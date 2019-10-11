--[[

欢乐五张玩家界面
]]

local checkCount = 0
local checkCardable = true
local READY_TIME = 20
local STAGE_TIME = 30
--第一张手牌坐标
local cardPosArr = {{x = 1019.67, y = 86.25}, {x = 103.39, y = 456.86}, {x = 1018.26, y = 964.42}, {x = 1364.76, y = 450.39},}
local panel_ui1 = require "game.joyfive_std.script.ui_create.ui_joyfive_player1"
local panel_ui2 = require "game.joyfive_std.script.ui_create.ui_joyfive_player2"
local panel_ui3 = require "game.joyfive_std.script.ui_create.ui_joyfive_player3"
local panel_ui4 = require "game.joyfive_std.script.ui_create.ui_joyfive_player4"
 
CJoyFivePlayer = class("CJoyFivePlayer", function ()
	local ret = cc.Node:create()
	return ret
end)

function CJoyFivePlayer.create(seatId)
	-- body
	local node = CJoyFivePlayer.new()
	if node ~= nil then
		node:init_ui(seatId)
		return node
	end
end
function CJoyFivePlayer:init_ui(seatId)
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	if 1 == seatId then 
		self.panel_ui = panel_ui1.create()
	elseif 2 == seatId then 
		self.panel_ui = panel_ui2.create()
	elseif 3 == seatId then 
		self.panel_ui = panel_ui3.create()
	elseif 4 == seatId then 
		self.panel_ui = panel_ui4.create()
	end

	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.root:setPosition(0,0)

	self.imgCardList = {self.panel_ui.imgCard1,self.panel_ui.imgCard2,self.panel_ui.imgCard3,
					self.panel_ui.imgCard4,self.panel_ui.imgCard5,}
	for i=1,5 do
		self.imgCardList[i]:setVisible(false)
	end
	self.panel_ui.imCardBg:setVisible(false)
	self.panel_ui.imgSettleAccountsWin:setVisible(false)
	self.panel_ui.fntSettleAccountsWin:setVisible(false)
	self.panel_ui.imgSettleAccountsLose:setVisible(false)
	self.panel_ui.fntSettleAccountsLose:setVisible(false)
	self.panel_ui.imgReady:setVisible(false)
	self.panel_ui.imgClockBg:setVisible(false)
	self.panel_ui.fntClock:setVisible(false)
	self.panel_ui.spBetType:setVisible(false)
	self:regTouchHander()
end
function CJoyFivePlayer:setInfo( seatInfo )
	self.order = seatInfo.order --座位顺序(1-4)
	self.playerId = seatInfo.playerId --玩家id,0代表座位上没有人
	self.state = seatInfo.state --1:入座 2:准备 3：游戏中
	self.chips = seatInfo.chips --筹码
	self.sex = seatInfo.sex --性别
	self.tableId = seatInfo.tableId
	self:setChips( seatInfo.chips ) --筹码
	self.playerName = seatInfo.playerName
	self.panel_ui.labName:setString(textUtils.replaceStr(seatInfo.playerName, NAME_BITE_LIMIT, ".."))
	self.panel_ui.imgHead:setVisible(true)
	uiUtils:setPlayerHead(self.panel_ui.imgHead, seatInfo.icon, uiUtils.HEAD_SIZE_115)
	self.panel_ui.imgReady:setVisible(self.state == 2)
	self.handCardNum = 0
	self.cardArr = {}
end
function CJoyFivePlayer:setChips( value )
	self.chips = value
	self.panel_ui.fntChips:setString(value)	
end

function CJoyFivePlayer:clearPlayerInfo()
	self.panel_ui.imgReady:setVisible(false)
	self.panel_ui.imgHead:setVisible(false)
	self.panel_ui.labName:setString("")
	self.panel_ui.fntChips:setString(0)
end
--实际的座位号
function CJoyFivePlayer:setRealOrder(realOrder)
	self.realOrder = realOrder
end
function CJoyFivePlayer:getRealOrder()
	return self.realOrder
end

--开始倒计时  type 1:准备倒计时  2:回合倒计时
function CJoyFivePlayer:startTimeDown(type, callBack)
	timeUtils:remove(self.panel_ui.fntClock)
	local time = 0
	if type == 1 then
		time = READY_TIME
	else
		time = STAGE_TIME
	end

	self.panel_ui.imgClockBg:setVisible(true)
	self.panel_ui.fntClock:setVisible(true)
	self:timeCallBackHandler(time)
	
	timeUtils:addTimeDown(self.panel_ui.fntClock, time, function ( t ) self:timeCallBackHandler(t) end,
		function ( args ) 
			if callBack then callBack() end
		end)
	
end
--倒计时回调函数
function CJoyFivePlayer:timeCallBackHandler(time)
	self.panel_ui.imgClockBg:setVisible(true)
	self.panel_ui.fntClock:setVisible(true)
	local showtime = math.ceil(time)
	if self.panel_ui.fntClock then
		self.panel_ui.fntClock:setString(tostring(showtime))
	end
	--倒计时音效
	if showtime <= 5 then
		audio_manager:playOtherSound(3)
	end
end
--移除倒计时
function CJoyFivePlayer:removeTimeDown()
	self.panel_ui.imgClockBg:setVisible(false)
	self.panel_ui.fntClock:setVisible(false)
	timeUtils:remove(self.panel_ui.fntClock)
end
--清除游戏数据
function CJoyFivePlayer:clearGameInfo()
	joyfive_manager._isBanlance = false
	self.panel_ui.imCardBg:setVisible(false)
	self.panel_ui.imgSettleAccountsWin:setVisible(false)
	self.panel_ui.fntSettleAccountsWin:setVisible(false)
	self.panel_ui.imgSettleAccountsLose:setVisible(false)
	self.panel_ui.fntSettleAccountsLose:setVisible(false)
	if self.cardEffect then
    	self.cardEffect:removeFromParent()
    	self.cardEffect = nil
    end
	for i=1,5 do
		self.imgCardList[i]:setVisible(false)
	end
	self.handCardNum = 0
	self.cardArr = {}
	self.betType = 0
end
--结算
function CJoyFivePlayer:setBanlance(betValue)
	self.panel_ui.spBetType:setVisible(false)
	local str = long_compare(betValue, 0) >= 0 and "+" or ""
	self.panel_ui.imgSettleAccountsWin:setVisible((long_compare(betValue, 0) >= 0) and true or false)
	self.panel_ui.fntSettleAccountsWin:setVisible((long_compare(betValue, 0) >= 0) and true or false)
	self.panel_ui.imgSettleAccountsLose:setVisible((long_compare(betValue, 0) < 0) and true or false)
	self.panel_ui.fntSettleAccountsLose:setVisible((long_compare(betValue, 0) < 0) and true or false)
	if long_compare(betValue, 0) >= 0 then
		self.panel_ui.fntSettleAccountsWin:setString(str ..betValue)
	else
		self.panel_ui.fntSettleAccountsLose:setString(str ..betValue)
	end
end

--添加手牌
function CJoyFivePlayer:addOneHandCard(cardid)
	--print("cardid === " ..cardid)
	self.panel_ui.imCardBg:setVisible(true)
	self.handCardNum = self.handCardNum + 1
	local sprFrame
	if self.handCardNum == 1 then
		if cardid then
			-- sprFrame  = display.newSpriteFrame(joyfive_card_data[52].card_big)
			table.insert(self.cardArr, cardid)
			--self.panel_ui.imgCard1:setTexture(joyfive_card_data[52].card_big)
		--else
			--sprFrame = display.newSpriteFrame(joyfive_card_data[52].card_big)
			--self.panel_ui.imgCard1:setTexture(joyfive_card_data[52].card_big)
		end

		-- self.panel_ui.imgCard1:setSpriteFrame(sprFrame)
		self.panel_ui.imgCard1:loadTexture(joyfive_card_data[52].card_big,1)
		self.panel_ui.imgCard1:setVisible(true)
	else
		if cardid then
			sprFrame = display.newSpriteFrame(joyfive_card_data[cardid].card_big)

			table.insert(self.cardArr, cardid)
		else
			sprFrame = display.newSpriteFrame(joyfive_card_data[52].card_big)
		end
		if self.imgCardList[self.handCardNum] then 
			self.imgCardList[self.handCardNum]:setSpriteFrame(sprFrame)
			self.imgCardList[self.handCardNum]:setVisible(true)
		else
			print("手牌数量出错：" ..self.handCardNum)
		end
	end
end
--显示底牌
function CJoyFivePlayer:showhiddenCards(cardid)
	--local sprFrame = display.newSpriteFrame(joyfive_card_data[cardid].card_big)
	print("亮牌：" ..joyfive_card_data[cardid].card_big)
 	self.panel_ui.imgCard1:loadTexture(joyfive_card_data[cardid].card_big,1)
end
--玩家准备
function CJoyFivePlayer:setPlayerReady(value)
	self.panel_ui.imgReady:setVisible(value)
	if value then
		self.state = 2
		self:clearGameInfo()
		self.panel_ui.imgClockBg:setVisible(false)
		self.panel_ui.fntClock:setVisible(false)
		--停止倒计时
		self:removeTimeDown()
	end
end
--设置玩家状态
function CJoyFivePlayer:setPlayerBetType(betType)
	self.betType = betType
	self.panel_ui.spBetType:setVisible(true)
	self.panel_ui.spBetType:setTexture(joyfive_imageRes_config[betType].resPath)
	if betType == 5 then
		local sprFrame = display.newSpriteFrame(joyfive_card_data[52].card_big)
		for i=1,(self.handCardNum) do
			if i == 1 then
				self.imgCardList[i]:loadTexture(joyfive_card_data[52].card_big,1)
			else
				self.imgCardList[i]:setSpriteFrame(sprFrame)
			end
		end
	end
end
--隐藏玩家状态
function CJoyFivePlayer:hiddenPlayerBetType()
	self.panel_ui.spBetType:setVisible(false)
end
--显示牌类型
function CJoyFivePlayer:showCardTyopeEffect(effectType)
	if self.cardEffect == nil then
		local effecName = joyfive_manager._cardEffectTypeList[effectType]
		self.cardEffect = animationUtils.createAndPlayAnimation(self.panel_ui.ndEffect, joyfive_effect_config[effecName], nil)
		self.cardEffect:setAnchorPoint(cc.p(0.5,0.5))
	end
end
function CJoyFivePlayer:regTouchHander()
   	self.panel_ui.imgCard1:setTouchEnabled(true)
  	self.panel_ui.imgCard1:onTouch(function(e)
		if e.name == "ended" then
			if self.order == joyfive_manager._mySeatOrder then
				if (joyfive_manager._isBanlance == false) and (self.betType ~= 5) then
					self.panel_ui.imgCard1:setTouchEnabled(false)
					send_happyfive_ReqCheckCard()
				end
			end
		end
	end)
end

--玩家看牌
function CJoyFivePlayer:checkCard(order)
	if (order == self.order) then
	 	local function startCallBack()
	    		if order == joyfive_manager._mySeatOrder then
	    			local cardid = self.cardArr[1]
				 	self.panel_ui.imgCard1:loadTexture(joyfive_card_data[cardid].card_big,1)
	    		end
	    	end 
		local function endCallBack()
			if (joyfive_manager._isBanlance == true) and (self.betType ~= 5)and (self.handCardNum == 5) then
				local cardid = self.cardArr[1]
				self.panel_ui.imgCard1:loadTexture(joyfive_card_data[cardid].card_big,1)
			else
				self.panel_ui.imgCard1:loadTexture(joyfive_card_data[52].card_big,1)
			end
		 	self.panel_ui.imgCard1:setTouchEnabled(true)
		end
		local start_call_action = cc.CallFunc:create(startCallBack)
		local end_call_action = cc.CallFunc:create(endCallBack)
		local realOrder = joyfive_manager:getRealOrder(order)
		--local start_posX,start_posY = self.panel_ui.imgCard1:getPosition()
		local end_posX,end_posY = self.panel_ui.checkCardCon:getPosition()
	 	local moveTo = cc.MoveTo:create(0.8, cc.p(end_posX,end_posY))
	 	local moveBack = cc.MoveTo:create(0.1, cardPosArr[realOrder])
		local seq_arr = {}
		table.insert(seq_arr,start_call_action)
		table.insert(seq_arr,moveTo)
		table.insert(seq_arr,cc.DelayTime:create(0.5))
		table.insert(seq_arr,moveBack)
		table.insert(seq_arr,end_call_action)
		local seq = cc.Sequence:create(seq_arr)
		self.panel_ui.imgCard1:runAction(seq)
	end
end

