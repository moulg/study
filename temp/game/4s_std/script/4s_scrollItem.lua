--[[
彩金滚动对象
]]

CFS_scrollItem = class("CFS_scrollItem",function()
	-- body
	local  ret = cc.Sprite:create()
	return ret
end)

function CFS_scrollItem.create()
	-- body
	local layer = CFS_scrollItem.new()
	if layer ~= nil then
		return layer
	end
end

function CFS_scrollItem:initBitmapInfo(id)
	self.icon_resPath = "game/4s_std/resource/image/lottery/"..id..".png"
	self.id = id

	self:setTexture(self.icon_resPath)
	self:getTexture():setAntiAliasTexParameters()
end

--创建遮罩
function CFS_scrollItem:createMask()
	return display.newSprite(self.icon_resPath)
end

