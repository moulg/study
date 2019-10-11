#remark
--[[
	活动广告
]]
local ui_create = require "lobby.ui_create.ui_GameHall_Ad"

ActiveAd = class("ActiveAd",function ()
	local obj = cc.Layer:create()
	return obj
end)


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

--[[
	info = {
		parent,
		pos,
	}
]]
function ActiveAd.create(info)
	local obj = ActiveAd.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function ActiveAd:init(info)
	-- body
	self.parent = info.parent
	self.pos = info.pos
	self.parent:addChild(self)
	self:setPosition(self.pos.x,self.pos.y)

	self:init_ui()
end

function ActiveAd:init_ui()
	self.ui_lst = ui_create.create()
	self:addChild(self.ui_lst.root)

	local size 	= {width = 173,height = 195,}
	local pos 	= {x = 10,y = 10,}
	local src_btn 	= "lobby/resource/reg_res/QUAN.png"
	local src_click = "lobby/resource/reg_res/QUAN_.png"
	self.adv_player_obj = AD_PageView.create(size,pos,src_btn,src_click)
	self.adv_player_obj:setLocalZOrder(100)
	self:addChild(self.adv_player_obj)
	self.adv_player_obj:setShowBtn(true)

	--local t = 5
	for i=1,#lobby_advertising_cfg do
		local item_info = {
			src 	= lobby_advertising_cfg[i].src_nor,
			realm 	= lobby_advertising_cfg[i].realm_name,
		}
		local item = AdvItem.create(item_info)
		self.adv_player_obj:addPage(item)
		--t = lobby_advertising_cfg[i].t
	end

	self.adv_player_obj:setAutoScrollPage(true,5)
end

