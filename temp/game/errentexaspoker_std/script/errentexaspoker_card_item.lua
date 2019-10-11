--[[
公共牌类
]]
CErRenTexasCardItem = class("CErRenTexasCardItem", function ()
	local ret = cc.Sprite:create()
	return ret
end)

function CErRenTexasCardItem.create(resPath)
	local sprite =  CErRenTexasCardItem.new()
	if sprite then
		sprite:init(resPath)
		return sprite
	end
end

function CErRenTexasCardItem:init(resPath)
	local imgFrame = display.newSpriteFrame(resPath)
	self:setSpriteFrame(imgFrame)
	self.imgSelect = display.newSprite(errentexaspoker_imageRes_config["大选择框"].resPath)
	self:addChild(self.imgSelect)
	self.imgSelect:setAnchorPoint(0.5,0.5)
	self.imgSelect:setPosition(self:getContentSize().width/2,self:getContentSize().height/2)
	self.imgSelect:setVisible(false)
end

function CErRenTexasCardItem:showSelectState()
	self.imgSelect:setVisible(true)
	self:stopAllActions()

	local jump1 = cc.JumpBy:create(1, cc.p(0, 0), 10, 4)
	local jump2 = jump1:reverse()
	local actions = cc.RepeatForever:create( cc.Sequence:create(jump1, jump2) )
	self:runAction(actions)
end

function CErRenTexasCardItem:hideSelectState()
	self.imgSelect:setVisible(false)
	self:stopAllActions()
end