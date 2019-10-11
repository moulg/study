--[[
公共牌类
]]
CTexasCardItem = class("CTexasCardItem", function ()
	local ret = cc.Sprite:create()
	return ret
end)

function CTexasCardItem.create(resPath)
	local sprite =  CTexasCardItem.new()
	if sprite then
		sprite:init(resPath)
		return sprite
	end
end

function CTexasCardItem:init(resPath)
	local imgFrame = display.newSpriteFrame(resPath)
	self:setSpriteFrame(imgFrame)
	self.imgSelect = display.newSprite(texas_imageRes_config["大选择框"].resPath)
	self:addChild(self.imgSelect)
	self.imgSelect:setAnchorPoint(0,0)
	self.imgSelect:setPosition(0,0)
	self.imgSelect:setVisible(false)
end

function CTexasCardItem:showSelectState()
	self.imgSelect:setVisible(true)
	self:stopAllActions()

	local jump1 = cc.JumpBy:create(1, cc.p(0, 0), 10, 4)
	local jump2 = jump1:reverse()
	local actions = cc.RepeatForever:create( cc.Sequence:create(jump1, jump2) )
	self:runAction(actions)
end

function CTexasCardItem:hideSelectState()
	self.imgSelect:setVisible(false)
	self:stopAllActions()
end