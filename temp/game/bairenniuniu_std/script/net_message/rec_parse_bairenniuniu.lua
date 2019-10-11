--[[
	BetInfo ={
		名称:area 类型:int 备注:下注区域
		名称:chips 类型:long 备注:下注筹码
	}
]]
function read_com_wly_game_games_bairenniuniu_dto_BetInfo(sobj)
	local obj = {};
	obj.area = sobj:readInt()
	obj.chips = sobj:readLong()
	
	return obj		
end

--[[
	RoomTypeDetailInfo ={
		名称:type 类型:int 备注:房间类型id
		名称:typeName 类型:String 备注:房间类型名称
		名称:rooms 类型:List<RoomInfo> 备注:房间
	}
]]
function read_com_wly_game_games_bairenniuniu_dto_RoomTypeDetailInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.typeName = sobj:readString()
	local roomsSize = sobj:readInt()
	obj.rooms = {}
	for i=1, roomsSize do  
		obj.rooms[i] = read_com_wly_game_games_bairenniuniu_dto_RoomInfo(sobj)
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
function read_com_wly_game_games_bairenniuniu_dto_RoomInfo(sobj)
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
function read_com_wly_game_games_bairenniuniu_dto_BillInfo(sobj)
	local obj = {};
	obj.order = sobj:readInt()
	obj.chips = sobj:readLong()
	
	return obj		
end

--[[
	CardsInfo ={
		名称:cards 类型:List<int> 备注:玩家的牌，已经是最优牌型(3+2)
		名称:id 类型:int 备注:0-4 :0庄家的牌，1:闲家1，2:闲家2，3:闲家3，4:闲家4
		名称:cardsType 类型:int 备注:牌型(0:没牛，1-10:牛1到牛牛,四花:11,四炸:12,五花:13,五小:14)
	}
]]
function read_com_wly_game_games_bairenniuniu_dto_CardsInfo(sobj)
	local obj = {};
	local cardsSize = sobj:readInt()
	obj.cards = {}
	for i=1, cardsSize do  
		obj.cards[i] = sobj:readInt()
	end 	
	obj.id = sobj:readInt()
	obj.cardsType = sobj:readInt()
	
	return obj		
end



--[[
	进入游戏大厅返回房间数据
	msg ={
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function rec_parse_bairenniuniu_ResEnterGameHall(sobj)

	if sobj then
		local msg = {}
		local roomTypesSize = sobj:readInt()
		msg.roomTypes = {}
		for i=1, roomTypesSize do  
			msg.roomTypes[i] = read_com_wly_game_games_bairenniuniu_dto_RoomTypeDetailInfo(sobj)
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
function rec_parse_bairenniuniu_ResChipsChange(sobj)

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
function rec_parse_bairenniuniu_ResReady(sobj)

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
function rec_parse_bairenniuniu_ResExchangeTable(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	摊牌结果
	msg ={
		名称:order 类型:int 备注:座位顺序
		名称:cardsType 类型:int 备注:牌型(0:没牛，1-10:牛1到牛牛,四花:11,四炸:12,五花:13,五小:14)
		名称:bestCards 类型:List<int> 备注:最优牌组合(如果有牛展示为3+2)
	}
]]
function rec_parse_bairenniuniu_ResShowdown(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
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
function rec_parse_bairenniuniu_ResFastEnterTable(sobj)

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
function rec_parse_bairenniuniu_ResEnterRoom(sobj)

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
function rec_parse_bairenniuniu_ResEnterTable(sobj)

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
function rec_parse_bairenniuniu_ResExitRoom(sobj)

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
function rec_parse_bairenniuniu_ResExitTable(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.playerId = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	发牌
	msg ={
		名称:cardsInfo 类型:List<CardsInfo> 备注:牌信息
	}
]]
function rec_parse_bairenniuniu_ResDealCards(sobj)

	if sobj then
		local msg = {}
		local cardsInfoSize = sobj:readInt()
		msg.cardsInfo = {}
		for i=1, cardsInfoSize do  
			msg.cardsInfo[i] = read_com_wly_game_games_bairenniuniu_dto_CardsInfo(sobj)
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
function rec_parse_bairenniuniu_ResOtherEnterTable(sobj)

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
		名称:area 类型:int 备注:下注区域  闲家1-4
		名称:chips 类型:long 备注:对应的筹码
	}
]]
function rec_parse_bairenniuniu_ResBet(sobj)

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
function rec_parse_bairenniuniu_ResTableBet(sobj)

	if sobj then
		local msg = {}
		local betInfoSize = sobj:readInt()
		msg.betInfo = {}
		for i=1, betInfoSize do  
			msg.betInfo[i] = read_com_wly_game_games_bairenniuniu_dto_BetInfo(sobj)
		end 	
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
function rec_parse_bairenniuniu_ResApplyBankers(sobj)

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
		名称:sex 类型:int 备注:性别 0男1女3系统
		名称:chips 类型:long 备注:筹码
		名称:num 类型:int 备注:局数
		名称:score 类型:long 备注:成绩
	}
]]
function rec_parse_bairenniuniu_ResBankerInfo(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.name = sobj:readString()
		msg.sex = sobj:readInt()
		msg.chips = sobj:readLong()
		msg.num = sobj:readInt()
		msg.score = sobj:readLong()
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
function rec_parse_bairenniuniu_ResTime(sobj)

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
function rec_parse_bairenniuniu_ResHistory(sobj)

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
		名称:bankerChips 类型:long 备注:庄家结算筹码
		名称:playerChips 类型:long 备注:玩家结算筹码
	}
]]
function rec_parse_bairenniuniu_ResBalance(sobj)

	if sobj then
		local msg = {}
		msg.bankerChips = sobj:readLong()
		msg.playerChips = sobj:readLong()
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
function rec_parse_bairenniuniu_ResClearBet(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


s2c_bairenniuniu_ResEnterGameHall_msg = 508201 --[[进入游戏大厅返回房间数据]]
s2c_bairenniuniu_ResChipsChange_msg = 508202 --[[玩家筹码变化消息]]
s2c_bairenniuniu_ResReady_msg = 508204 --[[玩家准备]]
s2c_bairenniuniu_ResExchangeTable_msg = 508205 --[[请求交换桌子]]
s2c_bairenniuniu_ResShowdown_msg = 508209 --[[摊牌结果]]
s2c_bairenniuniu_ResFastEnterTable_msg = 508210 --[[玩家请求快速进入房间牌桌结果]]
s2c_bairenniuniu_ResEnterRoom_msg = 508211 --[[进入房间结果]]
s2c_bairenniuniu_ResEnterTable_msg = 508212 --[[进入牌桌结果]]
s2c_bairenniuniu_ResExitRoom_msg = 508215 --[[玩家请求退出房间]]
s2c_bairenniuniu_ResExitTable_msg = 508216 --[[玩家请求退出房间牌桌结果]]
s2c_bairenniuniu_ResDealCards_msg = 508218 --[[发牌]]
s2c_bairenniuniu_ResOtherEnterTable_msg = 508219 --[[其他人进入桌子]]
s2c_bairenniuniu_ResBet_msg = 508221 --[[返回下注结果]]
s2c_bairenniuniu_ResTableBet_msg = 508222 --[[桌子筹码变化]]
s2c_bairenniuniu_ResApplyBankers_msg = 508223 --[[玩家申请庄家列表]]
s2c_bairenniuniu_ResBankerInfo_msg = 508224 --[[庄家信息]]
s2c_bairenniuniu_ResTime_msg = 508225 --[[通知客户端计时]]
s2c_bairenniuniu_ResHistory_msg = 508226 --[[历史输赢记录]]
s2c_bairenniuniu_ResBalance_msg = 508227 --[[返回结算结果]]
s2c_bairenniuniu_ResClearBet_msg = 508231 --[[清空下注结果]]

ReceiveMsg.regParseRecMsg(508201, rec_parse_bairenniuniu_ResEnterGameHall)--[[进入游戏大厅返回房间数据]]
ReceiveMsg.regParseRecMsg(508202, rec_parse_bairenniuniu_ResChipsChange)--[[玩家筹码变化消息]]
ReceiveMsg.regParseRecMsg(508204, rec_parse_bairenniuniu_ResReady)--[[玩家准备]]
ReceiveMsg.regParseRecMsg(508205, rec_parse_bairenniuniu_ResExchangeTable)--[[请求交换桌子]]
ReceiveMsg.regParseRecMsg(508209, rec_parse_bairenniuniu_ResShowdown)--[[摊牌结果]]
ReceiveMsg.regParseRecMsg(508210, rec_parse_bairenniuniu_ResFastEnterTable)--[[玩家请求快速进入房间牌桌结果]]
ReceiveMsg.regParseRecMsg(508211, rec_parse_bairenniuniu_ResEnterRoom)--[[进入房间结果]]
ReceiveMsg.regParseRecMsg(508212, rec_parse_bairenniuniu_ResEnterTable)--[[进入牌桌结果]]
ReceiveMsg.regParseRecMsg(508215, rec_parse_bairenniuniu_ResExitRoom)--[[玩家请求退出房间]]
ReceiveMsg.regParseRecMsg(508216, rec_parse_bairenniuniu_ResExitTable)--[[玩家请求退出房间牌桌结果]]
ReceiveMsg.regParseRecMsg(508218, rec_parse_bairenniuniu_ResDealCards)--[[发牌]]
ReceiveMsg.regParseRecMsg(508219, rec_parse_bairenniuniu_ResOtherEnterTable)--[[其他人进入桌子]]
ReceiveMsg.regParseRecMsg(508221, rec_parse_bairenniuniu_ResBet)--[[返回下注结果]]
ReceiveMsg.regParseRecMsg(508222, rec_parse_bairenniuniu_ResTableBet)--[[桌子筹码变化]]
ReceiveMsg.regParseRecMsg(508223, rec_parse_bairenniuniu_ResApplyBankers)--[[玩家申请庄家列表]]
ReceiveMsg.regParseRecMsg(508224, rec_parse_bairenniuniu_ResBankerInfo)--[[庄家信息]]
ReceiveMsg.regParseRecMsg(508225, rec_parse_bairenniuniu_ResTime)--[[通知客户端计时]]
ReceiveMsg.regParseRecMsg(508226, rec_parse_bairenniuniu_ResHistory)--[[历史输赢记录]]
ReceiveMsg.regParseRecMsg(508227, rec_parse_bairenniuniu_ResBalance)--[[返回结算结果]]
ReceiveMsg.regParseRecMsg(508231, rec_parse_bairenniuniu_ResClearBet)--[[清空下注结果]]
