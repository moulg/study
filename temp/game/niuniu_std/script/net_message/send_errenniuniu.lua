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
	请求进入牛牛大厅
	ReqEnterGameHall ={
	}
]]
function send_errenniuniu_ReqEnterGameHall(msg)
	local stream = CNetStream()
	stream:writeInt(502101)
	
	GetSocketInstance():send(stream)
end


--[[
	请求兑换游戏筹码
	ReqExchangeChips ={
		名称:gold 类型:long 备注:兑换的筹码的金币数量
	}
]]
function send_errenniuniu_ReqExchangeChips(msg)
	local stream = CNetStream()
	stream:writeInt(502102)
	
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
function send_errenniuniu_ReqExchangeGolds(msg)
	local stream = CNetStream()
	stream:writeInt(502103)
	
	if msg.chips == nil then msg.chips = 0 end
	stream:writeLong(msg.chips)
	GetSocketInstance():send(stream)
end


--[[
	请求准备
	ReqReady ={
	}
]]
function send_errenniuniu_ReqReady(msg)
	local stream = CNetStream()
	stream:writeInt(502104)
	
	GetSocketInstance():send(stream)
end


--[[
	请求交换桌子
	ReqExchangeTable ={
	}
]]
function send_errenniuniu_ReqExchangeTable(msg)
	local stream = CNetStream()
	stream:writeInt(502105)
	
	GetSocketInstance():send(stream)
end


--[[
	请求叫庄家
	ReqCallDealer ={
		名称:call 类型:byte 备注:0:不叫,非0:叫
	}
]]
function send_errenniuniu_ReqCallDealer(msg)
	local stream = CNetStream()
	stream:writeInt(502106)
	
	if msg.call == nil then msg.call = 0 end
	stream:writeByte(msg.call)
	GetSocketInstance():send(stream)
end


--[[
	请求下注
	ReqBet ={
		名称:chip 类型:long 备注:筹码
	}
]]
function send_errenniuniu_ReqBet(msg)
	local stream = CNetStream()
	stream:writeInt(502108)
	
	if msg.chip == nil then msg.chip = 0 end
	stream:writeLong(msg.chip)
	GetSocketInstance():send(stream)
end


--[[
	请求摊牌
	ReqShowdown ={
		名称:cards 类型:List<int> 备注:3张牌的组合，不足3张或者不是最优牌按服务器最优牌处理
	}
]]
function send_errenniuniu_ReqShowdown(msg)
	local stream = CNetStream()
	stream:writeInt(502109)
	
	if msg.cards == nil then msg.cards = {} end
	stream:writeInt(#(msg.cards))
	for i=1, #(msg.cards) do  
		stream:writeInt(msg.cards[i])
	end 	
	GetSocketInstance():send(stream)
end


--[[
	请求进入房间
	ReqEnterRoom ={
		名称:roomId 类型:int 备注:房间id
	}
]]
function send_errenniuniu_ReqEnterRoom(msg)
	local stream = CNetStream()
	stream:writeInt(502111)
	
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
function send_errenniuniu_ReqEnterTable(msg)
	local stream = CNetStream()
	stream:writeInt(502112)
	
	if msg.tableId == nil then msg.tableId = 0 end
	stream:writeInt(msg.tableId)
	if msg.order == nil then msg.order = 0 end
	stream:writeByte(msg.order)
	if msg.password == nil then msg.password = "" end
	stream:writeString(msg.password)
	GetSocketInstance():send(stream)
end


--[[
	请求退出房间
	ReqExitRoom ={
	}
]]
function send_errenniuniu_ReqExitRoom(msg)
	local stream = CNetStream()
	stream:writeInt(502113)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求退出房间牌桌
	ReqExitTable ={
	}
]]
function send_errenniuniu_ReqExitTable(msg)
	local stream = CNetStream()
	stream:writeInt(502114)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求快速进入房间牌桌
	ReqFastEnterTable ={
		名称:roomId 类型:int 备注:房间id
	}
]]
function send_errenniuniu_ReqFastEnterTable(msg)
	local stream = CNetStream()
	stream:writeInt(502115)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	GetSocketInstance():send(stream)
end


local c2s_errenniuniu_ReqEnterGameHall_msg = 502101 --[[请求进入牛牛大厅]]
local c2s_errenniuniu_ReqExchangeChips_msg = 502102 --[[请求兑换游戏筹码]]
local c2s_errenniuniu_ReqExchangeGolds_msg = 502103 --[[请求筹码兑换金币]]
local c2s_errenniuniu_ReqReady_msg = 502104 --[[请求准备]]
local c2s_errenniuniu_ReqExchangeTable_msg = 502105 --[[请求交换桌子]]
local c2s_errenniuniu_ReqCallDealer_msg = 502106 --[[请求叫庄家]]
local c2s_errenniuniu_ReqBet_msg = 502108 --[[请求下注]]
local c2s_errenniuniu_ReqShowdown_msg = 502109 --[[请求摊牌]]
local c2s_errenniuniu_ReqEnterRoom_msg = 502111 --[[请求进入房间]]
local c2s_errenniuniu_ReqEnterTable_msg = 502112 --[[请求进入牌桌]]
local c2s_errenniuniu_ReqExitRoom_msg = 502113 --[[请求退出房间]]
local c2s_errenniuniu_ReqExitTable_msg = 502114 --[[玩家请求退出房间牌桌]]
local c2s_errenniuniu_ReqFastEnterTable_msg = 502115 --[[玩家请求快速进入房间牌桌]]

--[[游戏请求Map]]
gameReqFunMap[2] = {
	ReqEnterGameHall=send_errenniuniu_ReqEnterGameHall,
	ReqExchangeChips=send_errenniuniu_ReqExchangeChips,
	ReqExchangeGolds=send_errenniuniu_ReqExchangeGolds,
	ReqReady=send_errenniuniu_ReqReady,
	ReqExchangeTable=send_errenniuniu_ReqExchangeTable,
	ReqCallDealer=send_errenniuniu_ReqCallDealer,
	ReqBet=send_errenniuniu_ReqBet,
	ReqShowdown=send_errenniuniu_ReqShowdown,
	ReqEnterRoom=send_errenniuniu_ReqEnterRoom,
	ReqEnterTable=send_errenniuniu_ReqEnterTable,
	ReqExitRoom=send_errenniuniu_ReqExitRoom,
	ReqExitTable=send_errenniuniu_ReqExitTable,
	ReqFastEnterTable=send_errenniuniu_ReqFastEnterTable,
}

