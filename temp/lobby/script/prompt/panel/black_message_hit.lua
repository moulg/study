#remark
--[[
	黑条提示信息
]]


local __ui_create = require "lobby.ui_create.ui_tips"

BlackMessageHit = class("BlackMessageHit",function ()
	local obj = cc.Node:create()
	return obj
end)

--[[
	info = {
		txt,
		color,
	}
]]
function BlackMessageHit.create(info)
	local obj = BlackMessageHit.new()
	if obj then
		obj:init(info)
	end


	return obj
end

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

function BlackMessageHit:init(info)
	if info then
		self.ui_lst = __ui_create.create()
		self:addChild(self.ui_lst.root)

		if info.txt then
			self.ui_lst.text:setString(info.txt)
		end

		if info.color then
			self.ui_lst.text:setColor(info.color)
		end

		local size = WindowScene.getInstance():getDesSize()
		local csize = self.ui_lst.hte_1:getContentSize()
		self:setPosition(size.w/2,size.h + csize.height/2)

		self:show()
	end
end

function BlackMessageHit:show()
	local csize = self.ui_lst.hte_1:getContentSize()
	local call_action = cc.CallFunc:create(function ()
 		WindowScene.getInstance():closeDlg(self)
	end)
	local act_arr = {cc.MoveBy:create(0.5,cc.p(0,-csize.height)),cc.DelayTime:create(1.2),cc.MoveBy:create(0.4,cc.p(0,csize.height)),call_action}
	self:runAction(cc.Sequence:create(act_arr))
end


