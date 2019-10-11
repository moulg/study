#remark
--[[
个人中心管理类
]]

personal_manager = {}

function personal_manager:showPersonalCenter()
	WindowScene.getInstance():showDlgByName("CPersonalCenterMain")
end


--[[
名称:baseInfo 类型:PlayerBaseInfo 备注:玩家基本信息
	请求修改基本资料
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
function personal_manager:reqModifyBaseInfoMsg(sex)
	local pinfo = get_player_info()
	local msg = {baseInfo = {
		icon = pinfo.head_id, --头像id
		sex = sex, --性别
		age = pinfo.age, --年龄
		birthMonth = pinfo.birthMonth, --生日月
		birthDay = pinfo.birthDay, --生日天
		province = pinfo.province, --省
		city = pinfo.city, --市
		addr = pinfo.addr, --地址
		signature = pinfo.signature, --签名

	}}

	send_personalcenter_ReqModifyBaseInfo(msg)
end

--[[
	请求修改基本资料结果消息
	msg = {
		名称:baseInfo 类型:PlayerBaseInfo 备注:玩家基本信息
	}
]]
function personal_manager:resModifyBaseInfo(msg)
	get_player_info().sex = msg.baseInfo.sex
	local obj = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if obj then
		obj:setPlayerHeadSex()
	end
end


--[[
	请求实名认证结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:重复校验,2:姓名格式不对(2-10个汉字),3:身份证格式不对
		名称:name 类型:String 备注:姓名
		名称:idNo 类型:String 备注:身份证号
	}
]]
function personal_manager:resRealNameAuthenticate(msg)
	if msg.res == 0 then
		local panel = WindowScene.getInstance():getDlgByName("CPersonalCenterMain")
		panel:realNameRequestSuccess(idNo)
	elseif msg.res == 2 then
		TipsManager:showOneButtonTipsPanel(114, {}, true)
	elseif msg.res == 3 then
		TipsManager:showOneButtonTipsPanel(115, {}, true)
	end
end

--[[
	请求绑定手机消息
	msg = {
		名称:phone 类型:String 备注:手机
	}
]]
function personal_manager:resBindPhone(msg)
	local obj = WindowScene.getInstance():getDlgByName("CPersonalCenterMain")
	if msg.phone ~= "" then
		local pinfo = get_player_info()
		pinfo.phone = msg.phone
		if obj then obj:updatePhoneBindUI() end
		TipsManager:showOneButtonTipsPanel(508, {}, true)
	end
end

--[[
	请求解除绑定手机返回消息
	msg = {}
]]
function personal_manager:resUnBindPhone(msg)
	local pinfo = get_player_info()
	pinfo.phone = ""
	local obj = WindowScene.getInstance():getDlgByName("CPersonalCenterMain")
	if obj then obj:updatePhoneBindUI() end
	TipsManager:showOneButtonTipsPanel(509, {}, true)
end

--[[
	请求获取绑定手机验证码消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:手机号码格式错误,2:获取验证码时间间隔不足
		名称:second 类型:int 备注:当res为2时，剩余秒
	}
]]
function personal_manager:resGetBindPhoneKey(msg)
	if msg.res == 0 then
		
	elseif msg.res == 1 then
		TipsManager:showOneButtonTipsPanel(506, {}, true)
	elseif msg.res == 2 then
		TipsManager:showOneButtonTipsPanel(100015, {msg.second,}, true)
		local obj = WindowScene.getInstance():getDlgByName("CPersonalCenterMain")
		if obj then obj:resetTime(msg.second) end
	end
end

--[[
	请求获取解除绑定手机验证码消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:获取验证码时间间隔不足
		名称:second 类型:int 备注:当res为2时，剩余秒
	}
]]
function personal_manager:resGetUnBindPhoneKey(msg)
	if msg.res == 0 then
		print("解除绑定成功》》》》》》》》》》》》")
	elseif msg.res == 1 then
		TipsManager:showOneButtonTipsPanel(100015, {msg.second,}, true)
		local obj = WindowScene.getInstance():getDlgByName("CPersonalCenterMain")
		if obj then obj:resetTime(msg.second) end
	end
end

--[[
	请求修改银行密码结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:旧密码输入不正确, 2:新密码格式不对
	}
]]
function personal_manager:resModifyBankPwd(msg)
	if msg.res == 0 then
		--修改成功
		TipsManager:showOneButtonTipsPanel(503, {}, true)
	elseif msg.res == 1 then
		--旧密码输入不正确
		TipsManager:showOneButtonTipsPanel(501, {}, true)
	elseif msg.res == 2 then
		--新密码格式不对
		TipsManager:showOneButtonTipsPanel(705, {}, true)
	end
end



-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
