#remark
--[[
	通用错误消息消息
	msg = {
		名称:msgId 类型:int 备注:消息id
		名称:system 类型:int 备注:系统(暂时未用)
		名称:args 类型:List<String> 备注:消息参数
	}
]]
local function rec_pro_common_ResError(msg)
	player_manager:resErrorMsg(msg)
end

--[[
	通用警告消息消息
	msg = {
		名称:msgId 类型:int 备注:消息id
		名称:system 类型:int 备注:系统(暂时未用)
		名称:args 类型:List<String> 备注:消息参数
	}
]]
local function rec_pro_common_ResWarn(msg)
	player_manager:resErrorMsg(msg)
end

--[[
	通用提示消息消息
	msg = {
		名称:msgId 类型:int 备注:消息id
		名称:system 类型:int 备注:系统(暂时未用)
		名称:args 类型:List<String> 备注:消息参数
	}
]]
local function rec_pro_common_ResTip(msg)
	--add your logic code here
	player_manager:resErrorMsg(msg)
end

--[[
	通用右下角展示消息消息
	msg = {
		名称:msgId 类型:int 备注:消息id
		名称:system 类型:int 备注:系统(暂时未用)
		名称:args 类型:List<String> 备注:消息参数
	}
]]
local function rec_pro_common_ResShow(msg)
	--add your logic code here
	--TipsManager:showInformPanel( msg.msgId, msg.args)	
end

--[[
	比赛通知消息消息
	msg = {
		名称:apply 类型:String 备注:报名内容
		名称:leftTime 类型:int 备注:剩余开赛时间(秒)
	}
]]
local function rec_pro_common_ResMatchNotice(msg)
	--add your logic code here
	--TipsManager:showMatchInformPanel( msg.apply, msg.leftTime)
end


ReceiveMsg.regProRecMsg(105201, rec_pro_common_ResError)--通用错误消息 处理
ReceiveMsg.regProRecMsg(105202, rec_pro_common_ResWarn)--通用警告消息 处理
ReceiveMsg.regProRecMsg(105203, rec_pro_common_ResTip)--通用提示消息 处理
ReceiveMsg.regProRecMsg(105204, rec_pro_common_ResShow)--通用右下角展示消息 处理
ReceiveMsg.regProRecMsg(105205, rec_pro_common_ResMatchNotice)--比赛通知消息 处理

--传输对象说明
