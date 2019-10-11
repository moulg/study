--[[
	结算面板
]]

local panel_ui = require "game.shuihu_std.script.ui_create.ui_settle_accounts"

CShuiHuSettleAccounts = class("CShuiHuSettleAccounts",function()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
    return ret
end)

function CShuiHuSettleAccounts.create()
	-- body
	local layer = CShuiHuSettleAccounts.new()
	if layer ~= nil then
		layer:regEnterExit()
		layer:init_ui()
		return layer
	end
end


function CShuiHuSettleAccounts:regEnterExit()
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

function CShuiHuSettleAccounts:onEnter()
	--防止穿透
	self:setTouchEnabled(true)
end

function CShuiHuSettleAccounts:onExit()
	timeUtils:remove(self)
end


function CShuiHuSettleAccounts:onShow(isCompare, overCallBack, compareCallBack)
	if isCompare then
		self.panel_ui.btnCompare:setVisible(false)
		self.panel_ui.btnContinue:setVisible(true)

		self.panel_ui.fntChips:setString("w "..shuihu_manager._diceCurWin)
	else
		self.panel_ui.btnCompare:setVisible(true)
		self.panel_ui.btnContinue:setVisible(false)

		self.panel_ui.fntChips:setString("w "..shuihu_manager._shuiHuCurWin)
	end

	self.overCallBack = overCallBack
	self.compareCallBack = compareCallBack

	self:setVisible(true)

	timeUtils:addTimeDown(self, 30, nil, function ()
		self:onHide()

		--结算
		shuihu_manager:reqSettleCountsGame()

		if self.overCallBack then
			self.overCallBack()
		end
	end)
end

function CShuiHuSettleAccounts:onHide()
	timeUtils:remove(self)
	
	self:setVisible(false)

	shuihu_manager:showWordTips( 2 )
end

function CShuiHuSettleAccounts:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.root:setPosition(size.width/2,size.height/2)

	self:registerHandler()
end

function CShuiHuSettleAccounts:registerHandler()
	self.panel_ui.btnOver:onTouch(function (e)
		if e.name == "ended" then
			self:onHide()

			--结算
			shuihu_manager:reqSettleCountsGame()

			--音效
			audio_manager:playOtherSound(37)
			
			if self.overCallBack then
				self.overCallBack()
			end
		end
	end)

	self.panel_ui.btnCompare:onTouch(function (e)
		if e.name == "ended" then
			self:onHide()
			
			if self.compareCallBack then
				self.compareCallBack()
			end
		end
	end)

	self.panel_ui.btnContinue:onTouch(function (e)
		if e.name == "ended" then
			self:onHide()
			
			if self.compareCallBack then
				self.compareCallBack()
			end
		end
	end)
end

