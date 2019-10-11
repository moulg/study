--[[
百人牛牛管理类
]]

bairenniuniu_manager = {}

--我自己的座位id
bairenniuniu_manager._mySeatOrder = nil
--拥有筹码
bairenniuniu_manager._ownChips = "0"

bairenniuniu_manager._seatsMap = {}

--出牌信息
bairenniuniu_manager.showDownMsgMap = {}

--是否自动准备
bairenniuniu_manager.isAutoReady = false

--庄家信息
bairenniuniu_manager._bankerInfo = {}
--游戏状态: 1.休息 2.下注 3.开奖 4.结算
bairenniuniu_manager._state = 1
--倒计时时间
bairenniuniu_manager._countdown = 10
--筹码数值
bairenniuniu_manager._chipsValueList = {10000000,1000000,100000,10000,1000,100,10,1}
--当前选择筹码小图标
bairenniuniu_manager._selectChipsType = nil
--所有下注的筹码
bairenniuniu_manager.totalBetChipsMap = {}
--所有下注的筹码信息
bairenniuniu_manager.totalBetChipsInfo = {}
--当前玩家下注的筹码
bairenniuniu_manager.curBetChipsMap = {}
--庄家筹码的变化
bairenniuniu_manager._bankerChipschanges = 0
--玩家筹码变化
bairenniuniu_manager._playerChipschanges = 0
--用于记录当前玩家在每个区域下注的用于续押的总筹码数
bairenniuniu_manager._continueChips = nil
--申请坐庄排队列表
bairenniuniu_manager._applyListData = {}
--坐庄要求最少拥有筹码数
bairenniuniu_manager._requireChipsNum = 10000000
--成绩
bairenniuniu_manager._playerScore = 0 
--记录
bairenniuniu_manager._record = {}
--是否可下注
bairenniuniu_manager._bCanBet = true
--是否是首次进入游戏
bairenniuniu_manager._bFirstEnter = true
--每个区域下注的每种类型筹码个数
bairenniuniu_manager._numberList = {[1] = {0,0,0,0,0,0,0,0},
								    [2] = {0,0,0,0,0,0,0,0},
								    [3] = {0,0,0,0,0,0,0,0},
								    [4] = {0,0,0,0,0,0,0,0},
								}

local binTable = {{0,0,0,0},{0,0,0,1},{0,0,1,0},{0,0,1,1},{0,1,0,0},{0,1,0,1},{0,1,1,0},{0,1,1,1},
				  {1,0,0,0},{1,0,0,1},{1,0,1,0},{1,0,1,1},{1,1,0,0},{1,1,0,1},{1,1,1,0},{1,1,1,1},}

--初始化座位信息
function bairenniuniu_manager.saveSeatInfos(members)
	bairenniuniu_manager._seatsMap = {}
	for k,v in pairs(members) do
		bairenniuniu_manager._seatsMap[v.order] = v

		if player_is_myself(v.playerId) then
			bairenniuniu_manager._mySeatOrder = v.order
		end
	end
end


--准备状态重置
function bairenniuniu_manager:resetReadyState()
	for i,v in pairs(self._seatsMap) do
		v.state = 1
	end
end

--将十进制转化为二进制表, 返回的一个表结构
function bairenniuniu_manager:convertToBinTable(num)
	return binTable[num+1] 
end

-- 十进制转二进制, 返回的一个表结构
function bairenniuniu_manager:decimalismToBinary(_dec)
	if _dec ~= nil then
		local tmpBin = {}
		while _dec >= 2 do
			tmpBin[#tmpBin+1] = _dec%2
			_dec = math.floor(_dec/2)
		end
		if _dec > 0 then
			tmpBin[#tmpBin+1] = _dec
			
		end
		return tmpBin
	else
		print("******************\n bairenniuniu_manager:decimalismToBinary传参异常！！！！！\n******************")
	end
end


----------------------------------------------------------------房间座位消息

--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function bairenniuniu_manager:resEnterGameHallMsg(msg)
	local _playerInfo = get_player_info()
	_playerInfo.myRoomTypeInfo = msg.roomTypes

	_playerInfo.curGameID = 7
	_playerInfo.curGameDeskClassName = "CBaiRenNiuNiuDesk"

	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
end



--[[
	进入牌桌结果消息
	msg = {
		名称:players 类型:List<long> 备注:牌桌中的玩家
	}
]]
function bairenniuniu_manager.resEnterTableMsg(msg)
	-- local members = HallManager:getMemberInfos(msg)
	local members = msg.mems
    local _playerInfo = get_player_info()
    _playerInfo.myTableId = members[1].tableId

	bairenniuniu_manager._ownChips = "0"
	bairenniuniu_manager.saveSeatInfos(members)

	WindowScene.getInstance():replaceModuleByModuleName("bairenniuniu_std")
	-- local game_ui = WindowScene.getInstance():getModuleObjByClassName("CBaiRenNiuNiuMainScene")
	-- if game_ui then
	-- 	game_ui:init_after_enter()
	-- end
	HallManager:enterTableHandler(msg)
end

--[[
	通知其他玩家我进入房间的消息
	msg = {
		名称:playerId 类型:long 备注:进入桌子的其他玩家
	}
]]
function bairenniuniu_manager:resOtherPlayerEnterTableMgs(msg)
	-- local member = HallManager._members[msg.playerId]
	local member = msg.mem
	-- HallManager:informPlayerEnterGame(member.playerName)

	self._seatsMap[member.order] = member
	HallManager._members[member.playerId] = member	
end


--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
function bairenniuniu_manager:resExitTableMsg(msg)
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
	    -- self._seatsMap = {}
	    -- self._mySeatOrder = nil
	-- else
		-- local game_ui = WindowScene.getInstance():getModuleObjByClassName("CBaiRenNiuNiuMainScene")
		-- if game_ui then
		-- 	-- game_ui:removePlayer(msg.order)

		-- 	if game_ui._gameStep == game_ui.GAME_STEP.CALL_STEP or game_ui._gameStep == game_ui.GAME_STEP.BET_STEP then
		-- 		game_ui:resetGameData()
		-- 		game_ui:enterReadyStage()
		-- 	end
		-- end

		-- local name = self._seatsMap[msg.order].playerName
		-- HallManager:informPlayerExitGame(name)

  --       self._seatsMap[msg.order] = nil
	end
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家ID
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
function bairenniuniu_manager:resChipsChangeMsg(msg)	
	if msg.playerId == get_player_info().id then
		-- dump(get_player_info())
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CBaiRenNiuNiuMainScene")
		if game_ui.isLoadEnd then
			self._ownChips = msg.chips
			if bairenniuniu_manager._state ~= 3 then
				game_ui:updateChips()
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
function bairenniuniu_manager:resReadyMsg(msg)
	if msg.res == 0 then
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CBaiRenNiuNiuMainScene")
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
	发牌消息
	msg = {
		名称:cardsInfo 类型:List<CardsInfo> 备注:牌信息
		CardsInfo = {
			cards, --玩家的牌，已经是最优牌型(3+2)
			id, --0-4 :0庄家的牌，1:闲家1，2:闲家2，3:闲家3，4:闲家4
			cardsType, --牌型(0:没牛，1-10:牛1到牛牛,四花:11,四炸:12,五花:13,五小:14)
		}
	}
]]
function bairenniuniu_manager:resDealCardsMsg(msg)
	print("发牌消息")
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CBaiRenNiuNiuMainScene")
	if game_ui.isLoadEnd then
		--发牌音效
		audio_manager:playOtherSound(1, false)
		
		table.sort(msg.cardsInfo, function (a, b)
			if a.id < b.id then
				return true
			else
				return false
			end
		end )
		 dump(msg.cardsInfo)
		game_ui:sendCardsStage(msg.cardsInfo)
	end
end

--[[
	桌子筹码变化消息
	msg = {
		名称:betInfo 类型:List<BetInfo> 备注:桌上筹码信息
	}
]]
function bairenniuniu_manager:resTableBet(msg)
	-- print("桌子筹码变化消息")
	-- dump(msg.betInfo)
	bairenniuniu_manager.totalBetChipsInfo = msg.betInfo
	if msg.betInfo ~= nil then
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CBaiRenNiuNiuMainScene")
		if game_ui.isLoadEnd then
			if table.nums(msg.betInfo) > 0 then
				for k,v in pairs(msg.betInfo) do
					if self.totalBetChipsMap[v.area] == nil then
						self.totalBetChipsMap[v.area] = v.chips
						game_ui:addBetChips(v.area,v.chips,0)
					else
						local addBetChips = long_minus(v.chips,self.totalBetChipsMap[v.area])
						self.totalBetChipsMap[v.area] = v.chips
						if long_compare(addBetChips,0) > 0 then
							game_ui:addBetChips(v.area,addBetChips,0)
						end
					end
				end
			else
				self.totalBetChipsMap = {}
				self.curBetChipsMap = {} 
				
			end
			game_ui:updateTotalBetChips()
			game_ui:updatePlayerBetChips()
		end
	end
end

--[[
	返回下注结果消息
	msg = {
		名称:area 类型:int 备注:下注区域  闲家1-4
		名称:chips 类型:long 备注:对应的筹码
	}
]]
function bairenniuniu_manager:resBet(msg)
	print("返回下注结果信息")
	-- dump(msg)
	--恢复下注
	-- bairenniuniu_manager._bCanBet = true
	if msg ~= nil then
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CBaiRenNiuNiuMainScene")
		if game_ui.isLoadEnd then
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
			game_ui:addBetChips(msg.area,msg.chips,1)
			game_ui:updateTotalBetChips()
			game_ui:updatePlayerBetChips()
			game_ui:updateChips()
		end
	end
end

--[[
	玩家申请庄家列表消息
	msg = {
		名称:applicants 类型:List<long> 备注:申请人
	}
]]
function bairenniuniu_manager:resApplyBankers(msg)
	-- print("申请庄家列表消息")
	-- dump(msg)
	if msg.applicants then
		bairenniuniu_manager._applyListData = msg.applicants
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CBaiRenNiuNiuMainScene")
		if game_ui.isLoadEnd then
			game_ui.applyListPanel:updateApplyListInfo()
		end
	end
end

--[[
	庄家信息消息
	msg = { 
		名称:playerId 类型:long 备注:庄家id
		名称:name 类型:String 备注:昵称
		名称:chips 类型:long 备注:筹码
		名称:num 类型:int 备注:局数
		名称:score 类型:long 备注:成绩
	}
]]
function bairenniuniu_manager:resBankerInfo(msg)
	print("庄家信息消息")
	dump(msg)
	if msg then
		if (long_compare(msg.playerId,0) ~= 0) and (long_compare(bairenniuniu_manager._bankerInfo.playerId, msg.playerId) ~= 0) then
			if bairenniuniu_manager._bFirstEnter ~= true then
				audio_manager:playPlayerSound(math.random(2,4), msg.sex)
			end
		end
		bairenniuniu_manager._bankerInfo = msg
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CBaiRenNiuNiuMainScene")
		if game_ui.isLoadEnd then
			game_ui.applyListPanel:updateApplyListInfo()
			if bairenniuniu_manager._state ~= 3 then
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
function bairenniuniu_manager:resTime(msg)
	if msg ~= nil then
		print("通知客户端计时消息")
		-- dump(msg.state)
		bairenniuniu_manager._state = msg.state
		bairenniuniu_manager._countdown = msg.time
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CBaiRenNiuNiuMainScene")
		if game_ui.isLoadEnd == true then
			game_ui:resetGame()
		end
	end
end

--[[
	历史输赢记录消息
	msg = {
		名称:result 类型:List<int> 备注:闲家对庄家的输赢记录
	}
]]
function bairenniuniu_manager:resHistory(msg)
	-- print("历史输赢记录消息")
	-- dump(msg.result)
	if msg.result then
		if table.nums(bairenniuniu_manager._record) == 0 then
			local game_ui = WindowScene.getInstance():getModuleObjByClassName("CBaiRenNiuNiuMainScene")
			if game_ui then
				-- game_ui:updateRecord(msg.result)
			end
		end
		bairenniuniu_manager._record = msg.result
	end
end

--[[
	返回结算结果消息
	msg = {
		名称:bankerChips 类型:long 备注:庄家结算筹码
		名称:playerChips 类型:long 备注:玩家结算筹码
	}
]]
function bairenniuniu_manager:resBalance(msg)
	print("结算结果消息")
	if msg then
		bairenniuniu_manager._bankerChipschanges = msg.bankerChips
		bairenniuniu_manager._playerChipschanges = msg.playerChips
		-- local game_ui = WindowScene.getInstance():getModuleObjByClassName("CBaiRenNiuNiuMainScene")
		-- if game_ui then
		-- 	game_ui:addSettleAccountsPanel()
		-- end
	end
end

--[[
	清空下注结果消息
	msg = {
		名称:res 类型:int 备注:结果(0:成功,1:下注阶段不能清除下注)
	}
]]
function bairenniuniu_manager:resClearBet(msg)
	-- print("清空下注结果消息")
	-- dump(msg)
	if msg.res == 0 then
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CBaiRenNiuNiuMainScene")
		if game_ui.isLoadEnd then
			game_ui:cleanCurBetChips()
		end
	end
end