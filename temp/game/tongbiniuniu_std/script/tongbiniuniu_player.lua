--[[
通比牛牛玩家
]]

CTongBiNiuNiuPlayerExt = class("CTongBiNiuNiuPlayerExt",function()
	local  ret = cc.Node:create()
	return ret
end)

CTongBiNiuNiuPlayerExt.BOTTOM = 1
CTongBiNiuNiuPlayerExt.LEFT = 2
CTongBiNiuNiuPlayerExt.TOP = 3
CTongBiNiuNiuPlayerExt.RIGHT = 4

function CTongBiNiuNiuPlayerExt.create(dir)
	-- body
	local node = CTongBiNiuNiuPlayerExt.new()
	if node ~= nil then
		node:init_ui(dir)
		return node
	end
end

function CTongBiNiuNiuPlayerExt:init_ui(dir)
	-- dump(dir)
	if dir == self.BOTTOM then
		panel_ui = require "game.tongbiniuniu_std.script.ui_create.ui_tongbiniuniu_playerB"
	elseif dir == self.LEFT then
		panel_ui = require "game.tongbiniuniu_std.script.ui_create.ui_tongbiniuniu_playerL"
	elseif dir == self.TOP then
		panel_ui = require "game.tongbiniuniu_std.script.ui_create.ui_tongbiniuniu_playerT"
	else
		panel_ui = require "game.tongbiniuniu_std.script.ui_create.ui_tongbiniuniu_playerR"
	end


	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

-- 进度槽
	self._trackSprite = cc.Sprite:create(tongbiniuniu_imgRes_config["进度槽"].resPath)
	self.panel_ui.spPlayerBg:addChild(self._trackSprite)
	self._trackSprite:setPosition(10,10)
	self._trackSprite:setAnchorPoint(0,0)
	self._trackSprite:setVisible(false)


	--进度条
	self._progressTimer = cc.ProgressTimer:create(cc.Sprite:create(tongbiniuniu_imgRes_config["进度条"].resPath))
	self.panel_ui.spPlayerBg:addChild(self._progressTimer)
	self._progressTimer:setAnchorPoint(0,0)
	self._progressTimer:setPosition(10,10)
	self._progressTimer:setVisible(false)
	self._progressTimer:setReverseDirection(true)

end

--开始倒计时 
function CTongBiNiuNiuPlayerExt:addTimeDown(time, callBack)
	print("enteraddTimeDown开始倒计时 >>>>>>>>>")
	self._progressTimer:stopAllActions()
	self._trackSprite:setVisible(true)
	self._progressTimer:setVisible(true)
	self._progressTimer:setPercentage(100)

	-- local seq_arr = {}
	local progressAction = cc.RepeatForever:create(cc.ProgressTo:create(time, 0)) 

	self._progressTimer:runAction(progressAction)

	performWithDelay(self._progressTimer, function ()
		if callBack then
			callBack()
		end

		self:clearTimeDown()
	end, time)
end

--清除倒计时
function CTongBiNiuNiuPlayerExt:clearTimeDown()
	self._progressTimer:setVisible(false)
	self._trackSprite:setVisible(false)
	self._progressTimer:stopAllActions()
end

function CTongBiNiuNiuPlayerExt:clearInfo()
	print("清理玩家信息")
	self.panel_ui.imgReady:setVisible(false)
	-- self.panel_ui.labChips:setVisible(false)
	-- self.panel_ui.labName:setVisible(false)
	self.panel_ui.spPlayerBg:setVisible(false)
	self.panel_ui.imgHeadBg:setVisible(false)
	-- self.panel_ui.img_cardsTypeTips:setVisible(false)
	self:clearTimeDown()
	self.isEnabled = false
end

function CTongBiNiuNiuPlayerExt:setChips( value )
	self.chips = value
	self.panel_ui.labChips:setString(value)	
end

function CTongBiNiuNiuPlayerExt:setInfo( seatInfo )
	self.order = seatInfo.order --座位顺序(0-1)

	self:clearInfo()
	-- self:resetGame()

	if long_compare(seatInfo.playerId, 0) ~= 0 then
		self.playerId = seatInfo.playerId --玩家id,0代表座位上没有人
		self.chips = seatInfo.chips --筹码
		self.sex = seatInfo.sex --性别
		self.playerName = seatInfo.playerName --玩家name
		--local name = textUtils.replaceStr(seatInfo.playerName, NAME_BITE_LIMIT, "..")
		self.panel_ui.labName:setString(self.playerName)
		self.panel_ui.labChips:setString(self.chips)
		uiUtils:setPlayerHead(self.panel_ui.sprHead, seatInfo.sex, uiUtils.HEAD_SIZE_223)

		if seatInfo.state == 2 then
			self:setReady(true)
		end
		self.panel_ui.spPlayerBg:setVisible(true)
		self.panel_ui.imgHeadBg:setVisible(true)
		-- self.panel_ui.labChips:setVisible(true)
		-- self.panel_ui.labName:setVisible(true)
		-- self.panel_ui.sprHead:setVisible(true)
		self.isEnabled = true
	end
end

function CTongBiNiuNiuPlayerExt:setReady(value)
	self.panel_ui.imgReady:setVisible(value)
end

function CTongBiNiuNiuPlayerExt:resetGame()
	self.panel_ui.img_balance_bg:setVisible(false)
	self.panel_ui.img_cardsTypeTips:setVisible(false)

	if self._cardImgArr then
		for k,v in pairs(self._cardImgArr) do
			v:removeFromParent()
		end
	end
	self._cardImgArr = {}
	self._cardImgMap = {}

	self._selectCards = {}
end

function CTongBiNiuNiuPlayerExt:readIsVisible()
	return self.panel_ui.imgReady:isVisible()
end

function CTongBiNiuNiuPlayerExt:addCard( cardId )
	local cardImg = ccui.ImageView:create()
	if cardId == nil then
		cardImg:loadTexture(tongbiniuniu_card_data[54].card_sm, 1)
	else
		cardImg:loadTexture(tongbiniuniu_card_data[cardId].card_big, 1)

		local function touchHandler(e)
			if e.name == "ended" then
				local cardSize = cardImg:getContentSize()
				if cardImg:getPositionY() == 0 and #self._selectCards < 3 then
					cardImg:setPositionY(cardSize.height/2)
					table.insert(self._selectCards, cardId)
				else
					cardImg:setPositionY(0)

					for i,v in ipairs(self._selectCards) do
						if v == cardId then
							table.remove(self._selectCards, i)
							return
						end
					end
				end
			end
		end
		cardImg:onTouch(touchHandler)
		cardImg:setTouchEnabled(true)

		self._cardImgMap[cardId] = cardImg
	end
	self.panel_ui.nodeCard:addChild(cardImg)
	table.insert(self._cardImgArr, cardImg)

	local cardSize = cardImg:getContentSize()
	local num = #self._cardImgArr
	local beginX = -(num - 1)*cardSize.width/4
	for i,v in ipairs(self._cardImgArr) do
		local px = beginX + (i - 1) * cardSize.width/2
		v:setPositionX(px)
	end
end

function CTongBiNiuNiuPlayerExt:tipsCards( bestCards )
	for i = 1, 3 do
		local cardImg = self._cardImgMap[bestCards[i]]
		if cardImg then
			local cardSize = cardImg:getContentSize()
			cardImg:setPositionY(cardSize.height/2)
		end
	end
end

function CTongBiNiuNiuPlayerExt:showCards(cardType, bestCards)
	if cardType > CTongBiNiuNiuCardCheck.CardsKinds.MEI_NIU then
		for k,v in pairs(self._cardImgArr) do
			v:removeFromParent()
		end
		self._cardImgArr = {}

		local res
		for i = 4, 5 do
			if player_is_myself(self.playerId) then
				res = tongbiniuniu_card_data[bestCards[i]].card_big
			else
				res = tongbiniuniu_card_data[bestCards[i]].card_sm
			end
			local cardImg = ccui.ImageView:create(res,1)
			local cardSize = cardImg:getContentSize()
			local beginX = -cardSize.width/4
			local px = beginX + (i - 4) * cardSize.width/2
			cardImg:setPosition(px, cardSize.height/2)
			table.insert(self._cardImgArr, cardImg)
			self.panel_ui.nodeCard:addChild(cardImg)
		end
		
		for i = 1, 3 do
			if player_is_myself(self.playerId) then
				res = tongbiniuniu_card_data[bestCards[i]].card_big
			else
				res = tongbiniuniu_card_data[bestCards[i]].card_sm
			end
			
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
			if player_is_myself(self.playerId) then
				res = tongbiniuniu_card_data[bestCards[i]].card_big
			else
				res = tongbiniuniu_card_data[bestCards[i]].card_sm
			end
			local cardImg = ccui.ImageView:create(res,1)
			local cardSize = cardImg:getContentSize()
			local beginX = -4*cardSize.width/4
			local px = beginX + (i - 1) * cardSize.width/2
			cardImg:setPosition(px, 0)

			table.insert(self._cardImgArr, cardImg)
			self.panel_ui.nodeCard:addChild(cardImg)
		end
	end
end

function CTongBiNiuNiuPlayerExt:showCardType(cardType)
	print("显示牌型",cardType)
	self.panel_ui.img_cardsTypeTips:setTexture("game/tongbiniuniu_std/resource/word/NIU_"..cardType..".png")
	self.panel_ui.img_cardsTypeTips:setVisible(true)
end

--设置下注信息
function CTongBiNiuNiuPlayerExt:setBetInfo( chips )
	-- self.panel_ui.sprNumBack:setVisible(true)
	-- self.panel_ui.fntBetChips:setString(chips)
end

--设置结算信息
function CTongBiNiuNiuPlayerExt:setBalanceInfo( chips )
	-- self.panel_ui.sprNumBack:setVisible(false)
	
	if long_compare(chips,0) >= 0 then
		--self.panel_ui.fnt_balance:setFntFile("game/tongbiniuniu_std/resource/number/jiesuanying.fnt")
	else
		--self.panel_ui.fnt_balance:setFntFile("game/tongbiniuniu_std/resource/number/jiesuanshu.fnt")		
	end
	self.panel_ui.fnt_balance:setString(chips)
	self.panel_ui.img_balance_bg:setVisible(true)
end