#remark
--[[
	账号升级
]]

local panel_ui

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

CAccountUpgrade = class("CAccountUpgrade", function ()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
	return ret
end)


function CAccountUpgrade.create()
	local layer = CAccountUpgrade.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		layer:registerTouchEvent()
		return layer
	end
end

function CAccountUpgrade:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter();
		elseif event == "exit" then
			self:onExit();
		end
	end

	self:registerScriptHandler(_onEnterOrExit);
end

function CAccountUpgrade:registerTouchEvent()
	local function _on_touch_began(touch, event) return true end
    local function _on_touch_move(touch, event) return true end
    local function _on_touch_end(touch, event) return true end
    
    local listener = cc.EventListenerTouchOneByOne:create()

    listener:setSwallowTouches(true)
    listener:registerScriptHandler(_on_touch_began,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(_on_touch_move,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(_on_touch_end,cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener,self)
end

function CAccountUpgrade:onEnter()

end

function CAccountUpgrade:onExit()

end

function CAccountUpgrade:init_ui()

    local size = WindowModule.get_window_size()
    self:setContentSize(cc.size(size.width, size.height))
    self:setPosition(cc.p(size.width/2, size.height/2))

	panel_ui = require("lobby.ui_create.ui_up").create()
	self:addChild(panel_ui.root)

	local des_size = WindowScene.getInstance():getDesSize()
	panel_ui.root:setPosition(des_size.w/2 - 30,des_size.h/2)

	--[[
		check_mod : 1 -> check account,2 -> check nicheng,3 -> check mi ma,
	]]
	self.status_ctrl_lst = {
		[1] = {id = 1,objs = {panel_ui.inputName,panel_ui.imgNameWrong,panel_ui.textNameWrong,}, check_mod = 1,},
		[2] = {id = 2,objs = {panel_ui.inputNick,panel_ui.imgNickWrong,panel_ui.textNickWrong,}, check_mod = 2,},
		[3] = {id = 3,objs = {panel_ui.inputKey,panel_ui.imgKeyWrong,panel_ui.textKeyWrong,},  check_mod = 3,},
		[4] = {id = 4,objs = {panel_ui.inputTuijianID,panel_ui.imgTuijianIDWrong,panel_ui.textTuijianID,},  check_mod = 4,},
	}

	self.status_ctrl_lst[1].objs[2]:setVisible(false)
	self.status_ctrl_lst[1].objs[3]:setString(string_scr_cfg[4].text)

	self.status_ctrl_lst[2].objs[2]:setVisible(false)
	self.status_ctrl_lst[2].objs[3]:setString(string_scr_cfg[7].text)

	self.status_ctrl_lst[3].objs[2]:setVisible(false)
	self.status_ctrl_lst[3].objs[3]:setString(string_scr_cfg[12].text)

	self.status_ctrl_lst[4].objs[2]:setVisible(false)
	self.status_ctrl_lst[4].objs[3]:setString(string_scr_cfg[14].text)

	self:registerHandler()
	self.accout_err 	= 0
	self.user_name_err  = 0
end

function CAccountUpgrade:registerHandler()
	panel_ui.btnSure:onTouch(function (e)
		if e.name == "ended" then
			self:onOk()
			global_music_ctrl.play_btn_one()
		end
	end)

	panel_ui.btnClose:onTouch(function (e)
		if e.name == "ended" then
			self:onClose()
			global_music_ctrl.play_btn_one()
		end
	end)

	panel_ui.inputName:onEvent(function (e)
		if e.name == "ATTACH_WITH_IME" then
			self:accountCheck(1)
		elseif e.name == "DETACH_WITH_IME" then
			self:accountCheck(0)
		elseif e.name == "INSERT_TEXT" then
			--self:accountCheck(0)
		elseif e.name == "DELETE_BACKWARD" then
		end
	end)

	panel_ui.inputKey:onEvent(function (e)
		if e.name == "ATTACH_WITH_IME" then
			self:codeCheck(1)
		elseif e.name == "DETACH_WITH_IME" then
			self:codeCheck(0)
		elseif e.name == "INSERT_TEXT" then
			--self:codeCheck(0)
		elseif e.name == "DELETE_BACKWARD" then
		end
	end)

	panel_ui.inputTuijianID:onEvent(function (e)
		if e.name == "ATTACH_WITH_IME" then
			self:IDCheck(1)
		elseif e.name == "DETACH_WITH_IME" then
			self:IDCheck(0)
		elseif e.name == "INSERT_TEXT" then
			--self:codeCheck(0)
		elseif e.name == "DELETE_BACKWARD" then
		end
	end)

	panel_ui.inputNick:onEvent(function (e)
		if e.name == "ATTACH_WITH_IME" then
			self:userNameCheck(1)
		elseif e.name == "DETACH_WITH_IME" then
			self:userNameCheck(0)
		elseif e.name == "INSERT_TEXT" then
			--self:userNameCheck(0)
		elseif e.name == "DELETE_BACKWARD" then
		end
	end)
end

function CAccountUpgrade:accountCheck(mod)
	if mod == 0 then-- lose focus
		local msg = {
			userName = self.status_ctrl_lst[1].objs[1]:getString(),
		}
		send_login_ReqCheckUserName(msg)
		print("send request to check user account !")
	elseif mod == 1 then -- get focus
		self.status_ctrl_lst[1].objs[3]:setString(string_scr_cfg[4].text)
		self.status_ctrl_lst[1].objs[2]:setVisible(false)
	end
end

function CAccountUpgrade:userNameCheck(mod)
	if mod == 0 then --lose focus
		local msg = {
			playerName = self.status_ctrl_lst[2].objs[1]:getString(),
		}
		send_login_ReqCheckPlayerName(msg)
		print("send request to check user name !")
	elseif mod == 1 then --get focus
		self.status_ctrl_lst[2].objs[3]:setString(string_scr_cfg[7].text)
		self.status_ctrl_lst[2].objs[2]:setVisible(false)
	end
end

function CAccountUpgrade:codeCheck(mod)
	if mod == 0 then
		local str = self.status_ctrl_lst[3].objs[1]:getString()
		print(""..str)
		if str == "" then
			self.status_ctrl_lst[3].objs[3]:setString(string_scr_cfg[15].text)
			self.status_ctrl_lst[3].objs[2]:setVisible(true)
			return
		end
		if is_number_abc_str(str) == false then
			self.status_ctrl_lst[3].objs[3]:setString(string_scr_cfg[13].text)
			self.status_ctrl_lst[3].objs[2]:setVisible(true)
			return
		end


		if self:checkInputRel(3,str) == false then
			self.status_ctrl_lst[3].objs[3]:setString(string_scr_cfg[9].text)
			self.status_ctrl_lst[3].objs[2]:setVisible(true)

			return
		end
		self.status_ctrl_lst[3].objs[2]:setVisible(false)
	elseif mod == 1 then
		self.status_ctrl_lst[3].objs[3]:setString(string_scr_cfg[12].text)
		self.status_ctrl_lst[3].objs[2]:setVisible(false)
	end
end

function CAccountUpgrade:IDCheck(mod)
	if mod == 0 then
		local str = self.status_ctrl_lst[4].objs[1]:getString()
		if is_number_abc_str(str) == false then
			self.status_ctrl_lst[4].objs[3]:setString(string_scr_cfg[14].text)
			--self.status_ctrl_lst[4].objs[2]:setVisible(true)
			return
		end

		self.status_ctrl_lst[4].objs[2]:setVisible(false)
	elseif mod == 1 then
		self.status_ctrl_lst[4].objs[3]:setString(string_scr_cfg[14].text)
		self.status_ctrl_lst[4].objs[2]:setVisible(false)
	end
end

function CAccountUpgrade:onClose()
	if self.close_call_back then
		self.close_call_back()
	end

	WindowScene.getInstance():closeDlg(self)
end

function CAccountUpgrade:checkInputRel(mod,str)
	local ret 	  = true
	local asy_ret = ansy_string(str)

	if mod == 1 then
		local is_all_number = true
		for k,v in pairs(asy_ret.ch_lst) do
			if v.ch_type == 2 then
				is_all_number = false
				break
			end
		end

		if (asy_ret.str_len < 6 or asy_ret.str_len > 18) or is_all_number == true then 
			ret = false 
		end
	elseif mod == 2 then
		local wide_len = 0
		for k,v in pairs(asy_ret.ch_lst) do 
			wide_len = wide_len + v.wide_len 
		end
		if (wide_len < 4 or wide_len > 18) then 
			ret = false 
		end
	elseif mod == 3 then
		if asy_ret.str_len < 8 or asy_ret.str_len > 16 then
			ret = false 
		end

		if is_number_abc_str(str) == false then
			ret = false
		end
	elseif mod == 4 then
		if not asy_ret then
			ret = true 
		end

		if is_number_abc_str(str) == false then
			ret = true
		end
	end

	return ret
end

function CAccountUpgrade:onOk()
	local is_input_right = self:checkInput()
	if is_input_right == true and self.accout_err == 0 and self.user_name_err == 0 then
		print("send up account msg to server! ")
		local msg = {
			userName 	= panel_ui.inputName:getString(),
			playerName 	= panel_ui.inputNick:getString(),
			pwd 		= panel_ui.inputKey:getString(),
			recommend   = "0",
		}

		local str = panel_ui.inputTuijianID:getString()
		if ""~=str then
			msg.recommend = str
		end

		-- if is_number_abc_str(msg.recommend) == true then
		-- 	msg.recommend = "0"
		-- end

		local pinfo = get_player_info()
		pinfo.chose_login_mod = 1 --账号登陆

		local user_lst = getLoginUserInfo()
		user_lst[pinfo.chose_login_mod] = {}
		user_lst[pinfo.chose_login_mod].id = 1
		user_lst[pinfo.chose_login_mod].user_name = msg.userName
		user_lst[pinfo.chose_login_mod].user_code = msg.pwd
		user_lst[pinfo.chose_login_mod].b_rember_code = true
		user_lst[pinfo.chose_login_mod].is_tourist = 1

		send_gamehall_ReqTouristUpdate(msg)
		self:onClose()
	else
		self:codeCheck(0)
		self:accountCheck(0)
		self:userNameCheck(0)
		self:IDCheck(0)
	end
end

function CAccountUpgrade:checkInput()
	local right = true
	for k,v in pairs(self.status_ctrl_lst) do
		local str = v.objs[1]:getString()
		local ret = self:checkInputRel(v.check_mod,str)
		v.objs[2]:setVisible(not ret)
		if ret == false then 
			right = false
		end
	end

	-- if right == false then
	-- 	self.status_ctrl_lst[3].objs[1]:setString("")
	-- end
	

	return right
end

function CAccountUpgrade:setCloseCallBack(fun)
	self.close_call_back = fun
end


--动态验证用户账号
function CAccountUpgrade:onRecChekcAccount(msg)
	print("check user account,msg.res = " .. msg.res)
	self.accout_err = msg.res
	if msg.res == 0 then
		self.status_ctrl_lst[1].objs[2]:setVisible(false)
		self.status_ctrl_lst[1].objs[3]:setString(string_scr_cfg[4].text)
	elseif msg.res == 1 then
		self.status_ctrl_lst[1].objs[2]:setVisible(true)
		self.status_ctrl_lst[1].objs[3]:setString(string_scr_cfg[5].text)
	elseif msg.res == 2 then
		self.status_ctrl_lst[1].objs[2]:setVisible(true)
		self.status_ctrl_lst[1].objs[3]:setString(string_scr_cfg[6].text)
	end
end

--动态验证用户名
function CAccountUpgrade:onRecCheckUserName(msg)
	print("check user name,msg.res = " .. msg.res)
	self.user_name_err = msg.res
	if msg.res == 0 then
		self.status_ctrl_lst[2].objs[2]:setVisible(false)
		self.status_ctrl_lst[2].objs[3]:setString(string_scr_cfg[7].text)
	elseif msg.res == 1 then
		self.status_ctrl_lst[2].objs[2]:setVisible(true)
		self.status_ctrl_lst[2].objs[3]:setString(string_scr_cfg[8].text)
	elseif msg.res == 2 then
		self.status_ctrl_lst[2].objs[2]:setVisible(true)
		self.status_ctrl_lst[2].objs[3]:setString(string_scr_cfg[6].text)
	end
end
