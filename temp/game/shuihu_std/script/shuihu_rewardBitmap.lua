--[[
水浒传  icon  对象
]]

local borderImgRes = {
	[1] = "game/shuihu_std/resource/image/kuang/BORDER_02.png", --全盘奖的框
	[2] = "game/shuihu_std/resource/image/kuang/BORDER_03.png", --3连
	[3] = "game/shuihu_std/resource/image/kuang/BORDER_04.png", --4连
	[4] = "game/shuihu_std/resource/image/kuang/BORDER_05.png", --5连
}

CShuihu_rewardBitmap = class("CShuihu_rewardBitmap",function()
	-- body
	local  ret = cc.Sprite:create()
	ret:setAnchorPoint(0.5,0.5)
	return ret
end)

function CShuihu_rewardBitmap.create()
	-- body
	local layer = CShuihu_rewardBitmap.new()
	if layer ~= nil then
		layer:init()
		return layer
	end
end

function CShuihu_rewardBitmap:init()
	self.slotMachineCon = CSlotMachineCon.create(CSlotMachineCon.NORMAL_ALL)
	self:addChild(self.slotMachineCon)
end

--设置 特效边框的父节点
function CShuihu_rewardBitmap:setBorderCon(borderCon)
	self._borderCon = borderCon
	self.imgBorder = display.newSprite(borderImgRes[2])
	self._borderCon:addChild(self.imgBorder)
	self.imgBorder:setPosition(self:getPositionX(), self:getPositionY())
	self.imgBorder:setVisible(false)
	self.imgBorder:setLocalZOrder(100)
end

--设置 特效边框纹理
function CShuihu_rewardBitmap:setBorderTexture(type)
	self.imgBorder:setTexture(borderImgRes[type])
end

function CShuihu_rewardBitmap:initBitmapInfo(id)
	self.icon_resPath = "game/shuihu_std/resource/image/normal_icon/"..id..".png"
	self.iconGray_resPath = "game/shuihu_std/resource/image/gray_icon/"..id..".png"
	--图标id
	self.id = id

	self:setTexture(self.icon_resPath)
	self.slotMachineCon:setContentSize(self:getContentSize())
end

--设置奖励图标id   用于播发音效
function CShuihu_rewardBitmap:setRewardIconId(id)
	self.rewardId = id
end

function CShuihu_rewardBitmap:setIconGray()
	self:setTexture(self.iconGray_resPath)
end

--播发滚动动作
function CShuihu_rewardBitmap:playRollAction(callback)
	self.slotMachineCon:clearRewardList()
	self.slotMachineCon:setVisible(true)
	local arr = {}
	for i=2,9 do
		local reward = CShuihu_scrollBitmap.create()
		reward:initBitmapInfo(i)
		table.insert(arr, reward)
	end
	local rewardlist = CRewardList.create()
	local scrolldata = {}
	scrolldata.offset = -1
	scrolldata.state = CRewardList.ROLL_UP_DOWN
	scrolldata.dir = 1
	scrolldata.stopType = CRewardList.IMMEDIATELY_STOP

	rewardlist:initRewards(arr, scrolldata)
	rewardlist:setPosition(0,0)
	self.slotMachineCon:addRewardList( rewardlist )
	self.slotMachineCon:setRewardListSpeed( 1 , 110 , 110 , 0 )
	self.slotMachineCon:setAnchorPoint(0,0)
	self.slotMachineCon:setPosition(0,0)
	self.slotMachineCon:startRoll( 2 )

	EventUtils.addEventListener( self.slotMachineCon.ALLLISTSTOP, self, function ()
		self.slotMachineCon:setVisible(false)

		if callback then
			callback()
		end
	end, true )
end

function CShuihu_rewardBitmap:hightLightAnimationCallBack()
	if self.hightLightSprite then
	    self.hightLightSprite:removeFromParent()
    end
	self.hightLightSprite = nil

	self.imgBorder:setVisible(false)

	if self.hightLightCallBack then
		self.hightLightCallBack()
		self.hightLightCallBack = nil
	end
end

function CShuihu_rewardBitmap:ActionAnimationCallBack()
	if self.actionSprite then
	    self.actionSprite:removeFromParent()
    end
	self.actionSprite = nil

	self.imgBorder:setVisible(false)


	if self.iconActionCallBack then
		self.iconActionCallBack()
		self.iconActionCallBack = nil
	end
end

function CShuihu_rewardBitmap:clearAnimation()

	if self.hightLightSprite then
		self.hightLightSprite:stopAllActions()
	    self.hightLightSprite:removeFromParent()
    end
	self.hightLightSprite = nil

	if self.actionSprite then
		self.actionSprite:stopAllActions()
	    self.actionSprite:removeFromParent()
    end
	self.actionSprite = nil

	self.imgBorder:setVisible(false)

	self.hightLightCallBack = nil
	self.iconActionCallBack = nil
end

--播发高亮特效
function CShuihu_rewardBitmap:playHightLightAnimation(callback)
	self.hightLightCallBack = callback
	local iconData = shuihu_icon_config[self.id]
	local animationid = iconData.effect1
	
	self.hightLightSprite = animationUtils.createAndPlayAnimation(self._borderCon, shuihu_effect_config[animationid], function ()
		self:hightLightAnimationCallBack()
	end)
	self.hightLightSprite:setAnchorPoint(0.5,0.5)
	self.hightLightSprite:setPosition(self:getPosition())

	self.imgBorder:setVisible(true)
end

--播发动作特效
function CShuihu_rewardBitmap:playActionAnimation(callback)
	self.iconActionCallBack = callback

	local iconData = shuihu_icon_config[self.id]
	local animationid = iconData.effect2
	
	self.actionSprite = animationUtils.createAndPlayAnimation(self._borderCon, shuihu_effect_config[animationid], function ()
		self:ActionAnimationCallBack()
	end)
	self.actionSprite:setAnchorPoint(0.5,0.5)
	self.actionSprite:setPosition(self:getPosition())

	self.imgBorder:setVisible(true)
end

--播放动作音效
function CShuihu_rewardBitmap:playActionMusic()
	local musicid = shuihu_icon_config[self.rewardId].music2
	audio_manager:playOtherSound(musicid)
end

--播放高光音效
function CShuihu_rewardBitmap:playHightLightMusic()
	local musicid = shuihu_icon_config[self.rewardId].music1
	audio_manager:playOtherSound(musicid)
end