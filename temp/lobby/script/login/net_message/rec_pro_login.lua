#remark
--[[
	玩家信息消息
	msg = {
		名称:playerInfo 类型:PlayerInfo 备注:玩家信息
	}
]]
local function rec_pro_login_ResPlayerInfo(msg)
	--add your logic code here
    login_manager:loginSuccessMsg(msg)
end

--[[
	玩家退出消息消息
	msg = {
		名称:type 类型:int 备注:0:正常退出,1:同一个账号重复登录被T号退出,2:玩家被冻结退出,3:玩家被清除游戏退出,4:游戏服务器维护被T下线
	}
]]
local function rec_pro_login_ResLogout(msg)
	--add your logic code here
	-- local obj = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	-- if obj then obj:loginOutPro(msg) end
	player_manager:LoginOutPro(msg)
end

--[[
	刷新登录图片验证码结果消息
	msg = {
		名称:picKey 类型:String 备注:图片验证码
	}
]]
local function rec_pro_login_ResRefreshLoginPicKey(msg)
	--add your logic code here
	local obj = WindowScene.getInstance():getModuleObjByClassName("CLoginScene")
	if obj then obj:onReqLoginKey(msg) end
end

--[[
	刷新手机登录图片验证码结果消息
	msg = {
		名称:picKey 类型:String 备注:图片验证码
	}
]]
local function rec_pro_login_ResRefreshPhoneLoginPicKey(msg)
	--add your logic code here
	local obj = WindowScene.getInstance():getModuleObjByClassName("CLoginScene")
	if obj then obj:onReqLoinPhoneKey(msg) end
end

--[[
	刷新注册图片验证码结果消息
	msg = {
		名称:picKey 类型:String 备注:图片验证码
	}
]]
local function rec_pro_login_ResRefreshRegisterPicKey(msg)
	--add your logic code here
	local obj = WindowScene.getInstance():getModuleObjByClassName("CLoginScene")
	if obj then obj:onReqRegisterKey(msg) end
end

--[[
	登陆结果消息
	msg = {
		名称:res 类型:int 备注:0:成功 ;1:该用户绑定手机需要输入手机验证码登录 ;2:
	}
]]
local function rec_pro_login_ResLogin(msg)
	--add your logic code here
	local obj = WindowScene.getInstance():getModuleObjByClassName("CLoginScene")
	if obj then obj:loginResultPro(msg) end
end

--[[
	校验用户名结果消息
	msg = {
		名称:res 类型:int 备注:0:成功即该用户名可以注册,1:用户名已经存在,2:格式错误
	}
]]
local function rec_pro_login_ResCheckUserName(msg)
	--add your logic code here
	local obj = WindowScene.getInstance():getModuleObjByClassName("CLoginScene")
	if obj then obj:onRecCheckAccount(msg) end
end

--[[
	校验用户昵称结果消息
	msg = {
		名称:res 类型:int 备注:0:成功即该用户名可以注册,1:昵称已经存在,2:格式错误
	}
]]
local function rec_pro_login_ResCheckPlayerName(msg)
	--add your logic code here
	local obj = WindowScene.getInstance():getModuleObjByClassName("CLoginScene")
	if obj then obj:onRecCheckUsername(msg) end
end

--[[
	注册用户结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:密码格式错误,2:注册图片验证码错误
	}
]]
local function rec_pro_login_ResRegister(msg)
	--add your logic code here
	local obj = WindowScene.getInstance():getModuleObjByClassName("CLoginScene")
	if obj then obj:regResultPro(msg) end
end

--[[
	游戏开始消息消息
	msg = {
	}
]]
local function rec_pro_login_ResGameStart(msg)
	--add your logic code here
	login_manager:enterGame()
end

--[[
	心跳返回消息消息
	msg = {
	}
]]
local function rec_pro_login_ResHeartbeat(msg)
	--add your logic code here
	HeartPro.pro_heart_msg(msg)
end
--[[
	请求获取普通登录手机验证码失败消息
	msg = {
		名称:second 类型:int 备注:剩余秒
	}
]]
local function rec_pro_login_ResGetLoginPhoneKeyFail(msg)
	--add your logic code here
	login_manager:resGetLoginPhoneKeyFail(msg)
end

--[[
	请求获取手机登录验证码失败消息
	msg = {
		名称:second 类型:int 备注:剩余秒
	}
]]
local function rec_pro_login_ResGetPhoneLoginKeyFail(msg)
	--add your logic code here
	login_manager:resGetPhoneLoginKeyFail(msg)
end

--[[
	手机密码
	msg = {
		名称:password 类型:string 备注:密码
		名称:verificationCode 类型:string 备注:验证码
		名称:result 类型:int 备注:短信结果
	}
]]
local function rec_pro_login_ResGetPhonePassword(msg)
	--add your logic code here
	local obj = WindowScene.getInstance():getModuleObjByClassName("CLoginScene")
	if obj then obj:onRecPhoneLoginPassword(msg) end
end

ReceiveMsg.regProRecMsg(100119, rec_pro_login_ResGetPhonePassword)--请求获取手机登录验证码失败 处理
ReceiveMsg.regProRecMsg(100201, rec_pro_login_ResPlayerInfo)--玩家信息 处理
ReceiveMsg.regProRecMsg(100202, rec_pro_login_ResLogout)--玩家退出消息 处理
ReceiveMsg.regProRecMsg(100203, rec_pro_login_ResRefreshLoginPicKey)--刷新登录图片验证码结果 处理
ReceiveMsg.regProRecMsg(100204, rec_pro_login_ResRefreshPhoneLoginPicKey)--刷新手机登录图片验证码结果 处理
ReceiveMsg.regProRecMsg(100205, rec_pro_login_ResRefreshRegisterPicKey)--刷新注册图片验证码结果 处理
ReceiveMsg.regProRecMsg(100206, rec_pro_login_ResLogin)--登陆结果 处理
ReceiveMsg.regProRecMsg(100207, rec_pro_login_ResCheckUserName)--校验用户名结果 处理
ReceiveMsg.regProRecMsg(100208, rec_pro_login_ResCheckPlayerName)--校验用户昵称结果 处理
ReceiveMsg.regProRecMsg(100209, rec_pro_login_ResRegister)--注册用户结果 处理
ReceiveMsg.regProRecMsg(100210, rec_pro_login_ResGameStart)--游戏开始消息 处理
ReceiveMsg.regProRecMsg(100211, rec_pro_login_ResHeartbeat)--心跳返回消息 处理
ReceiveMsg.regProRecMsg(100212, rec_pro_login_ResGetLoginPhoneKeyFail)--请求获取普通登录手机验证码失败 处理
ReceiveMsg.regProRecMsg(100213, rec_pro_login_ResGetPhoneLoginKeyFail)--请求获取手机登录验证码失败 处理

--传输对象说明
--[[
	PlayerInfo = {
		id, --玩家id
		name, --玩家昵称
		sex, --玩家性别
		fullName, --玩家姓名
		idCardNo, --玩家身份证号
		icon, --头像
		level, --玩家等级
		vipLevel, --vip等级
		vipDuration, --vip时长(秒)
		gold, --金币
		safeGold, --保险箱金币
		ingot, --元宝
		cedit, --积分
		lottery, --奖券
		phone, --电话
		email, --邮箱
		age, --年龄
		birthMonth, --出生月
		birthDay, --出生日
		province, --省
		city, --市
		addr, --地址
		signature, --签名
		bindingMac, --绑定机器码
		havePwdProtect, --是否有密保(0:没有,非0:有)
		loginPhoneVerify, --登录是否需要手机验证(0:不需要，非0:需要)
		playItemEffect, --是否需要播放道具使用特效(0:不需要，非0:需要)
		tourist, --0:不是游客,1:游客
	}
]]
