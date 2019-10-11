#remark
player_manager = {}

--[[
	玩家属性改变消息消息
	msg = {
		名称:type 类型:int 备注:属性类型(1:元宝，2:金币,3:保险箱金币,4:积分,5:奖券,6:玩家等级,7:vip等级,8:vip时长)
		名称:val 类型:long 备注:属性值
	}
]]
function player_manager:resPlayerAttrChangeMsg(msg)
	local playerinfo = get_player_info()

	if msg.type == 1 then -- 元宝
		playerinfo.acer = msg.val
        --派发事件
		EventUtils.dispathEvents(EventUtils.ACER_CHANGE)
	elseif msg.type == 2 then --金币
		playerinfo.gold = msg.val
		--派发事件
		EventUtils.dispathEvents(EventUtils.GOLD_CHANGE)
	elseif msg.type == 3 then --保险箱金币
		playerinfo.safeGold = msg.val
		--派发事件
		EventUtils.dispathEvents(EventUtils.SAFEGOLD_CHANGE)
	elseif msg.type == 4 then
		playerinfo.integral = tonumber(msg.val)
	elseif msg.type == 5 then
		playerinfo.lottery = tonumber(msg.val)
	elseif msg.type == 6 then
		playerinfo.level = tonumber(msg.val)
		--派发事件
		EventUtils.dispathEvents(EventUtils.LEVEL_CHANGE)
	elseif msg.type == 7 then
		playerinfo.vipLevel = tonumber(msg.val)
	elseif msg.type == 8 then
		playerinfo.vipTime = tonumber(msg.val)
		--派发事件
		EventUtils.dispathEvents(EventUtils.VIP_CHANGE)
	end
end

--[[
	通用错误消息消息
	msg = {
		名称:msgId 类型:int 备注:消息id
		名称:system 类型:int 备注:系统(暂时未用)
		名称:args 类型:List<String> 备注:消息参数
	}
]]
function player_manager:resErrorMsg(msg)
	print("err msg id = " .. msg.msgId)
	TipsManager:showOneButtonTipsPanel(msg.msgId, msg.args, true)
end


local function __login_out_callback()
	WindowScene.getInstance():replaceModuleByModuleName("Login")
end

function player_manager:LoginOutPro(msg)
	if msg then
		update_login_state(false)
		if msg.type == 0 then --主动退出
			print("login out")
			WindowScene.getInstance():replaceModuleByModuleName("Login")

			--CBankExt.resetPassword()
		elseif msg.type == 1 then --同一个账号重复登录被T号退出
			print("being login out")
			TipsManager:showOneButtonTipsPanel(129, {}, true, __login_out_callback, __login_out_callback)
		elseif msg.type == 2 then --玩家被冻结退出
			TipsManager:showOneButtonTipsPanel(106, {}, true, __login_out_callback, __login_out_callback)
		elseif msg.type == 3 then --玩家卡线被退出
			TipsManager:showOneButtonTipsPanel(715, {}, true, __login_out_callback, __login_out_callback)
		elseif msg.type == 4 then --停服
			TipsManager:showOneButtonTipsPanel(100017, {}, true, __login_out_callback, __login_out_callback)
		end
	end
end

--显示玩家菜单
function player_manager:showPlayerMenu(memberinfo, pos)
	if self._playerMenu == nil then
		self._playerMenu = CPlayerMenuExt.create()
		self._playerMenu:showMe(memberinfo, pos)
	else
		self._playerMenu:onHide()
		self._playerMenu = CPlayerMenuExt.create()
		self._playerMenu:showMe(memberinfo, pos)
	end
end

--隐藏玩家菜单
function player_manager:hidePlayerMenu()
	if self._playerMenu then
		self._playerMenu:onHide()
	end
end

--[[
	比赛通知消息消息
	msg = {
		名称:game 类型:int 备注:游戏
		名称:room 类型:int 备注:房间
		名称:leftTime 类型:int 备注:剩余开赛时间(秒)
	}
]]
function player_manager:resMatchNotice(msg)
	
end