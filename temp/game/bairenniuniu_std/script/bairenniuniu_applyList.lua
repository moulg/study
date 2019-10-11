--[[

申请列表界面
]]

local panel_ui = require "game.bairenniuniu_std.script.ui_create.ui_bairenniuniu_applyList1"

CBaiRenNiuNiuApplyList = class("CBaiRenNiuNiuApplyList", function ()
	local ret = cc.Node:create()
	return ret
end)

function CBaiRenNiuNiuApplyList.create()
	-- body
	local node = CBaiRenNiuNiuApplyList.new()
	if node ~= nil then
		node:init_ui()
		node:registerHandler()
		-- node:registerBtnMouseMoveEff()
		return node
	end
end
function CBaiRenNiuNiuApplyList:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.size = self.panel_ui.LabShangz_Bg:getContentSize()
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.root:setPosition(0,0)
	self.labNameList = {self.panel_ui.labName1,self.panel_ui.labName2,self.panel_ui.labName3,self.panel_ui.labName4}
	self.labChipsNumList = {self.panel_ui.labChips1,self.panel_ui.labChips2,self.panel_ui.labChips3,self.panel_ui.labChips4}
	for i=1,4 do 
		self.labNameList[i]:setString("")
		self.labChipsNumList[i]:setString("")
	end
	-- self.panel_ui.BtnShangz:onTouch(function (e)
	-- 	if e.name == "ended" then
	-- 		self:showHidePanel()
	-- 	end
	-- end)
	self.ismoveOut = false
end

function CBaiRenNiuNiuApplyList:showHidePanel()
	if self.ismoveOut then
		self:moveOut()
	else
		self:moveIn()
	end
	self.ismoveOut = not self.ismoveOut
end

function CBaiRenNiuNiuApplyList:moveIn()
	local move_action = cc.MoveBy:create(0.3, cc.p(0,-self.size.height))
	self:runAction(move_action)
end

function CBaiRenNiuNiuApplyList:moveOut()
	local move_action = cc.MoveBy:create(0.3, cc.p(0,self.size.height))
	self:runAction(move_action)
end


function CBaiRenNiuNiuApplyList:registerHandler()

	--申请坐庄
	self.panel_ui.btnApply:onTouch(function(e)
		if e.name == "ended" then
			-- if long_compare(bairenniuniu_manager._ownChips,bairenniuniu_manager._requireChipsNum)>=0 then
				--排队人数超过4个
				if table.nums(bairenniuniu_manager._applyListData)>= 4 then
					TipsManager:showOneButtonTipsPanel(71, {}, true)
				else
					-- local playerInfo = get_player_info()
					-- local msg = {roomId=playerInfo.myDesksInfo[1].roomId,tableId=bairenniuniu_manager._deskId}
					-- send_foursshop_ReqOnBanker(msg)
					send_bairenniuniu_ReqApplyBanker()
				end
			-- else
			-- 	TipsManager:showOneButtonTipsPanel(75, {}, true)
			-- end
		end
	end)
	--取消申请
	self.panel_ui.btnCancel:onTouch(function(e)
		if e.name == "ended" then
			-- local playerInfo = get_player_info()
			-- local msg = {roomId=playerInfo.myDesksInfo[1].roomId,tableId=bairenniuniu_manager._deskId}
			-- send_foursshop_ReqCancelOnBanker(msg)
			send_bairenniuniu_ReqCancelApplyBanker()
		end
	end)
	--下庄
	self.panel_ui.btnStop:onTouch(function(e)
		if e.name == "ended" then
			-- local playerInfo = get_player_info()
			-- local msg = {r oomId=playerInfo.myDesksInfo[1].roomId,tableId=bairenniuniu_manager._deskId}
			-- send_foursshop_ReqCancelBanker(msg)
			send_bairenniuniu_ReqOffBanker()
		end
	end)
end
function CBaiRenNiuNiuApplyList:updateApplyListInfo()
	for i=1,4 do
		self.labNameList[i]:setString("")
		self.labChipsNumList[i]:setString("")
	end
	if bairenniuniu_manager._applyListData ~= nil and table.nums(bairenniuniu_manager._applyListData) > 0 then 
		for i,v in ipairs(bairenniuniu_manager._applyListData) do
			local member = HallManager._members[v]
			local name = textUtils.replaceStr(member.playerName, NAME_BITE_LIMIT, "..")
			self.labNameList[i]:setString(name)
			self.labChipsNumList[i]:setString(member.chips)
		end
	end
	if self:isOnApplyList() == true then
		-- self.panel_ui.btnApply:setEnabled(false)
		self.panel_ui.btnApply:setVisible(false)
	elseif self:isBanker() == true then
		-- self.panel_ui.btnApply:setEnabled(false)
		self.panel_ui.btnApply:setVisible(false)
		-- self.panel_ui.btnCancel:setEnabled(false)
		self.panel_ui.btnCancel:setVisible(false)
		self.panel_ui.btnStop:setEnabled(bairenniuniu_manager._state == 1)
		self.panel_ui.btnStop:setBright(bairenniuniu_manager._state == 1)
	else
		--排队人数超过4个
		if table.nums(bairenniuniu_manager._applyListData) >= 4 then
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
end
--判断当前玩家是否在申请列表中
function CBaiRenNiuNiuApplyList:isOnApplyList()
	local bOnApplyList = false
	local playerInfo = get_player_info()
	if bairenniuniu_manager._applyListData ~= nil and table.nums(bairenniuniu_manager._applyListData) > 0 then 
		for i,v in ipairs(bairenniuniu_manager._applyListData) do
			if player_is_myself(v) == true then
				bOnApplyList = true
				break
			end
		end
	end
	return bOnApplyList
end
--判断当前玩家是否为庄家
function CBaiRenNiuNiuApplyList:isBanker()
	local bIsBanker = false
	if bairenniuniu_manager._bankerInfo.playerId ~= nil then 
		if player_is_myself(bairenniuniu_manager._bankerInfo.playerId) == true then
			bIsBanker = true
		end
	end
	return bIsBanker
end