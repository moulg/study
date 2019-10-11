--[[
魏蜀吴发牌界面
]]


local panel_ui = require "game.weishuwu_std.script.ui_create.ui_weishuwu_desk"

CWeishuwuSendcard = class("CWeishuwuSendcard", function ()
	local ret = cc.Node:create()
	return ret
end)


function CWeishuwuSendcard.create()
	local node = CWeishuwuSendcard.new()
	if node ~= nil then
		-- node:initData()
		node:init_ui()
		return node
	end
end
function CWeishuwuSendcard:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0.5,0)
	self.nodeCard={self.panel_ui.NodePoker1,self.panel_ui.NodePoker2}

	self._cardImgArr={}
	self._gamblecardImgArr={}

	-- self.cardList={}
	-- self.cardType={}
	-- self.curCardNum = 0
	-- self.palyerCards = {}

	self.imgLogoList = {self.panel_ui.Img_log1,self.panel_ui.Img_log2,self.panel_ui.Img_log3,}
	for k,v in pairs(self.imgLogoList) do
		v:setVisible(false)
	end

	self.imgGamblelist = {self.panel_ui.ImgBPW1,self.panel_ui.ImgBPW2,self.panel_ui.ImgBPW3,
							self.panel_ui.ImgBPW4,self.panel_ui.ImgBPW5,self.panel_ui.ImgBPW6}
	for k,v in pairs(self.imgGamblelist) do
		v:setVisible(false)
	end
	self.FntDianlist = {self.panel_ui.FntDian1,self.panel_ui.FntDian2,self.panel_ui.FntDian3,self.panel_ui.FntDian4}
	for k,v in pairs(self.FntDianlist) do
		v:setVisible(false)
	end
	self.panel_ui.ImgDBG1:setVisible(false)
	self.panel_ui.ImgDBG2:setVisible(false)
	self.panel_ui.ImgBPBG:setVisible(false)
	self.powerpalyer=0
	self.powerbanker=0
end
function CWeishuwuSendcard:restGame()
	for k,imgCard in pairs(self._cardImgArr) do
		if imgCard ~= nil then 				
			imgCard:removeFromParent()
			imgCard = nil
		end
	end
	for k,v in pairs(self._gamblecardImgArr) do
		-- if gambleCardImg ~= nil then 				
			v:removeFromParent()
			v = nil
		-- end
	end
	for k,v in pairs(self.imgLogoList) do
		v:setVisible(false)
	end

	for k,v in pairs(self.imgGamblelist) do
		v:setVisible(false)
	end

	for k,v in pairs(self.FntDianlist) do
		v:setVisible(false)
	end
	self.panel_ui.ImgDBG1:setVisible(false)
	self.panel_ui.ImgDBG2:setVisible(false)
	self.panel_ui.ImgBPW3:setTexture(weishuwu_imageRes_config["蜀不补牌"].resPath)
	self.panel_ui.ImgBPW6:setTexture(weishuwu_imageRes_config["吴不补牌"].resPath)

	self.panel_ui.ImgBPBG:setVisible(false)

	self._cardImgArr = {}
	self._gamblecardImgArr = {}
	self.powerpalyer = 0
	self.powerbanker = 0
end

function CWeishuwuSendcard:setCardInfo()
	if cardsInfo.id == 0 then
		self.bankerCards = cardsInfo.cards
		table.insert(self.cardList,self.bankerCards)
	else
		self.palyerCards = cardsInfo.cards
		table.insert(self.cardList,self.palyerCards)
	end
end
--显示前两张牌的牌型点数
function CWeishuwuSendcard:showCardType(cardsInfo)
	-- dump(cardsInfo.palyerpower)
	if cardsInfo.palyerpower~=nil then		
		self.powerpalyer= (self.powerpalyer + cardsInfo.palyerpower)%10
		-- dump(self.powerpalyer)
		self.panel_ui.ImgDian1:setTexture(weishuwu_imageRes_config[self.powerpalyer].resPath)
		self.panel_ui.ImgDBG1:setVisible(true)

		self.panel_ui.FntDian1:setString(self.powerpalyer)
		self.panel_ui.FntDian1:setVisible(true)
	end
	if cardsInfo.bankerpower~=nil then		
		self.powerbanker= (self.powerbanker + cardsInfo.bankerpower)%10
		-- dump(self.powerbanker)
		self.panel_ui.ImgDian2:setTexture(weishuwu_imageRes_config[self.powerbanker].resPath)
		self.panel_ui.ImgDBG2:setVisible(true)
		self.panel_ui.FntDian2:setString(self.powerbanker)
		self.panel_ui.FntDian2:setVisible(true)
	end
end

function CWeishuwuSendcard:addCard(cardsInfo)
	print("添加手牌")
	-- dump(cardsInfo)
	local cardImg = ccui.ImageView:create()		
	local cardId  = cardsInfo.cardId
	cardImg:loadTexture(weishuwu_card_data[cardId].card_big, 1)
	self.nodeCard[cardsInfo.node]:addChild(cardImg)
	table.insert(self._cardImgArr, cardImg)
	local cardSize = cardImg:getContentSize()
	local num = #self._cardImgArr
	for i,v in ipairs(self._cardImgArr) do
		local px = (i - 1) * cardSize.width/4
		v:setPositionX(px)
	end
	self:showCardType(cardsInfo)
end

function CWeishuwuSendcard:addGambleCard(gambleCardList)
	print("添加补牌")
	-- dump(gambleCardList)
	local gambleCardImg = ccui.ImageView:create()		
	local cardId  = gambleCardList.cardId
	gambleCardImg:loadTexture(weishuwu_card_data[cardId].card_big, 1)
	self.nodeCard[gambleCardList.node]:addChild(gambleCardImg)
	table.insert(self._gamblecardImgArr, gambleCardImg)
	local cardSize = gambleCardImg:getContentSize()
	-- local num = #self._cardImgArr
	-- for i,v in ipairs(self._gamblecardImgArr) do
		local px =cardSize.width+(gambleCardList.node-1)* cardSize.width/4
		gambleCardImg:setPositionX(px)
	-- end
	self:showCardsType(gambleCardList)
end

--显示最终牌型点数
function CWeishuwuSendcard:showCardsType(cardsInfo)
	-- dump(cardsInfo.gamble)
	if cardsInfo.palyergamble and cardsInfo.gamble == 1 then
		self.powerpalyer= (self.powerpalyer + cardsInfo.palyerpower)%10
		self.panel_ui.ImgDian1:setTexture(weishuwu_imageRes_config[self.powerpalyer].resPath)
		self.panel_ui.ImgDBG1:setVisible(true)
	elseif cardsInfo.bankergamble and cardsInfo.gamble == 2 then
		self.powerbanker= (self.powerbanker + cardsInfo.bankerpower)%10
		self.panel_ui.ImgDian2:setTexture(weishuwu_imageRes_config[self.powerbanker].resPath)
		self.panel_ui.ImgDBG2:setVisible(true)
	else
		for k,v in pairs(self.imgGamblelist) do
			v:setVisible(true)
		end
	end
end
--显示是否补牌
function CWeishuwuSendcard:showGamble(cardsInfo)
	self.panel_ui.ImgBPBG:setVisible(true)
	if cardsInfo.palyergamble and cardsInfo.gamble == 1 then
		self.panel_ui.ImgBPW3:setTexture(weishuwu_imageRes_config["蜀补牌"].resPath)
		for i=1,3 do
			self.imgGamblelist[i]:setVisible(true)
			self.panel_ui.ImgBPW3:runAction(cc.Blink:create(1,2))
		end
		local function showsecond()
			for i=4,6 do
				self.imgGamblelist[i]:setVisible(true)
			end
			self.panel_ui.FntDian3:setString(self.powerpalyer)
			self.panel_ui.FntDian4:setString(self.powerbanker)
			self.panel_ui.FntDian3:setVisible(true)
			self.panel_ui.FntDian4:setVisible(true)
		end
		performWithDelay(self, function () showsecond() end, 2.0)
	elseif cardsInfo.bankergamble and cardsInfo.gamble == 2 then
		self.panel_ui.ImgBPW6:setTexture(weishuwu_imageRes_config["吴补牌"].resPath)
		for i=1,3 do
			self.imgGamblelist[i]:setVisible(true)
		end
		local function showsecond()
			for i=4,6 do
				self.imgGamblelist[i]:setVisible(true)
				self.panel_ui.ImgBPW6:runAction(cc.Blink:create(1,2))
			end
			self.panel_ui.FntDian3:setString(self.powerpalyer)
			self.panel_ui.FntDian4:setString(self.powerbanker)
			self.panel_ui.FntDian3:setVisible(true)
			self.panel_ui.FntDian4:setVisible(true)
		end
		performWithDelay(self, function () showsecond() end, 0.5)						
	else
		for k,v in pairs(self.imgGamblelist) do
			v:setVisible(true)
		end
	end
end

--显示赢家
function CWeishuwuSendcard:showWiner()
	if self.powerpalyer > self.powerbanker then
		self.panel_ui.Img_log1:setVisible(true)
	elseif self.powerpalyer < self.powerbanker then
		self.panel_ui.Img_log2:setVisible(true)
	else
		self.panel_ui.Img_log3:setVisible(true)
	end	
end



