#remark
--[[
	确定按钮面板
]]

local buttonPanel_ui = require "lobby.ui_create.ui_one_button_tips"

ConeButtonPanel = class("ConeButtonPanel",function()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
    return ret
end)

function ConeButtonPanel.create()
	-- body
	local layer = ConeButtonPanel.new()
	if layer ~= nil then
		layer:regEnterExit()
		return layer
	end
end


function ConeButtonPanel:regEnterExit()
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

function ConeButtonPanel:onEnter()
	WaitMessageHit.closeWaitMessageHit()
	self:setTouchEnabled(true)
end

function ConeButtonPanel:onExit()
  
end

function ConeButtonPanel:init_message(msgID, repArr, isShowTime, sureCallBack, cancelCallBack, arg)
	
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.buttonPanel_ui = buttonPanel_ui.create()
	self:setAnchorPoint(0,0)
	self:setPosition(0,0)
	self:addChild(self.buttonPanel_ui.root)
	self.buttonPanel_ui.root:setPosition(size.width/2,size.height/2)
	self.buttonPanel_ui.root:setAnchorPoint(0,0)

	self.arg = arg
	self.cancelCallBack = cancelCallBack
	local function closeHandler( e )
		if e.name == "ended" then
			if cancelCallBack then
				cancelCallBack(self.arg)
			end
			WindowScene.getInstance():closeDlg(self)
			global_music_ctrl.play_btn_one()
		end
	end
	--返回
	self.buttonPanel_ui.btnClose:onTouch(closeHandler)

	local function sureHandler( e )
		if e.name == "ended" then
			if sureCallBack then
				sureCallBack(self.arg)
			end
			WindowScene.getInstance():closeDlg(self)
			global_music_ctrl.play_btn_one()
		end
	end
	self.buttonPanel_ui.btnSure:onTouch(sureHandler)

	local info = message_config[msgID].name
	if repArr then
		self.buttonPanel_ui.testMessage:setString(textUtils.connectParam(info, repArr))
	end
end
