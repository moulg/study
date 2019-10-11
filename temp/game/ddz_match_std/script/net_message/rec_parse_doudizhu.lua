--[[
	SeatInfo ={
		名称:order 类型:int 备注:座位顺序(0-2)
		名称:tableId 类型:int 备注:桌子id
		名称:playerId 类型:long 备注:玩家id(负数:机器人,0:代表座位上没有人)
		名称:playerName 类型:String 备注:玩家name
		名称:cedits 类型:long 备注:积分
		名称:rank 类型:int 备注:当前排名
		名称:sex 类型:int 备注:0:男,非0:女
		名称:icon 类型:int 备注:玩家头像
		名称:offline 类型:int 备注:离线(即被系统托管),0:没有离线,非0:离线
	}
]]
function read_com_wly_game_games_doudizhu_dto_SeatInfo(sobj)
	local obj = {};
	obj.order = sobj:readInt()
	obj.tableId = sobj:readInt()
	obj.playerId = sobj:readLong()
	obj.playerName = sobj:readString()
	obj.cedits = sobj:readLong()
	obj.rank = sobj:readInt()
	obj.sex = sobj:readInt()
	obj.icon = sobj:readInt()
	obj.offline = sobj:readInt()
	
	return obj		
end

--[[
	MatchInfo ={
		名称:type 类型:int 备注:1:快速赛,2:定时赛
		名称:matchNum 类型:int 备注:比赛人数
		名称:appliedNum 类型:int 备注:已报名玩家人数
		名称:leftTime 类型:int 备注:剩余开赛时间(秒,定时赛才有效)
		名称:matchTime 类型:int 备注:开赛时间(时间戳,只能表示2036年)
		名称:reward 类型:String 备注:奖励字符串
	}
]]
function read_com_wly_game_games_doudizhu_dto_MatchInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.matchNum = sobj:readInt()
	obj.appliedNum = sobj:readInt()
	obj.leftTime = sobj:readInt()
	obj.matchTime = sobj:readInt()
	obj.reward = sobj:readString()
	
	return obj		
end

--[[
	RoomTypeDetailInfo ={
		名称:type 类型:int 备注:房间类型id
		名称:typeName 类型:String 备注:房间类型名称
		名称:rooms 类型:List<RoomInfo> 备注:房间
	}
]]
function read_com_wly_game_games_doudizhu_dto_RoomTypeDetailInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.typeName = sobj:readString()
	local roomsSize = sobj:readInt()
	obj.rooms = {}
	for i=1, roomsSize do  
		obj.rooms[i] = read_com_wly_game_games_doudizhu_dto_RoomInfo(sobj)
	end 	
	
	return obj		
end

--[[
	RoomInfo ={
		名称:roomId 类型:int 备注:房间id
		名称:name 类型:String 备注:房间名称
		名称:type 类型:int 备注:房间类型(1:人数赛房间,2:定时赛房间)
		名称:fee 类型:int 备注:报名费用(金币)
		名称:ticket 类型:int 备注:消耗的比赛卷id
		名称:ticketName 类型:String 备注:消耗的比赛卷名称
		名称:matchInfo 类型:MatchInfo 备注:正在进行的比赛
	}
]]
function read_com_wly_game_games_doudizhu_dto_RoomInfo(sobj)
	local obj = {};
	obj.roomId = sobj:readInt()
	obj.name = sobj:readString()
	obj.type = sobj:readInt()
	obj.fee = sobj:readInt()
	obj.ticket = sobj:readInt()
	obj.ticketName = sobj:readString()
	obj.matchInfo = read_com_wly_game_games_doudizhu_dto_MatchInfo(sobj)
	return obj		
end

--[[
	BillInfo ={
		名称:playerId 类型:long 备注:玩家id(负数:机器人,0:代表座位上没有人)
		名称:playerName 类型:String 备注:玩家name
		名称:order 类型:int 备注:座位顺序(0-2)
		名称:cedits 类型:long 备注:结算积分
	}
]]
function read_com_wly_game_games_doudizhu_dto_BillInfo(sobj)
	local obj = {};
	obj.playerId = sobj:readLong()
	obj.playerName = sobj:readString()
	obj.order = sobj:readInt()
	obj.cedits = sobj:readLong()
	
	return obj		
end

--[[
	RankRewardInfo ={
		名称:id 类型:int 备注:物品id
		名称:num 类型:int 备注:物品数量
	}
]]
function read_com_wly_game_games_doudizhu_dto_RankRewardInfo(sobj)
	local obj = {};
	obj.id = sobj:readInt()
	obj.num = sobj:readInt()
	
	return obj		
end



--[[
	进入小游戏大厅结果
	msg ={
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间类型信息
	}
]]
function rec_parse_doudizhu_ResEnterGameHall(sobj)
	if sobj then
		local msg = {}
		local roomTypesSize = sobj:readInt()
		msg.roomTypes = {}
		for i=1, roomTypesSize do  
			msg.roomTypes[i] = read_com_wly_game_games_doudizhu_dto_RoomTypeDetailInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	返回请求进入房间结果
	msg ={
		名称:apply 类型:int 备注:是否报名(0:没有,非0:报过了)
		名称:roomId 类型:int 备注:房间id
		名称:matchInfo 类型:MatchInfo 备注:比赛信息
	}
]]
function rec_parse_doudizhu_ResEnterRoom(sobj)

	if sobj then
		local msg = {}
		msg.apply = sobj:readInt()
		msg.roomId = sobj:readInt()
		msg.matchInfo = read_com_wly_game_games_doudizhu_dto_MatchInfo(sobj)
		return msg
	end
	return nil
end


--[[
	请求报名房间比赛结果
	msg ={
		名称:res 类型:int 备注:结果(0:成功,1:已经报过名不能报名本比赛,2:人数足够已经开赛)
	}
]]
function rec_parse_doudizhu_ResApply(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求取消报名比赛结果
	msg ={
	}
]]
function rec_parse_doudizhu_ResCancelApply(sobj)

	if sobj then
		local msg = {}
		return msg
	end
	return nil
end


--[[
	进入牌桌结果
	msg ={
	}
]]
function rec_parse_doudizhu_ResEnterTable(sobj)

	if sobj then
		local msg = {}
		return msg
	end
	return nil
end


--[[
	游戏开始
	msg ={
		名称:antes 类型:int 备注:底分
		名称:runsPlayerNum 类型:int 备注:比赛轮数的人数
		名称:seatInfos 类型:List<SeatInfo> 备注:房间座位信息
	}
]]
function rec_parse_doudizhu_ResGameStart(sobj)

	if sobj then
		local msg = {}
		msg.antes = sobj:readInt()
		msg.runsPlayerNum = sobj:readInt()
		local seatInfosSize = sobj:readInt()
		msg.seatInfos = {}
		for i=1, seatInfosSize do  
			msg.seatInfos[i] = read_com_wly_game_games_doudizhu_dto_SeatInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	玩家叫牌
	msg ={
		名称:playerId 类型:long 备注:叫牌的玩家
		名称:order 类型:int 备注:叫牌的玩家order
		名称:type 类型:int 备注:叫牌类型(0:不叫地主,1:叫地主,2:不抢地主,3:抢地主)
		名称:landlord 类型:long 备注:地主玩家id(0代表还没有确定地主)
		名称:landlordOrder 类型:int 备注:地主order
		名称:nextCallOrder 类型:int 备注:下一个叫牌的座位顺序号(0-2)
	}
]]
function rec_parse_doudizhu_ResCallCard(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.order = sobj:readInt()
		msg.type = sobj:readInt()
		msg.landlord = sobj:readLong()
		msg.landlordOrder = sobj:readInt()
		msg.nextCallOrder = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	底牌
	msg ={
		名称:cards 类型:List<int> 备注:底牌
	}
]]
function rec_parse_doudizhu_ResHiddenCards(sobj)

	if sobj then
		local msg = {}
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
	发牌
	msg ={
		名称:firstCallOrder 类型:int 备注:首先叫牌的座位顺序号(0-2)
		名称:cards 类型:List<int> 备注:玩家的牌
	}
]]
function rec_parse_doudizhu_ResDealCards(sobj)

	if sobj then
		local msg = {}
		msg.firstCallOrder = sobj:readInt()
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
	玩家出牌信息
	msg ={
		名称:playerId 类型:long 备注:出牌的玩家
		名称:order 类型:int 备注:出牌的玩家order
		名称:cards 类型:List<int> 备注:玩家出的牌
		名称:cardsType 类型:int 备注:玩家出的牌的类型(1:单牌，2:对子,3:三不带,4:三代单，5:三带对,6:单顺,7:双顺,8:三顺,9:飞机带单,10:飞机带队,11:炸弹,12:王炸,13:四带单,14:四带队)
		名称:nextPlayOrder 类型:int 备注:下一个出牌玩家的顺序
	}
]]
function rec_parse_doudizhu_ResPlayCards(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.order = sobj:readInt()
		local cardsSize = sobj:readInt()
		msg.cards = {}
		for i=1, cardsSize do  
			msg.cards[i] = sobj:readInt()
		end 	
		msg.cardsType = sobj:readInt()
		msg.nextPlayOrder = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	玩家放弃(不要)结果
	msg ={
		名称:order 类型:int 备注:放弃出牌的玩家位置
		名称:nextPlayOrder 类型:int 备注:下一个出牌玩家的顺序
	}
]]
function rec_parse_doudizhu_ResAbandon(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.nextPlayOrder = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	玩家加倍结果
	msg ={
		名称:playerId 类型:long 备注:加倍的玩家
		名称:order 类型:int 备注:加倍的玩家order
		名称:doubled 类型:byte 备注:0:不加倍,非0:加倍
	}
]]
function rec_parse_doudizhu_ResDouble(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.order = sobj:readInt()
		msg.doubled = sobj:readByte()
		return msg
	end
	return nil
end


--[[
	玩家请求提示结果
	msg ={
		名称:cards 类型:List<int> 备注:提示的牌(牌的数量为空则没有大过上家的牌)
	}
]]
function rec_parse_doudizhu_ResPrompt(sobj)

	if sobj then
		local msg = {}
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
	房间比赛信息更新
	msg ={
		名称:roomId 类型:int 备注:房间id
		名称:matchInfo 类型:MatchInfo 备注:比赛信息
	}
]]
function rec_parse_doudizhu_ResMatchInfoUpdate(sobj)

	if sobj then
		local msg = {}
		msg.roomId = sobj:readInt()
		msg.matchInfo = read_com_wly_game_games_doudizhu_dto_MatchInfo(sobj)
		return msg
	end
	return nil
end


--[[
	桌子座位信息变更
	msg ={
		名称:runsPlayerNum 类型:int 备注:比赛轮数的人数
		名称:seatInfos 类型:List<SeatInfo> 备注:房间座位信息
	}
]]
function rec_parse_doudizhu_ResTableSeatInfosUpdate(sobj)

	if sobj then
		local msg = {}
		msg.runsPlayerNum = sobj:readInt()
		local seatInfosSize = sobj:readInt()
		msg.seatInfos = {}
		for i=1, seatInfosSize do  
			msg.seatInfos[i] = read_com_wly_game_games_doudizhu_dto_SeatInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	游戏结束(后面会有结算等信息)
	msg ={
		名称:bills 类型:List<BillInfo> 备注:结算信息
	}
]]
function rec_parse_doudizhu_ResGameOver(sobj)

	if sobj then
		local msg = {}
		local billsSize = sobj:readInt()
		msg.bills = {}
		for i=1, billsSize do  
			msg.bills[i] = read_com_wly_game_games_doudizhu_dto_BillInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	玩家排名奖励消息
	msg ={
		名称:rank 类型:int 备注:排名
		名称:rewards 类型:List<RankRewardInfo> 备注:排名奖励
	}
]]
function rec_parse_doudizhu_ResRankRewardInfo(sobj)

	if sobj then
		local msg = {}
		msg.rank = sobj:readInt()
		local rewardsSize = sobj:readInt()
		msg.rewards = {}
		for i=1, rewardsSize do  
			msg.rewards[i] = read_com_wly_game_games_doudizhu_dto_RankRewardInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	玩家请求退出比赛结果
	msg ={
	}
]]
function rec_parse_doudizhu_ResWithdraw(sobj)

	if sobj then
		local msg = {}
		return msg
	end
	return nil
end


--[[
	比赛轮数信息更新消息
	msg ={
		名称:runs 类型:int 备注:比赛轮数(0:预赛)
		名称:nums 类型:List<int> 备注:比赛轮数人数
		名称:tables 类型:int 备注:正在比赛的桌子数
	}
]]
function rec_parse_doudizhu_ResMatchRunsInfoUpdate(sobj)

	if sobj then
		local msg = {}
		msg.runs = sobj:readInt()
		local numsSize = sobj:readInt()
		msg.nums = {}
		for i=1, numsSize do  
			msg.nums[i] = sobj:readInt()
		end 	
		msg.tables = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	游戏结束后分配桌子失败(预赛阶段才会出现)
	msg ={
	}
]]
function rec_parse_doudizhu_ResAssigneSeatsFail(sobj)

	if sobj then
		local msg = {}
		return msg
	end
	return nil
end


--[[
	玩家喊话
	msg ={
		名称:order 类型:int 备注:座位顺序(0-2)
		名称:type 类型:int 备注:0:嘲讽,2:催牌,3:赞扬
	}
]]
function rec_parse_doudizhu_ResShout(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		msg.type = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	比赛轮数结束
	msg ={
	}
]]
function rec_parse_doudizhu_ResMatchRunsOver(sobj)

	if sobj then
		local msg = {}
		return msg
	end
	return nil
end


--[[
	预赛被淘汰
	msg ={
		名称:order 类型:int 备注:座位顺序(0-2)
	}
]]
function rec_parse_doudizhu_ResPreElimination(sobj)

	if sobj then
		local msg = {}
		msg.order = sobj:readInt()
		return msg
	end
	return nil
end


s2c_doudizhu_ResEnterGameHall_msg = 501201 --[[进入小游戏大厅结果]]
s2c_doudizhu_ResEnterRoom_msg = 501202 --[[返回请求进入房间结果]]
s2c_doudizhu_ResApply_msg = 501203 --[[请求报名房间比赛结果]]
s2c_doudizhu_ResCancelApply_msg = 501250 --[[请求取消报名比赛结果]]
s2c_doudizhu_ResEnterTable_msg = 501204 --[[进入牌桌结果]]
s2c_doudizhu_ResGameStart_msg = 501205 --[[游戏开始]]
s2c_doudizhu_ResCallCard_msg = 501206 --[[玩家叫牌]]
s2c_doudizhu_ResHiddenCards_msg = 501207 --[[底牌]]
s2c_doudizhu_ResDealCards_msg = 501208 --[[发牌]]
s2c_doudizhu_ResPlayCards_msg = 501209 --[[玩家出牌信息]]
s2c_doudizhu_ResAbandon_msg = 501210 --[[玩家放弃(不要)结果]]
s2c_doudizhu_ResDouble_msg = 501212 --[[玩家加倍结果]]
s2c_doudizhu_ResPrompt_msg = 501213 --[[玩家请求提示结果]]
s2c_doudizhu_ResMatchInfoUpdate_msg = 501214 --[[房间比赛信息更新]]
s2c_doudizhu_ResTableSeatInfosUpdate_msg = 501215 --[[桌子座位信息变更]]
s2c_doudizhu_ResGameOver_msg = 501216 --[[游戏结束(后面会有结算等信息)]]
s2c_doudizhu_ResRankRewardInfo_msg = 501217 --[[玩家排名奖励消息]]
s2c_doudizhu_ResWithdraw_msg = 501219 --[[玩家请求退出比赛结果]]
s2c_doudizhu_ResMatchRunsInfoUpdate_msg = 501220 --[[比赛轮数信息更新消息]]
s2c_doudizhu_ResAssigneSeatsFail_msg = 501221 --[[游戏结束后分配桌子失败(预赛阶段才会出现)]]
s2c_doudizhu_ResShout_msg = 501222 --[[玩家喊话]]
s2c_doudizhu_ResMatchRunsOver_msg = 501223 --[[比赛轮数结束]]
s2c_doudizhu_ResPreElimination_msg = 501224 --[[预赛被淘汰]]

ReceiveMsg.regParseRecMsg(501201, rec_parse_doudizhu_ResEnterGameHall)--[[进入小游戏大厅结果]]
ReceiveMsg.regParseRecMsg(501202, rec_parse_doudizhu_ResEnterRoom)--[[返回请求进入房间结果]]
ReceiveMsg.regParseRecMsg(501203, rec_parse_doudizhu_ResApply)--[[请求报名房间比赛结果]]
ReceiveMsg.regParseRecMsg(501250, rec_parse_doudizhu_ResCancelApply)--[[请求取消报名比赛结果]]
ReceiveMsg.regParseRecMsg(501204, rec_parse_doudizhu_ResEnterTable)--[[进入牌桌结果]]
ReceiveMsg.regParseRecMsg(501205, rec_parse_doudizhu_ResGameStart)--[[游戏开始]]
ReceiveMsg.regParseRecMsg(501206, rec_parse_doudizhu_ResCallCard)--[[玩家叫牌]]
ReceiveMsg.regParseRecMsg(501207, rec_parse_doudizhu_ResHiddenCards)--[[底牌]]
ReceiveMsg.regParseRecMsg(501208, rec_parse_doudizhu_ResDealCards)--[[发牌]]
ReceiveMsg.regParseRecMsg(501209, rec_parse_doudizhu_ResPlayCards)--[[玩家出牌信息]]
ReceiveMsg.regParseRecMsg(501210, rec_parse_doudizhu_ResAbandon)--[[玩家放弃(不要)结果]]
ReceiveMsg.regParseRecMsg(501212, rec_parse_doudizhu_ResDouble)--[[玩家加倍结果]]
ReceiveMsg.regParseRecMsg(501213, rec_parse_doudizhu_ResPrompt)--[[玩家请求提示结果]]
ReceiveMsg.regParseRecMsg(501214, rec_parse_doudizhu_ResMatchInfoUpdate)--[[房间比赛信息更新]]
ReceiveMsg.regParseRecMsg(501215, rec_parse_doudizhu_ResTableSeatInfosUpdate)--[[桌子座位信息变更]]
ReceiveMsg.regParseRecMsg(501216, rec_parse_doudizhu_ResGameOver)--[[游戏结束(后面会有结算等信息)]]
ReceiveMsg.regParseRecMsg(501217, rec_parse_doudizhu_ResRankRewardInfo)--[[玩家排名奖励消息]]
ReceiveMsg.regParseRecMsg(501219, rec_parse_doudizhu_ResWithdraw)--[[玩家请求退出比赛结果]]
ReceiveMsg.regParseRecMsg(501220, rec_parse_doudizhu_ResMatchRunsInfoUpdate)--[[比赛轮数信息更新消息]]
ReceiveMsg.regParseRecMsg(501221, rec_parse_doudizhu_ResAssigneSeatsFail)--[[游戏结束后分配桌子失败(预赛阶段才会出现)]]
ReceiveMsg.regParseRecMsg(501222, rec_parse_doudizhu_ResShout)--[[玩家喊话]]
ReceiveMsg.regParseRecMsg(501223, rec_parse_doudizhu_ResMatchRunsOver)--[[比赛轮数结束]]
ReceiveMsg.regParseRecMsg(501224, rec_parse_doudizhu_ResPreElimination)--[[预赛被淘汰]]
