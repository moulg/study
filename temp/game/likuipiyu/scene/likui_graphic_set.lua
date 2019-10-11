
--[[
	画质设置
]]

local ui_creater = require "game.likuipiyu.ui.ui_likuipiyu_ps"

LikuiGraphicSet = class("LikuiGraphicSet",function ()
	local obj = cc.Node:create()
	return obj
end)

function LikuiGraphicSet.create()
	local obj = LikuiGraphicSet.new()
	if obj then
		obj:init()
	end

	return obj
end

function LikuiGraphicSet:init()
	self:initUI()
	self:registerTouch()
end

function LikuiGraphicSet:initUI()
	self.ui_lst = ui_creater.create()
	self:addChild(self.ui_lst.root)
	local des_size = WindowScene.getInstance():getDesSize()
	self.ui_lst.root:setPosition(des_size.w/2,des_size.h/2)

	self.ui_lst.btnClose:onTouch(function (e)
		if e.name == "ended" then
			local btn_lst = {self.ui_lst.CheckBox_Hight,self.ui_lst.CheckBox_Middle,self.ui_lst.CheckBox_Low,}
			WindowScene.getInstance():unregisterGroupEvent(btn_lst)
			WindowScene.getInstance():closeDlg(self)
		end
	end)

	local btn_lst = {self.ui_lst.CheckBox_Hight,self.ui_lst.CheckBox_Middle,self.ui_lst.CheckBox_Low,}
	WindowScene.getInstance():registerGroupEvent(btn_lst,function (sender,eventType)
		self:onGroupCallback(sender,eventType)
	end)

	open_user_config()
	self.key = string.format("%d",get_player_info().curGameID)
	self.set_data = get_user_config()[self.key]
	if self.set_data == nil then self.set_data = {} end
	if self.set_data.graphic_level == nil then
		self.set_data.graphic_level = 3
	end

	self:initSelectState(self.set_data.graphic_level)
end

function LikuiGraphicSet:registerTouch()
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

function LikuiGraphicSet:onGroupCallback(sender,eventType)
	if sender == self.ui_lst.CheckBox_Hight then
		if eventType == "selected" then
			self:setGraphicLevel(3)
		end
	elseif sender == self.ui_lst.CheckBox_Middle then
		if eventType == "selected" then
			self:setGraphicLevel(2)
		end
	elseif sender == self.ui_lst.CheckBox_Low then
		if eventType == "selected" then
			self:setGraphicLevel(1)
		end
	end
end

function LikuiGraphicSet:setGraphicLevel(level)
	print("graphics level = " .. level)
	self.set_data.graphic_level = level
	get_user_config()[self.key] = self.set_data
	save_uer_config()

	local obj = WindowScene.getInstance():getModuleObjByClassName("Likuipiyu")
	if obj then
		obj:setGraphicLevel(level)
	end
end

function LikuiGraphicSet:initSelectState(level)
	if level == 3 then
		self.ui_lst.CheckBox_Hight:setSelected(true)
		self.ui_lst.CheckBox_Hight:setEnabled(false)
		self.ui_lst.CheckBox_Middle:setSelected(false)
		self.ui_lst.CheckBox_Low:setSelected(false)
	elseif level == 2 then
		self.ui_lst.CheckBox_Hight:setSelected(false)
		self.ui_lst.CheckBox_Middle:setSelected(true)
		self.ui_lst.CheckBox_Middle:setEnabled(false)
		self.ui_lst.CheckBox_Low:setSelected(false)
	elseif level == 1 then
		self.ui_lst.CheckBox_Hight:setSelected(false)
		self.ui_lst.CheckBox_Middle:setSelected(false)
		self.ui_lst.CheckBox_Low:setSelected(true)
		self.ui_lst.CheckBox_Low:setEnabled(false)
	end
end

