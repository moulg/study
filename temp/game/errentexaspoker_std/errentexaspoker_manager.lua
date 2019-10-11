--[[
德州扑克管理类
]]

errentexaspoker_manager = {}

--我自己的座位id
errentexaspoker_manager._mySeatOrder = nil
--拥有筹码
errentexaspoker_manager._ownChips = "0"

--玩家游戏状态
errentexaspoker_manager.GameState = {
	KEEP_BET = 0,
	GIVE_UP = 1,
	ADD_BET = 2,
	ALL_BET = 3,
	PASS_CARD = 4,
	SM_BLIND = 5,
	BIG_BLIND = 6,
}

--自动选择项
errentexaspoker_manager.autoSelect = nil

--跟注 一次
errentexaspoker_manager.AUTO_KEEP_BET_ONCE = 0
--让牌/弃牌
errentexaspoker_manager.AUTO_PASS_ABANDON = 1
--跟任何注
errentexaspoker_manager.AUTP_KEEP_ANY_BET = 2

--是否自动准备
errentexaspoker_manager.isAutoReady = false

errentexaspoker_manager._seatsMap = {}
--是否可下注
errentexaspoker_manager._bCanBet = true
--是否是弃牌结算
errentexaspoker_manager._bDiscard = false



function errentexaspoker_manager:getRealOrder(order)
	local realOrder = 1
	if order == errentexaspoker_manager._mySeatOrder then
		realOrder = 1
	else
		realOrder = 2
	end
	return realOrder
end

--玩家下注筹码的字符数组相加
function errentexaspoker_manager:betChipsArrayAddition(arr1, arr2)
	local len = #arr1 > #arr2 and #arr1 or #arr2

	local newArr = {}
	for i=1,len do
		if arr1[i] and arr2[i] then
			table.insert(newArr, tonumber(arr1[i]) + tonumber(arr2[i]))
		elseif arr1[i] == nil then
			table.insert(newArr, tonumber(arr2[i]))
		elseif arr2[i] == nil then
			table.insert(newArr, tonumber(arr1[i]))
		end
	end

	return newArr
end

--初始化座位信息
function errentexaspoker_manager.saveSeatInfos(members)
	errentexaspoker_manager._seatsMap = {}
	for k,v in pairs(members) do
		errentexaspoker_manager._seatsMap[v.order] = v

		if player_is_myself(v.playerId) then
			errentexaspoker_manager._mySeatOrder = v.order
		end
	end
end


--准备状态重置
function errentexaspoker_manager:resetReadyState()
	for i,v in pairs(self._seatsMap) do
		v.state = 1
	end

	
end

----------------------------------------------------------------房间座位消息

function errentexaspoker_manager:resEnterGameHallMsg(msg)
	local _playerInfo = get_player_info()
	_playerInfo.myRoomTypeInfo = msg.roomTypes
	_playerInfo.curGameID = 15
	_playerInfo.curGameDeskClassName = "CErRenTexaspokerDesk"

	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
end

--[[
	返回请求进入牌桌结果消息
		msg = {
		名称:players 类型:List<long> 备注:牌桌中的玩家
	}
]]
function errentexaspoker_manager.resEnterTableMsg(msg)
	-- local members = HallManager:getMemberInfos(msg)
	local members = msg.mems
	local _playerInfo = get_player_info()
    _playerInfo.myTableId = members[1].tableId
	
	errentexaspoker_manager._ownChips = "0"
	errentexaspoker_manager.saveSeatInfos(members)
	WindowScene.getInstance():replaceModuleByModuleName("errentexaspoker_std")

	HallManager:enterTableHandler(msg)
end

--[[
	通知其他玩家我进入房间的消息消息
	msg = {
		名称:playerId 类型:long 备注:进入桌子的其他玩家
	}
]]
function errentexaspoker_manager:resOtherPlayerEnterTableMgs(msg)
	-- member = HallManager._members[msg.playerId]
	member = msg.mem

	HallManager:informPlayerEnterGame(member.playerName)

	local game_texaspoker = WindowScene.getInstance():getModuleObjByClassName("CErRenTexasPokerMainScene")
	if game_texaspoker and game_texaspoker.isLoadEnd == true then
        game_texaspoker:createPlayer(member)
	end

	self._seatsMap[member.order] = member
end


--[[
	玩家退出房间牌桌结果消息
		msg = {
		名称:seatInfo 类型:com.wly.game.gamehall.dto.SeatInfo 备注:退桌子信息
	}
]]
function errentexaspoker_manager:resExitTableMsg(msg)
	if self._mySeatOrder == msg.seatInfo.order then
		HallManager:reqExitCurGameRoom()
		if WindowScene.getInstance():getCurModuleName()  == "game_lobby" then
			return
		end
		WindowScene.getInstance():replaceModuleByModuleName("game_lobby")

		--切界面
		local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
		if gamelobby then
			gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
		end

	    --座位信息清空
	    self._seatsMap = {}
	    self._mySeatOrder = nil
	else
		local game_texaspoker = WindowScene.getInstance():getModuleObjByClassName("CErRenTexasPokerMainScene")
		if game_texaspoker and game_texaspoker.isLoadEnd == true then
			game_texaspoker:removePlayer(msg.seatInfo.order)
		end

		local name = self._seatsMap[msg.seatInfo.order].playerName
		HallManager:informPlayerExitGame(name)

        self._seatsMap[msg.seatInfo.order] = nil
	end
end

--[[
	玩家筹码变化消息消息
	msg = {
		order
		名称:chips 类型:int 备注:兑换的游戏币后的筹码
	}
]]
function errentexaspoker_manager:resChipsChangeMsg(msg)
	local game_texaspoker = WindowScene.getInstance():getModuleObjByClassName("CErRenTexasPokerMainScene")
	if game_texaspoker and game_texaspoker.isLoadEnd == true then
		game_texaspoker:updateChips(msg.order, msg.chips)

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
		名称:order 类型:int 备注:准备的玩家
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
function errentexaspoker_manager:resReadyMsg(msg)
	print("玩家准备消息")
	if msg.res == 0 then
		local game_texaspoker = WindowScene.getInstance():getModuleObjByClassName("CErRenTexasPokerMainScene")
		if game_texaspoker and game_texaspoker.isLoadEnd == true then
			if msg.order == errentexaspoker_manager._mySeatOrder then
				game_texaspoker:resetGameData()
			end
			game_texaspoker:setPlayerReady(msg.order)
		end

		if self._seatsMap[msg.order] then
			self._seatsMap[msg.order].state = 2
		end
	end
end

----------------------------------------------------------------游戏消息

--[[
	底牌消息
	msg = {
		名称:cards 类型:List<int> 备注:底牌
		名称:isNeedInfo 类型:int 备注:是否需要返回告知发牌结束 0:是，1：不是
	}
]]
function errentexaspoker_manager:resHiddenCardsMsg(msg)
	print("底牌消息")
	-- dump(msg.cards)
	local game_texaspoker = WindowScene.getInstance():getModuleObjByClassName("CErRenTexasPokerMainScene")
	if game_texaspoker then
		game_texaspoker:playerBetTogether(function ()
            game_texaspoker:sendPublicCards(msg.cards, msg.isNeedInfo == 0)
        end)
	end
end


--[[
	发牌消息
	msg = {
		名称:landlordOrder 类型:int 备注:庄家座位号
		名称:smallBind 类型:int 备注:小盲注座位号
		名称:binBind 类型:int 备注:大盲注座位号
		名称:cards 类型:List<int> 备注:玩家的牌
	}
]]
function errentexaspoker_manager:resDealCardsMsg(msg)
	print("发手牌消息")
	-- dump(msg.cards)
	local game_texaspoker = WindowScene.getInstance():getModuleObjByClassName("CErRenTexasPokerMainScene")
	if game_texaspoker then
		-- game_texaspoker:resetGameData()
		game_texaspoker._gameIsGoing = true

		--庄家
		game_texaspoker:setMasterPlayer( msg.landlordOrder )

		local roominfo = get_player_info():get_cur_roomInfo()
		--小盲注
		local smBet = long_divide(roominfo.minOne, 2)
		game_texaspoker:playerBetChips(msg.smallBind, self.GameState.SM_BLIND, smBet)
		--大盲注
		game_texaspoker:playerBetChips(msg.binBind, self.GameState.BIG_BLIND, roominfo.minOne)

		game_texaspoker:enterSendHandCardStage(msg.cards)

		HallManager:informPalyerGameStartMsg()
	end
end

--[[
	通知下一个玩家下注消息
	msg = {
		order
		名称:raisetBet 类型:int 备注:当前的加注额度
		名称:curMaxBet 类型:int 备注:当前轮次最大下注数
	}
]]
function errentexaspoker_manager:resNextSeatMsg(msg)
	local game_texaspoker = WindowScene.getInstance():getModuleObjByClassName("CErRenTexasPokerMainScene")
	if game_texaspoker then
		game_texaspoker:enterBetStage(msg.order, msg.raisetBet, msg.curMaxBet)
	end
end

--[[下注结果
	order  座位号
	名称:bet 类型:int 备注:下注数量
	名称:betType 类型:int 备注:下注类型
]]
function errentexaspoker_manager:resBetResultMsg(msg)
	local game_texaspoker = WindowScene.getInstance():getModuleObjByClassName("CErRenTexasPokerMainScene")
	if game_texaspoker then
		game_texaspoker:playerBetChips(msg.order, msg.betType, msg.bet, true)
		game_texaspoker:exitBetStage(msg.order)
	end
end

--[[
	通知客户端该轮结束消息
	msg = {
		order
		名称:state 类型:int 备注:当前第几轮
	}
]]
function errentexaspoker_manager:resTurnOverMsg(msg)

end

--[[
	结算结果消息
	msg = {
		名称:billInfo 类型:List<PlayerBillInfo> 备注:结算信息
		名称:cards 类型:List<PlayerCards> 备注:玩家手上的牌
		名称:type 类型:int 备注:0：正常结算，1：弃牌结算
	}
]]
function errentexaspoker_manager:resBanlanceMsg(msg)
	print("结算结果消息")
	-- dump(msg.cards)
	-- dump(msg.billInfo)
	local game_texaspoker = WindowScene.getInstance():getModuleObjByClassName("CErRenTexasPokerMainScene")
	if game_texaspoker then
		--筹码集合之后  分发赢家筹码
		local callback = function ()
			for i,info in ipairs(msg.cards) do
				game_texaspoker:playerShowCards(info.order, info.cards)
			end

			--只有一个人赢 不存在分筹码,  筹码处于任何地方
			if #msg.billInfo == 1 then
				game_texaspoker:giveWinnerAllChips(msg.billInfo[1].order, msg.billInfo[1].bet, msg.type)
			elseif #msg.billInfo > 1 then--筹码全在 荷官手上
				game_texaspoker:splitChipsToPlayer(1, msg.billInfo)
			end

			for i,v in ipairs(msg.billInfo) do
				print("结算信息：order = "..v.order,"chips = "..v.bet)
			end
		end
		
		--延迟0.3让发牌结束
		performWithDelay(game_texaspoker, function ()
			game_texaspoker:playerBetTogether(callback)
			--游戏结束音效
			audio_manager:playOtherSound(2)
		end, 0.3)
		
	end
end

--[[
	返回亮牌牌信息消息
	msg = {
		名称:cards 类型:List<int> 备注:亮牌牌ID
		名称:order 类型:int 备注:亮牌玩家位置号
	}
]]
function errentexaspoker_manager:resLightCardMsg(msg)
	local game_texaspoker = WindowScene.getInstance():getModuleObjByClassName("CErRenTexasPokerMainScene")
	if game_texaspoker then
		game_texaspoker:playerShowCards(msg.order, msg.cards)
	end
end