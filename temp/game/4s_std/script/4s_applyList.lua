--[[

申请列表界面
]]

local panel_ui = require "game.4s_std.script.ui_create.ui_4s_applyList"

CFSApplyList = class("CFSApplyList", function ()
	local ret = cc.Node:create()
	return ret
end)

function CFSApplyList.create()
	-- body
	local node = CFSApplyList.new()
	if node ~= nil then
		node:init_ui()
		node:registerHandler()
		return node
	end
end
function CFSApplyList:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.root:setPosition(0,0)
	-- self.labNameList = {self.panel_ui.labNiCheng1,self.panel_ui.labNiCheng2,self.panel_ui.labNiCheng3}
	-- self.labChipsNumList = {self.panel_ui.labChips1,self.panel_ui.labChips2,self.panel_ui.labChips3}
	-- self.imgHeadList = {self.panel_ui.imgHead1,self.panel_ui.imgHead2,self.panel_ui.imgHead3}
	-- self.imgChipsList = {self.panel_ui.imgChips1,self.panel_ui.imgChips2,self.panel_ui.imgChips3}
	-- for i=1,3 do
	-- 	self.imgHeadList[i]:setVisible(false)
	-- 	self.imgChipsList[i]:setVisible(false) 
	-- 	self.labNameList[i]:setString("")
	-- 	self.labChipsNumList[i]:setString("")
	-- end
end

function CFSApplyList:registerHandler()
	--申请坐庄
	self.panel_ui.btnApply:onTouch(function(e)
		if e.name == "ended" then
			-- if long_compare(fs_manager._ownChips,fs_manager._requireChipsNum)>=0 then
				--排队人数超过3个
				if table.nums(fs_manager._applyListData)>= 3 then
					TipsManager:showOneButtonTipsPanel(71, {}, true)
				else
					local playerInfo = get_player_info()
					local msg = {roomId=playerInfo.myDesksInfo[1].roomId,tableId=fs_manager._deskId}
					send_foursshop_ReqOnBanker(msg)
				end
			-- else
			-- 	TipsManager:showOneButtonTipsPanel(75, {}, true)
			-- end
		end
	end)
	--取消申请
	self.panel_ui.btnCancel:onTouch(function(e)
		if e.name == "ended" then
			local playerInfo = get_player_info()
			local msg = {roomId=playerInfo.myDesksInfo[1].roomId,tableId=fs_manager._deskId}
			send_foursshop_ReqCancelOnBanker(msg)
		end
	end)
	--申请停业
	self.panel_ui.btnStop:onTouch(function(e)
		if e.name == "ended" then
			local playerInfo = get_player_info()
			local msg = {roomId=playerInfo.myDesksInfo[1].roomId,tableId=fs_manager._deskId}
			send_foursshop_ReqCancelBanker(msg)
		end
	end)
end
function CFSApplyList:updateApplyListInfo()
	self.panel_ui.ruquestNumber:setString(table.nums(fs_manager._applyListData))
	if self:isOnApplyList() == true then
		self.panel_ui.btnApply:setEnabled(false)
		self.panel_ui.btnApply:setVisible(false)
	elseif self:isBanker() == true then
		self.panel_ui.btnApply:setEnabled(false)
		self.panel_ui.btnApply:setVisible(false)
		self.panel_ui.btnCancel:setEnabled(false)
		self.panel_ui.btnCancel:setVisible(false)
		self.panel_ui.btnStop:setEnabled(fs_manager._state==1 and true or false)
		self.panel_ui.btnStop:setBright(fs_manager._state==1 and true or false)
		local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
		if game_FoursShop then
			game_FoursShop.chipsPanel:setBankerState()
		end
	else
		--排队人数超过3个
		if table.nums(fs_manager._applyListData)>= 3 then
			self.panel_ui.btnApply:setEnabled(false)
			self.panel_ui.btnCancel:setEnabled(false)
			self.panel_ui.btnStop:setEnabled(false)
		else
			self.panel_ui.btnApply:setEnabled(true)
			self.panel_ui.btnApply:setVisible(true)
			self.panel_ui.btnCancel:setEnabled(true)
			self.panel_ui.btnCancel:setVisible(true)
		end
		
	end
	self.panel_ui.btnApply:setVisible(false)
	self.panel_ui.btnCancel:setVisible(false)
	self.panel_ui.btnStop:setVisible(false)
end
--判断当前玩家是否在申请列表中
function CFSApplyList:isOnApplyList()
	local bOnApplyList = false
	local playerInfo = get_player_info()
	if fs_manager._applyListData ~= nil and table.nums(fs_manager._applyListData) > 0 then 
		for i,v in ipairs(fs_manager._applyListData) do
			if player_is_myself(v.id) == true then
				bOnApplyList = true
				break
			end
		end
	end
	return bOnApplyList
end
--判断当前玩家是否为庄家
function CFSApplyList:isBanker()
	local bIsBanker = false
	local playerInfo = get_player_info()
	if fs_manager._bankerInfo.playerId ~= nil then 
		if player_is_myself(fs_manager._bankerInfo.playerId) == true then
			bIsBanker = true
		end
	end
	return bIsBanker
end