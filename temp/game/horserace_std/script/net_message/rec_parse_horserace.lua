--[[
	HorseDetail ={
		名称:horseId 类型:int 备注:赛马ID
		名称:totalTime 类型:int 备注:总时间
		名称:segement 类型:int 备注:总时间
		名称:perTime 类型:List<int> 备注:每一段的时间
	}
]]
function read_com_wly_game_games_horserace_dto_HorseDetail(sobj)
	local obj = {};
	obj.horseId = sobj:readInt()
	obj.totalTime = sobj:readInt()
	obj.segement = sobj:readInt()
	local perTimeSize = sobj:readInt()
	obj.perTime = {}
	for i=1, perTimeSize do  
		obj.perTime[i] = sobj:readInt()
	end 	
	
	return obj		
end

--[[
	BetInfo ={
		名称:area 类型:int 备注:下注区域
		名称:chips 类型:long 备注:下注筹码
	}
]]
function read_com_wly_game_games_horserace_dto_BetInfo(sobj)
	local obj = {};
	obj.area = sobj:readInt()
	obj.chips = sobj:readLong()
	
	return obj		
end

--[[
	IconMultiple ={
		名称:areId 类型:int 备注:区域ID
		名称:rate 类型:int 备注:区域对应倍率
	}
]]
function read_com_wly_game_games_horserace_dto_IconMultiple(sobj)
	local obj = {};
	obj.areId = sobj:readInt()
	obj.rate = sobj:readInt()
	
	return obj		
end

--[[
	RoomTypeDetailInfo ={
		名称:type 类型:int 备注:房间类型id
		名称:typeName 类型:String 备注:房间类型名称
		名称:rooms 类型:List<RoomInfo> 备注:房间
	}
]]
function read_com_wly_game_games_horserace_dto_RoomTypeDetailInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.typeName = sobj:readString()
	local roomsSize = sobj:readInt()
	obj.rooms = {}
	for i=1, roomsSize do  
		obj.rooms[i] = read_com_wly_game_games_horserace_dto_RoomInfo(sobj)
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
function read_com_wly_game_games_horserace_dto_RoomInfo(sobj)
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
	BillInfo ={
		名称:order 类型:int 备注:座位顺序
		名称:chips 类型:long 备注:结算筹码
	}
]]
function read_com_wly_game_games_horserace_dto_BillInfo(sobj)
	local obj = {};
	obj.order = sobj:readInt()
	obj.chips = sobj:readLong()
	
	return obj		
end



--[[
	进入游戏大厅返回房间数据
	msg ={
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function rec_parse_horserace_ResEnterGameHall(sobj)

	if sobj then
		local msg = {}
		local roomTypesSize = sobj:readInt()
		msg.roomTypes = {}
		for i=1, roomTypesSize do  
			msg.roomTypes[i] = read_com_wly_game_games_horserace_dto_RoomTypeDetailInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	玩家筹码变化消息
	msg ={
		名称:playerId 类型:long 备注:玩家ID
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
function rec_parse_horserace_ResChipsChange(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.chips = sobj:readLong()
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
function rec_parse_horserace_ResFastEnterTable(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
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
function rec_parse_horserace_ResEnterRoom(sobj)

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
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
function rec_parse_horserace_ResEnterTable(sobj)

	if sobj then
		local msg = {}
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
function rec_parse_horserace_ResExitRoom(sobj)

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
function rec_parse_horserace_ResExitTable(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.playerId = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	返回倍率结果
	msg ={
		名称:iconMultiple 类型:List<IconMultiple> 备注:本局每个区域的倍率
	}
]]
function rec_parse_horserace_ResMultiple(sobj)

	if sobj then
		local msg = {}
		local iconMultipleSize = sobj:readInt()
		msg.iconMultiple = {}
		for i=1, iconMultipleSize do  
			msg.iconMultiple[i] = read_com_wly_game_games_horserace_dto_IconMultiple(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	赛马跑动数据
	msg ={
		名称:horseDetail 类型:List<HorseDetail> 备注:每匹马的数据
	}
]]
function rec_parse_horserace_ResHorseDetail(sobj)

	if sobj then
		local msg = {}
		local horseDetailSize = sobj:readInt()
		msg.horseDetail = {}
		for i=1, horseDetailSize do  
			msg.horseDetail[i] = read_com_wly_game_games_horserace_dto_HorseDetail(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	其他人进入桌子
	msg ={
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
function rec_parse_horserace_ResOtherEnterTable(sobj)

	if sobj then
		local msg = {}
		msg.mem = read_com_wly_game_gamehall_dto_MemInfo(sobj)
		return msg
	end
	return nil
end


--[[
	返回下注结果
	msg ={
		名称:area 类型:int 备注:下注区域  闲家1-15
		名称:chips 类型:long 备注:对应的筹码
	}
]]
function rec_parse_horserace_ResBet(sobj)

	if sobj then
		local msg = {}
		msg.area = sobj:readInt()
		msg.chips = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	桌子筹码变化
	msg ={
		名称:betInfo 类型:List<BetInfo> 备注:桌上筹码信息
	}
]]
function rec_parse_horserace_ResTableBet(sobj)

	if sobj then
		local msg = {}
		local betInfoSize = sobj:readInt()
		msg.betInfo = {}
		for i=1, betInfoSize do  
			msg.betInfo[i] = read_com_wly_game_games_horserace_dto_BetInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	通知客户端计时
	msg ={
		名称:state 类型:int 备注:告知客户端游戏进行到的阶段
		名称:time 类型:int 备注:计时时间(单位秒)
	}
]]
function rec_parse_horserace_ResTime(sobj)

	if sobj then
		local msg = {}
		msg.state = sobj:readInt()
		msg.time = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	历史输赢记录
	msg ={
		名称:result 类型:List<int> 备注:闲家对庄家的输赢记录
	}
]]
function rec_parse_horserace_ResHistory(sobj)

	if sobj then
		local msg = {}
		local resultSize = sobj:readInt()
		msg.result = {}
		for i=1, resultSize do  
			msg.result[i] = sobj:readInt()
		end 	
		return msg
	end
	return nil
end


--[[
	返回结算结果
	msg ={
		名称:playerChips 类型:long 备注:玩家结算筹码
	}
]]
function rec_parse_horserace_ResBalance(sobj)

	if sobj then
		local msg = {}
		msg.playerChips = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	场景消息
	msg ={
		名称:sceneId 类型:int 备注:场景ID
	}
]]
function rec_parse_horserace_ResScene(sobj)

	if sobj then
		local msg = {}
		msg.sceneId = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	返回开奖结果
	msg ={
		名称:areID 类型:int 备注:中奖区域
	}
]]
function rec_parse_horserace_ResReward(sobj)

	if sobj then
		local msg = {}
		msg.areID = sobj:readInt()
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
function rec_parse_horserace_ResClearBet(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


s2c_horserace_ResEnterGameHall_msg = 516201 --[[进入游戏大厅返回房间数据]]
s2c_horserace_ResChipsChange_msg = 516202 --[[玩家筹码变化消息]]
s2c_horserace_ResFastEnterTable_msg = 516210 --[[玩家请求快速进入房间牌桌结果]]
s2c_horserace_ResEnterRoom_msg = 516211 --[[进入房间结果]]
s2c_horserace_ResEnterTable_msg = 516212 --[[进入牌桌结果]]
s2c_horserace_ResExitRoom_msg = 516215 --[[玩家请求退出房间]]
s2c_horserace_ResExitTable_msg = 516216 --[[玩家请求退出房间牌桌结果]]
s2c_horserace_ResMultiple_msg = 516217 --[[返回倍率结果]]
s2c_horserace_ResHorseDetail_msg = 516218 --[[赛马跑动数据]]
s2c_horserace_ResOtherEnterTable_msg = 516219 --[[其他人进入桌子]]
s2c_horserace_ResBet_msg = 516221 --[[返回下注结果]]
s2c_horserace_ResTableBet_msg = 516222 --[[桌子筹码变化]]
s2c_horserace_ResTime_msg = 516225 --[[通知客户端计时]]
s2c_horserace_ResHistory_msg = 516226 --[[历史输赢记录]]
s2c_horserace_ResBalance_msg = 516227 --[[返回结算结果]]
s2c_horserace_ResScene_msg = 516228 --[[场景消息]]
s2c_horserace_ResReward_msg = 516230 --[[返回开奖结果]]
s2c_horserace_ResClearBet_msg = 516231 --[[清空下注结果]]

ReceiveMsg.regParseRecMsg(516201, rec_parse_horserace_ResEnterGameHall)--[[进入游戏大厅返回房间数据]]
ReceiveMsg.regParseRecMsg(516202, rec_parse_horserace_ResChipsChange)--[[玩家筹码变化消息]]
ReceiveMsg.regParseRecMsg(516210, rec_parse_horserace_ResFastEnterTable)--[[玩家请求快速进入房间牌桌结果]]
ReceiveMsg.regParseRecMsg(516211, rec_parse_horserace_ResEnterRoom)--[[进入房间结果]]
ReceiveMsg.regParseRecMsg(516212, rec_parse_horserace_ResEnterTable)--[[进入牌桌结果]]
ReceiveMsg.regParseRecMsg(516215, rec_parse_horserace_ResExitRoom)--[[玩家请求退出房间]]
ReceiveMsg.regParseRecMsg(516216, rec_parse_horserace_ResExitTable)--[[玩家请求退出房间牌桌结果]]
ReceiveMsg.regParseRecMsg(516217, rec_parse_horserace_ResMultiple)--[[返回倍率结果]]
ReceiveMsg.regParseRecMsg(516218, rec_parse_horserace_ResHorseDetail)--[[赛马跑动数据]]
ReceiveMsg.regParseRecMsg(516219, rec_parse_horserace_ResOtherEnterTable)--[[其他人进入桌子]]
ReceiveMsg.regParseRecMsg(516221, rec_parse_horserace_ResBet)--[[返回下注结果]]
ReceiveMsg.regParseRecMsg(516222, rec_parse_horserace_ResTableBet)--[[桌子筹码变化]]
ReceiveMsg.regParseRecMsg(516225, rec_parse_horserace_ResTime)--[[通知客户端计时]]
ReceiveMsg.regParseRecMsg(516226, rec_parse_horserace_ResHistory)--[[历史输赢记录]]
ReceiveMsg.regParseRecMsg(516227, rec_parse_horserace_ResBalance)--[[返回结算结果]]
ReceiveMsg.regParseRecMsg(516228, rec_parse_horserace_ResScene)--[[场景消息]]
ReceiveMsg.regParseRecMsg(516230, rec_parse_horserace_ResReward)--[[返回开奖结果]]
ReceiveMsg.regParseRecMsg(516231, rec_parse_horserace_ResClearBet)--[[清空下注结果]]
