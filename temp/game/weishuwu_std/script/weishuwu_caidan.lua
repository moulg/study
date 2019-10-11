--[[
魏蜀吴菜单
]]


local panel_ui = require "game.weishuwu_std.script.ui_create.ui_weishuwu_caidan"

CWeishuwuCaidan = class("CWeishuwuCaidan", function ()
	local ret = cc.Node:create()
	return ret
end)


function CWeishuwuCaidan.create()
	local node = CWeishuwuCaidan.new()
	if node ~= nil then
		node:init_ui()
		-- node:registerHandler()
		return node
	end
end
function CWeishuwuCaidan:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.size = self.panel_ui.ImgCBg:getContentSize()
	self.panel_ui.Btn_caidan:onTouch(function (e)
		if e.name == "ended" then
			self:showHidePanel()
		end
	end)
	self.ismoveOut = true
	self.bIsShowCardPanel = false
end
function CWeishuwuCaidan:showHidePanel()
	if self.ismoveOut then
		self.panel_ui.Btn_caidan:setFlippedX(true)
		self:moveOut()
	else
		self.panel_ui.Btn_caidan:setFlippedX(false)
		self:moveIn()
	end
	self.ismoveOut = not self.ismoveOut
end

function CWeishuwuCaidan:moveIn()
	local move_action = cc.MoveBy:create(0.3, cc.p(self.size.width/4*3,0))
	self:runAction(move_action)
end

function CWeishuwuCaidan:moveOut()
	local move_action = cc.MoveBy:create(0.3, cc.p(-self.size.width/4*3,0))
	self:runAction(move_action)
end

