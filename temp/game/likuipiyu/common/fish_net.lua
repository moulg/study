

--[[
	鱼网
]]

local fish_net_zorder = 1200000

FishNet = class("FishNet",function ()
	local  obj = cc.Sprite:create()
	return obj
end)

--[[
	info = {obj_id,id,}
]]
function FishNet.create(info)
	local obj = FishNet.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function FishNet:init(info)
	self.fshn_cfg 		= fish_net_config[info.id]
	self.object_id 		= info.obj_id
	self.is_alive		= false
	self.end_call 		= nil

	local frame_name = string.format(sprite_ani_config[self.fshn_cfg.src_id].pattern,1)
	self:setSpriteFrame(frame_name)
	self:setPosition(0,0)
	self:setVisible(false)

	local ani_key  = sprite_ani_config[self.fshn_cfg.src_id].key
	local exit_ani = cc.AnimationCache:getInstance():getAnimation(ani_key)

	if exit_ani == nil then
		local animation = self:createAnimation(sprite_ani_config[self.fshn_cfg.src_id],true)
		cc.AnimationCache:getInstance():addAnimation(animation,ani_key)
	end
	self:setLocalZOrder(fish_net_zorder)
	fish_net_zorder = fish_net_zorder + 1
end

function FishNet:createAnimation(cfg_item,bregorg)
	local animation = nil
	if cfg_item then
		local frames = display.newFrames(cfg_item.pattern,1,cfg_item.fs)
		animation = cc.Animation:createWithSpriteFrames(frames,cfg_item.ft)
		if bregorg == true then
			animation:setRestoreOriginalFrame(bregorg)
		end
	end

	return animation
end

function FishNet:getDataId()
	return self.fshn_cfg.id
end

function FishNet:getObjectId()
	return self.object_id
end

function FishNet:setUseState(buse)
	self.is_alive = buse
end

function FishNet:getUseState()
	return self.is_alive
end

--call(obj)
function FishNet:setPlayEndCall(call)
	self.end_call = call
end

function FishNet:play(pos)
	self:setPosition(pos.x,pos.y)
	self:setVisible(true)

	local ani_key   = sprite_ani_config[self.fshn_cfg.src_id].key
	local animation = cc.AnimationCache:getInstance():getAnimation(ani_key)

	local animate = nil
	if animation then
		animation:retain()
		animate = cc.Animate:create(animation)
		animation:release()
	end

	local __end_call_func = function () 
		if self.end_call then
			self.end_call(self)
		end
	end
	local end_call = cc.CallFunc:create(__end_call_func)

	local seq_lst = {}
	
	if animate then table.insert(seq_lst,animate) end
	if end_call then table.insert(seq_lst,end_call) end

	local seq_obj = cc.Sequence:create(seq_lst)

	if seq_obj then
		self:runAction(seq_obj)
	end
end

