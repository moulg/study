--[[
四人牛牛管理类
]]

four_niuniu_manager = {}

--我自己的座位id
four_niuniu_manager._mySeatOrder = nil
--拥有筹码
four_niuniu_manager._ownChips = "0"

four_niuniu_manager._seatsMap = {}

--出牌信息
four_niuniu_manager.showDownMsgMap = {}

-- --是否自动准备
-- four_niuniu_manager.isAutoReady = false
-- --是否自动叫庄
-- four_niuniu_manager.isAutoCallBanker = false
-- --是否自动最大注
-- four_niuniu_manager.isAutoMaxBet = false
-- --是否自动出牌
-- four_niuniu_manager.isAutoShowDown = false

--初始化座位信息
function four_niuniu_manager.saveSeatInfos(members)

	four_niuniu_manager._seatsMap = {}
	for k,v in pairs(members) do
		four_niuniu_manager._seatsMap[v.order] = v

		if player_is_myself(v.playerId) then
			four_niuniu_manager._mySeatOrder = v.order
		end
	end
end


--准备状态重置
function four_niuniu_manager:resetReadyState()
	for i,v in pairs(self._seatsMap) do
		v.state = 1
	end
end

--[[
	获取实际显示的座位号
	1.当我进入位置数(a)小于或者等于1的时候:我实际位置=1.其余玩家实际位置(b)=玩家原来位置(c)+(1-a),
	当b大于的时候,其余玩家实际位置b=b-4。
	2.当我进入位置数(a)大于1的时候:我实际位置=1,其余玩家实际位置(b)=玩家原来位置(c)-(a-1)，
	当b小于1的时候,其余玩家实际位置b=4+b。
]]
function four_niuniu_manager:getRealOrder(order)
	local realOrder = 1
	if self._mySeatOrder <= 1 then
		realOrder = order + (1 - self._mySeatOrder)
		if realOrder > 4 then
			realOrder = realOrder - 4
		end
	elseif self._mySeatOrder > 1 then
		realOrder = order - (self._mySeatOrder - 1)
		if realOrder < 1 then
			realOrder = realOrder + 4 
		end
	end
	return realOrder
end



----------------------------------------------------------------房间座位消息
--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function four_niuniu_manager:resEnterGameHallMsg(msg)
	local _playerInfo = get_player_info()
	_playerInfo.myRoomTypeInfo = msg.roomTypes
	_playerInfo.curGameID = 13
	_playerInfo.curGameDeskClassName = "C4pNiuNiuDesk"

	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
end



--[[
	返回请求进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
function four_niuniu_manager.resEnterTableMsg(msg)
	local members = msg.mems
	local _playerInfo = get_player_info()
    _playerInfo.myTableId = members[1].tableId

	four_niuniu_manager._ownChips = "0"
	four_niuniu_manager.saveSeatInfos(members)
	WindowScene.getInstance():replaceModuleByModuleName("foursniuniu_std")
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CFourNiuNiuMainScene")
	if game_ui then
		game_ui:init_after_enter()
	end

	HallManager:enterTableHandler(msg)
end

--[[
	通知其他玩家我进入房间的消息消息
	msg = {
		名称:mems 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
function four_niuniu_manager:resOtherPlayerEnterTableMgs(msg)
	member = msg.mem
	HallManager:informPlayerEnterGame(member.playerName)

	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CFourNiuNiuMainScene")
	if game_ui then
        game_ui:createPlayer(member)
	end

	self._seatsMap[member.order] = member
end


--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
	}
]]
function four_niuniu_manager:resExitTableMsg(msg)
	-- dump(msg)
	if self._mySeatOrder == msg.order then
		print("player_is_myself>>>>>ExitCurGameRoom")
		HallManager:reqExitCurGameRoom()
		if WindowScene.getInstance():getCurModuleName()  == "game_lobby" then
			return
		end
		WindowScene.getInstance():replaceModuleByModuleName("game_lobby")
		local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
		if gamelobby then
			gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
		end

		self._seatsMap = {}
	    self._mySeatOrder = nil
	else 
		print("player_is_other>>>>>ExitCurGameRoom")
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CFourNiuNiuMainScene")
		if game_ui then	
			self._seatsMap[msg.order]  = nil
           	game_ui:removePlayer(msg.order)
			if game_ui.game_step == game_ui.GAME_STEP.CALL_STEP or game_ui.game_step == game_ui.GAME_STEP.BET_STEP then
				game_ui:resetGameData()
				game_ui:enterReadyStage()
			end
		end
		-- local name = self._seatsMap[msg.order].playerName
		-- 	HallManager:informPlayerExitGame(name)		
	end

end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
function four_niuniu_manager:resChipsChangeMsg(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CFourNiuNiuMainScene")
	if game_ui then
		game_ui:updateChips(msg.order, msg.chips)

		if msg.order == self._mySeatOrder then
			self._ownChips = msg.chips
		end
	end

	if self._seatsMap[msg.order] then
		self._seatsMap[msg.order].chips = msg.chips
	end
end

--[[
	玩家准备消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
function four_niuniu_manager:resReadyMsg(msg)
	if msg.res == 0 then
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CFourNiuNiuMainScene")
		if game_ui then
			game_ui:setPlayerReady(msg.order)
		end

		if self._seatsMap[msg.order] then
			self._seatsMap[msg.order].state = 2
		end
	end
end

--------------------------------------------------------------------------------游戏内消息

--[[
	所有玩家准备，准备结束消息
	msg = {
	}
]]
function four_niuniu_manager:resReadyOverMsg(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CFourNiuNiuMainScene")
	if game_ui then
		game_ui:enterRobBankerStage()
		
		HallManager:informPalyerGameStartMsg()
	end
end

--[[
	请求叫庄家结果消息
	msg = {
		名称:playerId 类型:long 备注:叫庄的玩家
		名称:order 类型:int 备注:位置
		名称:callType 类型:int 备注:0:不叫,非0:叫
	}
]]
function four_niuniu_manager:resCallDealerMsg(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CFourNiuNiuMainScene")
	if game_ui then
		game_ui:robBankerHandler(msg.order, msg.callType ~= 0)
	end
end

--[[
	所有玩家都叫庄，叫庄结束消息
	msg = {
		名称:dealerOrder 类型:int 备注:庄家位置
	}
]]
function four_niuniu_manager:resCallDealerOverMsg(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CFourNiuNiuMainScene")
	if game_ui then
		game_ui:setBankerPlayer(msg.dealerOrder)
	end
end

--[[
	请求下注结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:筹码不合法
		名称:order 类型:int 备注:座位顺序
		名称:chips 类型:long 备注:筹码
	}
]]
function four_niuniu_manager:resBetMsg(msg)
	if msg.res == 0 then
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CFourNiuNiuMainScene")
		if game_ui then
			game_ui:playerBetChips(msg.order, msg.chips)
		end
	end
end

--[[
	摊牌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:cardsType 类型:int 备注:牌型(0:没牛，1-10:牛1到牛牛,四花:11,四炸:12,五花:13,五小:14)
		名称:bestCards 类型:List<int> 备注:最优牌组合(如果有牛展示为3+2)
	}
]]
function four_niuniu_manager:resShowdownMsg(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CFourNiuNiuMainScene")
	if game_ui then
		if game_ui._gameStep == game_ui.GAME_STEP.SEND_CARD_STEP then
			self.showDownMsgMap[msg.order] = msg
		else
			game_ui:playerShowDown(msg.order, msg.cardsType, msg.bestCards)
		end
	end
end


--[[
	发牌消息
	msg = {
		名称:cards 类型:List<int> 备注:玩家的牌，已经是最优牌型(3+2)
		名称:cardsType 类型:int 备注:牌型(0:没牛，1-10:牛1到牛牛,四花:11,四炸:12,五花:13,五小:14)
	}
]]
function four_niuniu_manager:resDealCardsMsg(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CFourNiuNiuMainScene")
	if game_ui then
		game_ui:sendCardsStage(msg.cards, msg.cardsType)
	end
end

--[[
	游戏结束消息
	msg = {
		名称:billInfos 类型:List<BillInfo> 备注:结算信息
	}
]]
function four_niuniu_manager:resGameOverMsg(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CFourNiuNiuMainScene")
	if game_ui then

		local allWin = true
		local allLose = true
		for i,v in ipairs(msg.billInfos) do
			game_ui:splitChipsToPlayer(v.order, v.chips, i == #msg.billInfos)

			if game_ui._bankerOrder ~= v.order then
				if long_compare(v.chips, 0) > 0 then
					allLose = false
				else
					allWin = false
				end
			end
		end

		if #msg.billInfos == 0 then
			game_ui:clearAllChipsImg()
		end

		if allWin then
			audio_manager:playOtherSound(2)
		elseif allLose then
			audio_manager:playOtherSound(3)
		end

		game_ui:enterCompleteStage()
	end
	
end