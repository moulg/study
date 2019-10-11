--[[
	RoomTypeDetailInfo ={
		名称:type 类型:int 备注:房间类型id
		名称:typeName 类型:String 备注:房间类型名称
		名称:rooms 类型:List<RoomInfo> 备注:房间
	}
]]
function read_com_wly_game_games_zjh_dto_RoomTypeDetailInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.typeName = sobj:readString()
	local roomsSize = sobj:readInt()
	obj.rooms = {}
	for i=1, roomsSize do  
		obj.rooms[i] = read_com_wly_game_games_zjh_dto_RoomInfo(sobj)
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
		名称:base 类型:int 备注:底注
		名称:top 类型:int 备注:封顶
		名称:chip1 类型:int 备注:筹码1
		名称:chip2 类型:int 备注:筹码2
		名称:chip3 类型:int 备注:筹码3
		名称:status 类型:String 备注:状态(空闲,普通,拥挤,爆满)
		名称:displayNames 类型:String 备注:展示的属性名称
		名称:placeHolder 类型:String 备注:展示的属性名称占位符
	}
]]
function read_com_wly_game_games_zjh_dto_RoomInfo(sobj)
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
	obj.base = sobj:readInt()
	obj.top = sobj:readInt()
	obj.chip1 = sobj:readInt()
	obj.chip2 = sobj:readInt()
	obj.chip3 = sobj:readInt()
	obj.status = sobj:readString()
	obj.displayNames = sobj:readString()
	obj.placeHolder = sobj:readString()
	
	return obj		
end

--[[
	BillInfo ={
		名称:order 类型:int 备注:座位顺序
		名称:playerName 类型:String 备注:玩家昵称
		名称:chips 类型:long 备注:结算筹码(包含喜钱)
		名称:luck 类型:long 备注:喜钱
		名称:cardsType 类型:int 备注:牌型(0:235,1:单张,2:对子,3:顺子,4:金华,5:顺金,6:豹子)
		名称:cards 类型:List<int> 备注:牌
	}
]]
function read_com_wly_game_games_zjh_dto_BillInfo(sobj)
	local obj = {};
	obj.order = sobj:readInt()
	obj.playerName = sobj:readString()
	obj.chips = sobj:readLong()
	obj.luck = sobj:readLong()
	obj.cardsType = sobj:readInt()
	local cardsSize = sobj:readInt()
	obj.cards = {}
	for i=1, cardsSize do  
		obj.cards[i] = sobj:readInt()
	end 	
	
	return obj		
end



--[[
	进入游戏大厅返回房间数据
	msg ={
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function rec_parse_zjh_ResEnterGameHall(sobj)

	if sobj then
		local msg = {}
		local roomTypesSize = sobj:readInt()
		msg.roomTypes = {}
		for i=1, roomTypesSize do  
			msg.roomTypes[i] = read_com_wly_game_games_zjh_dto_RoomTypeDetailInfo(sobj)
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
function rec_parse_zjh_ResChipsChange(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.chips = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	玩家准备
	msg ={
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:准备的玩家id
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
function rec_parse_zjh_ResReady(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.playerId = sobj:readLong()
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
function rec_parse_zjh_ResExchangeTable(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求下注结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:筹码不合法
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:准备的玩家id
		名称:chips 类型:long 备注:筹码
		名称:type 类型:int 备注:0:暗注,非0:明注
		名称:nextOptOrder 类型:int 备注:下一个操作玩家order
		名称:nextOptPlayerId 类型:long 备注:下一个操作玩家id
	}
]]
function rec_parse_zjh_ResBet(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		msg.order = sobj:readInt()
		msg.playerId = sobj:readLong()
		msg.chips = sobj:readLong()
		msg.type = sobj:readInt()
		msg.nextOptOrder = sobj:readInt()
		msg.nextOptPlayerId = sobj:readLong()
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
function rec_parse_zjh_ResFastEnterTable(sobj)

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
function rec_parse_zjh_ResEnterRoom(sobj)

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
function rec_parse_zjh_ResEnterTable(sobj)

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
function rec_parse_zjh_ResExitRoom(sobj)

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
function rec_parse_zjh_ResExitTable(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.playerId = sobj:readLong()
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
function rec_parse_zjh_ResOtherEnterTable(sobj)

	if sobj then
		local msg = {}
		msg.mem = read_com_wly_game_gamehall_dto_MemInfo(sobj)
		return msg
	end
	return nil
end


--[[
	所有玩家准备，准备结束
	msg ={
		名称:nextOptOrder 类型:int 备注:下一个操作玩家order
		名称:nextOptPlayerId 类型:long 备注:下一个操作玩家id
	}
]]
function rec_parse_zjh_ResReadyOver(sobj)

	if sobj then
		local msg = {}
		msg.nextOptOrder = sobj:readInt()
		msg.nextOptPlayerId = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	游戏结束
	msg ={
		名称:billInfos 类型:List<BillInfo> 备注:结算信息
	}
]]
function rec_parse_zjh_ResGameOver(sobj)

	if sobj then
		local msg = {}
		local billInfosSize = sobj:readInt()
		msg.billInfos = {}
		for i=1, billInfosSize do  
			msg.billInfos[i] = read_com_wly_game_games_zjh_dto_BillInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	看牌结果
	msg ={
		名称:cardsType 类型:int 备注:牌型(0:235,1:单张,2:对子,3:顺子,4:金华,5:顺金,6:豹子)
		名称:cards 类型:List<int> 备注:牌
	}
]]
function rec_parse_zjh_ResSeeCard(sobj)

	if sobj then
		local msg = {}
		msg.cardsType = sobj:readInt()
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
	玩家看过牌
	msg ={
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
function rec_parse_zjh_ResSawCard(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.playerId = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	弃牌结果
	msg ={
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
		名称:nextOptOrder 类型:int 备注:下一个操作玩家order(-1表示没有)
		名称:nextOptPlayerId 类型:long 备注:下一个操作玩家id(0表示没有)
	}
]]
function rec_parse_zjh_ResDiscard(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.playerId = sobj:readLong()
		msg.nextOptOrder = sobj:readInt()
		msg.nextOptPlayerId = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	比牌结果
	msg ={
		名称:win 类型:int 备注:0:输,非0:赢
		名称:playerId 类型:long 备注:主动比牌玩家id
		名称:vsPlayerId 类型:long 备注:被比牌玩家id
		名称:nextOptOrder 类型:int 备注:下一个操作玩家order(-1表示没有)
		名称:nextOptPlayerId 类型:long 备注:下一个操作玩家id(0表示没有)
	}
]]
function rec_parse_zjh_ResVersus(sobj)

	if sobj then
		local msg = {}
		msg.win = sobj:readInt()
		msg.playerId = sobj:readLong()
		msg.vsPlayerId = sobj:readLong()
		msg.nextOptOrder = sobj:readInt()
		msg.nextOptPlayerId = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	看牌结果
	msg ={
		名称:win 类型:int 备注:0:输,非0:赢
		名称:cardsType 类型:int 备注:牌型(0:235,1:单张,2:对子,3:顺子,4:金华,5:顺金,6:豹子)
		名称:cards 类型:List<int> 备注:牌
	}
]]
function rec_parse_zjh_ResRobotSeeCard(sobj)

	if sobj then
		local msg = {}
		msg.win = sobj:readInt()
		msg.cardsType = sobj:readInt()
		local cardsSize = sobj:readInt()
		msg.cards = {}
		for i=1, cardsSize do  
			msg.cards[i] = sobj:readInt()
		end 	
		return msg
	end
	return nil
end


s2c_zjh_ResEnterGameHall_msg = 510201 --[[进入游戏大厅返回房间数据]]
s2c_zjh_ResChipsChange_msg = 510202 --[[玩家筹码变化消息]]
s2c_zjh_ResReady_msg = 510204 --[[玩家准备]]
s2c_zjh_ResExchangeTable_msg = 510205 --[[请求交换桌子]]
s2c_zjh_ResBet_msg = 510208 --[[请求下注结果]]
s2c_zjh_ResFastEnterTable_msg = 510210 --[[玩家请求快速进入房间牌桌结果]]
s2c_zjh_ResEnterRoom_msg = 510211 --[[进入房间结果]]
s2c_zjh_ResEnterTable_msg = 510212 --[[进入牌桌结果]]
s2c_zjh_ResExitRoom_msg = 510215 --[[玩家请求退出房间]]
s2c_zjh_ResExitTable_msg = 510216 --[[玩家请求退出房间牌桌结果]]
s2c_zjh_ResOtherEnterTable_msg = 510219 --[[其他人进入桌子]]
s2c_zjh_ResReadyOver_msg = 510220 --[[所有玩家准备，准备结束]]
s2c_zjh_ResGameOver_msg = 510230 --[[游戏结束]]
s2c_zjh_ResSeeCard_msg = 510231 --[[看牌结果]]
s2c_zjh_ResSawCard_msg = 510232 --[[玩家看过牌]]
s2c_zjh_ResDiscard_msg = 510233 --[[弃牌结果]]
s2c_zjh_ResVersus_msg = 510234 --[[比牌结果]]
s2c_zjh_ResRobotSeeCard_msg = 510235 --[[看牌结果]]

ReceiveMsg.regParseRecMsg(510201, rec_parse_zjh_ResEnterGameHall)--[[进入游戏大厅返回房间数据]]
ReceiveMsg.regParseRecMsg(510202, rec_parse_zjh_ResChipsChange)--[[玩家筹码变化消息]]
ReceiveMsg.regParseRecMsg(510204, rec_parse_zjh_ResReady)--[[玩家准备]]
ReceiveMsg.regParseRecMsg(510205, rec_parse_zjh_ResExchangeTable)--[[请求交换桌子]]
ReceiveMsg.regParseRecMsg(510208, rec_parse_zjh_ResBet)--[[请求下注结果]]
ReceiveMsg.regParseRecMsg(510210, rec_parse_zjh_ResFastEnterTable)--[[玩家请求快速进入房间牌桌结果]]
ReceiveMsg.regParseRecMsg(510211, rec_parse_zjh_ResEnterRoom)--[[进入房间结果]]
ReceiveMsg.regParseRecMsg(510212, rec_parse_zjh_ResEnterTable)--[[进入牌桌结果]]
ReceiveMsg.regParseRecMsg(510215, rec_parse_zjh_ResExitRoom)--[[玩家请求退出房间]]
ReceiveMsg.regParseRecMsg(510216, rec_parse_zjh_ResExitTable)--[[玩家请求退出房间牌桌结果]]
ReceiveMsg.regParseRecMsg(510219, rec_parse_zjh_ResOtherEnterTable)--[[其他人进入桌子]]
ReceiveMsg.regParseRecMsg(510220, rec_parse_zjh_ResReadyOver)--[[所有玩家准备，准备结束]]
ReceiveMsg.regParseRecMsg(510230, rec_parse_zjh_ResGameOver)--[[游戏结束]]
ReceiveMsg.regParseRecMsg(510231, rec_parse_zjh_ResSeeCard)--[[看牌结果]]
ReceiveMsg.regParseRecMsg(510232, rec_parse_zjh_ResSawCard)--[[玩家看过牌]]
ReceiveMsg.regParseRecMsg(510233, rec_parse_zjh_ResDiscard)--[[弃牌结果]]
ReceiveMsg.regParseRecMsg(510234, rec_parse_zjh_ResVersus)--[[比牌结果]]
ReceiveMsg.regParseRecMsg(510235, rec_parse_zjh_ResRobotSeeCard)--[[看牌结果]]
