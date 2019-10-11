#remark
--[[
	SeatInfo ={
		名称:tableId 类型:int 备注:桌子id
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:玩家id,0代表座位上没有人
	}
]]
local function write_SeatInfo(stream,bean)
	if bean.tableId == nil then bean.tableId = 0 end
	stream:writeInt(bean.tableId)
	if bean.order == nil then bean.order = 0 end
	stream:writeInt(bean.order)
	if bean.playerId == nil then bean.playerId = 0 end
	stream:writeLong(bean.playerId)
end

--[[
	RoomSetting ={
		名称:tableLimitGold 类型:long 备注:其他玩家金币限制
		名称:tableLimitGoldAbled 类型:int 备注:其他玩家金币限制是否有效(0:无效,非0:有效)
		名称:tableLimitIp 类型:int 备注:是否不与同ip的玩家玩(0:否,非0:是)
		名称:tablePwd 类型:String 备注:桌子密码
		名称:tablePwdAbled 类型:int 备注:桌子密码是否生效(0:无效,非0:有效)
		名称:roomSettingAbled 类型:int 备注:当前房间设置是否生效(0:无效,非0:有效)
	}
]]
local function write_RoomSetting(stream,bean)
	if bean.tableLimitGold == nil then bean.tableLimitGold = 0 end
	stream:writeLong(bean.tableLimitGold)
	if bean.tableLimitGoldAbled == nil then bean.tableLimitGoldAbled = 0 end
	stream:writeInt(bean.tableLimitGoldAbled)
	if bean.tableLimitIp == nil then bean.tableLimitIp = 0 end
	stream:writeInt(bean.tableLimitIp)
	if bean.tablePwd == nil then bean.tablePwd = "" end
	stream:writeString(bean.tablePwd)
	if bean.tablePwdAbled == nil then bean.tablePwdAbled = 0 end
	stream:writeInt(bean.tablePwdAbled)
	if bean.roomSettingAbled == nil then bean.roomSettingAbled = 0 end
	stream:writeInt(bean.roomSettingAbled)
end

--[[
	TableInfo ={
		名称:id 类型:int 备注:桌子id
		名称:roomId 类型:int 备注:所属房间id
		名称:hasPwd 类型:int 备注:0:没有密码,非0:有密码
		名称:seats 类型:List<SeatInfo> 备注:牌桌的座位信息
	}
]]
local function write_TableInfo(stream,bean)
	if bean.id == nil then bean.id = 0 end
	stream:writeInt(bean.id)
	if bean.roomId == nil then bean.roomId = 0 end
	stream:writeInt(bean.roomId)
	if bean.hasPwd == nil then bean.hasPwd = 0 end
	stream:writeInt(bean.hasPwd)
	if bean.seats == nil then bean.seats = {} end
	stream:writeInt(#(bean.seats))
	for i=1, #(bean.seats) do  
		write_SeatInfo(stream,bean.seats[i])
	end 	
end

--[[
	MemInfo ={
		名称:playerId 类型:long 备注:玩家id
		名称:playerName 类型:String 备注:玩家昵称
		名称:signature 类型:String 备注:玩家签名
		名称:level 类型:int 备注:玩家等级
		名称:sex 类型:int 备注:0:男,非0:女
		名称:icon 类型:int 备注:玩家头像
		名称:gold 类型:long 备注:金币
		名称:cedit 类型:long 备注:积分
		名称:chips 类型:long 备注:筹码
		名称:state 类型:int 备注:状态(0:站立,1:入座,2:准备,3:游戏中)
		名称:vip 类型:int 备注:0:不是vip,非0:vip
		名称:tableId 类型:int 备注:桌号
		名称:order 类型:int 备注:座位号
		名称:sysHost 类型:int 备注:0:不是托管,非0:托管
	}
]]
local function write_MemInfo(stream,bean)
	if bean.playerId == nil then bean.playerId = 0 end
	stream:writeLong(bean.playerId)
	if bean.playerName == nil then bean.playerName = "" end
	stream:writeString(bean.playerName)
	if bean.signature == nil then bean.signature = "" end
	stream:writeString(bean.signature)
	if bean.level == nil then bean.level = 0 end
	stream:writeInt(bean.level)
	if bean.sex == nil then bean.sex = 0 end
	stream:writeInt(bean.sex)
	if bean.icon == nil then bean.icon = 0 end
	stream:writeInt(bean.icon)
	if bean.gold == nil then bean.gold = 0 end
	stream:writeLong(bean.gold)
	if bean.cedit == nil then bean.cedit = 0 end
	stream:writeLong(bean.cedit)
	if bean.chips == nil then bean.chips = 0 end
	stream:writeLong(bean.chips)
	if bean.state == nil then bean.state = 0 end
	stream:writeInt(bean.state)
	if bean.vip == nil then bean.vip = 0 end
	stream:writeInt(bean.vip)
	if bean.tableId == nil then bean.tableId = 0 end
	stream:writeInt(bean.tableId)
	if bean.order == nil then bean.order = 0 end
	stream:writeInt(bean.order)
	if bean.sysHost == nil then bean.sysHost = 0 end
	stream:writeInt(bean.sysHost)
end



--[[
	修改房间设置
	ReqModifyRoomSetting ={
		名称:roomSetting 类型:RoomSetting 备注:房间设置
	}
]]
function send_gamehall_ReqModifyRoomSetting(msg)
	local stream = CNetStream()
	stream:writeInt(112101)
	
	write_RoomSetting(stream,msg.roomSetting)
	GetSocketInstance():send(stream)
end


--[[
	游客账号升级
	ReqTouristUpdate ={
		名称:userName 类型:String 备注:用户名
		名称:playerName 类型:String 备注:昵称
		名称:pwd 类型:String 备注:密码
		名称:recommend 类型:long 备注:推荐人
	}
]]
function send_gamehall_ReqTouristUpdate(msg)
	local stream = CNetStream()
	stream:writeInt(112102)
	
	if msg.userName == nil then msg.userName = "" end
	stream:writeString(msg.userName)
	if msg.playerName == nil then msg.playerName = "" end
	stream:writeString(msg.playerName)
	if msg.pwd == nil then msg.pwd = "" end
	stream:writeString(msg.pwd)
	if msg.recommend == nil then msg.recommend = 0 end
	stream:writeLong(msg.recommend)
	GetSocketInstance():send(stream)
end


local c2s_gamehall_ReqModifyRoomSetting_msg = 112101 --[[修改房间设置]]
local c2s_gamehall_ReqTouristUpdate_msg = 112102 --[[游客账号升级]]


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
