--[[
	网络错误处理
]]

NetErrPro = {}

local is_connect_err 	 = false
local is_connect_timeout = false

function NetErrPro.connect_error_pro()
	local pinfo = get_player_info()
	if pinfo.is_have_login == true then
		print("is loging mark true >>>>>>>>>>>>>>>>>>>" )
		local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
		if gamelobby == nil then
			WindowScene.getInstance():replaceModuleByModuleName("game_lobby")
			gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
		end
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_GAME)
	end

	--WindowScene.getInstance():clearDlgLst() --正在下载游戏时会出错，所以不能清空
	is_connect_err = true
	TipsManager:showTwoButtonTipsPanel(601,{},true,NetErrPro.reconnect_server,nil,nil)
	HeartPro.pause_send_hmsg()
	WaitMessageHit.closeWaitMessageHit()
end

function NetErrPro.connect_timeout_pro()
	local pinfo = get_player_info()
	print("connect time out >>>>>>>>>>>>>>>>")
	if pinfo.is_have_login == true then
		local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
		if gamelobby == nil then
			WindowScene.getInstance():replaceModuleByModuleName("game_lobby")
			gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
		end
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_GAME)
	end
	
	--WindowScene.getInstance():clearDlgLst()  --正在下载游戏时会出错，所以不能清空
	is_connect_timeout = true
	TipsManager:showTwoButtonTipsPanel(602,{},true,NetErrPro.reconnect_server,nil,nil)
	HeartPro.pause_send_hmsg()
	WaitMessageHit.closeWaitMessageHit()
end

function NetErrPro.connect_success_pro()
	if is_connect_err == true or is_connect_timeout == true then
		print("reconnect server success >>>>>>>>>>>")
		is_connect_timeout 	= false
		is_connect_err 		= false

		local bk_hit_obj = BlackMessageHit.create({txt = "重新连接服务器成功！",color = cc.c3b(255,255,255),})
		WindowScene.getInstance():showDlg(bk_hit_obj)

		local pinfo 	= get_player_info()
		local user_lst  = getLoginUserInfo()
		local mac_addr  = CTools:getMacAddress()
		
		if pinfo.is_have_login == true then

            if #user_lst > 0 then
            	local login_type = user_lst[pinfo.chose_login_mod].login_type
            	if login_type == 0 then
            		local msg = {
				  	    account 	= user_lst[pinfo.chose_login_mod].user_name,
					    mac 		= mac_addr,
				    }
				    send_login_ReqTouristLogin(msg)
				    print("relogin ! login mod is tourist login >>>>>>>>")
            	elseif login_type == 1 or login_type == 3 then
            		local msg = {
					    name 		= user_lst[pinfo.chose_login_mod].user_name,
					    password 	= user_lst[pinfo.chose_login_mod].user_code,
					    mac 		= mac_addr,
				    }
				    send_login_ReqLoginFromPhone(msg)
				    print("relogin ! login mod is account login >>>>>>>>")
            	elseif login_type == 2 then
            		local msg = {
				        platform    = "wechatLogin",
				  	    unionid 	= user_lst[pinfo.chose_login_mod].user_name,
					    nickname 	= user_lst[pinfo.chose_login_mod].user_code,
					    mac 		= mac_addr,
				    }
				    send_login_ReqLoginFromWechat(msg)
				    print("relogin ! login mod is wechat login >>>>>>>>")
            	end
            else 
            	send_login_ReqTouristLogin({mac=mac_addr, account=""})
            end
		end
	end

	HeartPro.init_heart_pro()
end

function NetErrPro.reconnect_server()
	g_ReConnect()
end

function NetErrPro.unreconnect_server()
	printf("cancel connect server ")
	WindowModule.close()
end



