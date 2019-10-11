--[[
	BetInfo ={
		名称:area 类型:int 备注:下注区域
		名称:chips 类型:long 备注:下注筹码
	}
]]
function read_com_wly_game_games_weishuwu_dto_BetInfo(sobj)
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
function read_com_wly_game_games_weishuwu_dto_RoomTypeDetailInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.typeName = sobj:readString()
	local roomsSize = sobj:readInt()
	obj.rooms = {}
	for i=1, roomsSize do  
		obj.rooms[i] = read_com_wly_game_games_weishuwu_dto_RoomInfo(sobj)
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
function read_com_wly_game_games_weishuwu_dto_RoomInfo(sobj)
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
function read_com_wly_game_games_weishuwu_dto_BillInfo(sobj)
	local obj = {};
	obj.order = sobj:readInt()
	obj.chips = sobj:readLong()
	
	return obj		
end

--[[
	CardsInfo ={
		名称:cards 类型:List<int> 备注:玩家的牌
		名称:id 类型:int 备注:0-4 :0庄家的牌，1:闲家1
		名称:cardsType 类型:int 备注:牌型(0非对子,1对子)
	}
]]
function read_com_wly_game_games_weishuwu_dto_CardsInfo(sobj)
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
function rec_parse_weishuwu_ResEnterGameHall(sobj)

	if sobj then
		local msg = {}
		local roomTypesSize = sobj:readInt()
		msg.roomTypes = {}
		for i=1, roomTypesSize do  
			msg.roomTypes[i] = read_com_wly_game_games_weishuwu_dto_RoomTypeDetailInfo(sobj)
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
function rec_parse_weishuwu_ResChipsChange(sobj)

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
function rec_parse_weishuwu_ResReady(sobj)

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
function rec_parse_weishuwu_ResExchangeTable(sobj)

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
function rec_parse_weishuwu_ResFastEnterTable(sobj)

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
function rec_parse_weishuwu_ResEnterRoom(sobj)

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
function rec_parse_weishuwu_ResEnterTable(sobj)

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
function rec_parse_weishuwu_ResExitRoom(sobj)

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
function rec_parse_weishuwu_ResExitTable(sobj)

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
function rec_parse_weishuwu_ResDealCards(sobj)

	if sobj then
		local msg = {}
		local cardsInfoSize = sobj:readInt()
		msg.cardsInfo = {}
		for i=1, cardsInfoSize do  
			msg.cardsInfo[i] = read_com_wly_game_games_weishuwu_dto_CardsInfo(sobj)
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
function rec_parse_weishuwu_ResOtherEnterTable(sobj)

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
		名称:area 类型:int 备注:下注区域  闲家0-4
		名称:chips 类型:long 备注:对应的筹码
	}
]]
function rec_parse_weishuwu_ResBet(sobj)

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
function rec_parse_weishuwu_ResTableBet(sobj)

	if sobj then
		local msg = {}
		local betInfoSize = sobj:readInt()
		msg.betInfo = {}
		for i=1, betInfoSize do  
			msg.betInfo[i] = read_com_wly_game_games_weishuwu_dto_BetInfo(sobj)
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
function rec_parse_weishuwu_ResApplyBankers(sobj)

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
function rec_parse_weishuwu_ResBankerInfo(sobj)

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
function rec_parse_weishuwu_ResTime(sobj)

	if sobj then
		local msg = {}
		msg.state = sobj:readInt()
		msg.time = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	历史记录
	msg ={
		名称:win 类型:List<int> 备注:吴蜀魏输赢记录
		名称:waybill 类型:List<int> 备注:路单记录
		名称:hero 类型:List<int> 备注:蜀虎将吴都督记录
	}
]]
function rec_parse_weishuwu_ResHistory(sobj)

	if sobj then
		local msg = {}
		local winSize = sobj:readInt()
		msg.win = {}
		for i=1, winSize do  
			msg.win[i] = sobj:readInt()
		end 	
		local waybillSize = sobj:readInt()
		msg.waybill = {}
		for i=1, waybillSize do  
			msg.waybill[i] = sobj:readInt()
		end 	
		local heroSize = sobj:readInt()
		msg.hero = {}
		for i=1, heroSize do  
			msg.hero[i] = sobj:readInt()
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
function rec_parse_weishuwu_ResBalance(sobj)

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
function rec_parse_weishuwu_ResResult(sobj)

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
function rec_parse_weishuwu_ResClearBet(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


s2c_weishuwu_ResEnterGameHall_msg = 522201 --[[进入游戏大厅返回房间数据]]
s2c_weishuwu_ResChipsChange_msg = 522202 --[[玩家筹码变化消息]]
s2c_weishuwu_ResReady_msg = 522204 --[[玩家准备]]
s2c_weishuwu_ResExchangeTable_msg = 522205 --[[请求交换桌子]]
s2c_weishuwu_ResFastEnterTable_msg = 522210 --[[玩家请求快速进入房间牌桌结果]]
s2c_weishuwu_ResEnterRoom_msg = 522211 --[[进入房间结果]]
s2c_weishuwu_ResEnterTable_msg = 522212 --[[进入牌桌结果]]
s2c_weishuwu_ResExitRoom_msg = 522215 --[[玩家请求退出房间]]
s2c_weishuwu_ResExitTable_msg = 522216 --[[玩家请求退出房间牌桌结果]]
s2c_weishuwu_ResDealCards_msg = 522218 --[[发牌]]
s2c_weishuwu_ResOtherEnterTable_msg = 522219 --[[其他人进入桌子]]
s2c_weishuwu_ResBet_msg = 522221 --[[返回下注结果]]
s2c_weishuwu_ResTableBet_msg = 522222 --[[桌子筹码变化]]
s2c_weishuwu_ResApplyBankers_msg = 522223 --[[玩家申请庄家列表]]
s2c_weishuwu_ResBankerInfo_msg = 522224 --[[庄家信息]]
s2c_weishuwu_ResTime_msg = 522225 --[[通知客户端计时]]
s2c_weishuwu_ResHistory_msg = 522226 --[[历史记录]]
s2c_weishuwu_ResBalance_msg = 522227 --[[返回结算结果]]
s2c_weishuwu_ResResult_msg = 522228 --[[开出的结果]]
s2c_weishuwu_ResClearBet_msg = 522231 --[[清空下注结果]]

ReceiveMsg.regParseRecMsg(522201, rec_parse_weishuwu_ResEnterGameHall)--[[进入游戏大厅返回房间数据]]
ReceiveMsg.regParseRecMsg(522202, rec_parse_weishuwu_ResChipsChange)--[[玩家筹码变化消息]]
ReceiveMsg.regParseRecMsg(522204, rec_parse_weishuwu_ResReady)--[[玩家准备]]
ReceiveMsg.regParseRecMsg(522205, rec_parse_weishuwu_ResExchangeTable)--[[请求交换桌子]]
ReceiveMsg.regParseRecMsg(522210, rec_parse_weishuwu_ResFastEnterTable)--[[玩家请求快速进入房间牌桌结果]]
ReceiveMsg.regParseRecMsg(522211, rec_parse_weishuwu_ResEnterRoom)--[[进入房间结果]]
ReceiveMsg.regParseRecMsg(522212, rec_parse_weishuwu_ResEnterTable)--[[进入牌桌结果]]
ReceiveMsg.regParseRecMsg(522215, rec_parse_weishuwu_ResExitRoom)--[[玩家请求退出房间]]
ReceiveMsg.regParseRecMsg(522216, rec_parse_weishuwu_ResExitTable)--[[玩家请求退出房间牌桌结果]]
ReceiveMsg.regParseRecMsg(522218, rec_parse_weishuwu_ResDealCards)--[[发牌]]
ReceiveMsg.regParseRecMsg(522219, rec_parse_weishuwu_ResOtherEnterTable)--[[其他人进入桌子]]
ReceiveMsg.regParseRecMsg(522221, rec_parse_weishuwu_ResBet)--[[返回下注结果]]
ReceiveMsg.regParseRecMsg(522222, rec_parse_weishuwu_ResTableBet)--[[桌子筹码变化]]
ReceiveMsg.regParseRecMsg(522223, rec_parse_weishuwu_ResApplyBankers)--[[玩家申请庄家列表]]
ReceiveMsg.regParseRecMsg(522224, rec_parse_weishuwu_ResBankerInfo)--[[庄家信息]]
ReceiveMsg.regParseRecMsg(522225, rec_parse_weishuwu_ResTime)--[[通知客户端计时]]
ReceiveMsg.regParseRecMsg(522226, rec_parse_weishuwu_ResHistory)--[[历史记录]]
ReceiveMsg.regParseRecMsg(522227, rec_parse_weishuwu_ResBalance)--[[返回结算结果]]
ReceiveMsg.regParseRecMsg(522228, rec_parse_weishuwu_ResResult)--[[开出的结果]]
ReceiveMsg.regParseRecMsg(522231, rec_parse_weishuwu_ResClearBet)--[[清空下注结果]]
