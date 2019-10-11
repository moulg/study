

CSharkRewardItem = class("CSharkRewardItem",function()
	local  ret = cc.Sprite:create()
	ret:setAnchorPoint(0.5,0.5)
	return ret
end)

function CSharkRewardItem.create()
	-- body
	local layer = CSharkRewardItem.new()
	if layer ~= nil then
		return layer
	end
end

function CSharkRewardItem:initIconInfo(indexId, iconId)
	self.id = indexId
	self.iconId = iconId

	if self.iconId == 10 then
		self:setTexture("game/shark_std/resource/image/kbjjs.png")
	else
		self:setTexture("game/shark_std/resource/image/kbj.png")
	end

	
	self._animalSpr = cc.Sprite:create("game/shark_std/resource/image/icon/"..self.iconId..".png")
	self:addChild(self._animalSpr)
	local size = self:getContentSize()
	self._animalSpr:setPosition(size.width/2, size.height/2)
	self._animalSpr:setLocalZOrder(2)
end

function CSharkRewardItem:setDisplay(curIndex)
	if self.highLightEff then
		self.highLightEff:stopAllActions()
		self.highLightEff:removeFromParent()
		self.highLightEff = nil
	end

	if curIndex == self.id then
		local effectData
		if self.iconId == 10 then
			effectData = shark_effect_config["金框特效"]
		else
			if curIndex >= 1 and curIndex <= 13 then
				effectData = shark_effect_config["红框特效"]
			else
				effectData = shark_effect_config["绿框特效"]
			end
		end

		self.highLightEff = animationUtils.createAndPlayAnimation(self, effectData)	
		self.highLightEff:setAnchorPoint(0,0)
		self.highLightEff:setPosition(0,0)
		self.highLightEff:setLocalZOrder(1)

		shark_manager:setRewardPool( self.iconId )
	end
end

function CSharkRewardItem:playAction()
	self._animalEffect = animationUtils.createAndPlayAnimation(self, shark_effect_config[self.iconId])
	local size = self:getContentSize()
	self._animalEffect:setPosition(size.width/2, size.height/2)
	self._animalEffect:setLocalZOrder(3)

	self._animalSpr:setVisible(false)
end

function CSharkRewardItem:reset()
	if self._animalEffect then
		self._animalEffect:stopAllActions()	
		self._animalEffect:removeFromParent()
		self._animalEffect = nil
	end

	self._animalSpr:setVisible(true)
end