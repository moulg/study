--[[
	BetInfo ={
		名称:icon 类型:int 备注:图标
		名称:bet 类型:long 备注:下注筹码
	}
]]
local function write_BetInfo(stream,bean)
	if bean.icon == nil then bean.icon = 0 end
	stream:writeInt(bean.icon)
	if bean.bet == nil then bean.bet = 0 end
	stream:writeLong(bean.bet)
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
local function write_RoomInfo(stream,bean)
	if bean.roomId == nil then bean.roomId = 0 end
	stream:writeInt(bean.roomId)
	if bean.name == nil then bean.name = "" end
	stream:writeString(bean.name)
	if bean.type == nil then bean.type = 0 end
	stream:writeInt(bean.type)
	if bean.maxNum == nil then bean.maxNum = 0 end
	stream:writeInt(bean.maxNum)
	if bean.free == nil then bean.free = 0 end
	stream:writeInt(bean.free)
	if bean.general == nil then bean.general = 0 end
	stream:writeInt(bean.general)
	if bean.crowded == nil then bean.crowded = 0 end
	stream:writeInt(bean.crowded)
	if bean.lower == nil then bean.lower = 0 end
	stream:writeInt(bean.lower)
	if bean.upper == nil then bean.upper = 0 end
	stream:writeInt(bean.upper)
	if bean.proportionGold == nil then bean.proportionGold = 0 end
	stream:writeInt(bean.proportionGold)
	if bean.proportionChips == nil then bean.proportionChips = 0 end
	stream:writeInt(bean.proportionChips)
	if bean.tabble == nil then bean.tabble = 0 end
	stream:writeInt(bean.tabble)
	if bean.maxOne == nil then bean.maxOne = 0 end
	stream:writeInt(bean.maxOne)
	if bean.minOne == nil then bean.minOne = 0 end
	stream:writeInt(bean.minOne)
	if bean.afee == nil then bean.afee = 0 end
	stream:writeInt(bean.afee)
	if bean.inType == nil then bean.inType = 0 end
	stream:writeInt(bean.inType)
	if bean.playerNum == nil then bean.playerNum = 0 end
	stream:writeInt(bean.playerNum)
	if bean.status == nil then bean.status = "" end
	stream:writeString(bean.status)
	if bean.displayNames == nil then bean.displayNames = "" end
	stream:writeString(bean.displayNames)
	if bean.placeHolder == nil then bean.placeHolder = "" end
	stream:writeString(bean.placeHolder)
end

--[[
	IconRateInfo ={
		名称:icon 类型:int 备注:图标
		名称:rate 类型:int 备注:图标倍率
	}
]]
local function write_IconRateInfo(stream,bean)
	if bean.icon == nil then bean.icon = 0 end
	stream:writeInt(bean.icon)
	if bean.rate == nil then bean.rate = 0 end
	stream:writeInt(bean.rate)
end



--[[
	请求进入金鲨银鲨大厅
	ReqEnterGameHall ={
	}
]]
function send_shark_ReqEnterGameHall(msg)
	local stream = CNetStream()
	stream:writeInt(509101)
	
	GetSocketInstance():send(stream)
end


--[[
	请求进入房间
	ReqEnterRoom ={
		名称:roomId 类型:int 备注:房间id
	}
]]
function send_shark_ReqEnterRoom(msg)
	local stream = CNetStream()
	stream:writeInt(509102)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	GetSocketInstance():send(stream)
end


--[[
	请求进入牌桌
	ReqEnterTable ={
		名称:tableId 类型:int 备注:牌桌id
		名称:order 类型:byte 备注:位置(0-1)
		名称:password 类型:String 备注:密码
	}
]]
function send_shark_ReqEnterTable(msg)
	local stream = CNetStream()
	stream:writeInt(509103)
	
	if msg.tableId == nil then msg.tableId = 0 end
	stream:writeInt(msg.tableId)
	if msg.order == nil then msg.order = 0 end
	stream:writeByte(msg.order)
	if msg.password == nil then msg.password = "" end
	stream:writeString(msg.password)
	GetSocketInstance():send(stream)
end


--[[
	玩家请求快速进入房间牌桌
	ReqFastEnterTable ={
		名称:roomId 类型:int 备注:房间id
	}
]]
function send_shark_ReqFastEnterTable(msg)
	local stream = CNetStream()
	stream:writeInt(509104)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	GetSocketInstance():send(stream)
end


--[[
	请求兑换游戏筹码
	ReqExchangeChips ={
		名称:gold 类型:long 备注:兑换的筹码的金币数量
	}
]]
function send_shark_ReqExchangeChips(msg)
	local stream = CNetStream()
	stream:writeInt(509105)
	
	if msg.gold == nil then msg.gold = 0 end
	stream:writeLong(msg.gold)
	GetSocketInstance():send(stream)
end


--[[
	请求筹码兑换金币
	ReqExchangeGolds ={
		名称:chips 类型:long 备注:兑换的金币的筹码数量
	}
]]
function send_shark_ReqExchangeGolds(msg)
	local stream = CNetStream()
	stream:writeInt(509106)
	
	if msg.chips == nil then msg.chips = 0 end
	stream:writeLong(msg.chips)
	GetSocketInstance():send(stream)
end


--[[
	玩家下注
	ReqBet ={
		名称:icon 类型:int 备注:图标
		名称:bet 类型:long 备注:下注筹筹码
	}
]]
function send_shark_ReqBet(msg)
	local stream = CNetStream()
	stream:writeInt(509107)
	
	if msg.icon == nil then msg.icon = 0 end
	stream:writeInt(msg.icon)
	if msg.bet == nil then msg.bet = 0 end
	stream:writeLong(msg.bet)
	GetSocketInstance():send(stream)
end


--[[
	玩家申请当庄家
	ReqApplyBanker ={
	}
]]
function send_shark_ReqApplyBanker(msg)
	local stream = CNetStream()
	stream:writeInt(509108)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家取消申请当庄家
	ReqCancelApplyBanker ={
	}
]]
function send_shark_ReqCancelApplyBanker(msg)
	local stream = CNetStream()
	stream:writeInt(509109)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求下庄
	ReqOffBanker ={
	}
]]
function send_shark_ReqOffBanker(msg)
	local stream = CNetStream()
	stream:writeInt(509110)
	
	GetSocketInstance():send(stream)
end


--[[
	清空下注
	ReqClearBet ={
	}
]]
function send_shark_ReqClearBet(msg)
	local stream = CNetStream()
	stream:writeInt(509111)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求退出房间牌桌
	ReqExitTable ={
	}
]]
function send_shark_ReqExitTable(msg)
	local stream = CNetStream()
	stream:writeInt(509113)
	
	GetSocketInstance():send(stream)
end


--[[
	请求退出房间
	ReqExitRoom ={
	}
]]
function send_shark_ReqExitRoom(msg)
	local stream = CNetStream()
	stream:writeInt(509114)
	
	GetSocketInstance():send(stream)
end


--[[
	请求游戏阶段
	ReqStage ={
	}
]]
function send_shark_ReqStage(msg)
	local stream = CNetStream()
	stream:writeInt(509115)
	
	GetSocketInstance():send(stream)
end


local c2s_shark_ReqEnterGameHall_msg = 509101 --[[请求进入金鲨银鲨大厅]]
local c2s_shark_ReqEnterRoom_msg = 509102 --[[请求进入房间]]
local c2s_shark_ReqEnterTable_msg = 509103 --[[请求进入牌桌]]
local c2s_shark_ReqFastEnterTable_msg = 509104 --[[玩家请求快速进入房间牌桌]]
local c2s_shark_ReqExchangeChips_msg = 509105 --[[请求兑换游戏筹码]]
local c2s_shark_ReqExchangeGolds_msg = 509106 --[[请求筹码兑换金币]]
local c2s_shark_ReqBet_msg = 509107 --[[玩家下注]]
local c2s_shark_ReqApplyBanker_msg = 509108 --[[玩家申请当庄家]]
local c2s_shark_ReqCancelApplyBanker_msg = 509109 --[[玩家取消申请当庄家]]
local c2s_shark_ReqOffBanker_msg = 509110 --[[玩家请求下庄]]
local c2s_shark_ReqClearBet_msg = 509111 --[[清空下注]]
local c2s_shark_ReqExitTable_msg = 509113 --[[玩家请求退出房间牌桌]]
local c2s_shark_ReqExitRoom_msg = 509114 --[[请求退出房间]]
local c2s_shark_ReqStage_msg = 509115 --[[请求游戏阶段]]

--[[游戏请求Map]]
gameReqFunMap[10] = {
	ReqEnterGameHall=send_shark_ReqEnterGameHall,
	ReqEnterRoom=send_shark_ReqEnterRoom,
	ReqEnterTable=send_shark_ReqEnterTable,
	ReqFastEnterTable=send_shark_ReqFastEnterTable,
	ReqExchangeChips=send_shark_ReqExchangeChips,
	ReqExchangeGolds=send_shark_ReqExchangeGolds,
	ReqBet=send_shark_ReqBet,
	ReqApplyBanker=send_shark_ReqApplyBanker,
	ReqCancelApplyBanker=send_shark_ReqCancelApplyBanker,
	ReqOffBanker=send_shark_ReqOffBanker,
	ReqClearBet=send_shark_ReqClearBet,
	ReqExitTable=send_shark_ReqExitTable,
	ReqExitRoom=send_shark_ReqExitRoom,
	ReqStage=send_shark_ReqStage,
}

