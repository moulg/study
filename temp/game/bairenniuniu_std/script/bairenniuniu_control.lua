--[[

菜单
]]

local panel_ui = require "game.bairenniuniu_std.script.ui_create.ui_bairenniuniu_applyList2"

CBaiRenNiuNiuControl = class("CBaiRenNiuNiuControl", function ()
	local ret = cc.Node:create()
	return ret
end)

function CBaiRenNiuNiuControl.create()
	-- body
	local node = CBaiRenNiuNiuControl.new()
	if node ~= nil then
		node:init_ui()
		-- node:registerHandler()
		return node
	end
end
function CBaiRenNiuNiuControl:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.size = self.panel_ui.ImageBg:getContentSize()
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.root:setPosition(0,0)

	self.panel_ui.BtnExchange:onTouch(function (e)
		if e.name == "ended" then
			self:showHidePanel()
		end
	end)
	self.ismoveOut = true
	self.bIsShowCardPanel = false
end
function CBaiRenNiuNiuControl:showHidePanel()
	if self.ismoveOut then
		self:moveOut()
	else
		self:moveIn()
	end
	self.ismoveOut = not self.ismoveOut
end

function CBaiRenNiuNiuControl:moveIn()
	local move_action = cc.MoveBy:create(0.3, cc.p(self.size.width,0))
	self:runAction(move_action)
end

function CBaiRenNiuNiuControl:moveOut()
	local move_action = cc.MoveBy:create(0.3, cc.p(-self.size.width,0))
	self:runAction(move_action)
end


function CBaiRenNiuNiuControl:registerHandler()
	-- --倍率
	-- self.panel_ui.BtnBeil:onTouch(function (e)
	-- 	if e.name == "ended" then
	-- 		if self.bIsShowCardPanel == false then
	-- 			self.bIsShowCardPanel = true
	-- 			self.panel_ui.LabBeilv:setVisible(true)
	-- 			self.panel_ui.LabBeilv:setTouchEnabled(true)
	-- 		else
	-- 			self.bIsShowCardPanel = false
	-- 			self.panel_ui.LabBeilv:setVisible(false)
	-- 			self.panel_ui.LabBeilv:setTouchEnabled(false)
	-- 		end
	-- 	end
	-- end)
	-- --设置
	-- self.panel_ui.BtnSet:onTouch(function (e)
	-- 	if e.name == "ended" then
	-- 		local gameid = get_player_info().curGameID
	-- 		if gameid ~= nil then
	-- 			WindowScene.getInstance():showDlgByName("CHallSet")
	-- 		end
	-- 	end
	-- end)
	-- --退出
	-- self.panel_ui.BtnExit:onTouch(function (e)
	-- 	if e.name == "ended" then
	-- 		closeFunc()
	-- 	end
	-- end)
end
