#remark
--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码
HallManager = {}
--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码
HallManager._roomSettingData = nil
HallManager._members = {}

local _gameTypeMap = {}

--我的足迹
HallManager.MYGAME = 0
--扑克馆 (棋牌)
HallManager.POKER = 1
--麻将馆 (捕鱼)
HallManager.MAHJONG = 2
--街机馆 (街机)
HallManager.ARCADE = 3
--比赛馆
HallManager.MATCH = 4
--休闲馆 (电玩)
HallManager.CASUAL = 5
--所有游戏
HallManager.ALL = 6
--推荐游戏
HallManager.RECOMMEND = 7

--清理房间玩家列表 中的选中状态
function HallManager:clearPlayerSelectedState()
	local roomRightExt = WindowScene.getInstance():getModuleObjByClassName("CRoomTalkExt")
	if roomRightExt then
		roomRightExt:clearPlayerSelectedState()
	end
end

--return @ GameType = {
-- 	type, --游戏类型(0:我的游戏;1:扑克厅;2:麻将厅;3:街机厅;4:比赛厅;5:休闲厅;6:所有游戏;7:推荐游戏)
-- 	index, --位置索引
-- 	games, --游戏列表
-- }
function HallManager:getGamesByType(type)
	return _gameTypeMap[type]
end

--是否是推荐游戏
function HallManager:gameIsRecommend( gameid )
	if _gameTypeMap[HallManager.RECOMMEND] then
		for i,v in ipairs(_gameTypeMap[HallManager.RECOMMEND].games) do
			if v == gameid then
				return true
			end
		end
	end

	return false
end

--通知玩家进桌扣费
function HallManager:informPalyerFeeMsg()
	if message_config[200001] == nil then
		return
	end
	local msg = {}
	msg.content = message_config[200001].name

	local _playerInfo = get_player_info()
	local roominfo = _playerInfo:get_cur_roomInfo()
	local gamename = game_config[_playerInfo.curGameID].name
	msg.content = textUtils.connectParam(msg.content, {gamename, roominfo.afee})

	HallManager:resSysNoticeMsg(msg)
end

--通知玩家游戏开始
function HallManager:informPalyerGameStartMsg()
	if message_config[200002] == nil then
		return
	end
	local msg = {}
	msg.content = message_config[200002].name

	HallManager:resSysNoticeMsg(msg)
end

--玩家进入游戏通知
function HallManager:informPlayerEnterGame(name)
	if message_config[200003] == nil then
		return
	end
	local msg = {}
	msg.content = message_config[200003].name
	msg.content = textUtils.connectParam(msg.content, {name})

	HallManager:resSysNoticeMsg(msg)
end

--玩家退出游戏通知
function HallManager:informPlayerExitGame(name)
	if message_config[200004] == nil then
		return
	end
	local msg = {}
	msg.content = message_config[200004].name
	msg.content = textUtils.connectParam(msg.content, {name})

	HallManager:resSysNoticeMsg(msg)
end

--请求进入当前游戏
function HallManager:reqEnterCurGame(gameid)
	if gameReqFunMap[gameid] and gameReqFunMap[gameid].ReqEnterGameHall then
		gameReqFunMap[gameid].ReqEnterGameHall()
	end
end

--当前游戏进入房间
--名称:roomId 类型:int 备注:房间id
function HallManager:reqEnterCurGameRoom(roomId)
	local gameid = get_player_info().curGameID
	if gameReqFunMap[gameid].ReqEnterRoom then
		gameReqFunMap[gameid].ReqEnterRoom({roomId = roomId})
	end
end

--当前游戏退出房间
function HallManager:reqExitCurGameRoom()
	local gameid = get_player_info().curGameID
	if gameReqFunMap[gameid].ReqExitRoom then
		gameReqFunMap[gameid].ReqExitRoom()
	end
end

--当前游戏进入桌子
--[[
	msg = {
		名称:tableId 类型:int 备注:牌桌id
		名称:order 类型:byte 备注:位置(0-1)
		名称:password 类型:String 备注:密码
	}
]]
function HallManager:reqEnterCurGameTable(msg)
	local gameid = get_player_info().curGameID
	if gameReqFunMap[gameid].ReqEnterTable then
		gameReqFunMap[gameid].ReqEnterTable(msg)
	end
end

--当前游戏退出桌子
function HallManager:reqExitCurGameTable()
	local gameid = get_player_info().curGameID
	if gameReqFunMap[gameid].ReqExitTable then
		gameReqFunMap[gameid].ReqExitTable()
	end
end

--当前游戏快速加入
function HallManager:reqQuickEnterCurGame()
	local gameid = get_player_info().curGameID
	local _playerInfo = get_player_info()

	if gameReqFunMap[gameid].ReqFastEnterTable and _playerInfo.myDesksInfo[1] then
		gameReqFunMap[gameid].ReqFastEnterTable({roomId = _playerInfo.myDesksInfo[1].roomId})
	end
end

--快速加入结果消息
function HallManager:resQuickEnterCurGame(msg)
	if msg.res == 1 then
		HallManager:reqExitCurGameRoom()
	end
end

--当前游戏兑换筹码
--名称:gold 类型:long 备注:兑换的筹码的金币数量
function HallManager:reqExchangeChips(gold)
	local gameid = get_player_info().curGameID
	if gameReqFunMap[gameid].ReqExchangeChips then
		gameReqFunMap[gameid].ReqExchangeChips({gold = gold})
	end
end

--当前游戏兑换金币
--名称:chips 类型:long 备注:兑换的金币的筹码数量
function HallManager:reqExchangeGold(chips)
	local gameid = get_player_info().curGameID
	if gameReqFunMap[gameid].ReqExchangeGolds then
		gameReqFunMap[gameid].ReqExchangeGolds({chips = chips})
	end
end

------------------------------------------------------------------------------------------消息处理---------------------------------------------------------------
--游客升级结果消息
function HallManager:resAccountUpgrade(msg)
	local pinfo = get_player_info()
	pinfo.is_tourist = false
	pinfo.name = msg.playerName
	print("player name " .. msg.playerName)
	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:upAccountSuccess()
	end
end


--[[
	房间座位变更信息消息
	msg = {
		名称:seat 类型:SeatInfo 备注:房间座位信息
			SeatInfo = {
				tableId, --桌子id
				order, --座位顺序
				playerId, --玩家id,0代表座位上没有人
			}
	}
]]
function HallManager:resSeatInfoUpdateMsg(msg)
	local tmpSeat = msg.seat
	local tmpMember = HallManager._members[msg.seat.playerId]
	--其余的数据从 member里面去拿
	if tmpMember then
		tmpSeat.sex = tmpMember.sex
		tmpSeat.icon = tmpMember.icon
		tmpSeat.playerName = tmpMember.playerName
		tmpSeat.state = tmpMember.state
		tmpSeat.gold = tmpMember.gold
        tmpSeat.cedit = tmpMember.cedit
		tmpSeat.chips = tmpMember.chips
		tmpSeat.sysHost = tmpMember.sysHost
        tmpSeat.vip = tmpMember.vip
	else--退桌子
		if long_compare(msg.seat.playerId, 0) ~= 0 then
			print("出错了，id不为0", msg.seat.playerId)
        else
            print("hallmanager  退桌成功")
		end
		tmpSeat.state = 0
	end

    get_player_info():updateDeskInfo(tmpSeat)

end

--[[
	房间成员变更信息消息
	msg = {
		名称:member 类型:MemInfo 备注:房间成员信息
	}
]]
function HallManager:resMemInfoUpdateMag(msg)
	local _playerInfo = get_player_info()
	_playerInfo:updateDeskInfo(msg.member)

	HallManager._members[msg.member.playerId] = msg.member
end

--[[
	删除房间成员信息消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
	}
]]
function HallManager:resRemoveMemInfoMsg(msg)
    HallManager._members[msg.playerId] = nil
end

--[[
	房间设置更新消息
	msg = {
		名称:roomSetting 类型:RoomSetting 备注:房间设置
	}
]]
function HallManager:resRoomSettingUpdateMsg(msg)
	HallManager._roomSettingData = msg.roomSetting
end

--[[
	进入房间结果消息
	msg = {
		名称:tables 类型:List<TableInfo> 备注:牌桌信息
        名称:members 类型:List<MemInfo> 备注:房间成员信息
	}
]]
function HallManager:resEnterRoomMsg(msg)
	HallManager._members = {}

	local orderMembers = {}
    for i,v in ipairs(msg.members) do
    	HallManager._members[v.playerId] = v

    	if player_is_myself(v.playerId) then
    		table.insert(orderMembers, 1, v)
    	else
    		table.insert(orderMembers, v)
    	end
    end
                                                                                          
	for i,tableinfo in ipairs(msg.tables) do
        for k,tmpSeat in pairs(tableinfo.seats) do
        	local tmpMember = HallManager._members[tmpSeat.playerId]
        	--其余的数据从 member里面去拿
			if tmpMember then
				tmpSeat.sex = tmpMember.sex
				tmpSeat.icon = tmpMember.icon
				tmpSeat.playerName = tmpMember.playerName
				tmpSeat.state = tmpMember.state
				tmpSeat.gold = tmpMember.gold
                tmpSeat.cedit = tmpMember.cedit
				tmpSeat.chips = tmpMember.chips
				tmpSeat.sysHost = tmpMember.sysHost
			else
				tmpSeat.state = 0
			end
        end
	end
	local _playerInfo = get_player_info()
	_playerInfo.myDesksInfo = msg.tables


	HallManager:reqQuickEnterCurGame()
end

--[[
退出房间
]]
function HallManager:resExitRoomMsg()
	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
end

--[[
退出比赛房间
]]
function HallManager:resExitMatchRoomMsg()
	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
end

--[[
获得玩家详细信息
msg = {
		名称:players 类型:List<long> 备注:牌桌中的玩家
	}
]]
function HallManager:getMemberInfos(msg)
	local members = {}
	for i,v in ipairs(msg.players) do

		if player_is_myself(v.playerId) then
			table.insert(members, 1, HallManager._members[v])
		else
			table.insert(members, HallManager._members[v])	
		end
	end

	return members
end

--[[
	进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
function HallManager:enterTableHandler(msg)
	local members = msg.mems

	--通知玩家进桌扣费
	--self:informPalyerFeeMsg()

    --更新房间信息栏
	-- local tableRightExt = WindowScene.getInstance():getModuleObjByClassName("CTableTalkExt")
	-- if tableRightExt then
	-- 	for i,v in ipairs(members) do
	-- 		tableRightExt:updateMemberInfo(v)
	-- 	end
	-- 	tableRightExt:sortPlayerObj()
	-- end

	--音效设置
	--audio_manager:initGameAudio()
end

--[[
	房间人数消息
	msg = {
		名称:roomId 类型:int 备注:房间
		名称:num 类型:int 备注:房间人数
	}
]]
function HallManager:resRoomPlayerNumMsg(msg)
	get_player_info():updateRoomInfo(msg.roomId, msg.num)

	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby and gamelobby.second_hall_ui_list then
		gamelobby.second_hall_ui_list:updateRoomInfo(msg.roomId, msg.num)
	end
end

--[[
	桌子密码已经改变消息消息
	msg = {
		名称:tableId 类型:int 备注:桌子id
		名称:hasPwd 类型:int 备注:0:没有密码,非0:有密码
	}
]]
function HallManager:resTablePwdChanged(msg)
	get_player_info():updateDeskPassWord( msg.tableId, msg.hasPwd )

	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		--更新房间桌子
		local game_room_obj = gamelobby.game_room_ui_list
		if game_room_obj then
			game_room_obj:upDateTablePassword(msg.tableId, msg.hasPwd)
		end
	end
end

---------------------------------------------------------------------------------------------------聊天相关
--[[
	房间聊天消息结果消息
	msg = {
		名称:content 类型:String 备注:内容
		名称:playerName 类型:String 备注:聊天的玩家
	}
]]
function HallManager:resRoomChatMsg(msg)

end

--[[
	桌子聊天消息结果消息
	msg = {
		名称:content 类型:String 备注:内容
		名称:playerName 类型:String 备注:聊天的玩家
	}
]]
function HallManager:resTableChatMsg(msg)

end

--[[
	喇叭消息消息
	msg = {
		名称:playerName 类型:String 备注:玩家昵称
		名称:content 类型:String 备注:内容
	}
]]
function HallManager:resHornMsg(msg)
	if msg.playerName ~= nil and msg.content ~= nil then
		CSystemMessage.addChatMsg(CSystemMessage.Channel_ID_Bugle, msg.playerName, msg.content,1)
	end
end

--[[
	聊天框系统公告消息消息
	msg = {
		名称:content 类型:String 备注:内容
	}
]]
function HallManager:resSysNoticeMsg(msg)
	if msg.playerName ~= nil and msg.content ~= nil then
		CSystemMessage.addChatMsg(CSystemMessage.Channel_ID_System, msg.playerName, msg.content,2)
	end
end

--[[
	跑马灯公告消息
	msg = {
		名称:content 类型:String 备注:内容
		名称:type 类型:int 备注:0:游戏公告,1:官方公告,3:删除消息
		名称:noticeid 类型:int 备注:消息id
	}
]]
function HallManager:resMarqueeNoticeMsg(msg)
	-- local item = {
	-- 	text = msg.content,
	-- 	type = msg.type,
	-- 	noticeid = msg.noticeid,
	-- }
	SystemNoticePro.showScrollTextPro(msg)
end


---------------------------------------------------------------------------大厅游戏列表

--[[
	游戏类型消息
	msg = {
		名称:types 类型:List<GameType> 备注:游戏类型
	}
]]
function HallManager:resGameTypesMsg(msg)
	_gameTypeMap = {}
	for i,v in ipairs(msg.types) do
		_gameTypeMap[v.type] = v
	end
end

--[[
	请求服务器进入桌子
]]
function HallManager:sendEnterTableMsg(msg)
	local playerInfo = get_player_info() 
    local curRoomInfo = playerInfo:get_cur_roomInfo()
    if long_compare(curRoomInfo.lower, playerInfo.gold) > 0 then
		TipsManager:showOneButtonTipsPanel(32, {}, true)
	else
		HallManager:reqEnterCurGameTable(msg)
	end
end

---------------------------------------------------------------------------排行榜数据

function HallManager:resRankListMsg(rankList)
    WaitMessageHit.closeWaitMessageHit()
	print(rankList)
    local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showRank(rankList)
	end
end

--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码

--[[
   商品列表
]]
function HallManager:resGoodsItem(msg)
    shop_goods_config = msg
end

--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码
-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

-- 阿修罗，你在六道轮回中或许只是一个瞬间，但是我很感谢你与我的相遇之缘。你所教给我的，那就是，人的本性就是通过吃掉其他生命而活下去。夺走出生于大海的生命，夺走生于山野的生命，人就是靠这个活下去。背负着罪恶，即使那样也在有限的生命中拼命地活下去。正因为那样，这个世界才如此美丽！