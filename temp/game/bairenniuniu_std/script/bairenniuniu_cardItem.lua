local carTypeResPathlist = {"game/bairenniuniu_std/resource/word/wn.png",
	"game/bairenniuniu_std/resource/word/n1.png",
	"game/bairenniuniu_std/resource/word/n2.png",
	"game/bairenniuniu_std/resource/word/n3.png",
	"game/bairenniuniu_std/resource/word/n4.png",
	"game/bairenniuniu_std/resource/word/n5.png",
	"game/bairenniuniu_std/resource/word/n6.png",
	"game/bairenniuniu_std/resource/word/n7.png",
	"game/bairenniuniu_std/resource/word/n8.png",
	"game/bairenniuniu_std/resource/word/n9.png",
	-- "game/bairenniuniu_std/resource/word/nn.png",
	-- "game/bairenniuniu_std/resource/word/shn.png",
	-- "game/bairenniuniu_std/resource/word/szn.png",
	-- "game/bairenniuniu_std/resource/word/whn.png",
	-- "game/bairenniuniu_std/resource/word/wxn.png",
}

CBaiRenNiuNiuCardItem = class("CBaiRenNiuNiuCardItem",function()
	local  ret = cc.Node:create()
	return ret
end)


function CBaiRenNiuNiuCardItem.create(dir)
	-- body
	local node = CBaiRenNiuNiuCardItem.new()
	if node ~= nil then
		node:init_ui(dir)
		return node
	end
end

function CBaiRenNiuNiuCardItem:init_ui(dir)
	if dir == 1 then
		panel_ui = require "game.bairenniuniu_std.script.ui_create.ui_bairenniuniu_carItem1"
	elseif dir == 2 then
		panel_ui = require "game.bairenniuniu_std.script.ui_create.ui_bairenniuniu_carItem2"
	elseif dir == 3 then
		panel_ui = require "game.bairenniuniu_std.script.ui_create.ui_bairenniuniu_carItem3"
	elseif dir == 4 then
		panel_ui = require "game.bairenniuniu_std.script.ui_create.ui_bairenniuniu_carItem4"
	else
		panel_ui = require "game.bairenniuniu_std.script.ui_create.ui_bairenniuniu_carItem5"
	end

	self.id = dir
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.imgMask:setVisible(false)
	self:resetGame()
end

function CBaiRenNiuNiuCardItem:clearInfo()
	self.panel_ui.imgMask:setVisible(false)
	self.isEnabled = false
end


function CBaiRenNiuNiuCardItem:resetGame()
	self.panel_ui.imgMask:setVisible(false)
	self.panel_ui.imgCardType:setVisible(false)
	self.panel_ui.imgCardTypeBG:setVisible(false)

	if self._cardImgArr then
		for k,v in pairs(self._cardImgArr) do
			v:removeFromParent()
		end
	end
	self._cardImgArr = {}
	self._cardImgMap = {}
	self.cardsPosx= nil
	self.cardType = nil 
	self.cardList = nil
	if self.effectMap ~= nil then
		self.effectMap:removeFromParent()
		self.effectMap = nil 
	end
	-- self.effectMap = nil
	self.curCardNum = 0

	self._selectCards = {}
	self.panel_ui.imgMask:stopAllActions()
end

function CBaiRenNiuNiuCardItem:setCardInfo(cardsInfo)
	self.cardList = cardsInfo.cards
	self.cardType = cardsInfo.cardsType
	
end

--牌型及特效
function CBaiRenNiuNiuCardItem:showCardType()
	local sex = 0
	if self.id < 5 then
		sex = 0
	else
		sex = 1
	end
	if self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.SI_ZHA then
		audio_manager:playPlayerSound(6, sex)
	elseif self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.MEI_NIU then
		audio_manager:playPlayerSound(10, sex)
	elseif self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.NIU_1 then
		audio_manager:playPlayerSound(11, sex)
	elseif self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.NIU_2 then
		audio_manager:playPlayerSound(12, sex)
	elseif self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.NIU_3 then
		audio_manager:playPlayerSound(13, sex)
	elseif self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.NIU_4 then
		audio_manager:playPlayerSound(14, sex)
	elseif self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.NIU_5 then
		audio_manager:playPlayerSound(15, sex)
	elseif self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.NIU_6 then
		audio_manager:playPlayerSound(16, sex)
	elseif self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.NIU_7 then
		audio_manager:playPlayerSound(17, sex)
	elseif self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.NIU_8 then
		audio_manager:playPlayerSound(18, sex)
	elseif self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.NIU_9 then
		audio_manager:playPlayerSound(19, sex)
	elseif self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.NIU_NIU then
		audio_manager:playPlayerSound(20, sex)
	elseif self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.WU_XIAO then
		audio_manager:playPlayerSound(21, sex)
	elseif self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.WU_HUA then
		audio_manager:playPlayerSound(25, sex)
	elseif self.cardType == CBaiRenNiuNiuCardCheck.CardsKinds.SI_HUA then
		audio_manager:playPlayerSound(26, sex)
	end
	local effectSpr
	if self.cardType >= CBaiRenNiuNiuCardCheck.CardsKinds.NIU_NIU then
		local effectData = bairenniuniu_effect_config[self.cardType]
			self.effectMap = animationUtils.createAndPlayAnimationNoAutoRemove(self.panel_ui.nodeCard,effectData)
			self.effectMap:setAnchorPoint(0.5,0.5)
			self.effectMap:setPosition(cc.p(0,-70))
	else
		self.panel_ui.imgCardType:loadTexture(carTypeResPathlist[self.cardType + 1])
		self.panel_ui.imgCardType:setVisible(true)
		self.panel_ui.imgCardTypeBG:setVisible(true)
	end
	-- self.panel_ui.imgCardType:setTexture(carTypeResPathlist[self.cardType + 1])
	-- self.panel_ui.imgCardType:setVisible(true)
end


function CBaiRenNiuNiuCardItem:addCard()
	if self.cardList and self.curCardNum < 5 then
		self.curCardNum = self.curCardNum + 1
		local cardImg = ccui.ImageView:create()
		if self.curCardNum == 5 then
			cardImg:loadTexture(bairenniuniu_card_data[55].card_big, 1)
		else
			local cardId  = self.cardList[self.curCardNum]
			cardImg:loadTexture(bairenniuniu_card_data[cardId].card_big, 1)
		end
		self.panel_ui.nodeCard:addChild(cardImg)
		table.insert(self._cardImgArr, cardImg)
		local cardSize = cardImg:getContentSize()
		local num = #self._cardImgArr
		local beginX = -(num - 1)*cardSize.width/8
		for i,v in ipairs(self._cardImgArr) do
			if i ==5 then
				i = 3
				local px = beginX + (i - 1) * cardSize.width/4
				v:setPosition(px-10,-30)
			else
				local px = beginX + (i - 1) * cardSize.width/4
				v:setPositionX(px)
			end
			-- local px = beginX + (i - 1) * cardSize.width/4
			-- dump(px)
			-- v:setPositionX(px)
			self.cardsPosx = beginX +cardSize.width
		end
	end
end

function CBaiRenNiuNiuCardItem:showHiddenCard()
	local cardId  = self.cardList[5]
	self._cardImgArr[5]:loadTexture(bairenniuniu_card_data[cardId].card_big,1)
	self._cardImgArr[5]:setVisible(true)
	self._cardImgArr[5]:setPosition(self.cardsPosx,2)
	audio_manager:playOtherSound(6, false)
end

function CBaiRenNiuNiuCardItem:addFlopCard()
	self.flopCardImg = ccui.ImageView:create()
	local cardId  = self.cardList[5]
	self.flopCardImg:loadTexture(bairenniuniu_card_data[cardId].card_sm, 1)
	self.flopCardImg:setAnchorPoint(0.5,0.5)
	self.flopCardImg:setPosition(cc.p(217,90))
	self.flopEffect:addChild(self.flopCardImg)
	performWithDelay(self, function () self:removeFlopCard() end, 1.0)
end

function CBaiRenNiuNiuCardItem:removeFlopCard()
	if self.flopEffect then
		self.flopEffect:removeFromParent()
		self.flopEffect = nil
	end
	self:playFlyAnimation()
	performWithDelay(self, function () 
		self:showCards() 
		self:showCardType()
		end, 0.5)
	-- performWithDelay(self, function () self:showCardType() end, 0.8)	
end

--飞牌动画
function CBaiRenNiuNiuCardItem:playFlyAnimation()
	local effectData = bairenniuniu_effect_config["翻牌2"]
	self.flyEffect = animationUtils.createAndPlayAnimation(self.panel_ui.nodeEffect,effectData,
		function () self:showHiddenCard() end)
	self.flyEffect:setAnchorPoint(0.5,0.5)	
	self.flyEffect:setPosition(cc.p(-10,-75))
end

--翻牌动画
function CBaiRenNiuNiuCardItem:playFlopAnimation()
	self._cardImgArr[5]:setVisible(false)
	local posx,posY = self.panel_ui.nodeCard:getPosition()
	local effectData = bairenniuniu_effect_config["翻牌1"]
	self.flopEffect = animationUtils.createAndPlayAnimationNoAutoRemove(self.panel_ui.nodeEffect,effectData)
	self.flopEffect:setPosition(cc.p(-10,-55))
	local move_action = cc.MoveBy:create(0.1, cc.p(0,-20))
	self.flopEffect:runAction(move_action)
	performWithDelay(self, function () self:addFlopCard() end, 0.7)
end

function CBaiRenNiuNiuCardItem:showCards()
	if self.cardType > CBaiRenNiuNiuCardCheck.CardsKinds.MEI_NIU then
		for k,v in pairs(self._cardImgArr) do
			v:removeFromParent()
		end
		self._cardImgArr = {}
		for i = 4, 5 do
			local res = bairenniuniu_card_data[self.cardList[i]].card_big
			local cardImg = ccui.ImageView:create(res,1)
			local cardSize = cardImg:getContentSize()
			local beginX = -cardSize.width/4
			local px = beginX + (i - 4) * cardSize.width/2
			cardImg:setPosition(px, cardSize.height/3)
			table.insert(self._cardImgArr, cardImg)
			self.panel_ui.nodeCard:addChild(cardImg)
		end
		
		for i = 1, 3 do
			local res = bairenniuniu_card_data[self.cardList[i]].card_big
			local cardImg = ccui.ImageView:create(res,1)
			local cardSize = cardImg:getContentSize()
			local beginX = -cardSize.width/2
			local px = beginX + (i - 1) * cardSize.width/2
			cardImg:setPosition(px, 0)

			table.insert(self._cardImgArr, cardImg)
			self.panel_ui.nodeCard:addChild(cardImg)
		end
	else
		for k,v in pairs(self._cardImgArr) do
			v:removeFromParent()
		end
		self._cardImgArr = {}

		for i = 1, 5 do
			local res = bairenniuniu_card_data[self.cardList[i]].card_big
			local cardImg = ccui.ImageView:create(res,1)
			local cardSize = cardImg:getContentSize()
			local beginX = -4*cardSize.width/8
			local px = beginX + (i - 1) * cardSize.width/4
			cardImg:setPosition(px, 0)

			table.insert(self._cardImgArr, cardImg)
			self.panel_ui.nodeCard:addChild(cardImg)
		end
	end
end

--设置结算信息
function CBaiRenNiuNiuCardItem:setBalance(value)
	if value == 1 then
		self.panel_ui.imgMask:runAction(cc.RepeatForever:create(cc.Blink:create(1,1)))
	end
end