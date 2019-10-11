--[[
德州扑克
]]

--筹码投掷坐标
local chipsPosArr = {x = 950, y = 350,}
--投掷范围
local THROW_WIDTH = 350
local THROW_HEIGHT = 160
--总座位数
local TOTAL_SEAT_NUM = 8
--发牌速度
local SEND_CARD_SPEED = 0.2

--公共牌坐标
local publicCardsPosArr = {[1] = {x = 610,y = 630}, [2] = {x = 720,y = 630}, [3] = {x = 830,y = 630}, [4] = {x = 940,y = 630}, [5] = {x = 1050,y = 630}}

--玩家位置坐标
local seatPosArr = {{x = 554, y = 935}, {x = 175, y = 830}, {x = 175, y = 307}, {x = 584, y = 200}, 
					 {x = 1056, y = 200}, {x = 1483, y = 307}, {x = 1483, y = 836}, {x = 1105, y = 934},}

--发手牌终点坐标
local cardEndPosArr = {{x = 990, y = 790}, {x = 1400, y = 790}, {x = 1530, y = 640}, {x = 1440, y = 493}, 
					 {x = 1190, y = 340}, {x = 596, y = 460}, {x = 410, y = 638}, {x = 558, y = 768},}

local sideResPathlist = {"lobby/resource/chips/70/1.png",
	"lobby/resource/chips/70/10.png",
	"lobby/resource/chips/70/100.png",
	"lobby/resource/chips/70/1k.png",
	"lobby/resource/chips/70/1w.png",
	"lobby/resource/chips/70/10w.png",
	"lobby/resource/chips/70/100w.png",
	"lobby/resource/chips/70/1000w.png",}


local panel_ui = require "game.texaspoker_std.script.ui_create.ui_texaspoker_main"

CTexasPokerMainScene = class("CTexasPokerMainScene", function ()
	local ret = cc.Node:create()
	return ret
end)

ModuleObjMgr.add_module_obj(CTexasPokerMainScene,"CTexasPokerMainScene")

function CTexasPokerMainScene.create()
	local node = CTexasPokerMainScene.new()
	if node ~= nil then
		node:loading()
		node:regEnterExit()
		node:regTouch()
		return node
	end
end

function CTexasPokerMainScene:loading()
    self.isLoadEnd = false
    self:initData()

	local info = {
		parent 			= WindowScene.getInstance().game_layer,
		task_call 		= function (percent,index,texture) self:addImageSrc(percent,index,texture) end,
		complete_call 	= function () self:loadEnded() end,
		--task_lst = {[x] = {src = "",},},
		ui_info = {
			back_pic 		= "game/texaspoker_std/resource/image/loading/bg.png",
			bar_back_pic 	= "game/texaspoker_std/resource/image/loading/loadingbg.png",
			bar_process_pic = "game/texaspoker_std/resource/image/loading/loading.png",
			b_self_release 	= true,
		},
	}

	info.task_lst = {}
	for i=1,#texaspoker_effect_res_config do
		local item = {src = texaspoker_effect_res_config[i].imageName,}
		info.task_lst[i] = item
	end
	self._loadingTask = LoadingTask.create(info)
end

function CTexasPokerMainScene:addImageSrc(percent,index,texture)
	-- print("index = " .. index .. ",plist path  = " .. texaspoker_effect_res_config[index].plistPath)

	local cache = cc.SpriteFrameCache:getInstance()
	cache:addSpriteFrames(texaspoker_effect_res_config[index].plistPath)
end

function CTexasPokerMainScene:regEnterExit()
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

function CTexasPokerMainScene:onEnter()
	audio_manager:reloadMusicByConfig(texaspoker_music_config)
end

function CTexasPokerMainScene:onExit()
    local cache = cc.SpriteFrameCache:getInstance()
    
    for k,v in pairs(texaspoker_effect_res_config) do
    	cache:removeSpriteFramesFromFile(v.plistPath)
    end

    audio_manager:destoryAllMusicRes()

	self:clearPanel()
end

function CTexasPokerMainScene:destoryLoading()
	if self._loadingTask then
    	self._loadingTask:forcedDestory()
        self._loadingTask = nil
    end
end

function CTexasPokerMainScene:initData()
	--公共牌图片
	self.publicCardImgMap = {}
	--公共牌
	self._publicCardArr = {}
	--我的手牌
	self._myCardArr = {}
	--玩家的手牌
	self._playerHandCardMap = {}

	--玩家的筹码图片
	self.playerChipsImgList = {}
	--玩家筹码
	self.playerChipsMap = {}
	--荷官筹码图片
	self.dealerChipsImgList = {}
	--玩家座位
	self._playerSeatMap = {}
	--荷官筹码
	self.dealerChips = "0"
	--玩家人数
	self._playerNumber = "0"

	--统计数据
	self.statistics_data = {count = 0, totalCount = 0}
	--各个玩家结算
	self.playersBalanceMap = {}

	self._gameIsGoing = false
end

function CTexasPokerMainScene:loadEnded()
	self._loadingTask = nil
	
	self:init_ui()
	self:initGameSeats(texaspoker_manager._seatsMap)
    self.isLoadEnd = true
    --背景音乐
	audio_manager:playBackgroundMusic(1, true)
end

function CTexasPokerMainScene:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.imgMaster:setVisible(false)

	--统计面板
	-- self.statistics_ui = CTexaspokerStatistics.create()
	-- self.panel_ui.bgImage:addChild(self.statistics_ui)
	-- self.statistics_ui:setPosition(1276, 1050)
	-- self.statistics_ui:setInfo({count = 0, totalCount = 0})

	--操作界面
	self.betPanel_ui = CTexasPokerBetExt.create()
	self:addChild(self.betPanel_ui)
	self.betPanel_ui:setPosition(0,0)
	self.betPanel_ui:setAnchorPoint(0,0)

	--筹码面板
	-- self.chipsPanel = CChipsPanel.create()
	-- self:addChild(self.chipsPanel)
	-- self.chipsPanel:setPosition(0,0)

	self:registerHandler()
	self.panel_ui.bgCard:setVisible(false)
	self.bIsShowCardPanel = false
	self.betPanel_ui:setVisible(false)

	self.panel_ui.sbtnKeepBet:setSelected(false)
	self.panel_ui.sbtnGiveUp:setSelected(false)
	self.panel_ui.sbtnKeepAny:setSelected(false)
	self.panel_ui.sprCardType:setVisible(false)
end

function CTexasPokerMainScene:registerHandler()
	--标题
	local function tipsCallBack()
		send_texaspoker_ReqExitTable()
	end

	local function closeFunc()
		if self._gameIsGoing then
			TipsManager:showTwoButtonTipsPanel(36, {}, true, tipsCallBack)
		else
			tipsCallBack()
		end
	end
	local title = WindowScene.getInstance():getModuleObjByClassName("CTableTitleExt")
	if title then
		title:setCloseFunc(closeFunc)
	end

	--开始/退出
	self.panel_ui.btnStart:onTouch(function (e)
		if e.name == "ended" then
			self:readyClickHandler(function ()
				send_texaspoker_ReqReady()
			end)
		end
	end)
	self.panel_ui.btnOut:onTouch(function (e)
		if e.name == "ended" then
			send_texaspoker_ReqExitTable()
		end
	end)
	self.panel_ui.btnExit:onTouch(function (e)
		if e.name == "ended" then
			send_texaspoker_ReqExitTable()
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
	--兑换
	self.panel_ui.btnExchange:onTouch(function (e)
		if e.name == "ended" then
			local playerInfo = get_player_info()
			TipsManager:showExchangePanel(texaspoker_manager._ownChips, playerInfo.gold)
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

	local stateButtoncallback = function (sender, eventType)
		if sender == self.panel_ui.sbtnKeepBet then
			if eventType == "selected" then
				texaspoker_manager.autoSelect = texaspoker_manager.AUTO_KEEP_BET_ONCE
			else
				texaspoker_manager.autoSelect = nil
                self.panel_ui.sbtnKeepBet:setSelected(false)
			end
            self.panel_ui.sbtnKeepBet:setEnabled(true)
			self.panel_ui.sbtnKeepBet:setBright(true)
		elseif sender == self.panel_ui.sbtnGiveUp then
			if eventType == "selected" then
				texaspoker_manager.autoSelect = texaspoker_manager.AUTO_PASS_ABANDON
			else
				texaspoker_manager.autoSelect = nil
                self.panel_ui.sbtnGiveUp:setSelected(false)
			end
            self.panel_ui.sbtnGiveUp:setEnabled(true)
			self.panel_ui.sbtnGiveUp:setBright(true)
		elseif sender == self.panel_ui.sbtnKeepAny then
			if eventType == "selected" then
				texaspoker_manager.autoSelect = texaspoker_manager.AUTP_KEEP_ANY_BET
			else
				texaspoker_manager.autoSelect = nil
                self.panel_ui.sbtnKeepAny:setSelected(false)
			end
            self.panel_ui.sbtnKeepAny:setEnabled(true)
			self.panel_ui.sbtnKeepAny:setBright(true)
		end
	end

	--statebutton 
	local btn_group_lst = {self.panel_ui.sbtnKeepBet,self.panel_ui.sbtnGiveUp,self.panel_ui.sbtnKeepAny,}
	WindowScene.getInstance():registerGroupEvent(btn_group_lst,stateButtoncallback)
end

--准备
function CTexasPokerMainScene:readyClickHandler(callback)
	local roominfo = get_player_info():get_cur_roomInfo()
	local myChips = self._playerSeatMap[texaspoker_manager._mySeatOrder].chips
	if long_compare(roominfo.minOne, myChips) > 0 then
		TipsManager:showExchangePanel(myChips, get_player_info().gold, callback)
	else
		send_texaspoker_ReqReady()
	end
end


--显示选择的牌型
function CTexasPokerMainScene:showSelectedCards(order)
	local arr = self._playerHandCardMap[order]
	if arr == nil then
		return
	end

	table.insertto(arr, self._publicCardArr, 0)
	local list, cardType = texas_card_check.findOutMaxPowerCards( arr )
	if list == nil or cardType == nil then
		return
	end

	for i,cardid in ipairs(list) do
		local find = false
		for i,id in ipairs(self._publicCardArr) do
			if id == cardid then
				find = true
				self.publicCardImgMap[id]:showSelectState()
			end
		end	

		if find == false and self._playerSeatMap[order] then
			self._playerSeatMap[order]:showSelectedCards({cardid})
		end

		print("显示选择的牌型---"..texas_card_data[cardid].name)
	end
	
	-- if self._cardEffectSprite == nil then
		-- dump(self._cardEffectSprite)
  --   	self._cardEffectSprite:removeFromParent()
  --   	self._cardEffectSprite = nil
	  -- self._cardEffectSprite = cc.Sprite:create()
   --  end
    
    -- dump(texaspoker_effect_config[cardType])
    self.panel_ui.sprCardType:setTexture(texaspoker_effect_config[cardType])
	-- self._cardEffectSprite = animationUtils.createAndPlayAnimation(self, texaspoker_effect_config[cardType])
	self.panel_ui.sprCardType:setAnchorPoint(0.5,0.5)
	self.panel_ui.sprCardType:setPosition(cardEndPosArr[texaspoker_manager:getRealOrder(order)])
	-- self.panel_ui.sprCardType:setPosition(cc.p(800,600))
	self.panel_ui.sprCardType:setTag(order)
	self.panel_ui.sprCardType:setVisible(true)
end

--隐藏选择的牌型
function CTexasPokerMainScene:hideSelectCards(order)
	for i,id in ipairs(self._publicCardArr) do
		self.publicCardImgMap[id]:hideSelectState()
	end

	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:hideSelectState()
	end
end

--释放资源
function CTexasPokerMainScene:clearPanel()
	self:resetGameData()

	--清理座位
    if self._playerSeatMap then
	    for k,img in pairs(self._playerSeatMap) do
		    img:removeFromParent()
	    end
    end
	self._playerSeatMap = {}

end

--重置游戏数据
function CTexasPokerMainScene:resetGameData()
	--清理公共牌
    if self.publicCardImgMap then
	    for k,img in pairs(self.publicCardImgMap) do
		    img:removeFromParent()
	    end
    end
	self.publicCardImgMap = {}

	self._publicCardArr = {}
	self._myCardArr = {}
	self._playerHandCardMap = {}

	--清理玩家筹码
    if self.playerChipsImgList then
	    for k,imgs in pairs(self.playerChipsImgList) do
		    for i,img in pairs(imgs) do
			    img:removeFromParent()
		    end
	    end
    end
	self.playerChipsImgList = {}

	--清理汇总筹码
    if self.dealerChipsImgList then
	    for k,img in pairs(self.dealerChipsImgList) do
		    img:removeFromParent()
	    end
	    self.dealerChipsImgList = {}
    end

    if self._playerSeatMap then
	    for k,seatObj in pairs(self._playerSeatMap) do
		    seatObj:clearGameInfo()
	    end
    end

    self.statistics_data.count = 0

    --荷官筹码
	self.dealerChips = "0"
    self.playerChipsMap = {}

    self.playersBalanceMap = {}

    --牌型特效
    -- if self._cardEffectSprite then
    -- 	-- dump(self._cardEffectSprite)
    -- 	-- self._cardEffectSprite:removeFromParent()
    -- 	-- self._cardEffectSprite = nil
    -- 	self._cardEffectSprite:setVisible(false)
    -- end
    self.panel_ui.sprCardType:setVisible(false)

    if self.panel_ui then
        self.panel_ui.imgMaster:setVisible(false)
        self.panel_ui.sprDealNumBack:setVisible(false)
    end
end

--初始化桌位信息
function CTexasPokerMainScene:initGameSeats(seats)
	--清理座位
	for k,seatObj in pairs(self._playerSeatMap) do
		seatObj:removeFromParent()
	end
	self._playerSeatMap = {}

	for order = 1,TOTAL_SEAT_NUM do
		local seatinfo = seats[order]
		if seatinfo then
			self:createPlayer(seatinfo)
		end

		local key = "sprNumBack"..order
		self.panel_ui[key]:setVisible(false)
		self.panel_ui[key]:setPosition(cardEndPosArr[texaspoker_manager:getRealOrder(order)])
	end

	self.panel_ui.sprDealNumBack:setVisible(false)
	local posX, posY = self.panel_ui.totalChipsCon:getPosition()
	self.panel_ui.sprDealNumBack:setPosition(posX, posY + 60)
	-- local realOrder = texaspoker_manager:getRealOrder(texaspoker_manager._mySeatOrder)
	-- self.panel_ui.imgMySelf:setPosition(texas_selfPos_config[realOrder].pos)

	self:enterReadyStage()
end

--创建玩家
function CTexasPokerMainScene:createPlayer(memberInfo)
	local seatObj = CTexasPlayerExt.create(texaspoker_manager:getRealOrder(memberInfo.order))
	self.panel_ui.nodePlayer:addChild(seatObj)
	-- seatObj:setPosition(seatPosArr[memberInfo.order])
	seatObj:setInfo(memberInfo)

	self._playerSeatMap[memberInfo.order] = seatObj

	self._playerNumber = self._playerNumber + 1
end

--删除玩家
function CTexasPokerMainScene:removePlayer(order)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:removeFromParent()
		self._playerSeatMap[order] = nil
	end

	self._playerHandCardMap[order] = nil

	self._playerNumber =  self._playerNumber - 1
	local tag = self.panel_ui.sprCardType:getTag()
	if tag == order then
		self.panel_ui.sprCardType:setVisible(false)
	end
end

--玩家准备
function CTexasPokerMainScene:setPlayerReady(order)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:setPlayerReady(true)

		if order == texaspoker_manager._mySeatOrder then
			self:exitReadyStage()
		end
	end
end

--进入准备阶段
function CTexasPokerMainScene:enterReadyStage()
	local seatObj = self._playerSeatMap[texaspoker_manager._mySeatOrder]
	seatObj:startTimeDown(1, function ()
		--退出
		send_texaspoker_ReqExitTable()
	end)

	self.panel_ui.btnOut:setVisible(true)
	self.panel_ui.btnStart:setVisible(true)

	self.betPanel_ui:showHideBetButtons(false)
	self:showHideAddRecChipsButton(true)

	if texaspoker_manager.isAutoReady then
		self:readyClickHandler(function ()
				send_texaspoker_ReqReady()
			end)
	end
end

--离开准备阶段
function CTexasPokerMainScene:exitReadyStage()
	self.panel_ui.btnOut:setVisible(false)
	self.panel_ui.btnStart:setVisible(false)
	self.betPanel_ui:showHideMingBtn(false)

	self:showHideAddRecChipsButton(false)
end

--进入发手牌阶段
function CTexasPokerMainScene:enterSendHandCardStage(cards)
	--游戏开始音效
	audio_manager:playOtherSound(1)

	self._myCardArr = cards
	self._playerHandCardMap[texaspoker_manager._mySeatOrder] = cards

	--隐藏准备图片
	for k,seatobj in pairs(self._playerSeatMap) do
		seatobj:setPlayerReady(false)
	end

	local myIndex = 1
	local count = 0
	local num = 0
	for i=1,2 do
		for k,seatObj in pairs(self._playerSeatMap) do
			local function sendCardCallBack(isFinal)
				if seatObj.order == texaspoker_manager._mySeatOrder then
					seatObj:addOneHandCard(self._myCardArr[myIndex])
					myIndex = myIndex + 1
				else
					seatObj:addOneHandCard()
				end
				--通知后端发牌结束
				if isFinal then
					local _playerInfo = get_player_info()

					send_texaspoker_ReqDealCardOver({roomId = _playerInfo.myDesksInfo[1].roomId, tableId = seatObj.tableId})
					print("send  success~~~")
				end
			end

			performWithDelay(seatObj, function ()
				count = count + 1
				self:showSendHandCardAction(cardEndPosArr[texaspoker_manager:getRealOrder(seatObj.order)], sendCardCallBack, count == self._playerNumber * 2)
			end, 0.1*num)

			num = num + 1
		end
	end
end

--离开发手牌阶段
function CTexasPokerMainScene:exitSendHandCardStage()
	
end

--玩家 进入下注阶段
function CTexasPokerMainScene:enterBetStage(order, raisetBet, maxBet)
	--已经下的注
	local alreadyBetChips = self.playerChipsMap[order] == nil and 0 or self.playerChipsMap[order]
    -- print("~~已经下注的筹码：", alreadyBetChips)
    -- print("~~~~~~~~~~最大注：", maxBet)
    -- print("~~~~~~~~加注额度：", raisetBet)
    local tmpNum = long_plus(raisetBet, maxBet)
    tmpNum = long_minus(tmpNum, alreadyBetChips)
    -- print("~~~~~~~~加注下限：", tmpNum)
	self.betPanel_ui:setRaiseBetLimit(tmpNum)

	tmpNum = long_minus(maxBet, alreadyBetChips)
	self.betPanel_ui:setKeepBet(tmpNum)

	if order == texaspoker_manager._mySeatOrder then
        self.betPanel_ui:autoPlayGame()
	end

	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:startTimeDown(2)
	end
	if order == texaspoker_manager._mySeatOrder then
		self.betPanel_ui:setVisible(true)
		self.betPanel_ui:showHideBetButtons(true)
	else
		self.betPanel_ui:showHideBetButtons(false)
		self.betPanel_ui:setVisible(false)
	end
end

--玩家 离开下注阶段
function CTexasPokerMainScene:exitBetStage(order)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:clearTimeDown()
	end

	if order == texaspoker_manager._mySeatOrder then
		self.betPanel_ui:showHideBetButtons(false)
	end
end

--发公共牌
function CTexasPokerMainScene:sendPublicCards(cardList, isInform)
	for i,cardid in ipairs(cardList) do
		if self._publicCardArr == nil or #self._publicCardArr >= 5 then
			TipsManager:showOneButtonTipsPanel( 100016, {"超出5张牌了"..#self._publicCardArr}, true)
			return
		end
	    local cardItem = CTexasCardItem.create(texas_card_data[cardid].card_big)
	    self.panel_ui.bgImage:addChild(cardItem)
	    cardItem:setPosition(self.panel_ui.totalChipsCon:getPosition())
		self.publicCardImgMap[cardid] = cardItem
		table.insert(self._publicCardArr, cardid)

		local moveAction = cc.MoveTo:create(SEND_CARD_SPEED, publicCardsPosArr[#self._publicCardArr])

		if i == #cardList then
			local call_action = cc.CallFunc:create(function (node)
				--通知后端发牌结束
				local _playerInfo = get_player_info()
				local mySeat = texaspoker_manager._seatsMap[texaspoker_manager._mySeatOrder]

				if isInform then
					send_texaspoker_ReqDealCardOver({roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
					-- print("send  success~~~")
				end
	    	end)
	    	local seq = cc.Sequence:create({moveAction, call_action})
	    	cardItem:runAction( seq )
	    else
	    	local seq = cc.Sequence:create({moveAction})
	    	cardItem:runAction( seq )
		end
	    
	    --发底牌音效
		audio_manager:playOtherSound(5)
	end
	
end

--进入结算阶段
function CTexasPokerMainScene:enterCompleteStage()
    -- self.statistics_ui:setInfo(self.statistics_data)
	self.dealerChips = 0
	self:updateDealerChips()

	self.betPanel_ui:showHideBetButtons(false)

	-- HallManager:addGameBalanceInTalk(self.playersBalanceMap)

	--重置准备
	texaspoker_manager:resetReadyState()

	self._gameIsGoing = false

    self:enterReadyStage()
end

--离开结算阶段
function CTexasPokerMainScene:exitCompleteStage()
    
end

--播发发手牌动作
function CTexasPokerMainScene:showSendHandCardAction(endPos, callback, isFinal)
	local imgFrame = display.newSpriteFrame(texas_card_data[52].card_big)
    local imgBackCard = cc.Sprite:createWithSpriteFrame(imgFrame)
    self:addChild(imgBackCard)
    imgBackCard:setPosition(self.panel_ui.totalChipsCon:getPosition())

    local moveAction = cc.MoveTo:create(SEND_CARD_SPEED, endPos)
    local call_action = cc.CallFunc:create(function (node)
		node:stopAllActions()
		node:removeFromParent()
		node = nil

    	callback(isFinal)
    end)

    local seq = cc.Sequence:create({moveAction, call_action})
    imgBackCard:runAction( seq )
end

--更新玩家筹码
function CTexasPokerMainScene:updateChips(order, chips)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:setChips(chips)
	end

    local seatInfo = texaspoker_manager._seatsMap[order]
    if seatInfo then
        seatInfo.chips = chips
    end

	-- if order == texaspoker_manager._mySeatOrder then
	-- 	self.chipsPanel:setChips(chips)
	-- end
end

--设置庄家
function CTexasPokerMainScene:setMasterPlayer( order )
	self.panel_ui.imgMaster:setVisible(true)
	self.panel_ui.imgMaster:setPosition( texas_masterPos_config[texaspoker_manager:getRealOrder(order)].pos ) 
end

--玩家下注  isInform 是否通知后端下注动作 结束
function CTexasPokerMainScene:playerBetChips(order, betType, value, isInform)
	if self._playerSeatMap[order] == nil then
		return
	end

	self._playerSeatMap[order]:setPlayerState(betType)

	self.dealerChips = long_plus(self.dealerChips, value)

	if long_compare(value, 0) == 0 then
		--通知后端发牌
		if order == texaspoker_manager._mySeatOrder and isInform then
			send_texaspoker_ReqNextStep()
		end
	else
		--下注筹码音效
		audio_manager:playOtherSound(4)
	end

	if self.playersBalanceMap[order] == nil then
		self.playersBalanceMap[order] = {}
		local seatObj = self._playerSeatMap[order]
		if seatObj then
			self.playersBalanceMap[order].name = seatObj.playerName
		end
		self.playersBalanceMap[order].chips = long_minus(0, value)
	else
		self.playersBalanceMap[order].chips = long_minus(self.playersBalanceMap[order].chips, value)
	end

	--下注统计
	if order == texaspoker_manager._mySeatOrder then
		self.statistics_data.count = long_minus(self.statistics_data.count, value)
        -- print("我下注：", value)
	end

	--玩家下注音效
	local sex = self._playerSeatMap[order].sex
	-- print("sex = " ..sex)

	local key = "fntBetChips"..order
	self.panel_ui[key]:setVisible(true)
	key = "ImgGiveUp"..order
	self.panel_ui[key]:setVisible(false)

	if betType == texaspoker_manager.GameState.ADD_BET then--加注
		audio_manager:playPlayerSound(1, sex)
	elseif betType == texaspoker_manager.GameState.ALL_BET then--梭哈
		audio_manager:playPlayerSound(2, sex)
	elseif betType == texaspoker_manager.GameState.KEEP_BET then--跟注
		audio_manager:playPlayerSound(3, sex)
	elseif betType == texaspoker_manager.GameState.PASS_CARD then--让牌
		audio_manager:playPlayerSound(4, sex)
	elseif betType == texaspoker_manager.GameState.GIVE_UP then--弃牌
		audio_manager:playPlayerSound(5, sex)

		key = "fntBetChips"..order
		self.panel_ui[key]:setVisible(false)
		key = "ImgGiveUp"..order
		self.panel_ui[key]:setVisible(true)
	end

	local numArr = gsplit(value)
	numArr = table.reverse(numArr)
	for i,v in ipairs(numArr) do
		for k = 1,v do
			local params = {}
			params.endPos_x = math.random(chipsPosArr.x-THROW_WIDTH, chipsPosArr.x + THROW_WIDTH)
			params.endPos_y = math.random(chipsPosArr.y, chipsPosArr.y + THROW_HEIGHT)
			--回调选择
			if k == v and i == #numArr then
				params.flyendCallback = function ()
					--通知后端发牌
					if order == texaspoker_manager._mySeatOrder and isInform then
						send_texaspoker_ReqNextStep()
					end
				end
			end

			local startP_x, startP_y = self._playerSeatMap[order]:getPosition()
			local sprite = display.newSprite(sideResPathlist[i], startP_x, startP_y)
			sprite:setAnchorPoint(0.5,0.5)
			self.panel_ui.chipsCon:addChild(sprite)
			CFlyAction:Fly(sprite, 0.2, params, CFlyAction.FLY_TYPE_CHIPS)

			if self.playerChipsImgList[order] == nil then
				self.playerChipsImgList[order] = {}
			end
			table.insert( self.playerChipsImgList[order], sprite )
		end
	end

	if self.playerChipsMap[order] == nil then
		self.playerChipsMap[order] = value
	else
		self.playerChipsMap[order] = long_plus(value, self.playerChipsMap[order])
	end

	key = "sprNumBack"..order
	self.panel_ui[key]:setVisible(true)
	key = "fntBetChips"..order
	self.panel_ui[key]:setString(self.playerChipsMap[order])
end

--玩家赌注集合到荷官
function CTexasPokerMainScene:playerBetTogether(callback)
    local callCount = 0
    local totalCount = table.nums(self.playerChipsImgList)
    
    local isNoChips = true
	for order,imgs in pairs(self.playerChipsImgList) do
		for i,img in ipairs(imgs) do
			local params = {}
			params.endPos_x = self.panel_ui.totalChipsCon:getPositionX()
			params.endPos_y = self.panel_ui.totalChipsCon:getPositionY()
			--回调选择
			if i == #imgs then
				params.flyendCallback = function ()
					img:removeFromParent()
					self:updateDealerChips()

                    callCount = callCount + 1

                    if callCount == totalCount then
                        callback()
                    end
				end
			else
				params.flyendCallback = function ()
					img:removeFromParent()
				end
			end

			img:stopAllActions()
			CFlyAction:Fly(img, 1, params, CFlyAction.FLY_TYPE_CHIPS)

            isNoChips = false
		end
	end

	for order = 1,TOTAL_SEAT_NUM do
		local key = "sprNumBack"..order
		self.panel_ui[key]:setVisible(false)
	end

	self.playerChipsImgList = {}
	self.playerChipsMap = {}

	if isNoChips then
		self:updateDealerChips()
        callback()
    else
    	--播发筹码集合的音效
    	audio_manager:playOtherSound(6)
    end
end

--更新荷官的筹码
function CTexasPokerMainScene:updateDealerChips()
	for k,img in pairs(self.dealerChipsImgList) do
		img:removeFromParent()
	end
	self.dealerChipsImgList = {}

	-- if long_compare(self.dealerChips, 0) > 0 then
	-- 	self.panel_ui.sprDealNumBack:setVisible(true)
	-- end
	self.panel_ui.fntDealBetChips:setString(self.dealerChips)

	local numArr = gsplit(self.dealerChips)
	numArr = table.reverse(numArr)

	local sprWidth = 0
	local count = 0
	for i,v in ipairs(numArr) do
		if v ~= 0 then
			count = count+1
			if count < 5 then
				for k = 1,v do
					local startP_x = self.panel_ui.totalChipsCon:getPositionX()
					local startP_y = 5 * (k - 1) + self.panel_ui.totalChipsCon:getPositionY()
					local sprite = display.newSprite(sideResPathlist[i])
					sprite:setAnchorPoint(0.5,0.5)

					sprWidth = sprite:getContentSize().width
					local init_x = startP_x + sprWidth * 2--math.floor(4 / 2)
					startP_x = init_x - sprWidth * (count-1)

					sprite:setPosition(startP_x, startP_y)
					self.panel_ui.chipsCon:addChild(sprite)

					table.insert(self.dealerChipsImgList, sprite)
				end
			else
				for k = 1,v do
					local startP_x = self.panel_ui.totalChipsCon:getPositionX()
					local startP_y = 5 * (k - 1) + self.panel_ui.totalChipsCon:getPositionY() - 80
					local sprite = display.newSprite(sideResPathlist[i])
					sprite:setAnchorPoint(0.5,0.5)

					sprWidth = sprite:getContentSize().width
					local init_x = startP_x + sprWidth * 2--math.floor(4 / 2)
					startP_x = init_x - sprWidth * (count-4-1)

					sprite:setPosition(startP_x, startP_y)
					self.panel_ui.chipsCon:addChild(sprite)

					table.insert(self.dealerChipsImgList, sprite)
				end
			end
		end
	end
end

--将筹码分给玩家
function CTexasPokerMainScene:splitChipsToPlayer(index, chipsInfoArr)
	local info = chipsInfoArr[index]
	if info == nil then
		return
	end

	--显示玩家的牌型
	self:showSelectedCards(info.order)

	self.playersBalanceMap[info.order].chips = long_plus(self.playersBalanceMap[info.order].chips, info.bet)

	if info.order == texaspoker_manager._mySeatOrder then
		self.statistics_data.count = long_plus(self.statistics_data.count, info.bet) 
	 	self.statistics_data.totalCount = long_plus(self.statistics_data.totalCount, self.statistics_data.count)
	end


	--减去荷官筹码
	self.dealerChips = long_minus(self.dealerChips, info.bet)
    if long_compare(self.dealerChips, 0) < 0 then
        self.dealerChips = 0
        print("~~~~~~~~~~~~~有问题，最总奖励大于荷官的筹码")
    end
	self:updateDealerChips()

	--筹码来我碗里
	local sprRoot = cc.Node:create()
	self.panel_ui.chipsCon:addChild(sprRoot)
	sprRoot:setPosition(self.panel_ui.totalChipsCon:getPosition())

	local numArr = gsplit(info.bet)
	numArr = table.reverse(numArr)
	local count = 0
	for i,v in ipairs(numArr) do
		if v ~= 0 then
			count = count + 1
			if count < 5 then
				for k = 1,v do
					local startP_x = 0
					local startP_y = 5 * (k - 1)
					local sprite = display.newSprite(sideResPathlist[i])
					sprite:setAnchorPoint(0.5,0.5)

					sprWidth = sprite:getContentSize().width
					local init_x = startP_x + sprWidth * 2--math.floor(#numArr / 2)
					startP_x = init_x - sprWidth * (count-1)

					sprite:setPosition(startP_x, startP_y)
					sprRoot:addChild(sprite)
				end
			else
				for k = 1,v do
					local startP_x = 0
					local startP_y = 5 * (k - 1) - 80
					local sprite = display.newSprite(sideResPathlist[i])
					sprite:setAnchorPoint(0.5,0.5)

					sprWidth = sprite:getContentSize().width
					local init_x = startP_x + sprWidth * 2--math.floor(#numArr / 2)
					startP_x = init_x - sprWidth * (count-4-1)

					sprite:setPosition(startP_x, startP_y)
					sprRoot:addChild(sprite)
				end
			end
		end
	end

	local params = {}
	local realOrder = texaspoker_manager:getRealOrder(info.order)
	params.endPos_x = cardEndPosArr[realOrder].x
	params.endPos_y = cardEndPosArr[realOrder].y
	params.flyendCallback = function ()
					sprRoot:removeFromParent()
					sprRoot = nil
					local seatObj = self._playerSeatMap[info.order]
					if seatObj then
						seatObj:setChips(seatObj.chips + info.bet)

						-- if info.order == texaspoker_manager._mySeatOrder then
						-- 	self.chipsPanel:setChips(seatObj.chips)
						-- end
					end

					if index + 1 > #chipsInfoArr then
						self:enterCompleteStage()
					else
						self:hideSelectCards(info.order)
						self:splitChipsToPlayer(index + 1, chipsInfoArr)
					end
				end

	CFlyAction:Fly(sprRoot, 2, params, CFlyAction.FLY_TYPE_CHIPS)
end

--将筹码全都分给winner
function CTexasPokerMainScene:giveWinnerAllChips(order, chips, type)
	--正常结算
	if type == 0 then
		--显示玩家的牌型
		self:showSelectedCards(order)
	else
		--赢的人是自己
		if texaspoker_manager._mySeatOrder == order and #self._publicCardArr == 5 then
			self:setMyMingBtn()
		end
	end

	self.playersBalanceMap[order].chips = long_plus(self.playersBalanceMap[order].chips, chips)

	if order == texaspoker_manager._mySeatOrder then
		self.statistics_data.count = long_plus(self.statistics_data.count, chips)
	end
    self.statistics_data.totalCount = long_plus(self.statistics_data.totalCount, self.statistics_data.count)
	--self.statistics_ui:setInfo(self.statistics_data)

	for k,img in ipairs(self.dealerChipsImgList) do
		local params = {}
		local realOrder = texaspoker_manager:getRealOrder(order)
		params.endPos_x = cardEndPosArr[realOrder].x
		params.endPos_y = cardEndPosArr[realOrder].y
		--回调选择
		if k == #self.dealerChipsImgList then
			params.flyendCallback = function ()
						img:removeFromParent()
						img = nil

						local seatObj = self._playerSeatMap[order]
						if seatObj then
							seatObj:setChips(seatObj.chips + chips)

							-- if order == texaspoker_manager._mySeatOrder then
							-- 	self.chipsPanel:setChips(seatObj.chips)
							-- end
						end

						self:enterCompleteStage()
					end
		else
			params.flyendCallback = function ()
						img:removeFromParent()
						img = nil
					end
		end

		CFlyAction:Fly(img, 1, params, CFlyAction.FLY_TYPE_CHIPS)
	end

	self.dealerChips = "0"
	self.panel_ui.fntDealBetChips:setString(self.dealerChips)

    self.dealerChipsImgList = {}
end

--玩家亮牌
function CTexasPokerMainScene:playerShowCards(order, cards)
	self._playerHandCardMap[order] = cards

	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj.handCardNum	 = 0
		seatObj:addOneHandCard(cards[1])
		seatObj:addOneHandCard(cards[2])
	end
end

--设置玩家 明牌按钮
function CTexasPokerMainScene:setMyMingBtn()
	for k,seatObj in pairs(self._playerSeatMap) do
		if seatObj.order ~= texaspoker_manager._mySeatOrder then
			if seatObj.state ~= texaspoker_manager.GameState.GIVE_UP then
				return
			end
		end
	end

	self.betPanel_ui:showHideMingBtn(true)
end

function CTexasPokerMainScene:regTouch()
	-- body
	local function __on_touch_began(touch, event)
        return true
    end

    local function __on_touch_moved(touch,event)
        return true
    end

    local function __on_touch_ended(touch, event)
        -- local location = touch:getLocation()
        return self:onTouchEnded(touch, event)
    end
    
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(__on_touch_began,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(__on_touch_moved,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(__on_touch_ended,cc.Handler.EVENT_TOUCH_ENDED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)
end

function CTexasPokerMainScene:onTouchEnded(touch, event)
	local a,b = self.panel_ui.bgCard:getPosition()
	local pos = self.panel_ui.bgCard:convertToWorldSpace(cc.p(0,0))
	local boundingBox = self.panel_ui.bgCard:getBoundingBox()
	boundingBox.x = pos.x
	boundingBox.y = pos.y
	local pt = cc.Director:getInstance():convertToGL(touch:getLocation())
	if cc.rectContainsPoint(boundingBox, pt) ~= true then
		if self.bIsShowCardPanel then
			self.bIsShowCardPanel = false
			self.panel_ui.bgCard:setVisible(false)
			self.panel_ui.bgCard:setTouchEnabled(false)
		end
	end
end

--启用/禁用兑换按钮
function CTexasPokerMainScene:showHideAddRecChipsButton(value)
	self.panel_ui.btnExchange:setEnabled(value)	
	self.panel_ui.btnExchange:setBright(value)
end