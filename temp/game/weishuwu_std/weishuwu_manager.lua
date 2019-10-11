 --[[
	魏蜀吴管理类
]]

weishuwu_manager = {}

--玩家筹码
weishuwu_manager._ownChips = "0"
weishuwu_manager._seatsMap = {}

--庄家信息
weishuwu_manager._bankerInfo={}
--游戏状态:1休息,2下注，3开牌
weishuwu_manager._state = nil
--倒计时
weishuwu_manager._countdown = 0
--当前选择筹码小图标
weishuwu_manager._selectChipsType = nil
--所有下注的筹码
weishuwu_manager.totalBetChipsMap = {}
--所有下注的筹码信息
weishuwu_manager.totalBetChipsInfo = {}

--当前玩家下注的筹码
weishuwu_manager.curBetChipsMap = {}
--用于记录当前玩家在每个区域下注的用于续押的总筹码数
weishuwu_manager._continueChips = nil
--申请坐庄排队列表
weishuwu_manager._applyListData = {}
--筹码数值
weishuwu_manager._chipsValueList = {1,10,100,1000,10000,100000,1000000,10000000}
--开奖结果
weishuwu_manager.result = nil
--玩家筹码变化
weishuwu_manager.chipsChange = "0"
--玩家成绩
weishuwu_manager.score = "0"
--切牌列表
weishuwu_manager.cutCardList = nil
--统计数据
weishuwu_manager.statisticsData = {}
--路单
weishuwu_manager.alone = nil
--路单是否显示
weishuwu_manager.alonePanel = false
--记录
weishuwu_manager._record = {}
--是否是首次进入游戏
weishuwu_manager._bFirstEnter = true

--初始化座位信息
function weishuwu_manager.saveSeatInfos(members)
	weishuwu_manager._seatsMap = {}
	for k,v in pairs(members) do
		weishuwu_manager._seatsMap[v.order] = v

		if player_is_myself(v.playerId) then
			weishuwu_manager._mySeatOrder = v.order
		end
	end
end

--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function weishuwu_manager:resEnterGameHall(msg)
	-- dump(msg)
	local _playerInfo = get_player_info()
	_playerInfo.myRoomTypeInfo = msg.roomTypes
	_playerInfo.curGameID = 20
	_playerInfo.curGameDeskClassName = "CWeishuwuDesk"
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
function weishuwu_manager:resChipsChange(msg)
	-- print("玩家筹码变化消息消息")
	-- dump(msg)
	if msg.playerId == get_player_info().id then
		local game_weishuwu = WindowScene.getInstance():getModuleObjByClassName("CWeishuwuMainScene")
		if game_weishuwu and (game_weishuwu.isLoadEnd == true) then
			self._ownChips = msg.chips
			if weishuwu_manager._state ~= 3 then
				game_weishuwu:updateChips()
			end
		end
	end
	HallManager._members[msg.playerId].chips = msg.chips
end

--[[
	玩家准备消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
function weishuwu_manager:resReady(msg)
	print("玩家准备消息")
	if msg.res == 0 then
		local game_weishuwu = WindowScene.getInstance():getModuleObjByClassName("CWeishuwuMainScene")
		if game_weishuwu and game_weishuwu.isLoadEnd == true then
			game_weishuwu:setPlayerReady(msg.order)
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
function weishuwu_manager:resExchangeTable(msg)
	--add your logic code here
	print("请求交换桌子消息")
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
function weishuwu_manager:resFastEnterTable(msg)
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
function weishuwu_manager:resEnterRoom(msg)
	HallManager:resEnterRoomMsg(msg)
end

--[[
	进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
function weishuwu_manager:resEnterTable(msg)
	-- dump(msg)
	-- dump(get_player_info().tableId)
	print("进入牌桌结果消息>>>>>>")
	local members = msg.mems
    local _playerInfo = get_player_info()
    _playerInfo.myTableId = members[1].tableId
    weishuwu_manager._ownChips="0"
	weishuwu_manager.saveSeatInfos(members)
	WindowScene.getInstance():replaceModuleByModuleName("weishuwu_std")
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CWeishuwuMainScene")
	if game_ui then
		game_ui:init_after()
	end

	HallManager:enterTableHandler(msg)
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
function weishuwu_manager:resExitRoom(msg)
	--add your logic code here
	
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
function weishuwu_manager:resExitTable(msg)
	dump(msg)
	-- dump(get_player_info)
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
	发牌消息
	msg = {
		名称:cardsInfo 类型:List<CardsInfo> 备注:牌信息
	}
]]
function weishuwu_manager:resDealCards(msg)
	--add your logic code here
	-- print("发牌消息")
	-- dump(msg)
	-- dump(msg.cardsInfo)
	if msg then
		-- weishuwu_manager._cardInfo = msg.cardsInfo
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CWeishuwuMainScene")
		if game_ui and (game_ui.isLoadEnd == true) then
			game_ui:sendCardStage(msg)
		end
	end
end

--[[
	其他人进入桌子消息
	msg = {
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
function weishuwu_manager:resOtherEnterTable(msg)
	print("其他人进入桌子消息>>>>>>>")
	--add your logic code here
	local member = msg.mem
	dump(member)
	self._seatsMap[member.order] = member
	HallManager._members[member.playerId] = member
end

--[[
	返回下注结果消息
	msg = {
		名称:area 类型:int 备注:下注区域  闲家0-8
		名称:chips 类型:long 备注:对应的筹码
	}
]]
function weishuwu_manager:resBet(msg)
	--add your logic code here
	-- print("返回下注结果消息")
	-- dump(msg)
	if msg ~= nil then
		local game_weishuwu = WindowScene.getInstance():getModuleObjByClassName("CWeishuwuMainScene")
		if game_weishuwu and (game_weishuwu.isLoadEnd == true) then
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
			game_weishuwu:addChipsToPanel(msg.area+1,msg.chips,1)
			game_weishuwu:updateTotalBetChips()
			game_weishuwu:updatePlayerBetChips()
		end
	end
end

--[[
	桌子筹码变化消息
	msg = {
		名称:betInfo 类型:List<BetInfo> 备注:桌上筹码信息
	}
]]
function weishuwu_manager:resTableBet(msg)
	-- dump(msg)
	--add your logic code here
	print("桌子筹码变化消息")
	weishuwu_manager.totalBetChipsInfo = msg.betInfo
	if (msg.betInfo ~= nil) and (weishuwu_manager._state == 2) then
		local game_weishuwu = WindowScene.getInstance():getModuleObjByClassName("CWeishuwuMainScene")
		if game_weishuwu and game_weishuwu.isLoadEnd == true then
			if table.nums(msg.betInfo) > 0 then
				for k,v in pairs(msg.betInfo) do
					if self.totalBetChipsMap[v.area] == nil then
						self.totalBetChipsMap[v.area] = v.chips
						game_weishuwu:addChipsToPanel(v.area+1,v.chips,0)
					else
						local addBetChips = long_minus(v.chips,self.totalBetChipsMap[v.area])
						self.totalBetChipsMap[v.area] = v.chips
						if long_compare(addBetChips,0) > 0 then
							game_weishuwu:addChipsToPanel(v.area+1,addBetChips,0)
						end
					end
				end
			else
				self.totalBetChipsMap = {}
				self.curBetChipsMap = {} 				
			end
			game_weishuwu:updateTotalBetChips()
			game_weishuwu:updatePlayerBetChips()
		end
	end
end

--[[
	玩家申请庄家列表消息
	msg = {
		名称:applicants 类型:List<long> 备注:申请人
	}
]]
function weishuwu_manager:resApplyBankers(msg)
	-- print("申请庄家列表消息")
	dump(msg.applicants)
	if msg.applicants then
		weishuwu_manager._applyListData = msg.applicants
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CWeishuwuMainScene")
		if game_ui and game_ui.isLoadEnd == true then
			game_ui:updateApplyListInfo()
		end
	end
end
--[[
	庄家信息消息
	msg = {
		名称:playerId 类型:long 备注:庄家id
		名称:name 类型:String 备注:昵称
		名称:sex 类型:int 备注:性别 0男1女3系统
		名称:chips 类型:long 备注:筹码
		名称:num 类型:int 备注:局数
		名称:score 类型:long 备注:成绩
	}
]]
function weishuwu_manager:resBankerInfo(msg)
	--add your logic code here
	print("庄家信息消息")
	-- dump(msg)	
	if msg then
		if (long_compare(msg.playerId,0) ~= 0) and (long_compare(weishuwu_manager._bankerInfo.playerId, msg.playerId) ~= 0) then
			if weishuwu_manager._bFirstEnter ~= true then
				local member = HallManager._members[msg.playerId]
				dump(member)
				-- audio_manager:playPlayerSound(math.random(2,4), member.sex)
			end
		end
		weishuwu_manager._bankerInfo = msg
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CWeishuwuMainScene")
		if game_ui and game_ui.isLoadEnd == true then
			game_ui:updateApplyListInfo()
			if weishuwu_manager._state ~= 3 then
				game_ui:updateBankerInfo()
			end
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
function weishuwu_manager:resTime(msg)
	print("通知客户端计时消息")
	-- dump(msg)
	if msg then
		weishuwu_manager._state = msg.state
		weishuwu_manager._countdown = msg.time
		local game_weishuwu = WindowScene.getInstance():getModuleObjByClassName("CWeishuwuMainScene")
		if game_weishuwu and game_weishuwu.isLoadEnd == true then
			game_weishuwu:resetGame()
		end
	end
end

--[[
	历史记录消息
	msg = {
		名称:win 类型:List<int> 备注:吴蜀魏输赢记录
		名称:waybill 类型:List<int> 备注:路单记录
		名称:hero 类型:List<int> 备注:蜀虎将吴都督记录
	}
]]
function weishuwu_manager:resHistory(msg)
	--add your logic code here
	print("历史路单记录消息")
	-- dump(msg.waybill)
	-- dump(msg.hero)
	if msg then
		weishuwu_manager.alone = msg
		weishuwu_manager._record = msg.win
		local game_weishuwu = WindowScene.getInstance():getModuleObjByClassName("CWeishuwuMainScene")
		if game_weishuwu and (game_weishuwu.isLoadEnd == true) and (weishuwu_manager._state ~= 3) then
			print("发送历史路单记录消息")
			game_weishuwu:updateRecord(msg.win)
			game_weishuwu.alone_ui:updateAlone(weishuwu_manager.alone)	
			game_weishuwu.alone_ui:updateHero(weishuwu_manager.alone)
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
function weishuwu_manager:resBalance(msg)
	--add your logic code here
	print("返回结算结果消息")
	dump(msg)
	if msg.playerChips ~= nil then
		weishuwu_manager.chipsChange = msg.playerChips
	end
end

--[[
	开出的结果消息
	msg = {
		名称:result 类型:List<int> 备注:开出结果列表
	}
]]
function weishuwu_manager:resResult(msg)
	print("开出的结果消息")
	dump(msg.result)
	if msg.result then
		weishuwu_manager.result = msg.result
		table.sort(weishuwu_manager.result,function (a,b)
			return a < b
		end)
		-- local game_weishuwu = WindowScene.getInstance():getModuleObjByClassName("CWeishuwuMainScene")
		-- if game_weishuwu and game_weishuwu.isLoadEnd == true then
		-- 	game_weishuwu:playResultEffect(msg.result)
		-- end
	end
end

--[[
	清空下注结果消息
	msg = {
		名称:res 类型:int 备注:结果(0:成功,1:下注阶段不能清除下注)
	}
]]
function weishuwu_manager:resClearBet(msg)
	--add your logic code here
	if msg.res == 0 then
		local game_weishuwu = WindowScene.getInstance():getModuleObjByClassName("CWeishuwuMainScene")
		if game_weishuwu and (game_weishuwu.isLoadEnd == true) then
			game_weishuwu:cleanCurBetChips()
		end
	else
		print("下注阶段不能清除下注")
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
		cards, --玩家的牌
		id, --0-4 :0庄家的牌，1:闲家1
		cardsType, --牌型(0非对子,1对子)
	}
]]


