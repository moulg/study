--[[
	赛马管理类
]]

horserace_manager = {}

--我自己的座位id
horserace_manager._mySeatOrder = nil
--拥有筹码
horserace_manager._ownChips = "0"

horserace_manager._seatsMap = {}
--游戏状态: 1.休息 2.下注 3.开奖 4.结算
horserace_manager._state = nil
--倒计时时间
horserace_manager._countdown = nil
--当前选择筹码小图标
horserace_manager._selectChipsType = nil
--所有下注的筹码
horserace_manager.totalBetChipsMap = {}
--当前玩家下注的筹码
horserace_manager.curBetChipsMap = {}
--用于记录当前玩家在每个区域下注的用于续押的总筹码数
horserace_manager._continueChips = nil
--筹码数值
horserace_manager._chipsValueList = {10000000,1000000,100000,10000,1000,100,10,1}
--倍数
horserace_manager._listMultiple = nil 
--场景ID
horserace_manager._iSceneId = 1
--跑第二的马用的总时间
horserace_manager._secondTotalTime = 0
--总段数
horserace_manager._segement = 0
--是否开在开奖之前进入
horserace_manager._beforeStart = false
--是否显示押注面板
horserace_manager._betPanelIsShow = false

--马跑的段数及时间
horserace_manager._horseData = nil
--开奖的区域ID
horserace_manager._areaId = 1
horserace_manager._playerChangeChips = 0
--每个区域对应的组合字符串
horserace_manager._areaData = {"1-6","1-5","1-4","1-3","1-2","2-6","2-5","2-4","2-3","3-6","3-5","3-4","4-6","4-5","5-6",}
--开奖记录
horserace_manager._recordData = {}
--当前记录
horserace_manager._curRecord = 1
--第一名马的ID
horserace_manager._firstHorseId = 1
--第二名马的ID
horserace_manager._secodHorseId = 1




--初始化座位信息
function horserace_manager.saveSeatInfos(members)
	horserace_manager._seatsMap = {}
	for k,v in pairs(members) do
		horserace_manager._seatsMap[v.order] = v

		if player_is_myself(v.playerId) then
			horserace_manager._mySeatOrder = v.order
		end
	end
end
--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function horserace_manager:resEnterGameHall(msg)
	local _playerInfo = get_player_info()
	_playerInfo.myRoomTypeInfo = msg.roomTypes

	_playerInfo.curGameID = 16
	_playerInfo.curGameDeskClassName = "CHorseRaceDesk"

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
function horserace_manager:resChipsChange(msg)
	if msg.playerId == get_player_info().id then
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CHorseRaceMainScene")
		if game_ui.isLoadEnd then
			self._ownChips = msg.chips
			if horserace_manager._state ~= 3 then
				game_ui:updateChips()
			end
		end
	end
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
function horserace_manager:resFastEnterTable(msg)
	--add your logic code here
	
end

--[[
	进入房间结果消息
	msg = {
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
function horserace_manager:resEnterRoom(msg)
	HallManager:resEnterRoomMsg(msg)
end

--[[
	进入牌桌结果消息
	msg = {
		名称:players 类型:List<long> 备注:牌桌中的玩家
	}
]]
function horserace_manager:resEnterTable(msg)
	-- dump(msg)
	-- local members = HallManager:getMemberInfos(msg)
	local members = msg.mems

    local _playerInfo = get_player_info()
    _playerInfo.myTableId = members[1].tableId

	horserace_manager._ownChips = "0"
	horserace_manager.saveSeatInfos(members)

	WindowScene.getInstance():replaceModuleByModuleName("horserace_std")
	-- local game_ui = WindowScene.getInstance():getModuleObjByClassName("CHorseRaceMainScene")
	-- if game_ui then
	-- 	game_ui:init_after_enter()
	-- end
	HallManager:enterTableHandler(msg)
	
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
function horserace_manager:resExitRoom(msg)
	
	
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
function horserace_manager:resExitTable(msg)
	-- dump(msg)
	if self._mySeatOrder == msg.order then
		-- print("playerExitTable>>>>>> ")
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

--[[
	返回倍率结果消息
	msg = {
		名称:iconMultiple 类型:List<IconMultiple> 备注:本局每个区域的倍率
	}
]]
function horserace_manager:resMultiple(msg)
	print("返回倍率结果消息")
	-- dump(msg)
	if msg.iconMultiple ~= nil then
		horserace_manager._listMultiple = msg.iconMultiple
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CHorseRaceMainScene")
		if game_ui.isLoadEnd then
			game_ui:setMultiple()
		end
	end
	
end

--[[
	赛马跑动数据消息
	msg = {
		名称:segement 类型:int 备注:总段数
		名称:horseDetail 类型:List<HorseDetail> 备注:每匹马的数据
	}
]]
function horserace_manager:resHorseDetail(msg)
	print("赛马跑动数据消息")
	
	horserace_manager._beforeStart = true
	local totalTime = {}
	for k,v in pairs(msg.horseDetail) do
		totalTime[#totalTime + 1] = v.totalTime
	end
	
	table.sort(msg.horseDetail,function (a,b)
		if a.totalTime < b.totalTime then
			return true
		else
			return false
		end
	end)
	
	horserace_manager._secondTotalTime = msg.horseDetail[2].totalTime 
	horserace_manager._firstHorseId = msg.horseDetail[1].horseId
	horserace_manager._secodHorseId = msg.horseDetail[2].horseId
	print("secondTime ===== " ..horserace_manager._secondTotalTime)
	horserace_manager._segement = msg.segement
	table.sort(msg.horseDetail,function (a,b)
		if a.horseId < b.horseId then
			return true
		else
			return false
		end
	end)
	-- dump(msg.horseDetail)
	horserace_manager._horseData = msg.horseDetail
	-- local game_ui = WindowScene.getInstance():getModuleObjByClassName("CHorseRaceMainScene")
	-- if game_ui then
	-- 	game_ui:playHorseMoveAnimation(horserace_manager._horseData)
	-- end
end

--[[
	其他人进入桌子消息
	msg = {
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
	
]]
function horserace_manager:resOtherEnterTable(msg)
	-- dump(msg)
	-- local member = HallManager._members[msg.playerId]
	local members = msg.mem
	self._seatsMap[members.order] = member
	
end

--[[
	返回下注结果消息
	msg = {
		名称:area 类型:int 备注:下注区域  闲家1-15
		名称:chips 类型:long 备注:对应的筹码
	}
]]
function horserace_manager:resBet(msg)
	print("返回下注结果信息")
	-- dump(msg)
	if msg ~= nil then
		audio_manager:playOtherSound(7, false)
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CHorseRaceMainScene")
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
			-- game_ui:addBetChips(msg.area,msg.chips,1)
			game_ui:addBetEffect(msg.area)
			game_ui:updateTotalBetChips()
			game_ui:updatePlayerBetChips()
			game_ui:updateChips()
		end
	end
	
end

--[[
	桌子筹码变化消息
	msg = {
		名称:betInfo 类型:List<BetInfo> 备注:桌上筹码信息
	}
]]
function horserace_manager:resTableBet(msg)
	-- print("桌子筹码变化消息")
	-- dump(msg)
	if msg.betInfo ~= nil then
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CHorseRaceMainScene")
		if game_ui.isLoadEnd then
			if table.nums(msg.betInfo) > 0 then
				for k,v in pairs(msg.betInfo) do
					if self.totalBetChipsMap[v.area] == nil then
						self.totalBetChipsMap[v.area] = v.chips
						-- game_ui:addBetChips(v.area,v.chips,0)
					else
						local addBetChips = long_minus(v.chips,self.totalBetChipsMap[v.area])
						self.totalBetChipsMap[v.area] = v.chips
						-- if long_compare(addBetChips,0) > 0 then
						-- 	game_ui:addBetChips(v.area,addBetChips,0)
						-- end
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
	通知客户端计时消息
	msg = {
		名称:state 类型:int 备注:告知客户端游戏进行到的阶段
		名称:time 类型:int 备注:计时时间(单位秒)
	}
]]
function horserace_manager:resTime(msg)
	print("通知客户端计时消息")
	-- dump(msg)
	if msg then
		horserace_manager._state = msg.state
		horserace_manager._countdown = msg.time
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CHorseRaceMainScene")
		if game_ui.isLoadEnd then
			-- print("isLoadEnd==true>>>")
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
function horserace_manager:resHistory(msg)
	--add your logic code here
	print("历史输赢记录消息")
	horserace_manager._recordData = msg.result
	-- dump(msg.result)
	-- local game_ui = WindowScene.getInstance():getModuleObjByClassName("CHorseRaceMainScene")
	-- if game_ui and game_ui.isLoadEnd == true then
	-- 	print("更新历史输赢记录消息")
	-- 	game_ui.recordPanel:updateRecordUi()
	-- end
end

--[[
	返回结算结果消息
	msg = {
		名称:playerChips 类型:long 备注:玩家结算筹码
	}
]]
function horserace_manager:resBalance(msg)    
	--add your logic code here
	print("返回结算结果消息")
	print("playerChips === " ..msg.playerChips)
	horserace_manager._playerChangeChips = msg.playerChips
end

--[[
	返回开奖结果消息
	msg = {
		名称:areID 类型:int 备注:中奖区域
	}
]]
function horserace_manager:resReward(msg)
	--add your logic code here
	print("返回开奖结果消息,开奖的区域ID：" ..msg.areID)

	horserace_manager._areaId = msg.areID
end
--[[
	场景消息消息
	msg = {
		名称:sceneId 类型:int 备注:场景ID
	}
]]
function horserace_manager:resScene(msg)
	--add your logic code here
	if msg.sceneId then
		horserace_manager._iSceneId = msg.sceneId
		-- local game_ui = WindowScene.getInstance():getModuleObjByClassName("CHorseRaceMainScene")
		-- if game_ui then
		-- 	game_ui:updateBackGroundById(msg.sceneId)
		-- 	game_ui:addItemBySceneId(msg.sceneId)
		-- end
	end
end

--[[
	清空下注结果消息
	msg = {
		名称:res 类型:int 备注:结果(0:成功,1:下注阶段不能清除下注)
	}
]]
function horserace_manager:resClearBet(msg)
	--add your logic code here
	-- print("清空下注结果消息")
	-- dump(msg)
	if msg.res == 0 then
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CHorseRaceMainScene")
		if game_ui.isLoadEnd then
			game_ui:cleanChipsPanel()
		end
	end
end
--传输对象说明
--[[
	HorseDetail = {
		horseId, --赛马ID
		totalTime, --总时间
		segement, --总段数
		perTime, --每一段的时间
	}
]]
--[[
	BetInfo = {
		area, --下注区域
		chips, --下注筹码
	}
]]
--[[
	IconMultiple = {
		areId, --区域ID
		rate, --区域对应倍率
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