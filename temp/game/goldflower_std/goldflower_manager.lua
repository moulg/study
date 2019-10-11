--[[
	扎金花管理类
]]

goldflower_manager = {}

--我自己的座位id
goldflower_manager._mySeatOrder = nil
--拥有筹码
goldflower_manager._ownChips = "0"
--座位列表
goldflower_manager._seatsMap = {}
--下一个操作
goldflower_manager.nextOpt = {}
--是否看过牌
goldflower_manager.bIsSawCard = false
--是否已下注
goldflower_manager.bIsBet = false
--结算信息
goldflower_manager.billInfo = nil
--是否正在播放比牌特效
goldflower_manager.bIsVersusing = false
--是否已收到结算消息
goldflower_manager.bIsGameOver = false
--记录
goldflower_manager._recordData = {}
--自动跟注
goldflower_manager.isAutoKeepAny = false
--自动准备
goldflower_manager.isAutoReady = false

--初始化座位信息
function goldflower_manager.saveSeatInfos(members)
	goldflower_manager._seatsMap = {}
	for k,v in pairs(members) do
		goldflower_manager._seatsMap[v.order] = v

		if player_is_myself(v.playerId) then
			goldflower_manager._mySeatOrder = v.order
		end
	end
end


--准备状态重置
function goldflower_manager:resetReadyState()
	for i,v in pairs(self._seatsMap) do
		v.state = 1
	end

	
end

--[[
	获取实际显示的座位号
	1.当我进入位置数(a)小于或者等于2的时候:我实际位置=2.其余玩家实际位置(b)=玩家原来位置(c)+(2-a),
	当b大于4的时候,其余玩家实际位置b=b-5。
	2.当我进入位置数(a)大于2的时候:我实际位置=2,其余玩家实际位置(b)=玩家原来位置(c)-(a-2)，
	当b小于0的时候,其余玩家实际位置b=5+b。
]]
function goldflower_manager:getRealOrder(order)
	local realOrder = 1
	if self._mySeatOrder <= 2 then
		realOrder = order + (2 - self._mySeatOrder)
		if realOrder > 4 then
			realOrder = realOrder - 5
		end
	elseif self._mySeatOrder > 2 then
		realOrder = order - (self._mySeatOrder - 2)
		if realOrder < 0 then
			realOrder = realOrder + 5 
		end
	end
	return realOrder 
end

--更新记录
-- function goldflower_manager:updateRecord()
-- 	for k,v in pairs(goldflower_manager._seatsMap) do
-- 		if goldflower_manager._recordData[v.playerName] == nil then
-- 			local realOrder = goldflower_manager:getRealOrder(v.order)
-- 			goldflower_manager._recordData[v.playerName] = {order = v.order,name = v.playerName,count = 0,totalCount = 0,realOrder = realOrder}
-- 		end 
-- 	end
-- 	for k,v in pairs(goldflower_manager._recordData) do
-- 		if goldflower_manager._seatsMap[v.order] == nil then
-- 			goldflower_manager._recordData[k] = nil
-- 		end
-- 	end
-- end



--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function goldflower_manager:resEnterGameHall(msg)
	local _playerInfo = get_player_info()
	_playerInfo.myRoomTypeInfo = msg.roomTypes
	_playerInfo.curGameID = 17
	_playerInfo.curGameDeskClassName = "CGoldFlowerDesk"

	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
function goldflower_manager:resChipsChange(msg)
	print("玩家筹码变化消息消息")
	local game_goldflower = WindowScene.getInstance():getModuleObjByClassName("CGoldFlowerMainScene")
	if game_goldflower and game_goldflower.isLoadEnd == true then
		game_goldflower:updateChips(msg.order, msg.chips)

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
function goldflower_manager:resReady(msg)
	dump(msg)
	if msg.res == 0 then
		local game_goldflower = WindowScene.getInstance():getModuleObjByClassName("CGoldFlowerMainScene")
		if game_goldflower and game_goldflower.isLoadEnd == true then
			game_goldflower:setPlayerReady(msg.order)
		end

		if self._seatsMap[msg.order] then
			self._seatsMap[msg.order].state = 2
		end
	end
	
end

--[[
	请求交换桌子消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:已经准备不能交换桌子,2:当前房间没有空位置
	}
]]
function goldflower_manager:resExchangeTable(msg)
	if msg.res == 2 then
		TipsManager:showOneButtonTipsPanel( 100014, {}, true )
	end
	
end

--[[
	请求下注结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:筹码不合法
		名称:order 类型:int 备注:座位顺序
		名称:chips 类型:long 备注:筹码
		名称:nextOptOrder 类型:int 备注:座位顺序
		名称:nextOptPlayerId 类型:long 备注:退桌玩家id
	}
]]
function goldflower_manager:resBet(msg)
	print("请求下注结果消息")
	dump(msg)
	if msg.res == 0 then
		if msg.nextOptOrder then
			goldflower_manager.nextOpt.nextOptOrder = msg.nextOptOrder
			goldflower_manager.nextOpt.nextOptPlayerId = msg.nextOptPlayerId
		end
		if msg.order == goldflower_manager._mySeatOrder then
			goldflower_manager.bIsBet = true
		end
		local game_goldflower = WindowScene.getInstance():getModuleObjByClassName("CGoldFlowerMainScene")
		if game_goldflower then
			if game_goldflower._playerSeatMap[msg.order].bIsSawCard then
				goldflower_manager.nextOpt.nextBetChips = long_divide(msg.chips,2)
			else
				goldflower_manager.nextOpt.nextBetChips =  msg.chips
			end
			game_goldflower:addChipsToPanelByValue(msg.order, msg.chips)
			game_goldflower:exitBetStage(msg.order)
			game_goldflower:enterBetStage()
		end
	end
	
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
function goldflower_manager:resFastEnterTable(msg)
	HallManager:resQuickEnterCurGame(msg)
end

--[[
	进入房间结果消息
	msg = {
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
function goldflower_manager:resEnterRoom(msg)
	HallManager:resEnterRoomMsg(msg)
end

--[[
	进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
function goldflower_manager:resEnterTable(msg)
	local members = msg.mems
	local _playerInfo = get_player_info()
    _playerInfo.myTableId = members[1].tableId
	
	goldflower_manager._ownChips = "0"
	goldflower_manager.saveSeatInfos(members)
	WindowScene.getInstance():replaceModuleByModuleName("goldflower_std")

	HallManager:enterTableHandler(msg)
	
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
function goldflower_manager:resExitRoom(msg)
	--add your logic code here
	
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
function goldflower_manager:resExitTable(msg)
	if self._mySeatOrder == msg.order then
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
		local game_goldflower = WindowScene.getInstance():getModuleObjByClassName("CGoldFlowerMainScene")
		if game_goldflower and game_goldflower.isLoadEnd == true then
			game_goldflower:removePlayer(msg.order)
		end

		local name = self._seatsMap[msg.order].playerName
		HallManager:informPlayerExitGame(name)

        self._seatsMap[msg.order] = nil
	end
	
end

--[[
	其他人进入桌子消息
	msg = {
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
function goldflower_manager:resOtherEnterTable(msg)
	member = msg.mem

	HallManager:informPlayerEnterGame(member.playerName)

	local game_goldflower = WindowScene.getInstance():getModuleObjByClassName("CGoldFlowerMainScene")
	if game_goldflower and game_goldflower.isLoadEnd == true then
        game_goldflower:OtherPlayerEnterTable(member)
	end

	self._seatsMap[member.order] = member
	
end

--[[
	所有玩家准备，准备结束消息
	msg = {
		名称:nextOptOrder 类型:int 备注:座位顺序
		名称:nextOptPlayerId 类型:long 备注:退桌玩家id
	}
]]
function goldflower_manager:resReadyOver(msg)
	--add your logic code here
	dump(msg)
	if msg then
		goldflower_manager.nextOpt.nextOptOrder = msg.nextOptOrder
		goldflower_manager.nextOpt.nextOptPlayerId = msg.nextOptPlayerId
		goldflower_manager.nextOpt.nextBetChips = "0"
		local game_goldflower = WindowScene.getInstance():getModuleObjByClassName("CGoldFlowerMainScene")
		if game_goldflower then
			game_goldflower._gameIsGoing = true
			game_goldflower:enterSendHandCardStage()
		end
	end
end

--[[
	游戏结算消息
	msg = {
		名称:billInfos 类型:List<BillInfo> 备注:结算信息
	}
]]
function goldflower_manager:resGameOver(msg)
	--add your logic code here
	print("结算消息")
	if msg.billInfos then
		dump(msg.billInfos)
		goldflower_manager.billInfo = nil 
		goldflower_manager.billInfo = msg.billInfos
		goldflower_manager.bIsGameOver = true
		if goldflower_manager.bIsVersusing == false then
			local game_goldflower = WindowScene.getInstance():getModuleObjByClassName("CGoldFlowerMainScene")
			if game_goldflower then
				print("立即结算")
				game_goldflower._gameIsGoing = false
				game_goldflower:enterBanlanceStage()
			end
		end
	end
end

--[[
	看牌结果消息
	msg = {
		名称:cardsType 类型:int 备注:牌型(0:235,1:单张,2:对子,3:顺子,4:金华,5:顺金,6:豹子)
		名称:cards 类型:List<int> 备注:牌
	}
]]
function goldflower_manager:resSeeCard(msg)
	--add your logic code here
	print("看牌结果消息")
	dump(msg)
	if msg.cards then
		local game_goldflower = WindowScene.getInstance():getModuleObjByClassName("CGoldFlowerMainScene")
		if game_goldflower then
			game_goldflower:setSeeCardResult(msg.cards)
		end
	end
end

--[[
	玩家看过牌消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
function goldflower_manager:resSawCard(msg)
	--add your logic code here
	print("玩家看过牌消息")
	if msg.order then
		if msg.order == goldflower_manager._mySeatOrder then
			goldflower_manager.bIsSawCard = true
		end
		local game_goldflower = WindowScene.getInstance():getModuleObjByClassName("CGoldFlowerMainScene")
		if game_goldflower then
			game_goldflower:setSawCard(msg.order)
		end
	end
end

--[[
	弃牌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
		名称:nextOptOrder 类型:int 备注:下一个操作玩家order
		名称:nextOptPlayerId 类型:long 备注:下一个操作玩家id
	}
]]
function goldflower_manager:resDiscard(msg)
	print("弃牌结果消息")
	dump(msg)
	if msg.order then
		local game_goldflower = WindowScene.getInstance():getModuleObjByClassName("CGoldFlowerMainScene")
		if game_goldflower and (game_goldflower._gameIsGoing == true) then
			game_goldflower:setDisCard(msg.order)
			if msg.nextOptOrder ~= -1 then
				goldflower_manager.nextOpt.nextOptOrder = msg.nextOptOrder
				goldflower_manager.nextOpt.nextOptPlayerId = msg.nextOptPlayerId
				game_goldflower:enterBetStage()
			end
		end
	end
end

--[[
	比牌结果消息
	msg = {
		名称:win 类型:int 备注:0:输,非0:赢
		名称:playerId 类型:long 备注:主动比牌玩家id
		名称:vsPlayerId 类型:long 备注:被比牌玩家id
		名称:nextOptOrder 类型:int 备注:下一个操作玩家order
		名称:nextOptPlayerId 类型:long 备注:下一个操作玩家id
	}
]]
function goldflower_manager:resVersus(msg)
	--add your logic code here
	print("比牌结果消息")
	dump(msg)
	if msg then
		goldflower_manager.bIsVersusing = true
		if msg.nextOptOrder ~= -1 then
			goldflower_manager.nextOpt.nextOptOrder = msg.nextOptOrder
			goldflower_manager.nextOpt.nextOptPlayerId = msg.nextOptPlayerId
		end
		local game_goldflower = WindowScene.getInstance():getModuleObjByClassName("CGoldFlowerMainScene")
		if game_goldflower then
			for k,v in pairs(game_goldflower._playerSeatMap) do
				if v.playerId == msg.playerId then
					local requireChips = long_multiply(goldflower_manager.nextOpt.nextBetChips,2)
					if v.bIsSawCard then
						requireChips = long_multiply(requireChips,2)
					end
					game_goldflower:addChipsToPanelByValue(v.order,requireChips)
					game_goldflower:exitBetStage(v.order)
				end
			end 
			game_goldflower:setVersusResult(msg.playerId,msg.vsPlayerId,msg.win)
		end
	end

end


--传输对象说明
--[[
	RoomTypeDetailInfo = {
		type, --房间类型id
		typeName, --房间类型名称
		rooms, --房间
	}
]]
--[[
	RoomInfo = {
		roomId, --房间id
		name, --房间名称
		type, --房间类型
		maxNum, --房间最大人数
		free, --空闲状态人数
		general, --普通状态人数
		crowded, --拥挤状态人数
		lower, --进入下限
		upper, --进入上限
		proportionGold, --金币比例
		proportionChips, --筹码比例
		tabble, --每桌椅子数
		maxOne, --单局上限（筹码）
		minOne, --单局下限（筹码）
		afee, --单局台费
		inType, --进入类型（0点击入座，1自动分配）
		playerNum, --玩家人数
		base, --底注
		top, --封顶
		chip1, --筹码1
		chip2, --筹码2
		chip3, --筹码3
		status, --状态(空闲,普通,拥挤,爆满)
		displayNames, --展示的属性名称
		placeHolder, --展示的属性名称占位符
	}
]]
--[[
	BillInfo = {
		order, --座位顺序
		playerName, --玩家昵称
		chips, --结算筹码(包含喜钱)
		luck, --喜钱
		cardsType, --牌型(0:235,1:单张,2:对子,3:顺子,4:金华,5:顺金,6:豹子)
		cards, --牌
	}
]]
