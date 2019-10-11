#remark
--[[
	确定、充值按钮面板
]]

local buttonPanel_ui = require "lobby.ui_create.ui_button_big_tips"
local scheduler = cc.Director:getInstance():getScheduler()

CSureOrRechagePanel = class("CSureOrRechagePanel",function()
	-- body
	local  ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
	return ret
end)

function CSureOrRechagePanel.create()
	-- body
	local layer = CSureOrRechagePanel.new()
	if layer ~= nil then
		layer:regEnterExit()
		return layer
	end
end


function CSureOrRechagePanel:regEnterExit()
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

function CSureOrRechagePanel:onEnter()
	-- body
	self:regTouchFunction()
	self:setTouchEnabled(true)
end

function CSureOrRechagePanel:onExit()
    if self.schedulerEntry then
	    scheduler:unscheduleScriptEntry(self.schedulerEntry)
    end
	self.schedulerEntry = nil
end

local function onHide(obj)
	local scene = WindowScene.getInstance()
	scene:closeDlg(obj)
end

function CSureOrRechagePanel:regTouchFunction()
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

function CSureOrRechagePanel:init_message(msgID, repArr, isShowTime, sureCallBack, cancelCallBack, arg)
	
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.buttonPanel_ui = buttonPanel_ui.create()
	self:setAnchorPoint(0,0)
	self:setPosition(0,0)
	self:addChild(self.buttonPanel_ui.root)
	self.buttonPanel_ui.root:setPosition(size.width/2,size.height/2)
	self.buttonPanel_ui.root:setAnchorPoint(0,0)


	self.buttonPanel_ui.btnCancel:setVisible(false)
	self.buttonPanel_ui.btnGold:setVisible(false)
	self.buttonPanel_ui.btnAcer:setVisible(false)
	self.buttonPanel_ui.btnSure:setVisible(false)

	
	self.arg = arg
	local function closeHandler( e )
		if e.name == "ended" then
			if cancelCallBack and e.name == "ended" then
				cancelCallBack(self.arg)
			end
			onHide(self)
			global_music_ctrl.play_btn_one()
		end
	end
	--关闭
	self.buttonPanel_ui.btnClose:onTouch(closeHandler)

	local function rechargeHandler( e )
		if e.name == "ended" then
			--冲值地址
			WindowScene.getInstance():openurl(http_address_cfg[6].http_add.. get_player_info().id)
			onHide(self)
			global_music_ctrl.play_btn_one()
		end
	end
    self.buttonPanel_ui.btnRecharge:onTouch(rechargeHandler)

	local function sureHandler( e )
		if e.name == "ended" then
			if sureCallBack then
				sureCallBack(self.arg)
			end
			onHide(self)
			global_music_ctrl.play_btn_one()
		end
	end
	self.buttonPanel_ui.btnIknow:onTouch(sureHandler)


	local info = message_config[msgID].name
	self.buttonPanel_ui.textInfo:setString(textUtils.connectParam(info, repArr))

	if isShowTime then
		self.lastTime = 10

		local function timeHandler(t)
			self.lastTime = self.lastTime - t
			local showtime = math.floor(self.lastTime)
			self.buttonPanel_ui.labIknowTime:setString(showtime)

			if self.lastTime <= 0 then
				if self.cancelCallBack then
					self.cancelCallBack(self.arg)
				end
		        onHide(self)
			end
		end
		
		self.schedulerEntry = scheduler:scheduleScriptFunc(timeHandler, 0, false)

		self.buttonPanel_ui.labIknowTime:setVisible(true)
		self.buttonPanel_ui.labIknowTime:setString(self.lastTime)
	else
		self.buttonPanel_ui.labIknowTime:setVisible(false)
	end
end

function CSureOrRechagePanel:showMe()
	-- body
	local scene = WindowScene.getInstance()
	scene:showDlg(self)
end