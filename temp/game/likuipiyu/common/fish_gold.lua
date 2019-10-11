
--[[
	金币柱
]]

local fish_gold_zorder = 2000000

FishGold = class("FishGold",function ()
	local obj = cc.Sprite:create()
	return obj
end)

--[[
	info = {obj_id,id}
]]
function FishGold.create(info)
	local obj = FishGold.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function FishGold:init(info)
	self.object_id 		= info.obj_id
	self.data_config 	= fish_gold_config[info.id]
	self.is_alive		= false
	self.end_call 		= nil
	self.end_pos 		= {x = 0,y = 0,}
	self.start_pos		= {x = 0,y = 0,}

	local frame_name = string.format(sprite_ani_config[self.data_config.src_id].pattern,1)
	self:setSpriteFrame(frame_name)
	self:setPosition(0,0)
	self:setVisible(false)

	local ani_key  = sprite_ani_config[self.data_config.src_id].key
	local exit_ani = cc.AnimationCache:getInstance():getAnimation(ani_key)

	if exit_ani == nil then
		local animation = self:createAnimation(sprite_ani_config[self.data_config.src_id],true)
		cc.AnimationCache:getInstance():addAnimation(animation,ani_key)
	end

	self:setLocalZOrder(fish_gold_zorder)
	fish_gold_zorder = fish_gold_zorder + 1
end

function FishGold:createAnimation(cfg_item,bregorg)
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

function FishGold:getDataId()
	return self.data_config.id
end

function FishGold:getObjectId()
	return self.object_id
end

function FishGold:setUseState(buse)
	self.is_alive = buse
end

function FishGold:getUseState()
	return self.is_alive
end

--call(obj)
function FishGold:setPlayEndCall(call)
	self.end_call = call
end

function FishGold:getEndPos()
	return self.end_pos
end

function FishGold:getArrangeWay()
	
end

function FishGold:play(spos,epos)
	self:setPosition(spos.x,spos.y)
	self:setVisible(true)
	self.end_pos 	= epos
	self.start_pos  = spos

	local ani_key   = sprite_ani_config[self.data_config.src_id].key
	local animation = cc.AnimationCache:getInstance():getAnimation(ani_key)

	local animate = nil
	if animation then
		animation:retain()
		animate = cc.Animate:create(animation)
		animation:release()
	end
	self:runAction(cc.RepeatForever:create(animate))

	local __fish_net_act_endcall = function ()
		if self.end_call then self.end_call(self) end
	end

	ActionEffectPlayer.getInstance():play(self,__fish_net_act_endcall,self.data_config.act_id)
end

function FishGold:resumeOrgin()
	self:stopAllActions()
	local frame_name = string.format(sprite_ani_config[self.data_config.src_id].pattern,1)
	self:setSpriteFrame(frame_name)
	self:setPosition(0,0)
	self:setVisible(false)
	self.end_pos  	= {x = 0,y = 0,}
	self.start_pos  = {x = 0,y = 0,}
	self.end_call = nil
end

function FishGold:getEndMoveTime()
	local dis = math.sqrt( math.pow(self.start_pos.x - self.end_pos.x,2) + math.pow(self.start_pos.y - self.end_pos.y,2) )
	local t = dis/lk_system_config.gold_move_v

	return t
end

