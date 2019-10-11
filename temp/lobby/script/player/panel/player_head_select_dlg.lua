#remark
--[[
	头像选择对话框
]]

local ui_create = require "lobby.ui_create.ui_RegAccount_Head"

local item_dis_w = 5
local item_dis_h = 5

PlayerHeadSelectDlg = class("PlayerHeadSelectDlg",function ()
	local  obj = cc.Layer:create()
	return obj
end)

function PlayerHeadSelectDlg.create()
	local obj = PlayerHeadSelectDlg.new()
	if obj then
		obj:init()
	end

	return obj
end

function PlayerHeadSelectDlg:init()
	self:init_data()
	self:init_ui()
	self:registerEE()
end

function PlayerHeadSelectDlg:init_data()
	self.close_call 	= nil
	self.ok_call	 	= nil
	self.upload_call 	= nil
	self.pic_index 		= -1
	self.pic_src 		= ""
	self.cur_lst_len 	= 0
	self.cur_lst_obj = {}
end

function PlayerHeadSelectDlg:init_ui()
	self.ui_obj_lst = ui_create.create()
	self:addChild(self.ui_obj_lst.root)

	self.ui_obj_lst.btnSure:onTouch(function (e) self:onOkClick(e) end)
	--self.ui_obj_lst.btnUpload:onTouch(function (e) self:onUpdateSelfHeadPic(e) end)
	self.ui_obj_lst.btnClose:onTouch(function (e) self:onCloseCall(e) end)
	self.ui_obj_lst.btnSure:setLocalZOrder(200)
	self.ui_obj_lst.btnClose:setLocalZOrder(200)
	--self.ui_obj_lst.btnUpload:setLocalZOrder(200)

	local mov_obj = cc.Sprite:create("lobby/resource/button/queding2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.ui_obj_lst.btnSure,mov_obj,1)

	--local mov_obj = cc.Sprite:create("lobby/resource/head/zidingyi2.png")
	--WindowScene.getInstance():registerBtnMouseMoveEff(self.ui_obj_lst.btnUpload,mov_obj,1)

	self:init_head_lst_by_config()
end

function PlayerHeadSelectDlg:init_head_lst_by_config()
	self.cur_lst_len  = 0
	self.cur_item_group = nil
	self.head_lst_obj = CSilderScroll.create()
	self.ui_obj_lst.head_bg:addChild(self.head_lst_obj)
	self.head_lst_obj:setPosition(10,73)
	local item = PlayerHeadItem.create({key = 1,img_src = "common/head_pic/toux1.png",})
	self.head_lst_obj:init_sliderScroll(cc.size(515, 305), 0)
	item:destroy()
	item = nil

	local function __on_select_head_call(key,obj)
		self:onSelectHeadCall(key,obj)
	end

	for i=1,#player_head_src do
		local info = {key = player_head_src[i].id,img_src = player_head_src[i].src,click_call = __on_select_head_call,}
		local item = PlayerHeadItem.create(info)

		local item_sz = item:getContentSize()
		item:setAnchorPoint(0,0)
		self:addHeadItem(item,item_sz.width + item_dis_w,item_sz.height + item_dis_h)
	end
	self.head_lst_obj:refreshView()
end

function PlayerHeadSelectDlg:addHeadItem(obj,w,h)
	local listview_w = self.head_lst_obj:getContentSize().width

	local horizon_count = math.floor(listview_w / w)
	local dif = (listview_w - horizon_count * w) / (horizon_count + 1)

	local item_x = (self.cur_lst_len % horizon_count) * (w + dif) + dif + item_dis_w/2
	local item_y = self.head_lst_obj:getContentSize().height - math.floor(self.cur_lst_len / horizon_count) * h

	print("item_x = " .. item_x .. " ,item_y = " .. item_y)


	if self.cur_lst_len%horizon_count == 0 then
		self.cur_item_group = ccui.Layout:create()
		self.cur_item_group:setClippingEnabled(false)
    	self.cur_item_group:setContentSize(cc.size(listview_w,h))
    	self.cur_item_group:setAnchorPoint(0,1)
    	self.cur_item_group:setPosition(0,item_y)
    	self.head_lst_obj:addObject(self.cur_item_group)
    end

	obj:setPosition(item_x, 0)
	self.cur_lst_len = self.cur_lst_len + 1
	self.cur_item_group:addChild(obj)
	table.insert(self.cur_lst_obj,obj)
end

function PlayerHeadSelectDlg:registerEE()
	local function __enter_exit(e)
		if e == "enter" then
			self:onEnter()
		elseif e == "exit" then
			self:onExit()
		end
	end
	self:registerScriptHandler(__enter_exit)
end

function PlayerHeadSelectDlg:onEnter()
	
end


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。


function PlayerHeadSelectDlg:onExit()
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_obj_lst.btnSure)
	--WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_obj_lst.btnUpload)
end


function PlayerHeadSelectDlg:DoShow(pos,parent,close_call,ok_call,upload_call)

	local listener = cc.EventListenerTouchOneByOne:create()
   
    listener:registerScriptHandler(function (t,e) return true end,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(function (t,e) return true end,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(function (t,e) return true end,cc.Handler.EVENT_TOUCH_ENDED)

    listener:setSwallowTouches(true)
    local event_dispatcher = self:getEventDispatcher()
    event_dispatcher:addEventListenerWithSceneGraphPriority(listener,self)

	self.close_call 	= close_call
	self.ok_call 		= ok_call
	self.upload_call 	= upload_call

	if parent then
    	parent:addChild(self)
    	self:setPosition(pos.x,pos.y)
    	self:setLocalZOrder(200)
    	self:setVisible(true)
    end
end

function PlayerHeadSelectDlg:onCloseCall(e)
	if e.name == "ended" then
		if self.close_call then self.close_call() end
		self:removeFromParent()
	end
end

function PlayerHeadSelectDlg:onOkClick(e)
	if e.name == "ended" then
		if self.ok_call then self.ok_call(self.pic_index) end
		self:onCloseCall(e)
	end
end

function PlayerHeadSelectDlg:onUpdateSelfHeadPic(e)
	if e.name == "ended" then
		if self.upload_call then self.upload_call(self.pic_src) end
	end
end

function PlayerHeadSelectDlg:onSelectHeadCall(key,obj)
	print("select head id = " .. key)
	for k,v in pairs(self.cur_lst_obj) do
		if v == obj then
			v:setSelected(true)
		else
			v:setSelected(false)
		end
	end
	self.pic_index = key
end

