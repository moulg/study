

--[[
	对象作用世界，碰撞
]]

ObjectEffectWorld = class("ObjectEffectWorld",function ()
	local obj = {}
	return obj
end)

local __object_effect_world_obj = nil

function ObjectEffectWorld.getInstance()
	if __object_effect_world_obj == nil then
		__object_effect_world_obj = ObjectEffectWorld.new()
	end

	return __object_effect_world_obj
end

function ObjectEffectWorld.destroyInstance()
	__object_effect_world_obj = nil
end

function ObjectEffectWorld:init()
	self.shot_call = nil
end

--[[ shot_call(shot_lst) ]]
function ObjectEffectWorld:registerCallback(shot_call)
	self.shot_call = shot_call
end

function ObjectEffectWorld:update(dt)
	local shot_bullet_lst = {}

	local bullet_lst = BulletManager.getInstance():getBulletAliveLst()
	
	if bullet_lst then
		for k,v in pairs(bullet_lst) do
			local bl_obj_id = v:getObjectId()
			local bbx = BulletManager.getInstance():getBulletBBX(bl_obj_id)


			local set_id  = v:getBulletSetId()
			local bat_obj = BatteryManager.getInstance():getBatteryBySetId(set_id)


			if bat_obj then
				local lock_fish_id  = bat_obj:getLockFishId()--检查当前锁定状态
				local lock_fish_obj = FishManager.getInstance():getFishObjById(lock_fish_id)

				if lock_fish_obj and v:getCurLockFishId() == lock_fish_id then--锁定
					--print("lock fish id = " .. lock_fish_id)
					local bshot = lock_fish_obj:isShotFish(bbx)
					if bshot == true then
						local shot_item = {bullet_obj = v,fish_obj = lock_fish_obj,}
						shot_bullet_lst[bl_obj_id] = shot_item
						--print("shot lock fish >>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
					end
				else --没有锁定
					local fish_obj = FishManager.getInstance():shotFish(bbx)
					if fish_obj then
						local shot_item = {bullet_obj = v,fish_obj = fish_obj,}
						shot_bullet_lst[bl_obj_id] = shot_item
					end
				end
			else

				local fish_obj = FishManager.getInstance():shotFish(bbx)
				if fish_obj then
					local shot_item = {bullet_obj = v,fish_obj = fish_obj,}
					shot_bullet_lst[bl_obj_id] = shot_item
				end
			end
		end
	end

	if self.shot_call then self.shot_call(shot_bullet_lst) end
end

