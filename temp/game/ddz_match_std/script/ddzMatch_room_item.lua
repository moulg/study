local panel_ui = require "game.ddz_match_std.script.ui_create.ui_ddzMatch_room"

local _contentSize = cc.size(192, 175)

CDdzMatchRoomItem = class("CDdzMatchRoomItem", function ()
	-- body
	local  ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:setContentSize(_contentSize)
    ret:setAnchorPoint(0, 0)
	return ret
end)

function CDdzMatchRoomItem.getContentSize()
	return _contentSize
end

function CDdzMatchRoomItem.create()
	-- body
	local layer = CDdzMatchRoomItem.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end

function CDdzMatchRoomItem:regEnterExit()
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

function CDdzMatchRoomItem:onEnter()
	
end

function CDdzMatchRoomItem:onExit()
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.panel_ui.btnEnter)
end

function CDdzMatchRoomItem:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)

	
	self:registerHandler()
	self:addButtonHightLight()
end


function CDdzMatchRoomItem:addButtonHightLight()
	--注册按钮高亮事件
	local mov_obj = cc.Sprite:create("game/ddz_match_std/resource/button/k2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.btnEnter,mov_obj,1)
end

function CDdzMatchRoomItem:registerHandler()
	--进入游戏桌子
	local function __on_enter_deskclick( e )
		if e.name == "ended" then
			send_doudizhu_ReqEnterRoom({roomId = self._roomInfo.roomId})
		end
	end

	self.panel_ui.btnEnter:onTouch(__on_enter_deskclick)
end


function CDdzMatchRoomItem:setInfo( info )
	self._roomInfo = info

	self.panel_ui.imgPVP:setTexture(ddz_match_type_config[info.type].iconRes)
	self.panel_ui.imgWord:setTexture(ddz_match_type_config[info.type].wordRes)
end