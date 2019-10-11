#remark
--[[
	房间座位变更信息消息
	msg = {
		名称:seat 类型:SeatInfo 备注:房间座位信息
	}
]]
local function rec_pro_gamehall_ResSeatInfoUpdate(msg)
	--add your logic code here
	HallManager:resSeatInfoUpdateMsg(msg)
end

--[[
	房间成员变更信息消息
	msg = {
		名称:member 类型:MemInfo 备注:房间成员信息
	}
]]
local function rec_pro_gamehall_ResMemInfoUpdate(msg)
	--add your logic code here
	HallManager:resMemInfoUpdateMag(msg)
end

--[[
	删除房间成员信息消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
	}
]]
local function rec_pro_gamehall_ResRemoveMemInfo(msg)
	--add your logic code here
	HallManager:resRemoveMemInfoMsg(msg)
end

--[[
	房间设置更新消息
	msg = {
		名称:roomSetting 类型:RoomSetting 备注:房间设置
	}
]]
local function rec_pro_gamehall_ResRoomSettingUpdate(msg)
	--add your logic code here
	HallManager:resRoomSettingUpdateMsg(msg)
end

--[[
	桌子密码已经改变消息消息
	msg = {
		名称:tableId 类型:int 备注:桌子id
		名称:hasPwd 类型:int 备注:0:没有密码,非0:有密码
	}
]]
local function rec_pro_gamehall_ResTablePwdChanged(msg)
	--add your logic code here
	HallManager:resTablePwdChanged(msg)	
end

--[[
	游客升级结果消息
	msg = {
		名称:playerName 类型:String 备注:昵称
	}
]]
local function rec_pro_gamehall_ResTouristUpdate(msg)
	--add your logic code here
	HallManager:resAccountUpgrade(msg)
end


ReceiveMsg.regProRecMsg(112201, rec_pro_gamehall_ResSeatInfoUpdate)--房间座位变更信息 处理
ReceiveMsg.regProRecMsg(112202, rec_pro_gamehall_ResMemInfoUpdate)--房间成员变更信息 处理
ReceiveMsg.regProRecMsg(112203, rec_pro_gamehall_ResRemoveMemInfo)--删除房间成员信息 处理
ReceiveMsg.regProRecMsg(112204, rec_pro_gamehall_ResRoomSettingUpdate)--房间设置更新 处理
ReceiveMsg.regProRecMsg(112208, rec_pro_gamehall_ResTablePwdChanged)--桌子密码已经改变消息 处理
ReceiveMsg.regProRecMsg(112209, rec_pro_gamehall_ResTouristUpdate)--游客升级结果 处理

--传输对象说明
--[[
	SeatInfo = {
		tableId, --桌子id
		order, --座位顺序
		playerId, --玩家id,0代表座位上没有人
	}
]]
--[[
	RoomSetting = {
		tableLimitGold, --其他玩家金币限制
		tableLimitGoldAbled, --其他玩家金币限制是否有效(0:无效,非0:有效)
		tableLimitIp, --是否不与同ip的玩家玩(0:否,非0:是)
		tablePwd, --桌子密码
		tablePwdAbled, --桌子密码是否生效(0:无效,非0:有效)
		roomSettingAbled, --当前房间设置是否生效(0:无效,非0:有效)
	}
]]
--[[
	TableInfo = {
		id, --桌子id
		roomId, --所属房间id
		hasPwd, --0:没有密码,非0:有密码
		seats, --牌桌的座位信息
	}
]]
--[[
	MemInfo = {
		playerId, --玩家id
		playerName, --玩家昵称
		signature, --玩家签名
		level, --玩家等级
		sex, --0:男,非0:女
		icon, --玩家头像
		gold, --金币
		cedit, --积分
		chips, --筹码
		state, --状态(0:站立,1:入座,2:准备,3:游戏中)
		vip, --0:不是vip,非0:vip
		tableId, --桌号
		order, --座位号
		sysHost, --0:不是托管,非0:托管
	}
]]
