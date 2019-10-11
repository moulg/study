--[[
牛牛游戏
]]

--庄家坐标
local bankerMarkPos = {top = {x = 104, y = 983}, center = {x = 960, y = 680}, bottom = {x = 104, y = 97}}

--筹码抛掷区域
local chipsThrowRect = {x1 = 760, y1 = 560, x2 = 1160 , y2 = 760}
local trowBeginPos = {
	[1] = {x = 960, y = 0},
	[2] = {x = 960, y = 1080},
}

local sideResPathlist = {
	"lobby/resource/chips/131/1.png",
	"lobby/resource/chips/131/10.png",
	"lobby/resource/chips/131/100.png",
	"lobby/resource/chips/131/1k.png",
	"lobby/resource/chips/131/1w.png",
	"lobby/resource/chips/131/10w.png",
	"lobby/resource/chips/131/100w.png",
	"lobby/resource/chips/131/1kw.png",
}

local game_ui = require "game.niuniu_std.script.ui_create.ui_niuniu_mainscene"

local GAME_STEP = {
	READY_STEP = 0,   	--准备    
	READY_STEP_END = 1,   	--准备完成
	CALL_STEP = 2,		--叫庄
	CALL_STEP_END = 3,		--叫庄完成
	BET_STEP = 4,		--下注
	BET_STEP_END = 5,		--下注完成
	SHOW_DOWN_STEP = 6,	--摊牌
	SHOW_DOWN_STEP_END = 7,	--摊牌完成
	COMPLETE_STEP = 8	--结算
}
local READY_TIME = errenniuniu_time_config.errenniuniu_time_table[1].time
local CALL_TIME = errenniuniu_time_config.errenniuniu_time_table[2].time
local BET_TIME = errenniuniu_time_config.errenniuniu_time_table[3].time
local SHOW_DOWN_TIME = errenniuniu_time_config.errenniuniu_time_table[4].time

local TOTAL_SEAT_NUM = 2

local sel_movy_dis 	= 30 --选中时牌向上移距离

CNiuNiuGame = class("CNiuNiuGame", function ()
	local ret = cc.Layer:create()
	return ret
end)
ModuleObjMgr.add_module_obj(CNiuNiuGame,"CNiuNiuGame")

CNiuNiuGame.GAME_STEP = GAME_STEP

function CNiuNiuGame.create()
	local layer = CNiuNiuGame.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
	end
	return layer
end


function CNiuNiuGame:regEnterExit()
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

function CNiuNiuGame:onEnter()
    local cache = cc.SpriteFrameCache:getInstance()
    cache:addSpriteFrames("game/niuniu_std/resource/effect/card_big.plist")
    cache:addSpriteFrames("game/niuniu_std/resource/effect/card_sm.plist")

    audio_manager:reloadMusicByConfig(errenniuniu_music_config)

    audio_manager:playBackgroundMusic(1, true)
end

function CNiuNiuGame:onExit()
	local cache = cc.SpriteFrameCache:getInstance()
    cache:removeSpriteFramesFromFile("game/niuniu_std/resource/effect/card_big.plist")
    cache:removeSpriteFramesFromFile("game/niuniu_std/resource/effect/card_sm.plist")
    
    audio_manager:destoryAllMusicRes()
end

function CNiuNiuGame:resetGame()
	local delArr = {}
	for k,seatObj in pairs(self._playerSeatMap) do
		if seatObj._playerIsLeave == true then
			table.insert(delArr, seatObj)
		end

		seatObj:resetGame()
	end

	for i,seatObj in ipairs(delArr) do
		self._playerSeatMap[seatObj.playerId] = nil
		seatObj:removeFromParent()
	end

	for i,v in ipairs(self.chipsImgList) do
		v:removeFromParent()
	end
	self.chipsImgList = {}

	self.game_ui.sprBankMark:stopAllActions()
	self.game_ui.sprBankMark:setVisible(false)
	self.game_ui.sprCardsType1:setVisible(false)
	self.game_ui.sprCardsType2:setVisible(false)

	self:stopAllActions()

	self.banker_id = nil
end

function CNiuNiuGame:registerHandler()
	local function tipsCallBack()
		HallManager:reqExitCurGameTable()
	end

	local function closeFunc()
		if self.game_step ~= GAME_STEP.READY_STEP then
			TipsManager:showTwoButtonTipsPanel(36, {}, true, tipsCallBack)
		else
			tipsCallBack()
		end
	end
	self.game_ui.btnBack:onTouch(function ( e )
		if e.name == "ended" then
			closeFunc()
		end
	end)

	--下注按钮
	local function _on_cash_click( e )
		if e.name == "ended" then
			self:onCashClickHandler(e)
		end
	end 
	self.game_ui.btnCash1:onTouch(_on_cash_click)
	self.game_ui.btnCash2:onTouch(_on_cash_click)
	self.game_ui.btnCash3:onTouch(_on_cash_click)
	self.game_ui.btnCash4:onTouch(_on_cash_click)

	--叫庄
	self.game_ui.btnCallZ:onTouch(function (e)
		if e.name == "ended" then
			send_errenniuniu_ReqCallDealer({call = 1})
		end
	end)

	--不叫
	self.game_ui.btnNoCallZ:onTouch(function (e)
		if e.name == "ended" then
			send_errenniuniu_ReqCallDealer({call = 0})
		end
	end)

	--准备.换桌
	local function _on_ready_click(e)
		if e.name == "ended" then
			self:readyClickHandler(function ()
				send_errenniuniu_ReqReady()
			    --退出上一句的结算
			    self:exitCompleteStage()
			end)
		end
	end
	self.game_ui.btn_ready:onTouch(_on_ready_click)

	self.game_ui.btnChangeTable:onTouch(function (e)
		if e.name == "ended" then
			send_errenniuniu_ReqExchangeTable()
		end
	end)

	--摊牌按钮
	self.game_ui.btnShowDown:onTouch(function (e)
		if  e.name == "ended" then
			self:showDownHandler()
		end
	end)

	--提示按钮
	self.game_ui.btnPointOut:onTouch(function (e)
		if e.name == "ended" then
			if self._myBestCardType == CNN_CardsCheck.CardsKinds.MEI_NIU then
				send_errenniuniu_ReqShowdown({})
			else
				local playerId = get_player_info().id

				local seatItem = self._playerSeatMap[playerId]
				if seatItem then
					seatItem:tipsCards(self._myTipsCards)
				end
			end
		end
	end)

	self.game_ui.btnExchange:onTouch(function (e)
		if e.name == "ended" then
			local seatObj = self._playerSeatMap[get_player_info().id]
			TipsManager:showExchangePanel(seatObj.chips, get_player_info().gold)
		end
	end)
end

--初始化游戏ui
function CNiuNiuGame:init_ui()

	self.game_ui = game_ui.create()
	self:addChild(self.game_ui.root)
	self.game_ui.root:setPosition(0,0)
	self.game_ui.root:setAnchorPoint(0,0)

	self:registerHandler()

	--下注按钮
	self.game_ui.btnCash1:setVisible(false)
	self.game_ui.btnCash2:setVisible(false)	
	self.game_ui.btnCash3:setVisible(false)	
	self.game_ui.btnCash4:setVisible(false)


	--分数
	self.game_ui.sprScore1:setVisible(false)
	self.game_ui.sprScore2:setVisible(false)

	self.game_ui.sprBetBack1:setVisible(false)
	self.game_ui.sprBetBack2:setVisible(false)

	--叫庄
	self.game_ui.btnCallZ:setVisible(false)

	--不叫
	self.game_ui.btnNoCallZ:setVisible(false)

	--准备.换桌
	self.game_ui.btn_ready:setVisible(false)
	self.game_ui.btnChangeTable:setVisible(false)

	--摊牌按钮
	self.game_ui.btnShowDown:setVisible(false)
	
	--提示按钮
	self.game_ui.btnPointOut:setVisible(false)

	self.game_ui.sprCalling:setVisible(false)
	self.game_ui.sprBetting:setVisible(false)
	self.game_ui.sprCardsType1:setVisible(false)
	self.game_ui.sprCardsType2:setVisible(false)

	--庄 图片
	self.game_ui.sprBankMark:setVisible(false)
end

function CNiuNiuGame:init_after_enter()
	
	self:initData()
	self:initGameSeats(niuniu_manager.seatsMap)

	self:enterReadyStage()
end


function CNiuNiuGame:initData()
	--玩家座位
	self._playerSeatMap = {}

	self._playerIndexMap = {}

	--玩家下注筹码数
	self.chipsImgList = {}
	--自己的最优牌
	self._myBestCardType = nil
	self._myTipsCards = {}

	self._showCardsCache = {}

	niuniu_manager.showDownMsgMap = {}

	self.banker_id = nil
end

--初始化桌位信息
function CNiuNiuGame:initGameSeats(memberInfos)
	--清理座位
	for k,seatObj in pairs(self._playerSeatMap) do
		seatObj:removeFromParent()
	end
	self._playerSeatMap = {}

	local seatItem
	for k,v in pairs(memberInfos) do
		if v.order == niuniu_manager._mySeatOrder then
			seatItem = CNiuNiuPlayerExt.create(CNiuNiuPlayerExt.BOTTOM)

			self._playerIndexMap[v.playerId] = 2
		else
			seatItem = CNiuNiuPlayerExt.create(CNiuNiuPlayerExt.TOP)

			self._playerIndexMap[v.playerId] = 1
		end

		self._playerSeatMap[v.playerId] = seatItem
		self.game_ui.playerNode:addChild(seatItem)
		seatItem:setInfo(v)
	end
end

--创建玩家
function CNiuNiuGame:createPlayer(memberInfo)
	local seatItem = self._playerSeatMap[memberInfo.playerId]
	if seatItem then
		seatItem:removeFromParent()
	end

	local seatItem = CNiuNiuPlayerExt.create(CNiuNiuPlayerExt.TOP)
	seatItem:setInfo(memberInfo)
	self.game_ui.playerNode:addChild(seatItem)
	self._playerSeatMap[memberInfo.playerId] = seatItem
end

--删除玩家
function CNiuNiuGame:removePlayer(playerId)
	local seatObj = self._playerSeatMap[playerId]
	if seatObj then
		seatObj:playerLeave()
		self._playerSeatMap[playerId] = nil
		seatObj:removeFromParent()
	end
end

--准备
function CNiuNiuGame:readyClickHandler(callback)
	local roominfo = get_player_info():get_cur_roomInfo()
	local seatObj = self._playerSeatMap[get_player_info().id]

	local tmpNum = long_multiply(roominfo.minOne,8)
	if long_compare(tmpNum, seatObj.chips) == 1 then
		TipsManager:showExchangePanel(seatObj.chips, get_player_info().gold, callback)
	else
		send_errenniuniu_ReqReady()
	    --退出上一句的结算
	    self:exitCompleteStage()
	end
end

--出牌
function CNiuNiuGame:showDownHandler()
	local seatObj = self._playerSeatMap[get_player_info().id]
	send_errenniuniu_ReqShowdown({cards = seatObj._selectCards})

    if CNN_CardsCheck.checkIsBestCardsType(self._myTipsCards, 
    seatObj._selectCards, self._myBestCardType) == false then
        TipsManager:showOneButtonTipsPanel(41, {}, true)
    end
end

function CNiuNiuGame:onCashClickHandler(e)
	if e.target == self.game_ui.btnCash1 then
		send_errenniuniu_ReqBet({chip = self.cashData[1] })
	elseif e.target == self.game_ui.btnCash2 then
		send_errenniuniu_ReqBet({chip = self.cashData[2] })
	elseif e.target == self.game_ui.btnCash3 then
		send_errenniuniu_ReqBet({chip = self.cashData[3] })
	elseif e.target == self.game_ui.btnCash4 then
		send_errenniuniu_ReqBet({chip = self.cashData[4] })
	end

	--下注音效
	audio_manager:playOtherSound(1)
end

--重置各种显示
function CNiuNiuGame:resetDiplay()
	self.game_ui.btnCallZ:setVisible(false)
	self.game_ui.btnNoCallZ:setVisible(false)
	self.game_ui.sprCalling:setVisible(false)
	self.game_ui.sprBetting:setVisible(false)
	self.game_ui.btnShowDown:setVisible(false)
	self.game_ui.btnPointOut:setVisible(false)

	self.game_ui.btnCash1:setVisible(false)
	self.game_ui.btnCash2:setVisible(false)	
	self.game_ui.btnCash3:setVisible(false)	
	self.game_ui.btnCash4:setVisible(false)
end


--更新玩家筹码
function CNiuNiuGame:updateChips(playerId, chips)
	local seatItem = self._playerSeatMap[playerId]
	if seatItem then
		seatItem:setChips(chips)
	end
end

function CNiuNiuGame:addTimeDown( playerId, time )
	self:clearTimeDown()

	local seatObj = self._playerSeatMap[playerId]
	if seatObj then
		seatObj:addTimeDown(time, function ()
			self:timeEndCallBack()
		end)
	end
end

function CNiuNiuGame:clearTimeDown()
	for k,seatObj in pairs(self._playerSeatMap) do
		seatObj:clearTimeDown()
	end
end

function CNiuNiuGame:timeEndCallBack( args )
	if self.game_step == GAME_STEP.READY_STEP then
		local seatObj = self._playerSeatMap[get_player_info().id]
		if seatObj and seatObj.playerState == 1 then
			send_errenniuniu_ReqExitTable()

			print("请求退桌")
		end
	elseif self.game_step == GAME_STEP.CALL_STEP then
		if player_is_myself( self.callingZ_playerid ) then --我叫庄
			send_errenniuniu_ReqCallDealer({call = 1})
		end
	elseif self.game_step == GAME_STEP.BET_STEP then
		if player_is_myself( self.banker_id ) == false then  --我下注
			send_errenniuniu_ReqBet({chip = self.cashData[4] })
		end
	elseif self.game_step == GAME_STEP.SHOW_DOWN_STEP then
		send_errenniuniu_ReqShowdown({})
	end
end

--进入准备阶段
function CNiuNiuGame:enterReadyStage()
	self.game_step = GAME_STEP.READY_STEP

	self.game_ui.btn_ready:setVisible(true)
	self.game_ui.btnChangeTable:setVisible(true)
	self.game_ui.btnExchange:setVisible(true)

	self:addTimeDown(get_player_info().id, READY_TIME)
end

--更新准备状态
function CNiuNiuGame:playerReady(playerId)
	local seatItem = self._playerSeatMap[playerId]
	if seatItem then
		seatItem:setReady(true, 2)

		if player_is_myself(playerId) then
			--准备.换桌
			self.game_ui.btn_ready:setVisible(false)
			self.game_ui.btnChangeTable:setVisible(false)
			self.game_ui.btnExchange:setVisible(false)

			seatItem:clearTimeDown()
		end
	end
end

--离开准备阶段
function CNiuNiuGame:exitReadyStage()
	self.game_step = GAME_STEP.READY_STEP_END

	for k,seatItem in pairs(self._playerSeatMap) do
		seatItem:setReady(false, 2)
	end

	audio_manager:playOtherSound(4)
end

--进入叫庄阶段
function CNiuNiuGame:enterCallZhuangStage()
	self.game_step = GAME_STEP.CALL_STEP

	--是否是自己叫庄
	local playerInfo = get_player_info()
	if long_compare(playerInfo.id, self.callingZ_playerid) == 0 then
		self.game_ui.btnCallZ:setVisible(true)
		self.game_ui.btnNoCallZ:setVisible(true)
		self.game_ui.sprCalling:setVisible(false)
	else
		self.game_ui.btnCallZ:setVisible(false)
		self.game_ui.btnNoCallZ:setVisible(false)
		--对方叫庄提示
		self.game_ui.sprCalling:setVisible(true)
	end

	self:addTimeDown(self.callingZ_playerid, CALL_TIME, function ()
			self:timeEndCallBack()
		end)

	self.game_ui.sprBankMark:setVisible(true)
	self.game_ui.sprBankMark:setPosition(bankerMarkPos.center)
end

--离开叫庄阶段
function CNiuNiuGame:exitCallZhuangStage()
	self.game_step = GAME_STEP.CALL_STEP_END

	self.game_ui.btnCallZ:setVisible(false)
	self.game_ui.btnNoCallZ:setVisible(false)
	self.game_ui.sprCalling:setVisible(false)


    if self.banker_id ~= nil then
        if player_is_myself(self.banker_id) then
			self.game_ui.sprBetting:setVisible(true)
	    else
		    self.game_ui.sprBetting:setVisible(false)
	    end
    end

    self:clearTimeDown()
end

--进入下注阶段
function CNiuNiuGame:enterBetStage()
	self.game_step = GAME_STEP.BET_STEP

	for k,seatItem in pairs(self._playerSeatMap) do
		if long_compare(seatItem.playerId, self.banker_id) ~= 0 then
			seatItem:addTimeDown(BET_TIME, function ()
												self:timeEndCallBack()
											end)
		end
	end

	--是否是自己下注  --不是庄家者下注
	if player_is_myself(self.banker_id) == false then
		local chipsArr = {}
		for k,seatItem in pairs(self._playerSeatMap) do
			table.insert(chipsArr, seatItem.chips)
		end

		dump(chipsArr)
		local btndata = CNN_CardsCheck.calute_bottomCash(chipsArr)

		self.cashData = btndata

		if self.autoMaxBet then
			if btndata[5] then
				send_errenniuniu_ReqBet({chip = self.cashData[1] })	
			elseif btndata[6] then
				send_errenniuniu_ReqBet({chip = self.cashData[2] })	
			elseif btndata[7] then
				send_errenniuniu_ReqBet({chip = self.cashData[3] })	
			elseif btndata[8] then
				send_errenniuniu_ReqBet({chip = self.cashData[4] })	
			end
		end

		--下注按钮
		self.game_ui.btnCash1:setVisible(true)
		self.game_ui.btnCash1:setEnabled(btndata[5])
		self.game_ui.btnCash1:setBright(btndata[5])
		self.game_ui.fnt_cash1:setString(btndata[1])

		self.game_ui.btnCash2:setVisible(true)
		self.game_ui.btnCash2:setEnabled(btndata[6])
		self.game_ui.btnCash2:setBright(btndata[6])
		self.game_ui.fnt_cash2:setString(btndata[2])

		self.game_ui.btnCash3:setVisible(true)
		self.game_ui.btnCash3:setEnabled(btndata[7])
		self.game_ui.btnCash3:setBright(btndata[7])
		self.game_ui.fnt_cash3:setString(btndata[3])

		self.game_ui.btnCash4:setVisible(true)
		self.game_ui.btnCash4:setEnabled(btndata[8])
		self.game_ui.btnCash4:setBright(btndata[8])
		self.game_ui.fnt_cash4:setString(btndata[4])

		local moveAction = cc.MoveTo:create(1, bankerMarkPos.top)
		self.game_ui.sprBankMark:runAction(moveAction)
	else
		--下注按钮
		self.game_ui.btnCash1:setVisible(false)
		self.game_ui.btnCash2:setVisible(false)
		self.game_ui.btnCash3:setVisible(false)
		self.game_ui.btnCash4:setVisible(false)

		local moveAction = cc.MoveTo:create(1, bankerMarkPos.bottom)
		self.game_ui.sprBankMark:runAction(moveAction)
	end
end

--玩家下注
function CNiuNiuGame:playerBetChips( chips )
	local mod = 1
	if player_is_myself(self.banker_id) then
		mod = 2

		self.game_ui.sprBetBack1:setVisible(true)
		self.game_ui.fntBet1:setString(chips)
	else
		self.game_ui.sprBetBack2:setVisible(true)
		self.game_ui.fntBet2:setString(chips)
	end

	local num_list = gsplit(chips)
	num_list = table.reverse(num_list)
	self.chipsImgList = {}
	for i,v in ipairs(num_list) do
		for k = 1,v do
			local params = {}
			params.endPos_x = math.random(chipsThrowRect.x1, chipsThrowRect.x2)
			params.endPos_y = math.random(chipsThrowRect.y1, chipsThrowRect.y2)
			local sprite = display.newSprite(sideResPathlist[i], trowBeginPos[mod].x, trowBeginPos[mod].y)
			sprite:setAnchorPoint(1,0.5)
			self.game_ui.sprSceneBack:addChild(sprite)
			CFlyAction:Fly(sprite, 1, params, CFlyAction.FLY_TYPE_CHIPS)
			table.insert( self.chipsImgList, sprite )
		end
	end

	audio_manager:playOtherSound(1)
end


--离开下注阶段
function CNiuNiuGame:exitBetStage()
	self.game_step = GAME_STEP.BET_STEP_END
		--下注按钮
	self.game_ui.btnCash1:setVisible(false)	
	self.game_ui.btnCash2:setVisible(false)	
	self.game_ui.btnCash3:setVisible(false)	
	self.game_ui.btnCash4:setVisible(false)
	--对方下注提示
	self.game_ui.sprBetting:setVisible(false)

	self:clearTimeDown()
end

--发牌阶段
function CNiuNiuGame:sendCardsStage( tipsCards, cardsType )
	self._myTipsCards = clone(tipsCards)
	self._myBestCardType = cardsType
	local list = tipsCards
	table.sort( list, function (id1, id2)
		if id1 < id2 then
			return true
		else
			return false
		end
	end )

	local mainPlayerId = get_player_info().id
	for i,cardId in ipairs(list) do
		local num = 0
		for id,seatObj in pairs(self._playerSeatMap) do
			

			local function callback()
				if long_compare(id, mainPlayerId) == 0 then
					seatObj:addCard(cardId)
					audio_manager:playOtherSound(9)
				else
					seatObj:addCard()
				end

				num = num + 1
				--所有牌发完 
				if i == #list and num == TOTAL_SEAT_NUM then
					print("所有牌发完1")

					performWithDelay(self, function ()
						self:enterShowDownStage()
					end, 0.5)
				end
			end
			performWithDelay(self, callback, 0.2 * (i - 1) )
		end
	end
end


--进入摊牌阶段
function CNiuNiuGame:enterShowDownStage()
	self.game_step = GAME_STEP.SHOW_DOWN_STEP

	self.game_ui.btnShowDown:setVisible(true)
	self.game_ui.btnPointOut:setVisible(true)

	--添加倒计时
	for k,seatItem in pairs(self._playerSeatMap) do
		if player_is_myself(seatItem.playerId) then
			seatItem:addTimeDown(SHOW_DOWN_TIME, function ()
				self:timeEndCallBack()
			end)
		else
			seatItem:addTimeDown(SHOW_DOWN_TIME)
		end
	end


	for i,msg in ipairs(self._showCardsCache) do
		self:showDownCards(msg.playerId, msg.bestCards, msg.cardsType)

		--出牌包含自己，直接退出摊牌阶段
		if player_is_myself(msg.playerId) then
			self:exitShowDownStage()
			self:enterReadyStage()
		end
	end
	self._showCardsCache = {}
end

--玩家摊牌
function CNiuNiuGame:showDownCards( playerId, bestCards, cardsType )
	local seatItem = self._playerSeatMap[playerId]
	if seatItem then
		seatItem:showCards(cardsType, bestCards)

		if player_is_myself(playerId) then
			self:exitShowDownStage()
		end

		--摊牌音效
		audio_manager:playOtherSound(8)

		seatItem:clearTimeDown()
	end

	self:showCardsTypeEffect( playerId ,cardsType )
end

--玩家摊牌临时缓存
function CNiuNiuGame:saveShowCardsMsg( msg )
	--在摊牌/摊牌结束 阶段 才能显示出牌 否则存储
	if self.game_step == GAME_STEP.SHOW_DOWN_STEP or self.game_step == GAME_STEP.SHOW_DOWN_STEP_END then
		self:showDownCards(msg.playerId, msg.bestCards, msg.cardsType)
	else
		table.insert(self._showCardsCache, msg)
	end
end

--退出摊牌阶段
function CNiuNiuGame:exitShowDownStage()
	self.game_step = GAME_STEP.SHOW_DOWN_STEP_END

	self.game_ui.btnShowDown:setVisible(false)
	self.game_ui.btnPointOut:setVisible(false)
end

--进入结算阶段
function CNiuNiuGame:enterCompleteStage()
	self.game_step = GAME_STEP.COMPLETE_STEP

	--清理筹码
	local endPos
	if long_compare(self.MyGameChips,0) > 0 then
		endPos = trowBeginPos[1]
		--self.game_ui.fntScore1:setFntFile("game/niuniu_std/resource/number/loseNum.fnt")
		--self.game_ui.fntScore2:setFntFile("game/niuniu_std/resource/number/winNum.fnt")

		audio_manager:playOtherSound(7)
	else
		endPos = trowBeginPos[2]
		--self.game_ui.fntScore2:setFntFile("game/niuniu_std/resource/number/loseNum.fnt")
		--self.game_ui.fntScore1:setFntFile("game/niuniu_std/resource/number/winNum.fnt")

		audio_manager:playOtherSound(3)
	end
	for i,sprite in ipairs(self.chipsImgList) do
		local params = {}
		params.endPos_x = endPos.x
		params.endPos_y = endPos.y
		params.flyendCallback = function ()
			sprite:removeFromParent()
		end
		CFlyAction:Fly(sprite, 1, params, CFlyAction.FLY_TYPE_CHIPS)
	end
	self.chipsImgList = {}


	self.game_ui.sprBetBack1:setVisible(false)
    self.game_ui.sprBetBack2:setVisible(false)

	--分数
	self.game_ui.sprScore1:setVisible(true)
	self.game_ui.fntScore1:setString(long_multiply(-1,self.MyGameChips))
	self.game_ui.sprScore2:setVisible(true)
	self.game_ui.fntScore2:setString(self.MyGameChips)

	--游戏结束音效
	audio_manager:playOtherSound(2)

	--重置准备状态
	for k,seatObj in pairs(self._playerSeatMap) do
		seatObj:setReady(false, 1)
	end

	self:resetDiplay()

	self:enterReadyStage()
end


--退出结算阶段
function CNiuNiuGame:exitCompleteStage()
	self.game_ui.sprScore1:setVisible(false)
	self.game_ui.sprScore2:setVisible(false)

	self:resetGame()
end

--显示卡牌牌型特效
function CNiuNiuGame:showCardsTypeEffect( playerId ,cardsType )
	local mainPlayerId = get_player_info().id
	if long_compare(mainPlayerId, playerId) == 0 then
		self.game_ui.sprCardsType2:setVisible(true)
		self.game_ui.sprCardsType2:setTexture("game/niuniu_std/resource/word/NIU_"..cardsType..".png")
	else
		self.game_ui.sprCardsType1:setVisible(true)
		self.game_ui.sprCardsType1:setTexture("game/niuniu_std/resource/word/NIU_"..cardsType..".png")
	end

	if cardsType >= CNN_CardsCheck.CardsKinds.SI_HUA then
		audio_manager:playOtherSound(10)
	elseif cardsType <= CNN_CardsCheck.CardsKinds.NIU_NIU then
		local seatItem = self._playerSeatMap[playerId]
		if seatItem then
			audio_manager:playPlayerSound(cardsType + 2, seatItem.sex)
		end
	end


end
