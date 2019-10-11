#remark
--[[
	登陆场景
]]
local login_main_ui

CLoginScene = class("CLoginScene",function()
	local  ret = cc.Layer:create()
	return ret
end
)
ModuleObjMgr.add_module_obj(CLoginScene,"CLoginScene")

function CLoginScene.create()

	local layer = CLoginScene.new()
	if layer ~= nil then
		layer:init_ui()

		return layer
	end
end

function CLoginScene:init_ui()
	login_main_ui = require("lobby.ui_create.ui_Login").create()
	self:addChild(login_main_ui.root)

	self:registerHandler()
	self:registerEnterExit()

	-- self.act = sp.SkeletonAnimation:create(spine_login_cfg[1].jsonPath,spine_login_cfg[1].atlasPath,spine_login_cfg[1].scale)
	-- self.act:setPosition(600.0000,180.0000)
	-- login_main_ui.nodeCard:addChild(self.act)

	local sprite = cc.Sprite:create("update/resource/js.png")
	sprite:setPosition(530.0000,465.0000)
	login_main_ui.nodeCard:addChild(sprite)

end

function CLoginScene:registerEnterExit()

	local function _onEnterOrExit(event)
		if event == "enter" then
			self:onEnter()
		elseif event == "enterTransitionFinish" then
			self:onEnterFinished()
		elseif event == "exit" then
			self:onExit()
		end
		print(event)
	end

	self:registerScriptHandler(_onEnterOrExit)
end

function CLoginScene:onEnterFinished()
	
	readUserNameLst()
	
	AudioEngine.playMusic("common/prop/music/bj1.mp3",true)
end


 --注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码

 function CLoginScene:test(interval)
	print("==============="..interval)
end

function CLoginScene:registerHandler()

	local function __on_login_click(e)
		if e.name == "ended" then 

--			self.tempnode:runAction(cc.Lens3D:create(1.0, cc.size(200,200),cc.p(960,540), 400))

			-- local PageViewRank = ccui.Layout:create()
			-- PageViewRank:setLayoutComponentEnabled(true)
			-- PageViewRank:setPosition(960/2, 540/2)
			-- PageViewRank:setContentSize(500,500)
			-- self.tempnode:addChild(PageViewRank)
			
			-- local spritetemp1 = cc.Sprite:create("lobby/resource/login_res/dl.png")
			-- spritetemp1:setPosition(spritetemp1:getContentSize().width/2, 100)
			-- PageViewRank:addChild(spritetemp1)

			-- local spritetemp2 = cc.Sprite:create("lobby/resource/login_res/dl.png")
			-- spritetemp2:setPosition(spritetemp2:getContentSize().width/2*3, 200)
			-- PageViewRank:addChild(spritetemp2)

			-- local spritetemp3 = cc.Sprite:create("lobby/resource/login_res/dl.png")
			-- spritetemp3:setPosition(spritetemp3:getContentSize().width/2*5, 300)
			-- PageViewRank:addChild(spritetemp3)

			-- local function handler(interval)
			-- 	local speed = 10
			-- 	local temp1 = spritetemp1:getPositionY()
			-- 	spritetemp1:setPositionY(temp1-13-speed)
			-- 	if temp1<=-PageViewRank:getContentSize().height then
			-- 		spritetemp1:setPositionY(500)
			-- 	end

			-- 	local temp2 = spritetemp2:getPositionY()
			-- 	spritetemp2:setPositionY(temp2-10-speed)
			-- 	if temp2<=-PageViewRank:getContentSize().height then
			-- 		spritetemp2:setPositionY(500)
			-- 	end

			-- 	local temp3 = spritetemp3:getPositionY()
			-- 	spritetemp3:setPositionY(temp3-15-speed)
			-- 	if temp3<=-PageViewRank:getContentSize().height then
			-- 		spritetemp3:setPositionY(500)
			-- 	end
			-- end
		
			-- self:scheduleUpdateWithPriorityLua(handler,1);
			
			self:onLogin()
			
			global_music_ctrl.play_btn_one() 
		end
	end
	login_main_ui.btnAccLogin:onTouch(__on_login_click) --帐号登录

	local targetPlatform = cc.Application:getInstance():getTargetPlatform()

	if targetPlatform == cc.PLATFORM_OS_ANDROID  then
	
		login_main_ui.btnSmall:setVisible(false)
		login_main_ui.btnExit:setVisible(false)

		--login_main_ui.btnTouristLogin:setVisible(false)
		--login_main_ui.btnWechatLogin:setVisible(true)

	elseif targetPlatform == cc.PLATFORM_OS_IPHONE then

		login_main_ui.btnSmall:setVisible(false)
		login_main_ui.btnExit:setVisible(false)
	
		login_main_ui.btnWechatLogin:setVisible(false)
		login_main_ui.btnTouristLogin:setVisible(false)
		--login_main_ui.btnAccLogin:setPositionY(login_main_ui.btnAccLogin:getPositionY()+100)
	elseif targetPlatform == cc.PLATFORM_OS_WINDOWS then

		login_main_ui.btnWechatLogin:setVisible(false)
	else
		login_main_ui.btnSmall:setVisible(false)
		login_main_ui.btnExit:setVisible(false)
	end

	login_main_ui.btnSmall:setLocalZOrder(10000)
	login_main_ui.btnExit:setLocalZOrder(10000)

	--注册最小化事件
	login_main_ui.btnSmall:onTouch(function (e) 
		WindowModule.show_window(enum_win_show_mod.mod_mini)
	end)

	--注册关闭窗口事件
	login_main_ui.btnExit:onTouch(function (e)
		WindowScene.getInstance():closeWindow()
	end)

	login_main_ui.btnTouristLogin:onTouch(function (e) --手机登录
		if e.name == "ended" then

			local pinfo = get_player_info()
			pinfo.chose_login_mod = 3 --手机登录
		
			local user_lst = getLoginUserInfo()
			if user_lst[pinfo.chose_login_mod] then
		
				local msg = {
					name 		= user_lst[pinfo.chose_login_mod].user_name or "",
					password 	= user_lst[pinfo.chose_login_mod].user_code or "",
					mac 		= CTools:getMacAddress() or "",
				}


				print("============="..msg.name)
				print("============="..msg.password)
		
				if msg.name ~= ""  then

					pinfo.user_name = msg.name

					if msg.password ~= "" then

						pinfo.user_name = msg.password

						send_login_ReqLoginFromPhone(msg)
						return
					else

						local msgPW = {
							phoneNumber = msg.name,
							flag = 0,
							mac = CTools:getMacAddress(),
						}
						send_login_ReqPhoneLogin(msgPW)
						return
					end
				end
			end

			WindowScene.getInstance():showDlgByName("PhoneLogin")

			-- local username = ""

            -- local user_lst = getLoginUserInfo()
	        -- if #user_lst > 0 then
		    --    if user_lst[1].login_type == 0 then   -- 游客登录，取出保存的用户名
		    --    	  username = user_lst[1].user_name
		    --    end
	        -- end

			-- send_login_ReqTouristLogin({mac = CTools:getMacAddress(), account = username})
			-- WaitMessageHit.showWaitMessageHit(2)
			-- global_music_ctrl.play_btn_one()
			-- local pinfo = get_player_info()
			-- pinfo.chose_login_mod = 1 --游客登陆
		end
	end)

	login_main_ui.btnWechatLogin:onTouch(function(e)
		
		if e.name == "ended" then
			local targetPlatform = cc.Application:getInstance():getTargetPlatform()

			if targetPlatform == cc.PLATFORM_OS_ANDROID  then
				self:WXLoginAndroid()
			elseif targetPlatform == cc.PLATFORM_OS_IPHONE or targetPlatform == cc.PLATFORM_OS_IPAD then
				self:WXLoginIOS()
			end
			
			global_music_ctrl.play_btn_one()
	    end
	end)
end

function CLoginScene:WXLoginIOS()
    WaitMessageHit.showWaitMessageHit(2)
    local luaoc = require("cocos.cocos2d.luaoc")

    local className = "AppController"

    local methodName = "WXLogin"

    local function callback(arg)

        local pinfo = get_player_info()
        pinfo.chose_login_mod = 2 --微信登陆

        if arg.result == "failed" then
            WaitMessageHit.closeWaitMessageHit()
            return
        end

        local msg = {
            mac = CTools:getMacAddress(),
            platform = "wechatLogin",
            unionid = arg.openid,
            nickname = arg.openid,
        }

        if msg.unionid ~= "" and msg.nickname ~= "" then
            local user_lst = getLoginUserInfo()
            user_lst[pinfo.chose_login_mod] = {}
            user_lst[pinfo.chose_login_mod].id = 1
            user_lst[pinfo.chose_login_mod].user_name = msg.nickname
            user_lst[pinfo.chose_login_mod].user_code = msg.unionid
            user_lst[pinfo.chose_login_mod].b_rember_code = true
            user_lst[pinfo.chose_login_mod].login_type = 2
            send_login_ReqLoginFromWechat(msg)

        else
            WaitMessageHit.closeWaitMessageHit()
        end

    end

    local args = {func = callback,arg1 = "1234" }
    local ok = luaoc.callStaticMethod(className, methodName,args)
    if not ok then
        print("=============================failed")
    end

end

function CLoginScene:regResultPro(msg)
	local obj = WindowScene.getInstance():getDlgByName("CAccLoginExt")
	if obj then
		obj:register_result(msg)
	end
end

function CLoginScene:onLogin()
	WindowScene.getInstance():showDlgByName("CAccLoginExt")
end

function CLoginScene:onEnter()
	-- if self.act then
	-- 	self.act:setAnimation(0,spine_login_cfg[1].actName1,true)
	-- end
end

function CLoginScene:onExit()
end

--[[
	刷新注册图片验证码结果消息
	msg = {
		名称:picKey 类型:String 备注:图片验证码
	}
]]
function CLoginScene:onReqRegisterKey(msg)
	local obj = WindowScene.getInstance():getDlgByName("CAccLoginExt")
	if obj then
		obj:onReqRegisterKeyResult(msg.picKey)
	end
end
--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码
--[[
	校验用户名结果消息
	msg = {
		名称:res 类型:int 备注:0:成功即该用户名可以注册,1:用户名已经存在,2:格式错误
	}
]]
function CLoginScene:onRecCheckAccount(msg)

	local obj = WindowScene.getInstance():getDlgByName("CAccLoginExt")
	if obj then
		obj:onRecCheckAccountResult(msg)
	end
end


--[[
	校验用户昵称结果消息
	msg = {
		名称:res 类型:int 备注:0:成功即该用户名可以注册,1:昵称已经存在,2:格式错误
	}
]]
function CLoginScene:onRecCheckUsername(msg)
	
	local obj = WindowScene.getInstance():getDlgByName("CAccLoginExt")
	if obj then
		obj:onRecCheckUsernameResult(msg)
	end
end

--[[
	手机密码
	msg = {
		名称:password 类型:string 备注:密码
		名称:verificationCode 类型:string 备注:验证码
		名称:result 类型:int 备注:短信结果
	}
]]
function CLoginScene:onRecPhoneLoginPassword(msg)

	if msg.password and msg.password ~= "" then
		
		local pinfo = get_player_info()
		pinfo.password = msg.password
		pinfo.chose_login_mod = 3 --手机登陆

		local user_lst = getLoginUserInfo()
		user_lst[pinfo.chose_login_mod] = {}
		user_lst[pinfo.chose_login_mod].id = 1
		user_lst[pinfo.chose_login_mod].user_name = pinfo.user_name
		user_lst[pinfo.chose_login_mod].user_code = pinfo.password
		user_lst[pinfo.chose_login_mod].b_rember_code = true
		user_lst[pinfo.chose_login_mod].login_type = 3

		local msgPW ={
			phoneNumber = pinfo.user_name,
			flag = 0,
			key = pinfo.password,
			mac = CTools:getMacAddress(),
		}

		send_login_ReqLoginByPhoneKey(msgPW)
	end
	
	-- local obj = WindowScene.getInstance():getDlgByName("PhoneLogin")
	-- if obj then
	-- 	obj:onRecPhoneLoginPassword(msg)
	-- end
end

function CLoginScene:WXLoginAndroid()
	WaitMessageHit.showWaitMessageHit(2)
	print("===WXLogin")

	self:add_WXLogin_callback()

	local WXInfo={
		["nickname"] ={value="",},
		["openid"] ={value="",},
		["sex"] ={value="",},
		["headimgurl"] ={value="",},
	}

	self.WXInfo=WXInfo
    local luaj = require "cocos.cocos2d.luaj"
    local className = "org/cocos2dx/lua/AppActivity"
	-- body
   local args = { "callbacklua", func }
   local sigs = "()V"
   local ok = luaj.callStaticMethod(className,"WXLogin",nil,sigs)
   if not ok then
       print("============= call callback error")
   else
       print("------------- call callback success")
   end
end

function CLoginScene:add_WXLogin_callback()

	local flagT = {"nickname","openid","sex","headimgurl"}

	local function WXLogin_callback(result)

		if "finish"==result then
			 local pinfo = get_player_info()
			 pinfo.chose_login_mod = 2 --微信登陆
			local msg = {
				mac = CTools:getMacAddress(), 
				platform = "wechatLogin", 
				unionid = self.WXInfo["openid"].value, 
				nickname = self.WXInfo["nickname"].value,}
				-- local Text_content = ccui.Text:create()
				-- Text_content:setFontSize(34)
				-- Text_content:setString(msg.unionid..msg.nickname)
				-- Text_content:setPosition(500.0000, 300.0000)
				-- login_main_ui.root:addChild(Text_content)

				if msg.unionid ~= "" and msg.nickname ~= "" then
					local user_lst = getLoginUserInfo()
					user_lst[pinfo.chose_login_mod] = {}
					user_lst[pinfo.chose_login_mod].id = 1
					user_lst[pinfo.chose_login_mod].user_name = msg.nickname
					user_lst[pinfo.chose_login_mod].user_code = msg.unionid
					user_lst[pinfo.chose_login_mod].b_rember_code = true
					user_lst[pinfo.chose_login_mod].login_type = 2
					send_login_ReqLoginFromWechat(msg)

				else
					WaitMessageHit.closeWaitMessageHit()
				end
		elseif "failed"==result then
			local bk_hit_obj = BlackMessageHit.create({txt = "请安装微信",color = cc.c3b(255,255,255),})
			WindowScene.getInstance():showDlg(bk_hit_obj)
			WaitMessageHit.closeWaitMessageHit()
		else
			for k,v in pairs(flagT) do
				local str = string.split(result,v)
				if nil ~= str[2] then
					self.WXInfo[v].value = str[2]
				end
			end
		end
	end

    local luaj = require "cocos.cocos2d.luaj"
    local className = "org/cocos2dx/lua/AppActivity"
	-- body
   local args = { "WXLogin_callback", WXLogin_callback }
   local sigs = "(Ljava/lang/String;I)V"
   local ok = luaj.callStaticMethod(className,"WXLogin_callback",args,sigs)
   if not ok then
       print("============= call callback error")
   else
       print("------------- call callback success")
   end
end

function CLoginScene:Split(szFullString, szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	while true do
	   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
	   if not nFindLastIndex then
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
		break
	   end
	   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
	   nFindStartIndex = nFindLastIndex + string.len(szSeparator)
	   nSplitIndex = nSplitIndex + 1
	end
	return nSplitArray
end
