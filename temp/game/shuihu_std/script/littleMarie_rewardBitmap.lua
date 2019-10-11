--[[
小玛丽  icon  对象
]]

CLittleMarie_rewardBitmap = class("CLittleMarie_rewardBitmap",function()
	-- body
	local  ret = cc.Sprite:create()
	ret:setAnchorPoint(0.5,0.5)
	return ret
end)

function CLittleMarie_rewardBitmap.create()
	-- body
	local layer = CLittleMarie_rewardBitmap.new()
	if layer ~= nil then
		return layer
	end
end

function CLittleMarie_rewardBitmap:initBitmapInfo(index, id)
	self.icon_resPath = "game/shuihu_std/resource/image/xml_icon/"..id..".png"
	self.id = id
	self.myIndex = index

	self:setTexture(self.icon_resPath)
end

function CLittleMarie_rewardBitmap:setDisplay(curIndex)
	if self.myIndex == curIndex then
		self:setVisible(true)
		audio_manager:playOtherSound(54)
	else
		self:setVisible(false)
	end
end


