--[[
	FishDieInfo ={
		名称:fishId 类型:int 备注:鱼id
		名称:score 类型:int 备注:分数
	}
]]
local function write_FishDieInfo(stream,bean)
	if bean.fishId == nil then bean.fishId = 0 end
	stream:writeInt(bean.fishId)
	if bean.score == nil then bean.score = 0 end
	stream:writeInt(bean.score)
end

--[[
	BatteryInfo ={
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:座位顺序
		名称:score 类型:int 备注:炮管分数
		名称:num 类型:int 备注:炮管数量
		名称:power 类型:int 备注:是否能量炮(0:不是,非0:能量炮)
	}
]]
local function write_BatteryInfo(stream,bean)
	if bean.playerId == nil then bean.playerId = 0 end
	stream:writeLong(bean.playerId)
	if bean.order == nil then bean.order = 0 end
	stream:writeInt(bean.order)
	if bean.score == nil then bean.score = 0 end
	stream:writeInt(bean.score)
	if bean.num == nil then bean.num = 0 end
	stream:writeInt(bean.num)
	if bean.power == nil then bean.power = 0 end
	stream:writeInt(bean.power)
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
	FishInfo ={
		名称:id 类型:int 备注:鱼id
		名称:type 类型:int 备注:鱼的类型
		名称:x 类型:int 备注:起点x
		名称:y 类型:int 备注:起点y
		名称:road 类型:int 备注:路径id
		名称:t 类型:long 备注:时间
		名称:angle 类型:int 备注:夹角(负数不处理)
	}
]]
local function write_FishInfo(stream,bean)
	if bean.id == nil then bean.id = 0 end
	stream:writeInt(bean.id)
	if bean.type == nil then bean.type = 0 end
	stream:writeInt(bean.type)
	if bean.x == nil then bean.x = 0 end
	stream:writeInt(bean.x)
	if bean.y == nil then bean.y = 0 end
	stream:writeInt(bean.y)
	if bean.road == nil then bean.road = 0 end
	stream:writeInt(bean.road)
	if bean.t == nil then bean.t = 0 end
	stream:writeLong(bean.t)
	if bean.angle == nil then bean.angle = 0 end
	stream:writeInt(bean.angle)
end



--[[
	请求进入大厅
	ReqEnterGameHall ={
	}
]]
function send_lkby_ReqEnterGameHall(msg)
	local stream = CNetStream()
	stream:writeInt(521101)
	
	GetSocketInstance():send(stream)
end


--[[
	请求进入房间
	ReqEnterRoom ={
		名称:roomId 类型:int 备注:房间id
	}
]]
function send_lkby_ReqEnterRoom(msg)
	local stream = CNetStream()
	stream:writeInt(521102)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	GetSocketInstance():send(stream)
end


--[[
	请求进入牌桌
	ReqEnterTable ={
		名称:tableId 类型:int 备注:牌桌id
		名称:order 类型:byte 备注:位置
		名称:password 类型:String 备注:密码
	}
]]
function send_lkby_ReqEnterTable(msg)
	local stream = CNetStream()
	stream:writeInt(521103)
	
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
function send_lkby_ReqFastEnterTable(msg)
	local stream = CNetStream()
	stream:writeInt(521115)
	
	if msg.roomId == nil then msg.roomId = 0 end
	stream:writeInt(msg.roomId)
	GetSocketInstance():send(stream)
end


--[[
	请求兑换游戏筹码
	ReqExchangeChips ={
	}
]]
function send_lkby_ReqExchangeChips(msg)
	local stream = CNetStream()
	stream:writeInt(521104)
	
	GetSocketInstance():send(stream)
end


--[[
	请求筹码兑换金币
	ReqExchangeGolds ={
	}
]]
function send_lkby_ReqExchangeGolds(msg)
	local stream = CNetStream()
	stream:writeInt(521105)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求开炮
	ReqFire ={
		名称:angle 类型:int 备注:夹角
	}
]]
function send_lkby_ReqFire(msg)
	local stream = CNetStream()
	stream:writeInt(521106)
	
	if msg.angle == nil then msg.angle = 0 end
	stream:writeInt(msg.angle)
	GetSocketInstance():send(stream)
end


--[[
	子弹打中鱼
	ReqHit ={
		名称:playerId 类型:long 备注:玩家id
		名称:bulletId 类型:int 备注:子弹id
		名称:fishId 类型:int 备注:鱼id
	}
]]
function send_lkby_ReqHit(msg)
	local stream = CNetStream()
	stream:writeInt(521108)
	
	if msg.playerId == nil then msg.playerId = 0 end
	stream:writeLong(msg.playerId)
	if msg.bulletId == nil then msg.bulletId = 0 end
	stream:writeInt(msg.bulletId)
	if msg.fishId == nil then msg.fishId = 0 end
	stream:writeInt(msg.fishId)
	GetSocketInstance():send(stream)
end


--[[
	玩家切换炮台
	ReqSwitchBattery ={
		名称:type 类型:int 备注:类型(0:加炮,非0:减炮)
	}
]]
function send_lkby_ReqSwitchBattery(msg)
	local stream = CNetStream()
	stream:writeInt(521107)
	
	if msg.type == nil then msg.type = 0 end
	stream:writeInt(msg.type)
	GetSocketInstance():send(stream)
end


--[[
	请求退出房间
	ReqExitRoom ={
	}
]]
function send_lkby_ReqExitRoom(msg)
	local stream = CNetStream()
	stream:writeInt(521113)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求退出房间牌桌
	ReqExitTable ={
	}
]]
function send_lkby_ReqExitTable(msg)
	local stream = CNetStream()
	stream:writeInt(521114)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求场景数据
	ReqScence ={
	}
]]
function send_lkby_ReqScence(msg)
	local stream = CNetStream()
	stream:writeInt(521120)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家请求锁定
	ReqLock ={
		名称:fishId 类型:int 备注:锁定鱼
	}
]]
function send_lkby_ReqLock(msg)
	local stream = CNetStream()
	stream:writeInt(521121)
	
	if msg.fishId == nil then msg.fishId = 0 end
	stream:writeInt(msg.fishId)
	GetSocketInstance():send(stream)
end


--[[
	玩家取消锁定
	ReqCancelLock ={
	}
]]
function send_lkby_ReqCancelLock(msg)
	local stream = CNetStream()
	stream:writeInt(521122)
	
	GetSocketInstance():send(stream)
end


--[[
	请求兑换所有金币为游戏筹码
	ReqExchangeAllChips ={
	}
]]
function send_lkby_ReqExchangeAllChips(msg)
	local stream = CNetStream()
	stream:writeInt(521123)
	
	GetSocketInstance():send(stream)
end


local c2s_lkby_ReqEnterGameHall_msg = 521101 --[[请求进入大厅]]
local c2s_lkby_ReqEnterRoom_msg = 521102 --[[请求进入房间]]
local c2s_lkby_ReqEnterTable_msg = 521103 --[[请求进入牌桌]]
local c2s_lkby_ReqFastEnterTable_msg = 521115 --[[玩家请求快速进入房间牌桌]]
local c2s_lkby_ReqExchangeChips_msg = 521104 --[[请求兑换游戏筹码]]
local c2s_lkby_ReqExchangeGolds_msg = 521105 --[[请求筹码兑换金币]]
local c2s_lkby_ReqFire_msg = 521106 --[[玩家请求开炮]]
local c2s_lkby_ReqHit_msg = 521108 --[[子弹打中鱼]]
local c2s_lkby_ReqSwitchBattery_msg = 521107 --[[玩家切换炮台]]
local c2s_lkby_ReqExitRoom_msg = 521113 --[[请求退出房间]]
local c2s_lkby_ReqExitTable_msg = 521114 --[[玩家请求退出房间牌桌]]
local c2s_lkby_ReqScence_msg = 521120 --[[玩家请求场景数据]]
local c2s_lkby_ReqLock_msg = 521121 --[[玩家请求锁定]]
local c2s_lkby_ReqCancelLock_msg = 521122 --[[玩家取消锁定]]
local c2s_lkby_ReqExchangeAllChips_msg = 521123 --[[请求兑换所有金币为游戏筹码]]

--[[游戏请求Map]]
gameReqFunMap[12] = {
	ReqEnterGameHall=send_lkby_ReqEnterGameHall,
	ReqEnterRoom=send_lkby_ReqEnterRoom,
	ReqEnterTable=send_lkby_ReqEnterTable,
	ReqFastEnterTable=send_lkby_ReqFastEnterTable,
	ReqExchangeChips=send_lkby_ReqExchangeChips,
	ReqExchangeGolds=send_lkby_ReqExchangeGolds,
	ReqFire=send_lkby_ReqFire,
	ReqHit=send_lkby_ReqHit,
	ReqSwitchBattery=send_lkby_ReqSwitchBattery,
	ReqExitRoom=send_lkby_ReqExitRoom,
	ReqExitTable=send_lkby_ReqExitTable,
	ReqScence=send_lkby_ReqScence,
	ReqLock=send_lkby_ReqLock,
	ReqCancelLock=send_lkby_ReqCancelLock,
	ReqExchangeAllChips=send_lkby_ReqExchangeAllChips,
}

