--[[
牛牛管理类
]]


niuniu_manager = {}

--我自己的座位id
niuniu_manager._mySeatOrder = nil

niuniu_manager.seatsMap = {}

--初始化座位信息
function niuniu_manager:initGameSeats(seats)
	self.seatsMap = {}
	for k,v in pairs(seats) do
		self.seatsMap[v.playerId] = v

		if player_is_myself(v.playerId) then
			self._mySeatOrder = v.order
		end
	end
end

function niuniu_manager:updateMyTable(info)

	for i,v in pairs(self.seatsMap) do
		if v.tableId == info.tableId then
			self.seatsMap[info.playerId] = info
            return true
		end
	end

	return false
end

------------------------------------------------------------消息处理
--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function niuniu_manager:resEnterGameHallMsg(msg)
	local _playerInfo = get_player_info()
	_playerInfo.myRoomTypeInfo = msg.roomTypes
	_playerInfo.curGameID = 2
	_playerInfo.curGameDeskClassName = "CNIUNIU_DeskItem"

	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:chips 类型:int 备注:筹码变换
	}
]]
function niuniu_manager:resChipsChangeMsg(msg)
	local game_niuniu = WindowScene.getInstance():getModuleObjByClassName("CNiuNiuGame")
	if game_niuniu then
		game_niuniu:updateChips(msg.playerId, msg.chips)
	end
end

--[[
	玩家准备消息
	msg = {
		名称:playerId 类型:long 备注:准备的玩家
		名称:callPlayerId 类型:long 备注:叫庄的玩家,0代表不需要叫庄
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
function niuniu_manager:resReadyMsg(msg)
	if msg.res == 0 then
		local game_niuniu = WindowScene.getInstance():getModuleObjByClassName("CNiuNiuGame")
		if game_niuniu then
			game_niuniu:playerReady(msg.playerId)

			if long_compare(msg.callPlayerId, 0) ~= 0 then
				game_niuniu.callingZ_playerid = msg.callPlayerId
				game_niuniu:exitReadyStage()
				game_niuniu:enterCallZhuangStage()
			end
		end
	end
end


--[[
	请求叫庄家结果消息
	msg = {
		名称:playerId 类型:long 备注:叫庄的玩家
		名称:order 类型:int 备注:位置
		名称:callType 类型:int 备注:0:不叫,非0:叫
		名称:dealer 类型:long 备注:庄家id(0:庄家还未确定)
		名称:nextCallPlayer 类型:long 备注:下一个叫庄的玩家id)
	}
]]
function niuniu_manager:resCallDealerMsg(msg)
	local game_niuniu = WindowScene.getInstance():getModuleObjByClassName("CNiuNiuGame")
	if game_niuniu then
		if long_compare(game_niuniu.callingZ_playerid, msg.playerId) == 0 and long_compare(msg.dealer, 0) ~= 0 then
			game_niuniu.banker_id = msg.dealer
			game_niuniu:exitCallZhuangStage()

			game_niuniu:enterBetStage()
		else
			game_niuniu.callingZ_playerid = msg.nextCallPlayer
			game_niuniu:exitCallZhuangStage()
			game_niuniu:enterCallZhuangStage()
		end

		if self.seatsMap[msg.playerId] then
			if msg.callType == 0 then
				audio_manager:playPlayerSound(1, self.seatsMap[msg.playerId].sex)
			else
				--叫庄音效
				audio_manager:playOtherSound(5)
			end
		end
	end
end

--[[
	请求筹码兑换金币消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:chips 类型:int 备注:兑换金币后的剩余筹码数量
	}
]]
function niuniu_manager:resExchangeGoldsMsg(msg)
	local game_niuniu = WindowScene.getInstance():getModuleObjByClassName("CNiuNiuGame")
	if game_niuniu then
		game_niuniu:updateChips(msg.playerId, msg.chips)
	end
end

--[[
	请求下注结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:筹码不合法
		名称:chips 类型:long 备注:筹码
	}
]]
function niuniu_manager:resBetMsg(msg)
	if msg.res == 0 then
		print("下注   =  "..msg.chips)
		local game_niuniu = WindowScene.getInstance():getModuleObjByClassName("CNiuNiuGame")
		if game_niuniu then
			game_niuniu:exitBetStage()
			game_niuniu:playerBetChips( msg.chips )
		end
	end
end

--[[
	摊牌结果消息
	msg = {
		名称:playerId 类型:long 备注:摊牌的玩家
		名称:cardsType 类型:int 备注:牌型(0:没牛，1-10:牛1到牛牛,四花:11,四炸:12,五花:13,五小:14)
		名称:bestCards 类型:List<int> 备注:最优牌组合(如果有牛展示为3+2)
	}
]]
function niuniu_manager:resShowdownMsg(msg)
	local game_niuniu = WindowScene.getInstance():getModuleObjByClassName("CNiuNiuGame")
	if game_niuniu then
		game_niuniu:saveShowCardsMsg( msg )
	end
end

--[[
	请求进入牌桌消息
	名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
]]
function niuniu_manager.resEnterTableMsg(msg)
	local members = msg.mems
	local _playerInfo = get_player_info()
    _playerInfo.myTableId = members[1].tableId
    
	WindowScene.getInstance():replaceModuleByModuleName("niuniu_std")

	local game_niuniu = WindowScene.getInstance():getModuleObjByClassName("CNiuNiuGame")
	if game_niuniu then
		niuniu_manager:initGameSeats(members)
        game_niuniu:init_after_enter()
	end

	HallManager:enterTableHandler(msg)
end

--[[
	其他人进入桌子消息
	msg = {
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
function niuniu_manager:resOtherPlayerEnterTableMgs(msg)
	local member = msg.mem

	if self:updateMyTable(member) then
        local game_niuniu = WindowScene.getInstance():getModuleObjByClassName("CNiuNiuGame")
        if game_niuniu then
		    game_niuniu:createPlayer(member)
	    end
	end
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:playerId 类型:long 备注:退出桌子的玩家
	}
]]
function niuniu_manager:resExitTableMsg(msg)
	if player_is_myself(msg.playerId) then
		HallManager:reqExitCurGameRoom()

		if WindowScene.getInstance():getCurModuleName()  == "game_lobby" then
			return
		end
		WindowScene.getInstance():replaceModuleByModuleName("game_lobby")
		local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
		if gamelobby then
			gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
		end

		self.seatsMap = {}
		local _playerInfo = get_player_info()
		_playerInfo.myTableId = 0
	else --不是自己退出则将自己  回复到准备阶段
		local game_niuniu = WindowScene.getInstance():getModuleObjByClassName("CNiuNiuGame")
		if game_niuniu then

           self.seatsMap[msg.playerId]  = nil
           game_niuniu:removePlayer(msg.playerId)

			if game_niuniu.game_step ~= game_niuniu.GAME_STEP.READY_STEP then
				game_niuniu:resetDiplay()
				game_niuniu:enterReadyStage()
			end
		end
	end
	
end


--[[
	发牌消息
	msg = {
		名称:cards 类型:List<int> 备注:玩家的牌
		名称:tipCards 类型:List<int> 备注:提示的牌(3+2)
		名称:cardsType 类型:int 备注:牌型(0:没牛，1-10:牛1到牛牛,四花:11,四炸:12,五花:13,五小:14)
		名称:chips 类型:int 备注:输赢的筹码(正:赢,负:输)
	}
]]
function niuniu_manager:resDealCardsMsg(msg)
	local game_niuniu = WindowScene.getInstance():getModuleObjByClassName("CNiuNiuGame")
	if game_niuniu then
		game_niuniu:sendCardsStage(msg.tipCards, msg.cardsType)
		game_niuniu.MyGameChips = msg.chips
	end
end

--[[
	游戏结束消息
	msg = {
	}
]]
function niuniu_manager:resGameOverMsg(msg)
	local game_niuniu = WindowScene.getInstance():getModuleObjByClassName("CNiuNiuGame")
	if game_niuniu then
		game_niuniu:enterCompleteStage()
	end
	
end