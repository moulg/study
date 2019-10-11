--[[
	RoomTypeDetailInfo ={
		名称:type 类型:int 备注:房间类型id
		名称:typeName 类型:String 备注:房间类型名称
		名称:rooms 类型:List<RoomInfo> 备注:房间
	}
]]
function read_com_wly_game_games_errenniuniu_dto_RoomTypeDetailInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.typeName = sobj:readString()
	local roomsSize = sobj:readInt()
	obj.rooms = {}
	for i=1, roomsSize do  
		obj.rooms[i] = read_com_wly_game_games_errenniuniu_dto_RoomInfo(sobj)
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
function read_com_wly_game_games_errenniuniu_dto_RoomInfo(sobj)
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
	进入游戏大厅返回房间数据
	msg ={
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function rec_parse_errenniuniu_ResEnterGameHall(sobj)

	if sobj then
		local msg = {}
		local roomTypesSize = sobj:readInt()
		msg.roomTypes = {}
		for i=1, roomTypesSize do  
			msg.roomTypes[i] = read_com_wly_game_games_errenniuniu_dto_RoomTypeDetailInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	玩家筹码变化消息
	msg ={
		名称:playerId 类型:long 备注:玩家id
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
function rec_parse_errenniuniu_ResChipsChange(sobj)

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
		名称:playerId 类型:long 备注:准备的玩家
		名称:callPlayerId 类型:long 备注:叫庄的玩家,0代表不需要叫庄
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
function rec_parse_errenniuniu_ResReady(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.callPlayerId = sobj:readLong()
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
function rec_parse_errenniuniu_ResExchangeTable(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求叫庄家结果
	msg ={
		名称:playerId 类型:long 备注:叫庄的玩家
		名称:order 类型:int 备注:位置
		名称:callType 类型:int 备注:0:不叫,非0:叫
		名称:dealer 类型:long 备注:庄家id(0:庄家还未确定)
		名称:nextCallPlayer 类型:long 备注:下一个叫庄的玩家id)
	}
]]
function rec_parse_errenniuniu_ResCallDealer(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.order = sobj:readInt()
		msg.callType = sobj:readInt()
		msg.dealer = sobj:readLong()
		msg.nextCallPlayer = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	请求下注结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:筹码不合法
		名称:chips 类型:long 备注:筹码
	}
]]
function rec_parse_errenniuniu_ResBet(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		msg.chips = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	摊牌结果
	msg ={
		名称:playerId 类型:long 备注:摊牌的玩家
		名称:cardsType 类型:int 备注:牌型(0:没牛，1-10:牛1到牛牛,四花:11,四炸:12,五花:13,五小:14)
		名称:bestCards 类型:List<int> 备注:最优牌组合(如果有牛展示为3+2)
	}
]]
function rec_parse_errenniuniu_ResShowdown(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.cardsType = sobj:readInt()
		local bestCardsSize = sobj:readInt()
		msg.bestCards = {}
		for i=1, bestCardsSize do  
			msg.bestCards[i] = sobj:readInt()
		end 	
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
function rec_parse_errenniuniu_ResFastEnterTable(sobj)

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
function rec_parse_errenniuniu_ResEnterRoom(sobj)

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
function rec_parse_errenniuniu_ResEnterTable(sobj)

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
function rec_parse_errenniuniu_ResExitRoom(sobj)

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
		名称:playerId 类型:long 备注:退出桌子的玩家
	}
]]
function rec_parse_errenniuniu_ResExitTable(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	发牌
	msg ={
		名称:cards 类型:List<int> 备注:玩家的牌
		名称:tipCards 类型:List<int> 备注:提示的牌(3+2)
		名称:cardsType 类型:int 备注:牌型(0:没牛，1-10:牛1到牛牛,四花:11,四炸:12,五花:13,五小:14)
		名称:chips 类型:long 备注:输赢的筹码(正:赢,负:输)
	}
]]
function rec_parse_errenniuniu_ResDealCards(sobj)

	if sobj then
		local msg = {}
		local cardsSize = sobj:readInt()
		msg.cards = {}
		for i=1, cardsSize do  
			msg.cards[i] = sobj:readInt()
		end 	
		local tipCardsSize = sobj:readInt()
		msg.tipCards = {}
		for i=1, tipCardsSize do  
			msg.tipCards[i] = sobj:readInt()
		end 	
		msg.cardsType = sobj:readInt()
		msg.chips = sobj:readLong()
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
function rec_parse_errenniuniu_ResOtherEnterTable(sobj)

	if sobj then
		local msg = {}
		msg.mem = read_com_wly_game_gamehall_dto_MemInfo(sobj)
		return msg
	end
	return nil
end


--[[
	游戏结束
	msg ={
	}
]]
function rec_parse_errenniuniu_ResGameOver(sobj)

	if sobj then
		local msg = {}
		return msg
	end
	return nil
end


s2c_errenniuniu_ResEnterGameHall_msg = 502201 --[[进入游戏大厅返回房间数据]]
s2c_errenniuniu_ResChipsChange_msg = 502202 --[[玩家筹码变化消息]]
s2c_errenniuniu_ResReady_msg = 502204 --[[玩家准备]]
s2c_errenniuniu_ResExchangeTable_msg = 502205 --[[请求交换桌子]]
s2c_errenniuniu_ResCallDealer_msg = 502206 --[[请求叫庄家结果]]
s2c_errenniuniu_ResBet_msg = 502208 --[[请求下注结果]]
s2c_errenniuniu_ResShowdown_msg = 502209 --[[摊牌结果]]
s2c_errenniuniu_ResFastEnterTable_msg = 502210 --[[玩家请求快速进入房间牌桌结果]]
s2c_errenniuniu_ResEnterRoom_msg = 502211 --[[进入房间结果]]
s2c_errenniuniu_ResEnterTable_msg = 502212 --[[进入牌桌结果]]
s2c_errenniuniu_ResExitRoom_msg = 502215 --[[玩家请求退出房间]]
s2c_errenniuniu_ResExitTable_msg = 502216 --[[玩家请求退出房间牌桌结果]]
s2c_errenniuniu_ResDealCards_msg = 502218 --[[发牌]]
s2c_errenniuniu_ResOtherEnterTable_msg = 502219 --[[其他人进入桌子]]
s2c_errenniuniu_ResGameOver_msg = 502230 --[[游戏结束]]

ReceiveMsg.regParseRecMsg(502201, rec_parse_errenniuniu_ResEnterGameHall)--[[进入游戏大厅返回房间数据]]
ReceiveMsg.regParseRecMsg(502202, rec_parse_errenniuniu_ResChipsChange)--[[玩家筹码变化消息]]
ReceiveMsg.regParseRecMsg(502204, rec_parse_errenniuniu_ResReady)--[[玩家准备]]
ReceiveMsg.regParseRecMsg(502205, rec_parse_errenniuniu_ResExchangeTable)--[[请求交换桌子]]
ReceiveMsg.regParseRecMsg(502206, rec_parse_errenniuniu_ResCallDealer)--[[请求叫庄家结果]]
ReceiveMsg.regParseRecMsg(502208, rec_parse_errenniuniu_ResBet)--[[请求下注结果]]
ReceiveMsg.regParseRecMsg(502209, rec_parse_errenniuniu_ResShowdown)--[[摊牌结果]]
ReceiveMsg.regParseRecMsg(502210, rec_parse_errenniuniu_ResFastEnterTable)--[[玩家请求快速进入房间牌桌结果]]
ReceiveMsg.regParseRecMsg(502211, rec_parse_errenniuniu_ResEnterRoom)--[[进入房间结果]]
ReceiveMsg.regParseRecMsg(502212, rec_parse_errenniuniu_ResEnterTable)--[[进入牌桌结果]]
ReceiveMsg.regParseRecMsg(502215, rec_parse_errenniuniu_ResExitRoom)--[[玩家请求退出房间]]
ReceiveMsg.regParseRecMsg(502216, rec_parse_errenniuniu_ResExitTable)--[[玩家请求退出房间牌桌结果]]
ReceiveMsg.regParseRecMsg(502218, rec_parse_errenniuniu_ResDealCards)--[[发牌]]
ReceiveMsg.regParseRecMsg(502219, rec_parse_errenniuniu_ResOtherEnterTable)--[[其他人进入桌子]]
ReceiveMsg.regParseRecMsg(502230, rec_parse_errenniuniu_ResGameOver)--[[游戏结束]]
