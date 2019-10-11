--[[
牛牛玩家
]]

CNiuNiuPlayerExt = class("CNiuNiuPlayerExt",function()
	local  ret = cc.Node:create()
	return ret
end)

CNiuNiuPlayerExt.TOP = 1
CNiuNiuPlayerExt.BOTTOM = 2

function CNiuNiuPlayerExt.create(dir)
	-- body
	local node = CNiuNiuPlayerExt.new()
	if node ~= nil then
		node:init_ui(dir)
		node:regEnterExit()
		return node
	end
end

function CNiuNiuPlayerExt:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter();
		elseif event == "exit" then
			self:onExit();
		end
	end

	self:registerScriptHandler(_onEnterOrExit);
end

function CNiuNiuPlayerExt:onEnter()

end

function CNiuNiuPlayerExt:onExit()
	self:resetGame()
end

function CNiuNiuPlayerExt:init_ui(dir)
	if dir == self.BOTTOM then
		panel_ui = require "game.niuniu_std.script.ui_create.ui_niuniu_playerB"
	else
		panel_ui = require "game.niuniu_std.script.ui_create.ui_niuniu_playerT"
	end

	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	--进度槽
	self._trackSprite = cc.Sprite:create("game/niuniu_std/resource/image/Nroom_clockBg.png")
	self.panel_ui.sprHeadBack:addChild(self._trackSprite)
	self._trackSprite:setPosition(10,10)
	self._trackSprite:setAnchorPoint(0,0)

	--进度条
	self._progressTimer = cc.ProgressTimer:create(cc.Sprite:create("game/niuniu_std/resource/image/Nroom_clock.png"))
	self.panel_ui.sprHeadBack:addChild(self._progressTimer)
	self._progressTimer:setAnchorPoint(0,0)
	self._progressTimer:setPosition(10,10)
	self._progressTimer:setVisible(false)
	self._progressTimer:setReverseDirection(true)
end

--开始倒计时 
function CNiuNiuPlayerExt:addTimeDown(time, callBack)
	self._progressTimer:stopAllActions()
	self._trackSprite:setVisible(true)
	self._progressTimer:setVisible(true)
	self._progressTimer:setPercentage(100)

	local seq_arr = {}
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
function CNiuNiuPlayerExt:clearTimeDown()
	self._progressTimer:setVisible(false)
	self._trackSprite:setVisible(false)
	self._progressTimer:stopAllActions()
end

--玩家离桌
function CNiuNiuPlayerExt:playerLeave()
	self.panel_ui.sprHeadBack:setVisible(false)
	self.panel_ui.labChips:setVisible(false)
	self.panel_ui.labName:setVisible(false)
	self:clearTimeDown()

	self._playerIsLeave = true
end

function CNiuNiuPlayerExt:setChips( value )
	self.chips = value
	self.panel_ui.labChips:setString(value)	
end

function CNiuNiuPlayerExt:setInfo( seatInfo )
	self:resetGame()

	if long_compare(seatInfo.playerId, 0) ~= 0 then
		self.order = seatInfo.order --座位顺序(0-1)
		self.playerId = seatInfo.playerId --玩家id,0代表座位上没有人
		self.chips = seatInfo.chips --筹码
		self.sex = seatInfo.sex --性别
		self.playerName = seatInfo.playerName --玩家name
		self.playerState = seatInfo.state --玩家状态(0:站立,1:入座,2:准备,3:游戏中)
		--local name = textUtils.replaceStr(seatInfo.playerName, NAME_BITE_LIMIT, "..")
		self.panel_ui.labName:setString(self.playerName)
		self.panel_ui.labChips:setString(self.chips)
		uiUtils:setPhonePlayerHead(self.panel_ui.sprHead, seatInfo.sex, uiUtils.HEAD_SIZE_223)

		self:setReady(seatInfo.state == 2, seatInfo.state)

		self.panel_ui.labChips:setVisible(true)
		self.panel_ui.labName:setVisible(true)
		self.panel_ui.sprHeadBack:setVisible(true)

		self._playerIsLeave = false
	end
end

function CNiuNiuPlayerExt:setReady(value, state)
	self.playerState = state
	self.panel_ui.sprReady:setVisible(value)
end

function CNiuNiuPlayerExt:resetGame()
	if self._cardImgArr then
		for k,v in pairs(self._cardImgArr) do
			v:removeFromParent()
		end
	end
	self._cardImgArr = {}
	self._cardImgMap = {}

	self._selectCards = {}

	--入座状态(0:站立,1:入座,2:准备,3:游戏中)
	self.playerState = 1

	self:clearTimeDown()
end

function CNiuNiuPlayerExt:addCard( cardId )
	local cardImg = ccui.ImageView:create()
	if cardId == nil then
		cardImg:loadTexture(niuniu_card_data[54].card_big, 1)
	else
		cardImg:loadTexture(niuniu_card_data[cardId].card_big, 1)

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

function CNiuNiuPlayerExt:tipsCards( bestCards )
	for i = 1, 3 do
		local cardImg = self._cardImgMap[bestCards[i]]
		if cardImg then
			local cardSize = cardImg:getContentSize()
			cardImg:setPositionY(cardSize.height/2)
		end
	end
end

function CNiuNiuPlayerExt:showCards(cardType, bestCards)
	if cardType > CNN_CardsCheck.CardsKinds.MEI_NIU then
		for k,v in pairs(self._cardImgArr) do
			v:removeFromParent()
		end
		self._cardImgArr = {}

		local res
		for i = 4, 5 do
			if player_is_myself(self.playerId) then
				res = niuniu_card_data[bestCards[i]].card_big
			else
				res = niuniu_card_data[bestCards[i]].card_big
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
				res = niuniu_card_data[bestCards[i]].card_big
			else
				res = niuniu_card_data[bestCards[i]].card_big
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
				res = niuniu_card_data[bestCards[i]].card_big
			else
				res = niuniu_card_data[bestCards[i]].card_big
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