--[[
	进入小游戏大厅结果消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间类型信息
	}
]]
local function rec_pro_doudizhu_ResEnterGameHall(msg)
	--add your logic code here
	ddz_match_manager:resEnterGameHallMsg(msg)
end

--[[
	返回请求进入房间结果消息
	msg = {
		名称:apply 类型:int 备注:是否报名(0:没有,非0:报过了)
		名称:roomId 类型:int 备注:房间id
		名称:matchInfo 类型:MatchInfo 备注:比赛信息
	}
]]
local function rec_pro_doudizhu_ResEnterRoom(msg)
	--add your logic code here
	ddz_match_manager:resEnterRoomMsg(msg)	
end

--[[
	请求报名房间比赛结果消息
	msg = {
		名称:res 类型:int 备注:结果(0:成功,1:已经报过名不能报名本比赛,2:人数足够已经开赛)
	}
]]
local function rec_pro_doudizhu_ResApply(msg)
	--add your logic code here
	ddz_match_manager:resMatchApplyMsg(msg)
end

--[[
	请求取消报名比赛结果消息
	msg = {
	}
]]
local function rec_pro_doudizhu_ResCancelApply(msg)
	--add your logic code here
	ddz_match_manager:resCancelMatchApplyMsg(msg)
end

--[[
	进入牌桌结果消息
	msg = {
	}
]]
local function rec_pro_doudizhu_ResEnterTable(msg)
	--add your logic code here
	ddz_match_manager:resEnterTableMsg(msg)
end

--[[
	游戏开始消息
	msg = {
		名称:antes 类型:int 备注:底分
		名称:runsPlayerNum 类型:int 备注:比赛轮数的人数
		名称:seatInfos 类型:List<SeatInfo> 备注:房间座位信息
	}
]]
local function rec_pro_doudizhu_ResGameStart(msg)
	--add your logic code here
	ddz_match_manager:resGameStart(msg)
end

--[[
	玩家叫牌消息
	msg = {
		名称:playerId 类型:long 备注:叫牌的玩家
		名称:order 类型:int 备注:叫牌的玩家order
		名称:type 类型:int 备注:叫牌类型(0:不叫地主,1:叫地主,2:不抢地主,3:抢地主)
		名称:landlord 类型:long 备注:地主玩家id(0代表还没有确定地主)
		名称:landlordOrder 类型:int 备注:地主order
		名称:nextCallOrder 类型:int 备注:下一个叫牌的座位顺序号(0-2)
	}
]]
local function rec_pro_doudizhu_ResCallCard(msg)
	--add your logic code here
	ddz_match_manager:resCallCard(msg)
end

--[[
	底牌消息
	msg = {
		名称:cards 类型:List<int> 备注:底牌
	}
]]
local function rec_pro_doudizhu_ResHiddenCards(msg)
	--add your logic code here
	ddz_match_manager:resHiddenCards(msg)
end

--[[
	发牌消息
	msg = {
		名称:firstCallOrder 类型:int 备注:首先叫牌的座位顺序号(0-2)
		名称:cards 类型:List<int> 备注:玩家的牌
	}
]]
local function rec_pro_doudizhu_ResDealCards(msg)
	--add your logic code here
	ddz_match_manager:resDealCards(msg)
end

--[[
	玩家出牌信息消息
	msg = {
		名称:playerId 类型:long 备注:出牌的玩家
		名称:order 类型:int 备注:出牌的玩家order
		名称:cards 类型:List<int> 备注:玩家出的牌
		名称:cardsType 类型:int 备注:玩家出的牌的类型(1:单牌，2:对子,3:三不带,4:三代单，5:三带对,6:单顺,7:双顺,8:三顺,9:飞机带单,10:飞机带队,11:炸弹,12:王炸,13:四带单,14:四带队)
		名称:nextPlayOrder 类型:int 备注:下一个出牌玩家的顺序
	}
]]
local function rec_pro_doudizhu_ResPlayCards(msg)
	--add your logic code here
	ddz_match_manager:resPlayCards(msg)
end

--[[
	玩家放弃(不要)结果消息
	msg = {
		名称:order 类型:int 备注:放弃出牌的玩家位置
		名称:nextPlayOrder 类型:int 备注:下一个出牌玩家的顺序
	}
]]
local function rec_pro_doudizhu_ResAbandon(msg)
	--add your logic code here
	ddz_match_manager:resAbandon(msg)
end

--[[
	玩家加倍结果消息
	msg = {
		名称:playerId 类型:long 备注:加倍的玩家
		名称:order 类型:int 备注:加倍的玩家order
		名称:doubled 类型:byte 备注:0:不加倍,非0:加倍
	}
]]
local function rec_pro_doudizhu_ResDouble(msg)
	--add your logic code here
	ddz_match_manager:resDouble(msg)
end

--[[
	玩家请求提示结果消息
	msg = {
		名称:cards 类型:List<int> 备注:提示的牌(牌的数量为空则没有大过上家的牌)
	}
]]
local function rec_pro_doudizhu_ResPrompt(msg)
	--add your logic code here
	ddz_match_manager:resPrompt(msg)
end

--[[
	房间比赛信息更新消息
	msg = {
		名称:roomId 类型:int 备注:房间id
		名称:matchInfo 类型:MatchInfo 备注:比赛信息
	}
]]
local function rec_pro_doudizhu_ResMatchInfoUpdate(msg)
	--add your logic code here
	ddz_match_manager:resMatchInfoUpdateMsg(msg)	
end

--[[
	桌子座位信息变更消息
	msg = {
		名称:runsPlayerNum 类型:int 备注:比赛轮数的人数
		名称:seatInfos 类型:List<SeatInfo> 备注:房间座位信息
	}
]]
local function rec_pro_doudizhu_ResTableSeatInfosUpdate(msg)
	--add your logic code here
	ddz_match_manager:resTableSeatInfosUpdate(msg)
end

--[[
	游戏结束(后面会有结算等信息)消息
	msg = {
		名称:bills 类型:List<BillInfo> 备注:结算信息
	}
]]
local function rec_pro_doudizhu_ResGameOver(msg)
	--add your logic code here
	ddz_match_manager:resGameOver(msg)
end

--[[
	玩家排名奖励消息消息
	msg = {
		名称:rank 类型:int 备注:排名
		名称:rewards 类型:List<RankRewardInfo> 备注:排名奖励
	}
]]
local function rec_pro_doudizhu_ResRankRewardInfo(msg)
	--add your logic code here
	ddz_match_manager:resRankRewardInfoMsg(msg)
end

--[[
	玩家请求退出比赛结果消息
	msg = {
	}
]]
local function rec_pro_doudizhu_ResWithdraw(msg)
	--add your logic code here
	ddz_match_manager:resExitTableMsg(msg)
end

--[[
	比赛轮数信息更新消息消息
	msg = {
		名称:runs 类型:int 备注:比赛轮数(0:预赛)
		名称:nums 类型:List<int> 备注:比赛轮数人数
		名称:tables 类型:int 备注:正在比赛的桌子数
	}
]]
local function rec_pro_doudizhu_ResMatchRunsInfoUpdate(msg)
	--add your logic code here
	ddz_match_manager:resMatchRunsWaite(msg)	
end

--[[
	游戏结束后分配桌子失败(预赛阶段才会出现)消息
	msg = {
	}
]]
local function rec_pro_doudizhu_ResAssigneSeatsFail(msg)
	--add your logic code here
	ddz_match_manager:resAssigneSeatsFail(msg)	
end

--[[
	玩家喊话消息
	msg = {
		名称:order 类型:int 备注:座位顺序(0-2)
		名称:type 类型:int 备注:0:嘲讽,2:催牌,3:赞扬
	}
]]
local function rec_pro_doudizhu_ResShout(msg)
	--add your logic code here
	ddz_match_manager:resShout(msg)
end

--[[
	比赛轮数结束消息
	msg = {
	}
]]
local function rec_pro_doudizhu_ResMatchRunsOver(msg)
	--add your logic code here
	ddz_match_manager:resMatchRunsOver(msg)	
end

--[[
	预赛被淘汰消息
	msg = {
		名称:order 类型:int 备注:座位顺序(0-2)
	}
]]
local function rec_pro_doudizhu_ResPreElimination(msg)
	--add your logic code here
	ddz_match_manager:resPreElimination(msg)	
end


ReceiveMsg.regProRecMsg(501201, rec_pro_doudizhu_ResEnterGameHall)--进入小游戏大厅结果 处理
ReceiveMsg.regProRecMsg(501202, rec_pro_doudizhu_ResEnterRoom)--返回请求进入房间结果 处理
ReceiveMsg.regProRecMsg(501203, rec_pro_doudizhu_ResApply)--请求报名房间比赛结果 处理
ReceiveMsg.regProRecMsg(501250, rec_pro_doudizhu_ResCancelApply)--请求取消报名比赛结果 处理
ReceiveMsg.regProRecMsg(501204, rec_pro_doudizhu_ResEnterTable)--进入牌桌结果 处理
ReceiveMsg.regProRecMsg(501205, rec_pro_doudizhu_ResGameStart)--游戏开始 处理
ReceiveMsg.regProRecMsg(501206, rec_pro_doudizhu_ResCallCard)--玩家叫牌 处理
ReceiveMsg.regProRecMsg(501207, rec_pro_doudizhu_ResHiddenCards)--底牌 处理
ReceiveMsg.regProRecMsg(501208, rec_pro_doudizhu_ResDealCards)--发牌 处理
ReceiveMsg.regProRecMsg(501209, rec_pro_doudizhu_ResPlayCards)--玩家出牌信息 处理
ReceiveMsg.regProRecMsg(501210, rec_pro_doudizhu_ResAbandon)--玩家放弃(不要)结果 处理
ReceiveMsg.regProRecMsg(501212, rec_pro_doudizhu_ResDouble)--玩家加倍结果 处理
ReceiveMsg.regProRecMsg(501213, rec_pro_doudizhu_ResPrompt)--玩家请求提示结果 处理
ReceiveMsg.regProRecMsg(501214, rec_pro_doudizhu_ResMatchInfoUpdate)--房间比赛信息更新 处理
ReceiveMsg.regProRecMsg(501215, rec_pro_doudizhu_ResTableSeatInfosUpdate)--桌子座位信息变更 处理
ReceiveMsg.regProRecMsg(501216, rec_pro_doudizhu_ResGameOver)--游戏结束(后面会有结算等信息) 处理
ReceiveMsg.regProRecMsg(501217, rec_pro_doudizhu_ResRankRewardInfo)--玩家排名奖励消息 处理
ReceiveMsg.regProRecMsg(501219, rec_pro_doudizhu_ResWithdraw)--玩家请求退出比赛结果 处理
ReceiveMsg.regProRecMsg(501220, rec_pro_doudizhu_ResMatchRunsInfoUpdate)--比赛轮数信息更新消息 处理
ReceiveMsg.regProRecMsg(501221, rec_pro_doudizhu_ResAssigneSeatsFail)--游戏结束后分配桌子失败(预赛阶段才会出现) 处理
ReceiveMsg.regProRecMsg(501222, rec_pro_doudizhu_ResShout)--玩家喊话 处理
ReceiveMsg.regProRecMsg(501223, rec_pro_doudizhu_ResMatchRunsOver)--比赛轮数结束 处理
ReceiveMsg.regProRecMsg(501224, rec_pro_doudizhu_ResPreElimination)--预赛被淘汰 处理

--传输对象说明
--[[
	SeatInfo = {
		order, --座位顺序(0-2)
		tableId, --桌子id
		playerId, --玩家id(负数:机器人,0:代表座位上没有人)
		playerName, --玩家name
		cedits, --积分
		rank, --当前排名
		sex, --0:男,非0:女
		icon, --玩家头像
		offline, --离线(即被系统托管),0:没有离线,非0:离线
	}
]]
--[[
	MatchInfo = {
		type, --1:快速赛,2:定时赛
		matchNum, --比赛人数
		appliedNum, --已报名玩家人数
		leftTime, --剩余开赛时间(秒,定时赛才有效)
		matchTime, --开赛时间(时间戳,只能表示2036年)
		reward, --奖励字符串
	}
]]
--[[
	RoomTypeDetailInfo = {
		type, --房间类型id
		typeName, --房间类型名称
		rooms, --房间
	}
]]
--[[
	RoomInfo = {
		roomId, --房间id
		name, --房间名称
		type, --房间类型(1:人数赛房间,2:定时赛房间)
		fee, --报名费用(金币)
		ticket, --消耗的比赛卷id
		ticketName, --消耗的比赛卷名称
		matchInfo, --正在进行的比赛
	}
]]
--[[
	BillInfo = {
		playerId, --玩家id(负数:机器人,0:代表座位上没有人)
		playerName, --玩家name
		order, --座位顺序(0-2)
		cedits, --结算积分
	}
]]
--[[
	RankRewardInfo = {
		id, --物品id
		num, --物品数量
	}
]]
