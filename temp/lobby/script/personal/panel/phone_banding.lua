#remark
--[[
	手机绑定项
]]

local ui_create = require "lobby.ui_create.ui_Personal_phone"

CPhoneBandingExt = class("CPhoneBandingExt",function (e)
	local obj = ccui.ImageView:create()
	obj:setScale9Enabled(true)
    obj:loadTexture("lobby/resource/general/heidi.png")
	return obj
end)


--[[
	info = {
		parent,
		pos,
	}
]]
function CPhoneBandingExt.create(info)
	local obj = CPhoneBandingExt.new()
	if obj then obj:init(info) end

	return obj
end

function CPhoneBandingExt:init(info)
	self:init_data(info)
	self:init_ui()
	self:registerHander()
	self:regEnterExit()
	self:updateUi()
end

function CPhoneBandingExt:init_data(info)
	self.parent = info.parent
	self.pos = info.pos
end

function CPhoneBandingExt:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(_onEnterOrExit)
end

function CPhoneBandingExt:onEnter()
   self:setTouchEnabled(true)
end

function CPhoneBandingExt:onExit()
	timeUtils:remove(self.ui_lst.IknowTime)
end

function CPhoneBandingExt:init_ui()
	self.parent:addChild(self)
	self:setPosition(self.pos.x,self.pos.y)
	self:setVisible(false)
	self.ui_lst = ui_create.create()
	self:addChild(self.ui_lst.root)
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.ui_lst.root:setPosition(size.width/2, size.height/2)
end


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。


function CPhoneBandingExt:updateUi()
	local pinfo    = get_player_info()
	local phoneStr = pinfo.phone

	self.ui_lst.btnget:setEnabled(true)
	self.ui_lst.btnget:setBright(true)
	self.ui_lst.IknowTime:setVisible(false)
	self.ui_lst.inputPhone_Display1:setVisible(string.len(phoneStr)~=0 and true or false)
	self.ui_lst.inputPhone_Display2:setVisible(string.len(phoneStr)~=0 and true or false)
	self.ui_lst.inputPhone:setEnabled(string.len(phoneStr)==0 and true or false)
	self.ui_lst.inputPhone:setVisible(string.len(phoneStr)==0 and true or false)
	self.ui_lst.ImagePhone:setVisible(string.len(phoneStr)==0 and true or false)
	self.ui_lst.ImagePhone_0:setVisible(string.len(phoneStr)~=0 and true or false)
	self.ui_lst.gamePhone:setVisible(string.len(phoneStr)==0 and true or false)
	self.ui_lst.inputPhone:setString("")
	self.ui_lst.inputSMS:setString("")

	if string.len(phoneStr) ~= 0 then
		local phoneStrLeft = string.sub(phoneStr,1,3)
		local phoneStrRight = string.sub(phoneStr,4,string.len(phoneStr))
		phoneStrRight = string.gsub(phoneStrRight,"(%w)","*")
		self.ui_lst.inputPhone_Display1:setString(phoneStrLeft)
		self.ui_lst.inputPhone_Display2:setString(phoneStrRight)
	end
end

--开始倒计时  
function CPhoneBandingExt:startTimeDown(time)
	self:removeCountDown()
	self.ui_lst.btnget:setEnabled(false)
	self.ui_lst.btnget:setBright(false)
	self.ui_lst.IknowTime:setString(tostring(time))
	self.ui_lst.IknowTime:setVisible(true)
	timeUtils:addTimeDown(self.ui_lst.IknowTime, time, function ( t ) self:timeCallBackHandler(t) end,
		function() self:timeEndCallBack() end)
end

--倒计时回调函数
function CPhoneBandingExt:timeCallBackHandler(time)
	local showtime = math.ceil(time)
	self.ui_lst.IknowTime:setString(tostring(showtime))
end

--倒计时结束回调函数
function CPhoneBandingExt:timeEndCallBack()
	self.ui_lst.btnget:setEnabled(true)
	self.ui_lst.btnget:setBright(true)
	self.ui_lst.IknowTime:setVisible(false)
end

function CPhoneBandingExt:registerHander()
	self.ui_lst.btnget:onTouch(function (e) self:onGetSMSCode(e) end) 
	self.ui_lst.btnSure:onTouch(function (e) self:onConfirmClick(e) end)

	self.ui_lst.btnClose:onTouch(function (e)
		if e.name == "ended" then
			self:setVisible(false)
			global_music_ctrl.play_btn_one()
		end
	end)
end

function CPhoneBandingExt:onGetSMSCode(e)
	if e.name == "ended" then
		global_music_ctrl.play_btn_one()
		local pinfo 	= get_player_info()
		local phoneStr  = pinfo.phone
		if string.len(phoneStr) == 0 then
			local phoneNumStr = self.ui_lst.inputPhone:getString()
			local firstNum = string.sub(phoneNumStr,1,1)
			if string.len(phoneNumStr) == 11 and tonumber(firstNum) == 1 then
				send_personalcenter_ReqGetBindPhoneKey({phone = phoneNumStr})
				self:startTimeDown(60)
			else
				TipsManager:showOneButtonTipsPanel(506, {}, true)
			end
		else
			send_personalcenter_ReqGetUnBindPhoneKey()
			self:startTimeDown(60)
		end
	end
end

function CPhoneBandingExt:onConfirmClick(e)
	if e.name == "ended" then
		global_music_ctrl.play_btn_one()
		local SMSCode = self.ui_lst.inputSMS:getString()
		if string.len(SMSCode) ~= 0 then
			local pinfo 	= get_player_info()
			local phoneStr  = pinfo.phone
			if string.len(phoneStr) == 0 then
				send_personalcenter_ReqBindPhone({key = SMSCode})
			else
				send_personalcenter_ReqUnBindPhone({key = SMSCode})
			end
		else
			TipsManager:showOneButtonTipsPanel(108, {}, true)
		end

	end
end

function CPhoneBandingExt:onShow()
	self:updateUi()
	self:setVisible(true)
end

function CPhoneBandingExt:onHide()
	self:setVisible(false)
	timeUtils:remove(self.ui_lst.IknowTime)
end

function CPhoneBandingExt:removeCountDown()
	timeUtils:remove(self.ui_lst.IknowTime)
end

function CPhoneBandingExt:resetTime(t)
	self:removeCountDown()
	self:startTimeDown(t)
end
