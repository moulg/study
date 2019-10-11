--[[

4S店 管理类
]]

fs_manager = {}

--坐庄要求最少拥有筹码数
fs_manager._requireChipsNum = 10000000
--当前玩家拥有筹码
fs_manager._ownChips = 0
--成绩
fs_manager._playerScore = 0 
--庄家当前拥有筹码
fs_manager.bankerOwnChips = 0
--是否自动续押
fs_manager._bAutoContinue = false
--是否自动退出
fs_manager._bAutoExit = false
--总押注
fs_manager._totalBetChips = 0
--当前所在桌子ID
fs_manager._deskId = 1
--最终开奖格子ID
fs_manager._finalId = 1
--最终开奖车子ID
fs_manager._finalCarId = 1
--老虎机起始位置
fs_manager._startIndex = 1
--游戏状态: 1.休息 2.下注 3.开奖 4.结算
fs_manager._state = 1
--倒计时时间
fs_manager._countdown = nil
--当前下注筹码类型
fs_manager._betChipsType = nil
--当前下注车标ID
fs_manager._betCarId = nil
--彩金池彩金数
fs_manager._lottery = 0
--彩金池触发时获得的彩金数
fs_manager._lotteryNum = 0
--是否触发彩金池
fs_manager._bTriggerLottery = false
--选择筹码小图标
fs_manager._smallChipsIcon = nil
--庄家筹码的变化
fs_manager._bankerChipschanges = 0
--玩家筹码变化
fs_manager._playerChipschanges = 0
--筹码数值
fs_manager._chipsValueList = {10,100,1000,10000,100000,}
--当前玩家在每个区域下注的筹码数
fs_manager._chipsNumberList = {0,0,0,0,0,0,0,0}
--用于记录当前玩家在每个区域下注的用于续押的总筹码数
fs_manager._continueChips = nil
--当前每个区域下注的总筹码数
fs_manager._chipsTotalNumberList = {0,0,0,0,0,0,0,0}
--每个区域下注的每种类型筹码个数
fs_manager._numberList = {[1] = {0,0,0,0,0,0,0,0},
						  [2] = {0,0,0,0,0,0,0,0},
						  [3] = {0,0,0,0,0,0,0,0},
						  [4] = {0,0,0,0,0,0,0,0},
						  [5] = {0,0,0,0,0,0,0,0},
						  [6] = {0,0,0,0,0,0,0,0},
						  [7] = {0,0,0,0,0,0,0,0},
						  [8] = {0,0,0,0,0,0,0,0},
						}
--不同车标对应的倍数
fs_manager._MultipleList = {40,30,20,10,5,5,5,5}
--每种类型筹码的个数
fs_manager._chipsNumListPerType = {0,0,0,0,0,0,0,0}
--当前开奖记录
fs_manager._curRecord = 1
--所有开奖记录
fs_manager._recordData = {}
--当前是否可以下注
fs_manager._bCanBet = true 
--申请开店排队列表
fs_manager._applyListData = {}
--庄家信息
fs_manager._bankerInfo = {}
--倍数
fs_manager._listMultiple = nil
--是否开在开奖之前进入
fs_manager._beforeStart = false
--是否第一次进游戏
fs_manager._firstEnter = true
--开奖时间
fs_manager._rewardTime = 5

--注册移动筹码小图标
function fs_manager:registerSelectBtnMouseMoveSprite()
	local game_4s = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
	if game_4s then
		game_4s:registerSelectBtnMouseMoveSprite()
	end
end
--获取每种类型筹码的个数
function fs_manager:getChipsNumByValue(value)
	if long_compare(value, 10000000) >= 0 then
		fs_manager._chipsNumListPerType[1] = tonumber(long_divide(value, 10000000))
		value = long_mod(value, 10000000)
	elseif long_compare(value, 1000000) >= 0 then
		fs_manager._chipsNumListPerType[2] = tonumber(long_divide(value, 1000000))
		value = long_mod(value, 1000000)
	elseif long_compare(value, 100000) >= 0 then
		fs_manager._chipsNumListPerType[3] = tonumber(long_divide(value, 100000))
		value = long_mod(value, 100000)
	elseif long_compare(value, 10000) >= 0 then
		fs_manager._chipsNumListPerType[4] = tonumber(long_divide(value, 10000))
		value = long_mod(value, 10000)
	elseif long_compare(value, 1000) >= 0 then
		fs_manager._chipsNumListPerType[5] = tonumber(long_divide(value, 1000))
		value = long_mod(value, 1000)
	elseif long_compare(value, 100) >= 0 then
		fs_manager._chipsNumListPerType[6] = tonumber(long_divide(value, 100))
		value = long_mod(value, 100)
	elseif long_compare(value, 10) >= 0 then
		fs_manager._chipsNumListPerType[7] = tonumber(long_divide(value, 10))
		value = long_mod(value, 10)
	elseif long_compare(value, 1) >= 0 then
		fs_manager._chipsNumListPerType[8] = tonumber(long_divide(value, 1))
		value = long_mod(value, 1)
	end
	return value
end

-------------------------------------消息处理-----------------------------------------------
--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function fs_manager:resEnterGameHall(msg)
	local _playerInfo = get_player_info()
	_playerInfo.myRoomTypeInfo = msg.roomTypes
	_playerInfo.curGameID = 4
	_playerInfo.curGameDeskClassName = "CFSDeskItem"

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
function fs_manager.resEnterTableMsg(msg)
	-- local tmpMember = HallManager._members[msg.players[1]]
	-- local _playerInfo = get_player_info()
 --    _playerInfo.myTableId = tmpMember.tableId

    local members = HallManager:getMemberInfos(msg)
    local _playerInfo = get_player_info()
    _playerInfo.myTableId = members[1].tableId
    
	WindowScene.getInstance():replaceModuleByModuleName("4s_std")
	local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
	-- if game_FoursShop then
	-- 	game_FoursShop:init_after()
	-- end

	HallManager:enterTableHandler(msg)
end

--[[
	其他玩家的加入
	msg = {
			名称:member 类型:com.wly.game.gamehall.dto.MemInfo 备注:牌桌中的成员信息
		}
]]
-- function fs_manager:resOtherPlayerEnterTableMgs(msg)
-- 	local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
-- 	if game_FoursShop then
--         game_FoursShop:createPlayer(msg.member)
-- 	end
-- end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
function fs_manager:resChipsChange(msg)
	if msg ~= nil then
		fs_manager._ownChips = msg.chips
		local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
		if game_FoursShop and (game_FoursShop.isLoadEnd == true) then
			game_FoursShop.chipsPanel:updatePlayerInfo()
			game_FoursShop:updateChipsBtn()
		end
	end
end

--[[
	座位信息变化消息
	msg = {
		名称:seat 类型:SeatInfo 备注:变化的座位信息
	}
]]
-- function fs_manager:resSeatInfoUpdate(msg)
-- 	local _playerInfo = get_player_info()
-- 	_playerInfo:updateDeskInfo(msg.seat)

--     local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
-- 	if gamelobby then
-- 		local game_room_obj = gamelobby.game_room_ui_list
-- 		if game_room_obj then
-- 			game_room_obj:upDateSeatInfo(msg.seat)
-- 		end
-- 	end
-- end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
function fs_manager:resFastEnterTable(msg)
	--add your logic code here
	
end

--[[
	请求进入房间结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:人数超过房间上限
		名称:tables 类型:List<TableInfo> 备注:房间中的牌桌信息
	}
]]
-- function fs_manager:resEnterRoom(msg)
-- 	if msg.res == 0 then
-- 		local _playerInfo = get_player_info()
-- 		_playerInfo.myDesksInfo = msg.tables
-- 		fs_manager._deskId = playerInfo.myDesksInfo[1].seats[1].tableId

-- 		local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
-- 		if gamelobby then
-- 			gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_GAME_ROOM)
-- 		end
-- 	end
-- end

--[[
	请求进入牌桌消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:该位置有人;
		名称:seat 类型:SeatInfo 备注:牌桌中的座位信息
	}
]]
-- function fs_manager:resEnterTable(msg)
-- 	if msg.res == 0 then
-- 		--local function compeletCallBack()
-- 			fs_manager._deskId = msg.seat.tableId 
-- 			WindowScene.getInstance():replaceModuleByModuleName("4s_std")
-- 		--end
-- 		--WindowScene.getInstance():replaceModuleByModuleName("loading")
-- 		--local game_loading = WindowScene.getInstance():getModuleObjByClassName("CGameLoadingExt")		
-- 		--if game_loading then
-- 			--game_loading:loadingGame(4, compeletCallBack)
-- 		--end	
-- 	end
-- end

--[[
	4s房间人数消息
	msg = {
		名称:roomId 类型:int 备注:房间
		名称:type 类型:int 备注:房间类型
		名称:num 类型:int 备注:房间人数
	}
]]
-- function fs_manager:resRoomPlayerNum(msg)
-- 	get_player_info():updateRoomInfo(msg.roomId, msg.type, msg.num)
-- 	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
-- 	if gamelobby and gamelobby.second_hall_ui_list then
-- 		gamelobby.second_hall_ui_list:updateRoomInfo(msg.type, msg.roomId, msg.num)
-- 	end
-- end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
function fs_manager:resExitRoom(msg)
	--add your logic code here
	
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
	}
]]
function fs_manager:resExitTable(msg)
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

--[[
	请求结算结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有可结算筹码
	}
]]
function fs_manager:resBill(msg)
	--add your logic code here
	
end

--[[
	4s店当前开出的概率和出现的车标消息
	msg = {
		名称:carId 类型:int 备注:车标ID
		名称:rate 类型:int 备注:本次游戏开出的倍率
		名称:startIndex 类型:int 备注:开始位置
		名称:rewardTime 类型:int 备注:开奖时间
	}
]]
function fs_manager:resRandCarResult(msg)
	if msg ~= nil then 
		fs_manager._finalCarId = msg.carId
		fs_manager._rate = msg.rate
		fs_manager._startIndex = msg.startIndex
		fs_manager._rewardTime = math.ceil(msg.rewardTime/1000)
	end
end

--[[
	返回倍率结果消息
	msg = {
		名称:foursPlan 类型:List<FoursIconMultiple> 备注:本局所开出的倍率
	}
]]
function fs_manager:resMultiple(msg)
	if msg.foursPlan ~= nil then
		fs_manager._listMultiple = msg.foursPlan
		local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
		if game_FoursShop and (game_FoursShop.isLoadEnd == true) then
			game_FoursShop:setMultiple()
		end
	end
end

--[[
	返回结算结果消息
	msg = {
		名称:billChips 类型:long 备注:获得筹码数
		名称:totalChips 类型:long 备注:总筹码数
		名称:bankerEarn 类型:long 备注:庄家收益
		名称:mosaicGold 类型:long 备注:彩金池数
		名称:bankerTotalChips 类型:long 备注:庄家身上的总筹码
	}
]]
function fs_manager:resBalance(msg)
	if msg ~= nil then
		dump(msg)
		fs_manager._playerChipschanges = msg.billChips
		fs_manager._bankerChipschanges = msg.bankerEarn
		fs_manager._ownChips = msg.totalChips
		fs_manager._lottery = msg.mosaicGold
		fs_manager._bankerInfo.gold = msg.bankerTotalChips
		local record = {finalCarId = fs_manager._finalCarId,
						playerChipschanges = fs_manager._playerChipschanges,
						bankerChipschanges = fs_manager._bankerChipschanges}
		table.insert(fs_manager._recordData,1,record)
		--dump(fs_manager._recordData)
	end
end

--[[
	返回上庄结果消息
	msg = {
		名称:result 类型:int 备注:上庄结果0：成功，1：失败
		名称:bankers 类型:List<BankerRanker> 备注:目前在队列里面的庄家
	}
]]
function fs_manager:resOnBanker(msg)
	if msg.result == 0 then
		fs_manager._applyListData = msg.bankers
		local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
		if game_FoursShop and (game_FoursShop.isLoadEnd == true) then
			game_FoursShop.applyListPanel:updateApplyListInfo()
		end
	end
end

--[[
	返回取消上庄结果消息
	msg = {
		名称:result 类型:int 备注:上庄结果0：成功，1：失败
		名称:banker 类型:List<BankerRanker> 备注:队列里面的申请庄家信息
	}
]]
function fs_manager:resCancelOnBanker(msg)
	if msg.result == 0 then
		fs_manager._applyListData = msg.banker
		local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
		if game_FoursShop and (game_FoursShop.isLoadEnd == true) then
			game_FoursShop.applyListPanel:updateApplyListInfo()
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
function fs_manager:resTime(msg)
	if msg ~= nil then 
		print("状态改变，服务器发送的时间 = " ..msg.time)
		fs_manager._state = msg.state
		fs_manager._countdown = msg.time
		-- fs_manager._smallChipsIcon = nil
		-- fs_manager._betChipsType = nil
		local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
		if game_FoursShop and (game_FoursShop.isLoadEnd == true) then
			game_FoursShop:resetGame()
		end
	end
end

--[[
	返回下注结果消息
	msg = {
		名称:result 类型:int 备注:下注结果返回0：成功，1：失败
	}
]]
function fs_manager:resBetResult(msg)
	--恢复下注
	fs_manager._bCanBet = true
	if msg.result == 0 then
		--audio_manager:playOtherSound(4, false)
		local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
		if game_FoursShop then
			game_FoursShop:addChipsToPanelByType(fs_manager._betCarId,fs_manager._betChipsType,1)
			fs_manager._chipsNumberList[fs_manager._betCarId] = long_plus(fs_manager._chipsNumberList[fs_manager._betCarId], fs_manager._chipsValueList[fs_manager._betChipsType])
			fs_manager._chipsTotalNumberList[fs_manager._betCarId] = long_plus(fs_manager._chipsTotalNumberList[fs_manager._betCarId], fs_manager._chipsValueList[fs_manager._betChipsType])
			--fs_manager._ownChips = fs_manager._ownChips - fs_manager._chipsValueList[fs_manager._betChipsType]
			--更新当前玩家在该区域下注的筹码
			game_FoursShop:updatePlayerBetChips()
			--更新该车标区域下注的总筹码
			game_FoursShop:updateTotalBetChips()
			--更新玩家当前筹码
			game_FoursShop.chipsPanel:updatePlayerInfo()
			--更新筹码按钮状态
			game_FoursShop:updateChipsBtn()
			--更新清空按钮状态
			game_FoursShop.chipsPanel:calculateClean()
			--更新续押按钮状态
			game_FoursShop.chipsPanel:calculateContinue()
		end
	elseif msg.result == 1 then
		TipsManager:showOneButtonTipsPanel(74, {}, true)
	end
end

--[[
	返回下庄结果消息
	msg = {
		名称:result 类型:int 备注:下注结果返回0：成功，1：失败
	}
]]
function fs_manager:resCancelBanker(msg)
	if msg.result == 0 then 
		local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
		if game_FoursShop and (game_FoursShop.isLoadEnd == true) then
			game_FoursShop.applyListPanel.updateApplyListInfo()
		end
	end
end

--[[
	庄家信息消息
	msg = {
		名称:playerId 类型:int 备注:庄家id
		名称:name 类型:String 备注:昵称
		名称:gold 类型:long 备注:筹码数
		名称:count 类型:int 备注:局数
		名称:score 类型:long 备注:成绩
		名称:immediately 类型:int 备注:是否立刻刷新:0是，1否
	}
]]
function fs_manager:resBankerInfo(msg)
	if msg ~= nil then
		fs_manager._bankerInfo = msg
		if msg.immediately == 0 then
			local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
			if game_FoursShop and (game_FoursShop.isLoadEnd == true) then
				game_FoursShop.bankerPanel:updateBankerInfo()
				game_FoursShop.applyListPanel:updateApplyListInfo()
			end
		end
	end
end

--[[
	申请庄家列表消息
	msg = {
		名称:banker 类型:List<BankerRanker> 备注:队列里面的申请庄家信息
	}
]]
function fs_manager:resBankerList(msg)
	if msg.banker ~= nil then 
        fs_manager._applyListData = msg.banker
		local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
		if game_FoursShop and(game_FoursShop.isLoadEnd == true) then
			game_FoursShop.applyListPanel:updateApplyListInfo()
		end
	end
end

--[[
	续押返回：0成功,1失败消息
	msg = {
		名称:result 类型:int 备注:队列里面的申请庄家信息
	}
]]
function fs_manager:resContinueBet(msg)
	if msg.result == 0 then
		local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
		if game_FoursShop and(game_FoursShop.isLoadEnd == true) then
			local totalContinueChips = 0
			if fs_manager._continueChips ~= nil then
				for i,v in ipairs(fs_manager._continueChips) do
					totalContinueChips = long_plus(totalContinueChips, v)
				end
			end
			fs_manager._ownChips = long_minus(fs_manager._ownChips, totalContinueChips) 
			game_FoursShop:addContinueChips()
			--更新玩家当前筹码
			game_FoursShop.chipsPanel:updatePlayerInfo()
			--更新筹码按钮状态
			game_FoursShop:updateChipsBtn()
			--更新清空按钮状态
			game_FoursShop.chipsPanel:calculateClean()
			--更新续押按钮状态
			game_FoursShop.chipsPanel:calculateContinue()
		end
	elseif msg.result == 1 then
		TipsManager:showOneButtonTipsPanel(74, {}, true)
	end
end

--[[
	清空下注：0成功,1失败消息
	msg = {
		名称:result 类型:int 备注:清空下注：0成功,1失败
	}
]]
function fs_manager:reqClearBet(msg)
	if msg.result == 0 then 
		local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
		if game_FoursShop and(game_FoursShop.isLoadEnd == true) then
			game_FoursShop:cleanChipsPanel()
		end
	end
end
--[[
	触发彩金池消息
	msg = {
		名称:num 类型:long 备注:获得的彩金数
	}
]]
function fs_manager:resMosaic(msg)
	if msg ~= nil then 
		fs_manager._bTriggerLottery = true
		fs_manager._lotteryNum = msg.num
	end
	
end
--[[
	总筹码数发生的变化消息
	msg = {
		名称:bestInfo 类型:List<BetsInfo> 备注:变化的筹码
	}
]]
function fs_manager:resBetsChange(msg)
	if msg.bestInfo == nil or table.nums(msg.bestInfo)== 0 then 
		return 
	else
		local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
		if game_FoursShop and (game_FoursShop.isLoadEnd == true) then
			--audio_manager:playOtherSound(4, false)
			for i,v in pairs(msg.bestInfo) do
			    local addChips = long_minus(v.bet, fs_manager._chipsTotalNumberList[v.carId])
			    fs_manager._chipsTotalNumberList[v.carId] = v.bet
			    while(long_compare(addChips,0)>0)
			    do 
			    	addChips = self:getChipsNumByValue(addChips)
				end
			    for k,j in ipairs(fs_manager._chipsNumListPerType) do
			    	if j > 0 then
			    		for n=1,j do
			    			game_FoursShop:addChipsToPanelByType(v.carId,k,0)
			    		end
			    	end
			    end	
				fs_manager._chipsNumListPerType = {0,0,0,0,0,0,0,0}
			end
			game_FoursShop:updateTotalBetChips()
		end
	end
end
--[[
	彩金池数量消息
	msg = {
		名称:mosaicGold 类型:long 备注:彩金池数量
	}
]]
function fs_manager:resMosaicGold(msg)
	if msg.mosaicGold ~= nil then
		fs_manager._lottery = msg.mosaicGold
		local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
		if game_FoursShop and (game_FoursShop.isLoadEnd == true) then
			game_FoursShop:updateLottery(false)
		end
	end
end
