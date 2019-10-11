--[[
	手机验证
]]
 --注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码

local refresh_time = 60

local ui_obj_lst_create = require "lobby.ui_create.ui_Login_phone"

PhoneLogin = class("PhoneLogin",function ()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
    return ret
end)

function PhoneLogin.create()
	local obj = PhoneLogin.new()
	if obj then
		obj:init_ui()
		obj:regEnterExit()
	end	

	return obj
end
function PhoneLogin:regEnterExit()
	local function _onEnterOrExit(event)

		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(_onEnterOrExit);
end

function PhoneLogin:onEnter()
	self:setTouchEnabled(true)

	-- local pinfo = get_player_info()
	-- pinfo.chose_login_mod = 3 --手机登录

	-- local user_lst = getLoginUserInfo()
	-- if #user_lst > 0 then

	-- 	local msg = {
	-- 		name 		= user_lst[pinfo.chose_login_mod].user_name,
	-- 		password 	= user_lst[pinfo.chose_login_mod].user_code,
	-- 		mac 		= CTools:getMacAddress()
	-- 	}
	-- 	print("============="..msg.name)
	-- 	print("============="..msg.password)

	-- 	self.ui_obj_lst.phoneNum:setString(msg.name)

	-- 	if msg.name ~= ""  then

	-- 		if msg.password ~= "" then

	-- 			send_login_ReqLoginFromPhone(msg)
	-- 		else
	-- 			local msgPW = {
	-- 				phoneNumber = msg.name,
	-- 				flag = 0,
	-- 				mac = CTools:getMacAddress(),
	-- 			}

	-- 			send_login_ReqPhoneLogin(msgPW)
	-- 		end
	-- 	end
	-- end

end

function PhoneLogin:onExit()
end
 
--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码

function PhoneLogin:init_ui()
	self.ui_obj_lst = ui_obj_lst_create.create()
	self:addChild(self.ui_obj_lst.root)

	self.ui_obj_lst.TextRestTime:setString("")
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self:registerCtrlEvent()
	 
end

function PhoneLogin:registerCtrlEvent()
	--关闭
	self.ui_obj_lst.btnClose:onTouch(function (e)
		if e.name == "ended" then
			WindowScene.getInstance():closeDlg(self)
	 
		end
	end) 

	--确定
	self.ui_obj_lst.btnSure:onTouch(function (e) 
		if e.name == "ended" then
			--self:onCloseClick(e)
			local phone_key = self.ui_obj_lst.phoneNum:getString()
			if phone_key == "" then
				TipsManager:showOneButtonTipsPanel(108,{},true)
				return
			end
	
			local phone_yanzhen = self.ui_obj_lst.verifyKey:getString()
			if self.b_input_check_code == false then
				phone_yanzhen = ""
			end
	
			local msg ={
				phoneNumber = phone_key,
				flag = 1,
				key = phone_yanzhen,
				mac = CTools:getMacAddress(),
			}
	
			local pinfo = get_player_info()
			pinfo.password = msg.password
	
			print("==================================验证码"..msg.flag)
			print("==================================验证码"..phone_yanzhen)
			local pinfo = get_player_info()
			pinfo.chose_login_mod = 3 --手机登陆
	
			local user_lst = getLoginUserInfo()
			user_lst[pinfo.chose_login_mod] = {}
			user_lst[pinfo.chose_login_mod].id = 1
			user_lst[pinfo.chose_login_mod].user_name = msg.phoneNumber
			user_lst[pinfo.chose_login_mod].user_code = pinfo.password
			user_lst[pinfo.chose_login_mod].b_rember_code = true
			user_lst[pinfo.chose_login_mod].login_type = 3
	
			send_login_ReqLoginByPhoneKey(msg)
		end


	 end) 
	 
 
	self.ui_obj_lst.btnGet:onTouch(function (e)

		if e.name == "ended" then

			local phonenum = self.ui_obj_lst.phoneNum:getString()
			if "" ~= phonenum then
				self.ui_obj_lst.btnGet:setEnabled(false)
				self.ui_obj_lst.btnGet:setBright(false)
			 
				self.ui_obj_lst.btnGet:runAction( cc.Repeat:create(cc.Sequence:create(cc.DelayTime:create(1),cc.CallFunc:create(
					function() 
						refresh_time=refresh_time-1
						self.ui_obj_lst.TextRestTime:setString(refresh_time.."s")
						if refresh_time<=0 then
							self.ui_obj_lst.TextRestTime:setString("")
							
							self.ui_obj_lst.btnGet:setEnabled(true)	
							self.ui_obj_lst.btnGet:setBright(true)
							refresh_time= 60
						end
					end)),refresh_time))
					

				local msg = {
					phoneNumber = self.ui_obj_lst.phoneNum:getString(),
					flag = "1",
					mac = CTools:getMacAddress(),
				}

				print("==========="..msg.flag.."============="..self.ui_obj_lst.phoneNum:getString())
				send_login_ReqPhoneLogin(msg)
			end
		end
	end) --重新获取手机验证码

--	self.ui_obj_lst.phoneNum:onEvent(function (e)

--		if e.name == "INSERT_TEXT" then
--			local str = self.ui_obj_lst.phoneNum:getString()

--			local isnum = tonumber(str)
--			if isnum == nil then
--				print("1==========================="..str)
--				self.ui_obj_lst.phoneNum:setString("")
--				return
--			else
--				print("2==========================="..isnum)
--			end

--			if string.len(str)>11 then
--				self.ui_obj_lst.phoneNum:setString(string.sub(str,1,11))
--			end 
--		end

--		-- if e.name == "ATTACH_WITH_IME" then
--		-- 	 self.phnumString=self.ui_obj_lst.phoneNum:getString()

--		-- elseif e.name == "DETACH_WITH_IME" then
--		-- 	local str = self.ui_obj_lst.phoneNum:getString()
--		-- 	 if string.match(str,'%a')~=nil  then
--		-- 	 end

--		-- elseif e.name == "INSERT_TEXT" then
--		-- 	local str = self.ui_obj_lst.phoneNum:getString()
--	    -- 	local lastStr=string.sub(str,string.len(self.phnumString)+1,string.len(str))
--		-- 	if string.match(lastStr,'%d')==nil     then
--		-- 		self.ui_obj_lst.phoneNum:setString(self.phnumString)
--		-- 	 else
--		-- 		self.phnumString=self.ui_obj_lst.phoneNum:getString()   
--		-- 	end
--		-- 	if string.len(str)>15 then
--		-- 		self.ui_obj_lst.phoneNum:setString(string.sub(str,1,15))
--		-- 	end
--		-- 	print("===============")

--		-- elseif e.name == "DELETE_BACKWARD" then
--		-- end
--	end)

--	self.ui_obj_lst.verifyKey:onEvent(function (e)
--		if e.name == "INSERT_TEXT" then
--			local str = self.ui_obj_lst.verifyKey:getString()
--			local isnum = tonumber(str)
--			if isnum == nil then
--				print("1==========================="..str)
--				self.ui_obj_lst.verifyKey:setString("")
--				return
--			else
--				print("2==========================="..isnum)
--			end

--			if string.len(str)>6 then
--				self.ui_obj_lst.verifyKey:setString(string.sub(str,1,6))
--			end

--		end
--	end)
	

end
 
function PhoneLogin:onRecPhoneLoginPassword(msg)
	
	if msg.password and msg.password ~= "" then
		
		local pinfo = get_player_info()
		pinfo.password = msg.password
		pinfo.chose_login_mod = 3 --手机登陆

		local user_lst = getLoginUserInfo()
		user_lst[pinfo.chose_login_mod] = {}
		user_lst[pinfo.chose_login_mod].id = 1
		user_lst[pinfo.chose_login_mod].user_name = self.ui_obj_lst.phoneNum:getString()
		user_lst[pinfo.chose_login_mod].user_code = pinfo.password
		user_lst[pinfo.chose_login_mod].b_rember_code = true
		user_lst[pinfo.chose_login_mod].login_type = 3

		local msgPW ={
			phoneNumber = self.ui_obj_lst.phoneNum:getString(),
			flag = 0,
			key = pinfo.password,
			mac = CTools:getMacAddress(),
		}

		send_login_ReqLoginByPhoneKey(msgPW)
	end
end
