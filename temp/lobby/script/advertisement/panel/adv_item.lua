#remark

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

AdvItem = class("AdvItem",function ()
	local obj = ccui.ImageView:create()
	return obj
end)


--[[
	item_info = {
		src   = "",
		realm = "",
	}
]]
function AdvItem.create(item_info)
	-- body
	local obj = AdvItem.new()
	if obj then
		obj:init(item_info)
	end
	return obj
end

function AdvItem:init(item_info)
	-- body
	self.item_info = item_info
	self:init_data()
	self:init_ui()
end

function AdvItem:init_data()
	-- body
end

function AdvItem:init_ui()
	-- body
	self:loadTexture(self.item_info.src)

	local function __on_reaml_click(e)
		self:onReamlClick(e)
	end
	self:onTouch(__on_reaml_click)
	self:setTouchEnabled(true)
end

function AdvItem:onReamlClick(e)
	-- body
	if e.name == "ended" then
		print("onpen url = " .. self.item_info.realm)
		WindowScene.getInstance():openurl(self.item_info.realm)
	end
end

function AdvItem:registerTouch()
	-- body
	local function __on_touch_begin(touch, event)
        local location = touch:getLocation()
        return self:touchBegin(location.x,location.y)
    end

    local function __on_touch_move(touch, event)
        local location = touch:getLocation()
        return self:touchMove(location.x,location.y)
    end

    local function __on_touch_end(touch, event)
        local location = touch:getLocation()
        return self:touchEnd(location.x,location.y)
    end
    
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(__on_touch_begin,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(__on_touch_move,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(__on_touch_end,cc.Handler.EVENT_TOUCH_ENDED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)

    --self:setTouchEnabled(true)
end

function AdvItem:touchBegin(x,y)
	-- body
	return true
end

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

function AdvItem:touchMove(x,y)
	-- body
	return true
end

function AdvItem:touchEnd(x,y)
	-- body
	print("touch!!!!!!!!!")
	WindowScene.getInstance():openurl(self.item_info.realm)
end
