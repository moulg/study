--[[
	登陆场景
]]
local accLogin_ui

CAccLoginExt = class("CAccLoginExt",function()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
    return ret
end
)

function CAccLoginExt.create()
	
	local layer = CAccLoginExt.new()

	if layer ~= nil then
		layer:init_data()
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end
--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码
function CAccLoginExt:regEnterExit()
	local function _onEnterOrExit(event)

		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(_onEnterOrExit);
end

function CAccLoginExt:onEnter()
	self:setTouchEnabled(true)
end

function CAccLoginExt:onExit()
--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码
end

function CAccLoginExt:init_data()
	
	self.msg = {
		userName = "",
		playerName = "",
		icon = 1,
		sex = 0,
		password = "",
		recommender = "0",
		name = "",
		idCard = "",
		key = "",
		mac =  CTools:getMacAddress(),
	}

end

function CAccLoginExt:init_ui()
	accLogin_ui = require("lobby.ui_create.ui_Login_player").create()
	self:addChild(accLogin_ui.root)

	self.accLogin_ui=accLogin_ui

	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	-- accLogin_ui.root:setPosition(size.width/2, size.height/2)
    self:registerHandler()
	local user_lst = getLoginUserInfo()
	if #user_lst > 0 then
		if user_lst[1].login_type == 1 then  -- 账号登录
		   accLogin_ui.inputName:setString(user_lst[1].user_name)
		   accLogin_ui.inputKey:setString(user_lst[1].user_code)
		end
	end

	self.regPanel=accLogin_ui.regPanel
	self.regPanel:setVisible(false)
	self.loginPanel=accLogin_ui.loginPanel
	self.loginPanel:setVisible(true)

--	self:checkInputText(self.accLogin_ui.textFieldAccout,false)
--	self:checkInputText(self.accLogin_ui.textFieldNickname,false);
--	self:checkInputText(self.accLogin_ui.textFieldpass,false);
    local dhT = accLogin_ui.zh:getChildByName("Image_1_0_0"):getChildByName("dh")
    local chT = accLogin_ui.zh:getChildByName("Image_1_0_0"):getChildByName("ch")

    self.nodeVisible={
    ["账号"] = {dh = accLogin_ui.zh:getChildByName("Image_1_0_0"):getChildByName("dh"), ch = accLogin_ui.zh:getChildByName("Image_1_0_0"):getChildByName("ch")},
    ["昵称"] = {dh = accLogin_ui.nc_1:getChildByName("Image_1"):getChildByName("dh"), ch = accLogin_ui.nc_1:getChildByName("Image_1"):getChildByName("ch")},
    ["密码"] = {dh = accLogin_ui.mm1:getChildByName("Image_1_0"):getChildByName("dh"), ch = accLogin_ui.mm1:getChildByName("Image_1_0"):getChildByName("ch")}
    }

    self:reshTextTips("账号",false,false)
    self:reshTextTips("昵称",false,false)
    self:reshTextTips("密码",false,false)
	
    self.accLogin_ui.textFieldAccout:onEvent(function (e)

		local str = self.accLogin_ui.textFieldAccout:getString()

		if self:is_chinese(str) then
			self.accLogin_ui.textFieldAccout:setString("")
		end
		
		if e.name == "DETACH_WITH_IME" then 
			if str ~= "" then
				WaitMessageHit.showWaitMessageHit(2)
				local msg = {
					userName = str,
				}
				send_login_ReqCheckUserName(msg)
			else
				self:reshTextTips("账号",false,false)
			end
		end
	end)

	self.accLogin_ui.textFieldNickname:onEvent(function (e)
		if e.name == "DETACH_WITH_IME" then 
			local str = self.accLogin_ui.textFieldNickname:getString()
			if str ~= "" then
				WaitMessageHit.showWaitMessageHit(2)
				local msg = {
					playerName = str,
				}
				send_login_ReqCheckPlayerName(msg)
			else
				self:reshTextTips("昵称",false,false)
			 end
		end
	end)

	self.accLogin_ui.textFieldpass:onEvent(function (e)

		local str = self.accLogin_ui.textFieldpass:getString()
		
		if self:is_chinese(str) then
			self.accLogin_ui.textFieldpass:setString("")
		end

		if e.name == "DETACH_WITH_IME" then 

			if str ~= "" then
				local len=string.len(str)
				if 6>len or len > self.accLogin_ui.textFieldpass:getMaxLength() then
					--TipsManager:showOneButtonTipsPanel(200008, {}, true)
					self:reshTextTips("密码",false,true)
				else
					self:reshTextTips("密码",true,false)
				end
			else
				self:reshTextTips("密码",false,false)
			 end
		end
	end)
end
function CAccLoginExt:textFieldEventListener(sender,eventType)
 
	 
	 if eventType == 0 then      -- attach IME
	 
	 elseif eventType == 1 then  -- detach IME
	
		
	 elseif eventType == 2 then  -- insert text
	--   print(sender:getString())
	  self:checkInputTextInfo(sender,false)

	 elseif eventType == 3 then  -- delete text
	--   print(sender:getString())
	  self:checkInputTextInfo(sender,false)
  end

end
function CAccLoginExt:registerHandler()

	self.accLogin_ui.idLogin:onTouch(function (e)
		if e.name == "ended" then 
	     
	    	 self.accLogin_ui.idLogin:setBright(false)  
             self.accLogin_ui.idLogin:setEnabled(false) 
			 self.regPanel:setVisible(false)
			 self.loginPanel:setVisible(true)
			 self.accLogin_ui.fastRegist:setBright(true)  
             self.accLogin_ui.fastRegist:setEnabled(true) 
		end
	end)
 
	self.accLogin_ui.fastRegist:onTouch(function (e)
	    
		if e.name == "ended" then 
			 send_login_ReqRefreshRegisterPicKey({})
			 self.accLogin_ui.idLogin:setBright(true)  
             self.accLogin_ui.idLogin:setEnabled(true) 
			 self.regPanel:setVisible(true)
			 self.loginPanel:setVisible(false)
			 self.accLogin_ui.fastRegist:setBright(false)  
             self.accLogin_ui.fastRegist:setEnabled(false) 
		end
	end)

	local function __on_login_click(e)
		if e.name == "ended" then 
			self:onLogin()
			global_music_ctrl.play_btn_one()
		end
	end
	accLogin_ui.btnLogin:onTouch(__on_login_click) --帐号登录

	accLogin_ui.btnClose:onTouch(function (e)
		if e.name == "ended" then
			WindowScene.getInstance():closeDlg(self)
			global_music_ctrl.play_btn_one()
		end
	end)
	accLogin_ui.registBtn:onTouch(function (e)
		if e.name == "ended" then
			self:onRegisterClick()
			global_music_ctrl.play_btn_one()
		end
	end)

end

--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码

function CAccLoginExt:onRegisterClick()

		self.msg.userName = self.accLogin_ui.textFieldAccout:getString()
		self.msg.playerName 	= self.accLogin_ui.textFieldNickname:getString()
		self.msg.sex = 0
		self.msg.password = self.accLogin_ui.textFieldpass:getString()

		local user_rem = tonumber(self.accLogin_ui.textFieldRem:getString())
		if user_rem == nil then user_rem = 0 end
		self.msg.recommender = user_rem


		if self.msg.userName =="" or self.msg.playerName =="" or self.msg.password =="" then
			return
		end

		WaitMessageHit.showWaitMessageHit(2)

		local pinfo = get_player_info()
		pinfo.chose_login_mod = 1 --账号登陆

		local user_lst = getLoginUserInfo()
		user_lst[pinfo.chose_login_mod] = {}
		user_lst[pinfo.chose_login_mod].id = 1
		user_lst[pinfo.chose_login_mod].user_name = self.msg.userName
		user_lst[pinfo.chose_login_mod].user_code = self.msg.password
		user_lst[pinfo.chose_login_mod].b_rember_code = true
		user_lst[pinfo.chose_login_mod].login_type = 1

		send_login_ReqRegister(self.msg)

		print(self.msg.userName..self.msg.playerName..self.msg.icon..self.msg.sex..self.msg.password..self.msg.recommender..self.msg.name..self.msg.idCard..self.msg.key..self.msg.mac)
		print("=======================发送注册")
end
function CAccLoginExt:register_result(msg)
	if msg.res == 0 then
		print("=======================注册成功")
	elseif msg.res == 1 then --密码格式错误
		print("=======================密码格式错误")
		TipsManager:showOneButtonTipsPanel(200008, {}, true)
	elseif msg.res == 2 then --验证码错误
		print("=======================验证码错误")
		send_login_ReqRefreshRegisterPicKey({})
	end
	print("=======================注册结果")
end


--检查输入文本 click 是点击注册按钮
function CAccLoginExt:checkInputTextInfo(inputNode,click)
	if  not inputNode then
		return
	end
	local len=0
	local flag=true
    if inputNode==self.accLogin_ui.textFieldAccout then
		local textFieldAccoutStr=self.accLogin_ui.textFieldAccout:getString()
		len=string.len(textFieldAccoutStr)
		flag=true
		--小于6个字符
		if len<6 then
			flag=false
		elseif len>18 then 
			flag=false
		elseif string.match(textFieldAccoutStr,'%a')==nil or string.match(textFieldAccoutStr,'%d')==nil   then
			flag=false
		end
		self:checkInputText(self.accLogin_ui.textFieldAccout,flag,click);
	end
    
	if inputNode==self.accLogin_ui.textFieldNickname then 
		local textFieldNicknameStr=self.accLogin_ui.textFieldNickname:getString()
		 --昵称
		 len=string.len(textFieldNicknameStr)
		 print(len)
		 flag=true
		 --小于6个字符
		 if len<4 then
			 flag=false
		 elseif len>18 then--大于18个字符
			 flag=false
		  --全是数字或全是字符
		--  elseif string.match(textFieldNicknameStr,'%d')==nil or string.match(textFieldNicknameStr,'%d')==nil   then
		--    print("zmsz")
		--    flag=false
		 end
		 self:checkInputText(self.accLogin_ui.textFieldNickname,flag,click);
	end
	if inputNode==self.accLogin_ui.textFieldpass then 
       --密码
		local textFieldpassStr=self.accLogin_ui.textFieldpass:getString()
		len=string.len(textFieldpassStr)
		print(len)
		flag=true
		--小于6个字符
		if len<6 then
			 flag=false
		elseif len>18 then--大于18个字符 
		 	flag=false
		--全是数字或全是字符
		-- elseif string.match(textFieldpassStr,'%d')==nil or string.match(textFieldpassStr,'%d')==nil   then
		-- 	print("zmsz")
		-- 	flag=false
		end
	  self:checkInputText(self.accLogin_ui.textFieldpass,flag,click);
    end
	 
end
--检查输入文本 click 是点击注册按钮
function CAccLoginExt:checkInputText(inputNode,flag,click)
	if  not inputNode then
		return
	end
	local p=inputNode:getParent()
	local dh=p:getChildByName("dh")
	local ch=p:getChildByName("ch")
	if string.len(inputNode:getString())>0 or click then
			 dh:setVisible(flag)
			 ch:setVisible(not flag)
		else
		dh:setVisible(false)
		ch:setVisible(false)
	end
end
--帐号登陆
function CAccLoginExt:onLogin()
	local user_name = accLogin_ui.inputName:getString()
	local user_pasd = accLogin_ui.inputKey:getString()

	if user_name == "" then
		TipsManager:showOneButtonTipsPanel(101,{},true)
	elseif user_pasd == "" then
		TipsManager:showOneButtonTipsPanel(102,{},true)
	else
		local msg = {
			name 		= user_name,
			password 	= user_pasd,
			mac 		= CTools:getMacAddress()
		}

		local pinfo = get_player_info()
		pinfo.chose_login_mod = 1 --账号登陆

		local user_lst = getLoginUserInfo()
		user_lst[pinfo.chose_login_mod] = {}
		user_lst[pinfo.chose_login_mod].id = 1
		user_lst[pinfo.chose_login_mod].user_name = user_name
		user_lst[pinfo.chose_login_mod].user_code = user_pasd
		user_lst[pinfo.chose_login_mod].b_rember_code = true
		user_lst[pinfo.chose_login_mod].login_type = 1

		send_login_ReqLoginFromPhone(msg)
		print("已经发登入了！！！！！！！！！！！！！")
		WaitMessageHit.showWaitMessageHit(2)

	end
end


function CAccLoginExt:onReqRegisterKeyResult(str)
	self.msg.key = str
	print("注册验证码======================"..str)
end

function CAccLoginExt:onRecCheckAccountResult(msg)
	WaitMessageHit.closeWaitMessageHit()
	print("======================账号校验结果"..msg.res)
	if 0 == msg.res then
		self:reshTextTips("账号",true,false)
	elseif  1 == msg.res then
		TipsManager:showOneButtonTipsPanel(119, {}, true)
		--self.accLogin_ui.textFieldAccout:setString("")
		self:reshTextTips("账号",false,true)
	elseif 2 == msg.res then
		TipsManager:showOneButtonTipsPanel(200006, {}, true)
		--self.accLogin_ui.textFieldAccout:setString("")
		self:reshTextTips("账号",false,true)
	end
end

function CAccLoginExt:onRecCheckUsernameResult(msg)
	WaitMessageHit.closeWaitMessageHit()
	print("======================昵称校验结果"..msg.res)
	if 0 == msg.res then
		self:reshTextTips("昵称",true,false)
	elseif 1 == msg.res then
		--TipsManager:showOneButtonTipsPanel(119, {}, true)
		--self.accLogin_ui.textFieldNickname:setString("")
		self:reshTextTips("昵称",false,true)
	elseif 2 == msg.res then
		--TipsManager:showOneButtonTipsPanel(200007, {}, true)
		--self.accLogin_ui.textFieldNickname:setString("")
		self:reshTextTips("昵称",false,true)
		
	end

end

function CAccLoginExt:reshTextTips(node,dh,ch)
    self.nodeVisible[node].dh:setVisible(dh)
    self.nodeVisible[node].ch:setVisible(ch)
end

function CAccLoginExt:is_chinese(str)
	
	local len = string.len(str)
	local i = 1

	local bChinese = false

	while i <= len do
		local c = string.sub(str,i,i)
		local n = string.byte(c)

		if (n > 127) then
			bChinese = true
		else
			bChinese = false
		end

		--if bChinese == false then return bChinese end

		i = i + 1
	end

	return bChinese
end