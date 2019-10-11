#remark
local btn_x_dis = 20
local btn_y_pos = 10

AD_PageView = class("AD_PageView",function ()
	local obj = cc.Layer:create()
	return obj
end)


function AD_PageView.create(size,pos,btn_src_nor,btn_src_click)
	local obj = AD_PageView.new()
	if obj then
		obj:init(size,pos,btn_src_nor,btn_src_click)
	end

	return obj
end


function AD_PageView:init(size,pos,btn_src_nor,btn_src_click)
	self.size = size
	self.pos  = pos

	self.btn_src_nor 	= btn_src_nor
	self.btn_src_click 	= btn_src_click

	self:init_data()
	self:init_ui()
	self:regEnterExit()
	self:regUpdate()
end


function AD_PageView:init_data()
	self.lst_button = {
		--[[ {btn_obj,page_index} ]]
	}
	
	
	self.bauto_scroll = false
	self.auto_time = 0
	self.add_auto_time = 0

	self.page_count 		= 0
	self.front_page_index 	= 0
	self.cur_page_index 	= 0
	self.back_page_index 	= 0

	self.b_add_way   = true
	self.is_show_btn = true

	self.btn_vir_rect = {x = 0,y = 0,w = 0,h = 0,}
end


function AD_PageView:init_ui()
	-- body
	local item_page = ccui.PageView:create()
	item_page:ignoreContentAdaptWithSize(false)
	item_page:setBackGroundImageCapInsets(cc.rect(0,0,0,0))
	item_page:setBackGroundColorOpacity(102)
	item_page:setBackGroundImageScale9Enabled(true)
	item_page:setCascadeColorEnabled(true)
	item_page:setCascadeOpacityEnabled(true)
	item_page:setPosition(self.pos.x,self.pos.y)
	item_page:setSize(self.size)

	self.lst_obj = item_page
	self:addChild(item_page)
	self.lst_obj:setTouchEnabled(false)


	self.btn_node = ccui.ImageView:create() 
	self.btn_node:loadTexture("lobby/resource/reg_res/bg.png")
	self.btn_node:setScale9Enabled(true)
	self.lst_obj:addChild(self.btn_node)
	self.btn_node:setLocalZOrder(10)
	self.btn_node:setVisible(true)
	self.btn_node:setAnchorPoint(0.5,0.5)
	self.btn_node:setPosition(self.size.width/2,10)

	self.btn_menu = cc.Menu:create()
	self.btn_node:addChild(self.btn_menu)
	self.btn_menu:setPosition(0,0)

	self.click_spr = cc.Sprite:create(self.btn_src_click)
	self.click_spr:setVisible(false)
	self.click_spr:setAnchorPoint(0.5,0.5)
	self.click_spr:setPosition(0,0)

	self.btn_node:addChild(self.click_spr)

	self.btn_vir_rect.x = 0
	self.btn_vir_rect.y = 0
	local size = self.click_spr:getContentSize()
	self.btn_vir_rect.w = self.btn_node:getContentSize().width/2 + size.width*2 + btn_x_dis/2--self.size.width/2
	self.btn_vir_rect.h = self.btn_node:getContentSize().height/2 + size.height--size.height + 2*btn_y_pos
end

function AD_PageView:regEnterExit()
	-- body
	local function __on_enter_exit(event)
		-- body
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__on_enter_exit)
end

function AD_PageView:onEnter()

end

function AD_PageView:onExit()

end

function AD_PageView:regUpdate()
	-- body
	local function __update_(dt) self:update(dt) end
	self:scheduleUpdateWithPriorityLua(__update_,0)
end

function AD_PageView:update(dt)
	-- body
	self:autoScrollItem(dt)
end

function AD_PageView:addPage(obj)
	-- body
	if obj then
		local par_size = self.lst_obj:getContentSize()
		local new_item = ccui.Layout:create()
    	new_item:setContentSize(par_size)
    	new_item:setPosition(0,0)
    	new_item:addChild(obj)
    	obj:setPosition(par_size.width/2,par_size.height/2)

    	self.page_count = self.page_count + 1
		self.lst_obj:addPage(new_item)
		self:addBtnClick()
		
		if self.page_count == 1 then
			self.cur_page_index = 1
			self.btn_node:setVisible(false)
		end

		if self.page_count > 1 and self.is_show_btn == true then
			self.btn_node:setVisible(true)
			self.click_spr:setVisible(true)
			local x,y = self.lst_button[1].obj:getPosition()
			self.click_spr:setPosition(x,y)
		end
	end
end

function AD_PageView:autoScrollItem(dt)
	-- body
	if self.bauto_scroll == true and self.page_count > 1 then
		if self.add_auto_time >= self.auto_time then
			if self.b_add_way == true then
				self.cur_page_index = self.cur_page_index + 1
			else
				self.cur_page_index = self.cur_page_index - 1
			end

			if self.cur_page_index > self.page_count then
				self.cur_page_index  = self.cur_page_index - 2
				self.b_add_way = false
			end

			if self.cur_page_index < 1 then
				self.cur_page_index = 2
				self.b_add_way = true
			end

			self.lst_obj:scrollToPage(self.cur_page_index - 1)
			local x,y = self.lst_button[self.cur_page_index].obj:getPosition()
			self.click_spr:setPosition(x,y)

			self.add_auto_time = 0
		else
			self.add_auto_time = self.add_auto_time + dt
		end
	end
end

function AD_PageView:addBtnClick()
	-- body


	local pos_x = 0
	local pos_y = 0

	local btn_len = #self.lst_button

	if btn_len == 0 then
		pos_x = self.btn_vir_rect.x + self.btn_vir_rect.w/2
		pos_y = self.btn_vir_rect.y + self.btn_vir_rect.h/2
	else
		for i = 1,#self.lst_button do
			local rx,_ = self.lst_button[i].obj:getPosition()
			local size = self.lst_button[i].obj:getContentSize()
			rx = rx - (btn_x_dis + size.width)/2
			self.lst_button[i].obj:setPositionX(rx)
		end

		local last_obj = self.lst_button[#self.lst_button].obj
		local lx,_ = last_obj:getPosition()
		local size = last_obj:getContentSize()


		pos_x = lx + (btn_x_dis + size.width)
		pos_y = self.btn_vir_rect.y + self.btn_vir_rect.h/2
	end

	print("pos_x = " .. pos_x .. " ,pos_y = " .. pos_y)

	local btn_info = {}
	btn_info.obj = cc.MenuItemImage:create(self.btn_src_nor,self.btn_src_nor)
	btn_info.obj:setPosition(pos_x,pos_y)

	local function _btn_click(e,f) self:btnClick(e,f) end
	btn_info.obj:registerScriptTapHandler(_btn_click)

	btn_info.page_index = self.page_count
	self.btn_menu:addChild(btn_info.obj)
	self.lst_button[self.page_count] = btn_info
end

function AD_PageView:btnClick(e,f)
	-- body
	for k,v in pairs(self.lst_button) do
		if v.obj == f then
			self.cur_page_index = v.page_index
			self.lst_obj:scrollToPage(self.cur_page_index - 1)
			local x,y = v.obj:getPosition()
			self.click_spr:setPosition(x,y)
		end
	end
end

function AD_PageView:setAutoScrollPage(bauto,t)
	-- body
	self.bauto_scroll = bauto
	self.auto_time = t
	self.add_auto_time = 0
end

function AD_PageView:clear()
	-- body
	self.bauto_scroll = false
	self.auto_time = 0
	self.page_count = 0
	self.cur_page_index = 0
	sefl.lst_obj:removeAllPages()
end

function AD_PageView:setShowBtn(bshow)
	-- body
	if bshow == true then
		self.is_show_btn = true
		self.btn_node:setVisible(true)
	elseif bshow == false then
		self.is_show_btn = false
		self.btn_node:setVisible(false)
	end
end



