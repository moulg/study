#remark
--[[
	等待网络消息提示界面
]]

local __ui_create = require "lobby.ui_create.ui_connectServer"

WaitMessageHit = class("WaitMessageHit",function ()
	local size = WindowScene.getInstance():getDesSize()
	local obj = cc.LayerColor:create(cc.c4b(0,0,0,100),size.w,size.h)
	return obj
end)


function WaitMessageHit.create()
	local obj = WaitMessageHit.new()
	if obj then
		obj:init()
	end

	return obj
end

function WaitMessageHit:init()
	self.ui_lst = __ui_create.create()
	self:addChild(self.ui_lst.root)
	local size = WindowScene.getInstance():getDesSize()
	self.ui_lst.root:setPosition(size.w/2,size.h/2)

	self.ui_lst.ljffq_2:runAction(cc.RepeatForever:create(cc.RotateBy:create(1,180)))

	self:registerTouchEvent()
	self:registerEE()
end

function WaitMessageHit:registerTouchEvent()
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

function WaitMessageHit:registerEE()
	local function __enter_exit(e)
		if e == "enter" then
			self:onEnter()
		elseif e == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__enter_exit)
end

function WaitMessageHit:onExit()
	
end

function WaitMessageHit:onEnter()
	
end

--全局调用函数
--[[
	type：1默认方式 2旋转动画
]]

local __wait_message = nil

function WaitMessageHit.showWaitMessageHit(type)
	if __wait_message == nil then
		__wait_message = WaitMessageHit.create()
		if type == 2 then
			__wait_message.ui_lst.ljffq_2:setVisible(true)
			__wait_message.ui_lst.ljffq_1:setVisible(false)
		elseif type == 1 then
			__wait_message.ui_lst.ljffq_2:setVisible(false)
			__wait_message.ui_lst.ljffq_1:setVisible(true)
		end

		WindowScene.getInstance():showDlg(__wait_message)
	end
end

function WaitMessageHit.closeWaitMessageHit()
	if __wait_message then
		WindowScene.getInstance():closeDlg(__wait_message)
		__wait_message = nil
	end
end

