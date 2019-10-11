#remark
local panel_ui
-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

CLeaveLobbyTipsExt = class("CLeaveLobbyTipsExt", function ()
	local ret = ccui.ImageView:create()
	ret:loadTexture("lobby/resource/general/heidi.png")
	ret:setScale9Enabled(true)
	return ret
end)


function CLeaveLobbyTipsExt.create()
	local layer = CLeaveLobbyTipsExt.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end


function CLeaveLobbyTipsExt:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(_onEnterOrExit);
end

function CLeaveLobbyTipsExt:onEnter()
	self:setTouchEnabled(true)
end

function CLeaveLobbyTipsExt:onExit()

end

function CLeaveLobbyTipsExt:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))

	panel_ui = require("lobby.ui_create.ui_close").create()
	self:addChild(panel_ui.root)
	panel_ui.root:setPosition(size.width/2,size.height/2)

	local pinfo = get_player_info()

	panel_ui.btnUpLeve:setVisible(pinfo.is_tourist)
	panel_ui.tvTourist:setVisible(pinfo.is_tourist)

	panel_ui.btnChange:setVisible(not pinfo.is_tourist)
	panel_ui.tvPlayer:setVisible(not pinfo.is_tourist)

	self:registerHandler()
end

function CLeaveLobbyTipsExt:registerHandler()
	panel_ui.btnChange:onTouch(function ( e )
		if e.name == "ended" then
			send_login_ReqLogout()
			global_music_ctrl.play_btn_one()
			WaitMessageHit.showWaitMessageHit(2)

			local pinfo = get_player_info()
			if pinfo and pinfo.chose_login_mod == 3 then--手机登录 
				--手机登陆 清除手机登陆缓存
				local user_lst = getLoginUserInfo()
				user_lst[3]  ={}
				saveUserNameLst()
			end
		end
	end)

	panel_ui.btnTrueClose:onTouch(function ( e )
		if e.name == "ended" then
			send_login_ReqLogout()
	        WindowModule.close()
			global_music_ctrl.play_btn_one()
			WaitMessageHit.showWaitMessageHit(2)
		end
	end)

	--升级帐号
	panel_ui.btnUpLeve:onTouch(function ( e )
		if e.name == "ended" then
			global_music_ctrl.play_btn_one()
			local obj = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
			if obj then
				obj:upAccount()
			end

			WindowScene.getInstance():closeDlg(self)
		end
	end)

	panel_ui.btnClose:onTouch(function ( e )
		if e.name == "ended" then
			global_music_ctrl.play_btn_one()
			WindowScene.getInstance():closeDlg(self)
		end
	end)
end
