--[[
汽车icon对象
]]

CFS_rewardListBitmap = class("CFS_rewardListBitmap",function()
	-- body
	local  ret = cc.Sprite:create()
	ret:setAnchorPoint(0.5,0.5)
	return ret
end)

function CFS_rewardListBitmap.create()
	-- body
	local layer = CFS_rewardListBitmap.new()
	if layer ~= nil then
		return layer
	end
end

function CFS_rewardListBitmap:initBitmapInfo(index, id)
	self.icon_resPath = "game/4s_std/resource/image/icon/"..id.."_1.png" 
	self.id = id
	self.myIndex = index

	self:setTexture(self.icon_resPath)
end

function CFS_rewardListBitmap:setDisplay(curIndex)
	if curIndex%4 == 1 then
		audio_manager:playOtherSound(2, false)
	end
	fs_manager._finalId = curIndex
	if self.myIndex == curIndex then
		self.icon_resPath = "game/4s_std/resource/image/icon/"..self.id.."_1.png" 
		self:setTexture(self.icon_resPath)
		self:setVisible(true)
	elseif (self.myIndex == curIndex-1) or (self.myIndex == curIndex-1+32) then
		--self:setVisible(false)
		self.icon_resPath = "game/4s_std/resource/image/icon/"..self.id.."_2.png" 
		self:setTexture(self.icon_resPath)
		self:setVisible(true)
	elseif (self.myIndex == curIndex-2) or (self.myIndex == curIndex-2+32) then
		--self:setVisible(false)
		self.icon_resPath = "game/4s_std/resource/image/icon/"..self.id.."_3.png"  
		self:setTexture(self.icon_resPath)
		self:setVisible(true)
	elseif (self.myIndex == curIndex-3) or (self.myIndex == curIndex-3+32) then
		--self:setVisible(false)
		self.icon_resPath = "game/4s_std/resource/image/icon/"..self.id.."_4.png" 
		self:setTexture(self.icon_resPath)
		self:setVisible(true)
	else
		self:setVisible(false)
	end
end


