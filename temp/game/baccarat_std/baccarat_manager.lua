 --[[
	百家乐管理类
]]

baccarat_manager = {}

--玩家筹码
baccarat_manager._ownChips = "0"
--游戏状态:1下注，2开奖，3休息，4洗牌
baccarat_manager._state = 1
--倒计时
baccarat_manager._countdown = 0
--当前选择筹码小图标
baccarat_manager._selectChipsType = nil
--所有下注的筹码
baccarat_manager.totalBetChipsMap = {}
--当前玩家下注的筹码
baccarat_manager.curBetChipsMap = {}
--用于记录当前玩家在每个区域下注的用于续押的总筹码数
baccarat_manager._continueChips = nil
--筹码数值
baccarat_manager._chipsValueList = {1,10,100,1000,10000,100000,1000000,10000000}
--开奖结果
baccarat_manager.result = nil
--玩家筹码变化
baccarat_manager.chipsChange = "0"
--切牌列表
baccarat_manager.cutCardList = nil
--统计数据
baccarat_manager.statisticsData = {}
--路单
baccarat_manager.alone = nil

baccarat_manager._cardEffectTypeList ={"蓝变蓝","蓝变黄","黄变蓝"}


--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function baccarat_manager:resEnterGameHall(msg)
	local _playerInfo = get_player_info()
	_playerInfo.myRoomTypeInfo = msg.roomTypes
	_playerInfo.curGameID = 18
	_playerInfo.curGameDeskClassName = "CBaccaratDesk"

	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家ID
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
function baccarat_manager:resChipsChange(msg)
	print("玩家筹码变化消息消息")
	dump(msg)
	if msg.playerId == get_player_info().id then
		self._ownChips = msg.chips
		local game_baccarat = WindowScene.getInstance():getModuleObjByClassName("CBaccaratMainScene")
		if game_baccarat and (game_baccarat.isLoadEnd == true) and (baccarat_manager._state ~= 2) then
			game_baccarat:updateChips()
		end
	end
end

--[[
	玩家准备消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
function baccarat_manager:resReady(msg)
	print("玩家准备消息")
	if msg.res == 0 then
		local game_baccarat = WindowScene.getInstance():getModuleObjByClassName("CBaccaratMainScene")
		if game_baccarat and game_baccarat.isLoadEnd == true then
			game_baccarat:setPlayerReady(msg.order)
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
function baccarat_manager:resExchangeTable(msg)
	--add your logic code here
	print("请求交换桌子消息")
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
function baccarat_manager:resFastEnterTable(msg)
	if msg.res == 2 then
		TipsManager:showOneButtonTipsPanel( 100014, {}, true )
	end
end

--[[
	进入房间结果消息
	msg = {
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
function baccarat_manager:resEnterRoom(msg)
	HallManager:resEnterRoomMsg(msg)
end

--[[
	进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
function baccarat_manager:resEnterTable(msg)
	local members = msg.mems
    local _playerInfo = get_player_info()
    _playerInfo.myTableId = members[1].tableId
    
	WindowScene.getInstance():replaceModuleByModuleName("baccarat_std")
	-- local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CBaccaratMainScene")
	-- if game_FoursShop then
	-- 	game_FoursShop:init_after()
	-- end

	HallManager:enterTableHandler(msg)
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
function baccarat_manager:resExitRoom(msg)
	--add your logic code here
	
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
function baccarat_manager:resExitTable(msg)
	if msg.playerId then
		if msg.playerId == get_player_info().id then
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
		end
	end
end

--[[
	返回倍率结果消息
	msg = {
		名称:iconMulti 类型:List<IconMultiple> 备注:本局所开出的倍率
	}
]]
function baccarat_manager:resMultiple(msg)
	--add your logic code here
	
end

--[[
	发牌消息
	msg = {
		名称:cardsInfo 类型:List<CardsInfo> 备注:牌信息
		名称:cardIndex 类型:int 备注:牌序(发到第多少张牌了)
		名称:leftNum 类型:int 备注:上一局剩余多少牌 (总共六张,发剩余了多少)
		名称:yellowCard 类型:int 备注:是否发到了黄牌(1是0否)
	}
]]
function baccarat_manager:resDealCards(msg)
	--add your logic code here
	print("发牌消息")
	-- dump(msg)
	dump(msg)
	dump(msg.cardsInfo)
	if msg then
		local game_baccarat = WindowScene.getInstance():getModuleObjByClassName("CBaccaratMainScene")
		if game_baccarat and (game_baccarat.isLoadEnd == true) then
			game_baccarat:sendCardStage(msg)
		end
	end
end

--[[
	其他人进入桌子消息
	msg = {
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
function baccarat_manager:resOtherEnterTable(msg)
	--add your logic code here
	
end

--[[
	返回下注结果消息
	msg = {
		名称:area 类型:int 备注:下注区域  闲家1-11
		名称:chips 类型:long 备注:对应的筹码
	}
]]
function baccarat_manager:resBet(msg)
	--add your logic code here
	print("返回下注结果消息")
	dump(msg)
	if msg ~= nil then
		local game_baccarat = WindowScene.getInstance():getModuleObjByClassName("CBaccaratMainScene")
		if game_baccarat and (game_baccarat.isLoadEnd == true) then
			if self.totalBetChipsMap[msg.area] == nil then
				self.totalBetChipsMap[msg.area] = msg.chips
			else
				self.totalBetChipsMap[msg.area] = long_plus(msg.chips, self.totalBetChipsMap[msg.area])
			end
			if self.curBetChipsMap[msg.area] == nil then
				self.curBetChipsMap[msg.area] = msg.chips
			else
				self.curBetChipsMap[msg.area] = long_plus(msg.chips, self.curBetChipsMap[msg.area])
			end
			game_baccarat:addChipsToPanel(msg.area+1,msg.chips)
			game_baccarat:updateTotalBetChips()
			game_baccarat:updatePlayerBetChips()
		end
	end
end

--[[
	桌子筹码变化消息
	msg = {
		名称:betInfo 类型:List<BetInfo> 备注:桌上筹码信息
	}
]]
function baccarat_manager:resTableBet(msg)
	--add your logic code here
	print("桌子筹码变化消息")
	if (msg.betInfo ~= nil) and (baccarat_manager._state == 1) then
		local game_baccarat = WindowScene.getInstance():getModuleObjByClassName("CBaccaratMainScene")
		if game_baccarat and (game_baccarat.isLoadEnd == true) then
			if table.nums(msg.betInfo) > 0 then
				for k,v in pairs(msg.betInfo) do
					self.totalBetChipsMap[v.area] = v.chips
				end
			else
				self.totalBetChipsMap = {}
				self.curBetChipsMap = {} 
				
			end
			game_baccarat:updateTotalBetChips()
			game_baccarat:updatePlayerBetChips()
		end
	end
end

--[[
	结果统计信息消息
	msg = {
		名称:bankerWin 类型:int 备注:庄赢
		名称:playerWin 类型:int 备注:闲赢
		名称:tie 类型:int 备注:和
		名称:bankerPaire 类型:int 备注:庄对
		名称:playerPaire 类型:int 备注:闲对
		名称:dragon 类型:int 备注:龙
		名称:tiger 类型:int 备注:虎
		名称:dragonTigerTie 类型:int 备注:龙虎和
		名称:score 类型:int 备注:总局数
	}
]]
function baccarat_manager:resBankerInfo(msg)
	--add your logic code here
	print("庄家信息消息")
	dump(msg)
	if msg.score then
		baccarat_manager.statisticsData =  msg
		local game_baccarat = WindowScene.getInstance():getModuleObjByClassName("CBaccaratMainScene")
		if game_baccarat and (game_baccarat.isLoadEnd == true) and (baccarat_manager._state ~= 2)then
			game_baccarat:updateNumberOfGames()
			game_baccarat.alone_ui:updateStatistics()
		end
	end
end

--[[
	通知客户端计时消息
	msg = {
		名称:state 类型:int 备注:告知客户端游戏进行到的阶段
		名称:time 类型:int 备注:计时时间(单位秒)
	}
]]
function baccarat_manager:resTime(msg)
	dump(msg)
	if msg then
		baccarat_manager._state = msg.state
		baccarat_manager._countdown = msg.time
		local game_baccarat = WindowScene.getInstance():getModuleObjByClassName("CBaccaratMainScene")
		if game_baccarat and game_baccarat.isLoadEnd == true then
			game_baccarat:resetGame()
		end
	end
end

--[[
	历史路单记录消息
	msg = {
		名称:hisWaybill 类型:List<int> 备注:历史路单记录
		名称:hisDragon 类型:List<int> 备注:历史龙虎记录
		名称:hisBigSmall 类型:List<int> 备注:历史大小记录
	}
]]
function baccarat_manager:resHistory(msg)
	--add your logic code here
	print("历史路单记录消息")
	-- dump(msg)
	if msg then
		baccarat_manager.alone = msg
		local game_baccarat = WindowScene.getInstance():getModuleObjByClassName("CBaccaratMainScene")
		if game_baccarat and (game_baccarat.isLoadEnd == true) and (baccarat_manager._state ~= 2) then
			game_baccarat.alone_ui:showCurSelect()
		end
	end
end

--[[
	返回结算结果消息
	msg = {
		名称:bankerChips 类型:long 备注:庄家结算筹码
		名称:playerChips 类型:long 备注:玩家结算筹码
	}
]]
function baccarat_manager:resBalance(msg)
	--add your logic code here
	print("返回结算结果消息")
	dump(msg)
	if msg.playerChips ~= nil then
		baccarat_manager.chipsChange = msg.playerChips
	end
end

--[[
	开出的结果消息
	msg = {
		名称:result 类型:List<int> 备注:开出结果列表
	}
]]
function baccarat_manager:resResult(msg)
	print("开出的结果消息")
	dump(msg.result)
	if msg.result then
		baccarat_manager.result = msg.result
		table.sort(baccarat_manager.result,function (a,b)
			return a < b
		end)
		-- local game_baccarat = WindowScene.getInstance():getModuleObjByClassName("CBaccaratMainScene")
		-- if game_baccarat and game_baccarat.isLoadEnd == true then
		-- 	game_baccarat:playResultEffect(msg.result)
		-- end
	end
end

--[[
	清空下注结果消息
	msg = {
		名称:res 类型:int 备注:结果(0:成功,1:下注阶段不能清除下注)
	}
]]
function baccarat_manager:resClearBet(msg)
	--add your logic code here
	if msg.res == 0 then
		local game_baccarat = WindowScene.getInstance():getModuleObjByClassName("CBaccaratMainScene")
		if game_baccarat and (game_baccarat.isLoadEnd == true) then
			game_baccarat:cleanCurBetChips()
		end
	else
		print("下注阶段不能清除下注")
	end
end

--[[
	切牌信息(切出来的12张牌)消息
	msg = {
		名称:cardsInfo 类型:List<int> 备注:牌信息
	}
]]
function baccarat_manager:resCutCards(msg)
	--add your logic code here
	if msg.cardsInfo then
		dump(msg.cardsInfo)
		baccarat_manager.cutCardList = msg.cardsInfo
	end
end

--传输对象说明
--[[
	BetInfo = {
		area, --下注区域
		chips, --下注筹码
	}
]]
--[[
	IconMultiple = {
		areaId, --图标ID
		rate, --图标倍率(客户端缩小100倍后显示)
	}
]]
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
		status, --状态(空闲,普通,拥挤,爆满)
		displayNames, --展示的属性名称
		placeHolder, --展示的属性名称占位符
	}
]]
--[[
	BillInfo = {
		order, --座位顺序
		chips, --结算筹码
	}
]]
--[[
	CardsInfo = {
		cards, --庄家闲家牌
		id, --0庄家，1闲家
		cardsType, --牌型
	}
]]


