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
local function write_PlayerBaseInfo(stream,bean)
	if bean.icon == nil then bean.icon = 0 end
	stream:writeInt(bean.icon)
	if bean.sex == nil then bean.sex = "" end
	stream:writeString(bean.sex)
	if bean.age == nil then bean.age = 0 end
	stream:writeInt(bean.age)
	if bean.birthMonth == nil then bean.birthMonth = 0 end
	stream:writeInt(bean.birthMonth)
	if bean.birthDay == nil then bean.birthDay = 0 end
	stream:writeInt(bean.birthDay)
	if bean.province == nil then bean.province = "" end
	stream:writeString(bean.province)
	if bean.city == nil then bean.city = "" end
	stream:writeString(bean.city)
	if bean.addr == nil then bean.addr = "" end
	stream:writeString(bean.addr)
	if bean.signature == nil then bean.signature = "" end
	stream:writeString(bean.signature)
end



--[[
	请求绑定电脑
	ReqBindComputer ={
		名称:bankPwd 类型:String 备注:银行密码
		名称:machineCode 类型:String 备注:机器码
	}
]]
function send_personalcenter_ReqBindComputer(msg)
	local stream = CNetStream()
	stream:writeInt(106101)
	
	if msg.bankPwd == nil then msg.bankPwd = "" end
	stream:writeString(msg.bankPwd)
	if msg.machineCode == nil then msg.machineCode = "" end
	stream:writeString(msg.machineCode)
	GetSocketInstance():send(stream)
end


--[[
	请求解除绑定电脑
	ReqUnbindComputer ={
		名称:bankPwd 类型:String 备注:银行密码
	}
]]
function send_personalcenter_ReqUnbindComputer(msg)
	local stream = CNetStream()
	stream:writeInt(106102)
	
	if msg.bankPwd == nil then msg.bankPwd = "" end
	stream:writeString(msg.bankPwd)
	GetSocketInstance():send(stream)
end


--[[
	请求修改基本资料
	ReqModifyBaseInfo ={
		名称:baseInfo 类型:PlayerBaseInfo 备注:玩家基本信息
	}
]]
function send_personalcenter_ReqModifyBaseInfo(msg)
	local stream = CNetStream()
	stream:writeInt(106103)
	
	write_PlayerBaseInfo(stream,msg.baseInfo)
	GetSocketInstance():send(stream)
end


--[[
	请求实名认证
	ReqRealNameAuthenticate ={
		名称:name 类型:String 备注:姓名
		名称:idNo 类型:String 备注:身份证号
	}
]]
function send_personalcenter_ReqRealNameAuthenticate(msg)
	local stream = CNetStream()
	stream:writeInt(106104)
	
	if msg.name == nil then msg.name = "" end
	stream:writeString(msg.name)
	if msg.idNo == nil then msg.idNo = "" end
	stream:writeString(msg.idNo)
	GetSocketInstance():send(stream)
end


--[[
	请求修改登录密码
	ReqModifyLoginPwd ={
		名称:oldPwd 类型:String 备注:旧密码
		名称:newPwd 类型:String 备注:新密码
	}
]]
function send_personalcenter_ReqModifyLoginPwd(msg)
	local stream = CNetStream()
	stream:writeInt(106105)
	
	if msg.oldPwd == nil then msg.oldPwd = "" end
	stream:writeString(msg.oldPwd)
	if msg.newPwd == nil then msg.newPwd = "" end
	stream:writeString(msg.newPwd)
	GetSocketInstance():send(stream)
end


--[[
	请求修改银行密码
	ReqModifyBankPwd ={
		名称:oldPwd 类型:String 备注:旧密码
		名称:newPwd 类型:String 备注:新密码
	}
]]
function send_personalcenter_ReqModifyBankPwd(msg)
	local stream = CNetStream()
	stream:writeInt(106106)
	
	if msg.oldPwd == nil then msg.oldPwd = "" end
	stream:writeString(msg.oldPwd)
	if msg.newPwd == nil then msg.newPwd = "" end
	stream:writeString(msg.newPwd)
	GetSocketInstance():send(stream)
end


--[[
	请求修改密保
	ReqMdifyPwdProtect ={
		名称:firstPwdProtectQ 类型:String 备注:第一个密保问题
		名称:firstPwdProtectA 类型:String 备注:第一个密保问题答案
		名称:secondPwdProtectQ 类型:String 备注:第二个密保问题
		名称:secondPwdProtectA 类型:String 备注:第二个密保问题答案
	}
]]
function send_personalcenter_ReqMdifyPwdProtect(msg)
	local stream = CNetStream()
	stream:writeInt(106107)
	
	if msg.firstPwdProtectQ == nil then msg.firstPwdProtectQ = "" end
	stream:writeString(msg.firstPwdProtectQ)
	if msg.firstPwdProtectA == nil then msg.firstPwdProtectA = "" end
	stream:writeString(msg.firstPwdProtectA)
	if msg.secondPwdProtectQ == nil then msg.secondPwdProtectQ = "" end
	stream:writeString(msg.secondPwdProtectQ)
	if msg.secondPwdProtectA == nil then msg.secondPwdProtectA = "" end
	stream:writeString(msg.secondPwdProtectA)
	GetSocketInstance():send(stream)
end


--[[
	请求获取绑定手机验证码
	ReqGetBindPhoneKey ={
		名称:phone 类型:String 备注:手机号码
	}
]]
function send_personalcenter_ReqGetBindPhoneKey(msg)
	local stream = CNetStream()
	stream:writeInt(106108)
	
	if msg.phone == nil then msg.phone = "" end
	stream:writeString(msg.phone)
	GetSocketInstance():send(stream)
end


--[[
	请求绑定手机
	ReqBindPhone ={
		名称:key 类型:String 备注:银行密码
	}
]]
function send_personalcenter_ReqBindPhone(msg)
	local stream = CNetStream()
	stream:writeInt(106109)
	
	if msg.key == nil then msg.key = "" end
	stream:writeString(msg.key)
	GetSocketInstance():send(stream)
end


--[[
	请求获取解除绑定手机验证码
	ReqGetUnBindPhoneKey ={
	}
]]
function send_personalcenter_ReqGetUnBindPhoneKey(msg)
	local stream = CNetStream()
	stream:writeInt(106110)
	
	GetSocketInstance():send(stream)
end


--[[
	请求解除绑定手机
	ReqUnBindPhone ={
		名称:key 类型:String 备注:验证码
	}
]]
function send_personalcenter_ReqUnBindPhone(msg)
	local stream = CNetStream()
	stream:writeInt(106111)
	
	if msg.key == nil then msg.key = "" end
	stream:writeString(msg.key)
	GetSocketInstance():send(stream)
end


--[[
	请求修改游戏设置
	ReqModifyGameSetting ={
		名称:loginPhoneVerify 类型:int 备注:登录手机验证(0:不需要,非0:需要)
		名称:playItemEffect 类型:int 备注:播放道具特效(0:不需要,非0:需要)
	}
]]
function send_personalcenter_ReqModifyGameSetting(msg)
	local stream = CNetStream()
	stream:writeInt(106112)
	
	if msg.loginPhoneVerify == nil then msg.loginPhoneVerify = 0 end
	stream:writeInt(msg.loginPhoneVerify)
	if msg.playItemEffect == nil then msg.playItemEffect = 0 end
	stream:writeInt(msg.playItemEffect)
	GetSocketInstance():send(stream)
end


--[[
	请求进入个人中心
	ReqEnterPersonalCenter ={
		名称:bankPwd 类型:String 备注:银行密码
	}
]]
function send_personalcenter_ReqEnterPersonalCenter(msg)
	local stream = CNetStream()
	stream:writeInt(106113)
	
	if msg.bankPwd == nil then msg.bankPwd = "" end
	stream:writeString(msg.bankPwd)
	GetSocketInstance():send(stream)
end


--[[
	请求绑定邮箱
	ReqBindEmail ={
		名称:email 类型:String 备注:邮箱
	}
]]
function send_personalcenter_ReqBindEmail(msg)
	local stream = CNetStream()
	stream:writeInt(106114)
	
	if msg.email == nil then msg.email = "" end
	stream:writeString(msg.email)
	GetSocketInstance():send(stream)
end


c2s_personalcenter_ReqBindComputer_msg = 106101 --[[请求绑定电脑]]
c2s_personalcenter_ReqUnbindComputer_msg = 106102 --[[请求解除绑定电脑]]
c2s_personalcenter_ReqModifyBaseInfo_msg = 106103 --[[请求修改基本资料]]
c2s_personalcenter_ReqRealNameAuthenticate_msg = 106104 --[[请求实名认证]]
c2s_personalcenter_ReqModifyLoginPwd_msg = 106105 --[[请求修改登录密码]]
c2s_personalcenter_ReqModifyBankPwd_msg = 106106 --[[请求修改银行密码]]
c2s_personalcenter_ReqMdifyPwdProtect_msg = 106107 --[[请求修改密保]]
c2s_personalcenter_ReqGetBindPhoneKey_msg = 106108 --[[请求获取绑定手机验证码]]
c2s_personalcenter_ReqBindPhone_msg = 106109 --[[请求绑定手机]]
c2s_personalcenter_ReqGetUnBindPhoneKey_msg = 106110 --[[请求获取解除绑定手机验证码]]
c2s_personalcenter_ReqUnBindPhone_msg = 106111 --[[请求解除绑定手机]]
c2s_personalcenter_ReqModifyGameSetting_msg = 106112 --[[请求修改游戏设置]]
c2s_personalcenter_ReqEnterPersonalCenter_msg = 106113 --[[请求进入个人中心]]
c2s_personalcenter_ReqBindEmail_msg = 106114 --[[请求绑定邮箱]]
