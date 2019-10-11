--[[
	BetInfo ={
		名称:area 类型:int 备注:下注区域
		名称:chips 类型:long 备注:下注筹码
	}
]]
function read_com_wly_game_games_baccarat_dto_BetInfo(sobj)
	local obj = {};
	obj.area = sobj:readInt()
	obj.chips = sobj:readLong()
	
	return obj		
end

--[[
	IconMultiple ={
		名称:areaId 类型:int 备注:图标ID
		名称:rate 类型:int 备注:图标倍率(客户端缩小100倍后显示)
	}
]]
function read_com_wly_game_games_baccarat_dto_IconMultiple(sobj)
	local obj = {};
	obj.areaId = sobj:readInt()
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
function read_com_wly_game_games_baccarat_dto_RoomTypeDetailInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.typeName = sobj:readString()
	local roomsSize = sobj:readInt()
	obj.rooms = {}
	for i=1, roomsSize do  
		obj.rooms[i] = read_com_wly_game_games_baccarat_dto_RoomInfo(sobj)
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
function read_com_wly_game_games_baccarat_dto_RoomInfo(sobj)
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
function read_com_wly_game_games_baccarat_dto_BillInfo(sobj)
	local obj = {};
	obj.order = sobj:readInt()
	obj.chips = sobj:readLong()
	
	return obj		
end

--[[
	CardsInfo ={
		名称:cards 类型:List<int> 备注:庄家闲家牌
		名称:id 类型:int 备注:0庄家，1闲家
		名称:cardsType 类型:int 备注:牌型
		名称:point 类型:int 备注:点数
	}
]]
function read_com_wly_game_games_baccarat_dto_CardsInfo(sobj)
	local obj = {};
	local cardsSize = sobj:readInt()
	obj.cards = {}
	for i=1, cardsSize do  
		obj.cards[i] = sobj:readInt()
	end 	
	obj.id = sobj:readInt()
	obj.cardsType = sobj:readInt()
	obj.point = sobj:readInt()
	
	return obj		
end



--[[
	进入游戏大厅返回房间数据
	msg ={
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function rec_parse_baccarat_ResEnterGameHall(sobj)

	if sobj then
		local msg = {}
		local roomTypesSize = sobj:readInt()
		msg.roomTypes = {}
		for i=1, roomTypesSize do  
			msg.roomTypes[i] = read_com_wly_game_games_baccarat_dto_RoomTypeDetailInfo(sobj)
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
function rec_parse_baccarat_ResChipsChange(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.chips = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	玩家准备
	msg ={
		名称:order 类型:int 备注:座位顺序
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
function rec_parse_baccarat_ResReady(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求交换桌子
	msg ={
		名称:res 类型:int 备注:0:成功,1:已经准备不能交换桌子,2:当前房间没有空位置
	}
]]
function rec_parse_baccarat_ResExchangeTable(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
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
function rec_parse_baccarat_ResFastEnterTable(sobj)

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
function rec_parse_baccarat_ResEnterRoom(sobj)

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
function rec_parse_baccarat_ResEnterTable(sobj)

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
function rec_parse_baccarat_ResExitRoom(sobj)

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
function rec_parse_baccarat_ResExitTable(sobj)

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
		名称:iconMulti 类型:List<IconMultiple> 备注:本局所开出的倍率
	}
]]
function rec_parse_baccarat_ResMultiple(sobj)

	if sobj then
		local msg = {}
		local iconMultiSize = sobj:readInt()
		msg.iconMulti = {}
		for i=1, iconMultiSize do  
			msg.iconMulti[i] = read_com_wly_game_games_baccarat_dto_IconMultiple(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	发牌
	msg ={
		名称:cardsInfo 类型:List<CardsInfo> 备注:牌信息
		名称:cardIndex 类型:int 备注:牌序(发到第多少张牌了)
		名称:leftNum 类型:int 备注:上一局剩余多少牌 (总共六张,发剩余了多少)
		名称:yellowCard 类型:int 备注:是否发到了黄牌(1是0否)
	}
]]
function rec_parse_baccarat_ResDealCards(sobj)

	if sobj then
		local msg = {}
		local cardsInfoSize = sobj:readInt()
		msg.cardsInfo = {}
		for i=1, cardsInfoSize do  
			msg.cardsInfo[i] = read_com_wly_game_games_baccarat_dto_CardsInfo(sobj)
		end 	
		msg.cardIndex = sobj:readInt()
		msg.leftNum = sobj:readInt()
		msg.yellowCard = sobj:readInt()
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
function rec_parse_baccarat_ResOtherEnterTable(sobj)

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
		名称:area 类型:int 备注:下注区域  闲家1-11
		名称:chips 类型:long 备注:对应的筹码
	}
]]
function rec_parse_baccarat_ResBet(sobj)

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
function rec_parse_baccarat_ResTableBet(sobj)

	if sobj then
		local msg = {}
		local betInfoSize = sobj:readInt()
		msg.betInfo = {}
		for i=1, betInfoSize do  
			msg.betInfo[i] = read_com_wly_game_games_baccarat_dto_BetInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	结果统计信息
	msg ={
		名称:bankerWin 类型:int 备注:庄赢
		名称:playerWin 类型:int 备注:闲赢
		名称:tie 类型:int 备注:和
		名称:bankerPaire 类型:int 备注:庄对
		名称:playerPaire 类型:int 备注:闲对
		名称:dragon 类型:int 备注:龙
		名称:tiger 类型:int 备注:虎
		名称:dragonTigerTie 类型:int 备注:龙虎和
		名称:score 类型:int 备注:总局数
	}
]]
function rec_parse_baccarat_ResBankerInfo(sobj)

	if sobj then
		local msg = {}
		msg.bankerWin = sobj:readInt()
		msg.playerWin = sobj:readInt()
		msg.tie = sobj:readInt()
		msg.bankerPaire = sobj:readInt()
		msg.playerPaire = sobj:readInt()
		msg.dragon = sobj:readInt()
		msg.tiger = sobj:readInt()
		msg.dragonTigerTie = sobj:readInt()
		msg.score = sobj:readInt()
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
function rec_parse_baccarat_ResTime(sobj)

	if sobj then
		local msg = {}
		msg.state = sobj:readInt()
		msg.time = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	历史路单记录
	msg ={
		名称:hisWaybill 类型:List<int> 备注:历史路单记录
		名称:hisDragon 类型:List<int> 备注:历史龙虎记录
		名称:hisBigSmall 类型:List<int> 备注:历史大小记录
	}
]]
function rec_parse_baccarat_ResHistory(sobj)

	if sobj then
		local msg = {}
		local hisWaybillSize = sobj:readInt()
		msg.hisWaybill = {}
		for i=1, hisWaybillSize do  
			msg.hisWaybill[i] = sobj:readInt()
		end 	
		local hisDragonSize = sobj:readInt()
		msg.hisDragon = {}
		for i=1, hisDragonSize do  
			msg.hisDragon[i] = sobj:readInt()
		end 	
		local hisBigSmallSize = sobj:readInt()
		msg.hisBigSmall = {}
		for i=1, hisBigSmallSize do  
			msg.hisBigSmall[i] = sobj:readInt()
		end 	
		return msg
	end
	return nil
end


--[[
	返回结算结果
	msg ={
		名称:bankerChips 类型:long 备注:庄家结算筹码
		名称:playerChips 类型:long 备注:玩家结算筹码
	}
]]
function rec_parse_baccarat_ResBalance(sobj)

	if sobj then
		local msg = {}
		msg.bankerChips = sobj:readLong()
		msg.playerChips = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	开出的结果
	msg ={
		名称:result 类型:List<int> 备注:开出结果列表
	}
]]
function rec_parse_baccarat_ResResult(sobj)

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
	清空下注结果
	msg ={
		名称:res 类型:int 备注:结果(0:成功,1:下注阶段不能清除下注)
	}
]]
function rec_parse_baccarat_ResClearBet(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	切牌信息(切出来的12张牌)
	msg ={
		名称:cardsInfo 类型:List<int> 备注:牌信息
	}
]]
function rec_parse_baccarat_ResCutCards(sobj)

	if sobj then
		local msg = {}
		local cardsInfoSize = sobj:readInt()
		msg.cardsInfo = {}
		for i=1, cardsInfoSize do  
			msg.cardsInfo[i] = sobj:readInt()
		end 	
		return msg
	end
	return nil
end


s2c_baccarat_ResEnterGameHall_msg = 518201 --[[进入游戏大厅返回房间数据]]
s2c_baccarat_ResChipsChange_msg = 518202 --[[玩家筹码变化消息]]
s2c_baccarat_ResReady_msg = 518204 --[[玩家准备]]
s2c_baccarat_ResExchangeTable_msg = 518205 --[[请求交换桌子]]
s2c_baccarat_ResFastEnterTable_msg = 518210 --[[玩家请求快速进入房间牌桌结果]]
s2c_baccarat_ResEnterRoom_msg = 518211 --[[进入房间结果]]
s2c_baccarat_ResEnterTable_msg = 518212 --[[进入牌桌结果]]
s2c_baccarat_ResExitRoom_msg = 518215 --[[玩家请求退出房间]]
s2c_baccarat_ResExitTable_msg = 518216 --[[玩家请求退出房间牌桌结果]]
s2c_baccarat_ResMultiple_msg = 518217 --[[返回倍率结果]]
s2c_baccarat_ResDealCards_msg = 518218 --[[发牌]]
s2c_baccarat_ResOtherEnterTable_msg = 518219 --[[其他人进入桌子]]
s2c_baccarat_ResBet_msg = 518221 --[[返回下注结果]]
s2c_baccarat_ResTableBet_msg = 518222 --[[桌子筹码变化]]
s2c_baccarat_ResBankerInfo_msg = 518224 --[[结果统计信息]]
s2c_baccarat_ResTime_msg = 518225 --[[通知客户端计时]]
s2c_baccarat_ResHistory_msg = 518226 --[[历史路单记录]]
s2c_baccarat_ResBalance_msg = 518227 --[[返回结算结果]]
s2c_baccarat_ResResult_msg = 518228 --[[开出的结果]]
s2c_baccarat_ResClearBet_msg = 518231 --[[清空下注结果]]
s2c_baccarat_ResCutCards_msg = 518232 --[[切牌信息(切出来的12张牌)]]

ReceiveMsg.regParseRecMsg(518201, rec_parse_baccarat_ResEnterGameHall)--[[进入游戏大厅返回房间数据]]
ReceiveMsg.regParseRecMsg(518202, rec_parse_baccarat_ResChipsChange)--[[玩家筹码变化消息]]
ReceiveMsg.regParseRecMsg(518204, rec_parse_baccarat_ResReady)--[[玩家准备]]
ReceiveMsg.regParseRecMsg(518205, rec_parse_baccarat_ResExchangeTable)--[[请求交换桌子]]
ReceiveMsg.regParseRecMsg(518210, rec_parse_baccarat_ResFastEnterTable)--[[玩家请求快速进入房间牌桌结果]]
ReceiveMsg.regParseRecMsg(518211, rec_parse_baccarat_ResEnterRoom)--[[进入房间结果]]
ReceiveMsg.regParseRecMsg(518212, rec_parse_baccarat_ResEnterTable)--[[进入牌桌结果]]
ReceiveMsg.regParseRecMsg(518215, rec_parse_baccarat_ResExitRoom)--[[玩家请求退出房间]]
ReceiveMsg.regParseRecMsg(518216, rec_parse_baccarat_ResExitTable)--[[玩家请求退出房间牌桌结果]]
ReceiveMsg.regParseRecMsg(518217, rec_parse_baccarat_ResMultiple)--[[返回倍率结果]]
ReceiveMsg.regParseRecMsg(518218, rec_parse_baccarat_ResDealCards)--[[发牌]]
ReceiveMsg.regParseRecMsg(518219, rec_parse_baccarat_ResOtherEnterTable)--[[其他人进入桌子]]
ReceiveMsg.regParseRecMsg(518221, rec_parse_baccarat_ResBet)--[[返回下注结果]]
ReceiveMsg.regParseRecMsg(518222, rec_parse_baccarat_ResTableBet)--[[桌子筹码变化]]
ReceiveMsg.regParseRecMsg(518224, rec_parse_baccarat_ResBankerInfo)--[[结果统计信息]]
ReceiveMsg.regParseRecMsg(518225, rec_parse_baccarat_ResTime)--[[通知客户端计时]]
ReceiveMsg.regParseRecMsg(518226, rec_parse_baccarat_ResHistory)--[[历史路单记录]]
ReceiveMsg.regParseRecMsg(518227, rec_parse_baccarat_ResBalance)--[[返回结算结果]]
ReceiveMsg.regParseRecMsg(518228, rec_parse_baccarat_ResResult)--[[开出的结果]]
ReceiveMsg.regParseRecMsg(518231, rec_parse_baccarat_ResClearBet)--[[清空下注结果]]
ReceiveMsg.regParseRecMsg(518232, rec_parse_baccarat_ResCutCards)--[[切牌信息(切出来的12张牌)]]
