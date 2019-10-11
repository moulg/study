--[[
	水波纹
]]

local water_zorder =  1500000

FishWater = class("FishWater",function ()
	local obj = cc.Node:create()
	return obj
end)

function FishWater.create()
	local obj = FishWater.new()
	if obj then
		obj:init()
	end

	return obj
end

function FishWater:init()
	self:setLocalZOrder(water_zorder)
	for k,v in pairs(fish_water_config) do
		local fname = string.format(v.pattern,1)
		local spr = cc.Sprite:createWithSpriteFrameName(fname)

		self:addChild(spr)
		spr:setPosition(v.pos.x,v.pos.y)
		--spr:setBlendFunc(cc.blendFunc(gl.SRC_ALPHA, gl.ONE))

		local frames = display.newFrames(v.pattern,1,v.fs)
		local animation = cc.Animation:createWithSpriteFrames(frames,v.ft)
		local animate = cc.Animate:create(animation)
		local action  = cc.RepeatForever:create(animate)
		
		spr:runAction(action)
	end
end

function FishWater:createSpr(cfg_item)
	local spr = nil
	if cfg_item then
		local frame_name = string.format(cfg_item.pattern,1)
		spr = cc.Sprite:createWithSpriteFrameName(frame_name)
	end

	return spr
end

