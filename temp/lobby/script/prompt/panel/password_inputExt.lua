#remark
--[[
密码输入
]]

local panel_ui = require "lobby.ui_create.ui_Input_Key"
CPasswordInputExt = class("CPasswordInputExt", function ()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
	return ret
end)


function CPasswordInputExt.create()
	-- body
	local layer = CPasswordInputExt.new()
	if layer ~= nil then
		layer:regEnterExit()
		layer:init_ui()
		return layer
	end
end


function CPasswordInputExt:regEnterExit()
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

function CPasswordInputExt:onEnter()
	self:setTouchEnabled(true)
end

function CPasswordInputExt:onExit()
	TipsManager.passwordPanel = nil
end

function CPasswordInputExt:init_ui()
	
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.panel_ui = panel_ui.create()
	self:setAnchorPoint(0,0)
	self:setPosition(0,0)
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(size.width/2,size.height/2)
	self.panel_ui.root:setAnchorPoint(0,0)
end

function CPasswordInputExt:showMe(callback)
	local scene = WindowScene.getInstance()
	scene:showDlg(self)

	self.sureCallBack = callback

	self:registerHandler()
end

function CPasswordInputExt:registerHandler()
	self.panel_ui.editBox_MM:setInputTextMod(1)

	self.panel_ui.btnSure:onTouch(function (e)
		if e.name == "ended" then
			local str = self.panel_ui.editBox_MM:getStringEx()
			self.sureCallBack(str)
			global_music_ctrl.play_btn_one()
		end
	end)

	self.panel_ui.btnClose:onTouch(function (e)
		if e.name == "ended" then
			self:onHide()
			global_music_ctrl.play_btn_one()
		end
	end)
end

function CPasswordInputExt:onHide()
	local scene = WindowScene.getInstance()
	scene:closeDlg(self)
end