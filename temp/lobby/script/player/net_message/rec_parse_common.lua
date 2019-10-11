#remark
--[[
	通用错误消息
	msg ={
		名称:msgId 类型:int 备注:消息id
		名称:system 类型:int 备注:系统(暂时未用)
		名称:args 类型:List<String> 备注:消息参数
	}
]]
function rec_parse_common_ResError(sobj)

	if sobj then
		local msg = {}
		msg.msgId = sobj:readInt()
		msg.system = sobj:readInt()
		local argsSize = sobj:readInt()
		msg.args = {}
		for i=1, argsSize do  
			msg.args[i] = sobj:readString()
		end 	
		return msg
	end
	return nil
end


--[[
	通用警告消息
	msg ={
		名称:msgId 类型:int 备注:消息id
		名称:system 类型:int 备注:系统(暂时未用)
		名称:args 类型:List<String> 备注:消息参数
	}
]]
function rec_parse_common_ResWarn(sobj)

	if sobj then
		local msg = {}
		msg.msgId = sobj:readInt()
		msg.system = sobj:readInt()
		local argsSize = sobj:readInt()
		msg.args = {}
		for i=1, argsSize do  
			msg.args[i] = sobj:readString()
		end 	
		return msg
	end
	return nil
end


--[[
	通用提示消息
	msg ={
		名称:msgId 类型:int 备注:消息id
		名称:system 类型:int 备注:系统(暂时未用)
		名称:args 类型:List<String> 备注:消息参数
	}
]]
function rec_parse_common_ResTip(sobj)

	if sobj then
		local msg = {}
		msg.msgId = sobj:readInt()
		msg.system = sobj:readInt()
		local argsSize = sobj:readInt()
		msg.args = {}
		for i=1, argsSize do  
			msg.args[i] = sobj:readString()
		end 	
		return msg
	end
	return nil
end


--[[
	通用右下角展示消息
	msg ={
		名称:msgId 类型:int 备注:消息id
		名称:system 类型:int 备注:系统(暂时未用)
		名称:args 类型:List<String> 备注:消息参数
	}
]]
function rec_parse_common_ResShow(sobj)

	if sobj then
		local msg = {}
		msg.msgId = sobj:readInt()
		msg.system = sobj:readInt()
		local argsSize = sobj:readInt()
		msg.args = {}
		for i=1, argsSize do  
			msg.args[i] = sobj:readString()
		end 	
		return msg
	end
	return nil
end


--[[
	比赛通知消息
	msg ={
		名称:apply 类型:String 备注:报名内容
		名称:leftTime 类型:int 备注:剩余开赛时间(秒)
	}
]]
function rec_parse_common_ResMatchNotice(sobj)

	if sobj then
		local msg = {}
		msg.apply = sobj:readString()
		msg.leftTime = sobj:readInt()
		return msg
	end
	return nil
end


s2c_common_ResError_msg = 105201 --[[通用错误消息]]
s2c_common_ResWarn_msg = 105202 --[[通用警告消息]]
s2c_common_ResTip_msg = 105203 --[[通用提示消息]]
s2c_common_ResShow_msg = 105204 --[[通用右下角展示消息]]
s2c_common_ResMatchNotice_msg = 105205 --[[比赛通知消息]]


ReceiveMsg.regParseRecMsg(105201, rec_parse_common_ResError)--[[通用错误消息]]
ReceiveMsg.regParseRecMsg(105202, rec_parse_common_ResWarn)--[[通用警告消息]]
ReceiveMsg.regParseRecMsg(105203, rec_parse_common_ResTip)--[[通用提示消息]]
ReceiveMsg.regParseRecMsg(105204, rec_parse_common_ResShow)--[[通用右下角展示消息]]
ReceiveMsg.regParseRecMsg(105205, rec_parse_common_ResMatchNotice)--[[比赛通知消息]]
