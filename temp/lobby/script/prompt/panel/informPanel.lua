#remark
--[[
	通知面板
]]

local buttonPanel_ui = require "lobby.ui_create.ui_bomb_box"
local scheduler = cc.Director:getInstance():getScheduler()

CInformPanel = class("CInformPanel",function()
	local ret = cc.Node:create()
    return ret
end)

function CInformPanel.create()
	-- body
	local layer = CInformPanel.new()
	if layer ~= nil then
		layer:regEnterExit()
		return layer
	end
end


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

function CInformPanel:regEnterExit()
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

function CInformPanel:onEnter()
	self:regTouchFunction()
end

function CInformPanel:onExit()
    if self.schedulerEntry then
	    scheduler:unscheduleScriptEntry(self.schedulerEntry)
    end
	self.schedulerEntry = nil

	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.buttonPanel_ui.btn_close)
end

function CInformPanel:regTouchFunction()
	-- body
    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        return self:ccTouchBegan(location.x,location.y)
    end

    local function onTouchMoved(touch, event)
        local location = touch:getLocation()
        return self:ccTouchMoved(location.x,location.y)
    end

    local function onTouchEnded(touch, event)
        local location = touch:getLocation()
        return self:ccTouchEnded(location.x,location.y)
    end
    
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)

end

local function onHide(obj)
	local action1 = cc.FadeOut:create(1)
	local seq_arr = {}
	table.insert(seq_arr,action1)

	local function dipose(node)
		local scene = WindowScene.getInstance()
		scene:closeDlg(obj)	
	end

	local call_action = cc.CallFunc:create(dipose)
	table.insert(seq_arr,call_action)	
	local seq = cc.Sequence:create(seq_arr)

	obj.buttonPanel_ui.img_bj:runAction(seq)
end

function CInformPanel:init_message(msgID, repArr)
	local size = WindowModule.get_window_size()
	self.buttonPanel_ui = buttonPanel_ui.create()
	self:setPosition(size.width,0)
	self:addChild(self.buttonPanel_ui.root)

	--注册高亮
	local mov_obj = cc.Sprite:create("lobby/resource/button/gbtc2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.buttonPanel_ui.btn_close,mov_obj,1)

	local function closeHandler( e )
		if e.name == "ended" then
			onHide(self)
			global_music_ctrl.play_btn_one()
		end
	end
	--返回
	self.buttonPanel_ui.btn_close:onTouch(closeHandler)

	local info = message_config[msgID].name
	if repArr then
		self.buttonPanel_ui.text_message:setString(textUtils.connectParam(info, repArr))
	end

	self.lastTime = 5

	local function timeHandler(t)
		self.lastTime = self.lastTime - t

		if self.lastTime <= 0 then
	        onHide(self)
		end
	end
	
	self.schedulerEntry = scheduler:scheduleScriptFunc(timeHandler, 0, false)

end


function CInformPanel:showMe()
	-- body
	local scene = WindowScene.getInstance()                         
	scene:showDlg(self)
	local size = scene:getScaleSize()
	self.buttonPanel_ui.root:setScale(1/size.x, 1/size.y)

	self.buttonPanel_ui.img_bj:runAction(cc.FadeIn:create(1))
end