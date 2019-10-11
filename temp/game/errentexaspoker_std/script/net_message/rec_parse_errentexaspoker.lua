--[[
	RoomTypeDetailInfo ={
		名称:type 类型:int 备注:房间类型id
		名称:typeName 类型:String 备注:房间类型名称
		名称:rooms 类型:List<RoomInfo> 备注:房间
	}
]]
function read_com_wly_game_games_errentexaspoker_dto_RoomTypeDetailInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.typeName = sobj:readString()
	local roomsSize = sobj:readInt()
	obj.rooms = {}
	for i=1, roomsSize do  
		obj.rooms[i] = read_com_wly_game_games_errentexaspoker_dto_RoomInfo(sobj)
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
function read_com_wly_game_games_errentexaspoker_dto_RoomInfo(sobj)
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
function read_com_wly_game_games_errentexaspoker_dto_CardInfo(sobj)
	local obj = {};
	obj.suit = sobj:readString()
	obj.number = sobj:readInt()
	
	return obj		
end

--[[
	PlayerCards ={
		名称:order 类型:int 备注:玩家作为号
		名称:cards 类型:List<int> 备注:玩家手上的牌
	}
]]
function read_com_wly_game_games_errentexaspoker_dto_PlayerCards(sobj)
	local obj = {};
	obj.order = sobj:readInt()
	local cardsSize = sobj:readInt()
	obj.cards = {}
	for i=1, cardsSize do  
		obj.cards[i] = sobj:readInt()
	end 	
	
	return obj		
end

--[[
	PlayerBillInfo ={
		名称:order 类型:int 备注:玩家座位号
		名称:bet 类型:long 备注:结算的筹码
	}
]]
function read_com_wly_game_games_errentexaspoker_dto_PlayerBillInfo(sobj)
	local obj = {};
	obj.order = sobj:readInt()
	obj.bet = sobj:readLong()
	
	return obj		
end



--[[
	德州扑克大厅数据
	msg ={
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function rec_parse_errentexaspoker_ResGameHall(sobj)

	if sobj then
		local msg = {}
		local roomTypesSize = sobj:readInt()
		msg.roomTypes = {}
		for i=1, roomTypesSize do  
			msg.roomTypes[i] = read_com_wly_game_games_errentexaspoker_dto_RoomTypeDetailInfo(sobj)
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
function rec_parse_errentexaspoker_ResEnterRoom(sobj)

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
function rec_parse_errentexaspoker_ResEnterTable(sobj)

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
function rec_parse_errentexaspoker_ResReady(sobj)

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
function rec_parse_errentexaspoker_ResHiddenCards(sobj)

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
		名称:landlordOrder 类型:int 备注:庄家座位号
		名称:smallBind 类型:int 备注:小盲注座位号
		名称:binBind 类型:int 备注:大盲注座位号
		名称:cards 类型:List<int> 备注:玩家的牌
	}
]]
function rec_parse_errentexaspoker_ResDealCards(sobj)

	if sobj then
		local msg = {}
		msg.landlordOrder = sobj:readInt()
		msg.smallBind = sobj:readInt()
		msg.binBind = sobj:readInt()
		local cardsSize = sobj:readInt()
		msg.cards = {}
		for i=1, cardsSize do  
			msg.cards[i] = sobj:readInt()
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
function rec_parse_errentexaspoker_ResExitRoom(sobj)

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
		名称:seatInfo 类型:com.wly.game.gamehall.dto.SeatInfo 备注:退桌子信息
	}
]]
function rec_parse_errentexaspoker_ResExitTable(sobj)

	if sobj then
		local msg = {}
		msg.seatInfo = read_com_wly_game_gamehall_dto_SeatInfo(sobj)
		return msg
	end
	return nil
end


--[[
	德州扑克房间人数
	msg ={
		名称:roomId 类型:int 备注:房间
		名称:type 类型:int 备注:房间类型
		名称:num 类型:int 备注:房间人数
	}
]]
function rec_parse_errentexaspoker_ResRoomPlayerNum(sobj)

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
function rec_parse_errentexaspoker_ResTurnOver(sobj)

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
function rec_parse_errentexaspoker_ResBet(sobj)

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
		名称:raisetBet 类型:long 备注:当前的加注额度
		名称:curMaxBet 类型:long 备注:当前轮次最大下注数
	}
]]
function rec_parse_errentexaspoker_ResNextSeat(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.raisetBet = sobj:readLong()
		msg.curMaxBet = sobj:readLong()
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
function rec_parse_errentexaspoker_ResChipsChange(sobj)

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
function rec_parse_errentexaspoker_ResBill(sobj)

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
function rec_parse_errentexaspoker_ResOtherPlayer(sobj)

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
function rec_parse_errentexaspoker_ResBanlance(sobj)

	if sobj then
		local msg = {}
		local billInfoSize = sobj:readInt()
		msg.billInfo = {}
		for i=1, billInfoSize do  
			msg.billInfo[i] = read_com_wly_game_games_errentexaspoker_dto_PlayerBillInfo(sobj)
		end 	
		local cardsSize = sobj:readInt()
		msg.cards = {}
		for i=1, cardsSize do  
			msg.cards[i] = read_com_wly_game_games_errentexaspoker_dto_PlayerCards(sobj)
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
function rec_parse_errentexaspoker_ResLightCard(sobj)

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
function rec_parse_errentexaspoker_ResWin(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
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
function rec_parse_errentexaspoker_ResFastEnterTable(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


s2c_errentexaspoker_ResGameHall_msg = 515201 --[[德州扑克大厅数据]]
s2c_errentexaspoker_ResEnterRoom_msg = 515202 --[[返回请求进入房间结果]]
s2c_errentexaspoker_ResEnterTable_msg = 515203 --[[返回请求进入牌桌结果]]
s2c_errentexaspoker_ResReady_msg = 515204 --[[玩家准备]]
s2c_errentexaspoker_ResHiddenCards_msg = 515206 --[[底牌]]
s2c_errentexaspoker_ResDealCards_msg = 515207 --[[发牌]]
s2c_errentexaspoker_ResExitRoom_msg = 515210 --[[玩家请求退出房间]]
s2c_errentexaspoker_ResExitTable_msg = 515213 --[[玩家请求退出房间牌桌结果]]
s2c_errentexaspoker_ResRoomPlayerNum_msg = 515216 --[[德州扑克房间人数]]
s2c_errentexaspoker_ResTurnOver_msg = 515217 --[[通知客户端该轮结束]]
s2c_errentexaspoker_ResBet_msg = 515219 --[[返回下注结果给其他玩家]]
s2c_errentexaspoker_ResNextSeat_msg = 515220 --[[通知下一个玩家下注]]
s2c_errentexaspoker_ResChipsChange_msg = 515221 --[[玩家筹码变化消息]]
s2c_errentexaspoker_ResBill_msg = 515222 --[[玩家请求结算结果]]
s2c_errentexaspoker_ResOtherPlayer_msg = 515223 --[[通知其他玩家我进入房间的消息]]
s2c_errentexaspoker_ResBanlance_msg = 515224 --[[游戏结束结算结果]]
s2c_errentexaspoker_ResLightCard_msg = 515225 --[[返回亮牌牌信息]]
s2c_errentexaspoker_ResWin_msg = 515226 --[[告知机器谁会获胜]]
s2c_errentexaspoker_ResFastEnterTable_msg = 515227 --[[玩家请求快速进入房间牌桌结果]]

ReceiveMsg.regParseRecMsg(515201, rec_parse_errentexaspoker_ResGameHall)--[[德州扑克大厅数据]]
ReceiveMsg.regParseRecMsg(515202, rec_parse_errentexaspoker_ResEnterRoom)--[[返回请求进入房间结果]]
ReceiveMsg.regParseRecMsg(515203, rec_parse_errentexaspoker_ResEnterTable)--[[返回请求进入牌桌结果]]
ReceiveMsg.regParseRecMsg(515204, rec_parse_errentexaspoker_ResReady)--[[玩家准备]]
ReceiveMsg.regParseRecMsg(515206, rec_parse_errentexaspoker_ResHiddenCards)--[[底牌]]
ReceiveMsg.regParseRecMsg(515207, rec_parse_errentexaspoker_ResDealCards)--[[发牌]]
ReceiveMsg.regParseRecMsg(515210, rec_parse_errentexaspoker_ResExitRoom)--[[玩家请求退出房间]]
ReceiveMsg.regParseRecMsg(515213, rec_parse_errentexaspoker_ResExitTable)--[[玩家请求退出房间牌桌结果]]
ReceiveMsg.regParseRecMsg(515216, rec_parse_errentexaspoker_ResRoomPlayerNum)--[[德州扑克房间人数]]
ReceiveMsg.regParseRecMsg(515217, rec_parse_errentexaspoker_ResTurnOver)--[[通知客户端该轮结束]]
ReceiveMsg.regParseRecMsg(515219, rec_parse_errentexaspoker_ResBet)--[[返回下注结果给其他玩家]]
ReceiveMsg.regParseRecMsg(515220, rec_parse_errentexaspoker_ResNextSeat)--[[通知下一个玩家下注]]
ReceiveMsg.regParseRecMsg(515221, rec_parse_errentexaspoker_ResChipsChange)--[[玩家筹码变化消息]]
ReceiveMsg.regParseRecMsg(515222, rec_parse_errentexaspoker_ResBill)--[[玩家请求结算结果]]
ReceiveMsg.regParseRecMsg(515223, rec_parse_errentexaspoker_ResOtherPlayer)--[[通知其他玩家我进入房间的消息]]
ReceiveMsg.regParseRecMsg(515224, rec_parse_errentexaspoker_ResBanlance)--[[游戏结束结算结果]]
ReceiveMsg.regParseRecMsg(515225, rec_parse_errentexaspoker_ResLightCard)--[[返回亮牌牌信息]]
ReceiveMsg.regParseRecMsg(515226, rec_parse_errentexaspoker_ResWin)--[[告知机器谁会获胜]]
ReceiveMsg.regParseRecMsg(515227, rec_parse_errentexaspoker_ResFastEnterTable)--[[玩家请求快速进入房间牌桌结果]]
