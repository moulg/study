--[[

庄家界面
]]

local panel_ui = require "game.4s_std.script.ui_create.ui_4s_banker"
local bankerHeadRes = "game/4s_std/resource/image/4stongyongtouxiang.png"

CFSBanker = class("CFSBanker", function ()
	local ret = cc.Node:create()
	return ret
end)

function CFSBanker.create()
	-- body
	local node = CFSBanker.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end
function CFSBanker:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.root:setPosition(0,0)
end
function CFSBanker:updateBankerInfo()
	if table.nums(fs_manager._bankerInfo) > 0 then
		self.panel_ui.labNiCheng:setString(fs_manager._bankerInfo.name)
		self.panel_ui.labChips:setString(fs_manager._bankerInfo.gold)
		self.panel_ui.labJuShu:setString(fs_manager._bankerInfo.count)
		self.panel_ui.labChengJi:setString(fs_manager._bankerInfo.score)

		-- 头像
		if player_is_myself(fs_manager._bankerInfo.playerId) then
			local sex = get_player_info().sex == "男" and 0 or 1
			uiUtils:setPhonePlayerHead(self.panel_ui.imgPlayerHead, sex, uiUtils.HEAD_SIZE_223)
		else
			self.panel_ui.imgPlayerHead:setTexture(bankerHeadRes)
		end
	end
end