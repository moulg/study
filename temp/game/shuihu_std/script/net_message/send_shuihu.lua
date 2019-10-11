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
		名称:full 类型:int 备注:爆满人数
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
	if bean.full == nil then bean.full = 0 end
	stream:writeInt(bean.full)
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
	LineRewardIcons ={
		名称:line 类型:int 备注:中奖线路(从1开始)
		名称:icon 类型:int 备注:中奖图标
		名称:indexs 类型:List<int> 备注:中奖图标索引(从1开始)
	}
]]
local function write_LineRewardIcons(stream,bean)
	if bean.line == nil then bean.line = 0 end
	stream:writeInt(bean.line)
	if bean.icon == nil then bean.icon = 0 end
	stream:writeInt(bean.icon)
	if bean.indexs == nil then bean.indexs = {} end
	stream:writeInt(#(bean.indexs))
	for i=1, #(bean.indexs) do  
		stream:writeInt(bean.indexs[i])
	end 	
end



--[[
	请求进入水浒传大厅
	ReqEnterGameHall ={
	}
]]
function send_shuihu_ReqEnterGameHall(msg)
	local stream = CNetStream()
	stream:writeInt(503101)
	
	GetSocketInstance():send(stream)
end


--[[
	请求进入房间
	ReqEnterRoom ={
		名称:roomId 类型:int 备注:房间id
	}
]]
function send_shuihu_ReqEnterRoom(msg)
	local stream = CNetStream()
	stream:writeInt(503102)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	GetSocketInstance():send(stream)
end


--[[
	请求进入牌桌
	ReqEnterTable ={
		名称:tableId 类型:int 备注:牌桌id
	}
]]
function send_shuihu_ReqEnterTable(msg)
	local stream = CNetStream()
	stream:writeInt(503103)
	
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
function send_shuihu_ReqFastEnterTable(msg)
	local stream = CNetStream()
	stream:writeInt(503104)
	
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
function send_shuihu_ReqExchangeChips(msg)
	local stream = CNetStream()
	stream:writeInt(503105)
	
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
function send_shuihu_ReqExchangeGolds(msg)
	local stream = CNetStream()
	stream:writeInt(503106)
	
	if msg.chips == nil then msg.chips = 0 end
	stream:writeLong(msg.chips)
	GetSocketInstance():send(stream)
end


--[[
	请求水浒传游戏开始
	ReqShuiHuStart ={
		名称:line 类型:int 备注:压得线数
		名称:bet 类型:long 备注:每条线的押注筹码
	}
]]
function send_shuihu_ReqShuiHuStart(msg)
	local stream = CNetStream()
	stream:writeInt(503107)
	
	if msg.line == nil then msg.line = 0 end
	stream:writeInt(msg.line)
	if msg.bet == nil then msg.bet = 0 end
	stream:writeLong(msg.bet)
	GetSocketInstance():send(stream)
end


--[[
	请求骰子比大小游戏开始
	ReqDiceGameStart ={
		名称:bet 类型:int 备注:小于0:小,0:和,大于0:大
		名称:type 类型:int 备注:0:半比,1:全比,2:双比
	}
]]
function send_shuihu_ReqDiceGameStart(msg)
	local stream = CNetStream()
	stream:writeInt(503108)
	
	if msg.bet == nil then msg.bet = 0 end
	stream:writeInt(msg.bet)
	if msg.type == nil then msg.type = 0 end
	stream:writeInt(msg.type)
	GetSocketInstance():send(stream)
end


--[[
	请求小玛丽开始
	ReqXiaoMaLiStart ={
	}
]]
function send_shuihu_ReqXiaoMaLiStart(msg)
	local stream = CNetStream()
	stream:writeInt(503109)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求退出房间牌桌
	ReqExitTable ={
	}
]]
function send_shuihu_ReqExitTable(msg)
	local stream = CNetStream()
	stream:writeInt(503113)
	
	GetSocketInstance():send(stream)
end


--[[
	请求退出房间
	ReqExitRoom ={
	}
]]
function send_shuihu_ReqExitRoom(msg)
	local stream = CNetStream()
	stream:writeInt(503114)
	
	GetSocketInstance():send(stream)
end


--[[
	请求结算
	ReqBill ={
	}
]]
function send_shuihu_ReqBill(msg)
	local stream = CNetStream()
	stream:writeInt(503116)
	
	GetSocketInstance():send(stream)
end


local c2s_shuihu_ReqEnterGameHall_msg = 503101 --[[请求进入水浒传大厅]]
local c2s_shuihu_ReqEnterRoom_msg = 503102 --[[请求进入房间]]
local c2s_shuihu_ReqEnterTable_msg = 503103 --[[请求进入牌桌]]
local c2s_shuihu_ReqFastEnterTable_msg = 503104 --[[玩家请求快速进入房间牌桌]]
local c2s_shuihu_ReqExchangeChips_msg = 503105 --[[请求兑换筹码]]
local c2s_shuihu_ReqExchangeGolds_msg = 503106 --[[请求筹码兑换金币]]
local c2s_shuihu_ReqShuiHuStart_msg = 503107 --[[请求水浒传游戏开始]]
local c2s_shuihu_ReqDiceGameStart_msg = 503108 --[[请求骰子比大小游戏开始]]
local c2s_shuihu_ReqXiaoMaLiStart_msg = 503109 --[[请求小玛丽开始]]
local c2s_shuihu_ReqExitTable_msg = 503113 --[[玩家请求退出房间牌桌]]
local c2s_shuihu_ReqExitRoom_msg = 503114 --[[请求退出房间]]
local c2s_shuihu_ReqBill_msg = 503116 --[[请求结算]]

--[[游戏请求Map]]
gameReqFunMap[3] = {
	ReqEnterGameHall=send_shuihu_ReqEnterGameHall,
	ReqEnterRoom=send_shuihu_ReqEnterRoom,
	ReqEnterTable=send_shuihu_ReqEnterTable,
	ReqFastEnterTable=send_shuihu_ReqFastEnterTable,
	ReqExchangeChips=send_shuihu_ReqExchangeChips,
	ReqExchangeGolds=send_shuihu_ReqExchangeGolds,
	ReqShuiHuStart=send_shuihu_ReqShuiHuStart,
	ReqDiceGameStart=send_shuihu_ReqDiceGameStart,
	ReqXiaoMaLiStart=send_shuihu_ReqXiaoMaLiStart,
	ReqExitTable=send_shuihu_ReqExitTable,
	ReqExitRoom=send_shuihu_ReqExitRoom,
	ReqBill=send_shuihu_ReqBill,
}

