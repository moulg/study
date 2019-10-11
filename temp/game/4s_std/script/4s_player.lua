--[[

玩家界面
]]

local panel_ui = require "game.4s_std.script.ui_create.ui_4s_player"

CFSPlayer = class("CFSPlayer", function ()
	local ret = cc.Node:create()
	return ret
end)

function CFSPlayer.create()
	-- body
	local node = CFSPlayer.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end
function CFSPlayer:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.root:setPosition(0,0)

	self:updatePlayerInfo()
end
function CFSPlayer:updatePlayerInfo()
	local playerInfo = get_player_info()
	self.panel_ui.labJinBi:setString(playerInfo.gold)
	self.panel_ui.labNiCheng:setString(playerInfo.name)
	self.panel_ui.labChips:setString(fs_manager._ownChips)
	self.panel_ui.labChengJi:setString(fs_manager._playerScore)
	uiUtils:setPlayerHead(self.panel_ui.imgPlayerHead, playerInfo.head_id, uiUtils.HEAD_SIZE_50)
end