--[[[
斗地主比赛主场景
]]

--玩家位置坐标
local _seatPosArr = {{x = 345, y = 170}, {x = 1800, y = 630}, {x = 112, y = 630}}

local _seatOrderMap = {}

local TOTAL_SEAT_NUM = 3

local CALL_TIME = doudizhu_time_config[2].time
local ADD_SCORE_TIME = doudizhu_time_config[3].time
local WAIT_TIME = doudizhu_time_config[4].time

local panel_ui = require "game.ddz_match_std.script.ui_create.ui_ddzMatch_mainscene"

CDdzMatchMainScene = class("CDdzMatchMainScene", function ()
	local ret = cc.Node:create()
	return ret		
end)

ModuleObjMgr.add_module_obj(CDdzMatchMainScene,"CDdzMatchMainScene")

function CDdzMatchMainScene.create()
	local node = CDdzMatchMainScene.new()
	if node ~= nil then
		node:regEnterExit()
		node:loading()
		return node
	end
end

function CDdzMatchMainScene:regEnterExit()
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

function CDdzMatchMainScene:onEnter()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)

	self:addButtonHightLight()
	self:registerHandler()
	self:initGameData()
end

function CDdzMatchMainScene:onExit()
	self:clearPanel()
end


function CDdzMatchMainScene:loading()
	local info = {
		parent 			= WindowScene.getInstance().game_layer,
		task_call 		= function (percent,index,texture) self:addImageSrc(percent,index,texture) end,
		complete_call 	= function () self:loadEnded() end,
		--task_lst = {[x] = {src = "",},},
		ui_info = {
			back_pic 		= "game/ddz_match_std/resource/image/lodingBj.jpg",
			bar_back_pic 	= "game/ddz_match_std/resource/image/jdtdk.png",
			bar_process_pic = "game/ddz_match_std/resource/image/jdt1.png",
			b_self_release 	= true,
		},
	}

	info.task_lst = {}
	for i=1,#ddz_match_effect_res_config do
		local item = {src = ddz_match_effect_res_config[i].imageName,}
		info.task_lst[i] = item
	end
	self._loadingTask = LoadingTask.create(info)
end

function CDdzMatchMainScene:destoryLoading()
	if self._loadingTask then
    	self._loadingTask:forcedDestory()
        self._loadingTask = nil
    end
end

function CDdzMatchMainScene:addImageSrc(percent,index,texture)
	local cache = cc.SpriteFrameCache:getInstance()
	cache:addSpriteFrames(ddz_match_effect_res_config[index].plistPath)
end

function CDdzMatchMainScene:loadEnded()
	self._loadingTask = nil
	audio_manager:reloadMusicByConfig(ddz_match_music_config)

	self:clearGame()

	send_doudizhu_ReqReady()

	audio_manager:playBackgroundMusic(1, true)

	audio_manager:initGameAudio()
	-- self._recordMatchRunsInfo = {runs = 5, nums = {99, 24, 12, 6, 3}, tables = 0}	
	-- self:showRankingWaitPanel()
end

--释放资源
function CDdzMatchMainScene:clearPanel()
	if self._cardListCon then
		self._cardListCon:clear()
		self._cardListCon:removeFromParent()
		self._cardListCon = nil
	end

	if self._rewardPanel then
		self._rewardPanel:removeFromParent()
		self._rewardPanel = nil
	end

	if self._waitEffect then
		self._waitEffect:removeFromParent()
		self._waitEffect = nil
	end

	if self._rankingWaitPanel then
		self._rankingWaitPanel:removeFromParent()
		self._rankingWaitPanel = nil
	end

	for k,seatObj in pairs(self._playerSeatMap) do
		seatObj:removeFromParent()
	end
	self._playerSeatMap = nil

	self:stopAllActions()

	local cache = cc.SpriteFrameCache:getInstance()
    for k,v in pairs(ddz_match_effect_res_config) do
    	cache:removeSpriteFramesFromFile(v.plistPath)
    end

	audio_manager:destoryAllMusicRes()
end

function CDdzMatchMainScene:addButtonHightLight()
	local btnArr = {self.panel_ui.btnCalldz, self.panel_ui.btnNotCall,
					self.panel_ui.btnRobot, self.panel_ui.btnNotRobot,
					self.panel_ui.btnAddScore, self.panel_ui.btnNotAdd,
					self.panel_ui.btnPutOutCard, self.panel_ui.btnNotOut, self.panel_ui.btnTips,
					self.panel_ui.btnIrony, self.panel_ui.btnBequick, self.panel_ui.btnPraise,
			}

	local resArr = {"jiaodizhu2.png", "bujiao2.png",
					"qiangdizhu2.png", "buqiang2.png",
					"jiabei2.png", "bujiabei2.png",
					"cp3.png", "buchu2.png", "tishi2.png",
					"chaofeng2.png", "cuipai2.png", "zanyang2.png",
					}

	for i,btn in ipairs(btnArr) do
		local mov_obj = cc.Sprite:create("game/ddz_match_std/resource/button/"..resArr[i])
		WindowScene.getInstance():registerBtnMouseMoveEff(btn,mov_obj,1)
	end
end

function CDdzMatchMainScene:registerHandler()
	--标题
	local function tipsCallBack()
		send_doudizhu_ReqWithdraw()
	end

	local function closeFunc()
		if self._gameOver == false then
			TipsManager:showTwoButtonTipsPanel(36, {}, true, tipsCallBack)
		else
			tipsCallBack()
		end
	end
	local title = WindowScene.getInstance():getModuleObjByClassName("CTableTitleExt")
	if title then
		title:setCloseFunc(closeFunc)
	end

	self.panel_ui.btnCalldz:onTouch(function (e)
		if e.name == "ended" then
			send_doudizhu_ReqCallCard({type = 1})
		end
	end)
	self.panel_ui.btnNotCall:onTouch(function (e)
		if e.name == "ended" then
			send_doudizhu_ReqCallCard({type = 0})
		end
	end)

	self.panel_ui.btnRobot:onTouch(function (e)
		if e.name == "ended" then
			send_doudizhu_ReqCallCard({type = 3})
		end
	end)
	self.panel_ui.btnNotRobot:onTouch(function (e)
		if e.name == "ended" then
			send_doudizhu_ReqCallCard({type = 2})
		end
	end)

	self.panel_ui.btnAddScore:onTouch(function (e)
		if e.name == "ended" then
			send_doudizhu_ReqDouble({doubled = 1})
		end
	end)
	self.panel_ui.btnNotAdd:onTouch(function (e)
		if e.name == "ended" then
			send_doudizhu_ReqDouble({doubled = 0})
		end
	end)

	self.panel_ui.btnPutOutCard:onTouch(function (e)
		if e.name == "ended" then
			self:mainPlayerOutCardsHandler()
		end
	end)
	self.panel_ui.btnNotOut:onTouch(function (e)
		if e.name == "ended" then
			send_doudizhu_ReqAbandon()
		end
	end)
	self.panel_ui.btnTips:onTouch(function (e)
		if e.name == "ended" then
			send_doudizhu_ReqPrompt()
		end
	end)

	self.panel_ui.btnIrony:onTouch(function (e)
		if e.name == "ended" then
			send_doudizhu_ReqShout({type = 1})
			self.panel_ui.btnIrony:setVisible(false)
			performWithDelay(self.panel_ui.btnIrony, function ()
				self.panel_ui.btnIrony:setVisible(true)
			end, 5)
		end
	end)
	self.panel_ui.btnBequick:onTouch(function (e)
		if e.name == "ended" then
			send_doudizhu_ReqShout({type = 2})
			self.panel_ui.btnBequick:setVisible(false)
			performWithDelay(self.panel_ui.btnBequick, function ()
				self.panel_ui.btnBequick:setVisible(true)
			end, 5)
		end
	end)
	self.panel_ui.btnPraise:onTouch(function (e)
		if e.name == "ended" then
			send_doudizhu_ReqShout({type = 3})
			self.panel_ui.btnPraise:setVisible(false)
			performWithDelay(self.panel_ui.btnPraise, function ()
				self.panel_ui.btnPraise:setVisible(true)
			end, 5)
		end
	end)
end

--检测鼠标碰撞
function CDdzMatchMainScene:checkIsContainButton( point )
	local btnArr = {self.panel_ui.btnCalldz,
	self.panel_ui.btnNotCall,
	self.panel_ui.btnRobot,
	self.panel_ui.btnNotRobot,
	self.panel_ui.btnAddScore,
	self.panel_ui.btnNotAdd,
	self.panel_ui.btnPutOutCard,
	self.panel_ui.btnNotOut,
	self.panel_ui.btnTips,
	self.panel_ui.btnIrony,
	self.panel_ui.btnBequick,
	self.panel_ui.btnPraise,}

	for i,btn in ipairs(btnArr) do
		if btn:hitTest(point) then
			return true
		end
	end

	return false
end

function CDdzMatchMainScene:initGameData()
	--玩家座位
	self._playerSeatMap = {}
	self._cardListCon = nil
	self._diZhuPlayerOrder = 0
	self._forwardCards = nil
	--加倍处理人数
	self._doublerHandlerNum = 0
	--游戏倍数
	self._gameMultiply = 1
	
	self._gameRecordData = {
	farmerIsOutCard = false,--农民是否出过牌
	diZhuIsOutCard = false,--地主是否出过牌
	rocketIsOut = false,--是否有火箭
	boomNum = 0,--炸弹个数
	}
	self._gameOver = false

	--排名面板
	self._rankingPanel = CDdzMatchRanking.create()
	self.panel_ui.layer:addChild(self._rankingPanel, 100)
	local windowSize = WindowScene.getInstance():getDesSize()
	self._rankingPanel:setPosition(windowSize.w, windowSize.h/3)

	self:hideButtons()

	--是否是第一次出牌
	self._isFirstOutCard = true
	--是否可以显示晋级面板
	self._isCanShowAdvance = false
	--结算是否展示完毕
	self._showSettlementOver = false
	--记录晋级面板信息
	self._recordMatchRunsInfo = nil
	--记录奖励面板信息
	self._recordRewardInfo = nil

	self.panel_ui.btnIrony:setVisible(false)
	self.panel_ui.btnBequick:setVisible(false)
	self.panel_ui.btnPraise:setVisible(false)
end


--初始化桌位信息
function CDdzMatchMainScene:initGameSeats(seats, runsPlayerNum)
	self:clearGame()

	self._isFirstOutCard = true
	self._isCanShowAdvance = false
	self._showSettlementOver = false
	self._recordMatchRunsInfo = nil
	self._recordRewardInfo = nil

	--座位排列
	local seatList = {CDdzMatchPlayer.create(1), CDdzMatchPlayer.create(2),
					  CDdzMatchPlayer.create(3)}

	local order = ddz_match_manager._mySeatOrder
	for i = 1, TOTAL_SEAT_NUM do

		local seatObj = seatList[i]
		seatObj:clearInfo()
		seatObj:setPosition(_seatPosArr[i])
		self:addChild(seatObj)
		self._playerSeatMap[i] = seatObj
		_seatOrderMap[order] = i

		order = order + 1
		if order >= TOTAL_SEAT_NUM then
			order = 0
		end
	end

	---创建玩家
	for i,info in ipairs(seats) do
		local index = _seatOrderMap[info.order]
		self._playerSeatMap[index]:setInfo(info)
	end

	self:updatePlayerRank( seats, runsPlayerNum )

	ddz_match_manager._selectCards = {}

	self._gameMultiply = 1
	self.panel_ui.fntMultiply:setString(1)
		--加倍处理人数
	self._doublerHandlerNum = 0
	self._forwardCards = nil
	
	self._gameRecordData = {
		farmerIsOutCard = false,--农民是否出过牌
		diZhuIsOutCard = false,--地主是否出过牌
		rocketIsOut = false,--是否有火箭
		boomNum = 0,--炸弹个数
	}

	self.panel_ui.btnIrony:setVisible(true)
	self.panel_ui.btnBequick:setVisible(true)
	self.panel_ui.btnPraise:setVisible(true)

	audio_manager:playOtherSound(1)
end

--清理游戏
function CDdzMatchMainScene:clearGame()
	for k,seatObj in pairs(self._playerSeatMap) do
		seatObj:removeFromParent()
	end
	self._playerSeatMap = {}

	self.panel_ui.sprHiddenCardBack:setVisible(false)

	self.panel_ui.sprCallWord1:setVisible(false)
	self.panel_ui.sprCallWord2:setVisible(false)
	self.panel_ui.sprCallWord3:setVisible(false)

	for i=1,3 do
		local key = "cardNode"..i
		self.panel_ui[key]:removeAllChildren()
	end

	if self._cardListCon then
		self._cardListCon:clear()
		self._cardListCon:removeFromParent()
	end
	self._cardListCon = nil

	if self._settlementPanel then
		self._settlementPanel:removeFromParent()
		self._settlementPanel = nil
	end

	if self._waitEffect then
		self._waitEffect:removeFromParent()
		self._waitEffect = nil
	end

	if self._rankingWaitPanel then
		self._rankingWaitPanel:removeFromParent()
		self._rankingWaitPanel = nil
	end

	self:hideButtons()

	--重置地主牌
	for i=1,TOTAL_SEAT_NUM do
		local key = "hiddenCard"..i
		self.panel_ui[key]:setSpriteFrame(ddzMatch_card_data[54].card_sm)
	end
end

function CDdzMatchMainScene:hideButtons()
	self.panel_ui.btnCalldz:setVisible(false)
	self.panel_ui.btnNotCall:setVisible(false)

	self.panel_ui.btnRobot:setVisible(false)
	self.panel_ui.btnNotRobot:setVisible(false)

	self.panel_ui.btnAddScore:setVisible(false)
	self.panel_ui.btnNotAdd:setVisible(false)

	self.panel_ui.btnPutOutCard:setVisible(false)
	self.panel_ui.btnNotOut:setVisible(false)
	self.panel_ui.btnTips:setVisible(false)
end

--发牌
function CDdzMatchMainScene:sendCard( idList )
	if self._cardListCon then
		self._cardListCon:clear()
		self._cardListCon:removeFromParent()
	end
	self._cardListCon = CDdzMatchCardList.create()

	for i,v in ipairs(idList) do
		performWithDelay(self, function ()
			self._cardListCon:addCard(v)

			for k = 1,TOTAL_SEAT_NUM do
				self._playerSeatMap[k]:addCardNum(1)
			end

		end, i*0.1)

		if i == #idList then
			performWithDelay(self, function ()
				--整理
				self._cardListCon:sortCardList()
				--显示地主牌
				self.panel_ui.sprHiddenCardBack:setVisible(true)
			end, i*0.1)
		end
	end

	self:addChild(self._cardListCon)
	self._cardListCon:setPosition(960, 150)
end

function CDdzMatchMainScene:playerCallDz( order )
	self:hideButtons()

	local callback = nil
	if order == ddz_match_manager._mySeatOrder then
		self.panel_ui.btnCalldz:setVisible(true)
		self.panel_ui.btnNotCall:setVisible(true)

		callback = function ()
						send_doudizhu_ReqCallCard({type = 0})
					end
	end

	local index = _seatOrderMap[order]
	self._playerSeatMap[index]:startTimeDown(CALL_TIME, callback)
	local key = "sprCallWord"..index
	self.panel_ui[key]:setVisible(false)
end

function CDdzMatchMainScene:playerRobotDz( order )
	self:hideButtons()

	local callback = nil
	if order == ddz_match_manager._mySeatOrder then
		self.panel_ui.btnRobot:setVisible(true)
		self.panel_ui.btnNotRobot:setVisible(true)

		callback = function ()
						send_doudizhu_ReqCallCard({type = 2})
					end
	end

	local index = _seatOrderMap[order]
	self._playerSeatMap[index]:startTimeDown(CALL_TIME, callback)
	local key = "sprCallWord"..index
	self.panel_ui[key]:setVisible(false)
end

--叫牌类型(0:不叫地主,1:叫地主,2:不抢地主,3:抢地主)
function CDdzMatchMainScene:playerCallRobotResult( order, result )
	local index = _seatOrderMap[order]
	self._playerSeatMap[index]:removeTimeDown()

	local resArr = {[0] = "bujiao.png", "jiaodizhu.png", "buqiang.png", "qiangdizhu.png"}
	local key = "sprCallWord"..index
	self.panel_ui[key]:setVisible(true)
	self.panel_ui[key]:setTexture("game/ddz_match_std/resource/word/"..resArr[result])

	if result == 0 then
		local soundId = math.random(36,37)
		audio_manager:playPlayerSound(soundId, self._playerSeatMap[index].sex)
	elseif result == 1 then
		audio_manager:playPlayerSound(38, self._playerSeatMap[index].sex)
	elseif result == 2 then
		audio_manager:playPlayerSound(40, self._playerSeatMap[index].sex)
	else
		audio_manager:playPlayerSound(39, self._playerSeatMap[index].sex)
	end
end

--设置地主
function CDdzMatchMainScene:setDiZhuPlayer( order )
	for i = 1,TOTAL_SEAT_NUM do
		self._playerSeatMap[i]:setDiZhu(order)
	end
	self._diZhuPlayerOrder = order

	local index = _seatOrderMap[order]
	audio_manager:playPlayerSound(5, self._playerSeatMap[index].sex)
end

--发地主牌
function CDdzMatchMainScene:sendDiZhuCards( idList )
	for i,v in ipairs(idList) do
		if self._diZhuPlayerOrder == ddz_match_manager._mySeatOrder then
			self._cardListCon:addCard(v)
		end

		local index = _seatOrderMap[self._diZhuPlayerOrder]
		self._playerSeatMap[index]:addCardNum(1)

		--设置地主牌
		local key = "hiddenCard"..i
		self.panel_ui[key]:setSpriteFrame(ddzMatch_card_data[v].card_sm)
	end

	--整理
	self._cardListCon:sortCardList()

	self:playerRedoubleStage()
end

--加倍阶段
function CDdzMatchMainScene:playerRedoubleStage()
	self:hideButtons()
	self.panel_ui.btnAddScore:setVisible(true)
	self.panel_ui.btnNotAdd:setVisible(true)

	self.panel_ui.sprCallWord1:setVisible(false)
	self.panel_ui.sprCallWord2:setVisible(false)
	self.panel_ui.sprCallWord3:setVisible(false)

	for index = 1,3 do
		if ddz_match_manager._mySeatOrder == self._playerSeatMap[index].order then
			self._playerSeatMap[index]:startTimeDown(ADD_SCORE_TIME, function ()
				send_doudizhu_ReqDouble({doubled = 0})
			end)
		else
			self._playerSeatMap[index]:startTimeDown(ADD_SCORE_TIME)
		end
	end
end

--加倍结果  0:不加倍,非0:加倍
function CDdzMatchMainScene:playerRedoubleResult( order, double )
	local index = _seatOrderMap[order]
	self._playerSeatMap[index]:removeTimeDown()
	if double ~= 0 then
		self._playerSeatMap[index]:showDoubled()
			--加倍特效
		local effect = animationUtils.createAndPlayAnimation(self.panel_ui.layer, ddz_match_effect_config["jiabei"])
		local key = "cardNode"..index
		effect:setPosition(self.panel_ui[key]:getPosition())

		audio_manager:playOtherSound(7)
	else
		--不加倍
		audio_manager:playPlayerSound(60, self._playerSeatMap[index].sex)
	end

	self._doublerHandlerNum = self._doublerHandlerNum + 1

	if order == ddz_match_manager._mySeatOrder then
		self.panel_ui.btnAddScore:setVisible(false)
		self.panel_ui.btnNotAdd:setVisible(false)
	end

	if self._doublerHandlerNum == TOTAL_SEAT_NUM then
		self:playerOutCardsStage(self._diZhuPlayerOrder)
	end
end

--玩家出牌阶段
function CDdzMatchMainScene:playerOutCardsStage( order )
	local index = _seatOrderMap[order]
	local key = "cardNode"..index
	self.panel_ui[key]:removeAllChildren()

	self._playerSeatMap[index]:startTimeDown(WAIT_TIME, function ()
		send_doudizhu_ReqAbandon()
	end)

	self:hideButtons()
	local key = "sprCallWord"..index
	self.panel_ui[key]:setVisible(false)

	if order == ddz_match_manager._mySeatOrder then
		self.panel_ui.btnPutOutCard:setVisible(true)
		self.panel_ui.btnNotOut:setVisible(true)
		self.panel_ui.btnTips:setVisible(true)

		self:setOutCardButtonState()

		--随意出牌
		if self._forwardCards == nil then
			self.panel_ui.btnNotOut:setEnabled(false)
			self.panel_ui.btnNotOut:setBright(false)
			self.panel_ui.btnTips:setEnabled(false)
			self.panel_ui.btnTips:setBright(false)
		else
			self.panel_ui.btnNotOut:setEnabled(true)
			self.panel_ui.btnNotOut:setBright(true)
			self.panel_ui.btnTips:setEnabled(true)
			self.panel_ui.btnTips:setBright(true)
		end
	end
end

--玩家不出牌
function CDdzMatchMainScene:playerAbandonOut( order )
	local index = _seatOrderMap[order]
	self._playerSeatMap[index]:removeTimeDown()

	local soundId = math.random(1, 3)
	audio_manager:playPlayerSound(soundId, self._playerSeatMap[index].sex)

	local key = "sprCallWord"..index
	self.panel_ui[key]:setVisible(true)
	self.panel_ui[key]:setTexture("game/ddz_match_std/resource/word/buchuzi.png")
end

--玩家出牌
function CDdzMatchMainScene:mainPlayerOutCardsHandler()
	if ddz_match_manager._selectCards == nil or #ddz_match_manager._selectCards == 0 or
		self.panel_ui.btnPutOutCard:isVisible() == false or self.panel_ui.btnPutOutCard:isEnabled() == false then

		return
	end
	send_doudizhu_ReqPlayCards({cards = ddz_match_manager._selectCards})
end

--玩家出牌结果
--名称:cardsType 类型:int 备注:玩家出的牌的类型(1:单牌，2:对子,3:三不带,4:三代单，5:三带对,6:单顺,7:双顺,8:三顺,9:飞机带单,10:飞机带队,11:炸弹,12:王炸,13:四带单,14:四带队)
function CDdzMatchMainScene:playerOutCards( order, idList, cardsType )
	local index = _seatOrderMap[order]
	local key = "cardNode"..index
	self._playerSeatMap[index]:removeTimeDown()
	self._playerSeatMap[index]:reduceCardNum(#idList)

	table.sort( idList, function ( id1, id2 )
		if ddzMatch_card_data[id1].power > ddzMatch_card_data[id2].power then
			return true
		elseif ddzMatch_card_data[id1].power < ddzMatch_card_data[id2].power then
			return false
		else
			return id1 > id2
		end
	end )

	local cardSprList = {}
	local cardSize
	for i,id in ipairs(idList) do
		local imageFileName = ddzMatch_card_data[id].card_sm
		local cardSpr = cc.Sprite:createWithSpriteFrameName(imageFileName)
		self.panel_ui[key]:addChild(cardSpr)
		table.insert(cardSprList, cardSpr)

		cardSize = cardSpr:getContentSize()
	end
	audio_manager:playOtherSound(2)

	if order == ddz_match_manager._mySeatOrder then
		ddz_match_manager._selectCards = {}
		self._cardListCon:removeCards(idList)
	end
	
	local num = #cardSprList
	local beginX = -(num - 1)*cardSize.width/6
	for i,v in ipairs(cardSprList) do
		local px = beginX + (i - 1) * cardSize.width/3
		v:setPositionX(px)
	end

	if order == ddz_match_manager._mySeatOrder then
		self._forwardCards = nil
	else
		self._forwardCards = idList
	end

	local effect
	if cardsType == 12 then--王炸
		self._gameMultiply = self._gameMultiply * 2
		self.panel_ui.fntMultiply:setString(self._gameMultiply)
		self._gameRecordData.rocketIsOut = true

		effect = animationUtils.createAndPlayAnimation(self.panel_ui.layer, ddz_match_effect_config["wangzha"])
		audio_manager:playOtherSound(4)
	elseif cardsType == 11 then--炸弹
		self._gameMultiply = self._gameMultiply * 2
		self.panel_ui.fntMultiply:setString(self._gameMultiply)
		self._gameRecordData.boomNum = self._gameRecordData.boomNum + 1

		effect = animationUtils.createAndPlayAnimation(self.panel_ui.layer, ddz_match_effect_config["zhadan"])
		audio_manager:playOtherSound(4)
	elseif cardsType == 9 then
		effect = animationUtils.createAndPlayAnimation(self.panel_ui.layer, ddz_match_effect_config["feiji"])
		audio_manager:playOtherSound(5)
	elseif cardsType == 10 then
		effect = animationUtils.createAndPlayAnimation(self.panel_ui.layer, ddz_match_effect_config["feijihechibang"])
		audio_manager:playOtherSound(5)
	elseif cardsType == 6 then
		effect = animationUtils.createAndPlayAnimation(self.panel_ui.layer, ddz_match_effect_config["long"])
	elseif cardsType == 7 then
		effect = animationUtils.createAndPlayAnimation(self.panel_ui.layer, ddz_match_effect_config["liandui"])
	end

	if effect then
		local windowSize = WindowScene.getInstance():getDesSize()
		effect:setAnchorPoint(0.5, 0)
		effect:setPosition(windowSize.w/2, windowSize.h/2)
	end

	if order == self._diZhuPlayerOrder then
		if self._isFirstOutCard then
			self._isFirstOutCard = false
		else
			--地主是否出过第二次牌
			self._gameRecordData.diZhuIsOutCard = true
		end
	else
		--农民是否出过牌
		self._gameRecordData.farmerIsOutCard = true
	end

	self:playOutCardSound(cardsType, self._playerSeatMap[index].sex, idList)
end

--播出牌音效
--名称:cardsType 类型:int 备注:玩家出的牌的类型(1:单牌，2:对子,3:三不带,4:三代单，5:三带对,6:单顺,7:双顺,8:三顺,9:飞机带单,10:飞机带队,11:炸弹,12:王炸,13:四带单,14:四带队)
function CDdzMatchMainScene:playOutCardSound( cardsType, sex, idList )
	local power = ddz_match_manager:checkCardsType(idList)
	if power == nil then
		return
	end

	if cardsType == 1 then
		local soundMap = {[14] = 6, [15] = 7, [3] = 8, [4] = 9, [5] = 10, [6] = 11, [7] = 12, [8] = 13,
							[9] = 14, [10] = 15, [11] = 16, [12] = 17, [13] = 18, [16] = 19, [17] = 20}

		audio_manager:playPlayerSound(soundMap[power], sex)
	elseif cardsType == 2 then
		local soundMap = {[14] = 21, [15] = 22, [3] = 23, [4] = 24, [5] = 25, [6] = 26, [7] = 27, [8] = 28,
							[9] = 29, [10] = 30, [11] = 31, [12] = 32, [13] = 33}

		audio_manager:playPlayerSound(soundMap[power], sex)
	elseif cardsType == 3 then
		audio_manager:playPlayerSound(50, sex)
	elseif cardsType == 4 then
		audio_manager:playPlayerSound(47, sex)
	elseif cardsType == 5 then
		audio_manager:playPlayerSound(48, sex)
	elseif cardsType == 6 then
		audio_manager:playPlayerSound(4, sex)
	elseif cardsType == 7 then
		audio_manager:playPlayerSound(59, sex)
	elseif cardsType == 8 then
		audio_manager:playPlayerSound(49, sex)
	elseif cardsType == 9 then
		audio_manager:playPlayerSound(34, sex)
	elseif cardsType == 10 then
		audio_manager:playPlayerSound(35, sex)
	elseif cardsType == 11 then
		local soundId = math.random(45, 46)
		audio_manager:playPlayerSound(soundId, sex)
	elseif cardsType == 12 then
		local soundId = math.random(41, 42)
		audio_manager:playPlayerSound(soundId, sex)
	elseif cardsType == 13 then
		audio_manager:playPlayerSound(52, sex)
	elseif cardsType == 14 then
		audio_manager:playPlayerSound(51, sex)
	end
end


--牌型提示
function CDdzMatchMainScene:cardsPrompt( idList )
	self._cardListCon:cardsPrompt(idList)
end

--更新玩家信息
function CDdzMatchMainScene:updatePlayerInfo( seatsInfo )
	for i,v in ipairs(seatsInfo) do
		local index = _seatOrderMap[v.order]
		self._playerSeatMap[index]:updateInfo(v)
	end
end

--出牌按钮状态设置
function CDdzMatchMainScene:setOutCardButtonState()
	self.panel_ui.btnPutOutCard:setEnabled(false)
	self.panel_ui.btnPutOutCard:setBright(false)

	if self._forwardCards == nil then
		if ddz_match_manager:checkCardsTypeIsLawful() then--检测牌型是否合法
			self.panel_ui.btnPutOutCard:setEnabled(true)
			self.panel_ui.btnPutOutCard:setBright(true)
		end
	else
		if ddz_match_manager:checkCardsTypePowerThenForward(self._forwardCards) then--检测牌型是否大于上一家
			self.panel_ui.btnPutOutCard:setEnabled(true)
			self.panel_ui.btnPutOutCard:setBright(true)
		end
	end
end

--播发反/春天 特效
function CDdzMatchMainScene:playSpringEffect(callback)
	local effName = ""
	if self._gameRecordData.farmerIsOutCard == false then
		effName = "chuntian"

		self._gameMultiply = self._gameMultiply * 2
		self.panel_ui.fntMultiply:setString(self._gameMultiply)
	elseif self._gameRecordData.diZhuIsOutCard == false then
		effName = "fanchun"

		self._gameMultiply = self._gameMultiply * 2
		self.panel_ui.fntMultiply:setString(self._gameMultiply)
	end

	if ddz_match_effect_config[effName] then
		local effect = animationUtils.createAndPlayAnimation(self.panel_ui.layer, ddz_match_effect_config[effName], callback)
		local windowSize = WindowScene.getInstance():getDesSize()
		effect:setPosition(windowSize.w/2, windowSize.h/2)
		audio_manager:playOtherSound(6)
	elseif callback then
		callback()
	end

	self.panel_ui.btnIrony:setVisible(false)
	self.panel_ui.btnIrony:stopAllActions()
	self.panel_ui.btnBequick:setVisible(false)
	self.panel_ui.btnBequick:stopAllActions()
	self.panel_ui.btnPraise:setVisible(false)
	self.panel_ui.btnBequick:stopAllActions()

	self:hideButtons()

	for k,v in pairs(self._playerSeatMap) do
		v:removeTimeDown()
	end
end

--游戏结束显示结算信息  
function CDdzMatchMainScene:showSettlePanel(bills)
	local info = {}
	info.playerScores = bills

	for j,data in ipairs(bills) do
		local index = _seatOrderMap[data.order]
		if long_compare(data.cedits, 0) > 0 then
			local soundId = math.random(43, 44)
			audio_manager:playPlayerSound(soundId, self._playerSeatMap[index].sex)
		end

		if data.order == ddz_match_manager._mySeatOrder then
			if long_compare(data.cedits, 0) > 0 then
				info.effectKey = "win"
			else
				info.effectKey = "lose"
			end
		end
	end
	info.boomMultiply = self._gameRecordData.boomNum >=1 and 2^self._gameRecordData.boomNum or 0
	info.rocketMultiply = self._gameRecordData.rocketIsOut and 2 or 0

	local value = self._gameRecordData.diZhuIsOutCard == false or self._gameRecordData.farmerIsOutCard == false
	info.springMultiply = value and 2 or 0

	if self._settlementPanel then
		self._settlementPanel:removeFromParent()
		self._settlementPanel = nil
	end
	self._settlementPanel = CDdzMatchSettlement.create()
	self._settlementPanel:setInfo(info)
	self.panel_ui.layer:addChild(self._settlementPanel)
	local windowSize = WindowScene.getInstance():getDesSize()
	self._settlementPanel:setPosition(windowSize.w/2, windowSize.h/2)


	self.panel_ui.btnIrony:setVisible(false)
	self.panel_ui.btnIrony:stopAllActions()
	self.panel_ui.btnBequick:setVisible(false)
	self.panel_ui.btnBequick:stopAllActions()
	self.panel_ui.btnPraise:setVisible(false)
	self.panel_ui.btnBequick:stopAllActions()

	self:hideButtons()

	for k,v in pairs(self._playerSeatMap) do
		v:removeTimeDown()
	end

	performWithDelay(self, function ()
		self._showSettlementOver = true
		if self._settlementPanel then
			self._settlementPanel:removeFromParent()
			self._settlementPanel = nil
		end

		if self._recordRewardInfo then
				self:showRewardPanel(self._recordRewardInfo)
		else
			if self._isCanShowAdvance == true then
				self:showRankingWaitPanel()
			else
				self:showWaitPanel()
				send_doudizhu_ReqReady()
			end
		end
	end, 3)
end

function CDdzMatchMainScene:updatePlayerRank( seatsInfo, runsPlayerNum )
	if self._rankingPanel then
		self._rankingPanel:setRankingInfo(seatsInfo, runsPlayerNum)
	end

	self:updatePlayerInfo(seatsInfo)
end

--显示等待
function CDdzMatchMainScene:showWaitPanel()
	self:clearGame()

	if self._waitEffect then
		self._waitEffect:removeFromParent()
		self._waitEffect = nil
	end
	self._waitEffect = animationUtils.createAnimation2( ddz_match_effect_config["waitTable"] )
	self.panel_ui.layer:addChild(self._waitEffect)
	local windowSize = WindowScene.getInstance():getDesSize()
	self._waitEffect:setPosition(windowSize.w/2, windowSize.h/2)
end

function CDdzMatchMainScene:showRankingWaitPanel()
	if self._showSettlementOver == false then
		return
	end

	if self._settlementPanel then
		self._settlementPanel:removeFromParent()
		self._settlementPanel = nil
	end

	if self._rankingWaitPanel == nil then
		self._rankingWaitPanel = CDdzMatchRankingWait.create()	
		local windowSize = WindowScene.getInstance():getDesSize()
		self._rankingWaitPanel:setPosition(windowSize.w/2, windowSize.h/2)
		self:addChild(self._rankingWaitPanel)

		self:updateRankingWaitInfo(self._recordMatchRunsInfo)
	end
end

--显示排名等待界面
--[[
	info = {
		名称:runs 类型:int 备注:比赛轮数(0:预赛)
		名称:nums 类型:List<int> 备注:比赛轮数人数
		名称:tables 类型:int 备注:正在比赛的桌子数
	}
]]
function CDdzMatchMainScene:updateRankingWaitInfo(info)
	if info == nil then
		return
	end
	self._recordMatchRunsInfo = info
	if self._rankingWaitPanel then
		self._rankingWaitPanel:setInfo(info)
		self._rankingWaitPanel:updateTableNum(info.tables)
		if info.tables == 0 then
			self._rankingWaitPanel:rankingResult()
		end
	end
end

--显示奖励
function CDdzMatchMainScene:showRewardPanel(data)
	self._recordRewardInfo = data
	if self._showSettlementOver == false then
		return
	end

	local rank = data.rank
	local rewards = data.rewards
	if self._rankingWaitPanel then
		self._rankingWaitPanel:removeFromParent()
		self._rankingWaitPanel = nil
	end

	if self._settlementPanel then
		self._settlementPanel:removeFromParent()
		self._settlementPanel = nil
	end

	if self._rewardPanel then
		self._rewardPanel:removeFromParent()
		self._rewardPanel = nil
	end

	local windowSize = WindowScene.getInstance():getDesSize()
	self._rewardPanel = CDdzMatchCertificate.create()
	self._rewardPanel:setInfo(rank, rewards)
	self._rewardPanel:setPosition(windowSize.w/2, windowSize.h/2)
	self:addChild(self._rewardPanel)

	performWithDelay(self._rewardPanel, function ()
		send_doudizhu_ReqWithdraw()
	end, 5)

	self._gameOver = true
end

--名称:type 类型:int 备注:1:嘲讽,2:催牌,3:赞扬
function CDdzMatchMainScene:playerSpeak(order, type)
	local soundId
	if type == 1 then
		soundId = math.random(57,58)
	elseif type == 2 then
		soundId = math.random(53,54)
	else
		soundId = math.random(55,56)
	end
	local index = _seatOrderMap[order]
	audio_manager:playPlayerSound(soundId, self._playerSeatMap[index].sex)
	self._playerSeatMap[index]:showDialog(soundId)
end

--玩家淘汰
function CDdzMatchMainScene:playerElimination( order )
	local index = _seatOrderMap[order]
	self._playerSeatMap[index]:playerElimination( order )
end