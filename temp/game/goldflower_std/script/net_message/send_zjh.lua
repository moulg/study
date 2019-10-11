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
	if bean.base == nil then bean.base = 0 end
	stream:writeInt(bean.base)
	if bean.top == nil then bean.top = 0 end
	stream:writeInt(bean.top)
	if bean.chip1 == nil then bean.chip1 = 0 end
	stream:writeInt(bean.chip1)
	if bean.chip2 == nil then bean.chip2 = 0 end
	stream:writeInt(bean.chip2)
	if bean.chip3 == nil then bean.chip3 = 0 end
	stream:writeInt(bean.chip3)
	if bean.status == nil then bean.status = "" end
	stream:writeString(bean.status)
	if bean.displayNames == nil then bean.displayNames = "" end
	stream:writeString(bean.displayNames)
	if bean.placeHolder == nil then bean.placeHolder = "" end
	stream:writeString(bean.placeHolder)
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
local function write_BillInfo(stream,bean)
	if bean.order == nil then bean.order = 0 end
	stream:writeInt(bean.order)
	if bean.playerName == nil then bean.playerName = "" end
	stream:writeString(bean.playerName)
	if bean.chips == nil then bean.chips = 0 end
	stream:writeLong(bean.chips)
	if bean.luck == nil then bean.luck = 0 end
	stream:writeLong(bean.luck)
	if bean.cardsType == nil then bean.cardsType = 0 end
	stream:writeInt(bean.cardsType)
	if bean.cards == nil then bean.cards = {} end
	stream:writeInt(#(bean.cards))
	for i=1, #(bean.cards) do  
		stream:writeInt(bean.cards[i])
	end 	
end



--[[
	请求进入牛牛大厅
	ReqEnterGameHall ={
	}
]]
function send_zjh_ReqEnterGameHall(msg)
	local stream = CNetStream()
	stream:writeInt(510101)
	
	GetSocketInstance():send(stream)
end


--[[
	请求进入房间
	ReqEnterRoom ={
		名称:roomId 类型:int 备注:房间id
	}
]]
function send_zjh_ReqEnterRoom(msg)
	local stream = CNetStream()
	stream:writeInt(510102)
	
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
function send_zjh_ReqEnterTable(msg)
	local stream = CNetStream()
	stream:writeInt(510103)
	
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
function send_zjh_ReqFastEnterTable(msg)
	local stream = CNetStream()
	stream:writeInt(510104)
	
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
function send_zjh_ReqExchangeChips(msg)
	local stream = CNetStream()
	stream:writeInt(510105)
	
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
function send_zjh_ReqExchangeGolds(msg)
	local stream = CNetStream()
	stream:writeInt(510106)
	
	if msg.chips == nil then msg.chips = 0 end
	stream:writeLong(msg.chips)
	GetSocketInstance():send(stream)
end


--[[
	请求准备
	ReqReady ={
	}
]]
function send_zjh_ReqReady(msg)
	local stream = CNetStream()
	stream:writeInt(510107)
	
	GetSocketInstance():send(stream)
end


--[[
	请求交换桌子
	ReqExchangeTable ={
	}
]]
function send_zjh_ReqExchangeTable(msg)
	local stream = CNetStream()
	stream:writeInt(510108)
	
	GetSocketInstance():send(stream)
end


--[[
	请求下注(下注筹码和上家一样即跟注,比上家多即加注)
	ReqBet ={
		名称:chips 类型:long 备注:筹码
	}
]]
function send_zjh_ReqBet(msg)
	local stream = CNetStream()
	stream:writeInt(510109)
	
	if msg.chips == nil then msg.chips = 0 end
	stream:writeLong(msg.chips)
	GetSocketInstance():send(stream)
end


--[[
	请求看牌
	ReqSeeCard ={
	}
]]
function send_zjh_ReqSeeCard(msg)
	local stream = CNetStream()
	stream:writeInt(510110)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求弃牌
	ReqDiscard ={
	}
]]
function send_zjh_ReqDiscard(msg)
	local stream = CNetStream()
	stream:writeInt(510111)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求比牌
	ReqVersus ={
		名称:other 类型:long 备注:比牌的另一个玩家id(-1系统自动比)
	}
]]
function send_zjh_ReqVersus(msg)
	local stream = CNetStream()
	stream:writeInt(510112)
	
	if msg.other == nil then msg.other = 0 end
	stream:writeLong(msg.other)
	GetSocketInstance():send(stream)
end


--[[
	请求退出房间
	ReqExitRoom ={
	}
]]
function send_zjh_ReqExitRoom(msg)
	local stream = CNetStream()
	stream:writeInt(510113)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求退出房间牌桌
	ReqExitTable ={
	}
]]
function send_zjh_ReqExitTable(msg)
	local stream = CNetStream()
	stream:writeInt(510114)
	
	GetSocketInstance():send(stream)
end


local c2s_zjh_ReqEnterGameHall_msg = 510101 --[[请求进入牛牛大厅]]
local c2s_zjh_ReqEnterRoom_msg = 510102 --[[请求进入房间]]
local c2s_zjh_ReqEnterTable_msg = 510103 --[[请求进入牌桌]]
local c2s_zjh_ReqFastEnterTable_msg = 510104 --[[玩家请求快速进入房间牌桌]]
local c2s_zjh_ReqExchangeChips_msg = 510105 --[[请求兑换游戏筹码]]
local c2s_zjh_ReqExchangeGolds_msg = 510106 --[[请求筹码兑换金币]]
local c2s_zjh_ReqReady_msg = 510107 --[[请求准备]]
local c2s_zjh_ReqExchangeTable_msg = 510108 --[[请求交换桌子]]
local c2s_zjh_ReqBet_msg = 510109 --[[请求下注(下注筹码和上家一样即跟注,比上家多即加注)]]
local c2s_zjh_ReqSeeCard_msg = 510110 --[[请求看牌]]
local c2s_zjh_ReqDiscard_msg = 510111 --[[玩家请求弃牌]]
local c2s_zjh_ReqVersus_msg = 510112 --[[玩家请求比牌]]
local c2s_zjh_ReqExitRoom_msg = 510113 --[[请求退出房间]]
local c2s_zjh_ReqExitTable_msg = 510114 --[[玩家请求退出房间牌桌]]

--[[游戏请求Map]]
gameReqFunMap[17] = {
	ReqEnterGameHall=send_zjh_ReqEnterGameHall,
	ReqEnterRoom=send_zjh_ReqEnterRoom,
	ReqEnterTable=send_zjh_ReqEnterTable,
	ReqFastEnterTable=send_zjh_ReqFastEnterTable,
	ReqExchangeChips=send_zjh_ReqExchangeChips,
	ReqExchangeGolds=send_zjh_ReqExchangeGolds,
	ReqReady=send_zjh_ReqReady,
	ReqExchangeTable=send_zjh_ReqExchangeTable,
	ReqBet=send_zjh_ReqBet,
	ReqSeeCard=send_zjh_ReqSeeCard,
	ReqDiscard=send_zjh_ReqDiscard,
	ReqVersus=send_zjh_ReqVersus,
	ReqExitRoom=send_zjh_ReqExitRoom,
	ReqExitTable=send_zjh_ReqExitTable,
}

