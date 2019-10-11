#remark
local __hit_dlg_creater = require "update.script.ui_create.ui_update_sure"



ShowDlClient = class("ShowDlClient",function ()
	return cc.Node:create()
end)

--[[
	info = {
		mod,
		ok_call,
		hit_text,
	}
]]
function ShowDlClient.create(info)
	local obj  = ShowDlClient.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function ShowDlClient:init(info)


	self.ui_lst = __hit_dlg_creater.create()
	self:addChild(self.ui_lst.root)
	if info then
		self.ok_call = info.ok_call
		if info.hit_text then
			self.ui_lst.textMessage:setString(info.hit_text)
		end
	end

	self.ui_lst.root:setPosition(1920/2,1080/2)

	self.ui_lst.btnSure:onTouch(function (e)
		if e.name == "ended" then
			if self.ok_call then
				self.ok_call()
				self:removeFromParent()
			end
		end
	end)

	self.ui_lst.btnNoSure:onTouch(function (e)
		if e.name == "ended" then
			cc.Director:getInstance():endToLua()

			local targetPlatform = cc.Application:getInstance():getTargetPlatform()
			if cc.PLATFORM_OS_IPHONE == targetPlatform then
				os.exit()
			end
		end
	end)

	self.ui_lst.btnClose:onTouch(function (e)
		if e.name == "ended" then
			cc.Director:getInstance():endToLua()

			local targetPlatform = cc.Application:getInstance():getTargetPlatform()
			if cc.PLATFORM_OS_IPHONE == targetPlatform then
				os.exit()
			end
		end
	end)
	if info.mod == 1 then

		self.ui_lst.btnSure:setPositionX(0.0000)
		self.ui_lst.btnNoSure:setVisible(false)

		self.ui_lst.textMessage:setPositionX(200.0000)
	end

	self:registerTouch()
end

function ShowDlClient:registerTouch()
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
