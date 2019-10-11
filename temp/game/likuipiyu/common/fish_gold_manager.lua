

--[[
	金币管理
]]

local def_config_id = 1

FishGoldManager = class("FishGoldManager",function ()
	local obj  = {}
	return obj
end)

local __fish_gold_manager_obj = nil


function FishGoldManager.getInstance()
	if __fish_gold_manager_obj == nil then
		__fish_gold_manager_obj = FishGoldManager.new()
	end
	return __fish_gold_manager_obj
end

function FishGoldManager.destroyInstance()
	__fish_gold_manager_obj = nil
end

function FishGoldManager:init()
	self.alive_fish_gold_manager = {}
end

function FishGoldManager:getUnitGoldNumber(score)
	if score ~= nil then
		for i=1,#fish_gold_config do
			if score > fish_gold_config[i].gold_num then
				return fish_gold_config[i].gold_num
			end
		end
	end

	return fish_gold_config[def_config_id].gold_num
end

--info = {spos,end_pos,number,angle,}
function FishGoldManager:play(info)
	local content_size = nil

	local id = def_config_id
	for i=1,#fish_gold_config do
		if info.number > fish_gold_config[i].gold_num then
			id = i
			break
		end
	end

	local max_num = math.ceil(info.number/fish_gold_config[id].gold_num)
	if max_num > lk_system_config.max_gold_arrange_way then
		max_num = lk_system_config.max_gold_arrange_way
	end

	local function __on_fishgold_endcall_ee(obj) 
		self:onEndCall(obj) 
	end

	local distance = 0
	for i=1,max_num do
		local obj = ObjectPool.getInstance():getObject(ObjectClassType.type_fish_gold,id)
		if obj then
			if content_size == nil then content_size = obj:getContentSize() end
			obj:setUseState(true)
			obj:setPlayEndCall(__on_fishgold_endcall_ee)
			local index = i - 1
			if i >= max_num/2 and max_num > 1 then
				index = max_num - i + 1
			end
			distance = ( index )*( math.sqrt( math.pow(content_size.width,2) + math.pow(content_size.height,2) ) + lk_system_config.gold_distance )
			local new_spos = self:getObjPos(max_num,i,info.angle,lk_system_config.gold_arrang_way,distance)
			new_spos.x = new_spos.x + info.spos.x
			new_spos.y = new_spos.y + info.spos.y
			obj:play(new_spos,info.end_pos)
		end
	end

	MusicEffectPlayer.getInstance():play(lk_system_config.gold_mus_id)
end

function FishGoldManager:getObjPos(max_num,cur_num,angle,arrange_way,dis)
	local pos = {x = 0,y = 0,}
	if arrange_way == 1 then --排列成一行
		if cur_num < max_num/2 then
			pos.x = dis*math.cos(math.pi - (angle/180)*math.pi)
			pos.y = dis*math.sin(math.pi - (angle/180)*math.pi)
		else
			pos.x = -dis*math.cos(math.pi - (angle/180)*math.pi)
			pos.y = -dis*math.sin(math.pi - (angle/180)*math.pi)
		end
	elseif arrange_way == 2 then--排列一个矩形
		local line_max = lk_system_config.max_gold_arrange_way2_line

	end

	return pos
end

function FishGoldManager:onEndCall(obj)
	if obj then
		local end_pos = obj:getEndPos()
		local t = obj:getEndMoveTime()
		if t <= 0 or t > 10 then t = 2 end
		local move_to = cc.MoveTo:create(t,end_pos)

		local function __fish_gold_move_end_call()
			--print("return fish gold object into object pool,object_id = " .. obj:getObjectId())
			obj:resumeOrgin()
			obj:setUseState(false)
		end

		local end_call_obj = cc.CallFunc:create(__fish_gold_move_end_call)

		local seq_lst = {}
		table.insert(seq_lst,move_to)
		table.insert(seq_lst,end_call_obj)

		obj:runAction(cc.Sequence:create(seq_lst))
	end
end
