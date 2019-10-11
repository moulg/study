--[[

开奖记录界面
]]

local panel_ui = require "game.4s_std.script.ui_create.ui_4s_record"

CFSRecord = class("CFSRecord", function ()
	local ret = cc.Node:create()
	return ret
end)

function CFSRecord.create()
	-- body
	local node = CFSRecord.new()
	if node ~= nil then
		node:init_ui()
        node:registerHandler()
        node:registerBtnMouseMoveEff()
		return node
	end
end
function CFSRecord:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.root:setPosition(0,0)
	self.imgList = {self.panel_ui.imgIconBg1,self.panel_ui.imgIconBg2,
				self.panel_ui.imgIconBg3,self.panel_ui.imgIconBg4,}
	self.labPlayerList = {self.panel_ui.labPlayer1,self.panel_ui.labPlayer2,
						self.panel_ui.labPlayer3,self.panel_ui.labPlayer4}
	self.labBankerList = {self.panel_ui.labBanker1,self.panel_ui.labBanker2,
						self.panel_ui.labBanker3,self.panel_ui.labBanker4}
end

--注册按钮高亮
function CFSRecord:registerBtnMouseMoveEff()
	local mov_obj = cc.Sprite:create("game/4s_std/resource/button/4sshop_button_left1.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.btnLeft,mov_obj)
	local mov_obj = cc.Sprite:create("game/4s_std/resource/button/4sshop_button_right1.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.btnRight,mov_obj)
end
--取消高亮
function CFSRecord:unregisterBtnMouseMoveEff()
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.btnLeft)
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.btnRight)
end
function CFSRecord:registerHandler()
	--向左
	self.panel_ui.btnLeft:onTouch(function (e)
		if e.name == "ended" then
			fs_manager._curRecord = fs_manager._curRecord + 1
			self:updateRecordUi()
		end
	end)
	--向右
	self.panel_ui.btnRight:onTouch(function (e)
		if e.name == "ended" then
			fs_manager._curRecord = fs_manager._curRecord - 1
			self:updateRecordUi()
		end
	end)
end
function CFSRecord:updateRecordUi()
	local ListRecordData = {}
	for i=1,4 do
        if fs_manager._recordData[fs_manager._curRecord + i -1] ~= nil then
            ListRecordData[i] = fs_manager._recordData[fs_manager._curRecord + i -1]
        end
	end
	for i,v in ipairs(ListRecordData) do
		if v ~= nil then
			self.imgList[i]:setTexture("game/4s_std/resource/image/logo/logo_s/4sshop_game_" ..v.finalCarId ..".png")
			local bankerStr = (long_compare(v.bankerChipschanges,0) >= 0) and "+" or ""
			local playerStr = (long_compare(v.playerChipschanges,0) >= 0) and "+" or ""
			self.labPlayerList[i]:setString(playerStr ..v.playerChipschanges)
            self.labBankerList[i]:setString(bankerStr ..v.bankerChipschanges)
		end
	end
	self.panel_ui.btnLeft:setEnabled((fs_manager._recordData[fs_manager._curRecord + 4] ~= nil)and true or false)
	self.panel_ui.btnLeft:setBright((fs_manager._recordData[fs_manager._curRecord + 4] ~= nil)and true or false)
	self.panel_ui.btnRight:setEnabled((fs_manager._curRecord > 1) and true or false)
	self.panel_ui.btnRight:setBright((fs_manager._curRecord > 1) and true or false)
	
end
