#remark
--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码
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
function read_com_wly_game_login_dto_PlayerInfo(sobj)
	local obj = {};
	obj.id = sobj:readLong()
	obj.name = sobj:readString()
	obj.sex = sobj:readString()
	obj.fullName = sobj:readString()
	obj.idCardNo = sobj:readString()
	obj.icon = sobj:readInt()
	obj.level = sobj:readInt()
	obj.vipLevel = sobj:readInt()
	obj.vipDuration = sobj:readInt()
	obj.gold = sobj:readLong()
	obj.safeGold = sobj:readLong()
	obj.ingot = sobj:readLong()
	obj.cedit = sobj:readLong()
	obj.lottery = sobj:readLong()
	obj.phone = sobj:readString()
	obj.email = sobj:readString()
	obj.age = sobj:readInt()
	obj.birthMonth = sobj:readInt()
	obj.birthDay = sobj:readInt()
	obj.province = sobj:readString()
	obj.city = sobj:readString()
	obj.addr = sobj:readString()
	obj.signature = sobj:readString()
	obj.bindingMac = sobj:readString()
	obj.havePwdProtect = sobj:readInt()
	obj.loginPhoneVerify = sobj:readInt()
	obj.playItemEffect = sobj:readInt()
	obj.tourist = sobj:readInt()
	obj.password = sobj:readString()
	obj.bankCardnumber = sobj:readString()

	return obj		
end



--[[
	玩家信息
	msg ={
		名称:playerInfo 类型:PlayerInfo 备注:玩家信息
	}
]]
function rec_parse_login_ResPlayerInfo(sobj)

	print(sobj)

	if sobj then
		local msg = {}
		msg.playerInfo = read_com_wly_game_login_dto_PlayerInfo(sobj)
		return msg
	end
	return nil
end


--[[
	玩家退出消息
	msg ={
		名称:type 类型:int 备注:0:正常退出,1:同一个账号重复登录被T号退出,2:玩家被冻结退出,3:玩家被清除游戏退出,4:游戏服务器维护被T下线
	}
]]
function rec_parse_login_ResLogout(sobj)

	if sobj then
		local msg = {}
		msg.type = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	刷新登录图片验证码结果
	msg ={
		名称:picKey 类型:String 备注:图片验证码
	}
]]
function rec_parse_login_ResRefreshLoginPicKey(sobj)

	if sobj then
		local msg = {}
		msg.picKey = sobj:readString()
		return msg
	end
	return nil
end


--[[
	刷新手机登录图片验证码结果
	msg ={
		名称:picKey 类型:String 备注:图片验证码
	}
]]
function rec_parse_login_ResRefreshPhoneLoginPicKey(sobj)

	if sobj then
		local msg = {}
		msg.picKey = sobj:readString()
		return msg
	end
	return nil
end


--[[
	刷新注册图片验证码结果
	msg ={
		名称:picKey 类型:String 备注:图片验证码
	}
]]
function rec_parse_login_ResRefreshRegisterPicKey(sobj)

	if sobj then
		local msg = {}
		msg.picKey = sobj:readString()
		return msg
	end
	return nil
end


--[[
	登陆结果
	msg ={
		名称:res 类型:int 备注:0:成功 ;1:该用户绑定手机需要输入手机验证码登录 ;
	}
]]
function rec_parse_login_ResLogin(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	校验用户名结果
	msg ={
		名称:res 类型:int 备注:0:成功即该用户名可以注册,1:用户名已经存在,2:格式错误
	}
]]
function rec_parse_login_ResCheckUserName(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	校验用户昵称结果
	msg ={
		名称:res 类型:int 备注:0:成功即该用户名可以注册,1:昵称已经存在,2:格式错误
	}
]]
function rec_parse_login_ResCheckPlayerName(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	注册用户结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:密码格式错误,2:注册图片验证码错误
	}
]]
function rec_parse_login_ResRegister(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	游戏开始消息
	msg ={
	}
]]
function rec_parse_login_ResGameStart(sobj)

	if sobj then
		local msg = {}
		return msg
	end
	return nil
end


--[[
	心跳返回消息
	msg ={
	}
]]
function rec_parse_login_ResHeartbeat(sobj)

	if sobj then
		local msg = {}
		return msg
	end
	return nil
end


--[[
	请求获取普通登录手机验证码失败
	msg ={
		名称:second 类型:int 备注:剩余秒
	}
]]
function rec_parse_login_ResGetLoginPhoneKeyFail(sobj)

	if sobj then
		local msg = {}
		msg.second = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求获取手机登录验证码失败
	msg ={
		名称:second 类型:int 备注:剩余秒
	}
]]
function rec_parse_login_ResGetPhoneLoginKeyFail(sobj)

	if sobj then
		local msg = {}
		msg.second = sobj:readInt()
		return msg
	end
	return nil
end
--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码

--[[
	请求获取手机登录验证码失败
	msg ={
		名称:password 类型:string 备注:手机登陆密码
	}
]]
function rec_parse_login_ResPhonePassword(sobj)
	
	if sobj then
		local msg = {}
		msg.password = sobj:readString()
		msg.verificationCode = sobj:readString()
		msg.result = sobj:readInt()
		return msg
	end
	return nil
end

s2c_login_ResPhonePassword_msg = 100119 --[[手机密码]]
s2c_login_ResPlayerInfo_msg = 100201 --[[玩家信息]]
s2c_login_ResLogout_msg = 100202 --[[玩家退出消息]]
s2c_login_ResRefreshLoginPicKey_msg = 100203 --[[刷新登录图片验证码结果]]
s2c_login_ResRefreshPhoneLoginPicKey_msg = 100204 --[[刷新手机登录图片验证码结果]]
s2c_login_ResRefreshRegisterPicKey_msg = 100205 --[[刷新注册图片验证码结果]]
s2c_login_ResLogin_msg = 100206 --[[登陆结果]]
s2c_login_ResCheckUserName_msg = 100207 --[[校验用户名结果]]
s2c_login_ResCheckPlayerName_msg = 100208 --[[校验用户昵称结果]]
s2c_login_ResRegister_msg = 100209 --[[注册用户结果]]
s2c_login_ResGameStart_msg = 100210 --[[游戏开始消息]]
s2c_login_ResHeartbeat_msg = 100211 --[[心跳返回消息]]
s2c_login_ResGetLoginPhoneKeyFail_msg = 100212 --[[请求获取普通登录手机验证码失败]]
s2c_login_ResGetPhoneLoginKeyFail_msg = 100213 --[[请求获取手机登录验证码失败]]

ReceiveMsg.regParseRecMsg(100119, rec_parse_login_ResPhonePassword)--[[手机密码]]
ReceiveMsg.regParseRecMsg(100201, rec_parse_login_ResPlayerInfo)--[[玩家信息]]
ReceiveMsg.regParseRecMsg(100202, rec_parse_login_ResLogout)--[[玩家退出消息]]
ReceiveMsg.regParseRecMsg(100203, rec_parse_login_ResRefreshLoginPicKey)--[[刷新登录图片验证码结果]]
ReceiveMsg.regParseRecMsg(100204, rec_parse_login_ResRefreshPhoneLoginPicKey)--[[刷新手机登录图片验证码结果]]
ReceiveMsg.regParseRecMsg(100205, rec_parse_login_ResRefreshRegisterPicKey)--[[刷新注册图片验证码结果]]
ReceiveMsg.regParseRecMsg(100206, rec_parse_login_ResLogin)--[[登陆结果]]
ReceiveMsg.regParseRecMsg(100207, rec_parse_login_ResCheckUserName)--[[校验用户名结果]]
ReceiveMsg.regParseRecMsg(100208, rec_parse_login_ResCheckPlayerName)--[[校验用户昵称结果]]
ReceiveMsg.regParseRecMsg(100209, rec_parse_login_ResRegister)--[[注册用户结果]]
ReceiveMsg.regParseRecMsg(100210, rec_parse_login_ResGameStart)--[[游戏开始消息]]
ReceiveMsg.regParseRecMsg(100211, rec_parse_login_ResHeartbeat)--[[心跳返回消息]]
ReceiveMsg.regParseRecMsg(100212, rec_parse_login_ResGetLoginPhoneKeyFail)--[[请求获取普通登录手机验证码失败]]
ReceiveMsg.regParseRecMsg(100213, rec_parse_login_ResGetPhoneLoginKeyFail)--[[请求获取手机登录验证码失败]]
