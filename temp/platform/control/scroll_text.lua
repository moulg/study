#remark
--[[
	滚动文字
]]

local max_scroll_v = 80


local item_dis_y 	 = 20
local default_width  = 500
local default_height = 70

ScrollText = class("ScrollText",function ()
	local obj = cc.Node:create()
	return obj
end)


--[[
	info = {
		parent,
		pos,
		size = {width,height},
	}
]]
function ScrollText.create(info)
	local obj = ScrollText.new()
	if obj and info.parent ~= nil then
		info.parent:addChild(obj)
		obj:init(info)
	end

	return obj
end

function ScrollText:init(info)
	self:init_data(info)
	self:init_ui()
	self:registerUpdate()
end


function ScrollText:init_data(info)
	self.cr_info = info
	self.text_item_lst = {
		--[x] = {obj,second,repeat_time,}
	}

	self.cur_scroll_time_add = 0
	self.cur_scroll_v = 0
	self.cur_scroll_index = -1
	self.bstop = false
end

function ScrollText:init_ui()
	self.clipp_obj = cc.ClippingNode:create()
	self:addChild(self.clipp_obj)
	self.clipp_obj:setContentSize(self.cr_info.size)
	self.clipp_obj:setAnchorPoint(0.5,0.5)
	self.clipp_obj:setPosition(self.cr_info.pos.x,self.cr_info.pos.y)

	self.item_node = cc.LayerColor:create(cc.c4b(0,0,0,0),self.cr_info.size.width,self.cr_info.size.height)
	self.item_node:setAnchorPoint(0,0)
	self.item_node:setPosition(0,0)
	self.clipp_obj:setStencil(self.item_node)
end

function ScrollText:registerUpdate()
	local function __on_update(dt)
		self:update(dt)
	end

	self:scheduleUpdateWithPriorityLua(__on_update,0)
end

function ScrollText:update(dt)

	if self.bstop == true then return end

	if #self.text_item_lst > 0 and self.cur_scroll_index ~= -1 then
		if self.cur_scroll_time_add >= self.text_item_lst[self.cur_scroll_index].second then
			

			if self.text_item_lst[self.cur_scroll_index].repeat_time ~= -1 then
				self.text_item_lst[self.cur_scroll_index].repeat_time = self.text_item_lst[self.cur_scroll_index].repeat_time - 1
			end
			
			if self.text_item_lst[self.cur_scroll_index].repeat_time > 0 or self.text_item_lst[self.cur_scroll_index].repeat_time == -1 then
				local new_item = self.text_item_lst[self.cur_scroll_index]
				new_item.obj:setPosition(self.cr_info.size.width,self.cr_info.size.height/2)
				new_item.obj:setVisible(false)
				table.insert(self.text_item_lst,new_item)
			else
				self.text_item_lst[self.cur_scroll_index].obj:removeFromParent()
			end
			table.remove(self.text_item_lst,self.cur_scroll_index)
			
			--self.cur_scroll_index = self.cur_scroll_index + 1
			if self.cur_scroll_index <= #self.text_item_lst then

				if self.text_item_lst[self.cur_scroll_index].obj == nil then
					self:create_new_item(self.text_item_lst[self.cur_scroll_index])
				end
				
				self.cur_scroll_v 		 = self.text_item_lst[self.cur_scroll_index].scroll_pixel/self.text_item_lst[self.cur_scroll_index].second
				if self.cur_scroll_v > max_scroll_v then
					self.cur_scroll_v = max_scroll_v
					self.text_item_lst[self.cur_scroll_index].second = self.text_item_lst[self.cur_scroll_index].scroll_pixel/self.cur_scroll_v
				end
				self.cur_scroll_time_add = 0
				
				
				self.text_item_lst[self.cur_scroll_index].obj:setVisible(true)
				--print("scroll cur_src = " .. "\" " .. self.text_item_lst[self.cur_scroll_index].txt .. " \"")
			end
		else
			self.cur_scroll_time_add = self.cur_scroll_time_add + dt
			local cur_scroll_s = math.floor(self.cur_scroll_time_add*self.cur_scroll_v)
			self.text_item_lst[self.cur_scroll_index].obj:setPositionX(self.cr_info.size.width - cur_scroll_s)
		end
	else
		self.cur_scroll_index = -1
	end
end

--[[
	item_info = {
		txt = "scroll text content",
		ft_size = 20,
		ft_color = cc.c4b(r,g,b,a)
		second = 5,
		repeat_time = 1,
	}
]]
function ScrollText:addItem(item_info)
	local tx_item_obj = {}

	tx_item_obj.second 		= item_info.second or 5
	tx_item_obj.repeat_time = item_info.repeat_time or 1

	tx_item_obj.txt 		= item_info.txt or ""
	tx_item_obj.ft_size 	= item_info.ft_size
	tx_item_obj.ft_color 	= item_info.ft_color
	tx_item_obj.text_type 	= item_info.text_type
	tx_item_obj.noticeid 	= item_info.noticeid

	if tx_item_obj.text_type == 4 then
		
		for i, v in pairs(self.text_item_lst) do

			if v and v.noticeid == tx_item_obj.noticeid then

				table.remove(text_item_lst, i)
				break
			end
		end
		return
	end

	table.insert(self.text_item_lst,tx_item_obj)

	--按type排序
	local function compareByType(a,b)
		return a.text_type > b.text_type
	end
	table.sort(tx_item_obj,compareByType)
	
	if self.cur_scroll_index == -1 then
		self.cur_scroll_index = 1
		self:create_new_item(self.text_item_lst[self.cur_scroll_index])
		self.cur_scroll_v = self.text_item_lst[self.cur_scroll_index].scroll_pixel/self.text_item_lst[self.cur_scroll_index].second
		if self.cur_scroll_v > max_scroll_v then
			self.cur_scroll_v = max_scroll_v
			self.text_item_lst[self.cur_scroll_index].second = self.text_item_lst[self.cur_scroll_index].scroll_pixel/self.cur_scroll_v
		end
		self.cur_scroll_time_add = 0
		print("scroll cur_src = " .. self.text_item_lst[self.cur_scroll_index].txt)
	end
end

function ScrollText:create_new_item(item)
	item.obj = ccui.Text:create()
	item.obj:ignoreContentAdaptWithSize(true)
	item.obj:setTextAreaSize(cc.size(0, 0))
	item.obj:setFontName("simhei.ttf")
	item.obj:setFontSize(item.ft_size)
	item.obj:setString(item.txt)
	item.obj:setAnchorPoint(0,0.5)
	item.obj:setPosition(self.cr_info.size.width,self.cr_info.size.height/2)
	item.obj:setColor(item.ft_color)
	local obj_sz 		= item.obj:getContentSize()
	item.scroll_pixel 	= obj_sz.width + self.cr_info.size.width
	self.clipp_obj:addChild(item.obj)
end

--[[
	item_info = {
		obj = nil,
		second = 5,
		repeat_time = 1,
	}
]]
function ScrollText:addObjItem(item_info)
	-- body
	if item_info and item_info.obj then
		local item_obj = {}
		item_obj.obj = item_info.obj
		item_obj.second = item_info.second
		item_obj.repeat_time = item_info.repeat_time
		item_obj.txt = "self define obj !"

		local sz = item_obj.obj:getContentSize()
		item_obj.scroll_pixel = sz.width + self.cr_info.size.width

		item_obj.obj:setAnchorPoint(0,0.5)
		item_obj.obj:setPosition(self.cr_info.size.width,self.cr_info.size.height/2)
		item_obj.obj:setVisible(false)

		table.insert(self.text_item_lst,item_obj)
		self.clipp_obj:addChild(item_obj.obj)

		if self.cur_scroll_index == -1 then
			self.cur_scroll_index = 1
			self.text_item_lst[self.cur_scroll_index].obj:setVisible(true)
			self.cur_scroll_v = self.text_item_lst[self.cur_scroll_index].scroll_pixel/self.text_item_lst[self.cur_scroll_index].second
			if self.cur_scroll_v > max_scroll_v then
				self.cur_scroll_v = max_scroll_v
				self.text_item_lst[self.cur_scroll_index].second = self.text_item_lst[self.cur_scroll_index].scroll_pixel/self.cur_scroll_v
			end
			self.cur_scroll_time_add = 0
			print("scroll cur_src = " .. self.text_item_lst[self.cur_scroll_index].txt)
		end
	end
end

function ScrollText:getScrollLength()
	return #self.text_item_lst
end

function ScrollText:setSopScroll(bstop)
	self.bstop = bstop
end

function ScrollText:clear()
	for k,v in pairs(self.text_item_lst) do
		if v.obj then
			v.obj:removeFromParent()
		end
	end
	self.text_item_lst = {}
	self.cur_scroll_time_add = 0
	self.cur_scroll_v = 0
	self.cur_scroll_index = -1
end

