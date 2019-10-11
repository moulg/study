--[[
百家乐个人信息
]]

local panel_ui = require "game.baccarat_std.script.ui_create.ui_baccarat_player"

CBaccaratPlayer = class("CBaccaratPlayer", function ()
	local ret = cc.Node:create()
	return ret
end)


function CBaccaratPlayer.create()
	local node = CBaccaratPlayer.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end

function CBaccaratPlayer:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	-- self.panel_ui.root:setPosition(0,0)
	-- self.panel_ui.root:setAnchorPoint(0,0)
	self.ismoveOut = false
	self.panel_ui.imgPlayer:setTouchEnabled(true)
end
function CBaccaratPlayer:showHidePanel()
	if self.ismoveOut then
		self:moveOut()
	else
		self:moveIn()
	end
	self.ismoveOut = not self.ismoveOut
end

function CBaccaratPlayer:moveIn()
	local size = self.panel_ui.imgPlayer:getContentSize()

	local move_action = cc.MoveBy:create(0.3, cc.p(size.width-64, 0))
	self:runAction(move_action)
end

function CBaccaratPlayer:moveOut()
	local size = self.panel_ui.imgPlayer:getContentSize()

	local move_action = cc.MoveBy:create(0.3, cc.p(-size.width+64, 0))
	self:runAction(move_action)
end

--刷新玩家信息
function CBaccaratPlayer:updatePlayerInfo()
	local playerInfo = get_player_info()
	self.panel_ui.textName:setString(textUtils.replaceStr(playerInfo.name, NAME_BITE_LIMIT, ".."))
	uiUtils:setPhonePlayerHead(self.panel_ui.sprPlayerHead, ((playerInfo.sex == "女") and 1 or 0), uiUtils.HEAD_SIZE_115)
	self.panel_ui.fntGold:setString(playerInfo.gold)
	self.panel_ui.fntChips:setString(baccarat_manager._ownChips)
end