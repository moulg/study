#remark
--[[
	PlayerInfo ={
		名称:id 类型:long 备注:玩家id
		名称:name 类型:String 备注:玩家昵称
		名称:sex 类型:String 备注:玩家性别
		名称:fullName 类型:String 备注:玩家姓名
		名称:idCardNo 类型:String 备注:玩家身份证号
		名称:icon 类型:int 备注:头像
		名称:level 类型:int 备注:玩家等级
		名称:vipLevel 类型:int 备注:vip等级
		名称:vipDuration 类型:int 备注:vip时长(秒)
		名称:gold 类型:long 备注:金币
		名称:safeGold 类型:long 备注:保险箱金币
		名称:ingot 类型:long 备注:元宝
		名称:cedit 类型:long 备注:积分
		名称:lottery 类型:long 备注:奖券
		名称:phone 类型:String 备注:电话
		名称:email 类型:String 备注:邮箱
		名称:age 类型:int 备注:年龄
		名称:birthMonth 类型:int 备注:出生月
		名称:birthDay 类型:int 备注:出生日
		名称:province 类型:String 备注:省
		名称:city 类型:String 备注:市
		名称:addr 类型:String 备注:地址
		名称:signature 类型:String 备注:签名
		名称:bindingMac 类型:String 备注:绑定机器码
		名称:havePwdProtect 类型:int 备注:是否有密保(0:没有,非0:有)
		名称:loginPhoneVerify 类型:int 备注:登录是否需要手机验证(0:不需要，非0:需要)
		名称:playItemEffect 类型:int 备注:是否需要播放道具使用特效(0:不需要，非0:需要)
		名称:tourist 类型:int 备注:0:不是游客,1:游客
	}
]]
local function write_PlayerInfo(stream,bean)
	if bean.id == nil then bean.id = 0 end
	stream:writeLong(bean.id)
	if bean.name == nil then bean.name = "" end
	stream:writeString(bean.name)
	if bean.sex == nil then bean.sex = "" end
	stream:writeString(bean.sex)
	if bean.fullName == nil then bean.fullName = "" end
	stream:writeString(bean.fullName)
	if bean.idCardNo == nil then bean.idCardNo = "" end
	stream:writeString(bean.idCardNo)
	if bean.icon == nil then bean.icon = 0 end
	stream:writeInt(bean.icon)
	if bean.level == nil then bean.level = 0 end
	stream:writeInt(bean.level)
	if bean.vipLevel == nil then bean.vipLevel = 0 end
	stream:writeInt(bean.vipLevel)
	if bean.vipDuration == nil then bean.vipDuration = 0 end
	stream:writeInt(bean.vipDuration)
	if bean.gold == nil then bean.gold = 0 end
	stream:writeLong(bean.gold)
	if bean.safeGold == nil then bean.safeGold = 0 end
	stream:writeLong(bean.safeGold)
	if bean.ingot == nil then bean.ingot = 0 end
	stream:writeLong(bean.ingot)
	if bean.cedit == nil then bean.cedit = 0 end
	stream:writeLong(bean.cedit)
	if bean.lottery == nil then bean.lottery = 0 end
	stream:writeLong(bean.lottery)
	if bean.phone == nil then bean.phone = "" end
	stream:writeString(bean.phone)
	if bean.email == nil then bean.email = "" end
	stream:writeString(bean.email)
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
	if bean.bindingMac == nil then bean.bindingMac = "" end
	stream:writeString(bean.bindingMac)
	if bean.havePwdProtect == nil then bean.havePwdProtect = 0 end
	stream:writeInt(bean.havePwdProtect)
	if bean.loginPhoneVerify == nil then bean.loginPhoneVerify = 0 end
	stream:writeInt(bean.loginPhoneVerify)
	if bean.playItemEffect == nil then bean.playItemEffect = 0 end
	stream:writeInt(bean.playItemEffect)
	if bean.tourist == nil then bean.tourist = 0 end
	stream:writeInt(bean.tourist)
end



--[[
	登陆
	ReqLogin ={
		名称:name 类型:String 备注:玩家用户名
		名称:password 类型:String 备注:玩家密码
		名称:key 类型:String 备注:登录检验码
		名称:version 类型:int 备注:游戏版本号
		名称:mac 类型:String 备注:机器码
	}
]]
function send_login_ReqLogin(msg)
	local stream = CNetStream()
	stream:writeInt(100101)
	
	if msg.name == nil then msg.name = "" end
	stream:writeString(msg.name)
	if msg.password == nil then msg.password = "" end
	stream:writeString(msg.password)
	if msg.key == nil then msg.key = "" end
	stream:writeString(msg.key)
	if msg.version == nil then msg.version = 0 end
	stream:writeInt(msg.version)
	if msg.mac == nil then msg.mac = "" end
	stream:writeString(msg.mac)
	GetSocketInstance():send(stream)
end


--[[
	注册用户
	ReqRegister ={
		名称:userName 类型:String 备注:玩家用户名
		名称:playerName 类型:String 备注:昵称
		名称:icon 类型:int 备注:头像id
		名称:sex 类型:byte 备注:0:女,非0:男
		名称:password 类型:String 备注:玩家密码
		名称:recommender 类型:long 备注:推荐人
		名称:name 类型:String 备注:姓名
		名称:idCard 类型:String 备注:身份证
		名称:key 类型:String 备注:验证码
		名称:mac 类型:String 备注:机器码
	}
]]
function send_login_ReqRegister(msg)
	local stream = CNetStream()
	stream:writeInt(100102)
	
	if msg.userName == nil then msg.userName = "" end
	stream:writeString(msg.userName)
	if msg.playerName == nil then msg.playerName = "" end
	stream:writeString(msg.playerName)
	if msg.icon == nil then msg.icon = 0 end
	stream:writeInt(msg.icon)
	if msg.sex == nil then msg.sex = 0 end
	stream:writeByte(msg.sex)
	if msg.password == nil then msg.password = "" end
	stream:writeString(msg.password)
	if msg.recommender == nil then msg.recommender = 0 end
	stream:writeLong(msg.recommender)
	if msg.name == nil then msg.name = "" end
	stream:writeString(msg.name)
	if msg.idCard == nil then msg.idCard = "" end
	stream:writeString(msg.idCard)
	if msg.key == nil then msg.key = "" end
	stream:writeString(msg.key)
	if msg.mac == nil then msg.mac = "" end
	stream:writeString(msg.mac)
	GetSocketInstance():send(stream)
end


--[[
	校验用户名
	ReqCheckUserName ={
		名称:userName 类型:String 备注:玩家用户名
	}
]]
function send_login_ReqCheckUserName(msg)
	local stream = CNetStream()
	stream:writeInt(100103)
	
	if msg.userName == nil then msg.userName = "" end
	stream:writeString(msg.userName)
	GetSocketInstance():send(stream)
end


--[[
	校验玩家昵称
	ReqCheckPlayerName ={
		名称:playerName 类型:String 备注:玩家昵称
	}
]]
function send_login_ReqCheckPlayerName(msg)
	local stream = CNetStream()
	stream:writeInt(100104)
	
	if msg.playerName == nil then msg.playerName = "" end
	stream:writeString(msg.playerName)
	GetSocketInstance():send(stream)
end


--[[
	玩家退出登录
	ReqLogout ={
	}
]]
function send_login_ReqLogout(msg)
	local stream = CNetStream()
	stream:writeInt(100105)
	
	GetSocketInstance():send(stream)
end


--[[
	请求刷新登录图片验证码
	ReqRefreshLoginPicKey ={
	}
]]
function send_login_ReqRefreshLoginPicKey(msg)
	local stream = CNetStream()
	stream:writeInt(100106)
	
	GetSocketInstance():send(stream)
end


--[[
	请求刷新注册图片验证码
	ReqRefreshPhoneLoginPicKey ={
	}
]]
function send_login_ReqRefreshPhoneLoginPicKey(msg)
	local stream = CNetStream()
	stream:writeInt(100107)
	
	GetSocketInstance():send(stream)
end


--[[
	请求刷新注册图片验证码
	ReqRefreshRegisterPicKey ={
	}
]]
function send_login_ReqRefreshRegisterPicKey(msg)
	local stream = CNetStream()
	stream:writeInt(100108)
	
	GetSocketInstance():send(stream)
end


--[[
	请求获取普通登录手机验证码(绑定手机的用户才可以)
	ReqGetLoginPhoneKey ={
	}
]]
function send_login_ReqGetLoginPhoneKey(msg)
	local stream = CNetStream()
	stream:writeInt(100109)
	
	GetSocketInstance():send(stream)
end


--[[
	请求获取手机登录验证码(绑定手机的用户才可以)
	ReqGetPhoneLoginKey ={
		名称:userName 类型:String 备注:玩家用户名
	}
]]
function send_login_ReqGetPhoneLoginKey(msg)
	local stream = CNetStream()
	stream:writeInt(100110)
	
	if msg.userName == nil then msg.userName = "" end
	stream:writeString(msg.userName)
	GetSocketInstance():send(stream)
end


--[[
	使用手机验证码登陆
	ReqLoginByPhoneKey ={
		名称:phoneNumber 类型:String 备注:手机号
		名称:flag 类型:String 备注:操作类型 0密码 1验证码
		名称:key 类型:String 备注:验证内容
		名称:mac 类型:String 备注:机器码
	}
]]
function send_login_ReqLoginByPhoneKey(msg)
	local stream = CNetStream()
	stream:writeInt(100111)
	
	if msg.phoneNumber == nil then msg.phoneNumber = "" end
	stream:writeString(msg.phoneNumber)

	if msg.flag == nil then msg.flag = "0" end
	stream:writeString(msg.flag)

	if msg.key == nil then msg.key = "" end
	stream:writeString(msg.key)

	if msg.mac == nil then msg.mac = "" end
	stream:writeString(msg.mac)
	
	GetSocketInstance():send(stream)
end

--[[
	使用手机登录获取验证码
	ReqPhoneLogin ={
		名称:phoneNumber 类型:String 备注:手机
		名称:flag 类型:String 备注:是否获取验证码
		名称:mac 类型:String 备注:机器码
	}
]]
function send_login_ReqPhoneLogin(msg)
	local stream = CNetStream()
	stream:writeInt(100112)
	
	if msg.phoneNumber == nil then msg.phoneNumber = "" end
	stream:writeString(msg.phoneNumber)
	if msg.flag == nil then msg.flag = "" end
	stream:writeString(msg.flag)
	if msg.mac == nil then msg.mac = "" end
	stream:writeString(msg.mac)
	GetSocketInstance():send(stream)
end


--[[
	机器人请求登录
	ReqRobotLogin ={
		名称:name 类型:String 备注:玩家用户名
		名称:password 类型:String 备注:玩家密码
		名称:gold 类型:int 备注:初始金币
	}
]]
function send_login_ReqRobotLogin(msg)
	local stream = CNetStream()
	stream:writeInt(100113)
	
	if msg.name == nil then msg.name = "" end
	stream:writeString(msg.name)
	if msg.password == nil then msg.password = "" end
	stream:writeString(msg.password)
	if msg.gold == nil then msg.gold = 0 end
	stream:writeInt(msg.gold)
	GetSocketInstance():send(stream)
end


--[[
	断线重新登录
	ReqReLogin ={
		名称:name 类型:String 备注:玩家用户名
		名称:password 类型:String 备注:玩家密码
		名称:mac 类型:String 备注:机器码
	}
]]
function send_login_ReqReLogin(msg)
	local stream = CNetStream()
	stream:writeInt(100114)
	
	if msg.name == nil then msg.name = "" end
	stream:writeString(msg.name)
	if msg.password == nil then msg.password = "" end
	stream:writeString(msg.password)
	if msg.mac == nil then msg.mac = "" end
	stream:writeString(msg.mac)
	GetSocketInstance():send(stream)
end


--[[
	心跳消息
	ReqHeartbeat ={
	}
]]
function send_login_ReqHeartbeat(msg)
	local stream = CNetStream()
	stream:writeInt(100115)
	
	GetSocketInstance():send(stream)
end


--[[
	游客登录
	ReqTouristLogin ={
		名称:mac 类型:String 备注:机器码
	}
]]
function send_login_ReqTouristLogin(msg)
	local stream = CNetStream()
	stream:writeInt(100116)
	print("mac:", msg.mac)
	if msg.mac == nil then msg.mac = "" end
	stream:writeString(msg.mac)
	if msg.account == nil then msg.account = "" end
	stream:writeString(msg.account)
	GetSocketInstance():send(stream)
end


--[[
	手机登陆
	ReqLoginFromPhone ={
		名称:name 类型:String 备注:玩家用户名
		名称:password 类型:String 备注:玩家密码
		名称:mac 类型:String 备注:机器码
	}
]]
function send_login_ReqLoginFromPhone(msg)
	local stream = CNetStream()
	stream:writeInt(100117)
	print("mac:", msg.mac)
	if msg.name == nil then msg.name = "" end
	stream:writeString(msg.name)
	if msg.password == nil then msg.password = "" end
	stream:writeString(msg.password)
	if msg.mac == nil then msg.mac = "" end
	stream:writeString(msg.mac)
	GetSocketInstance():send(stream)
end


function send_login_ReqLoginFromWechat(msg)
    local stream = CNetStream()
	stream:writeInt(100118)
	
	print("mac:", msg.mac)

	if msg.platform == nil then msg.platform = "" end
	stream:writeString(msg.platform)
	if msg.unionid == nil then msg.unionid = "" end
	stream:writeString(msg.unionid)
	if msg.mac == nil then msg.mac = "" end
	stream:writeString(msg.mac)
	if msg.nickname == nil then msg.nickname = "" end
	stream:writeString(msg.nickname)
	GetSocketInstance():send(stream)
end


local c2s_login_ReqLogin_msg = 100101 --[[登陆]]
local c2s_login_ReqRegister_msg = 100102 --[[注册用户]]
local c2s_login_ReqCheckUserName_msg = 100103 --[[校验用户名]]
local c2s_login_ReqCheckPlayerName_msg = 100104 --[[校验玩家昵称]]
local c2s_login_ReqLogout_msg = 100105 --[[玩家退出登录]]
local c2s_login_ReqRefreshLoginPicKey_msg = 100106 --[[请求刷新登录图片验证码]]
local c2s_login_ReqRefreshPhoneLoginPicKey_msg = 100107 --[[请求刷新注册图片验证码]]
local c2s_login_ReqRefreshRegisterPicKey_msg = 100108 --[[请求刷新注册图片验证码]]
local c2s_login_ReqGetLoginPhoneKey_msg = 100109 --[[请求获取普通登录手机验证码(绑定手机的用户才可以)]]
local c2s_login_ReqGetPhoneLoginKey_msg = 100110 --[[请求获取手机登录验证码(绑定手机的用户才可以)]]
local c2s_login_ReqLoginByPhoneKey_msg = 100111 --[[普通登录,绑定手机用户需要校验手机验证码和图片验证码]]
local c2s_login_ReqPhoneLogin_msg = 100112 --[[请求使用手机登录]]
local c2s_login_ReqRobotLogin_msg = 100113 --[[机器人请求登录]]
local c2s_login_ReqReLogin_msg = 100114 --[[断线重新登录]]
local c2s_login_ReqHeartbeat_msg = 100115 --[[心跳消息]]
local c2s_login_ReqTouristLogin_msg = 100116 --[[游客登录]]
local c2s_login_ReqLoginFromPhone_msg = 100117 --[[手机登陆]]
local c2s_login_ReqLoginFromWechat_msg = 100118 --[[微信登录]]

