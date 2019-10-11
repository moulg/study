--[[
	RoomTypeDetailInfo ={
		名称:type 类型:int 备注:房间类型id
		名称:typeName 类型:String 备注:房间类型名称
		名称:rooms 类型:List<RoomInfo> 备注:房间
	}
]]
function read_com_wly_game_games_happyfive_dto_RoomTypeDetailInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.typeName = sobj:readString()
	local roomsSize = sobj:readInt()
	obj.rooms = {}
	for i=1, roomsSize do  
		obj.rooms[i] = read_com_wly_game_games_happyfive_dto_RoomInfo(sobj)
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
		名称:full 类型:int 备注:爆满人数
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
function read_com_wly_game_games_happyfive_dto_RoomInfo(sobj)
	local obj = {};
	obj.roomId = sobj:readInt()
	obj.name = sobj:readString()
	obj.type = sobj:readInt()
	obj.maxNum = sobj:readInt()
	obj.free = sobj:readInt()
	obj.general = sobj:readInt()
	obj.crowded = sobj:readInt()
	obj.full = sobj:readInt()
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
	CardInfo ={
		名称:suit 类型:String 备注:花色
		名称:number 类型:int 备注:牌号
	}
]]
function read_com_wly_game_games_happyfive_dto_CardInfo(sobj)
	local obj = {};
	obj.suit = sobj:readString()
	obj.number = sobj:readInt()
	
	return obj		
end

--[[
	PlayerCards ={
		名称:order 类型:int 备注:玩家作为号
		名称:cards 类型:List<int> 备注:玩家手上的牌
		名称:type 类型:int 备注:玩家牌类型
	}
]]
function read_com_wly_game_games_happyfive_dto_PlayerCards(sobj)
	local obj = {};
	obj.order = sobj:readInt()
	local cardsSize = sobj:readInt()
	obj.cards = {}
	for i=1, cardsSize do  
		obj.cards[i] = sobj:readInt()
	end 	
	obj.type = sobj:readInt()
	
	return obj		
end

--[[
	PlayerBillInfo ={
		名称:order 类型:int 备注:玩家座位号
		名称:bet 类型:long 备注:结算的筹码
	}
]]
function read_com_wly_game_games_happyfive_dto_PlayerBillInfo(sobj)
	local obj = {};
	obj.order = sobj:readInt()
	obj.bet = sobj:readLong()
	
	return obj		
end



--[[
	欢乐五张大厅数据
	msg ={
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function rec_parse_happyfive_ResGameHall(sobj)

	if sobj then
		local msg = {}
		local roomTypesSize = sobj:readInt()
		msg.roomTypes = {}
		for i=1, roomTypesSize do  
			msg.roomTypes[i] = read_com_wly_game_games_happyfive_dto_RoomTypeDetailInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	返回请求进入房间结果
	msg ={
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
function rec_parse_happyfive_ResEnterRoom(sobj)

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
	返回请求进入牌桌结果
	msg ={
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
function rec_parse_happyfive_ResEnterTable(sobj)

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
	玩家准备
	msg ={
		名称:order 类型:int 备注:准备的玩家
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
function rec_parse_happyfive_ResReady(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	底牌
	msg ={
		名称:cards 类型:List<int> 备注:底牌
		名称:isNeedInfo 类型:int 备注:是否需要返回告知发牌结束 0:是，1：不是
	}
]]
function rec_parse_happyfive_ResHiddenCards(sobj)

	if sobj then
		local msg = {}
		local cardsSize = sobj:readInt()
		msg.cards = {}
		for i=1, cardsSize do  
			msg.cards[i] = sobj:readInt()
		end 	
		msg.isNeedInfo = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	发牌
	msg ={
		名称:minOne 类型:long 备注:加注1数
		名称:openCards 类型:int 备注:玩家的明牌
		名称:hiddenCards 类型:int 备注:玩家的底牌
		名称:minBet 类型:long 备注:底注
	}
]]
function rec_parse_happyfive_ResDealCards(sobj)

	if sobj then
		local msg = {}
		msg.minOne = sobj:readLong()
		msg.openCards = sobj:readInt()
		msg.hiddenCards = sobj:readInt()
		msg.minBet = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	玩家请求退出房间牌桌结果
	msg ={
		名称:seatInfo 类型:com.wly.game.gamehall.dto.SeatInfo 备注:退桌子信息
	}
]]
function rec_parse_happyfive_ResExitTable(sobj)

	if sobj then
		local msg = {}
		msg.seatInfo = read_com_wly_game_gamehall_dto_SeatInfo(sobj)
		return msg
	end
	return nil
end


--[[
	欢乐五张房间人数
	msg ={
		名称:roomId 类型:int 备注:房间
		名称:type 类型:int 备注:房间类型
		名称:num 类型:int 备注:房间人数
	}
]]
function rec_parse_happyfive_ResRoomPlayerNum(sobj)

	if sobj then
		local msg = {}
		msg.roomId = sobj:readInt()
		msg.type = sobj:readInt()
		msg.num = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	通知客户端该轮结束
	msg ={
		名称:state 类型:int 备注:当前第几轮
	}
]]
function rec_parse_happyfive_ResTurnOver(sobj)

	if sobj then
		local msg = {}
		msg.state = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	返回下注结果给其他玩家
	msg ={
		名称:bet 类型:long 备注:下注数量
		名称:order 类型:int 备注:玩家座位号
		名称:betType 类型:int 备注:下注类型
	}
]]
function rec_parse_happyfive_ResBet(sobj)

	if sobj then
		local msg = {}
		msg.bet = sobj:readLong()
		msg.order = sobj:readInt()
		msg.betType = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	通知下一个玩家下注
	msg ={
		名称:order 类型:int 备注:下一个玩家的座位号
		名称:curMaxBet 类型:long 备注:当前轮次最大下注数
		名称:allInBet 类型:long 备注:当前轮次梭哈数
	}
]]
function rec_parse_happyfive_ResNextSeat(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.curMaxBet = sobj:readLong()
		msg.allInBet = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	玩家筹码变化消息
	msg ={
		名称:order 类型:int 备注:玩家id
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
function rec_parse_happyfive_ResChipsChange(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.chips = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	玩家请求结算结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:没有可结算筹码
	}
]]
function rec_parse_happyfive_ResBill(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	通知其他玩家我进入房间的消息
	msg ={
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
function rec_parse_happyfive_ResOtherPlayer(sobj)

	if sobj then
		local msg = {}
		msg.mem = read_com_wly_game_gamehall_dto_MemInfo(sobj)
		return msg
	end
	return nil
end


--[[
	游戏结束结算结果
	msg ={
		名称:billInfo 类型:List<PlayerBillInfo> 备注:结算信息
		名称:cards 类型:List<PlayerCards> 备注:玩家手上的牌
		名称:type 类型:int 备注:0：正常结算，1：弃牌结算
	}
]]
function rec_parse_happyfive_ResBanlance(sobj)

	if sobj then
		local msg = {}
		local billInfoSize = sobj:readInt()
		msg.billInfo = {}
		for i=1, billInfoSize do  
			msg.billInfo[i] = read_com_wly_game_games_happyfive_dto_PlayerBillInfo(sobj)
		end 	
		local cardsSize = sobj:readInt()
		msg.cards = {}
		for i=1, cardsSize do  
			msg.cards[i] = read_com_wly_game_games_happyfive_dto_PlayerCards(sobj)
		end 	
		msg.type = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	返回亮牌牌信息
	msg ={
		名称:cards 类型:List<int> 备注:亮牌牌ID
		名称:order 类型:int 备注:亮牌玩家位置号
	}
]]
function rec_parse_happyfive_ResLightCard(sobj)

	if sobj then
		local msg = {}
		local cardsSize = sobj:readInt()
		msg.cards = {}
		for i=1, cardsSize do  
			msg.cards[i] = sobj:readInt()
		end 	
		msg.order = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	告知机器谁会获胜
	msg ={
		名称:order 类型:int 备注:座位号
	}
]]
function rec_parse_happyfive_ResWin(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	玩家明牌的牌
	msg ={
		名称:cards 类型:List<PlayerCards> 备注:玩家明牌的牌
	}
]]
function rec_parse_happyfive_ResOpenHandInfo(sobj)

	if sobj then
		local msg = {}
		local cardsSize = sobj:readInt()
		msg.cards = {}
		for i=1, cardsSize do  
			msg.cards[i] = read_com_wly_game_games_happyfive_dto_PlayerCards(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	返回玩家请求看牌
	msg ={
		名称:order 类型:int 备注:看牌玩家的座位号
	}
]]
function rec_parse_happyfive_ResCheckCard(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	返回底注筹码数量
	msg ={
		名称:bet 类型:long 备注:底注筹码数量
	}
]]
function rec_parse_happyfive_ResBottomBet(sobj)

	if sobj then
		local msg = {}
		msg.bet = sobj:readLong()
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
function rec_parse_happyfive_ResExchangeTable(sobj)

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
function rec_parse_happyfive_ResFastEnterTable(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


s2c_happyfive_ResGameHall_msg = 507201 --[[欢乐五张大厅数据]]
s2c_happyfive_ResEnterRoom_msg = 507202 --[[返回请求进入房间结果]]
s2c_happyfive_ResEnterTable_msg = 507203 --[[返回请求进入牌桌结果]]
s2c_happyfive_ResReady_msg = 507204 --[[玩家准备]]
s2c_happyfive_ResHiddenCards_msg = 507206 --[[底牌]]
s2c_happyfive_ResDealCards_msg = 507207 --[[发牌]]
s2c_happyfive_ResExitTable_msg = 507213 --[[玩家请求退出房间牌桌结果]]
s2c_happyfive_ResRoomPlayerNum_msg = 507216 --[[欢乐五张房间人数]]
s2c_happyfive_ResTurnOver_msg = 507217 --[[通知客户端该轮结束]]
s2c_happyfive_ResBet_msg = 507219 --[[返回下注结果给其他玩家]]
s2c_happyfive_ResNextSeat_msg = 507220 --[[通知下一个玩家下注]]
s2c_happyfive_ResChipsChange_msg = 507221 --[[玩家筹码变化消息]]
s2c_happyfive_ResBill_msg = 507222 --[[玩家请求结算结果]]
s2c_happyfive_ResOtherPlayer_msg = 507223 --[[通知其他玩家我进入房间的消息]]
s2c_happyfive_ResBanlance_msg = 507224 --[[游戏结束结算结果]]
s2c_happyfive_ResLightCard_msg = 507225 --[[返回亮牌牌信息]]
s2c_happyfive_ResWin_msg = 507226 --[[告知机器谁会获胜]]
s2c_happyfive_ResOpenHandInfo_msg = 507227 --[[玩家明牌的牌]]
s2c_happyfive_ResCheckCard_msg = 507228 --[[返回玩家请求看牌]]
s2c_happyfive_ResBottomBet_msg = 507229 --[[返回底注筹码数量]]
s2c_happyfive_ResExchangeTable_msg = 507230 --[[请求交换桌子]]
s2c_happyfive_ResFastEnterTable_msg = 507231 --[[玩家请求快速进入房间牌桌结果]]

ReceiveMsg.regParseRecMsg(507201, rec_parse_happyfive_ResGameHall)--[[欢乐五张大厅数据]]
ReceiveMsg.regParseRecMsg(507202, rec_parse_happyfive_ResEnterRoom)--[[返回请求进入房间结果]]
ReceiveMsg.regParseRecMsg(507203, rec_parse_happyfive_ResEnterTable)--[[返回请求进入牌桌结果]]
ReceiveMsg.regParseRecMsg(507204, rec_parse_happyfive_ResReady)--[[玩家准备]]
ReceiveMsg.regParseRecMsg(507206, rec_parse_happyfive_ResHiddenCards)--[[底牌]]
ReceiveMsg.regParseRecMsg(507207, rec_parse_happyfive_ResDealCards)--[[发牌]]
ReceiveMsg.regParseRecMsg(507213, rec_parse_happyfive_ResExitTable)--[[玩家请求退出房间牌桌结果]]
ReceiveMsg.regParseRecMsg(507216, rec_parse_happyfive_ResRoomPlayerNum)--[[欢乐五张房间人数]]
ReceiveMsg.regParseRecMsg(507217, rec_parse_happyfive_ResTurnOver)--[[通知客户端该轮结束]]
ReceiveMsg.regParseRecMsg(507219, rec_parse_happyfive_ResBet)--[[返回下注结果给其他玩家]]
ReceiveMsg.regParseRecMsg(507220, rec_parse_happyfive_ResNextSeat)--[[通知下一个玩家下注]]
ReceiveMsg.regParseRecMsg(507221, rec_parse_happyfive_ResChipsChange)--[[玩家筹码变化消息]]
ReceiveMsg.regParseRecMsg(507222, rec_parse_happyfive_ResBill)--[[玩家请求结算结果]]
ReceiveMsg.regParseRecMsg(507223, rec_parse_happyfive_ResOtherPlayer)--[[通知其他玩家我进入房间的消息]]
ReceiveMsg.regParseRecMsg(507224, rec_parse_happyfive_ResBanlance)--[[游戏结束结算结果]]
ReceiveMsg.regParseRecMsg(507225, rec_parse_happyfive_ResLightCard)--[[返回亮牌牌信息]]
ReceiveMsg.regParseRecMsg(507226, rec_parse_happyfive_ResWin)--[[告知机器谁会获胜]]
ReceiveMsg.regParseRecMsg(507227, rec_parse_happyfive_ResOpenHandInfo)--[[玩家明牌的牌]]
ReceiveMsg.regParseRecMsg(507228, rec_parse_happyfive_ResCheckCard)--[[返回玩家请求看牌]]
ReceiveMsg.regParseRecMsg(507229, rec_parse_happyfive_ResBottomBet)--[[返回底注筹码数量]]
ReceiveMsg.regParseRecMsg(507230, rec_parse_happyfive_ResExchangeTable)--[[请求交换桌子]]
ReceiveMsg.regParseRecMsg(507231, rec_parse_happyfive_ResFastEnterTable)--[[玩家请求快速进入房间牌桌结果]]
