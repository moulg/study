#remark
--[[
	福利列表项
]]

local ui_create = require "lobby.ui_create.ui_welfare_content"

CwelfareItem = class("CwelfareItem",function()
	local obj = ccui.ImageView:create()
	obj:setScale9Enabled(true)

	return obj
end)
--[[
	info = {
		type, 1->签到,2->救济金
		num, --剩余次数
		params,
	}
]]
function CwelfareItem.create(info)
	local obj = CwelfareItem.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function CwelfareItem:init(info)
	self.item_info = info
	self:init_ui()
	self:regEnterExit()
	self:registerHandler()
end

function CwelfareItem:init_ui()
	self.ui_lst = ui_create.create()
	self:addChild(self.ui_lst.root)
	self.ui_lst.root:setPosition(0,0)
	self.ui_lst.root:setAnchorPoint(0,0)
	--设置面板尺寸
	self:setContentSize(self.ui_lst.ImgBj:getContentSize())

	self.ui_lst.ImgSigin:setVisible(false)	
	self.ui_lst.ImgAlms:setVisible(false)
	self.ui_lst.Text_siginRule:setVisible(false)	
	self.ui_lst.Text_AlmsRule:setVisible(false)
	self.ui_lst.Text_siginTimes:setVisible(false)	
	self.ui_lst.Text_GetTimes:setVisible(false)
	self.ui_lst.btnSigin:setVisible(false)
	self.ui_lst.btnGet:setVisible(false)
	self.ui_lst.fntTimes:setVisible(false)

	if self.item_info.type == 1 then
		self.ui_lst.ImgSigin:setVisible(true)
		self.ui_lst.Text_siginRule:setVisible(true)
		self.ui_lst.btnSigin:setVisible(true)
		self.ui_lst.btnSigin:setEnabled((self.item_info.num > 0) and true or false)
		self.ui_lst.btnSigin:setBright((self.item_info.num > 0) and true or false)
		self.ui_lst.Text_siginTimes:setVisible(true)
		self.ui_lst.Text_siginTimes:setString(string.format("每日签到赠送%s金币！",self.item_info.params[1]))
	elseif self.item_info.type == 2 then
		self.ui_lst.ImgAlms:setVisible(true)
		self.ui_lst.Text_AlmsRule:setVisible(true)
		self.ui_lst.btnGet:setVisible(true)
		self.ui_lst.btnGet:setEnabled((self.item_info.num > 0) and true or false)
		self.ui_lst.btnSigin:setBright((self.item_info.num > 0) and true or false)
		self.ui_lst.Text_GetTimes:setVisible(true)
		self.ui_lst.fntTimes:setVisible(true)
		self.ui_lst.Text_GetTimes:setString(string.format("来领取%s的救济金哟！(低于%s时可领)",self.item_info.params[1],self.item_info.params[2]))
		self.ui_lst.fntTimes:setString(self.item_info.num)
	end
end

function CwelfareItem:registerHandler()
	local mov_obj = cc.Sprite:create("lobby/resource/welfare/qd2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.ui_lst.btnSigin,mov_obj,1)
	local mov_obj = cc.Sprite:create("lobby/resource/welfare/lq2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.ui_lst.btnGet,mov_obj,1)

	self.ui_lst.btnSigin:onTouch(function (e) self:onSiginClick(e) end)
	self.ui_lst.btnGet:onTouch(function (e) self:onGetClick(e) end)
end

function CwelfareItem:onSiginClick(e)
	if e.name == "ended" then
		--签到
		send_welfare_ReqSignIn()
	end
end

function CwelfareItem:onGetClick(e)
	if e.name == "ended" then
		--领取
		local playerInfo = get_player_info()
		local totalGoldNum = playerInfo.gold + playerInfo.safeGold
		if totalGoldNum < tonumber(self.item_info.params[2]) then
			send_welfare_ReqReceiveBenefits()
		else
			TipsManager:showOneButtonTipsPanel(702, {}, true)
		end
	end
end
function CwelfareItem:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(_onEnterOrExit);
end

function CwelfareItem:onEnter()
	-- body
	self:regTouchFunction()
end

function CwelfareItem:onExit()
	-- body
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_lst.btnSigin)
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_lst.btnGet)
end
function CwelfareItem:destroy()
	-- body
end

function CwelfareItem:regTouchFunction()
	-- body
    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        return self:ccTouchBegan(location.x,location.y)
    end

    local function onTouchMoved(touch, event)
        local location = touch:getLocation()
        return self:ccTouchMoved(location.x,location.y)
    end

    local function onTouchEnded(touch, event)
        local location = touch:getLocation()
        return self:ccTouchEnded(location.x,location.y)
    end
    
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)
end


function CwelfareItem:ccTouchBegan(x,y)
	-- body
	--print("touch begin")
	return true
end

function CwelfareItem:ccTouchMoved(x,y)
	-- body
	--print("touch moved")
	return true
end

function CwelfareItem:ccTouchEnded(x,y)
	-- body
	--print("touch end")
	return true	
end


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
