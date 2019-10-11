--[[

欢乐五张管理类
]]

joyfive_manager = {}

--当前拥有筹码
joyfive_manager._ownChips = "0"
--游戏状态,1->入座，2->准备，3->游戏中
joyfive_manager.state = 0
--当前玩家自己的座位
joyfive_manager._mySeatOrder = 3
--当前玩家playerId
joyfive_manager._playerId = 3
--加注次数
joyfive_manager._addBetCount = 0
--发牌次数
joyfive_manager._sendCardsCount = 0
--是否有人梭哈
joyfive_manager._BetAll = false
--当前玩家是否跟注
joyfive_manager._keepBet = false
--当前玩家是否加注
joyfive_manager._AddBet = false
joyfive_manager._hiddenCardList = {}
joyfive_manager.openCardList = {}
--是否已发手牌
joyfive_manager._start = false
--是否开始结算
joyfive_manager._isBanlance = false
--座位信息
joyfive_manager._seatsMap = {}
--记录
joyfive_manager._recordData = {}
--模拟服务器发的牌列表
joyfive_manager._testCardList = {{order=1,card=6},{order=2,card=16},{order=3,card=26},{order=1,card=15},{order=2,card=25},{order=3,card=35},}
--牌特效类型
joyfive_manager._cardEffectTypeList = {"single","pairs","twopairs","three","long","sameflowers","hulu","four","sameflowerslong"}
--胜利失败特效
joyfive_manager._winAndLostEffectList = {"win","lost",}

--获取实际显示的座位号
function joyfive_manager:getRealOrder(order)
	local realOrder = 1
	if joyfive_manager._mySeatOrder == order then
		realOrder = 1
	else
		if joyfive_manager._mySeatOrder == 4 then
			realOrder = order % joyfive_manager._mySeatOrder + 1
		end
		if joyfive_manager._mySeatOrder == 3 then
			if order < joyfive_manager._mySeatOrder then
				realOrder = order + (joyfive_manager._mySeatOrder - 1)
			else
				realOrder = order - (joyfive_manager._mySeatOrder - 1)
			end
		end
		if joyfive_manager._mySeatOrder == 2 then
			if order > joyfive_manager._mySeatOrder then
				realOrder = order - (joyfive_manager._mySeatOrder - 1)
			else
				realOrder = 4
			end
		end
		if joyfive_manager._mySeatOrder == 1 then
			realOrder = order
		end
	end
	return realOrder
end

--初始化座位信息
function joyfive_manager.saveSeatInfos(members)
	--dump(members)
	joyfive_manager._seatsMap = {}
	for k,v in pairs(members) do
		joyfive_manager._seatsMap[v.order] = v

		if player_is_myself(v.playerId) then
			joyfive_manager._mySeatOrder = v.order
		end
	end
end

--准备状态重置
function joyfive_manager:resetReadyState()
	for i,v in pairs(self._seatsMap) do
		v.state = 1
	end
end

--更新记录
function joyfive_manager:updateRecord()
	for k,v in pairs(joyfive_manager._seatsMap) do
		if joyfive_manager._recordData[v.playerName] == nil then
			local realOrder = joyfive_manager:getRealOrder(v.order)
			joyfive_manager._recordData[v.playerName] = {order = v.order,name = v.playerName,count = 0,totalCount = 0,realOrder = realOrder}
		end 
	end
	for k,v in pairs(joyfive_manager._recordData) do
		if joyfive_manager._seatsMap[v.order] == nil then
			joyfive_manager._recordData[k] = nil
		end
	end
end
--获取筹码最少玩家的筹码
function joyfive_manager:getLeastChips()
	local leastChips = joyfive_manager._seatsMap[joyfive_manager._mySeatOrder].chips
	for k,v in pairs(joyfive_manager._seatsMap) do
		if  long_compare(leastChips, v.chips) > 0 then
			leastChips = v.chips
		end
	end
	return leastChips
end
-------------------------------------消息处理-----------------------------------------------
--[[
	欢乐五张大厅数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function joyfive_manager:resEnterGameHall(msg)
	local _playerInfo = get_player_info()
	_playerInfo.myRoomTypeInfo = msg.roomTypes
	_playerInfo.curGameID = 6
	_playerInfo.curGameDeskClassName = "CJoyFiveDesk"


	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
end

--[[
	返回请求进入房间结果消息
	msg = {
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
function joyfive_manager:resEnterRoom(msg)
	
end

--[[
	返回请求进入牌桌结果消息
	msg = {
		名称:players 类型:List<long> 备注:牌桌中的玩家
	}
]]
function joyfive_manager.resEnterTableMsg(msg)
	local members = HallManager:getMemberInfos(msg)
	local _playerInfo = get_player_info()
    _playerInfo.myTableId = members[1].tableId
    
	joyfive_manager._ownChips = "0"
	joyfive_manager.saveSeatInfos(members)
	WindowScene.getInstance():replaceModuleByModuleName("joyfive_std")
	local game_JoyFive = WindowScene.getInstance():getModuleObjByClassName("CJoyFiveGame")
	if game_JoyFive then
		game_JoyFive:init_after_enter()
		--game_JoyFive:enterReadyStage()
	end
	
	HallManager:enterTableHandler(msg)
end
--[[
	玩家准备消息
	msg = {
		名称:order 类型:int 备注:准备的玩家
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
function joyfive_manager:resReady(msg)
	if msg.res == 0 then
		if joyfive_manager._seatsMap[msg.order] then
			joyfive_manager._seatsMap[msg.order].state = 2
		end
		local game_joyfive = WindowScene.getInstance():getModuleObjByClassName("CJoyFiveGame")
		if game_joyfive then
			game_joyfive:setPlayerReady(msg.order)
		end
	end
end

--[[
	底牌消息
	msg = {
		名称:cards 类型:List<int> 备注:底牌
		名称:isNeedInfo 类型:int 备注:是否需要返回告知发牌结束 0:是，1：不是
	}
]]
function joyfive_manager:resHiddenCards(msg)
	--add your logic code here
	
end

--[[
	发牌消息
	msg = {
		名称:landlordOrder 类型:int 备注:庄家座位号
		名称:openCards 类型:int 备注:玩家的明牌
		名称:hiddenCards 类型:int 备注:玩家的底牌
	}
]]
function joyfive_manager:resDealCards(msg)
	print("服务器发底牌")
	joyfive_manager._hiddenCards = msg.hiddenCards
	local game_joyfive = WindowScene.getInstance():getModuleObjByClassName("CJoyFiveGame")
	if game_joyfive then
		print("重置")
		game_joyfive:resetGame()
	end
	HallManager:informPalyerGameStartMsg()
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:seatInfo 类型:com.wly.game.gamehall.dto.SeatInfo 备注:退桌子信息
	}
]]
function joyfive_manager:resExitTable(msg)
	if msg then 
		if joyfive_manager._mySeatOrder == msg.seatInfo.order then
			if WindowScene.getInstance():getCurModuleName()  == "game_lobby" then
				return
			end
			WindowScene.getInstance():replaceModuleByModuleName("game_lobby")

			local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
			if gamelobby then
				gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_GAME_ROOM)
			end

			--座位信息清空
		    joyfive_manager._seatsMap = {}
		    joyfive_manager._mySeatOrder = nil
		    joyfive_manager._recordData = {}
		else
			local member = HallManager._members[msg.seatInfo.playerId]
	        for k,v in pairs(joyfive_manager._recordData) do
	        	if v.name == member.playerName then
	        		joyfive_manager._recordData[k] = nil
	        	end
	        end
			local game_joyfive = WindowScene.getInstance():getModuleObjByClassName("CJoyFiveGame")
			if game_joyfive then
				game_joyfive:removePlayer(msg.seatInfo.order)
				game_joyfive.statistics_ui:updateUi(joyfive_manager._recordData)
			end
	        local name = joyfive_manager._seatsMap[msg.seatInfo.order].playerName
			HallManager:informPlayerExitGame(name)
	        joyfive_manager._seatsMap[msg.seatInfo.order] = nil

		end
	end
end

--[[
	欢乐五张房间人数消息
	msg = {
		名称:roomId 类型:int 备注:房间
		名称:type 类型:int 备注:房间类型
		名称:num 类型:int 备注:房间人数
	}
]]
function joyfive_manager:resRoomPlayerNum(msg)
	--add your logic code here
	
end

--[[
	通知客户端该轮结束消息
	msg = {
		名称:state 类型:int 备注:当前第几轮
	}
]]
function joyfive_manager:resTurnOver(msg)
	--add your logic code here
	
end

--[[
	返回下注结果给其他玩家消息
	msg = {
		名称:bet 类型:long 备注:下注数量
		名称:order 类型:int 备注:玩家座位号
		名称:betType 类型:int 备注:下注类型
	}
]]
function joyfive_manager:resBet(msg)
	print("返回下注结果给其他玩家消息")
	dump(msg)
	local game_joyfive = WindowScene.getInstance():getModuleObjByClassName("CJoyFiveGame")
	if game_joyfive then
		game_joyfive:playerBetChips(msg.order, msg.betType, msg.bet, true)
		game_joyfive:exitBetStage(msg.order)
	end
end

--[[
	通知下一个玩家下注消息
	msg = {
		名称:order 类型:int 备注:下一个玩家的座位号
		名称:curMaxBet 类型:long 备注:当前轮次最大下注数
		名称:allInBet 类型:long 备注:当前轮次梭哈数
	}
]]
function joyfive_manager:resNextSeat(msg)
	print("通知下一个玩家下注消息")
	dump(msg)
	local game_joyfive = WindowScene.getInstance():getModuleObjByClassName("CJoyFiveGame")
	if game_joyfive then
		game_joyfive:enterBetStage(msg.order, msg.curMaxBet,msg.allInBet)
	end
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:order 类型:int 备注:玩家id
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
function joyfive_manager:resChipsChange(msg)
	local game_joyfive = WindowScene.getInstance():getModuleObjByClassName("CJoyFiveGame")
	if game_joyfive then
		game_joyfive:updateChips(msg.order, msg.chips)
		if msg.order == self._mySeatOrder then
			self._ownChips = msg.chips
		end
	end
	if self._seatsMap[msg.order] then
		self._seatsMap[msg.order].chips = msg.chips
	end 
	
end

--[[
	玩家请求结算结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有可结算筹码
	}
]]
function joyfive_manager:resBill(msg)
	--add your logic code here
	
end

--[[
	通知其他玩家我进入房间的消息消息
	msg = {
		名称:playerId 类型:long 备注:进入桌子的其他玩家
	}
]]
function joyfive_manager:resOtherPlayer(msg)
	member = HallManager._members[msg.playerId]
	joyfive_manager._seatsMap[member.order] = member
	HallManager:informPlayerEnterGame(member.playerName)

	local game_JoyFive = WindowScene.getInstance():getModuleObjByClassName("CJoyFiveGame")
	if game_JoyFive then
		game_JoyFive:OtherPlayerEnterTable(member)
	end
end

--[[
	游戏结束结算结果消息
	msg = {
		名称:billInfo 类型:List<PlayerBillInfo> 备注:结算信息
		名称:cards 类型:List<PlayerCards> 备注:玩家手上的牌
		名称:type 类型:int 备注:0：正常结算，1：弃牌结算
	}
]]
function joyfive_manager:resBanlance(msg)
	local game_JoyFive = WindowScene.getInstance():getModuleObjByClassName("CJoyFiveGame")
	if game_JoyFive then
		local callback = function ()
			game_JoyFive:gameBanlance(msg)
		end
		joyfive_manager._isBanlance = true
		game_JoyFive:playerBetTogether(callback)
	end
end

--[[
	返回亮牌牌信息消息

	msg = {
		名称:cards 类型:List<int> 备注:亮牌牌ID
		名称:order 类型:int 备注:亮牌玩家位置号
	}
]]
function joyfive_manager:resLightCard(msg)
	--add your logic code here
	
end

--[[
	告知机器谁会获胜消息
	msg = {
		名称:order 类型:int 备注:座位号
	}
]]
function joyfive_manager:resWin(msg)
	--add your logic code here
	
end

--[[
	玩家明牌的牌消息
	msg = {
		名称:cards 类型:List<PlayerCards> 备注:玩家明牌的牌
	}
]]
function joyfive_manager:resOpenHandInfo(msg)
	print("******************服务器发牌******************")
	dump(msg.cards)
	--重置跟注
	joyfive_manager._keepBet = false
	--重置加注
	joyfive_manager._AddBet = false
	joyfive_manager.openCardList = {}
	local isTwoCard = false
	for k,v in pairs(msg.cards) do
		local tab = {order = v.order,card = v.cards[1]}
		joyfive_manager.openCardList[k] = tab
		if v.cards[2] ~= nil then
			isTwoCard = true
		end
	end
	if isTwoCard then
		local nums = table.nums(joyfive_manager.openCardList)
		for k,v in pairs(msg.cards) do
			local tab = {order = v.order,card = v.cards[2]}
			joyfive_manager.openCardList[k+nums] = tab
		end
	end
	local game_JoyFive = WindowScene.getInstance():getModuleObjByClassName("CJoyFiveGame")
	if game_JoyFive then
		if joyfive_manager._start then
			local callback = function ()
				game_JoyFive:enterSendHandCardStage(joyfive_manager.openCardList)
			end
			game_JoyFive:playerBetTogether(callback)
			--game_JoyFive:enterSendHandCardStage(joyfive_manager.openCardList)
		else
			game_JoyFive:startGame(joyfive_manager.openCardList)
		end
	end
end
--[[
	返回玩家请求看牌消息
	msg = {
		名称:order 类型:int 备注:看牌玩家的座位号
	}
]]
function joyfive_manager:resCheckCard(msg)
	print("************玩家看牌***********")
	if msg.order then
		local game_JoyFive = WindowScene.getInstance():getModuleObjByClassName("CJoyFiveGame")
		if game_JoyFive then
			game_JoyFive:checkCard(msg.order)
		end
	end
end

--[[
	返回底注筹码数量消息
	msg = {
		名称:bet 类型:long 备注:底注筹码数量
	}
]]
function joyfive_manager:resBottomBet(msg)
	print("************底注***********")
	local game_JoyFive = WindowScene.getInstance():getModuleObjByClassName("CJoyFiveGame")
	if game_JoyFive then
		game_JoyFive:addBottomBet(msg.bet)
	end
end
--[[
	请求交换桌子消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:已经准备不能交换桌子,2:当前房间没有空位置
	}
]]
function joyfive_manager:resExchangeTable(msg)
	if msg.res == 2 then
		TipsManager:showOneButtonTipsPanel( 100014, {}, true )
	end
end