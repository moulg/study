--[[
	HorseDetail ={
		名称:horseId 类型:int 备注:赛马ID
		名称:totalTime 类型:int 备注:总时间
		名称:segement 类型:int 备注:总时间
		名称:perTime 类型:List<int> 备注:每一段的时间
	}
]]
local function write_HorseDetail(stream,bean)
	if bean.horseId == nil then bean.horseId = 0 end
	stream:writeInt(bean.horseId)
	if bean.totalTime == nil then bean.totalTime = 0 end
	stream:writeInt(bean.totalTime)
	if bean.segement == nil then bean.segement = 0 end
	stream:writeInt(bean.segement)
	if bean.perTime == nil then bean.perTime = {} end
	stream:writeInt(#(bean.perTime))
	for i=1, #(bean.perTime) do  
		stream:writeInt(bean.perTime[i])
	end 	
end

--[[
	BetInfo ={
		名称:area 类型:int 备注:下注区域
		名称:chips 类型:long 备注:下注筹码
	}
]]
local function write_BetInfo(stream,bean)
	if bean.area == nil then bean.area = 0 end
	stream:writeInt(bean.area)
	if bean.chips == nil then bean.chips = 0 end
	stream:writeLong(bean.chips)
end

--[[
	IconMultiple ={
		名称:areId 类型:int 备注:区域ID
		名称:rate 类型:int 备注:区域对应倍率
	}
]]
local function write_IconMultiple(stream,bean)
	if bean.areId == nil then bean.areId = 0 end
	stream:writeInt(bean.areId)
	if bean.rate == nil then bean.rate = 0 end
	stream:writeInt(bean.rate)
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
	BillInfo ={
		名称:order 类型:int 备注:座位顺序
		名称:chips 类型:long 备注:结算筹码
	}
]]
local function write_BillInfo(stream,bean)
	if bean.order == nil then bean.order = 0 end
	stream:writeInt(bean.order)
	if bean.chips == nil then bean.chips = 0 end
	stream:writeLong(bean.chips)
end



--[[
	请求进入赛马大厅
	ReqEnterGameHall ={
	}
]]
function send_horserace_ReqEnterGameHall(msg)
	local stream = CNetStream()
	stream:writeInt(516101)
	
	GetSocketInstance():send(stream)
end


--[[
	请求兑换游戏筹码
	ReqExchangeChips ={
		名称:gold 类型:long 备注:兑换的筹码的金币数量
	}
]]
function send_horserace_ReqExchangeChips(msg)
	local stream = CNetStream()
	stream:writeInt(516102)
	
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
function send_horserace_ReqExchangeGolds(msg)
	local stream = CNetStream()
	stream:writeInt(516103)
	
	if msg.chips == nil then msg.chips = 0 end
	stream:writeLong(msg.chips)
	GetSocketInstance():send(stream)
end


--[[
	玩家下注
	ReqBet ={
		名称:area 类型:int 备注:下注区域  闲家1-15
		名称:chips 类型:long 备注:对应的筹码
	}
]]
function send_horserace_ReqBet(msg)
	local stream = CNetStream()
	stream:writeInt(516108)
	
	if msg.area == nil then msg.area = 0 end
	stream:writeInt(msg.area)
	if msg.chips == nil then msg.chips = 0 end
	stream:writeLong(msg.chips)
	GetSocketInstance():send(stream)
end


--[[
	请求进入房间
	ReqEnterRoom ={
		名称:roomId 类型:int 备注:房间id
	}
]]
function send_horserace_ReqEnterRoom(msg)
	local stream = CNetStream()
	stream:writeInt(516111)
	
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
function send_horserace_ReqEnterTable(msg)
	local stream = CNetStream()
	stream:writeInt(516112)
	
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
function send_horserace_ReqExitRoom(msg)
	local stream = CNetStream()
	stream:writeInt(516113)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求退出房间牌桌
	ReqExitTable ={
	}
]]
function send_horserace_ReqExitTable(msg)
	local stream = CNetStream()
	stream:writeInt(516114)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求快速进入房间牌桌
	ReqFastEnterTable ={
		名称:roomId 类型:int 备注:房间id
	}
]]
function send_horserace_ReqFastEnterTable(msg)
	local stream = CNetStream()
	stream:writeInt(516115)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	GetSocketInstance():send(stream)
end


--[[
	清空下注
	ReqClearBet ={
	}
]]
function send_horserace_ReqClearBet(msg)
	local stream = CNetStream()
	stream:writeInt(516119)
	
	GetSocketInstance():send(stream)
end


local c2s_horserace_ReqEnterGameHall_msg = 516101 --[[请求进入赛马大厅]]
local c2s_horserace_ReqExchangeChips_msg = 516102 --[[请求兑换游戏筹码]]
local c2s_horserace_ReqExchangeGolds_msg = 516103 --[[请求筹码兑换金币]]
local c2s_horserace_ReqBet_msg = 516108 --[[玩家下注]]
local c2s_horserace_ReqEnterRoom_msg = 516111 --[[请求进入房间]]
local c2s_horserace_ReqEnterTable_msg = 516112 --[[请求进入牌桌]]
local c2s_horserace_ReqExitRoom_msg = 516113 --[[请求退出房间]]
local c2s_horserace_ReqExitTable_msg = 516114 --[[玩家请求退出房间牌桌]]
local c2s_horserace_ReqFastEnterTable_msg = 516115 --[[玩家请求快速进入房间牌桌]]
local c2s_horserace_ReqClearBet_msg = 516119 --[[清空下注]]

--[[游戏请求Map]]
gameReqFunMap[16] = {
	ReqEnterGameHall=send_horserace_ReqEnterGameHall,
	ReqExchangeChips=send_horserace_ReqExchangeChips,
	ReqExchangeGolds=send_horserace_ReqExchangeGolds,
	ReqBet=send_horserace_ReqBet,
	ReqEnterRoom=send_horserace_ReqEnterRoom,
	ReqEnterTable=send_horserace_ReqEnterTable,
	ReqExitRoom=send_horserace_ReqExitRoom,
	ReqExitTable=send_horserace_ReqExitTable,
	ReqFastEnterTable=send_horserace_ReqFastEnterTable,
	ReqClearBet=send_horserace_ReqClearBet,
}

