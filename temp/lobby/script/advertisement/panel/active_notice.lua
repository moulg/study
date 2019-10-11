#remark
--[[
	活动公告
]]

local ui_create = require "lobby.ui_create.ui_GameHall_Notice"


ActiveNotice = class("ActiveNotice",function ()
	local obj = cc.Layer:create()
	return obj
end)

--[[
	info = {
		parent,
		pos,
	}
]]
function ActiveNotice.create(info)
	local obj = ActiveNotice.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function ActiveNotice:init(info)
	self.pos = info.pos
	self.parent = info.parent
	self.parent:addChild(self)
	self:setPosition(info.pos.x,info.pos.y)
	self:init_ui()

	for i=1,20 do
		self:addAdvNotice("测试测试测试测试测试" .. i,cc.c3b(225,10*i,2*i*i))
	end
end

function ActiveNotice:init_ui()
	self.ui_lst = ui_create.create()
	self:addChild(self.ui_lst.root)


	self.text_lst_obj = CSilderScroll.create()
	local size  = {width = 170,height = 168,}
	self.text_lst_obj:init_sliderScroll(size,0)
	self.text_lst_obj:setPosition(10,10)
	self.text_lst_obj:showHideSlider(false)
	self:addChild(self.text_lst_obj)
end

function ActiveNotice:addAdvNotice(text,color)
	local txt_item = ccui.Text:create()
	txt_item:ignoreContentAdaptWithSize(true)
	txt_item:setTextAreaSize(cc.size(0, 0))
	txt_item:setFontSize(15)
	txt_item:setCascadeColorEnabled(true)
	txt_item:setCascadeOpacityEnabled(true)
	txt_item:setAnchorPoint(0.0000,0.5000)

	txt_item:setString(text)
	txt_item:setColor(color)
	self.text_lst_obj:addObject(txt_item)
	self.text_lst_obj:refreshView()
end

