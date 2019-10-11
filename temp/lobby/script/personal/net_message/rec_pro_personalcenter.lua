#remark
--[[
	请求绑定电脑结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:银行密码不正确
		名称:machineCode 类型:String 备注:机器码
	}
]]
local function rec_pro_personalcenter_ResBindComputer(msg)

end

--[[
	请求解除绑定电脑结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:银行密码不正确
	}
]]
local function rec_pro_personalcenter_ResUnbindComputer(msg)

end

--[[
	请求修改基本资料结果消息
	msg = {
		名称:baseInfo 类型:PlayerBaseInfo 备注:玩家基本信息
	}
]]
local function rec_pro_personalcenter_ResModifyBaseInfo(msg)
	personal_manager:resModifyBaseInfo(msg)
end

--[[
	请求实名认证结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:重复校验,2:姓名格式不对(2-10个汉字),3:身份证格式不对
		名称:name 类型:String 备注:姓名
		名称:idNo 类型:String 备注:身份证号
	}
]]
local function rec_pro_personalcenter_ResRealNameAuthenticate(msg)
	personal_manager:resRealNameAuthenticate(msg)
end

--[[
	请求修改登录密码结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:旧密码输入不正确, 2:新密码格式不对
	}
]]
local function rec_pro_personalcenter_ResModifyLoginPwd(msg)

	
end

--[[
	请求修改银行密码结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:旧密码输入不正确, 2:新密码格式不对
	}
]]
local function rec_pro_personalcenter_ResModifyBankPwd(msg)
	personal_manager:resModifyBankPwd(msg)
end

--[[
	请求绑定手机消息
	msg = {
		名称:phone 类型:String 备注:手机
	}
]]
local function rec_pro_personalcenter_ResBindPhone(msg)
	personal_manager:resBindPhone(msg)
end

--[[
	请求解除绑定手机返回消息
	msg = {
	}
]]
local function rec_pro_personalcenter_ResUnBindPhone(msg)
	personal_manager:resUnBindPhone(msg)
end

--[[
	请求获取绑定手机验证码消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:手机号码格式错误,2:获取验证码时间间隔不足
		名称:second 类型:int 备注:当res为2时，剩余秒
	}
]]
local function rec_pro_personalcenter_ResGetBindPhoneKey(msg)
	personal_manager:resGetBindPhoneKey(msg)	
end

--[[
	请求获取解除绑定手机验证码消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:获取验证码时间间隔不足
		名称:second 类型:int 备注:当res为2时，剩余秒
	}
]]
local function rec_pro_personalcenter_ResGetUnBindPhoneKey(msg)
	--add your logic code here
	personal_manager:resGetUnBindPhoneKey(msg)
end

--[[
	请求修改游戏设置结果消息
	msg = {
		名称:loginPhoneVerify 类型:int 备注:登录手机验证(0:不需要,非0:需要)
		名称:playItemEffect 类型:int 备注:播放道具特效(0:不需要,非0:需要)
	}
]]
local function rec_pro_personalcenter_ResModifyGameSetting(msg)

end

--[[
	请求修改密保成功结果消息
	msg = {
	}
]]
local function rec_pro_personalcenter_ResMdifyPwdProtect(msg)

end

--[[
	请求进入个人中心结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:密码不正确
	}
]]
local function rec_pro_personalcenter_ResEnterPersonalCenter(msg)

end
--[[
	请求绑定邮箱结果消息
	msg = {
		名称:email 类型:String 备注:邮箱
	}
]]
local function rec_pro_personalcenter_ResBindEmail(msg)

end


ReceiveMsg.regProRecMsg(106201, rec_pro_personalcenter_ResBindComputer)--请求绑定电脑结果 处理
ReceiveMsg.regProRecMsg(106202, rec_pro_personalcenter_ResUnbindComputer)--请求解除绑定电脑结果 处理
ReceiveMsg.regProRecMsg(106203, rec_pro_personalcenter_ResModifyBaseInfo)--请求修改基本资料结果 处理
ReceiveMsg.regProRecMsg(106204, rec_pro_personalcenter_ResRealNameAuthenticate)--请求实名认证结果 处理
ReceiveMsg.regProRecMsg(106205, rec_pro_personalcenter_ResModifyLoginPwd)--请求实名认证结果 处理
ReceiveMsg.regProRecMsg(106206, rec_pro_personalcenter_ResModifyBankPwd)--请求实名认证结果 处理
ReceiveMsg.regProRecMsg(106207, rec_pro_personalcenter_ResBindPhone)--请求绑定手机 处理
ReceiveMsg.regProRecMsg(106208, rec_pro_personalcenter_ResUnBindPhone)--请求解除绑定手机返回 处理
ReceiveMsg.regProRecMsg(106209, rec_pro_personalcenter_ResGetBindPhoneKey)--请求获取绑定手机验证码 处理
ReceiveMsg.regProRecMsg(106210, rec_pro_personalcenter_ResGetUnBindPhoneKey)--请求获取解除绑定手机验证码 处理
ReceiveMsg.regProRecMsg(106211, rec_pro_personalcenter_ResModifyGameSetting)--请求修改游戏设置结果 处理
ReceiveMsg.regProRecMsg(106212, rec_pro_personalcenter_ResMdifyPwdProtect)--请求修改密保成功结果 处理
ReceiveMsg.regProRecMsg(106213, rec_pro_personalcenter_ResEnterPersonalCenter)--请求进入个人中心结果 处理
ReceiveMsg.regProRecMsg(106214, rec_pro_personalcenter_ResBindEmail)--请求绑定邮箱结果 处理

--传输对象说明
--[[
	PlayerBaseInfo = {
		icon, --头像id
		sex, --性别
		age, --年龄
		birthMonth, --生日月
		birthDay, --生日天
		province, --省
		city, --市
		addr, --地址
		signature, --签名
	}
]]
