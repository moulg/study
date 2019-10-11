--[[
	玩家转账消息
	msg ={
		名称:target 类型:long 备注:转账目标玩家
		名称:gold 类型:long 备注:金币
	}
]]
function rec_parse_bank_ResTransferGoldSuccess(sobj)

	if sobj then
		local msg = {}
		msg.target = sobj:readLong()
		msg.gold = sobj:readLong()
		return msg
	end
	return nil
end

--[[
	银行卡体现消息
	msg ={
		名称:result 类型:int 备注:0成功  1失败
		名称:msg 类型:String 备注:结果消息
	}
]]
function rec_parse_bank_ResBankReflectSuccess(sobj)
	
	if sobj then
		local msg = {}
		msg.result = sobj:readInt()
		msg.msg = sobj:readString()
		return msg
	end
	return nil
end

--[[
	绑定银行卡消息
	msg ={
		名称:result 类型:int 备注:0成功  1失败
		名称:msg 类型:String 备注:结果消息
	}
]]
function rec_parse_bank_ResBankBangdingSuccess(sobj)
	
	if sobj then
		local msg = {}
		msg.result = sobj:readInt()
		msg.msg = sobj:readString()
		return msg
	end
	return nil
end

--[[
	转账记录消息
	msg ={
		名称:strjson 类型:String 备注:结果消息
	}
]]
function rec_parse_bank_ResGaveRecordSuccess(sobj)
	
	if sobj then
		local msg = {}
		msg.strjson = sobj:readString()
		return msg
	end
	return nil
end

s2c_bank_ResTransferGoldSuccess_msg = 107201 --[[玩家转账消息]]
s2c_bank_ResBankBangdingSuccess_msg = 107202 --[[绑定银行卡消息]]
s2c_bank_ResBankReflectSuccess_msg = 107203 --[[银行卡体现消息]]
s2c_bank_ResGaveRecordSuccess_msg = 107204 --[[转账记录消息]]

ReceiveMsg.regParseRecMsg(107201, rec_parse_bank_ResTransferGoldSuccess)--[[玩家转账消息]]
ReceiveMsg.regParseRecMsg(107202, rec_parse_bank_ResBankBangdingSuccess)--[[绑定银行卡消息]]
ReceiveMsg.regParseRecMsg(107203, rec_parse_bank_ResBankReflectSuccess)--[[银行卡体现消息]]
ReceiveMsg.regParseRecMsg(107204, rec_parse_bank_ResGaveRecordSuccess)--[[转账记录消息]]
