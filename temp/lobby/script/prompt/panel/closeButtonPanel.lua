#remark
--[[
	切换账号、关闭大厅、取消按钮面板
]]

local buttonPanel_ui = require "lobby.ui_create.ui_close"
local scheduler = cc.Director:getInstance():getScheduler()

CloseButtonPanel = class("CloseButtonPanel",function()
	-- body
	local  ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
	return ret
end)

function CloseButtonPanel.create()
	-- body
	local layer = CloseButtonPanel.new()
	if layer ~= nil then
		layer:regEnterExit()
		return layer
	end
end


function CloseButtonPanel:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter();
		elseif event == "exit" then
			self:onExit();
		end
	end

	self:registerScriptHandler(_onEnterOrExit)
end

function CloseButtonPanel:onEnter()
	-- body
	self:regTouchFunction()
	self:setTouchEnabled(true)
end

function CloseButtonPanel:onExit()
	scheduler:unscheduleScriptEntry(self.schedulerEntry)
	self.schedulerEntry = nil

	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.buttonPanel_ui.BtnClose)
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.buttonPanel_ui.BtnChange)
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.buttonPanel_ui.BtnSure)
end

function CloseButtonPanel:regTouchFunction()
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
	local scene = WindowScene.getInstance()
	scene:closeDlg(obj)
end

function CloseButtonPanel:init_message(isShowTime, changeCallBack, cancelCallBack, closeCallback, arg)
	
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.buttonPanel_ui = buttonPanel_ui.create()
	self:setAnchorPoint(0,0)
	self:setPosition(0,0)
	self:addChild(self.buttonPanel_ui.root)
	self.buttonPanel_ui.root:setPosition(size.width/2,size.height/2)
	self.buttonPanel_ui.root:setAnchorPoint(0,0)

	--注册高亮
	local mov_obj = cc.Sprite:create("lobby/resource/button/gb2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.buttonPanel_ui.BtnClose,mov_obj,1)
	local mov_obj = cc.Sprite:create("lobby/resource/close/qhzh2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.buttonPanel_ui.BtnChange,mov_obj,1)
	local mov_obj = cc.Sprite:create("lobby/resource/close/gbdt2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.buttonPanel_ui.BtnSure,mov_obj,1)
	
	self.arg = arg
	--取消
	local function cancelHandler( e )
		if e.name == "ended" then 
			if cancelCallBack then
				cancelCallBack(self.arg)
			end
			onHide(self)
			global_music_ctrl.play_btn_one()
		end
	end
	self.buttonPanel_ui.BtnClose:onTouch(cancelHandler)
    self.buttonPanel_ui.btnReturn:onTouch(cancelHandler)
    --切换账号
	local function changeHandler( e )
		if e.name == "ended" then
			if changeCallBack then
				changeCallBack(self.arg)
			end
            onHide(self)
            global_music_ctrl.play_btn_one()
		end
	end
	self.buttonPanel_ui.BtnChange:onTouch(changeHandler)
	--关闭大厅
	local function closeHandler( e )
		if e.name == "ended" then
			if closeCallback then
				closeCallback(self.arg)

			end
			global_music_ctrl.play_btn_one()
            --onHide(self)
		end
	end
	self.buttonPanel_ui.BtnSure:onTouch(closeHandler)


	-- local info = message_config[msgID].name
	-- self.buttonPanel_ui.textInfo:setString(textUtils.connectParam(info, repArr))

	if isShowTime then
		self.lastTime = 10

		local function timeHandler(t)
			self.lastTime = self.lastTime - t
			local showtime = math.floor(self.lastTime)
			self.buttonPanel_ui.ReturnTime:setString(showtime)

			if self.lastTime <= 0 then
				if self.cancelCallBack then
					self.cancelCallBack(self.arg)
				end
		        onHide(self)
			end
		end
		
		self.schedulerEntry = scheduler:scheduleScriptFunc(timeHandler, 0, false)

		self.buttonPanel_ui.ReturnTime:setVisible(true)
		self.buttonPanel_ui.ReturnTime:setString(self.lastTime)
	else
		self.buttonPanel_ui.ReturnTime:setVisible(false)
	end
end


function CloseButtonPanel:showMe()
	-- body
	local scene = WindowScene.getInstance()
	scene:showDlg(self)
	local size = scene:getScaleSize()
	self.buttonPanel_ui.root:setScale(1/size.x, 1/size.y)
end