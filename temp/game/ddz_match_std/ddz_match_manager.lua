ddz_match_manager = {}

ddz_match_manager._mySeatOrder = nil

ddz_match_manager._selectCards = {}

ddz_match_manager._tmpSelectEnabled = false
ddz_match_manager._tmpSelectCards = {list = {}, map = {}}

--上家出牌的类型
ddz_match_manager._forwardCardsType = nil

function ddz_match_manager._tmpSelectCards:clear()
	self.list = {}
	self.map = {}
end

function ddz_match_manager._tmpSelectCards:addItem( item )
	if self.map[item.id] == nil then
		table.insert(self.list, item)
		self.map[item.id] = item
	end
end

function ddz_match_manager._tmpSelectCards:removeItem( item )
	for i,v in ipairs(self.list) do
		if v.id == item.id then
			table.remove(self.list, i)
			break
		end
	end
	self.map[item.id] = nil
end

--检测鼠标碰撞
function ddz_match_manager:checkIsContainButton( point )
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		return game_ui:checkIsContainButton(point)
	end
end

--获取提示牌
function ddz_match_manager._tmpSelectCards:getTipsCards()
	if #self.list <= 5 then
		return self.list
	end

	local powerMap = {}
	local powerList = {}
	local power = 0
	for i,card in ipairs(self.list) do
		power = ddzMatch_card_data[card.id].power
		if powerMap[power] == nil then
			powerMap[power] = {}
            table.insert(powerList, power)
		end
		table.insert(powerMap[power], card.id)
	end

	table.sort(powerList)

	local isThree = true
	local isDouble = true
	for i,power in ipairs(powerList) do
		if #powerMap[power] ~= 3 then
			isThree = false
        end

		if #powerMap[power] ~= 2 then
			isDouble = false
		end
	end

	if isDouble or isThree then
		if powerList[#powerList] - powerList[1] == #powerList - 1 then
			return self.list
		end
	end

	local cardsList = {}
	local function findOutShunZi(beginPower, endPower)
		local cardArr = {}
		for p = beginPower, endPower do
			if powerMap[p] and p < 15 then
				local cardItem = self.map[ powerMap[p][1] ]
				table.insert(cardArr, cardItem)
			else
				if #cardArr >= 5 then
					table.insert(cardsList, cardArr)
				end
				return findOutShunZi(p+1, endPower)
			end
		end

        if #cardArr >= 5 then
			table.insert(cardsList, cardArr)
		end
	end

	findOutShunZi(powerList[1], powerList[#powerList])
	
	if #cardsList >= 1 then
		table.sort( cardsList, function ( arr1, arr2 )
			if #arr1 > #arr2 then
				return true
			elseif #arr1 < #arr2 then
				return false
			else
				if arr1[1] < arr2[1] then
					return true
				else
					return false
				end
			end
		end )

		return cardsList[1]
	else
		return self.list
	end
end

function ddz_match_manager:setOutCardButtonState()
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui:setOutCardButtonState()
	end
end

--检测牌型
function ddz_match_manager:checkCardsType(idList)
	local funcArr = {self.checkCardsIsSingleCard, self.checkCardsIsDuiZi, self.checkCardsIsSanBuDai, self.checkCardsIsSanDaiDan,
					 self.checkCardsIsSanDaiDui, self.checkCardsIsDanShun, self.checkCardsIsShuangShun, self.checkCardsIsSanShun,
					 self.checkCardsIsFeiJiDaiDan, self.checkCardsIsFeiJiDaiDui, self.checkCardsIsZhaDan, self.checkCardsIsWangZha,
					 self.checkCardsIsSiDaiDan, self.checkCardsIsSiDaiDui,}
	for i,func in ipairs(funcArr) do
		local isLawful, power = func(self, idList)
		if isLawful then
			return power
		end
	end

	return nil
end

--检测牌型是否合法
function ddz_match_manager:checkCardsTypeIsLawful()
	local funcArr = {self.checkCardsIsSingleCard, self.checkCardsIsDuiZi, self.checkCardsIsSanBuDai, self.checkCardsIsSanDaiDan,
					 self.checkCardsIsSanDaiDui, self.checkCardsIsDanShun, self.checkCardsIsShuangShun, self.checkCardsIsSanShun,
					 self.checkCardsIsFeiJiDaiDan, self.checkCardsIsFeiJiDaiDui, self.checkCardsIsZhaDan, self.checkCardsIsWangZha,
					 self.checkCardsIsSiDaiDan, self.checkCardsIsSiDaiDui,}

	for i,func in ipairs(funcArr) do
		local isLawful = func(self, self._selectCards)
		if isLawful then
			return true
		end
	end

	return false
end

--检测牌型是否大于上家
function ddz_match_manager:checkCardsTypePowerThenForward(forwardCards)
	local funcArr = {self.checkCardsIsSingleCard, self.checkCardsIsDuiZi, self.checkCardsIsSanBuDai, self.checkCardsIsSanDaiDan,
					 self.checkCardsIsSanDaiDui, self.checkCardsIsDanShun, self.checkCardsIsShuangShun, self.checkCardsIsSanShun,
					 self.checkCardsIsFeiJiDaiDan, self.checkCardsIsFeiJiDaiDui, self.checkCardsIsZhaDan, self.checkCardsIsWangZha,
					 self.checkCardsIsSiDaiDan, self.checkCardsIsSiDaiDui,}
    if self._forwardCardsType == nil or funcArr[self._forwardCardsType] == nil then
        return
    end
	local isLawful1, power1 = funcArr[self._forwardCardsType](self, forwardCards)
	local isLawful2, power2 = funcArr[self._forwardCardsType](self, self._selectCards)
    if isLawful2 == false then
        local newFuncArr = {self.checkCardsIsZhaDan, self.checkCardsIsWangZha}
        for i,func in ipairs(newFuncArr) do
		    isLawful2, power2 = func(self, self._selectCards)
		    if isLawful2 then
			    break
		    end
	    end
    end
	if isLawful2 == true and power2 > power1 then
		return true
	end

	return false
end

--检测是否是单牌
function ddz_match_manager:checkCardsIsSingleCard(cardIds)
	if #cardIds == 1 then
		return true, ddzMatch_card_data[cardIds[1]].power
	else
		return false
	end
end

--检测是否是对子
function ddz_match_manager:checkCardsIsDuiZi(cardIds)
	if #cardIds == 2 then
		local power1 = ddzMatch_card_data[cardIds[1]].power
		local power2 = ddzMatch_card_data[cardIds[2]].power
		if power2 == power1 then
			return true, ddzMatch_card_data[cardIds[1]].power
		else
			return false
		end
	else
		return false
	end
end

--检测是否是 三不带
function ddz_match_manager:checkCardsIsSanBuDai(cardIds)
	if #cardIds == 3 then
		local power1 = ddzMatch_card_data[cardIds[1]].power
		local power2 = ddzMatch_card_data[cardIds[2]].power
		local power3 = ddzMatch_card_data[cardIds[3]].power
		if power2 == power1 and power1 == power3 then
			return true, ddzMatch_card_data[cardIds[1]].power
		else
			return false
		end
	else
		return false
	end
end

--检测是否是 三带单
function ddz_match_manager:checkCardsIsSanDaiDan(cardIds)
	if #cardIds == 4 then
		local powerMap = {}
		local powerArr = {}
		for i,id in ipairs(cardIds) do
			local power = ddzMatch_card_data[id].power
			if powerMap[power] == nil then
				powerMap[power] = {}
				table.insert(powerArr, power)
			end

			table.insert(powerMap[power], id)
		end

		if #powerArr == 2 then
			if #powerMap[powerArr[1]] == 3 then
				local id = powerMap[powerArr[1]][1]
				return true, ddzMatch_card_data[id].power
			elseif #powerMap[powerArr[2]] == 3 then
				local id = powerMap[powerArr[2]][1]
				return true, ddzMatch_card_data[id].power
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

--检测是否是三带对
function ddz_match_manager:checkCardsIsSanDaiDui(cardIds)
	if #cardIds == 5 then
		local powerMap = {}
		local powerArr = {}
		for i,id in ipairs(cardIds) do
			local power = ddzMatch_card_data[id].power
			if powerMap[power] == nil then
				powerMap[power] = {}
				table.insert(powerArr, power)
			end

			table.insert(powerMap[power], id)
		end

		if #powerArr == 2 then
			if #powerMap[powerArr[1]] == 3 then
				local id = powerMap[powerArr[1]][1]
				return true, ddzMatch_card_data[id].power
			elseif #powerMap[powerArr[2]] == 3 then
				local id = powerMap[powerArr[2]][1]
				return true, ddzMatch_card_data[id].power
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

--检测是否是 单顺
function ddz_match_manager:checkCardsIsDanShun(cardIds)
	if #cardIds >= 5 then
		local powerMap = {}
		local powerArr = {}
		for i,id in ipairs(cardIds) do
			local power = ddzMatch_card_data[id].power
			if powerMap[power] == nil then
				powerMap[power] = {}
				table.insert(powerArr, power)
			end

			table.insert(powerMap[power], id)
		end

		--不存在大小王 2
		if #powerArr == #cardIds and powerMap[16] == nil and powerMap[17] == nil and powerMap[15] == nil then
			--power排序
			table.sort(powerArr)
			local maxPower = powerArr[#powerArr]
			local minPower = powerArr[1]

			if maxPower - minPower == #cardIds - 1 then
				local id = powerMap[minPower][1]
				return true, ddzMatch_card_data[id].power
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

--检测是否是双顺
function ddz_match_manager:checkCardsIsShuangShun(cardIds)
	if #cardIds >= 6 then
		local powerMap = {}
		local powerArr = {}
		for i,id in ipairs(cardIds) do
			local power = ddzMatch_card_data[id].power
			if powerMap[power] == nil then
				powerMap[power] = {}
				table.insert(powerArr, power)
			end

			table.insert(powerMap[power], id)
		end

		for k,idArr in pairs(powerMap) do
			if #idArr ~= 2 then
				return false
			end
		end

		--power排序
		table.sort(powerArr)
		local maxPower = powerArr[#powerArr]
		local minPower = powerArr[1]

		if maxPower - minPower == #powerArr - 1 then
			local id = powerMap[minPower][1]
			return true, ddzMatch_card_data[id].power
		else
			return false
		end
	else
		return false
	end
end

--检测是否是 三顺
function ddz_match_manager:checkCardsIsSanShun(cardIds)
	if #cardIds >= 9 then
		local powerMap = {}
		local powerArr = {}
		for i,id in ipairs(cardIds) do
			local power = ddzMatch_card_data[id].power
			if powerMap[power] == nil then
				powerMap[power] = {}
				table.insert(powerArr, power)
			end

			table.insert(powerMap[power], id)
		end

		for k,idArr in pairs(powerMap) do
			if #idArr ~= 3 then
				return false
			end
		end

		--power排序
		table.sort(powerArr)
		local maxPower = powerArr[#powerArr]
		local minPower = powerArr[1]

		if maxPower - minPower == #powerArr - 1 then
			local id = powerMap[minPower][1]
			return true, ddzMatch_card_data[id].power
		else
			return false
		end
	else
		return false
	end
end

--检测是否是飞机带单
function ddz_match_manager:checkCardsIsFeiJiDaiDan(cardIds)
	if #cardIds >= 8 and #cardIds % 4 == 0 then
		local powerMap = {}
		local powerArr = {}
		for i,id in ipairs(cardIds) do
			local power = ddzMatch_card_data[id].power
			if powerMap[power] == nil then
				powerMap[power] = {}
				table.insert(powerArr, power)
			end

			table.insert(powerMap[power], id)
		end

		--power排序
		table.sort(powerArr)
		local length = #cardIds / 4
		--单牌数量
		local singleCardNum = 0
		local isChecked = false
		local recordPower = 0

		for i,power in ipairs(powerArr) do
			if #powerMap[power] == 3 then
				if isChecked == false then
					isChecked = true
					for p = power + 1, power + length - 1 do
						if #powerMap[p] ~= 3 then
							return false
						end
					end

					recordPower = power
				end
			else
				singleCardNum = singleCardNum + #powerMap[power]
			end
		end

		if isChecked and singleCardNum == length then
			local id = powerMap[recordPower][1]
			return true, ddzMatch_card_data[id].power
		else
			return false
		end
	else
		return false
	end
end

--检测是否是飞机带队
function ddz_match_manager:checkCardsIsFeiJiDaiDui(cardIds)
	if #cardIds >= 10 and #cardIds % 5 == 0 then
		local powerMap = {}
		local powerArr = {}
		for i,id in ipairs(cardIds) do
			local power = ddzMatch_card_data[id].power
			if powerMap[power] == nil then
				powerMap[power] = {}
				table.insert(powerArr, power)
			end

			table.insert(powerMap[power], id)
		end

		--power排序
		table.sort(powerArr)
		local length = #cardIds / 5
		--单牌数量
		local doubleCardNum = 0
		local isChecked = false
		local recordPower = 0

		for i,power in ipairs(powerArr) do
			if #powerMap[power] == 3 then
				if isChecked == false then
					isChecked = true
					for p = power + 1, power + length - 1 do
						if #powerMap[p] ~= 3 then
							return false
						end
					end

					recordPower = power
				end
			elseif #powerMap[power] == 2 then
				doubleCardNum = doubleCardNum + 1
			else
				return false
			end
		end

		if isChecked and doubleCardNum == length then
			local id = powerMap[recordPower][1]
			return true, ddzMatch_card_data[id].power
		else
			return false
		end
	else
		return false
	end
end

--检测是否是炸弹
function ddz_match_manager:checkCardsIsZhaDan(cardIds)
	if #cardIds == 4 then
		local power1 = ddzMatch_card_data[cardIds[1]].power
		local power2 = ddzMatch_card_data[cardIds[2]].power
		local power3 = ddzMatch_card_data[cardIds[3]].power
		local power4 = ddzMatch_card_data[cardIds[4]].power
		if power4 == power3 and power3 == power2 and power2 == power1 then
			return true, power1 + 100
		else
			return false
		end
	else
		return false
	end
end

--检测是否是王炸
function ddz_match_manager:checkCardsIsWangZha(cardIds)
	if #cardIds == 2 then
		local power1 = ddzMatch_card_data[cardIds[1]].power
		local power2 = ddzMatch_card_data[cardIds[2]].power

		if power1 == 16 and power2 == 17 then
			return true, 16
		elseif power2 == 16 and power1 == 17 then
			return true, 16 + 100
		else
			return false
		end
	else
		return false
	end
end

--检测是否是四带单
function ddz_match_manager:checkCardsIsSiDaiDan(cardIds)
	if #cardIds == 6 then
		local powerMap = {}
		local powerArr = {}
		for i,id in ipairs(cardIds) do
			local power = ddzMatch_card_data[id].power
			if powerMap[power] == nil then
				powerMap[power] = {}
				table.insert(powerArr, power)
			end

			table.insert(powerMap[power], id)
		end

		--power排序
		table.sort(powerArr)
		--单牌数量
		local singleCardNum = 0
		local isChecked = false
		local recordPower = 0

		for i,power in ipairs(powerArr) do
			if #powerMap[power] == 4 then
				if isChecked == false then
					isChecked = true
					recordPower = power
				end
			else
				singleCardNum = singleCardNum + #powerMap[power]
			end
		end

		if isChecked and singleCardNum == 2 then
			local id = powerMap[recordPower][1]
			return true, ddzMatch_card_data[id].power
		else
			return false
		end
	else
		return false
	end
end

--检测是否是四带队
function ddz_match_manager:checkCardsIsSiDaiDui(cardIds)
	if #cardIds == 8 then
		local powerMap = {}
		local powerArr = {}
		for i,id in ipairs(cardIds) do
			local power = ddzMatch_card_data[id].power
			if powerMap[power] == nil then
				powerMap[power] = {}
				table.insert(powerArr, power)
			end

			table.insert(powerMap[power], id)
		end

		--power排序
		table.sort(powerArr)
		--单牌数量
		local doubleCardNum = 0
		local isChecked = false
		local recordPower = 0

		for i,power in ipairs(powerArr) do
			if #powerMap[power] == 4 then
				if isChecked == false then
					isChecked = true
					recordPower = power
				end
			elseif #powerMap[power] == 2 then
				doubleCardNum = doubleCardNum + 1
			else
				return false
			end
		end

		if isChecked and doubleCardNum == 2 then
			local id = powerMap[recordPower][1]
			return true, ddzMatch_card_data[id].power
		else
			return false
		end
	else
		return false
	end
end



----------------------------------------------------------------房间座位消息

function ddz_match_manager:resEnterGameHallMsg(msg)
	local _playerInfo = get_player_info()
	_playerInfo.myRoomTypeInfo = msg.roomTypes
	_playerInfo.curGameID = 1
	_playerInfo.curGameRoomClassName = "CDdzMatchRoomItem"
	_playerInfo.curGameDeskClassName = "CDdzMatchDesk"

	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		--gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_GAME_ROOM)
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
end

--[[
	返回请求进入房间结果消息
	msg = {
		名称:apply 类型:int 备注:是否报名(0:没有,非0:报过了)
		名称:matchInfo 类型:MatchInfo 备注:比赛信息
		名称:roomId 类型:int 备注:房间id
	}
]]
function ddz_match_manager:resEnterRoomMsg(msg)
	get_player_info().curMatchRoomID = msg.roomId
	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		--gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_GAME_ROOM)
		--gamelobby:updateMatchInfo(msg.matchInfo)
		--gamelobby:matchApplyResult(msg.apply ~= 0)
		HallManager:resEnterRoomMsg(msg)
	end
end

--[[
	返回请求进入房间结果消息
	msg = {
		名称:res 类型:int 备注:结果(0:成功,1:已经报过名不能报名本比赛,2:人数足够已经开赛)
	}
]]
function ddz_match_manager:resMatchApplyMsg(msg)
	if msg.res == 0 then
		local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
		if gamelobby then
			gamelobby:matchApplyResult(true)
		end
	end
end

--取消报名结果
function ddz_match_manager:resCancelMatchApplyMsg(msg)
	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:matchApplyResult(false)
	end
end

--[[
	进入牌桌结果消息
	msg = {
	}
]]
function ddz_match_manager:resEnterTableMsg(msg)
	WindowScene.getInstance():replaceModuleByModuleName("ddz_match_std")
end


--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		
	}
]]
function ddz_match_manager:resExitTableMsg(msg)
	if WindowScene.getInstance():getCurModuleName()  == "game_lobby" then
		return
	end
	WindowScene.getInstance():replaceModuleByModuleName("game_lobby")

	--切界面
	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_FIRST_HALL)
	end

    ddz_match_manager._mySeatOrder = nil
end

--[[
	房间比赛信息更新消息
	msg = {
		名称:roomId 类型:int 备注:房间id
		名称:matchInfo 类型:MatchInfo 备注:比赛信息
	}
]]
function ddz_match_manager:resMatchInfoUpdateMsg(msg)
	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:updateMatchInfo(msg.matchInfo)
	end
end

--[[
	玩家排名奖励消息消息
	msg = {
	名称:rank 类型:int 备注:排名
		名称:rewards 类型:List<RankRewardInfo> 备注:排名奖励
	}
]]
function ddz_match_manager:resRankRewardInfoMsg(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui:showRewardPanel(msg)
	end
end

----------------------------------------------------------------游戏消息

--[[
	游戏开始消息
	msg = {
		名称:antes 类型:int 备注:底分
		名称:runsPlayerNum 类型:int 备注:比赛轮数的人数
		名称:seatInfos 类型:List<SeatInfo> 备注:房间座位信息
	}
]]
function ddz_match_manager:resGameStart(msg)
	for k,v in pairs(msg.seatInfos) do
		if player_is_myself(v.playerId) then
			ddz_match_manager._mySeatOrder = v.order
		end
	end

	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui:initGameSeats(msg.seatInfos, msg.runsPlayerNum)
	end
end


--[[
	玩家叫牌消息
	msg = {
		名称:playerId 类型:long 备注:叫牌的玩家
		名称:order 类型:int 备注:叫牌的玩家order
		名称:type 类型:int 备注:叫牌类型(0:不叫地主,1:叫地主,2:不抢地主,3:抢地主)
		名称:landlord 类型:long 备注:地主玩家id(0代表还没有确定地主)
		名称:landlordOrder 类型:int 备注:地主order
		名称:nextCallOrder 类型:int 备注:下一个叫牌的座位顺序号(0-2)
	}
]]
function ddz_match_manager:resCallCard(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui:playerCallRobotResult(msg.order, msg.type)

		if long_compare(msg.landlord, 0) == 0 then
			if msg.type == 0 then
				game_ui:playerCallDz(msg.nextCallOrder)
			else
				game_ui:playerRobotDz(msg.nextCallOrder)
			end
		else
			game_ui:setDiZhuPlayer(msg.landlordOrder)
		end
	end
end

--[[
	底牌消息
	msg = {
		名称:cards 类型:List<int> 备注:底牌
	}
]]
function ddz_match_manager:resHiddenCards(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui:sendDiZhuCards( msg.cards )
	end
end

--[[
	发牌消息
	msg = {
		名称:firstCallOrder 类型:int 备注:首先叫牌的座位顺序号(0-2)
		名称:cards 类型:List<int> 备注:玩家的牌
	}
]]
function ddz_match_manager:resDealCards(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui:sendCard(msg.cards)
		game_ui:playerCallDz(msg.firstCallOrder)
	end
end

--[[
	玩家出牌信息消息
	msg = {
		名称:playerId 类型:long 备注:出牌的玩家
		名称:order 类型:int 备注:出牌的玩家order
		名称:cards 类型:List<int> 备注:玩家出的牌
		名称:cardsType 类型:int 备注:玩家出的牌的类型(1:单牌，2:对子,3:三不带,4:三代单，5:三带对,6:单顺,7:双顺,8:三顺,9:飞机带单,10:飞机带队,11:炸弹,12:王炸,13:四带单,14:四带队)
		名称:nextPlayOrder 类型:int 备注:下一个出牌玩家的顺序
	}
]]
function ddz_match_manager:resPlayCards(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
        self._forwardCardsType = msg.cardsType
		game_ui:playerOutCards(msg.order, msg.cards, msg.cardsType)
		game_ui:playerOutCardsStage(msg.nextPlayOrder)

		
	end
end

--[[
	玩家放弃(不要)结果消息
	msg = {
		名称:order 类型:int 备注:放弃出牌的玩家位置
		名称:nextPlayOrder 类型:int 备注:下一个出牌玩家的顺序
	}
]]
function ddz_match_manager:resAbandon(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui:playerAbandonOut(msg.order)
		game_ui:playerOutCardsStage(msg.nextPlayOrder)
	end
end

--[[
	玩家加倍结果消息
	msg = {
		名称:playerId 类型:long 备注:加倍的玩家
		名称:order 类型:int 备注:加倍的玩家order
		名称:doubled 类型:byte 备注:0:不加倍,非0:加倍
	}
]]
function ddz_match_manager:resDouble(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui:playerRedoubleResult(msg.order, msg.doubled)
	end
end

--[[
	玩家请求提示结果消息
	msg = {
		名称:cards 类型:List<int> 备注:提示的牌(牌的数量为空则没有大过上家的牌)
	}
]]
function ddz_match_manager:resPrompt(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui:cardsPrompt(msg.cards)
	end
end

--[[
	桌子座位信息变更消息
	msg = {
		名称:runsPlayerNum 类型:int 备注:比赛轮数的人数
		名称:seatInfos 类型:List<SeatInfo> 备注:房间座位信息
	}
]]
function ddz_match_manager:resTableSeatInfosUpdate(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui:updatePlayerRank(msg.seatInfos, msg.runsPlayerNum)
	end
end

--[[
	游戏结束(后面会有结算等信息)消息
	msg = {
			名称:bills 类型:List<BillInfo> 备注:结算信息
	}
]]
function ddz_match_manager:resGameOver(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui:playSpringEffect(function ()
			game_ui:showSettlePanel(msg.bills)
		end)
	end
end

--[[
	比赛轮数结束消息
	msg = {
	}
]]
function ddz_match_manager:resMatchRunsOver(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui._isCanShowAdvance = true
		game_ui:showRankingWaitPanel()
	end
end

--[[
	比赛轮数等待消息消息
	msg = {
		名称:runs 类型:int 备注:比赛轮数(0:预赛)
		名称:nums 类型:List<int> 备注:比赛轮数人数
		名称:tables 类型:int 备注:正在比赛的桌子数
	}
]]
function ddz_match_manager:resMatchRunsWaite(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
        msg.runs = msg.runs + 1
		game_ui:updateRankingWaitInfo(msg)
	end
end

--[[
	游戏结束后分配桌子失败(预赛阶段才会出现)消息
	msg = {
	}
]]
function ddz_match_manager:resAssigneSeatsFail(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui:showWaitPanel()
	end
end

--[[
	玩家喊话消息
	msg = {
		名称:order 类型:int 备注:座位顺序(0-2)
		名称:type 类型:int 备注:0:嘲讽,2:催牌,3:赞扬
	}
]]
function ddz_match_manager:resShout(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui:playerSpeak(msg.order, msg.type)
	end
end


--[[
	预赛被淘汰消息
	msg = {
		名称:order 类型:int 备注:座位顺序(0-2)
	}
]]
function ddz_match_manager:resPreElimination(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
	if game_ui then
		game_ui:playerElimination(msg.order)
	end
end