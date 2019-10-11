--[[

筹码区界面
]]

local panel_ui = require "game.4s_std.script.ui_create.ui_4s_request"

CFSChipsPanel = class("CFSChipsPanel", function ()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
	-- local ret = cc.Node:create()
	return ret
end)

function CFSChipsPanel.create()
	-- body
	local node = CFSChipsPanel.new()
	if node ~= nil then
	   node:init_ui()
       node:registerHandler()
		return node
	end
end

function CFSChipsPanel:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.root:setPosition(0,0)

	--筹码按钮
	self.btnChipsList = {self.panel_ui.btnChipsRed, self.panel_ui.btnChipsPurple, 
		self.panel_ui.btnChipsCoffe, self.panel_ui.btnChipsBlack,self.panel_ui.btnChipsBlue,
		self.panel_ui.btnChipsGreen,self.panel_ui.btnChipsPink, self.panel_ui.btnChipsGray,
	}
	self:setButtonsEnable(false)
	--选择下注区域按钮
	self.btnSelectsList = {self.panel_ui.btnSelected1,self.panel_ui.btnSelected2,self.panel_ui.btnSelected3,
		self.panel_ui.btnSelected4,self.panel_ui.btnSelected5,self.panel_ui.btnSelected6,
		self.panel_ui.btnSelected7,self.panel_ui.btnSelected8,
	}
	for i,v in pairs(self.btnSelectsList) do
		v:setTag(i)
	end

	--下注成功高亮框
	self.imgClickList = {self.panel_ui.imgClick1,self.panel_ui.imgClick2,self.panel_ui.imgClick3,self.panel_ui.imgClick4,
		self.panel_ui.imgClick5,self.panel_ui.imgClick6,self.panel_ui.imgClick7,self.panel_ui.imgClick8,
	}
	for k,v in pairs(self.imgClickList) do
		v:setVisible(false)
	end

	--当前玩家在每个区域下注的筹码数
    self.fntPlayerChipsList = {self.panel_ui.fntPlayer1,self.panel_ui.fntPlayer2,self.panel_ui.fntPlayer3,self.panel_ui.fntPlayer4,
		self.panel_ui.fntPlayer5,self.panel_ui.fntPlayer6,self.panel_ui.fntPlayer7,self.panel_ui.fntPlayer8,
	}
	for k,v in pairs(self.fntPlayerChipsList) do
		v:setString("0")
	end

	--每个区域下注的总筹码数
    self.fntTotalChipsList = {self.panel_ui.fntTotal1,self.panel_ui.fntTotal2,self.panel_ui.fntTotal3,self.panel_ui.fntTotal4,
		self.panel_ui.fntTotal5,self.panel_ui.fntTotal6,self.panel_ui.fntTotal7,self.panel_ui.fntTotal8,
	}
	for k,v in pairs(self.fntTotalChipsList) do
		v:setString("0")
	end

	--倍数
	self.fntMultipleList = {self.panel_ui.fntBeiShuFL,self.panel_ui.fntBeiShuBC,self.panel_ui.fntBeiShuBM,self.panel_ui.fntBeiShuAD,
		self.panel_ui.fntBeiShuFT,self.panel_ui.fntBeiShuDZ,self.panel_ui.fntBeiShuBK,self.panel_ui.fntBeiShuMZ,
	}
	for k,v in pairs(self.fntMultipleList) do
		v:setString("")
	end

	--历史记录
	self.imgRecordList = {self.panel_ui.imgIconBg1,self.panel_ui.imgIconBg2,
		self.panel_ui.imgIconBg3,self.panel_ui.imgIconBg4,
	}
	for k,v in pairs(self.imgRecordList) do
		v:setVisible(false)
	end

end

--
function CFSChipsPanel:playBetResultAnimation(carId)
	local function call_back()
		self.imgClickList[carId]:stopAllActions()
		self.imgClickList[carId]:setVisible(false)
	end

	self.imgClickList[carId]:runAction(cc.Sequence:create(cc.Blink:create(1, 4),cc.CallFunc:create(call_back)))
end

--设置下注区按钮是否可点
function CFSChipsPanel:setSelectBtnEnable(value)
	for i,v in pairs(self.btnSelectsList) do
		v:setEnabled(value)
	end
end

--禁用/启用筹码按钮
function CFSChipsPanel:setButtonsEnable(value)
	for i,v in pairs(self.btnChipsList) do
		-- v:setSelected(false)
		v:setEnabled(value)
		v:setBright(value)
	end
end
--坐庄成功取消下注等操作
function CFSChipsPanel:setBankerState()
	self:setButtonsEnable(false)
	self.panel_ui.btnClean:setEnabled(false)
	self.panel_ui.btnClean:setBright(false)
	self.panel_ui.btnExchange:setEnabled(false)
	self.panel_ui.btnExchange:setBright(false)
	self.panel_ui.btnContinued:setEnabled(false)
	self.panel_ui.btnContinued:setBright(false)

end

--更新个人信息
function CFSChipsPanel:updatePlayerInfo()
	local playerInfo = get_player_info()
	self.panel_ui.labJinBi:setString(playerInfo.gold)
	self.panel_ui.labNiCheng:setString(playerInfo.name)
	self.panel_ui.labChips:setString(fs_manager._ownChips)
	self.panel_ui.labChengJi:setString(fs_manager._playerScore)
	-- 头像
	local sex = get_player_info().sex == "男" and 0 or 1
	uiUtils:setPhonePlayerHead(self.panel_ui.imgPlayerHead, sex, uiUtils.HEAD_SIZE_223)
end

--设置倍数
function CFSChipsPanel:setMultiple()
	if fs_manager._listMultiple then
		for i,v in pairs(fs_manager._listMultiple) do
			self.fntMultipleList[v.cardId]:setString("X" ..v.rate)
			local aimBlink = cc.Blink:create(1,2)
			local function audioCallBack()
				audio_manager:playOtherSound(10, false)
			end
			local call_action = cc.CallFunc:create(audioCallBack)
			local seq_arr = {}
			table.insert(seq_arr,call_action)
			table.insert(seq_arr,aimBlink)
			local seq = cc.Sequence:create(seq_arr)
			self.fntMultipleList[v.cardId]:runAction(cc.RepeatForever:create (seq))
		end

		local function callBack()
			for i,v in pairs(fs_manager._listMultiple) do
				self.fntMultipleList[v.cardId]:stopAllActions()
				self.fntMultipleList[v.cardId]:setVisible(true)
			end
		end

		performWithDelay(self, callBack, 2)
	end
end

--显示当前玩家在每个区域下注的总数
function CFSChipsPanel:updatePlayerBetChips()
	for i,v in pairs(fs_manager._chipsNumberList) do
		self.fntPlayerChipsList[i]:setString(v)
	end
end

--显示每个区域所有玩家下注的总数
function CFSChipsPanel:updateTotalBetChips()
	for i,v in pairs(fs_manager._chipsTotalNumberList) do
		self.fntTotalChipsList[i]:setString(v)
	end
end


--判断当前筹码是否可以续押
function CFSChipsPanel:calculateContinue()
	if long_compare(fs_manager._bankerInfo.playerId, get_player_info().id) ~= 0 then
		if fs_manager._continueChips ~= nil then
			local totalContinueChips = 0
			for i,v in ipairs(fs_manager._continueChips) do
				totalContinueChips = long_plus(totalContinueChips, v)
			end
			if long_compare(fs_manager._ownChips, totalContinueChips) >= 0 then 
				self.panel_ui.btnContinued:setEnabled(true)
				self.panel_ui.btnContinued:setBright(true)
			else
				self.panel_ui.btnContinued:setEnabled(false)
				self.panel_ui.btnContinued:setBright(false)
			end	
		else
			self.panel_ui.btnContinued:setEnabled(false)
			self.panel_ui.btnContinued:setBright(false)
		end
	else
		self.panel_ui.btnContinued:setEnabled(false)
		self.panel_ui.btnContinued:setBright(false)
	end
end
--判断清空按钮是否可用
function CFSChipsPanel:calculateClean()
	if fs_manager._chipsNumberList ~= nil then
		local totalBetChipsNum = 0
		for i,v in ipairs(fs_manager._chipsNumberList) do
			totalBetChipsNum = long_plus(totalBetChipsNum, v)
		end
		if long_compare(totalBetChipsNum, 0) > 0 then
			self.panel_ui.btnClean:setEnabled(true)
			self.panel_ui.btnClean:setBright(true)
		else
			self.panel_ui.btnClean:setEnabled(false)
			self.panel_ui.btnClean:setBright(false)
		end 
	else
		self.panel_ui.btnClean:setEnabled(false)
		self.panel_ui.btnClean:setBright(false)
	end
	
end
--启用、禁用上下分按钮
function CFSChipsPanel:setAddAndSubtractBtn(isAble)
	self.panel_ui.btnExchange:setEnabled(isAble)
	self.panel_ui.btnExchange:setBright(isAble)
end
function CFSChipsPanel:registerHandler()
	--续押
	self.panel_ui.btnContinued:onTouch(function(e)
		if e.name == "ended" then
			local playerInfo = get_player_info()
			local msg = {roomId=playerInfo.myDesksInfo[1].roomId,tableId=fs_manager._deskId}
			send_foursshop_ReqContinueBet(msg)
		end
	end)
	--兑换
	self.panel_ui.btnExchange:onTouch(function(e)
		if e.name == "ended" then
			TipsManager:showExchangePanel(fs_manager._ownChips, get_player_info().gold)
		end
	end)
	--清空
	self.panel_ui.btnClean:onTouch(function(e)
		if e.name == "ended" then
			local playerInfo = get_player_info()
			local msg = {roomId=playerInfo.myDesksInfo[1].roomId,tableId=fs_manager._deskId}
			send_foursshop_ReqClearBet(msg)
		end
	end)
	--退出
	self.panel_ui.btnStead:onTouch(function(e)
		if e.name == "ended" then
			local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
			game_FoursShop.bIsShowBetPanel = false
			self:setVisible(false)
			self.panel_ui.imgBg:setTouchEnabled(false)
		end
	end)

	--下注
	for i,v in pairs(self.btnSelectsList) do
		v:onTouch(function( e )
			if e.name == "ended"then
				if fs_manager._bCanBet == true then
					if fs_manager._betChipsType ~= nil then
						local tag = e.target:getTag()
						fs_manager._betCarId = tag
						local requireChips = 10^fs_manager._betChipsType
						--每个下注区最多允许下注1000万筹码
						if long_compare(fs_manager._chipsNumberList[tag],10000000) >= 0 then
							TipsManager:showOneButtonTipsPanel(2009, {}, true)
						else
							--判断当前筹码是否够下注
							if long_compare(fs_manager._ownChips, requireChips) >= 0 then 
								local playerInfo = get_player_info()
								local msg = {roomId=playerInfo.myDesksInfo[1].roomId,
											tableId=fs_manager._deskId,
											bets={carId=tag,bet=requireChips}}
								--向服务器发送下注消息
								send_foursshop_ReqBet(msg)
								--在服务端未返回消息之前，不让再发送下注消息
								fs_manager._bCanBet = false
							else
								TipsManager:showOneButtonTipsPanel(76, {}, true)
							end
						end
					end
				end
			end
		end)
	end
end
