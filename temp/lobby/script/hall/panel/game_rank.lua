#remark
--[[
    排行榜
]]
-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

local panel_ui

CRank = class("CRank", function()
	local obj = ccui.ImageView:create()
	return obj
end)

function CRank.create()
	local layer = CRank.new()
	if layer ~= nul then
		layer:init_ui()
		layer:regEnterExit()
		layer:registerTouchEvent()
		return layer
	end
end

function CRank:regEnterExit()
	local function _onEnterOrExit(event)
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end
	self:registerScriptHandler(_onEnterOrExit)
end

function CRank:registerTouchEvent()
	local function _on_touch_began(touch, event) return true end
    local function _on_touch_move(touch, event) return true end
    local function _on_touch_end(touch, event) return true end
    local listener = cc.EventListenerTouchOneByOne:create()

    listener:setSwallowTouches(true)
    listener:registerScriptHandler(_on_touch_began,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(_on_touch_move,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(_on_touch_end,cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener,self)
end

function CRank:onEnter()

end

function CRank:onExit()

end

function CRank:init_ui() 
	local bg = ccui.ImageView:create()
	bg:setScale9Enabled(true)
    bg:loadTexture("lobby/resource/general/heidi.png")

    local size = WindowModule.get_window_size()
    bg:setContentSize(cc.size(size.width, size.height))
    self:addChild(bg)

	panel_ui = require("lobby.ui_create.ui_ranking").create()
	self:addChild(panel_ui.root)
	self:registerHandler()
end

function CRank:createRankItems(rankList) 
    panel_ui.PageViewRank:removeAllItems()
    panel_ui.PageViewRank:setItemsMargin(15)

    for k,v in ipairs( rankList ) do
    	print(v.id, v.index, v.nickname)
    end

    if rankList then
    	for k,v in ipairs(rankList) do
    		if v then 
    		    local item = CRankItem.create(v)
                local custom_item = ccui.Layout:create()
                custom_item:setContentSize(item:getContentSize().width,item:getContentSize().height)
                item:setPosition(cc.p(custom_item:getContentSize().width/2,custom_item:getContentSize().height/2))
	            custom_item:addChild(item)
	            panel_ui.PageViewRank:pushBackCustomItem(custom_item)
	        end 
    	end
    end 
end


function CRank:registerHandler()
     panel_ui.btnClose:onTouch(function(e)
     	if e.name == "ended" then
     	    self:onClose()
     	    global_music_ctrl.play_btn_one()
        end
     end)
end

function CRank:onClose()
	if self.close_call_back then
		self.close_call_back()
	end
	--WindowScene.getInstance():closeDlg(self)
	self:removeFromParent()
end 

function CRank:setCloseCallBack(fun)
	self.close_call_back = fun
end

return CRank
