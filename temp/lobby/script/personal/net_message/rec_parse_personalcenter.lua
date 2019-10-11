#remark
--[[
	PlayerBaseInfo ={
		名称:icon 类型:int 备注:头像id
		名称:sex 类型:String 备注:性别
		名称:age 类型:int 备注:年龄
		名称:birthMonth 类型:int 备注:生日月
		名称:birthDay 类型:int 备注:生日天
		名称:province 类型:String 备注:省
		名称:city 类型:String 备注:市
		名称:addr 类型:String 备注:地址
		名称:signature 类型:String 备注:签名
	}
]]
function read_com_wly_game_personalcenter_dto_PlayerBaseInfo(sobj)
	local obj = {};
	obj.icon = sobj:readInt()
	obj.sex = sobj:readString()
	obj.age = sobj:readInt()
	obj.birthMonth = sobj:readInt()
	obj.birthDay = sobj:readInt()
	obj.province = sobj:readString()
	obj.city = sobj:readString()
	obj.addr = sobj:readString()
	obj.signature = sobj:readString()
	
	return obj		
end



--[[
	请求绑定电脑结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:银行密码不正确
		名称:machineCode 类型:String 备注:机器码
	}
]]
function rec_parse_personalcenter_ResBindComputer(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		msg.machineCode = sobj:readString()
		return msg
	end
	return nil
end


--[[
	请求解除绑定电脑结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:银行密码不正确
	}
]]
function rec_parse_personalcenter_ResUnbindComputer(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求修改基本资料结果
	msg ={
		名称:baseInfo 类型:PlayerBaseInfo 备注:玩家基本信息
	}
]]
function rec_parse_personalcenter_ResModifyBaseInfo(sobj)

	if sobj then
		local msg = {}
		msg.baseInfo = read_com_wly_game_personalcenter_dto_PlayerBaseInfo(sobj)
		return msg
	end
	return nil
end


--[[
	请求实名认证结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:重复校验,2:姓名格式不对(2-10个汉字),3:身份证格式不对
		名称:name 类型:String 备注:姓名
		名称:idNo 类型:String 备注:身份证号
	}
]]
function rec_parse_personalcenter_ResRealNameAuthenticate(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		msg.name = sobj:readString()
		msg.idNo = sobj:readString()
		return msg
	end
	return nil
end


--[[
	请求实名认证结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:旧密码输入不正确, 2:新密码格式不对
	}
]]
function rec_parse_personalcenter_ResModifyLoginPwd(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求实名认证结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:旧密码输入不正确, 2:新密码格式不对
	}
]]
function rec_parse_personalcenter_ResModifyBankPwd(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求绑定手机
	msg ={
		名称:phone 类型:String 备注:手机
	}
]]
function rec_parse_personalcenter_ResBindPhone(sobj)

	if sobj then
		local msg = {}
		msg.phone = sobj:readString()
		return msg
	end
	return nil
end


--[[
	请求解除绑定手机返回
	msg ={
	}
]]
function rec_parse_personalcenter_ResUnBindPhone(sobj)

	if sobj then
		local msg = {}
		return msg
	end
	return nil
end


--[[
	请求获取绑定手机验证码
	msg ={
		名称:res 类型:int 备注:0:成功,1:手机号码格式错误,2:获取验证码时间间隔不足
		名称:second 类型:int 备注:当res为2时，剩余秒
	}
]]
function rec_parse_personalcenter_ResGetBindPhoneKey(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		msg.second = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求获取解除绑定手机验证码
	msg ={
		名称:res 类型:int 备注:0:成功,1:获取验证码时间间隔不足
		名称:second 类型:int 备注:当res为2时，剩余秒
	}
]]
function rec_parse_personalcenter_ResGetUnBindPhoneKey(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		msg.second = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求修改游戏设置结果
	msg ={
		名称:loginPhoneVerify 类型:int 备注:登录手机验证(0:不需要,非0:需要)
		名称:playItemEffect 类型:int 备注:播放道具特效(0:不需要,非0:需要)
	}
]]
function rec_parse_personalcenter_ResModifyGameSetting(sobj)

	if sobj then
		local msg = {}
		msg.loginPhoneVerify = sobj:readInt()
		msg.playItemEffect = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求修改密保成功结果
	msg ={
	}
]]
function rec_parse_personalcenter_ResMdifyPwdProtect(sobj)

	if sobj then
		local msg = {}
		return msg
	end
	return nil
end


--[[
	请求进入个人中心结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:密码不正确
	}
]]
function rec_parse_personalcenter_ResEnterPersonalCenter(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求绑定邮箱结果
	msg ={
		名称:email 类型:String 备注:邮箱
	}
]]
function rec_parse_personalcenter_ResBindEmail(sobj)

	if sobj then
		local msg = {}
		msg.email = sobj:readString()
		return msg
	end
	return nil
end


s2c_personalcenter_ResBindComputer_msg = 106201 --[[请求绑定电脑结果]]
s2c_personalcenter_ResUnbindComputer_msg = 106202 --[[请求解除绑定电脑结果]]
s2c_personalcenter_ResModifyBaseInfo_msg = 106203 --[[请求修改基本资料结果]]
s2c_personalcenter_ResRealNameAuthenticate_msg = 106204 --[[请求实名认证结果]]
s2c_personalcenter_ResModifyLoginPwd_msg = 106205 --[[请求实名认证结果]]
s2c_personalcenter_ResModifyBankPwd_msg = 106206 --[[请求实名认证结果]]
s2c_personalcenter_ResBindPhone_msg = 106207 --[[请求绑定手机]]
s2c_personalcenter_ResUnBindPhone_msg = 106208 --[[请求解除绑定手机返回]]
s2c_personalcenter_ResGetBindPhoneKey_msg = 106209 --[[请求获取绑定手机验证码]]
s2c_personalcenter_ResGetUnBindPhoneKey_msg = 106210 --[[请求获取解除绑定手机验证码]]
s2c_personalcenter_ResModifyGameSetting_msg = 106211 --[[请求修改游戏设置结果]]
s2c_personalcenter_ResMdifyPwdProtect_msg = 106212 --[[请求修改密保成功结果]]
s2c_personalcenter_ResEnterPersonalCenter_msg = 106213 --[[请求进入个人中心结果]]
s2c_personalcenter_ResBindEmail_msg = 106214 --[[请求绑定邮箱结果]]

ReceiveMsg.regParseRecMsg(106201, rec_parse_personalcenter_ResBindComputer)--[[请求绑定电脑结果]]
ReceiveMsg.regParseRecMsg(106202, rec_parse_personalcenter_ResUnbindComputer)--[[请求解除绑定电脑结果]]
ReceiveMsg.regParseRecMsg(106203, rec_parse_personalcenter_ResModifyBaseInfo)--[[请求修改基本资料结果]]
ReceiveMsg.regParseRecMsg(106204, rec_parse_personalcenter_ResRealNameAuthenticate)--[[请求实名认证结果]]
ReceiveMsg.regParseRecMsg(106205, rec_parse_personalcenter_ResModifyLoginPwd)--[[请求实名认证结果]]
ReceiveMsg.regParseRecMsg(106206, rec_parse_personalcenter_ResModifyBankPwd)--[[请求实名认证结果]]
ReceiveMsg.regParseRecMsg(106207, rec_parse_personalcenter_ResBindPhone)--[[请求绑定手机]]
ReceiveMsg.regParseRecMsg(106208, rec_parse_personalcenter_ResUnBindPhone)--[[请求解除绑定手机返回]]
ReceiveMsg.regParseRecMsg(106209, rec_parse_personalcenter_ResGetBindPhoneKey)--[[请求获取绑定手机验证码]]
ReceiveMsg.regParseRecMsg(106210, rec_parse_personalcenter_ResGetUnBindPhoneKey)--[[请求获取解除绑定手机验证码]]
ReceiveMsg.regParseRecMsg(106211, rec_parse_personalcenter_ResModifyGameSetting)--[[请求修改游戏设置结果]]
ReceiveMsg.regParseRecMsg(106212, rec_parse_personalcenter_ResMdifyPwdProtect)--[[请求修改密保成功结果]]
ReceiveMsg.regParseRecMsg(106213, rec_parse_personalcenter_ResEnterPersonalCenter)--[[请求进入个人中心结果]]
ReceiveMsg.regParseRecMsg(106214, rec_parse_personalcenter_ResBindEmail)--[[请求绑定邮箱结果]]
