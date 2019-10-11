--[[
	BankerRanker ={
		名称:id 类型:int 备注:玩家ID
		名称:name 类型:String 备注:玩家昵称
		名称:chips 类型:long 备注:玩家筹码数
	}
]]
local function write_BankerRanker(stream,bean)
	if bean.id == nil then bean.id = 0 end
	stream:writeInt(bean.id)
	if bean.name == nil then bean.name = "" end
	stream:writeString(bean.name)
	if bean.chips == nil then bean.chips = 0 end
	stream:writeLong(bean.chips)
end

--[[
	FoursIconMultiple ={
		名称:cardId 类型:int 备注:图标ID
		名称:rate 类型:int 备注:图标倍率
		名称:name 类型:String 备注:图标名称
	}
]]
local function write_FoursIconMultiple(stream,bean)
	if bean.cardId == nil then bean.cardId = 0 end
	stream:writeInt(bean.cardId)
	if bean.rate == nil then bean.rate = 0 end
	stream:writeInt(bean.rate)
	if bean.name == nil then bean.name = "" end
	stream:writeString(bean.name)
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
	BetsInfo ={
		名称:carId 类型:int 备注:图标ID
		名称:bet 类型:long 备注:下注筹码数
	}
]]
local function write_BetsInfo(stream,bean)
	if bean.carId == nil then bean.carId = 0 end
	stream:writeInt(bean.carId)
	if bean.bet == nil then bean.bet = 0 end
	stream:writeLong(bean.bet)
end



--[[
	请求进入4s店
	ReqEnterGameHall ={
	}
]]
function send_foursshop_ReqEnterGameHall(msg)
	local stream = CNetStream()
	stream:writeInt(504101)
	
	GetSocketInstance():send(stream)
end


--[[
	请求进入房间
	ReqEnterRoom ={
		名称:roomId 类型:int 备注:房间id
	}
]]
function send_foursshop_ReqEnterRoom(msg)
	local stream = CNetStream()
	stream:writeInt(504102)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	GetSocketInstance():send(stream)
end


--[[
	请求进入牌桌
	ReqEnterTable ={
		名称:roomId 类型:int 备注:房间id
		名称:tableId 类型:int 备注:牌桌id
	}
]]
function send_foursshop_ReqEnterTable(msg)
	local stream = CNetStream()
	stream:writeInt(504103)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	if msg.tableId == nil then msg.tableId = 0 end
	stream:writeInt(msg.tableId)
	GetSocketInstance():send(stream)
end


--[[
	玩家请求快速进入房间牌桌
	ReqFastEnterTable ={
		名称:roomId 类型:int 备注:房间id
	}
]]
function send_foursshop_ReqFastEnterTable(msg)
	local stream = CNetStream()
	stream:writeInt(504104)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	GetSocketInstance():send(stream)
end


--[[
	请求兑换筹码
	ReqExchangeChips ={
		名称:gold 类型:long 备注:兑换筹码的金币数量
	}
]]
function send_foursshop_ReqExchangeChips(msg)
	local stream = CNetStream()
	stream:writeInt(504105)
	
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
function send_foursshop_ReqExchangeGolds(msg)
	local stream = CNetStream()
	stream:writeInt(504106)
	
	if msg.chips == nil then msg.chips = 0 end
	stream:writeLong(msg.chips)
	GetSocketInstance():send(stream)
end


--[[
	玩家请求退出房间牌桌
	ReqExitTable ={
	}
]]
function send_foursshop_ReqExitTable(msg)
	local stream = CNetStream()
	stream:writeInt(504113)
	
	GetSocketInstance():send(stream)
end


--[[
	请求退出房间
	ReqExitRoom ={
	}
]]
function send_foursshop_ReqExitRoom(msg)
	local stream = CNetStream()
	stream:writeInt(504114)
	
	GetSocketInstance():send(stream)
end


--[[
	请求上庄
	ReqOnBanker ={
		名称:roomId 类型:int 备注:房间id
		名称:tableId 类型:int 备注:桌子id
	}
]]
function send_foursshop_ReqOnBanker(msg)
	local stream = CNetStream()
	stream:writeInt(504119)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	if msg.tableId == nil then msg.tableId = 0 end
	stream:writeInt(msg.tableId)
	GetSocketInstance():send(stream)
end


--[[
	玩家下注
	ReqBet ={
		名称:roomId 类型:int 备注:房间id
		名称:tableId 类型:int 备注:桌子id
		名称:bets 类型:BetsInfo 备注:下注信息
	}
]]
function send_foursshop_ReqBet(msg)
	local stream = CNetStream()
	stream:writeInt(504120)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	if msg.tableId == nil then msg.tableId = 0 end
	stream:writeInt(msg.tableId)
	write_BetsInfo(stream,msg.bets)
	GetSocketInstance():send(stream)
end


--[[
	取消上庄排队
	ReqCancelOnBanker ={
		名称:roomId 类型:int 备注:房间id
		名称:tableId 类型:int 备注:桌子id
	}
]]
function send_foursshop_ReqCancelOnBanker(msg)
	local stream = CNetStream()
	stream:writeInt(504121)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	if msg.tableId == nil then msg.tableId = 0 end
	stream:writeInt(msg.tableId)
	GetSocketInstance():send(stream)
end


--[[
	玩家请求下庄
	ReqCancelBanker ={
		名称:roomId 类型:int 备注:房间id
		名称:tableId 类型:int 备注:桌子id
	}
]]
function send_foursshop_ReqCancelBanker(msg)
	local stream = CNetStream()
	stream:writeInt(504122)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	if msg.tableId == nil then msg.tableId = 0 end
	stream:writeInt(msg.tableId)
	GetSocketInstance():send(stream)
end


--[[
	玩家请求续押
	ReqContinueBet ={
		名称:roomId 类型:int 备注:房间id
		名称:tableId 类型:int 备注:桌子id
	}
]]
function send_foursshop_ReqContinueBet(msg)
	local stream = CNetStream()
	stream:writeInt(504123)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	if msg.tableId == nil then msg.tableId = 0 end
	stream:writeInt(msg.tableId)
	GetSocketInstance():send(stream)
end


--[[
	清空下注
	ReqClearBet ={
		名称:roomId 类型:int 备注:房间id
		名称:tableId 类型:int 备注:桌子id
	}
]]
function send_foursshop_ReqClearBet(msg)
	local stream = CNetStream()
	stream:writeInt(504124)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	if msg.tableId == nil then msg.tableId = 0 end
	stream:writeInt(msg.tableId)
	GetSocketInstance():send(stream)
end


local c2s_foursshop_ReqEnterGameHall_msg = 504101 --[[请求进入4s店]]
local c2s_foursshop_ReqEnterRoom_msg = 504102 --[[请求进入房间]]
local c2s_foursshop_ReqEnterTable_msg = 504103 --[[请求进入牌桌]]
local c2s_foursshop_ReqFastEnterTable_msg = 504104 --[[玩家请求快速进入房间牌桌]]
local c2s_foursshop_ReqExchangeChips_msg = 504105 --[[请求兑换筹码]]
local c2s_foursshop_ReqExchangeGolds_msg = 504106 --[[请求筹码兑换金币]]
local c2s_foursshop_ReqExitTable_msg = 504113 --[[玩家请求退出房间牌桌]]
local c2s_foursshop_ReqExitRoom_msg = 504114 --[[请求退出房间]]
local c2s_foursshop_ReqOnBanker_msg = 504119 --[[请求上庄]]
local c2s_foursshop_ReqBet_msg = 504120 --[[玩家下注]]
local c2s_foursshop_ReqCancelOnBanker_msg = 504121 --[[取消上庄排队]]
local c2s_foursshop_ReqCancelBanker_msg = 504122 --[[玩家请求下庄]]
local c2s_foursshop_ReqContinueBet_msg = 504123 --[[玩家请求续押]]
local c2s_foursshop_ReqClearBet_msg = 504124 --[[清空下注]]

--[[游戏请求Map]]
gameReqFunMap[4] = {
	ReqEnterGameHall=send_foursshop_ReqEnterGameHall,
	ReqEnterRoom=send_foursshop_ReqEnterRoom,
	ReqEnterTable=send_foursshop_ReqEnterTable,
	ReqFastEnterTable=send_foursshop_ReqFastEnterTable,
	ReqExchangeChips=send_foursshop_ReqExchangeChips,
	ReqExchangeGolds=send_foursshop_ReqExchangeGolds,
	ReqExitTable=send_foursshop_ReqExitTable,
	ReqExitRoom=send_foursshop_ReqExitRoom,
	ReqOnBanker=send_foursshop_ReqOnBanker,
	ReqBet=send_foursshop_ReqBet,
	ReqCancelOnBanker=send_foursshop_ReqCancelOnBanker,
	ReqCancelBanker=send_foursshop_ReqCancelBanker,
	ReqContinueBet=send_foursshop_ReqContinueBet,
	ReqClearBet=send_foursshop_ReqClearBet,
}

