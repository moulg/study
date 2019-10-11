--[[
汽车icon对象
]]

CFS_rewardBitmap = class("CFS_rewardBitmap",function()
	-- body
	local  ret = cc.Sprite:create()
	ret:setAnchorPoint(0.5,0.5)
	return ret
end)

function CFS_rewardBitmap.create()
	-- body
	local layer = CFS_rewardBitmap.new()
	if layer ~= nil then
		return layer
	end
end

function CFS_rewardBitmap:initBitmapInfo(index, id)
	self.icon_resPath = "game/4s_std/resource/image/icon/"..id.."_1.png" 
	self.id = id
	self.myIndex = index

	self:setTexture(self.icon_resPath)
end

function CFS_rewardBitmap:setDisplay(curIndex)
	if self.myIndex == curIndex then
		self:setVisible(true)
	else
		self:setVisible(false)
	end
end


