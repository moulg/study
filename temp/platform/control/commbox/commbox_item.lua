#remark
--[[
	组合框项
]]

CommboxItem = class("CommboxItem",function ()
	local  obj = ccui.ImageView:create()
	obj:setScale9Enabled(true)
	return obj
end)


--[[
	info = {
		src_nor,
		src_mov,
		src_down,
		txt_key,
		ft_size,
		ft_name,
		ft_color,
		call,
		item_w,
		item_h,
	}
]]
function CommboxItem.create(info)
	local obj = CommboxItem.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function CommboxItem:init(info)
	self:init_data(info)
	self:init_ui()
	self:registerEE()
end

function CommboxItem:init_data(info)
	self.src_nor = info.src_nor
	self.src_mov = info.src_mov
	self.src_down = info.src_down

	self.key  = info.txt_key
	self.ft_name = info.ft_name

	self.ft_size = 14
	if info.ft_size and type(info.ft_size) == "number" then
		self.ft_size = info.ft_size
	end

	self.ft_color = cc.c3b(0,0,0)
	if info.ft_color then self.ft_color = info.ft_color end

	self.call = info.call

	self.item_w = info.item_w
	self.item_h = info.item_h
end

function CommboxItem:init_ui()
	local size = {width = self.item_w,height = self.item_h,}
	self:setContentSize(size)

	--create btn
	if self.src_nor and type(self.src_nor) == "string" then
		local spr = cc.Sprite:create(self.src_nor)
		size = spr:getContentSize()
		spr  = nil
	end
	local pos = {x = (self.item_w - size.width)/2,y = (self.item_h - size.height)/2,}
	self.item_btn = uiUtils.createBtn(pos,size,self.src_nor,self.src_down,self.src_dis)
	self:addChild(self.item_btn)
	if self.src_mov then
		local mov_obj = cc.Sprite:create(self.src_mov)
		WindowScene.getInstance():registerBtnMouseMoveEff(self.item_btn,mov_obj,1)
	end

	--create text
	self.text_obj = ccui.Text:create()
	self.text_obj:setFontSize(self.ft_size)
	self.text_obj:setString(self.key)
	self.text_obj:setAnchorPoint(0,0.5)
	self.text_obj:setPosition(5, size.height/2)
	self.text_obj:setColor(self.ft_color)
	self.item_btn:addChild(self.text_obj)

	--register btn event
	self.item_btn:onTouch(function (e)
		if e.name == "ended" then
			if self.call then self.call(self.key) end
		end
	end)
end

function CommboxItem:registerEE()
	local function __on_enter_exit(event)
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__on_enter_exit)
end

function CommboxItem:onEnter()
	
end

function CommboxItem:onExit()
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.item_btn)
end

function CommboxItem:setItemSelectState(bselect)
	if bselect ~= nil then
		WindowScene.getInstance():setBtnMoveEffState(self.item_btn,bselect)
	end
end

function CommboxItem:getItemSelectState()
	
end


