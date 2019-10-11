--[[
	BankerRanker ={
		名称:id 类型:int 备注:玩家ID
		名称:name 类型:String 备注:玩家昵称
		名称:chips 类型:long 备注:玩家筹码数
	}
]]
function read_com_wly_game_games_foursshop_dto_BankerRanker(sobj)
	local obj = {};
	obj.id = sobj:readInt()
	obj.name = sobj:readString()
	obj.chips = sobj:readLong()
	
	return obj		
end

--[[
	FoursIconMultiple ={
		名称:cardId 类型:int 备注:图标ID
		名称:rate 类型:int 备注:图标倍率
		名称:name 类型:String 备注:图标名称
	}
]]
function read_com_wly_game_games_foursshop_dto_FoursIconMultiple(sobj)
	local obj = {};
	obj.cardId = sobj:readInt()
	obj.rate = sobj:readInt()
	obj.name = sobj:readString()
	
	return obj		
end

--[[
	RoomTypeDetailInfo ={
		名称:type 类型:int 备注:房间类型id
		名称:typeName 类型:String 备注:房间类型名称
		名称:rooms 类型:List<RoomInfo> 备注:房间
	}
]]
function read_com_wly_game_games_foursshop_dto_RoomTypeDetailInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.typeName = sobj:readString()
	local roomsSize = sobj:readInt()
	obj.rooms = {}
	for i=1, roomsSize do  
		obj.rooms[i] = read_com_wly_game_games_foursshop_dto_RoomInfo(sobj)
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
		名称:afee 类型:int 备注:单局台费
		名称:inType 类型:int 备注:进入类型（0点击入座，1自动分配）
		名称:playerNum 类型:int 备注:玩家人数
		名称:status 类型:String 备注:状态(空闲,普通,拥挤,爆满)
		名称:displayNames 类型:String 备注:展示的属性名称
		名称:placeHolder 类型:String 备注:展示的属性名称占位符
	}
]]
function read_com_wly_game_games_foursshop_dto_RoomInfo(sobj)
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
	obj.afee = sobj:readInt()
	obj.inType = sobj:readInt()
	obj.playerNum = sobj:readInt()
	obj.status = sobj:readString()
	obj.displayNames = sobj:readString()
	obj.placeHolder = sobj:readString()
	
	return obj		
end

--[[
	BetsInfo ={
		名称:carId 类型:int 备注:图标ID
		名称:bet 类型:long 备注:下注筹码数
	}
]]
function read_com_wly_game_games_foursshop_dto_BetsInfo(sobj)
	local obj = {};
	obj.carId = sobj:readInt()
	obj.bet = sobj:readLong()
	
	return obj		
end



--[[
	进入游戏大厅返回房间数据
	msg ={
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function rec_parse_foursshop_ResEnterGameHall(sobj)

	if sobj then
		local msg = {}
		local roomTypesSize = sobj:readInt()
		msg.roomTypes = {}
		for i=1, roomTypesSize do  
			msg.roomTypes[i] = read_com_wly_game_games_foursshop_dto_RoomTypeDetailInfo(sobj)
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
function rec_parse_foursshop_ResChipsChange(sobj)

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
function rec_parse_foursshop_ResFastEnterTable(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求进入房间结果
	msg ={
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
function rec_parse_foursshop_ResEnterRoom(sobj)

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
	请求进入牌桌
	msg ={
		名称:players 类型:List<long> 备注:牌桌中的玩家
	}
]]
function rec_parse_foursshop_ResEnterTable(sobj)

	if sobj then
		local msg = {}
		local playersSize = sobj:readInt()
		msg.players = {}
		for i=1, playersSize do  
			msg.players[i] = sobj:readLong()
		end 	
		return msg
	end
	return nil
end


--[[
	4s房间人数
	msg ={
		名称:roomId 类型:int 备注:房间
		名称:type 类型:int 备注:房间类型
		名称:num 类型:int 备注:房间人数
	}
]]
function rec_parse_foursshop_ResRoomPlayerNum(sobj)

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
	玩家请求退出房间
	msg ={
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
function rec_parse_foursshop_ResExitRoom(sobj)

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
	}
]]
function rec_parse_foursshop_ResExitTable(sobj)

	if sobj then
		local msg = {}
		return msg
	end
	return nil
end


--[[
	请求结算结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:没有可结算筹码
	}
]]
function rec_parse_foursshop_ResBill(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	4s店当前开出的概率和出现的车标
	msg ={
		名称:carId 类型:int 备注:车标ID
		名称:rate 类型:int 备注:本次游戏开出的倍率
		名称:startIndex 类型:int 备注:开始位置
		名称:rewardTime 类型:int 备注:开奖时间
	}
]]
function rec_parse_foursshop_ResRandCarResult(sobj)

	if sobj then
		local msg = {}
		msg.carId = sobj:readInt()
		msg.rate = sobj:readInt()
		msg.startIndex = sobj:readInt()
		msg.rewardTime = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	返回倍率结果
	msg ={
		名称:foursPlan 类型:List<FoursIconMultiple> 备注:本局所开出的倍率
	}
]]
function rec_parse_foursshop_ResMultiple(sobj)

	if sobj then
		local msg = {}
		local foursPlanSize = sobj:readInt()
		msg.foursPlan = {}
		for i=1, foursPlanSize do  
			msg.foursPlan[i] = read_com_wly_game_games_foursshop_dto_FoursIconMultiple(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	返回结算结果
	msg ={
		名称:billChips 类型:long 备注:获得筹码数
		名称:totalChips 类型:long 备注:总筹码数
		名称:bankerEarn 类型:long 备注:庄家收益
		名称:mosaicGold 类型:long 备注:彩金池数
		名称:bankerTotalChips 类型:long 备注:庄家身上的总筹码
	}
]]
function rec_parse_foursshop_ResBalance(sobj)

	if sobj then
		local msg = {}
		msg.billChips = sobj:readLong()
		msg.totalChips = sobj:readLong()
		msg.bankerEarn = sobj:readLong()
		msg.mosaicGold = sobj:readLong()
		msg.bankerTotalChips = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	返回上庄结果
	msg ={
		名称:result 类型:int 备注:上庄结果0：成功，1：失败
		名称:bankers 类型:List<BankerRanker> 备注:目前在队列里面的庄家
	}
]]
function rec_parse_foursshop_ResOnBanker(sobj)

	if sobj then
		local msg = {}
		msg.result = sobj:readInt()
		local bankersSize = sobj:readInt()
		msg.bankers = {}
		for i=1, bankersSize do  
			msg.bankers[i] = read_com_wly_game_games_foursshop_dto_BankerRanker(sobj)
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
function rec_parse_foursshop_ResTime(sobj)

	if sobj then
		local msg = {}
		msg.state = sobj:readInt()
		msg.time = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	返回下注结果
	msg ={
		名称:result 类型:int 备注:下注结果返回0：成功，1：失败
	}
]]
function rec_parse_foursshop_ResBetResult(sobj)

	if sobj then
		local msg = {}
		msg.result = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	返回下庄结果
	msg ={
		名称:result 类型:int 备注:下注结果返回0：成功，1：失败
	}
]]
function rec_parse_foursshop_ResCancelBanker(sobj)

	if sobj then
		local msg = {}
		msg.result = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	总筹码数发生的变化
	msg ={
		名称:bestInfo 类型:List<BetsInfo> 备注:变化的筹码
	}
]]
function rec_parse_foursshop_ResBetsChange(sobj)

	if sobj then
		local msg = {}
		local bestInfoSize = sobj:readInt()
		msg.bestInfo = {}
		for i=1, bestInfoSize do  
			msg.bestInfo[i] = read_com_wly_game_games_foursshop_dto_BetsInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	返回取消上庄结果
	msg ={
		名称:result 类型:int 备注:上庄结果0：成功，1：失败
		名称:banker 类型:List<BankerRanker> 备注:队列里面的申请庄家信息
	}
]]
function rec_parse_foursshop_ResCancelOnBanker(sobj)

	if sobj then
		local msg = {}
		msg.result = sobj:readInt()
		local bankerSize = sobj:readInt()
		msg.banker = {}
		for i=1, bankerSize do  
			msg.banker[i] = read_com_wly_game_games_foursshop_dto_BankerRanker(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	庄家信息
	msg ={
		名称:playerId 类型:int 备注:庄家id
		名称:name 类型:String 备注:昵称
		名称:gold 类型:long 备注:筹码数
		名称:count 类型:int 备注:局数
		名称:score 类型:long 备注:成绩
		名称:immediately 类型:int 备注:是否立刻刷新:0是，1否
	}
]]
function rec_parse_foursshop_ResBankerInfo(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readInt()
		msg.name = sobj:readString()
		msg.gold = sobj:readLong()
		msg.count = sobj:readInt()
		msg.score = sobj:readLong()
		msg.immediately = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	申请庄家列表
	msg ={
		名称:banker 类型:List<BankerRanker> 备注:队列里面的申请庄家信息
	}
]]
function rec_parse_foursshop_ResBankerList(sobj)

	if sobj then
		local msg = {}
		local bankerSize = sobj:readInt()
		msg.banker = {}
		for i=1, bankerSize do  
			msg.banker[i] = read_com_wly_game_games_foursshop_dto_BankerRanker(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	续押返回：0成功,1失败
	msg ={
		名称:result 类型:int 备注:续押返回：0成功,1失败
	}
]]
function rec_parse_foursshop_ResContinueBet(sobj)

	if sobj then
		local msg = {}
		msg.result = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	清空下注：0成功,1失败
	msg ={
		名称:result 类型:int 备注:清空下注：0成功,1失败
	}
]]
function rec_parse_foursshop_ResClearBet(sobj)

	if sobj then
		local msg = {}
		msg.result = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	触发彩金池
	msg ={
		名称:num 类型:long 备注:获得的彩金数
	}
]]
function rec_parse_foursshop_ResMosaic(sobj)

	if sobj then
		local msg = {}
		msg.num = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	机器人下注区域
	msg ={
		名称:carId 类型:List<int> 备注:下注区域
	}
]]
function rec_parse_foursshop_ResRobtCarArea(sobj)

	if sobj then
		local msg = {}
		local carIdSize = sobj:readInt()
		msg.carId = {}
		for i=1, carIdSize do  
			msg.carId[i] = sobj:readInt()
		end 	
		return msg
	end
	return nil
end


--[[
	彩金池数量
	msg ={
		名称:mosaicGold 类型:long 备注:彩金池数量
	}
]]
function rec_parse_foursshop_ResMosaicGold(sobj)

	if sobj then
		local msg = {}
		msg.mosaicGold = sobj:readLong()
		return msg
	end
	return nil
end


s2c_foursshop_ResEnterGameHall_msg = 504201 --[[进入游戏大厅返回房间数据]]
s2c_foursshop_ResChipsChange_msg = 504202 --[[玩家筹码变化消息]]
s2c_foursshop_ResFastEnterTable_msg = 504206 --[[玩家请求快速进入房间牌桌结果]]
s2c_foursshop_ResEnterRoom_msg = 504207 --[[请求进入房间结果]]
s2c_foursshop_ResEnterTable_msg = 504208 --[[请求进入牌桌]]
s2c_foursshop_ResRoomPlayerNum_msg = 504209 --[[4s房间人数]]
s2c_foursshop_ResExitRoom_msg = 504210 --[[玩家请求退出房间]]
s2c_foursshop_ResExitTable_msg = 504211 --[[玩家请求退出房间牌桌结果]]
s2c_foursshop_ResBill_msg = 504215 --[[请求结算结果]]
s2c_foursshop_ResRandCarResult_msg = 504216 --[[4s店当前开出的概率和出现的车标]]
s2c_foursshop_ResMultiple_msg = 504217 --[[返回倍率结果]]
s2c_foursshop_ResBalance_msg = 504218 --[[返回结算结果]]
s2c_foursshop_ResOnBanker_msg = 504219 --[[返回上庄结果]]
s2c_foursshop_ResTime_msg = 504220 --[[通知客户端计时]]
s2c_foursshop_ResBetResult_msg = 504221 --[[返回下注结果]]
s2c_foursshop_ResCancelBanker_msg = 504222 --[[返回下庄结果]]
s2c_foursshop_ResBetsChange_msg = 504223 --[[总筹码数发生的变化]]
s2c_foursshop_ResCancelOnBanker_msg = 504224 --[[返回取消上庄结果]]
s2c_foursshop_ResBankerInfo_msg = 504225 --[[庄家信息]]
s2c_foursshop_ResBankerList_msg = 504226 --[[申请庄家列表]]
s2c_foursshop_ResContinueBet_msg = 504227 --[[续押返回：0成功,1失败]]
s2c_foursshop_ResClearBet_msg = 504228 --[[清空下注：0成功,1失败]]
s2c_foursshop_ResMosaic_msg = 504229 --[[触发彩金池]]
s2c_foursshop_ResRobtCarArea_msg = 504230 --[[机器人下注区域]]
s2c_foursshop_ResMosaicGold_msg = 504231 --[[彩金池数量]]

ReceiveMsg.regParseRecMsg(504201, rec_parse_foursshop_ResEnterGameHall)--[[进入游戏大厅返回房间数据]]
ReceiveMsg.regParseRecMsg(504202, rec_parse_foursshop_ResChipsChange)--[[玩家筹码变化消息]]
ReceiveMsg.regParseRecMsg(504206, rec_parse_foursshop_ResFastEnterTable)--[[玩家请求快速进入房间牌桌结果]]
ReceiveMsg.regParseRecMsg(504207, rec_parse_foursshop_ResEnterRoom)--[[请求进入房间结果]]
ReceiveMsg.regParseRecMsg(504208, rec_parse_foursshop_ResEnterTable)--[[请求进入牌桌]]
ReceiveMsg.regParseRecMsg(504209, rec_parse_foursshop_ResRoomPlayerNum)--[[4s房间人数]]
ReceiveMsg.regParseRecMsg(504210, rec_parse_foursshop_ResExitRoom)--[[玩家请求退出房间]]
ReceiveMsg.regParseRecMsg(504211, rec_parse_foursshop_ResExitTable)--[[玩家请求退出房间牌桌结果]]
ReceiveMsg.regParseRecMsg(504215, rec_parse_foursshop_ResBill)--[[请求结算结果]]
ReceiveMsg.regParseRecMsg(504216, rec_parse_foursshop_ResRandCarResult)--[[4s店当前开出的概率和出现的车标]]
ReceiveMsg.regParseRecMsg(504217, rec_parse_foursshop_ResMultiple)--[[返回倍率结果]]
ReceiveMsg.regParseRecMsg(504218, rec_parse_foursshop_ResBalance)--[[返回结算结果]]
ReceiveMsg.regParseRecMsg(504219, rec_parse_foursshop_ResOnBanker)--[[返回上庄结果]]
ReceiveMsg.regParseRecMsg(504220, rec_parse_foursshop_ResTime)--[[通知客户端计时]]
ReceiveMsg.regParseRecMsg(504221, rec_parse_foursshop_ResBetResult)--[[返回下注结果]]
ReceiveMsg.regParseRecMsg(504222, rec_parse_foursshop_ResCancelBanker)--[[返回下庄结果]]
ReceiveMsg.regParseRecMsg(504223, rec_parse_foursshop_ResBetsChange)--[[总筹码数发生的变化]]
ReceiveMsg.regParseRecMsg(504224, rec_parse_foursshop_ResCancelOnBanker)--[[返回取消上庄结果]]
ReceiveMsg.regParseRecMsg(504225, rec_parse_foursshop_ResBankerInfo)--[[庄家信息]]
ReceiveMsg.regParseRecMsg(504226, rec_parse_foursshop_ResBankerList)--[[申请庄家列表]]
ReceiveMsg.regParseRecMsg(504227, rec_parse_foursshop_ResContinueBet)--[[续押返回：0成功,1失败]]
ReceiveMsg.regParseRecMsg(504228, rec_parse_foursshop_ResClearBet)--[[清空下注：0成功,1失败]]
ReceiveMsg.regParseRecMsg(504229, rec_parse_foursshop_ResMosaic)--[[触发彩金池]]
ReceiveMsg.regParseRecMsg(504230, rec_parse_foursshop_ResRobtCarArea)--[[机器人下注区域]]
ReceiveMsg.regParseRecMsg(504231, rec_parse_foursshop_ResMosaicGold)--[[彩金池数量]]
