#remark
--[[
	玩家头像
]]

local ui_create = require "lobby.ui_create.ui_RegAccount_Head1" 

PlayerHeadItem = class("PlayerHeadItem",function ()
	local obj = ccui.ImageView:create()
	obj:setScale9Enabled(true)
	return obj
end)

--[[
	item_info ={
		key,
		headId,
		click_call,
	}
]]
function PlayerHeadItem.create(item_info)
	local obj = PlayerHeadItem.new()
	if obj then
		obj:init(item_info)
	end

	return obj
end

function PlayerHeadItem:init(item_info)
	self:init_data(item_info)
	self:init_ui()
	self:registerEE()
end


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。


function PlayerHeadItem:init_data(item_info)
	self.item_info = item_info
end

function PlayerHeadItem:init_ui()
	self.ui_obj_lst = ui_create.create()
	self:addChild(self.ui_obj_lst.root)

	self.ui_obj_lst.Image_1:loadTexture(self.item_info.img_src)
	local size = self.ui_obj_lst.btnhead:getContentSize()
	--self.ui_obj_lst.Image_1:setLocalZOrder(11)
	self.ui_obj_lst.Image_1:setTouchEnabled(false)
	self:setContentSize(size)

	--uiUtils:setPlayerHead(self.ui_obj_lst.Image_1, self.item_info.headId, self.item_info.size)

	self.ui_obj_lst.btnhead:onTouch(function (e) self:onHeadClick(e) end)
	local mov_obj = cc.Sprite:create("lobby/resource/head/touxk2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.ui_obj_lst.btnhead,mov_obj,1)
	--self.ui_obj_lst.btnhead:setLocalZOrder(10)

	-- self.select_spr = cc.Sprite:create("lobby/resource/head/touxk3.png")
	-- local x,y = self.ui_obj_lst.btnhead:getPosition()
	-- self.select_spr:setPosition(x,y)
	-- self:addChild(self.select_spr,10)
	--self.select_spr = self.ui_obj_lst.select_spr

	self.ui_obj_lst.select_spr:setVisible(false)
end

function PlayerHeadItem:registerEE()
	local function __enter_exit(e)
		if e == "enter" then
			self:onEnter()
		elseif e == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__enter_exit)
end

function PlayerHeadItem:onEnter()
	
end

function PlayerHeadItem:onExit()
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_obj_lst.btnhead)
end

function PlayerHeadItem:onHeadClick(e)
	if e.name == "ended" then
		if self.item_info.click_call then self.item_info.click_call(self.item_info.key,self) end
	end
end

function PlayerHeadItem:destroy()
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_obj_lst.btnhead)
end

function PlayerHeadItem:setSelected(bsel)
	self.ui_obj_lst.select_spr:setVisible(bsel)
end

function PlayerHeadItem:setHeadImage(src)
	if src then self.ui_obj_lst.Image_1:loadTexture(src) end
end
