

local __ui_help_create = require "game.jinchanbuyu.ui.ui_help"

JinchanHelp = class("JinchanHelp",function ()
	return cc.Node:create()
end)

function JinchanHelp.create()
	local obj  = JinchanHelp.new()
	if obj then
		obj:init()
	end

	return obj
end

function JinchanHelp:init()
	self.ui_lst = __ui_help_create.create()
	self:addChild(self.ui_lst.root)

	local des_size = WindowScene.getInstance():getDesSize()
	self.ui_lst.root:setPosition(des_size.w/2,des_size.h/2)

	self.ui_lst.btnClose:onTouch(function (e)
		if e.name == "ended" then
			WindowScene.getInstance():closeDlg(self)
		end
	end)

	self:registerTouch()
end

function JinchanHelp:registerTouch()
	local function __on_touch_began(touch, event) return true end
    local function __on_touch_moved(touch, event) return true end
    local function __on_touch_ended(touch, event) return true end
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(__on_touch_began,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(__on_touch_moved,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(__on_touch_ended,cc.Handler.EVENT_TOUCH_ENDED)
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener,self)
end



