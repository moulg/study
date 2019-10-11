--[[
	转账凭证
]]

 

local ui_create = require "lobby.ui_create.ui_transferEvidence"  
 
CTransferEvidence = class("CTransferEvidence",function()
	local  ret = cc.Layer:create()
	return ret
end)
ModuleObjMgr.add_module_obj(CTransferEvidence,"CTransferEvidence")

function CTransferEvidence.create()
	local obj = CTransferEvidence.new()
	if obj then
		obj:init()
	end

	return obj
end

function CTransferEvidence:init()
	self:init_ui()
	self:regTouch()
end

function CTransferEvidence:regTouch()
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

function CTransferEvidence:init_ui()
	 
	self.ui_lst = ui_create.create()
	self:addChild(self.ui_lst.root)

	self.ui_lst.btnSure:onTouch(function (e)
		if e.name == "ended" then
			WindowScene.getInstance():closeDlg(self)
			global_music_ctrl.play_btn_one()
		end
	end)

	self.ui_lst.btnSave:onTouch(function (e)
		if e.name == "ended" then
			WindowScene.getInstance():closeDlg(self)
			global_music_ctrl.play_btn_one()
		end
	end)

	self.ui_lst.btnClose:onTouch(function (e)
		if e.name ==  "ended" then
			WindowScene.getInstance():closeDlg(self)
			global_music_ctrl.play_btn_one()
		end
	end)

	local des_size = WindowScene.getInstance():getDesSize()
	-- self:setPosition(des_size.w/2,des_size.h/2)

end
function CTransferEvidence:displayInfo(msg)
    self.ui_lst.inID:setString(msg.target)
	self.ui_lst.outID:setString(get_player_info().id)
	-- print(os.date("%Y/%m/%d/%H/%M",os.time()))
	self.ui_lst.tmoney:setString(msg.gold)
	self.ui_lst.tTime:setString(os.date("%Y/%m/%d %H:%M",os.time()))
	-- print(require("socket").gettime()) 
	-- print(os.date("%Y-%m-%d-%H-%M-%S",os.time()))
end
--   .
-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
