--玩家位置坐标
local _seatPosArr = {{x = 960, y = 140}, {x = 130, y = 540}, {x = 960, y = 940}, {x = 1700, y = 540},}
-- --下注坐标
-- local _betPosArr = {{x = 720, y = 400, w = 300, h = 200}, {x = 650, y = 420, w = 200, h = 300}, 
-- 					{x = 720, y = 500, w = 300, h = 200}, {x = 1000, y = 420, w = 200, h = 300}, }

-- --牌型特效坐标
-- local _effectPosArr = {{x = 1162, y = 158}, {x = 290, y = 478}, {x = 1100, y = 809}, {x = 1330, y = 438},}

--胜利失败坐标
local effectPosArr = {{x = 960, y = 540},}

local TOTAL_SEAT_NUM = 4

--筹码
local sideResPathlist = {
	"lobby/resource/chips/70/1.png",
	"lobby/resource/chips/70/10.png",
	"lobby/resource/chips/70/100.png",
	"lobby/resource/chips/70/1k.png",
	"lobby/resource/chips/70/1w.png",
	"lobby/resource/chips/70/10w.png",
	"lobby/resource/chips/70/100w.png",
	"lobby/resource/chips/70/1kw.png",
}

local GAME_STEP = {
	READY_STEP = 1,   	--准备
	SEND_CARD_STEP = 2,	--发牌
	SHOW_DOWN_STEP = 3,	--摊牌
}
local READY_TIME = tongbiniuniu_time_config[1].time
local SHOW_DOWN_TIME = tongbiniuniu_time_config[2].time

local panel_ui = require "game.tongbiniuniu_std.script.ui_create.ui_tongbiniuniu_main"

CTongBiNiuNiuMainScene = class("CTongBiNiuNiuMainScene", function ()
	local ret = cc.Node:create()
	return ret		
end)

ModuleObjMgr.add_module_obj(CTongBiNiuNiuMainScene,"CTongBiNiuNiuMainScene")
CTongBiNiuNiuMainScene.GAME_STEP = GAME_STEP

function CTongBiNiuNiuMainScene.create()
	local node = CTongBiNiuNiuMainScene.new()
	if node ~= nil then
		node:init_ui()
		node:regEnterExit()
		return node
	end
end

function CTongBiNiuNiuMainScene:regEnterExit()
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

function CTongBiNiuNiuMainScene:onEnter()
	audio_manager:reloadMusicByConfig(tongbiniuniu_music_config)
	local cache = cc.SpriteFrameCache:getInstance()
    
    for k,v in pairs(tongbiniuniu_effect_res_config) do
    	cache:addSpriteFrames(v.plistPath)
    end
end

function CTongBiNiuNiuMainScene:onExit()
	self:clearPanel()
end

--释放资源
function CTongBiNiuNiuMainScene:clearPanel()
	local cache = cc.SpriteFrameCache:getInstance()
    
    for k,v in pairs(tongbiniuniu_effect_res_config) do
    	cache:removeSpriteFramesFromFile(v.plistPath)
    end

    audio_manager:destoryAllMusicRes()

	self:resetGameData()

	--清理座位
    if self._playerSeatMap then
	    for k,img in pairs(self._playerSeatMap) do
		    img:removeFromParent()
	    end
    end
	self._playerSeatMap = {}

	self:clearTimeDown()
end

function CTongBiNiuNiuMainScene:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	--摊牌按钮
	-- self.panel_ui.btnShowDown:setVisible(false)
	
	--提示按钮
	-- self.panel_ui.btnPointOut:setVisible(false)

	-- --筹码面板
	-- self.chipsPanel = CChipsPanel.create()
	-- self:addChild(self.chipsPanel)
	-- self.chipsPanel:setPosition(0,0)

	-- --统计面板
	-- self.statistics_ui = CTongBiNiuNiuStatistics.create()
	-- self.panel_ui.backImage:addChild(self.statistics_ui)
	-- self.statistics_ui:setPosition(1276, 1050)

	-- self:addButtonHightLight()

	self.panel_ui.bgCard:setVisible(false)
	self.bIsShowCardPanel = false
end

--按钮高亮
function CTongBiNiuNiuMainScene:addButtonHightLight()
	local btnArr = {self.panel_ui.btnAddChips, self.panel_ui.btnReduceChips, 
					self.panel_ui.btn_ready, self.panel_ui.btnChangeTable,
					self.panel_ui.btnShowDown,self.panel_ui.btnPointOut,
				}

	local resArr = {"上分高亮", "下分高亮",
					"开始高亮", "换桌高亮",
					"摊牌高亮", "提示高亮",
					}

	for i,btn in ipairs(btnArr) do
		local mov_obj = cc.Sprite:create(tongbiniuniu_imgRes_config[resArr[i]].resPath)
		WindowScene.getInstance():registerBtnMouseMoveEff(btn,mov_obj,1)
	end
end

--按钮事件
function CTongBiNiuNiuMainScene:registerHandler()
	--标题
	local function tipsCallBack()
		send_tongbiniuniu_ReqExitTable()
	end

	local function closeFunc()
		if self._gameStep ~= GAME_STEP.READY_STEP then
			TipsManager:showTwoButtonTipsPanel(36, {}, true, tipsCallBack)
		else
			tipsCallBack()
		end
	end
	local title = WindowScene.getInstance():getModuleObjByClassName("CTableTitleExt")
	if title then
		title:setCloseFunc(closeFunc)
	end

	--开始
	self.panel_ui.btn_ready:onTouch(function (e)
		if e.name == "ended" then
			print("开始")
			self:readyClickHandler(function ()
				send_tongbiniuniu_ReqReady()
			end)
		end
	end)
	--换桌
	self.panel_ui.btnChangeTable:onTouch(function (e)
		if e.name == "ended" then
			send_tongbiniuniu_ReqExchangeTable()
		end
	end)
	--退桌
	self.panel_ui.btnExit:onTouch(function (e)
		if e.name == "ended" then
			-- send_tongbiniuniu_ReqExitTable()
			closeFunc()
		end
	end)
	--设置
	self.panel_ui.btnSet:onTouch(function (e)
		if e.name == "ended" then
			local gameid = get_player_info().curGameID
			if gameid ~= nil then
				WindowScene.getInstance():showDlgByName("CHallSet")
			end
		end
	end)

	--摊牌按钮
	self.panel_ui.btnShowDown:onTouch(function (e)
		if  e.name == "ended" then
			self:showDownHandler()
		end
	end)

	--兑换按钮
	self.panel_ui.btnExchange:onTouch(function (e)
		if e.name == "ended" then
			local playerInfo = get_player_info()
			TipsManager:showExchangePanel(tongbiniuniu_manager._ownChips, playerInfo.gold)
		end
	end)
	--牌型
	self.panel_ui.btnCardPatterns:onTouch(function (e)
		if e.name == "ended" then
			if self.bIsShowCardPanel == false then
				self.bIsShowCardPanel = true
				self.panel_ui.bgCard:setVisible(true)
				self.panel_ui.bgCard:setTouchEnabled(true)
			else
				self.bIsShowCardPanel = false
				self.panel_ui.bgCard:setVisible(false)
				self.panel_ui.bgCard:setTouchEnabled(false)
			end
		end
	end)

	--提示按钮
	self.panel_ui.btnPointOut:onTouch(function (e)
		if e.name == "ended" then
			if CTongBiNiuNiuCardCheck.getCardsTypeFormation( self._myBestCardType ) then
				local seatObj = self._playerSeatMap[tongbiniuniu_manager._mySeatOrder]
				seatObj:tipsCards(self._myTipsCards)
			end

			if self._myBestCardType == CTongBiNiuNiuCardCheck.CardsKinds.MEI_NIU then
				send_tongbiniuniu_ReqShowdown({})

				audio_manager:playOtherSound(7)
			end

			self:showCardsTypeTipsImage(self._myBestCardType)
		end
	end)

	--一系列托管按钮事件
	local function _on_check_box_handler( sender,eventType )
		if sender == self.panel_ui.CheckBox_ready then
			tongbiniuniu_manager.isAutoReady = eventType == ccui.CheckBoxEventType.selected
		elseif sender == self.panel_ui.CheckBox_showdown then
			tongbiniuniu_manager.isAutoShowDown = eventType == ccui.CheckBoxEventType.selected
		end
	end
	--自动准备
	self.panel_ui.CheckBox_ready:addEventListener(_on_check_box_handler)
	--自动摊牌
	self.panel_ui.CheckBox_showdown:addEventListener(_on_check_box_handler)
end


function CTongBiNiuNiuMainScene:init_after_enter()

    self:registerHandler()
	self:initData()
	self:initGameSeats(tongbiniuniu_manager._seatsMap)
	self:enterReadyStage()

    --背景音乐
	audio_manager:playBackgroundMusic(1, true)
    local _playerInfo = get_player_info()
    local userConfig = get_user_config()
	local gameSetData = userConfig[_playerInfo.curGameID]
	if gameSetData then
		audio_manager:setMusicVolume(gameSetData.musicVol)
	end
end

--初始化信息
function CTongBiNiuNiuMainScene:initData()
	--玩家座位
	self._playerSeatMap = {}

	--玩家下注位置
	self._playerBetPosMap = {}
	--玩家位子坐标
	self._playerSeatPosMap = {}
	--牌型特效坐标
	self._effectPosMap = {}
	--玩家牌型特效
	self._effectMap = {}
	
	--统计数据
	self.statistics_data = {}
	--各个玩家结算
	self._playersBalanceMap = {}
	--玩家下注筹码数
	self._playerBetChipsImgMap = {}
	--自己的最优牌
	self._myBestCardType = nil
	self._myTipsCards = {}

	--庄家座位
	self._bankerOrder = nil

	--是否自动准备
	tongbiniuniu_manager.isAutoReady = false

	--是否自动出牌
	tongbiniuniu_manager.isAutoShowDown = false

	tongbiniuniu_manager.showDownMsgMap = {}
end

--重置游戏数据
function CTongBiNiuNiuMainScene:resetGameData()
	--各个玩家结算
	self._playersBalanceMap = {}

	for k,imgList in pairs(self._playerBetChipsImgMap) do
		for i,spr in ipairs(imgList) do
			spr:removeFromParent()
		end
	end
	--玩家下注筹码数
	self._playerBetChipsImgMap = {}
	--自己的最优牌
	self._myBestCardType = nil
	self._myTipsCards = {}

	-- self.panel_ui.img_cardsTypeTips:setVisible(false)

	--玩家数据清除
	for k,v in pairs(self._playerSeatMap) do
		print("v.order",v.order)		
		v:resetGame()
	end

	--玩家牌型特效
	for k,v in pairs(self._effectMap) do
		v:removeFromParent()
	end

	--提示牌型图片
	if  self.sprCardsType then
		self.sprCardsType:removeFromParent()
		self.sprCardsType=nil
	end

	self._effectMap = {}

	if self._balanceEffect then
		self._balanceEffect:removeFromParent()
		self._balanceEffect = nil
	end

	tongbiniuniu_manager.showDownMsgMap = {}
end

-- --下注按钮事件
-- function CTongBiNiuNiuMainScene:onCashClickHandler(e)
-- 	if e.target == self.panel_ui.btnCash1 then
-- 		send_sirenniuniu_ReqBet({chip = self.cashData[1] })
-- 	elseif e.target == self.panel_ui.btnCash2 then
-- 		send_sirenniuniu_ReqBet({chip = self.cashData[2] })
-- 	elseif e.target == self.panel_ui.btnCash3 then
-- 		send_sirenniuniu_ReqBet({chip = self.cashData[3] })
-- 	elseif e.target == self.panel_ui.btnCash4 then
-- 		send_sirenniuniu_ReqBet({chip = self.cashData[4] })
-- 	end
-- end

--准备事件
function CTongBiNiuNiuMainScene:readyClickHandler(callback)
	local roominfo = get_player_info():get_cur_roomInfo()
	print("roominfo.minOne = " ..roominfo.minOne)
	local tmpNum = long_multiply(roominfo.minOne,8)
	local seatObj = self._playerSeatMap[tongbiniuniu_manager._mySeatOrder]
	if long_compare(tmpNum, seatObj.chips) > 0 then
		TipsManager:showExchangePanel(seatObj.chips, get_player_info().gold, callback)
	else
		send_tongbiniuniu_ReqReady()
	    --退出上一局的结算
	    self:exitCompleteStage()
	end
end

--初始化桌位信息
function CTongBiNiuNiuMainScene:initGameSeats(seats)
	--清理座位
	for k,seatObj in pairs(self._playerSeatMap) do
		seatObj:removeFromParent()
	end
	self._playerSeatMap = {}

	--座位排列
	local seatList = {CTongBiNiuNiuPlayerExt.create(1), CTongBiNiuNiuPlayerExt.create(2),
					  CTongBiNiuNiuPlayerExt.create(3), CTongBiNiuNiuPlayerExt.create(4),}

	local index = tongbiniuniu_manager._mySeatOrder
	for i = 1, TOTAL_SEAT_NUM do
		-- local seatObj = seatList[i]
		-- 	seatObj:clearInfo()
		-- seatObj:resetGame()
		-- 	-- seatObj:setPosition(_seatPosArr[i])
		-- 	self.panel_ui.playerCon:addChild(seatObj)
		-- 	self._playerSeatMap[index] = seatObj
		self._playerSeatPosMap[index] = _seatPosArr[i]
		-- self._playerBetPosMap[index] = _betPosArr[i]
		-- self._effectPosMap[index] = _effectPosArr[i]

		index = index + 1
		if index >= TOTAL_SEAT_NUM then
			index = 0
		end
	end

	---创建玩家
	for order = 0,TOTAL_SEAT_NUM-1 do
		local seatinfo = seats[order]
		if seatinfo then
			self:createPlayer(seatinfo)
		end
	end
end


--创建玩家
function CTongBiNiuNiuMainScene:createPlayer(memberInfo)
	print("创建玩家",memberInfo.order)
	if self._playerSeatMap[memberInfo.order] == nil then
		local seatObj = CTongBiNiuNiuPlayerExt.create(tongbiniuniu_manager:getRealOrder(memberInfo.order))
			seatObj:clearInfo()
			seatObj:resetGame()
			self.panel_ui.playerCon:addChild(seatObj)
			seatObj:setInfo(memberInfo)
		self._playerSeatMap[memberInfo.order] = seatObj
	else
		self._playerSeatMap[memberInfo.order]:setInfo(memberInfo)
	end
end

--删除玩家
function CTongBiNiuNiuMainScene:removePlayer(order)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		-- self.statistics_data[order] = nil
		-- self.statistics_ui:setInfo(self.statistics_data)
		seatObj:clearInfo()
	end
end

--玩家筹码变化
function CTongBiNiuNiuMainScene:updateChips(order, chips)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:setChips(chips)
	end
	-- if order == tongbiniuniu_manager._mySeatOrder then
	-- 	self.chipsPanel:setChips(chips)
	-- end
end

--玩家准备
function CTongBiNiuNiuMainScene:setPlayerReady( order )
	if order == tongbiniuniu_manager._mySeatOrder then
		self:resetGameData()
		self:exitReadyStage()
	end
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:setReady(true)
	end
end

--添加倒计时
function CTongBiNiuNiuMainScene:addTimeDown(order,time)
	self:clearTimeDown()
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:addTimeDown(time, function ()
			self:timeEndCallBack()
		end)
	end
	-- local showtime = math.ceil(time)
	-- self.panel_ui.fnt_time:setString(tostring(showtime))

	-- timeUtils:addTimeDown(self.panel_ui.fnt_time, time, function ( t ) self:timeCallBackHandler(t) end,
	-- 	function ( args ) self:timeEndCallBack(args) end)
	-- self.panel_ui.img_clock:setVisible(true)
end

--倒计时回调函数
function CTongBiNiuNiuMainScene:timeCallBackHandler(time)
	local showtime = math.ceil(time)
	self.panel_ui.fnt_time:setString(tostring(showtime))
	--倒计时音效
	if time <= 5 then
		audio_manager:playOtherSound(9)
	end
end

--倒计时结束
function CTongBiNiuNiuMainScene:timeEndCallBack()
	if self._gameStep == GAME_STEP.READY_STEP then
		local seatObj = self._playerSeatMap[tongbiniuniu_manager._mySeatOrder]
		if seatObj and seatObj:readIsVisible() == false then
			send_tongbiniuniu_ReqExitTable()
		end
	elseif self._gameStep == GAME_STEP.SHOW_DOWN_STEP then
		send_tongbiniuniu_ReqShowdown({})
	end
end
--删除倒计时
function CTongBiNiuNiuMainScene:clearTimeDown()
	for k,seatObj in pairs(self._playerSeatMap) do
		seatObj:clearTimeDown()
	end
	-- timeUtils:remove(self.panel_ui.fnt_time)
	-- self.panel_ui.img_clock:setVisible(false)
end

--重置所有阶段性的按钮
function CTongBiNiuNiuMainScene:resetAllStageButton()
	self.panel_ui.btn_ready:setVisible(false)
	self.panel_ui.btnChangeTable:setVisible(false)
	self.panel_ui.btnShowDown:setVisible(false)
	self.panel_ui.btnPointOut:setVisible(false)
end

--启用/禁用兑换按钮
function CTongBiNiuNiuMainScene:showHideAddRecChipsButton(value)
	self.panel_ui.btnExchange:setEnabled(value)	
	self.panel_ui.btnExchange:setBright(value)
end

--进入准备阶段
function CTongBiNiuNiuMainScene:enterReadyStage()
	self:resetAllStageButton()
	self.panel_ui.btn_ready:setVisible(true)
	self.panel_ui.btnChangeTable:setVisible(true)
	self:showHideAddRecChipsButton(true)

	self._gameStep = GAME_STEP.READY_STEP
	self:clearTimeDown()
	self:addTimeDown(tongbiniuniu_manager._mySeatOrder,READY_TIME)

	if tongbiniuniu_manager.isAutoReady then
		self:readyClickHandler(function ()
				send_tongbiniuniu_ReqReady()
			end)
	end
end

--离开准备阶段
function CTongBiNiuNiuMainScene:exitReadyStage()
	self.panel_ui.btn_ready:setVisible(false)
	self.panel_ui.btnChangeTable:setVisible(false)
	self:showHideAddRecChipsButton(false)
	self:clearTimeDown()
end

--发牌
function CTongBiNiuNiuMainScene:sendCardsStage(tipsCards, cardsType)
	self._gameStep = GAME_STEP.SEND_CARD_STEP
	for order = 0, TOTAL_SEAT_NUM-1 do
		local seatObj = self._playerSeatMap[order]
		if seatObj then
			seatObj:setReady(false)
		end
	end

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

	for i,cardId in ipairs(list) do
		for j = 0, TOTAL_SEAT_NUM-1 do
			local seatObj = self._playerSeatMap[j]
			if seatObj and seatObj.isEnabled then
				local function callback()
					if j == tongbiniuniu_manager._mySeatOrder then
						seatObj:addCard(cardId)

						audio_manager:playOtherSound(5)
					else
						seatObj:addCard()
					end

					--所有牌发完
					if i == #list and j == tongbiniuniu_manager._mySeatOrder then
						performWithDelay(self, function ()
							self:enterShowDownStage()
						end, 0.5)
					end
				end
				performWithDelay(self, callback, 0.2 * (i - 1) )
			end
		end
	end
end


--抛出筹码
function CTongBiNiuNiuMainScene:playerBetChips(order, chips)
	print("抛出筹码")
	if self._playerSeatMap[order] == nil then
		return
	end

	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:setBetInfo(chips)
		audio_manager:playPlayerSound(5, seatObj.sex)
	end

	-- if order ~= self._bankerOrder and order ~= four_niuniu_manager._mySeatOrder then
	-- 	local img = self._bettingMap[order]
	-- 	if img then
	-- 		img:setVisible(false)
	-- 	end
	-- end

	local numArr = gsplit(chips)
	numArr = table.reverse(numArr)
	for i,v in ipairs(numArr) do
		for k = 1,v do
			local params = {}
			params.endPos_x = math.random(self._playerBetPosMap[order].x, self._playerBetPosMap[order].x + self._playerBetPosMap[order].w)
			params.endPos_y = math.random(self._playerBetPosMap[order].y, self._playerBetPosMap[order].y + self._playerBetPosMap[order].h)

			local sprite = display.newSprite(sideResPathlist[i],self._playerSeatPosMap[order].x,self._playerSeatPosMap[order].y)
			sprite:setAnchorPoint(0.5,0.5)
			self.panel_ui.backImage:addChild(sprite)
			CFlyAction:Fly(sprite, 0.5, params, CFlyAction.FLY_TYPE_CHIPS)

			if self._playerBetChipsImgMap[order] == nil then
				self._playerBetChipsImgMap[order] = {}
			end
			table.insert( self._playerBetChipsImgMap[order], sprite )
		end
	end

	audio_manager:playOtherSound(4)

	if order == tongbiniuniu_manager._mySeatOrder then
		self:exitBetStage()
	end
end


--进入摊牌阶段
function CTongBiNiuNiuMainScene:enterShowDownStage()
	self:resetAllStageButton()
	self.panel_ui.btnShowDown:setVisible(true)
	self.panel_ui.btnPointOut:setVisible(true)

	self._gameStep = GAME_STEP.SHOW_DOWN_STEP
	self:clearTimeDown()
	self:addTimeDown(tongbiniuniu_manager._mySeatOrder,SHOW_DOWN_TIME)

	if tongbiniuniu_manager.isAutoShowDown then
		send_tongbiniuniu_ReqShowdown({})
	end

	--处理缓存的出牌信息
	for order, msg in pairs(tongbiniuniu_manager.showDownMsgMap) do
		self:playerShowDown(msg.order, msg.cardsType, msg.bestCards)
	end
end

--离开摊牌阶段
function CTongBiNiuNiuMainScene:exitShowDownStage()
	self.panel_ui.btnShowDown:setVisible(false)
	self.panel_ui.btnPointOut:setVisible(false)
end

--进入结算阶段
function CTongBiNiuNiuMainScene:enterCompleteStage()
	self:enterReadyStage()
end

--退出结算
function CTongBiNiuNiuMainScene:exitCompleteStage()

end

--出牌操作
function CTongBiNiuNiuMainScene:showDownHandler()
	local seatObj = self._playerSeatMap[tongbiniuniu_manager._mySeatOrder]
	if seatObj == nil then
		return
	end
	send_tongbiniuniu_ReqShowdown({cards = seatObj._selectCards})

    if CTongBiNiuNiuCardCheck.checkIsBestCardsType(self._myTipsCards, 
    seatObj._selectCards, self._myBestCardType) == false then
        TipsManager:showOneButtonTipsPanel(41, {}, true)
    end
end

--玩家出牌结果
function CTongBiNiuNiuMainScene:playerShowDown( order, cardsType, bestCards )
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:showCards(cardsType, bestCards)
		audio_manager:playOtherSound(6)

		if order == tongbiniuniu_manager._mySeatOrder then
			self:exitShowDownStage()
		end

		--显示特效
		self:addCardTypeEffect(order, cardsType)
		seatObj:showCardType(cardsType)
	end
end

--牌型音效
function CTongBiNiuNiuMainScene:addCardTypeEffect(order, cardsType)
	-- local effectSpr
	-- if cardsType >= CTongBiNiuNiuCardCheck.CardsKinds.NIU_NIU then
	-- 	effectSpr = animationUtils.createAndPlayAnimation(self, tongbiniuniu_effect_config[cardsType])
	-- 	effectSpr:setAnchorPoint(0.5,0.5)
	-- 	effectSpr:setPosition(self._effectPosMap[order])
	-- else
		-- effectSpr = cc.Sprite:create("game/tongbiniuniu_std/resource/effect/NIU_"..cardsType..".png")
	-- 	effectSpr:setAnchorPoint(0.5,0.5)
	-- 	effectSpr:setPosition(self._effectPosMap[order])
	-- 	self:addChild(effectSpr)
	-- end
	
	-- self._effectMap[order] = effectSpr

	local seatObj = self._playerSeatMap[order]
	if seatObj == nil then
		return
	end

	if cardsType == CTongBiNiuNiuCardCheck.CardsKinds.SI_ZHA then
		audio_manager:playPlayerSound(6, seatObj.sex)
	elseif cardsType == CTongBiNiuNiuCardCheck.CardsKinds.MEI_NIU then
		audio_manager:playPlayerSound(10, seatObj.sex)
	elseif cardsType == CTongBiNiuNiuCardCheck.CardsKinds.NIU_1 then
		audio_manager:playPlayerSound(11, seatObj.sex)
	elseif cardsType == CTongBiNiuNiuCardCheck.CardsKinds.NIU_2 then
		audio_manager:playPlayerSound(12, seatObj.sex)
	elseif cardsType == CTongBiNiuNiuCardCheck.CardsKinds.NIU_3 then
		audio_manager:playPlayerSound(13, seatObj.sex)
	elseif cardsType == CTongBiNiuNiuCardCheck.CardsKinds.NIU_4 then
		audio_manager:playPlayerSound(14, seatObj.sex)
	elseif cardsType == CTongBiNiuNiuCardCheck.CardsKinds.NIU_5 then
		audio_manager:playPlayerSound(15, seatObj.sex)
	elseif cardsType == CTongBiNiuNiuCardCheck.CardsKinds.NIU_6 then
		audio_manager:playPlayerSound(16, seatObj.sex)
	elseif cardsType == CTongBiNiuNiuCardCheck.CardsKinds.NIU_7 then
		audio_manager:playPlayerSound(17, seatObj.sex)
	elseif cardsType == CTongBiNiuNiuCardCheck.CardsKinds.NIU_8 then
		audio_manager:playPlayerSound(18, seatObj.sex)
	elseif cardsType == CTongBiNiuNiuCardCheck.CardsKinds.NIU_9 then
		audio_manager:playPlayerSound(19, seatObj.sex)
	elseif cardsType == CTongBiNiuNiuCardCheck.CardsKinds.NIU_NIU then
		audio_manager:playPlayerSound(20, seatObj.sex)
	elseif cardsType == CTongBiNiuNiuCardCheck.CardsKinds.WU_XIAO then
		audio_manager:playPlayerSound(21, seatObj.sex)
	elseif cardsType == CTongBiNiuNiuCardCheck.CardsKinds.WU_HUA then
		audio_manager:playPlayerSound(25, seatObj.sex)
	elseif cardsType == CTongBiNiuNiuCardCheck.CardsKinds.SI_HUA then
		audio_manager:playPlayerSound(26, seatObj.sex)
	end
end


--显示并设置牌型的提示图片
function CTongBiNiuNiuMainScene:showCardsTypeTipsImage(type)
	if  self.sprCardsType then
		self.sprCardsType:removeFromParent()
		self.sprCardsType=nil
	end
	self.sprCardsType = cc.Sprite:create("game/tongbiniuniu_std/resource/word/Nroom_niu"..type..".png")
	self.panel_ui.btnPointOut:addChild(self.sprCardsType)
	self.sprCardsType:setScale(2.5)
	self.sprCardsType:setPosition(-100,0)
	self.sprCardsType:setAnchorPoint(0.5,0.5)

	-- self.panel_ui.img_cardsTypeTips:setTexture("game/tongbiniuniu_std/resource/word/Nroom_niu"..type..".png")
	-- self.panel_ui.img_cardsTypeTips:setVisible(true)
end

--分发筹码
function CTongBiNiuNiuMainScene:splitChipsToPlayer(order, chips, clearAll)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:setBalanceInfo(chips)

		if self._playersBalanceMap[order] == nil then
			self._playersBalanceMap[order] = {}
		end
		self._playersBalanceMap[order].name = seatObj.playerName
		self._playersBalanceMap[order].chips = chips

		-- self.statistics_data[order].count = chips
		-- self.statistics_data[order].totalCount = long_plus(self.statistics_data[order].totalCount, chips)
		-- self.statistics_ui:setInfo(self.statistics_data)
	end


	--播发胜利失败特效
	if order == tongbiniuniu_manager._mySeatOrder then

		local posX= self._playerSeatPosMap[order].x
		local posY= self._playerSeatPosMap[order].y+420
		if self._balanceEffect then
			self._balanceEffect:removeFromParent()
			self._balanceEffect = nil
		end

		self._balanceEffect = cc.CSLoader:createNode("game/tongbiniuniu_std/script/ui_create/ui_tongbiniuniu_settle.csb")
		self._balanceEffect:setPosition(posX, posY)
		self.panel_ui.playerCon:addChild(self._balanceEffect)
		local action = cc.CSLoader:createTimeline("game/tongbiniuniu_std/script/ui_create/ui_tongbiniuniu_settle.csb")
    		self._balanceEffect:runAction(action)
   			action:gotoFrameAndPlay(0, false)

		local effectNode = self._balanceEffect:getChildByName("effectNode")
			effectWin = effectNode:getChildByName("effectWin")
			effectLose = effectNode:getChildByName("effectLose")
		if effectWin then 
			effectWin:setVisible(false)
		end
	 	if effectLose then 
	 		effectLose:setVisible(false)
	 	end

		if long_compare(chips, 0) > 0 then
			-- effectData = tongbiniuniu_effect_config["胜利"]		
	 		effectWin:setVisible(true)
			-- audio_manager:playOtherSound(4)
		else
			-- effectData = tongbiniuniu_effect_config["失败"]			
			effectLose:setVisible(true)
			-- audio_manager:playOtherSound(3)
		end
	end

	--筹码飞向玩家
	local imgList = self._playerBetChipsImgMap[order]
	if imgList == nil then
        if clearAll then
			self:clearAllChipsImg()
		end
		return
	end

	for k,sprite in pairs(imgList) do
		local params = {}

		if long_compare(chips, 0) > 0 then
			params.endPos_x = self._playerSeatPosMap[order].x
			params.endPos_y = self._playerSeatPosMap[order].y
		else
			params.endPos_x = self._playerSeatPosMap[self._bankerOrder].x
			params.endPos_y = self._playerSeatPosMap[self._bankerOrder].y
		end
		
		params.flyendCallback = function ()
			sprite:removeFromParent()
			sprite = nil

			if clearAll then
				self:clearAllChipsImg()
			end
		end
		CFlyAction:Fly(sprite, 0.5, params, CFlyAction.FLY_TYPE_CHIPS)
	end
	self._playerBetChipsImgMap[order] = nil

end

--清理筹码
function CTongBiNiuNiuMainScene:clearAllChipsImg()
	for k,imgList in pairs(self._playerBetChipsImgMap) do
		for i,spr in ipairs(imgList) do
			spr:removeFromParent()
		end
	end
	self._playerBetChipsImgMap = {}
end