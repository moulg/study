#remark
require "platform.control.commbox.commbox_item"

--[[
	组合框
]]

local default_font_name  = "lobby/resource/font/simhei.ttf"
local default_font_size  = 16
local default_font_color = cc.c3b(0,0,0)
local default_show_line  = 5

local default_btn_normal_src 	= "lobby/resource/button/xialashanjiao1.png"
local default_btn_mov_src		= "lobby/resource/button/xialashanjiao2.png"
local default_btn_down_src 		= "lobby/resource/button/xialashanjiao3.png"
local default_bg_color = cc.c4b(255,255,255,255)

local commbox_obj_lst = {}
local function direct_key_pro(dir)
	if dir == 2 or dir == 3 then --key up,down
		for k,v in pairs(commbox_obj_lst) do
			v:onDirectKeyPro(dir)
		end
	end
end
WindowRegFun.reg_direction_key_call(direct_key_pro,"commbox_direct_pro")




CommBox = class("CommBox",function ()
	local obj = cc.LayerColor:create(cc.c4b(255,255,255,255),10,10)
	obj:setAnchorPoint(0,0)
	return obj
end)

--[[
	info = {
		parent,
		pos  = {x,y,},
		size = {width,height,},
		item_size = {width,height,}
		line,
		binput,

		--may nil
		font_size,
		font_color,
		font_name,

		--btn texture src
		src_btn_nor,
		src_btn_down,
		src_btn_mov,
		src_bg_color,
	}
]]
function CommBox.create(info)
	local obj = CommBox.new()
	if obj then
		obj:init(info)
		if info.parent then
			info.parent:addChild(obj)
		end
	end

	return obj
end

function CommBox:init(info)
	self:init_data(info)
	self:init_ui()
	self:registerEE()
	self:registerCallBack()
	self:registerMouseEve()
end

function CommBox:init_data(info)
	self.parent = info.parent
	self.pos 	= info.pos
	self.size 	= info.size

	self.si_line = default_show_line
	if info.line then self.si_line = info.line end

	self.item_size = info.item_size

	self.font_size = default_font_size
	if info.font_size then self.font_size = info.font_size end

	self.font_name = default_font_name
	if info.font_name then self.font_name = info.font_name end

	self.font_color = default_font_color
	if info.font_color then self.font_color = info.font_color end

	self.src_btn_nor  = default_btn_normal_src
	self.src_btn_down = default_btn_down_src
	self.src_btn_mov  = default_btn_mov_src
	self.src_bg_color = default_bg_color

	if info.src_btn_nor then self.src_btn_nor = info.src_btn_nor end
	if info.src_btn_down then self.src_btn_down = info.src_btn_down end
	if info.src_btn_mov then self.src_btn_mov = info.src_btn_mov end
	if info.src_bg_color then self.src_bg_color = info.src_bg_color end

	self.benable_input = true
	if info.binput ~= nil then self.benable_input = info.binput end

	self.item_lst 		= {}
	self.find_item_lst 	= {}
	self.tmp_obj_lst 	= {}
	self.dir_sel_index  = -1

	self.bshow_item_lst_obj = false
	self.commbox_index = -1

	self.select_call = nil
end

function CommBox:init_ui()

	self:setContentSize(self.size)
	self:setPosition(self.pos.x,self.pos.y)
	self:setColor(self.src_bg_color)

	local spr  = cc.Sprite:create(self.src_btn_nor)
	local size = spr:getContentSize()
	spr = nil

	local pos  = {}
	pos.x = self.size.width - size.width
	pos.y = (self.size.height - size.height)/2

	--create btn
	self.btn_item = uiUtils.createBtn(pos,size,self.src_btn_nor,self.src_btn_down,self.src_btn_dis)
	self:addChild(self.btn_item)

	--create input text
	self.input_txt_obj = EditBoxEx.create()
	self.input_txt_obj:setCascadeColorEnabled(true)
	self.input_txt_obj:setCascadeOpacityEnabled(true)
	self.input_txt_obj:setFontName(self.font_name)
	self.input_txt_obj:setFontSize(self.font_size)
	self.input_txt_obj:setColor(self.font_color)
	self.input_txt_obj:setPosition(5,self.size.height/4)
	local txt_size = {width = self.size.width - size.width,height = self.size.height}
	self.input_txt_obj:setContentSize(txt_size)
	self:addChild(self.input_txt_obj)

	self.input_txt_obj:setEnableInput(self.benable_input)

	--create item list obj
	self.item_lst_obj  = CSilderScroll.create()
	self:addChild(self.item_lst_obj)
	local lst_size  = {}
	lst_size.width  = self.size.width
	lst_size.height = self.item_size.height*self.si_line
	self.item_lst_obj:init_sliderScroll(lst_size,0)
	local lst_pos = {x = 0,y = -(lst_size.height + 1),}
	self.item_lst_obj:setPosition(lst_pos.x,lst_pos.y)
	self.item_lst_obj:showHideSlider(false)
	self.item_lst_obj:setVisible(self.bshow_item_lst_obj)




	local mov_obj = cc.Sprite:create(self.src_btn_mov)
	WindowScene.getInstance():registerBtnMouseMoveEff(self.btn_item,mov_obj,1)
end

function CommBox:registerEE()
	local function __on_enter_exit(event)
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__on_enter_exit)
end

function CommBox:registerMouseEve()
	local function __on_mouse_down(e) 
		local btn_type = e:getMouseButton()
		if btn_type == 0 then --left mouse button
			self:onLeftMouseDown(e)
		elseif btn_type == 1 then --right mouse button
		elseif btn_type == 2 then --center mouse button
		end 
	end
    local mouse_listener = cc.EventListenerMouse:create()
	mouse_listener:registerScriptHandler(__on_mouse_down,cc.Handler.EVENT_MOUSE_DOWN)
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(mouse_listener,self)
end

function CommBox:onLeftMouseDown(e)
	local pos = cc.Director:getInstance():convertToGL(e:getLocation())
	if self.item_lst_obj:getScrollObject():hitTest(pos) == false and self.btn_item:hitTest(pos) == false then
		if self.bshow_item_lst_obj == true then
			self.bshow_item_lst_obj = false
			self.item_lst_obj:setVisible(self.bshow_item_lst_obj)
		end
	end
end

function CommBox:registerCallBack()
	self.btn_item:onTouch(function (e)
		if e.name == "ended" then
			self:onBtnClick()
		end
	end)

	self.input_txt_obj:setTextChangeCall(function (txt)
		self:onInputTextCall(txt)
	end)

	self.input_txt_obj:setFocusCall(function (mod,txt)
		self:onFocusCall(mod,txt)
	end)
end

function CommBox:onEnter()
	table.insert(commbox_obj_lst,self)
	self.commbox_index = #commbox_obj_lst
end

function CommBox:onExit()
	commbox_obj_lst[self.commbox_index] = nil
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.btn_item)
end

function CommBox:onBtnClick()
	self.bshow_item_lst_obj = not self.bshow_item_lst_obj
	self.item_lst_obj:setVisible(self.bshow_item_lst_obj)

	self.dir_sel_index = 0
	self:resetItemLst(self.item_lst,false)
	self.find_item_lst = {}

	-- local str = self.input_txt_obj:getStringEx()
	-- if str and str ~= "" then
	-- 	self:resetItemLst(self.find_item_lst)
	-- else
	-- 	self:resetItemLst(self.item_lst)
	-- 	self.find_item_lst = {}
	-- end
end

function CommBox:removeItem(index)
	if index and type(index) == "number" then
		for i = 1,#self.item_lst do
			if i == index then
				table.remove(self.item_lst,i)
				break
			end
		end

		self.item_lst_obj:removeAllObjects()
		for i=1,#self.item_lst do
			self:addItem(self.item_lst[i])
		end
	end
end

function CommBox:addItem(obj)
	if obj then
		self.item_lst_obj:addObject(obj)
		self.item_lst_obj:refreshView()

		return #self.item_lst
	end

	return -1
end

--[[
	info = {
		nor,
		mov,
		down,
		txt,
	}
]]
function CommBox:addItemEx(info)
	if info then
		
		--self:addItem(self:newItem(info))

		local new_info = clone(info)
		table.insert(self.item_lst,new_info)

		-- if #self.item_lst > self.si_line then
		-- 	self.item_lst_obj:showHideSlider(true)
		-- else
		-- 	self.item_lst_obj:showHideSlider(false)
		-- end
	end
end

function CommBox:newItem(info)
	local cinfo = {
		src_nor  = info.nor,
		src_mov  = info.mov,
		src_down = info.down,
		txt_key  = info.txt,
		ft_size = self.font_size,
		ft_name = self.font_name,
		ft_color = self.font_color,
		call = function (key) self:onSelectClick(key) end,
		item_w = self.item_size.width,
		item_h = self.item_size.height,
	}

	return CommboxItem.create(cinfo)
end


function CommBox:resetItemLst(lst_item,bsel_first)
	self.item_lst_obj:removeAllObjects()
	self.item_lst_obj:refreshView()
	self.tmp_obj_lst = {}

	if lst_item then
		for i=1,#lst_item do
			local item = self:newItem(lst_item[i])
			self:addItem(item)
			if self.bshow_item_lst_obj == true and i == 1 and bsel_first == true then
				item:setItemSelectState(true)
				self.dir_sel_index = i
			end
			table.insert(self.tmp_obj_lst,item)
		end

		-- if #lst_item > self.si_line then
		-- 	self.item_lst_obj:showHideSlider(true)
		-- else
		-- 	self.item_lst_obj:showHideSlider(false)
		-- end
	end
end

function CommBox:onSelectClick(txt)
	printf(txt)
	self.input_txt_obj:setStringEx(txt)
	self.bshow_item_lst_obj = false
	self.item_lst_obj:setVisible(self.bshow_item_lst_obj)
	if self.select_call then self.select_call(txt) end
end

function CommBox:onDirectKeyPro(code)
	-- if self.bshow_item_lst_obj == true then
	-- 	if code == 2 then --key up
	-- 		self.dir_sel_index = self.dir_sel_index - 1
	-- 		if self.dir_sel_index <= 0 then	self.dir_sel_index = 1 end
	-- 		self:setSelectItem()
	-- 		--self.item_lst_obj:setScollPixel(-self.item_size.height)
	-- 	elseif code == 3 then --key down
	-- 		self.dir_sel_index = self.dir_sel_index + 1
	-- 		if self.dir_sel_index > #self.tmp_obj_lst then
	-- 			self.dir_sel_index = #self.tmp_obj_lst
	-- 		end
	-- 		self:setSelectItem()
	-- 		--self.item_lst_obj:setScollPixel(self.item_size.height)
	-- 	end
	-- end
end

function CommBox:setSelectItem()
	for i=1,#self.tmp_obj_lst do
		if self.dir_sel_index == i then
			self.tmp_obj_lst[i]:setItemSelectState(true)
		else
			self.tmp_obj_lst[i]:setItemSelectState(false)
		end
	end
end

function CommBox:scrollPixel(pixel)
	
end


function CommBox:onInputTextCall(txt)
	self:findItems(txt)
end

function CommBox:onFocusCall(mod,txt)
	if mod == 1 then --get focus
		printf("get focus")
	elseif mod == 0 then --lose focus
		self.bshow_item_lst_obj = false
		self.item_lst_obj:setVisible(self.bshow_item_lst_obj)
	end
end

function CommBox:findItems(str)
	if string.len(str) <= 0 then
		self.bshow_item_lst_obj = false
		self.item_lst_obj:setVisible(self.bshow_item_lst_obj)
	else
		self.find_item_lst = {}
		for i=1,#self.item_lst do
			local k,z = string.find(self.item_lst[i].txt,str)
			if k ~= nil and z ~= nil then
				local new_item = clone(self.item_lst[i])
				table.insert(self.find_item_lst,new_item)
			end
		end

		if #self.find_item_lst <= 0 then
			self.bshow_item_lst_obj = false
		else
			self.bshow_item_lst_obj = true
		end

		self.item_lst_obj:setVisible(self.bshow_item_lst_obj)

		self:resetItemLst(self.find_item_lst,true)
	end
end

--获取选择字符串
function CommBox:getSelectText()
	return self.input_txt_obj:getStringEx()
end

function CommBox:setSelectIndex(index)
	if index and type(index) == "number" then
		if index > 0 and index <= #self.item_lst then
			self.dir_sel_index = index
			local str = self.item_lst[index].txt
			self.input_txt_obj:setStringEx(str)
		end
	end
end

function CommBox:setSelectString(str)
	if str then
		self.input_txt_obj:setStringEx(str)
	end
end

function CommBox:setSelectCall(call)
	self.select_call = call
end

function CommBox:removeAllItem()
	self.item_lst_obj:removeAllObjects()
	self.item_lst = {}
end
