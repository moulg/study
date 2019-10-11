#remark
--[[
	全屏滚动字幕
]]

ScrollHitText = class("ScrollHitText",function ()
	local obj = cc.Layer:create()
	return obj
end)


function ScrollHitText.create(size)
	local obj = ScrollHitText.new()
	if obj then obj:init(size) end

	return obj
end

function ScrollHitText:init(size)
	self:init_ui(size)
	self:registerUpdate()
end

function ScrollHitText:init_ui(size)
	self.spr_back = cc.Sprite:create("lobby/resource/hall_res/gb.png")
	self:addChild(self.spr_back)
	local spr_size = self.spr_back:getContentSize()
	self.spr_back:setPosition(spr_size.width/2-30,spr_size.height/2)

	local info = {
		parent = self.spr_back,
		pos  = {x = spr_size.width/2 + 30,y = spr_size.height/2},
		size = {width = spr_size.width - 70,height = spr_size.height},
	}

	if size then
		info.size = size
	end

	self.ad_text_obj = ScrollText.create(info)

	self.bshow_scroll_obj = false
	self.bstop = false
end

function ScrollHitText:setCustomSize(size)
	self.ad_text_obj.clipp_obj:setContentSize(size)
end

function ScrollHitText:registerUpdate()
	self:scheduleUpdateWithPriorityLua(function (dt) self:update(dt) end,0)
end

function ScrollHitText:update(dt)
	if self.bshow_scroll_obj == true and self.ad_text_obj:getScrollLength() <= 0 then
		self:setVisible(false)
		self.bshow_scroll_obj = false
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
function ScrollHitText:addText(item_info)
	self.bshow_scroll_obj = true
	self.ad_text_obj:addItem(item_info)
--s	print("scroll len = " .. self.ad_text_obj:getScrollLength())

	if self.bstop == false then
		self:setVisible(true)
	end
end


--[[
	item_info = {
		obj = nil,
		second = 5,
		repeat_time = 1,
	}
]]
function ScrollHitText:addObj(item_info)
	self.bshow_scroll_obj = true
	self.ad_text_obj:addObjItem(item_info)	
end

function ScrollHitText:setScrollHitTextState(bshow,bstop)
	-- body

	self:setVisible(bshow)
	self.ad_text_obj:setSopScroll(bstop)
	self.bstop = bstop

	if self.bshow_scroll_obj == false then
		self:setVisible(false)
	end
end

function ScrollHitText:clear()
	self.ad_text_obj:clear()
end



