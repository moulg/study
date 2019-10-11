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
local function write_SeatInfo(stream,bean)
	if bean.order == nil then bean.order = 0 end
	stream:writeInt(bean.order)
	if bean.tableId == nil then bean.tableId = 0 end
	stream:writeInt(bean.tableId)
	if bean.playerId == nil then bean.playerId = 0 end
	stream:writeLong(bean.playerId)
	if bean.playerName == nil then bean.playerName = "" end
	stream:writeString(bean.playerName)
	if bean.cedits == nil then bean.cedits = 0 end
	stream:writeLong(bean.cedits)
	if bean.rank == nil then bean.rank = 0 end
	stream:writeInt(bean.rank)
	if bean.sex == nil then bean.sex = 0 end
	stream:writeInt(bean.sex)
	if bean.icon == nil then bean.icon = 0 end
	stream:writeInt(bean.icon)
	if bean.offline == nil then bean.offline = 0 end
	stream:writeInt(bean.offline)
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
local function write_MatchInfo(stream,bean)
	if bean.type == nil then bean.type = 0 end
	stream:writeInt(bean.type)
	if bean.matchNum == nil then bean.matchNum = 0 end
	stream:writeInt(bean.matchNum)
	if bean.appliedNum == nil then bean.appliedNum = 0 end
	stream:writeInt(bean.appliedNum)
	if bean.leftTime == nil then bean.leftTime = 0 end
	stream:writeInt(bean.leftTime)
	if bean.matchTime == nil then bean.matchTime = 0 end
	stream:writeInt(bean.matchTime)
	if bean.reward == nil then bean.reward = "" end
	stream:writeString(bean.reward)
end

--[[
	RoomTypeDetailInfo ={
		名称:type 类型:int 备注:房间类型id
		名称:typeName 类型:String 备注:房间类型名称
		名称:rooms 类型:List<RoomInfo> 备注:房间
	}
]]
local function write_RoomTypeDetailInfo(stream,bean)
	if bean.type == nil then bean.type = 0 end
	stream:writeInt(bean.type)
	if bean.typeName == nil then bean.typeName = "" end
	stream:writeString(bean.typeName)
	if bean.rooms == nil then bean.rooms = {} end
	stream:writeInt(#(bean.rooms))
	for i=1, #(bean.rooms) do  
		write_RoomInfo(stream,bean.rooms[i])
	end 	
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
local function write_RoomInfo(stream,bean)
	if bean.roomId == nil then bean.roomId = 0 end
	stream:writeInt(bean.roomId)
	if bean.name == nil then bean.name = "" end
	stream:writeString(bean.name)
	if bean.type == nil then bean.type = 0 end
	stream:writeInt(bean.type)
	if bean.fee == nil then bean.fee = 0 end
	stream:writeInt(bean.fee)
	if bean.ticket == nil then bean.ticket = 0 end
	stream:writeInt(bean.ticket)
	if bean.ticketName == nil then bean.ticketName = "" end
	stream:writeString(bean.ticketName)
	write_MatchInfo(stream,bean.matchInfo)
end

--[[
	BillInfo ={
		名称:playerId 类型:long 备注:玩家id(负数:机器人,0:代表座位上没有人)
		名称:playerName 类型:String 备注:玩家name
		名称:order 类型:int 备注:座位顺序(0-2)
		名称:cedits 类型:long 备注:结算积分
	}
]]
local function write_BillInfo(stream,bean)
	if bean.playerId == nil then bean.playerId = 0 end
	stream:writeLong(bean.playerId)
	if bean.playerName == nil then bean.playerName = "" end
	stream:writeString(bean.playerName)
	if bean.order == nil then bean.order = 0 end
	stream:writeInt(bean.order)
	if bean.cedits == nil then bean.cedits = 0 end
	stream:writeLong(bean.cedits)
end

--[[
	RankRewardInfo ={
		名称:id 类型:int 备注:物品id
		名称:num 类型:int 备注:物品数量
	}
]]
local function write_RankRewardInfo(stream,bean)
	if bean.id == nil then bean.id = 0 end
	stream:writeInt(bean.id)
	if bean.num == nil then bean.num = 0 end
	stream:writeInt(bean.num)
end



--[[
	请求进入斗地主大厅
	ReqEnterGameHall ={
	}
]]
function send_doudizhu_ReqEnterGameHall(msg)
	local stream = CNetStream()
	stream:writeInt(501101)
	GetSocketInstance():send(stream)
end


--[[
	请求进入房间
	ReqEnterRoom ={
		名称:roomId 类型:int 备注:房间id
	}
]]
function send_doudizhu_ReqEnterRoom(msg)
	local stream = CNetStream()
	stream:writeInt(501102)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	GetSocketInstance():send(stream)
end


--[[
	请求报名房间比赛
	ReqApply ={
	}
]]
function send_doudizhu_ReqApply(msg)
	local stream = CNetStream()
	stream:writeInt(501103)
	
	GetSocketInstance():send(stream)
end


--[[
	请求取消报名
	ReqCancelApply ={
	}
]]
function send_doudizhu_ReqCancelApply(msg)
	local stream = CNetStream()
	stream:writeInt(501104)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家叫地主
	ReqCallCard ={
		名称:type 类型:byte 备注:0:不叫地主,1:叫地主,2:不抢地主,3:抢地主
	}
]]
function send_doudizhu_ReqCallCard(msg)
	local stream = CNetStream()
	stream:writeInt(501105)
	
	if msg.type == nil then msg.type = 0 end
	stream:writeByte(msg.type)
	GetSocketInstance():send(stream)
end


--[[
	玩家出牌
	ReqPlayCards ={
		名称:cards 类型:List<int> 备注:玩家打出的牌
	}
]]
function send_doudizhu_ReqPlayCards(msg)
	local stream = CNetStream()
	stream:writeInt(501106)
	
	if msg.cards == nil then msg.cards = {} end
	stream:writeInt(#(msg.cards))
	for i=1, #(msg.cards) do  
		stream:writeInt(msg.cards[i])
	end 	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求放弃(不要)出牌
	ReqAbandon ={
	}
]]
function send_doudizhu_ReqAbandon(msg)
	local stream = CNetStream()
	stream:writeInt(501107)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求加倍
	ReqDouble ={
		名称:doubled 类型:byte 备注:0:不加倍,非0:加倍
	}
]]
function send_doudizhu_ReqDouble(msg)
	local stream = CNetStream()
	stream:writeInt(501111)
	
	if msg.doubled == nil then msg.doubled = 0 end
	stream:writeByte(msg.doubled)
	GetSocketInstance():send(stream)
end


--[[
	玩家请求提示牌
	ReqPrompt ={
	}
]]
function send_doudizhu_ReqPrompt(msg)
	local stream = CNetStream()
	stream:writeInt(501112)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求退出房间牌桌
	ReqExitRoom ={
	}
]]
function send_doudizhu_ReqExitRoom(msg)
	local stream = CNetStream()
	stream:writeInt(501113)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求退出比赛(如果在表赛中，退出了比赛会被托管)
	ReqWithdraw ={
	}
]]
function send_doudizhu_ReqWithdraw(msg)
	local stream = CNetStream()
	stream:writeInt(501114)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家 喊话
	ReqShout ={
		名称:type 类型:int 备注:1:嘲讽,2:催牌,3:赞扬
	}
]]
function send_doudizhu_ReqShout(msg)
	local stream = CNetStream()
	stream:writeInt(501115)
	
	if msg.type == nil then msg.type = 0 end
	stream:writeInt(msg.type)
	GetSocketInstance():send(stream)
end


--[[
	玩家准备
	ReqReady ={
	}
]]
function send_doudizhu_ReqReady(msg)
	local stream = CNetStream()
	stream:writeInt(501116)
	
	GetSocketInstance():send(stream)
end


local c2s_doudizhu_ReqEnterGameHall_msg = 501101 --[[请求进入斗地主大厅]]
local c2s_doudizhu_ReqEnterRoom_msg = 501102 --[[请求进入房间]]
local c2s_doudizhu_ReqApply_msg = 501103 --[[请求报名房间比赛]]
local c2s_doudizhu_ReqCancelApply_msg = 501104 --[[请求取消报名]]
local c2s_doudizhu_ReqCallCard_msg = 501105 --[[玩家叫地主]]
local c2s_doudizhu_ReqPlayCards_msg = 501106 --[[玩家出牌]]
local c2s_doudizhu_ReqAbandon_msg = 501107 --[[玩家请求放弃(不要)出牌]]
local c2s_doudizhu_ReqDouble_msg = 501111 --[[玩家请求加倍]]
local c2s_doudizhu_ReqPrompt_msg = 501112 --[[玩家请求提示牌]]
local c2s_doudizhu_ReqExitRoom_msg = 501113 --[[玩家请求退出房间牌桌]]
local c2s_doudizhu_ReqWithdraw_msg = 501114 --[[玩家请求退出比赛(如果在表赛中，退出了比赛会被托管)]]
local c2s_doudizhu_ReqShout_msg = 501115 --[[玩家 喊话]]
local c2s_doudizhu_ReqReady_msg = 501116 --[[玩家准备]]

--[[游戏请求Map]]
gameReqFunMap[1] = {
	ReqEnterGameHall=send_doudizhu_ReqEnterGameHall,
	ReqEnterRoom=send_doudizhu_ReqEnterRoom,
	ReqApply=send_doudizhu_ReqApply,
	ReqCancelApply=send_doudizhu_ReqCancelApply,
	ReqCallCard=send_doudizhu_ReqCallCard,
	ReqPlayCards=send_doudizhu_ReqPlayCards,
	ReqAbandon=send_doudizhu_ReqAbandon,
	ReqDouble=send_doudizhu_ReqDouble,
	ReqPrompt=send_doudizhu_ReqPrompt,
	ReqExitRoom=send_doudizhu_ReqExitRoom,
	ReqWithdraw=send_doudizhu_ReqWithdraw,
	ReqShout=send_doudizhu_ReqShout,
	ReqReady=send_doudizhu_ReqReady,
}

