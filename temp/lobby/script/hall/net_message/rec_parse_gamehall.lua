#remark

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

--[[
	SeatInfo ={
		名称:tableId 类型:int 备注:桌子id
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:玩家id,0代表座位上没有人
	}
]]
function read_com_wly_game_gamehall_dto_SeatInfo(sobj)
	local obj = {};
	obj.tableId = sobj:readInt()
	obj.order = sobj:readInt()
	obj.playerId = sobj:readLong()
	
	return obj		
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
function read_com_wly_game_gamehall_dto_RoomSetting(sobj)
	local obj = {};
	obj.tableLimitGold = sobj:readLong()
	obj.tableLimitGoldAbled = sobj:readInt()
	obj.tableLimitIp = sobj:readInt()
	obj.tablePwd = sobj:readString()
	obj.tablePwdAbled = sobj:readInt()
	obj.roomSettingAbled = sobj:readInt()
	
	return obj		
end

--[[
	TableInfo ={
		名称:id 类型:int 备注:桌子id
		名称:roomId 类型:int 备注:所属房间id
		名称:hasPwd 类型:int 备注:0:没有密码,非0:有密码
		名称:seats 类型:List<SeatInfo> 备注:牌桌的座位信息
	}
]]
function read_com_wly_game_gamehall_dto_TableInfo(sobj)
	local obj = {};
	obj.id = sobj:readInt()
	obj.roomId = sobj:readInt()
	obj.hasPwd = sobj:readInt()
	local seatsSize = sobj:readInt()
	obj.seats = {}
	for i=1, seatsSize do  
		obj.seats[i] = read_com_wly_game_gamehall_dto_SeatInfo(sobj)
	end 	
	
	return obj		
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
function read_com_wly_game_gamehall_dto_MemInfo(sobj)
	local obj = {};
	obj.playerId = sobj:readLong()
	obj.playerName = sobj:readString()
	obj.signature = sobj:readString()
	obj.level = sobj:readInt()
	obj.sex = sobj:readInt()
	obj.icon = sobj:readInt()
	obj.gold = sobj:readLong()
	obj.cedit = sobj:readLong()
	obj.chips = sobj:readLong()
	obj.state = sobj:readInt()
	obj.vip = sobj:readInt()
	obj.tableId = sobj:readInt()
	obj.order = sobj:readInt()
	obj.sysHost = sobj:readInt()
	
	return obj		
end



--[[
	房间座位变更信息
	msg ={
		名称:seat 类型:SeatInfo 备注:房间座位信息
	}
]]
function rec_parse_gamehall_ResSeatInfoUpdate(sobj)

	if sobj then
		local msg = {}
		msg.seat = read_com_wly_game_gamehall_dto_SeatInfo(sobj)
		return msg
	end
	return nil
end


--[[
	房间成员变更信息
	msg ={
		名称:member 类型:MemInfo 备注:房间成员信息
	}
]]
function rec_parse_gamehall_ResMemInfoUpdate(sobj)

	if sobj then
		local msg = {}
		msg.member = read_com_wly_game_gamehall_dto_MemInfo(sobj)
		return msg
	end
	return nil
end


--[[
	删除房间成员信息
	msg ={
		名称:playerId 类型:long 备注:玩家id
	}
]]
function rec_parse_gamehall_ResRemoveMemInfo(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	房间设置更新
	msg ={
		名称:roomSetting 类型:RoomSetting 备注:房间设置
	}
]]
function rec_parse_gamehall_ResRoomSettingUpdate(sobj)

	if sobj then
		local msg = {}
		msg.roomSetting = read_com_wly_game_gamehall_dto_RoomSetting(sobj)
		return msg
	end
	return nil
end


--[[
	桌子密码已经改变消息
	msg ={
		名称:tableId 类型:int 备注:桌子id
		名称:hasPwd 类型:int 备注:0:没有密码,非0:有密码
	}
]]
function rec_parse_gamehall_ResTablePwdChanged(sobj)

	if sobj then
		local msg = {}
		msg.tableId = sobj:readInt()
		msg.hasPwd = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	游客升级结果
	msg ={
		名称:playerName 类型:String 备注:昵称
	}
]]
function rec_parse_gamehall_ResTouristUpdate(sobj)

	if sobj then
		local msg = {}
		msg.playerName = sobj:readString()
		return msg
	end
	return nil
end


s2c_gamehall_ResSeatInfoUpdate_msg = 112201 --[[房间座位变更信息]]
s2c_gamehall_ResMemInfoUpdate_msg = 112202 --[[房间成员变更信息]]
s2c_gamehall_ResRemoveMemInfo_msg = 112203 --[[删除房间成员信息]]
s2c_gamehall_ResRoomSettingUpdate_msg = 112204 --[[房间设置更新]]
s2c_gamehall_ResTablePwdChanged_msg = 112208 --[[桌子密码已经改变消息]]
s2c_gamehall_ResTouristUpdate_msg = 112209 --[[游客升级结果]]

ReceiveMsg.regParseRecMsg(112201, rec_parse_gamehall_ResSeatInfoUpdate)--[[房间座位变更信息]]
ReceiveMsg.regParseRecMsg(112202, rec_parse_gamehall_ResMemInfoUpdate)--[[房间成员变更信息]]
ReceiveMsg.regParseRecMsg(112203, rec_parse_gamehall_ResRemoveMemInfo)--[[删除房间成员信息]]
ReceiveMsg.regParseRecMsg(112204, rec_parse_gamehall_ResRoomSettingUpdate)--[[房间设置更新]]
ReceiveMsg.regParseRecMsg(112208, rec_parse_gamehall_ResTablePwdChanged)--[[桌子密码已经改变消息]]
ReceiveMsg.regParseRecMsg(112209, rec_parse_gamehall_ResTouristUpdate)--[[游客升级结果]]
