

--[[
	鱼网管理
]]

FishNetManager = class("FishNetManager",function ()
	local obj ={}
	return obj
end)


local __fish_net_manager_obj = nil

function FishNetManager.getInstance()
	if __fish_net_manager_obj == nil then
		__fish_net_manager_obj = FishNetManager.new()
	end

	return __fish_net_manager_obj
end

function FishNetManager.destroyInstance()
	__fish_net_manager_obj = nil
end

function FishNetManager:init()
	self.alive_fish_net_obj = {}
end

--[[
	info = {pos,id}
]]
function FishNetManager:play(info)
	local fish_net_obj = ObjectPool.getInstance():getObject(ObjectClassType.type_fish_net,info.id)

	if fish_net_obj then
		fish_net_obj:setUseState(true)
		local function __fish_net_play_call(obj) self:onPlayEndCall(obj) end
		fish_net_obj:setPlayEndCall(__fish_net_play_call)
		fish_net_obj:play(info.pos)
	end
end

function FishNetManager:onPlayEndCall(obj)
	if obj then
		--print("return fish net object into object pool,object_id = " .. obj:getObjectId())
		obj:setUseState(false)
		obj:setVisible(false)	
	end
end

