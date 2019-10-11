#remark
--[[
	两种价格选择面板
]]

local buttonPanel_ui = require "lobby.ui_create.ui_button_big_tips"

CTwoPricePanel = class("CTwoPricePanel",function()
	-- body
	local  ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
	return ret
end)

function CTwoPricePanel.create()
	-- body
	local layer = CTwoPricePanel.new()
	if layer ~= nil then
		layer:regEnterExit()
		return layer
	end
end


function CTwoPricePanel:regEnterExit()
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

function CTwoPricePanel:onEnter()
	-- body
	self:regTouchFunction()
	self:setTouchEnabled(true)
end

function CTwoPricePanel:onExit()
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.buttonPanel_ui.btnClose)
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.buttonPanel_ui.btnGold)
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.buttonPanel_ui.btnAcer)
end

function CTwoPricePanel:regTouchFunction()
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

function CTwoPricePanel:init_message(msgID, callBack, arg)
	
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.buttonPanel_ui = buttonPanel_ui.create()
	self:setAnchorPoint(0,0)
	self:setPosition(0,0)
	self:addChild(self.buttonPanel_ui.root)
	self.buttonPanel_ui.root:setPosition(size.width/2,size.height/2)
	self.buttonPanel_ui.root:setAnchorPoint(0,0)


	self.buttonPanel_ui.btnRecharge:setVisible(false)
	self.buttonPanel_ui.btnCancel:setVisible(false)
	self.buttonPanel_ui.btnSure:setVisible(false)
	self.buttonPanel_ui.btnIknow:setVisible(false)

	--注册高亮
	local mov_obj = cc.Sprite:create("lobby/resource/button/gb2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.buttonPanel_ui.btnClose,mov_obj,1)
	local mov_obj = cc.Sprite:create("lobby/resource/button/jbgm2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.buttonPanel_ui.btnGold,mov_obj,1)
	local mov_obj = cc.Sprite:create("lobby/resource/button/ybgm2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.buttonPanel_ui.btnAcer,mov_obj,1)

	self.arg = arg

	--按钮事件
	local function sureHandler( e )
		if e.name == "ended" then
			if callBack then
				if e.target == self.buttonPanel_ui.btnAcer then
					callBack(1)
				else
					callBack(2)
				end
				
			end
			self:onHide()
			global_music_ctrl.play_btn_one()
		end
	end
	self.buttonPanel_ui.btnGold:onTouch(sureHandler)
	self.buttonPanel_ui.btnAcer:onTouch(sureHandler)

	local info = message_config[msgID].name
	self.buttonPanel_ui.textInfo:setString(info)

	self.buttonPanel_ui.btnClose:onTouch(function (e)
		if e.name == "ended" then
			-- body
			self:onHide()
			global_music_ctrl.play_btn_one()
		end
	end)

end

function CTwoPricePanel:showMe()
	-- body
	local scene = WindowScene.getInstance()
	scene:showDlg(self)
end

function CTwoPricePanel:onHide()
	local scene = WindowScene.getInstance()
	scene:closeDlg(self)
end