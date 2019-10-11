--[[
魏蜀吴玩家庄家信息
]]

local panel_ui = require "game.weishuwu_std.script.ui_create.ui_weishuwu_applyList"

CWeishuwuApplyList = class("CWeishuwuApplyList", function ()
	local ret = cc.Node:create()
	return ret
end)


function CWeishuwuApplyList.create()
	local node = CWeishuwuApplyList.new()
	if node ~= nil then
		node:init_ui()
		node:registerHandler()
		return node
	end
end

function CWeishuwuApplyList:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.labNameList = {self.panel_ui.ZName1,self.panel_ui.ZName2,self.panel_ui.ZName3,self.panel_ui.ZName4}
	self.labChipsNumList = {self.panel_ui.ZCM1,self.panel_ui.ZCM2,self.panel_ui.ZCM3,self.panel_ui.ZCM4}
	for i=1,4 do 
		self.labNameList[i]:setString("")
		self.labChipsNumList[i]:setString("")
	end
	self.playerScore = 0
	self.panel_ui.Btn_SZ:onTouch(function (e)
		if e.name == "ended" then
			self:showHidePanel()
		end
	end)
	self.ismoveOut = true
	self.bIsShowCardPanel = false
end
function CWeishuwuApplyList:showHidePanel()
	if self.ismoveOut then
		self:moveOut()
	else
		self:moveIn()
	end
	self.ismoveOut = not self.ismoveOut
end

function CWeishuwuApplyList:moveIn()
	local move_action = cc.MoveBy:create(0.3, cc.p(-360,0))
	self:runAction(move_action)
end

function CWeishuwuApplyList:moveOut()
	local move_action = cc.MoveBy:create(0.3, cc.p(360,0))
	self:runAction(move_action)
end
function CWeishuwuApplyList:registerHandler()
	--上庄
	self.panel_ui.Btn_SZhuang:onTouch(function(e)
		if e.name == "ended" then
			if table.nums(weishuwu_manager._applyListData)>= 4 then
				TipsManager:showOneButtonTipsPanel(71, {}, true)
			else
				send_weishuwu_ReqApplyBanker()
			end
		end
	end)
	--取消
	self.panel_ui.Btn_cancel:onTouch(function(e)
		if e.name == "ended" then
			send_weishuwu_ReqCancelApplyBanker()
		end
	end)
	--下庄
	self.panel_ui.Btn_XZhuang:onTouch(function(e)
		if e.name == "ended" then
			send_weishuwu_ReqOffBanker()
		end
	end)
end

--刷新上庄列表信息
function CWeishuwuApplyList:updateApplyListInfo()
	for i=1,4 do
		self.labNameList[i]:setString("")
		self.labChipsNumList[i]:setString("")
	end
	if self:isOnApplyList() == true then
		self.panel_ui.Btn_SZhuang:setVisible(false)
	elseif self:isBanker() == true then
		self.panel_ui.Btn_SZhuang:setVisible(false)
		self.panel_ui.Btn_cancel:setVisible(false)
		self.panel_ui.Btn_XZhuang:setEnabled(weishuwu_manager._state == 1)
		self.panel_ui.Btn_XZhuang:setBright(weishuwu_manager._state == 1)
	else
		--排队人数超过4个
		if table.nums(weishuwu_manager._applyListData) >= 4 then
			self.panel_ui.Btn_SZhuang:setEnabled(false)
			self.panel_ui.Btn_cancel:setEnabled(false)
			self.panel_ui.Btn_XZhuang:setEnabled(false)
		else
			self.panel_ui.Btn_SZhuang:setEnabled(true)
			self.panel_ui.Btn_SZhuang:setVisible(true)
			self.panel_ui.Btn_cancel:setEnabled(true)
			self.panel_ui.Btn_cancel:setVisible(true)
		end
		
	end
	if weishuwu_manager._applyListData ~= nil and table.nums(weishuwu_manager._applyListData) > 0 then 
		for i,v in ipairs(weishuwu_manager._applyListData) do
			local member = HallManager._members[v]
			dump(member)
			if member ~= nil then
				local name = textUtils.replaceStr(member.playerName, NAME_BITE_LIMIT, "..")
				self.labNameList[i]:setString(name)
				self.labChipsNumList[i]:setString(member.chips)
			end
		end
	end
end

--判断当前玩家是否在申请列表中
function CWeishuwuApplyList:isOnApplyList()
	local bOnApplyList = false
	local playerInfo = get_player_info()
	if weishuwu_manager._applyListData ~= nil and table.nums(weishuwu_manager._applyListData) > 0 then 
		for i,v in ipairs(weishuwu_manager._applyListData) do
			if player_is_myself(v) == true then
				bOnApplyList = true
				break
			end
		end
	end
	return bOnApplyList
end
--判断当前玩家是否为庄家
function CWeishuwuApplyList:isBanker()
	local bIsBanker = false
	if weishuwu_manager._bankerInfo.playerId ~= nil then 
		if player_is_myself(weishuwu_manager._bankerInfo.playerId) == true then
			bIsBanker = true
		end
	end
	return bIsBanker
end