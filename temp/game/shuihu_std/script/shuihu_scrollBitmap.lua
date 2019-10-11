--[[
水浒传  转动  对象
]]

CShuihu_scrollBitmap = class("CShuihu_scrollBitmap",function()
	-- body
	local  ret = cc.Sprite:create()
	return ret
end)

function CShuihu_scrollBitmap.create()
	-- body
	local layer = CShuihu_scrollBitmap.new()
	if layer ~= nil then
		return layer
	end
end

function CShuihu_scrollBitmap:initBitmapInfo(id)
	self.icon_resPath = "game/shuihu_std/resource/image/scroll_icon/GUNDONG_0"..id..".png"
	self.id = id

	self:setTexture(self.icon_resPath)
	self:getTexture():setAntiAliasTexParameters()
end

--创建遮罩
function CShuihu_scrollBitmap:createMask()
	return display.newSprite(self.icon_resPath)
end