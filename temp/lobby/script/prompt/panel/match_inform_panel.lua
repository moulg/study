#remark
--[[
	比赛通知面板
]]

local buttonPanel_ui = require "lobby.ui_create.ui_bomb_box"
local scheduler = cc.Director:getInstance():getScheduler()

CMatchInformExt = class("CMatchInformExt",function()
	local ret = cc.Node:create()
    return ret
end)

function CMatchInformExt.create()
	-- body
	local layer = CMatchInformExt.new()
	if layer ~= nil then
		layer:regEnterExit()
		return layer
	end
end


function CMatchInformExt:regEnterExit()
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

function CMatchInformExt:onEnter()

end

function CMatchInformExt:onExit()
	timeUtils:remove(self)

	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.buttonPanel_ui.btn_close)
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

function CMatchInformExt:init_message(gameName, time)
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

	local info = message_config[1008].name
	self.buttonPanel_ui.text_message:setString(textUtils.connectParam(info, {gameName, time}))

	local function timeHandler(t)
		local info = message_config[1008].name
		self.buttonPanel_ui.text_message:setString(textUtils.connectParam(info, {gameName, t}))
	end

	local function timeEnd()
		onHide(self)
	end
	
	timeUtils:addTimeDown(self, time, timeHandler, timeEnd)

end


function CMatchInformExt:showMe()
	-- body
	local scene = WindowScene.getInstance()                         
	scene:showDlg(self)
	local size = scene:getScaleSize()
	self.buttonPanel_ui.root:setScale(1/size.x, 1/size.y)

	self.buttonPanel_ui.img_bj:runAction(cc.FadeIn:create(1))
end