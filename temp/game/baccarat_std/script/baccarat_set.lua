--[[
百家乐设置面板
]]

local panel_ui = require "game.baccarat_std.script.ui_create.ui_baccarat_set"

CBaccaratSet = class("CBaccaratSet", function ()
	local ret = cc.Node:create()
	return ret
end)


function CBaccaratSet.create()
	local node = CBaccaratSet.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end

function CBaccaratSet:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	-- self.panel_ui.root:setPosition(0,0)
	-- self.panel_ui.root:setAnchorPoint(0,0)
	self.ismoveOut = false
	self.panel_ui.ImgBj:setTouchEnabled(true)
end
function CBaccaratSet:showHidePanel()
	if self.ismoveOut then
		self:moveOut()
	else
		self:moveIn()
	end
	self.ismoveOut = not self.ismoveOut
end

function CBaccaratSet:moveIn()
	local size = self.panel_ui.ImgBj:getContentSize()

	local move_action = cc.MoveBy:create(0.3, cc.p(-size.width, 0))
	self:runAction(move_action)
end

function CBaccaratSet:moveOut()
	local size = self.panel_ui.ImgBj:getContentSize()

	local move_action = cc.MoveBy:create(0.3, cc.p(size.width, 0))
	self:runAction(move_action)
end
