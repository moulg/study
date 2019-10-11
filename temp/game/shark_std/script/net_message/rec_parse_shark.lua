--[[
	BetInfo ={
		名称:icon 类型:int 备注:图标
		名称:bet 类型:long 备注:下注筹码
	}
]]
function read_com_wly_game_games_shark_dto_BetInfo(sobj)
	local obj = {};
	obj.icon = sobj:readInt()
	obj.bet = sobj:readLong()
	
	return obj		
end

--[[
	RoomTypeDetailInfo ={
		名称:type 类型:int 备注:房间类型id
		名称:typeName 类型:String 备注:房间类型名称
		名称:rooms 类型:List<RoomInfo> 备注:房间
	}
]]
function read_com_wly_game_games_shark_dto_RoomTypeDetailInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.typeName = sobj:readString()
	local roomsSize = sobj:readInt()
	obj.rooms = {}
	for i=1, roomsSize do  
		obj.rooms[i] = read_com_wly_game_games_shark_dto_RoomInfo(sobj)
	end 	
	
	return obj		
end

--[[
	RoomInfo ={
		名称:roomId 类型:int 备注:房间id
		名称:name 类型:String 备注:房间名称
		名称:type 类型:int 备注:房间类型
		名称:maxNum 类型:int 备注:房间最大人数
		名称:free 类型:int 备注:空闲状态人数
		名称:general 类型:int 备注:普通状态人数
		名称:crowded 类型:int 备注:拥挤状态人数
		名称:lower 类型:int 备注:进入下限
		名称:upper 类型:int 备注:进入上限
		名称:proportionGold 类型:int 备注:金币比例
		名称:proportionChips 类型:int 备注:筹码比例
		名称:tabble 类型:int 备注:每桌椅子数
		名称:maxOne 类型:int 备注:单局上限（筹码）
		名称:minOne 类型:int 备注:单局下限（筹码）
		名称:afee 类型:int 备注:单局台费
		名称:inType 类型:int 备注:进入类型（0点击入座，1自动分配）
		名称:playerNum 类型:int 备注:玩家人数
		名称:status 类型:String 备注:状态(空闲,普通,拥挤,爆满)
		名称:displayNames 类型:String 备注:展示的属性名称
		名称:placeHolder 类型:String 备注:展示的属性名称占位符
	}
]]
function read_com_wly_game_games_shark_dto_RoomInfo(sobj)
	local obj = {};
	obj.roomId = sobj:readInt()
	obj.name = sobj:readString()
	obj.type = sobj:readInt()
	obj.maxNum = sobj:readInt()
	obj.free = sobj:readInt()
	obj.general = sobj:readInt()
	obj.crowded = sobj:readInt()
	obj.lower = sobj:readInt()
	obj.upper = sobj:readInt()
	obj.proportionGold = sobj:readInt()
	obj.proportionChips = sobj:readInt()
	obj.tabble = sobj:readInt()
	obj.maxOne = sobj:readInt()
	obj.minOne = sobj:readInt()
	obj.afee = sobj:readInt()
	obj.inType = sobj:readInt()
	obj.playerNum = sobj:readInt()
	obj.status = sobj:readString()
	obj.displayNames = sobj:readString()
	obj.placeHolder = sobj:readString()
	
	return obj		
end

--[[
	IconRateInfo ={
		名称:icon 类型:int 备注:图标
		名称:rate 类型:int 备注:图标倍率
	}
]]
function read_com_wly_game_games_shark_dto_IconRateInfo(sobj)
	local obj = {};
	obj.icon = sobj:readInt()
	obj.rate = sobj:readInt()
	
	return obj		
end



--[[
	进入游戏大厅返回房间数据
	msg ={
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function rec_parse_shark_ResEnterGameHall(sobj)

	if sobj then
		local msg = {}
		local roomTypesSize = sobj:readInt()
		msg.roomTypes = {}
		for i=1, roomTypesSize do  
			msg.roomTypes[i] = read_com_wly_game_games_shark_dto_RoomTypeDetailInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	玩家筹码变化消息
	msg ={
		名称:order 类型:int 备注:座位顺序
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
function rec_parse_shark_ResChipsChange(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.chips = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	休息阶段消息
	msg ={
		名称:time 类型:int 备注:时间(秒)
		名称:iconRateInfos 类型:List<IconRateInfo> 备注:图标倍率信息
	}
]]
function rec_parse_shark_ResRestStage(sobj)

	if sobj then
		local msg = {}
		msg.time = sobj:readInt()
		local iconRateInfosSize = sobj:readInt()
		msg.iconRateInfos = {}
		for i=1, iconRateInfosSize do  
			msg.iconRateInfos[i] = read_com_wly_game_games_shark_dto_IconRateInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	下注阶段消息
	msg ={
		名称:time 类型:int 备注:时间(秒)
		名称:iconRateInfos 类型:List<IconRateInfo> 备注:图标倍率信息
	}
]]
function rec_parse_shark_ResBetStage(sobj)

	if sobj then
		local msg = {}
		msg.time = sobj:readInt()
		local iconRateInfosSize = sobj:readInt()
		msg.iconRateInfos = {}
		for i=1, iconRateInfosSize do  
			msg.iconRateInfos[i] = read_com_wly_game_games_shark_dto_IconRateInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	游戏阶段消息
	msg ={
		名称:firstIconIndex 类型:int 备注:第一次中奖图标位置(如果中的是金沙或者银沙会有第二次转动)，如果是中途进入游戏则是0
		名称:secondIconIndex 类型:int 备注:第二次中奖图标位置
		名称:firstTime 类型:int 备注:第一次中奖游戏时间
		名称:secondTime 类型:int 备注:第二次中奖游戏时间
		名称:playerBillChips 类型:long 备注:玩家的收益
		名称:bankerBillChips 类型:long 备注:庄家收益
	}
]]
function rec_parse_shark_ResGameStage(sobj)

	if sobj then
		local msg = {}
		msg.firstIconIndex = sobj:readInt()
		msg.secondIconIndex = sobj:readInt()
		msg.firstTime = sobj:readInt()
		msg.secondTime = sobj:readInt()
		msg.playerBillChips = sobj:readLong()
		msg.bankerBillChips = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	玩家申请庄家列表
	msg ={
		名称:applicants 类型:List<long> 备注:申请人
	}
]]
function rec_parse_shark_ResApplyBankers(sobj)

	if sobj then
		local msg = {}
		local applicantsSize = sobj:readInt()
		msg.applicants = {}
		for i=1, applicantsSize do  
			msg.applicants[i] = sobj:readLong()
		end 	
		return msg
	end
	return nil
end


--[[
	庄家信息
	msg ={
		名称:playerId 类型:long 备注:庄家id
		名称:name 类型:String 备注:昵称
		名称:chips 类型:long 备注:筹码
		名称:num 类型:int 备注:局数
		名称:score 类型:long 备注:成绩
		名称:sex 类型:int 备注:性别
	}
]]
function rec_parse_shark_ResBankerInfo(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.name = sobj:readString()
		msg.chips = sobj:readLong()
		msg.num = sobj:readInt()
		msg.score = sobj:readLong()
		msg.sex = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	进入房间结果
	msg ={
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
function rec_parse_shark_ResEnterRoom(sobj)

	if sobj then
		local msg = {}
		local tablesSize = sobj:readInt()
		msg.tables = {}
		for i=1, tablesSize do  
			msg.tables[i] = read_com_wly_game_gamehall_dto_TableInfo(sobj)
		end 	
		local membersSize = sobj:readInt()
		msg.members = {}
		for i=1, membersSize do  
			msg.members[i] = read_com_wly_game_gamehall_dto_MemInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	进入牌桌结果
	msg ={
		名称:historyRewardIcons 类型:List<int> 备注:历史中奖图标
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
function rec_parse_shark_ResEnterTable(sobj)

	if sobj then
		local msg = {}
		local historyRewardIconsSize = sobj:readInt()
		msg.historyRewardIcons = {}
		for i=1, historyRewardIconsSize do  
			msg.historyRewardIcons[i] = sobj:readInt()
		end 	
		local memsSize = sobj:readInt()
		msg.mems = {}
		for i=1, memsSize do  
			msg.mems[i] = read_com_wly_game_gamehall_dto_MemInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	玩家请求退出房间
	msg ={
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
function rec_parse_shark_ResExitRoom(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	玩家请求退出房间牌桌结果
	msg ={
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
function rec_parse_shark_ResExitTable(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.playerId = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	桌子下注信息
	msg ={
		名称:betInfos 类型:List<BetInfo> 备注:下注信息
	}
]]
function rec_parse_shark_ResTableBetInfos(sobj)

	if sobj then
		local msg = {}
		local betInfosSize = sobj:readInt()
		msg.betInfos = {}
		for i=1, betInfosSize do  
			msg.betInfos[i] = read_com_wly_game_games_shark_dto_BetInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	玩家下注成功
	msg ={
		名称:betInfo 类型:BetInfo 备注:下注信息
	}
]]
function rec_parse_shark_ResBet(sobj)

	if sobj then
		local msg = {}
		msg.betInfo = read_com_wly_game_games_shark_dto_BetInfo(sobj)
		return msg
	end
	return nil
end


--[[
	清空下注结果
	msg ={
		名称:res 类型:int 备注:结果(0:成功,1:下注阶段不能清除下注)
	}
]]
function rec_parse_shark_ResClearBet(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求游戏阶段结果
	msg ={
	}
]]
function rec_parse_shark_ResStage(sobj)

	if sobj then
		local msg = {}
		return msg
	end
	return nil
end


--[[
	玩家请求快速进入房间牌桌结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
function rec_parse_shark_ResFastEnterTable(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


s2c_shark_ResEnterGameHall_msg = 509201 --[[进入游戏大厅返回房间数据]]
s2c_shark_ResChipsChange_msg = 509202 --[[玩家筹码变化消息]]
s2c_shark_ResRestStage_msg = 509203 --[[休息阶段消息]]
s2c_shark_ResBetStage_msg = 509204 --[[下注阶段消息]]
s2c_shark_ResGameStage_msg = 509205 --[[游戏阶段消息]]
s2c_shark_ResApplyBankers_msg = 509206 --[[玩家申请庄家列表]]
s2c_shark_ResBankerInfo_msg = 509207 --[[庄家信息]]
s2c_shark_ResEnterRoom_msg = 509209 --[[进入房间结果]]
s2c_shark_ResEnterTable_msg = 509210 --[[进入牌桌结果]]
s2c_shark_ResExitRoom_msg = 509211 --[[玩家请求退出房间]]
s2c_shark_ResExitTable_msg = 509212 --[[玩家请求退出房间牌桌结果]]
s2c_shark_ResTableBetInfos_msg = 509213 --[[桌子下注信息]]
s2c_shark_ResBet_msg = 509214 --[[玩家下注成功]]
s2c_shark_ResClearBet_msg = 509215 --[[清空下注结果]]
s2c_shark_ResStage_msg = 509216 --[[请求游戏阶段结果]]
s2c_shark_ResFastEnterTable_msg = 509227 --[[玩家请求快速进入房间牌桌结果]]

ReceiveMsg.regParseRecMsg(509201, rec_parse_shark_ResEnterGameHall)--[[进入游戏大厅返回房间数据]]
ReceiveMsg.regParseRecMsg(509202, rec_parse_shark_ResChipsChange)--[[玩家筹码变化消息]]
ReceiveMsg.regParseRecMsg(509203, rec_parse_shark_ResRestStage)--[[休息阶段消息]]
ReceiveMsg.regParseRecMsg(509204, rec_parse_shark_ResBetStage)--[[下注阶段消息]]
ReceiveMsg.regParseRecMsg(509205, rec_parse_shark_ResGameStage)--[[游戏阶段消息]]
ReceiveMsg.regParseRecMsg(509206, rec_parse_shark_ResApplyBankers)--[[玩家申请庄家列表]]
ReceiveMsg.regParseRecMsg(509207, rec_parse_shark_ResBankerInfo)--[[庄家信息]]
ReceiveMsg.regParseRecMsg(509209, rec_parse_shark_ResEnterRoom)--[[进入房间结果]]
ReceiveMsg.regParseRecMsg(509210, rec_parse_shark_ResEnterTable)--[[进入牌桌结果]]
ReceiveMsg.regParseRecMsg(509211, rec_parse_shark_ResExitRoom)--[[玩家请求退出房间]]
ReceiveMsg.regParseRecMsg(509212, rec_parse_shark_ResExitTable)--[[玩家请求退出房间牌桌结果]]
ReceiveMsg.regParseRecMsg(509213, rec_parse_shark_ResTableBetInfos)--[[桌子下注信息]]
ReceiveMsg.regParseRecMsg(509214, rec_parse_shark_ResBet)--[[玩家下注成功]]
ReceiveMsg.regParseRecMsg(509215, rec_parse_shark_ResClearBet)--[[清空下注结果]]
ReceiveMsg.regParseRecMsg(509216, rec_parse_shark_ResStage)--[[请求游戏阶段结果]]
ReceiveMsg.regParseRecMsg(509227, rec_parse_shark_ResFastEnterTable)--[[玩家请求快速进入房间牌桌结果]]
