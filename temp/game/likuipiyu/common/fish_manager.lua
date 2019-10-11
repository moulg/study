

--[[
	鱼对象管理
]]

FishManager = class("FishManager",function ()
	local obj = {}

	return obj
end)

local __fishmanager_obj = nil


local function __compare_level(a,b)
	if a:getLockLevel() > b:getLockLevel() then
		return true
	else
		return false
	end
end


function FishManager.getInstance()
	if __fishmanager_obj == nil then
		__fishmanager_obj = FishManager.new()
	end

	return __fishmanager_obj
end

function FishManager.destroyInstance()
	__fishmanager_obj = nil
end

function FishManager:init(parent)
	print("fish manager initialize!")
	self.alive_fishf_lst = {}
	self.alive_bbx_info_lst = {}

	self.parent = parent
	self.light_obj = PlaneShadowLightModel.create()
	self.light_obj:setLightInfo({model = 1,svec3 = lk_system_config.spot_light_pos,})

	self.buse_light_mod = true

	self.level_up_id = -1 --升级鱼id
	self.fish_level_info = {
		level = 0,
		fish_id = -1,
	}
end


--[[
	fish = {
		object_id,--对象id
		fish_id,--鱼配置id
		spos ={x,y,},--起始坐标
		breserve,路径是否反向
		angle,--是否旋转
		cve_id,--曲线id
		run_t,--已经运动时间t
		user_info = {
			--用户数据
		},
	}
]]
function FishManager:addFish(fish)

	if self.alive_fishf_lst[fish.object_id] ~= nil then
		print("this fish has exist>>>>> obj_id = " .. fish.object_id)
		return false
	end

	local info = {
		obj_id 	= fish.object_id,
		id 		= fish.fish_id,
	}
	local fish_obj = Fish.create(info)

	fish_obj:setFishCurveId(fish.cve_id)
	fish_obj:setRunTime(fish.run_t)
	fish_obj:setStartPos(fish.spos)
	fish_obj:setReserve(fish.breserve)
	fish_obj:setCurveRotation(fish.angle)
	fish_obj:setUserInfo(fish.user_info)
	fish_obj:setUseLightModel(self.buse_light_mod)
	fish_obj:setFishSceneId(BackgroundSceneManager.getInstance():getCurrentSceneId())

	self.parent:addChild(fish_obj)
	self.alive_fishf_lst[info.obj_id] = fish_obj
	self.alive_bbx_info_lst[info.obj_id] = fish_obj:getCurrentBBX()
	
	fish_obj:fishStart()

	if self.fish_level_info.fish_id == fish.fish_id and self.fish_level_info.fish_id ~= nil then
		fish_obj:setFishLevel(self.fish_level_info.level)
		SkillPlayer.getInstance():play(fish_obj,4)
	end

	-- local len = 0
	-- for k,v in pairs(self.alive_fishf_lst) do len = len + 1 end
	-- print("have fish alive = " .. len)

	return true
end

function FishManager:removeFish(object_id)
	local fish_obj = self.alive_fishf_lst[object_id]
	if fish_obj then
		fish_obj:fishDead()
		self.alive_fishf_lst[object_id] = nil
		self.alive_bbx_info_lst[object_id] = nil
	end
end

function FishManager:update(dt)
	for k,v in pairs(self.alive_fishf_lst) do
		if v and v.update then
			v:update(dt)
			self.alive_bbx_info_lst[k] = v:getCurrentBBX()
			if v:isOutofTime() == true then
				v:fishOut()
				self.alive_fishf_lst[k] = nil
				self.alive_bbx_info_lst[k] = nil
			end
		end
	end

	if BackgroundSceneManager.getInstance():getSceneState() == 1 then
		BatteryManager.getInstance():resetLockFishLst(self:getFishLevelLst())
	end
end


--[[

	bonding_box = {
		[1] = {a = 0,b = 0,r = 10,},
	}
]]
function FishManager:shotFish(bbx)
	-- for k,v in pairs(self.alive_fishf_lst) do
	-- 	local bshot = v:isShotFish(bbx)
	-- 	if bshot == true then		
	-- 		return v
	-- 	end
	-- end

	for k,v in pairs(self.alive_bbx_info_lst) do
		for m,n in pairs(bbx) do
			for i,j in pairs(v) do
				local dis = math.sqrt(math.pow(j.a - n.a,2) + math.pow(j.b - n.b,2))
				if n.r + j.r > dis then
					return self.alive_fishf_lst[k]
				end
			end
		end
	end

	return nil
end

function FishManager:getAliveFishObjectLst()
	return self.alive_fishf_lst
end

function FishManager:getAliveFish(obj_id)
	if obj_id then
		return self.alive_fishf_lst[obj_id]
	end

	return nil
end

function FishManager:getFishLevelLst()
	local lst = {}
	for k,v in pairs(self.alive_fishf_lst) do
		if v:getLockLevel() > 0 then
			table.insert(lst,v)
		end
	end

	table.sort(lst,__compare_level)

	return lst
end

function FishManager:getFishObjById(obj_id)
	return self.alive_fishf_lst[obj_id]
end

function FishManager:clearAllFish()
	for k,v in pairs(self.alive_fishf_lst) do
		if v:getFishSceneId() ~= BackgroundSceneManager.getInstance():getCurrentSceneId() and v:getFishSceneId() ~= -1 then
			local fsh_id = v:getObjectId()
			v:removeFromParent()
			self.alive_fishf_lst[fsh_id] = nil
			self.alive_bbx_info_lst[fsh_id] = nil
		end
	end
	--self.alive_fishf_lst = {}
	print("clear front scene fish>>>>>>>>>>>>>>>>")
end

function FishManager:getFishLightObj()
	return self.light_obj
end

function FishManager:getFishByConfigId(cfg_id)
	local lst = {}
	for k,v in pairs(self.alive_fishf_lst) do
		if v:getFishConfigId() == cfg_id then
			table.insert(lst,v)
		end 
	end

	return lst
end

function FishManager:setLevelupInfo(info)
	if info then self.fish_level_info = info end
end

function FishManager:getParent()
	return self.parent
end

function FishManager:getFishIdByPoint(pos)
	local fsh_id = -1

	for k,v in pairs(self.alive_fishf_lst) do
		if v:isPointInFish(pos) == true then
			fsh_id = v:getObjectId()
			break
		end
	end

	return fsh_id
end

function FishManager:getFishCounter()
	local conter = 0
	for k,v in pairs(self.alive_fishf_lst) do
		conter = conter + 1
	end

	return conter
end

function FishManager:useLight(buse)
	self.buse_light_mod = buse
	for k,v in pairs(self.alive_fishf_lst) do
		v:setUseLightModel(self.buse_light_mod)
	end
end
