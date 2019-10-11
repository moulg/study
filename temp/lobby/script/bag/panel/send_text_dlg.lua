#remark
--[[
	发送文字对话框
]]

local ui_create = require "lobby.ui_create.ui_horm"

SendTextDlg = class("SendTextDlg",function ()
	local obj = cc.Layer:create()
	return obj
end)

--[[
	info = {
		type 0 -> 大喇叭，1 -> 小喇叭,
		send_call,
		send_param,
		close_call,
	}
]]
function SendTextDlg.create(info)
	local obj = SendTextDlg.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function SendTextDlg:init(info)
	self.create_info = info
	self:init_ui()
	self:registerEE()
	self:registerTouchEvent()
end

function SendTextDlg:init_ui()
	self.ui_lst = ui_create.create()
	self:addChild(self.ui_lst.root)

	self.ui_lst.btnSend:onTouch(function (e)
		self:onSendClick(e)
	end)

	self.ui_lst.btnClose:onTouch(function (e)
		if e.name == "ended" then 
			self:onCloseClick()
		end
	end)

	self.ui_lst.input:setInputMaxLen(50)
	
	--self.ui_lst.imgBig:setVisible(false)
	--self.ui_lst.imgSmall:setVisible(false)

	-- if self.create_info.type == 0 then
	-- 	self.ui_lst.imgBig:setVisible(true)
	-- else
	-- 	self.ui_lst.imgSmall:setVisible(true)
	-- end
end

function SendTextDlg:registerTouchEvent()
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

function SendTextDlg:registerEE()
	local function __enter_exit(e)
		if e == "enter" then
			self:onEnter()
		elseif e == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__enter_exit)
end

function SendTextDlg:onEnter()
	
end

function SendTextDlg:onExit()
	--WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_list.btnItem)
end

function SendTextDlg:doModule(pos)
	self:setPosition(pos.x,pos.y)
	WindowScene.getInstance():showDlg(self)
end

function SendTextDlg:close()
	if self.create_info.close_call then
		self.create_info.close_call()
	end
	WindowScene.getInstance():closeDlg(self)
end

function SendTextDlg:onSendClick(e)
	if e.name == "ended" then
		global_music_ctrl.play_btn_one()
		local str = string.trim(self.ui_lst.input:getStringEx())
		local asy_ret = ansy_string(str)
		local wide_len = 0
		for k,v in pairs(asy_ret.ch_lst) do
			 wide_len = wide_len + v.wide_len 
		end
		
		if wide_len == 0 then
			return
		elseif wide_len > 50 then
			TipsManager:showOneButtonTipsPanel(526, {}, true)
		else
			if self.create_info.send_call then
				self.create_info.send_call(self.create_info.send_param,self.create_info.type,str)
			end
			self:close()
		end
	end
end

function SendTextDlg:onCloseClick()
	self:close()
	global_music_ctrl.play_btn_one()
end

