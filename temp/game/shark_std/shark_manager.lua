shark_manager = {}

--庄家id
shark_manager._bankerID = "0"

--玩家的收益
shark_manager._playerBillChips = 0
shark_manager._bankerBillChips = 0

--押注金鲨的总筹码
shark_manager._betGoldSharkChips = 0

--第二次中奖索引
shark_manager._secondRewardIndex = nil
--第二次开奖时间
shark_manager._secondRewardTime = 0

--是否需要等待
shark_manager._isNeedWait = false



--设置奖金池
function shark_manager:setRewardPool( icon )
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CSharkMainScene")
	if game_ui then
		game_ui:setRewardPool(icon)
	end
end



------------------------------------------------------------------------------消息
--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function shark_manager:resEnterGameHallMsg(msg)
	local _playerInfo = get_player_info()
	_playerInfo.myRoomTypeInfo = msg.roomTypes
	_playerInfo.curGameID = 10
	_playerInfo.curGameDeskClassName = "CSharkDesk"

	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:chips 类型:int 
	}
]]
function shark_manager:resChipsChangeMsg(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CSharkMainScene")
	if game_ui then
		game_ui:setPlayerChips(msg.chips)
	end
end


--[[
	请求进入牌桌消息
	msg = {
		名称:historyRewardIcons 类型:List<int> 备注:历史中奖图标
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
function shark_manager.resEnterTableMsg(msg)
	local members = msg.mems
	local _playerInfo = get_player_info()
    _playerInfo.myTableId = members[1].tableId
	
	shark_manager._isNeedWait = true
	WindowScene.getInstance():replaceModuleByModuleName("shark_std")

	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CSharkMainScene")
	if game_ui then
		game_ui:setRecordList( msg.historyRewardIcons )
	end

	HallManager:enterTableHandler(msg)
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
	}
]]
function shark_manager:resExitTableMsg(msg)
	HallManager:reqExitCurGameRoom()
	if WindowScene.getInstance():getCurModuleName()  == "game_lobby" then
		return
	end
	WindowScene.getInstance():replaceModuleByModuleName("game_lobby")

	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
end

------------------------------------游戏消息

--[[
	休息阶段消息消息
	msg = {
		名称:time 类型:int 备注:时间(秒)
		名称:iconRateInfos 类型:List<IconRateInfo> 备注:图标倍率信息
	}
]]
function shark_manager:resRestStage(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CSharkMainScene")
	if game_ui and shark_manager._isNeedWait == false then
		game_ui:addTimeDown(msg.time)
		game_ui:setBetMultiplyNum(msg.iconRateInfos)
		game_ui:enterRestStage()
	end
end

--[[
	下注阶段消息消息
	msg = {
		名称:time 类型:int 备注:时间(秒)
	}
]]
function shark_manager:resBetStage(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CSharkMainScene")
	if game_ui and shark_manager._isNeedWait == false then
		game_ui:addTimeDown(msg.time)
		game_ui:setBetMultiplyNum(msg.iconRateInfos)
		game_ui:enterBetStage()
	end
end

--[[
	游戏阶段消息消息
	msg = {
		名称:firstIconIndex 类型:int 备注:第一次中奖图标位置(如果中的是金沙或者银沙会有第二次转动)，如果是中途进入游戏则是0
		名称:secondIconIndex 类型:int 备注:第二次中奖图标位置
		名称:firstTime 类型:int 备注:第一次中奖游戏时间
		名称:secondTime 类型:int 备注:第二次中奖游戏时间
		名称:playerBillChips 类型:long 备注:玩家的收益
		名称:bankerBillChips 类型:long 备注:庄家收益
	}
]]
function shark_manager:resGameStage(msg)
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CSharkMainScene")

	print("中奖结果:",msg.firstIconIndex.."   "..msg.secondIconIndex)

	if game_ui and shark_manager._isNeedWait == false and msg.firstIconIndex ~= 0 then
		shark_manager._playerBillChips = msg.playerBillChips
		shark_manager._bankerBillChips = msg.bankerBillChips
		shark_manager._secondRewardTime = msg.secondTime
		self._secondRewardIndex = msg.secondIconIndex
		
		game_ui:enterShowRewardStage(msg.firstTime)
		game_ui:startGame(msg.firstIconIndex)
	end
end

--所有玩家下注信息
function shark_manager:setAllPlayerBetInfo( msg )
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CSharkMainScene")
	if game_ui and shark_manager._isNeedWait == false then
		game_ui:setAllPlayerBetChips(msg.betInfos)
	end
end

--主玩家下注信息
function shark_manager:setMainPlayerBetInfo( msg )
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CSharkMainScene")
	if game_ui and shark_manager._isNeedWait == false then
		game_ui:setMainPlayerBetChips(msg.betInfo)
	end
end

--设置庄家信息
function shark_manager:setBankerInfo( msg )
	local data = {}
	data.chips = msg.chips
	data.score = msg.score
	data.num = msg.num
	data.name = msg.name
	data.sex = msg.sex
    local info = HallManager._members[msg.playerId]
    if info then
        data.icon = info.icon
    else
        data.icon = 1
    end

    shark_manager._bankerID = msg.playerId

	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CSharkMainScene")
	if game_ui then
		game_ui:setBankerInfo(data)
	end
end

--设置申请庄家列表
function shark_manager:setApplyBankers( msg )
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CSharkMainScene")
	if game_ui then
		local infos = {}
		for i,v in ipairs(msg.applicants) do
			local data = {}
            data.playerId = v
			data.chips = HallManager._members[v].chips
            data.playerName = HallManager._members[v].playerName
            table.insert(infos, data)
		end

		game_ui:setApplyPlayers(infos)
	end
end

--[[
	清空下注结果消息
	msg = {
		名称:res 类型:int 备注:结果(0:成功,1:下注阶段不能清除下注)
	}
]]
function shark_manager:resClearBet(msg)
	if msg.res == 0 then
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CSharkMainScene")
		if game_ui then
			game_ui:clearBetData()
		end
	end
end

--[[
	请求游戏阶段结果消息
	msg = {
	}
]]
function shark_manager:resStage(msg)
	shark_manager._isNeedWait = false
end