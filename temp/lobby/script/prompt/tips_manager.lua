#remark
--[[
	提示层面板管理
]]

TipsManager = {}
TipsManager.passwordPanel = nil
TipsManager.chipsExchangePanel = nil
TipsManager.goldExchangePanel = nil

--显示密码输入面板
function TipsManager:showPasswordPanel(callBack)
	if TipsManager.passwordPanel then
		return
	end

	TipsManager.passwordPanel = CPasswordInputExt.create()
	TipsManager.passwordPanel:showMe(callBack)
end

--关闭大厅提示面板
function TipsManager:showCloseButtonTipsPanel(isShowTime, changeCallBack, cancelCallBack, closeCallback, arg)
	local tips = CloseButtonPanel.create()
	tips:init_message(isShowTime, changeCallBack, cancelCallBack, closeCallback, arg)
end
--进入个人中心及绑定本机提示面板
--[[
	info = {
		type 0 -> 个人中心，1 -> 绑定本机, 
		send_call,
	}
]]
function TipsManager:showPersonalGoin(info)
	local panel = CPersonalGoin.create(info)
	panel:showMe()
end

--显示银行
function TipsManager:showSafeBoxPanel()
	local panel = CSafeBoxMain.create()
	panel:showMe()
end

--显示房间设置面板
function TipsManager:showRoomSetPanel()
	local panel = CRoomSetExt.create()
	panel:showMe(HallManager._roomSettingData)
end

--显示游戏设置面板
function TipsManager:showGameSetPanel(gameid)
	local panel = CGameSetExt.create()
	panel:showMe(gameid)
end

--显示兑换界面
function TipsManager:showExchangePanel(chips, gold, callback)
	local panel = WindowScene.getInstance():showDlgByName("CExchangePanelExt")
	panel:setInfo(chips, gold, callback)
end


--显示确定 和  取消  按钮的tip 面板
function TipsManager:showTwoButtonTipsPanel(msgID, repArr, isShowTime, sureCallBack, cancelCallBack, arg)
	-- body
	if message_config[msgID] == nil then
		return
	end
	local tips = WindowScene.getInstance():showDlgByName("CButtonPanel")
	tips:init_message(msgID, repArr, isShowTime, sureCallBack, cancelCallBack, arg)
end

--显示 充值tips 面板
function TipsManager:showRechargeTipsPanel( msgID, repArr, isShowTime, sureCallBack, cancelCallBack, arg )
	-- body
	if message_config[msgID] == nil then
		return
	end
	local tips = CSureOrRechagePanel.create()
	tips:init_message(msgID, repArr, isShowTime, sureCallBack, cancelCallBack, arg)
	tips:showMe()
end

--显示 确定tips 面板
function TipsManager:showOneButtonTipsPanel( msgID, repArr, isShowTime, sureCallBack, cancelCallBack, arg )
	-- body
	if message_config[msgID] == nil then
		return
	end
	local tips = WindowScene.getInstance():showDlgByName("ConeButtonPanel")
	tips:init_message(msgID, repArr, isShowTime, sureCallBack, cancelCallBack, arg)
end

--显示 右下角浮框
function TipsManager:showInformPanel( msgID, repArr)
	-- body
	if message_config[msgID] == nil then
		return
	end
	local tips = CInformPanel.create()
	tips:init_message(msgID, repArr)
	tips:showMe()
end

--显示 比赛通知框
function TipsManager:showMatchInformPanel( gameName, time )
	local tips = CMatchInformExt.create()
	tips:init_message(gameName, time)
	tips:showMe()
end



-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
