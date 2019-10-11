--玩家位置坐标
local _seatPosArr = {{x = 600, y = 100}, {x = 150, y = 550}, {x = 550, y = 960}, {x = 1700, y = 600},}
--庄家图标坐标
local _bankerImgPosArr = {{x = 400, y = 150}, {x = 160, y = 750}, {x = 350, y = 950}, {x = 1750, y = 750},}
--下注坐标
local _betPosArr = {{x = 720, y = 400, w = 300, h = 200}, {x = 650, y = 420, w = 200, h = 300}, 
					{x = 720, y = 500, w = 300, h = 200}, {x = 1000, y = 420, w = 200, h = 300}, }
--牌型特效坐标
local _effectPosArr = {{x = 950, y = 150}, {x = 420, y = 700}, {x = 900, y = 780}, {x = 1500, y = 700},}

--座位数
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
    --准备
	READY_STEP = 0,
	--叫庄    
	CALL_STEP = 1,
	--下注		
	BET_STEP = 2,
	--发牌	
	SEND_CARD_STEP = 3,
	--摊牌
	SHOW_DOWN_STEP = 4,
	--结算	
	COMPLETE_STEP = 5
}
local READY_TIME = sirenniuniu_time_config[1].time
local CALL_TIME = sirenniuniu_time_config[2].time
local BET_TIME = sirenniuniu_time_config[3].time
local SHOW_DOWN_TIME = sirenniuniu_time_config[4].time

local panel_ui = require "game.foursniuniu_std.script.ui_create.ui_fourniuniu_mainscene"

CFourNiuNiuMainScene = class("CFourNiuNiuMainScene", function ()
	local ret = cc.Node:create()
	return ret		
end)

ModuleObjMgr.add_module_obj(CFourNiuNiuMainScene,"CFourNiuNiuMainScene")
CFourNiuNiuMainScene.GAME_STEP = GAME_STEP

function CFourNiuNiuMainScene.create()
	local node = CFourNiuNiuMainScene.new()
	if node ~= nil then
		node:init_ui()
		node:regEnterExit()
		return node
	end
end

function CFourNiuNiuMainScene:regEnterExit()
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

function CFourNiuNiuMainScene:onEnter()

	audio_manager:reloadMusicByConfig(foursniuniu_music_config)

	local cache = cc.SpriteFrameCache:getInstance()    
    for k,v in pairs(foursniuniu_effect_res_config) do
    	cache:addSpriteFrames(v.plistPath)
    end
end

function CFourNiuNiuMainScene:onExit()

	self:clearPanel()
end

--释放资源
function CFourNiuNiuMainScene:clearPanel()
	local cache = cc.SpriteFrameCache:getInstance()
    
    for k,v in pairs(foursniuniu_effect_res_config) do
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

function CFourNiuNiuMainScene:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	--下注按钮	
	self.panel_ui.btnCash1:setVisible(false)
	self.panel_ui.btnCash2:setVisible(false)	
	self.panel_ui.btnCash3:setVisible(false)	
	self.panel_ui.btnCash4:setVisible(false)

	--叫庄
	self.panel_ui.btnCallZ:setVisible(false)

	--不叫
	self.panel_ui.btnNoCallZ:setVisible(false)

	--准备.换桌
	self.panel_ui.btn_ready:setVisible(false)
	self.panel_ui.btnChangeTable:setVisible(false)

	--摊牌按钮
	self.panel_ui.btnShowDown:setVisible(false)
	
	--提示按钮
	self.panel_ui.btnPointOut:setVisible(false)

	self.panel_ui.sprNoCalling2:setVisible(false)
	self.panel_ui.sprNoCalling3:setVisible(false)
	self.panel_ui.sprNoCalling4:setVisible(false)

	--下注中图片
	self.panel_ui.sprBetting2:setVisible(false)
	self.panel_ui.sprBetting3:setVisible(false)
	self.panel_ui.sprBetting4:setVisible(false)
	
	--牌型图片
	self.panel_ui.sprCardsType1:setVisible(false)
	self.panel_ui.sprCardsType2:setVisible(false)
	self.panel_ui.sprCardsType3:setVisible(false)
	self.panel_ui.sprCardsType4:setVisible(false)

	--庄 图片
	self.panel_ui.sprBankMark:setVisible(false)

	-- --筹码面板
	-- self.chipsPanel = CChipsPanel.create()
	-- self:addChild(self.chipsPanel)
	-- self.chipsPanel:setPosition(0,0)

	-- --统计面板
	-- self.statistics_ui = CFourNiuNiuStatistics.create()
	-- self.panel_ui.backImage:addChild(self.statistics_ui)
	-- self.statistics_ui:setPosition(1276, 1050)

	-- self:addButtonHightLight()
end

-- --按钮高亮
-- function CFourNiuNiuMainScene:addButtonHightLight()
-- 	local btnArr = {self.panel_ui.btnAddChips, self.panel_ui.btnReduceChips, 
-- 					self.panel_ui.btnCash1, self.panel_ui.btnCash2,
-- 					self.panel_ui.btnCash3, self.panel_ui.btnCash4,
-- 					self.panel_ui.btn_ready, self.panel_ui.btnChangeTable,
-- 					self.panel_ui.btnCallZ, self.panel_ui.btnNoCallZ,
-- 					self.panel_ui.btnShowDown,self.panel_ui.btnPointOut,
-- 				}

-- 	local resArr = {"上分高亮", "下分高亮",
-- 					"下注1高亮", "下注2高亮","下注3高亮", "下注4高亮",
-- 					"开始高亮", "换桌高亮",
-- 					"叫庄高亮", "不叫高亮",
-- 					"摊牌高亮", "提示高亮",
-- 					}

-- 	for i,btn in ipairs(btnArr) do
-- 		local mov_obj = cc.Sprite:create(four_niuniu_imgRes_config[resArr[i]].resPath)
-- 		WindowScene.getInstance():registerBtnMouseMoveEff(btn,mov_obj,1)
-- 	end
-- end

function CFourNiuNiuMainScene:registerHandler()
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
	--返回按钮
	self.panel_ui.btnBack:onTouch(function ( e )
		if e.name == "ended" then
			closeFunc()
		end
	end)

	--叫庄
	self.panel_ui.btnCallZ:onTouch(function (e)
		if e.name == "ended" then
			send_sirenniuniu_ReqCallDealer({call = 1})
		end
	end)

	--不叫
	self.panel_ui.btnNoCallZ:onTouch(function (e)
		if e.name == "ended" then
			send_sirenniuniu_ReqCallDealer({call = 0})
		end
	end)

	--准备.换桌
	local function _on_ready_click(e)
		if e.name == "ended" then
			self:readyClickHandler(function ()
				send_sirenniuniu_ReqReady()
			    --退出上一句的结算
			    self:exitCompleteStage()
			end)
		end
	end
	self.panel_ui.btn_ready:onTouch(_on_ready_click)

	self.panel_ui.btnChangeTable:onTouch(function (e)
		if e.name == "ended" then
			send_sirenniuniu_ReqExchangeTable()
		end
	end)

	--摊牌按钮
	self.panel_ui.btnShowDown:onTouch(function (e)
		if  e.name == "ended" then
			self:showDownHandler()
		end
	end)

	--提示按钮
	self.panel_ui.btnPointOut:onTouch(function (e)
		if e.name == "ended" then
			if C4PNiuNiuCardCheck.getCardsTypeFormation( self._myBestCardType ) then
				local seatObj = self._playerSeatMap[four_niuniu_manager._mySeatOrder]
				seatObj:tipsCards(self._myTipsCards)
			end

			if self._myBestCardType == C4PNiuNiuCardCheck.CardsKinds.MEI_NIU then
				send_sirenniuniu_ReqShowdown({})

				audio_manager:playOtherSound(7)
			end

			self:showCardsTypeTipsImage(self._myBestCardType)
		end
	end)

	--兑换按钮
	self.panel_ui.btnExchange:onTouch(function (e)

		if e.name == "ended" then
			dump(e)
			print("enterbtnExchange")
			local playerInfo = get_player_info()
			local seatObj = self._playerSeatMap[four_niuniu_manager._mySeatOrder]
			TipsManager:showExchangePanel(seatObj.chips, playerInfo.gold)
		end
	end)

	--下注按钮
	local function _on_cash_click( e )
		if e.name == "ended" then
			self:onCashClickHandler(e)
		end
	end 
	self.panel_ui.btnCash1:onTouch(_on_cash_click)
	self.panel_ui.btnCash2:onTouch(_on_cash_click)
	self.panel_ui.btnCash3:onTouch(_on_cash_click)
	self.panel_ui.btnCash4:onTouch(_on_cash_click)
end

function CFourNiuNiuMainScene:init_after_enter()

	-- dump(msg)

    self:registerHandler()
	self:initData()
	self:initGameSeats(four_niuniu_manager._seatsMap)

	for k,v in pairs(self._bettingMap) do
		v:setVisible(false)
	end

	for k,v in pairs(self._noRobotMap) do
		v:setVisible(false)
	end

	for k,v in pairs(self._playerRobLightMap) do
		v:setVisible(false)
	end

	--进入准备阶段
	self:enterReadyStage()
    --背景音乐
	audio_manager:playBackgroundMusic(1, true)
end

function CFourNiuNiuMainScene:initData()
	--玩家座位
	self._playerSeatMap = {}

	self._playerIndexMap = {}

	--玩家抢庄灯图片
	self._playerRobLightMap = {}
	--玩家牌型
	self._playerCardsType={}

	--庄家图片坐标
	self._bankerImgPosMap = {}

	--玩家抢庄情况
	self._playerRobResultMap = {}

	--玩家下注位置
	self._playerBetPosMap = {}
	--玩家位子坐标
	self._playerSeatPosMap = {}

	--牌型特效坐标
	self._effectPosMap = {}
	--玩家牌型特效
	self._effectMap = {}
	--“不抢”图片
	self._noRobotMap = {}
	--“下注中”图片
	self._bettingMap = {}

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

	--庄家每局获得的筹码
	self.bankerChips=nil

	-- --是否自动准备
	-- four_niuniu_manager.isAutoReady = false
	-- --是否自动最大注
	-- four_niuniu_manager.isAutoMaxBet = false
	-- --是否自动叫庄
	-- four_niuniu_manager.isAutoCallBanker = false
	-- --是否自动出牌
	-- four_niuniu_manager.isAutoShowDown = false

	four_niuniu_manager.showDownMsgMap = {}

	self._showCardsCache = {}

	self.banker_id = nil
end

--重置游戏数据
function CFourNiuNiuMainScene:resetGameData()

	print("重置游戏数据>>>>>")
	--玩家抢庄情况
	self._playerRobResultMap = {}
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

	self:stopAllActions()
    self.panel_ui.sprBankMark:stopAllActions()
    self.panel_ui.sprBankMark:setVisible(false)
    self.panel_ui.sprBankMark:setPosition(950,660)

	--庄家座位
	self._bankerOrder = nil

	-- self.panel_ui.img_cardsTypeTips:setVisible(false)

	for k,v in pairs(self._bettingMap) do
		v:setVisible(false)
	end

	for k,v in pairs(self._noRobotMap) do
		v:setVisible(false)
	end

	for k,v in pairs(self._playerRobLightMap) do
		v:setVisible(false)
	end
	--玩家数据清除
	for k,v in pairs(self._playerSeatMap) do
		print("v.order",v.order)
		v:resetGame()
	end

	--玩家牌型特效
	for k,v in pairs(self._effectMap) do
		v:removeFromParent()
	end
	self._effectMap = {}

	if self._balanceEffect then
		self._balanceEffect:removeFromParent()
		self._balanceEffect = nil
	end

	--提示牌型图片
	if  self.sprCardsType then
		self.sprCardsType:removeFromParent()
		self.sprCardsType=nil
	end

	four_niuniu_manager.showDownMsgMap = {}
end

--下注事件
function CFourNiuNiuMainScene:onCashClickHandler(e)
	if e.target == self.panel_ui.btnCash1 then
		send_sirenniuniu_ReqBet({chip = self.cashData[1] })
	elseif e.target == self.panel_ui.btnCash2 then
		send_sirenniuniu_ReqBet({chip = self.cashData[2] })
	elseif e.target == self.panel_ui.btnCash3 then
		send_sirenniuniu_ReqBet({chip = self.cashData[3] })
	elseif e.target == self.panel_ui.btnCash4 then
		send_sirenniuniu_ReqBet({chip = self.cashData[4] })
	end

end

--准备事件
function CFourNiuNiuMainScene:readyClickHandler(callback)
	local roominfo = get_player_info():get_cur_roomInfo()
	local tmpNum = long_multiply(roominfo.minOne,24)
	local seatObj = self._playerSeatMap[four_niuniu_manager._mySeatOrder]
	if long_compare(tmpNum, seatObj.chips) > 0 then
		-- TipsManager:showChipsExchangePanel(seatObj.chips, get_player_info().gold, callback)
		TipsManager:showExchangePanel(seatObj.chips, get_player_info().gold, callback)
	else
		send_sirenniuniu_ReqReady()
	    --退出上一句的结算
	    self:exitCompleteStage()
	end
end

--初始化桌位信息
function CFourNiuNiuMainScene:initGameSeats(memberInfos)
	--清理座位
	for k,seatObj in pairs(self._playerSeatMap) do
		seatObj:removeFromParent()
	end
	self._playerSeatMap = {}

	-- 座位排列
	local seatList = {CFourNiuNiuPlayerExt.create(1), CFourNiuNiuPlayerExt.create(2),
					  CFourNiuNiuPlayerExt.create(3), CFourNiuNiuPlayerExt.create(4),}

	--抢庄灯图片
	local bankerImgList = {self.panel_ui.imgLight1, self.panel_ui.imgLight2,
							self.panel_ui.imgLight3, self.panel_ui.imgLight4}
	--下注中图片
	local bettingImgList = {[2] = self.panel_ui.sprBetting2,
					 		[3] = self.panel_ui.sprBetting3, [4] = self.panel_ui.sprBetting4}
	--牌型图片				 		
	local CardsTypeList = {self.panel_ui.sprCardsType1,self.panel_ui.sprCardsType2,
							self.panel_ui.sprCardsType3,self.panel_ui.sprCardsType4} 
	--不抢图片
	local noImgList = { [2]=self.panel_ui.sprNoCalling2,
					 [3]=self.panel_ui.sprNoCalling3, [4]=self.panel_ui.sprNoCalling4}
	-- --叫庄中图片
	-- local CallingList = {[2] = self.panel_ui.sprCalling2,
	-- 				 		[3] = self.panel_ui.sprCalling3, [4] = self.panel_ui.sprCalling4}

	local index = four_niuniu_manager._mySeatOrder

	for i = 1, TOTAL_SEAT_NUM do

		-- local seatObj = seatList[i]
		-- seatObj:clearInfo()
		-- seatObj:resetGame()
		-- seatObj:setPosition(_seatPosArr[i])
		-- self.panel_ui.playerNode:addChild(seatObj)
		-- self._playerSeatMap[index] = seatObj

		self._playerSeatPosMap[index] = _seatPosArr[i]

		self._playerCardsType[index] =CardsTypeList[i]
		self._playerRobLightMap[index] = bankerImgList[i]
		self._bankerImgPosMap[index] = _bankerImgPosArr[i]

		-- self._CallingMap[index]=CallingList[i]

		self._playerBetPosMap[index] = _betPosArr[i]
		self._effectPosMap[index] = _effectPosArr[i]

		self._bettingMap[index] = bettingImgList[i]

		self._noRobotMap[index] = noImgList[i]

		index = index + 1
		if index >= TOTAL_SEAT_NUM then
			index = 0
		end
	end

	---创建玩家
	for order = 0,TOTAL_SEAT_NUM-1 do
		local seatinfo = memberInfos[order]
		if seatinfo then
			self:createPlayer(seatinfo)
		end
	end
end


--创建玩家
function CFourNiuNiuMainScene:createPlayer(memberInfo)
	if self._playerSeatMap[memberInfo.order] == nil then
		local seatObj = CFourNiuNiuPlayerExt.create(four_niuniu_manager:getRealOrder(memberInfo.order))
			seatObj:clearInfo()
			seatObj:resetGame()
		self.panel_ui.playerNode:addChild(seatObj)
		-- -- seatObj:setPosition(seatPosArr[memberInfo.order])
		seatObj:setInfo(memberInfo)
		self._playerSeatMap[memberInfo.order] = seatObj
	else
		self._playerSeatMap[memberInfo.order]:setInfo(memberInfo)
	end
end

--删除玩家
function CFourNiuNiuMainScene:removePlayer(order)

	local seatObj = self._playerSeatMap[order]
	if seatObj then
		-- seatObj:playerLeave()
		-- self._playerSeatMap[order] = nil
		-- seatObj:removeFromParent()
		seatObj:clearInfo()
	end
end

--玩家筹码变化
function CFourNiuNiuMainScene:updateChips(order, chips)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:setChips(chips)
	end
end

--进入准备阶段
function CFourNiuNiuMainScene:enterReadyStage()
	self:resetAllStageButton()
	print("CFourNiuNiuMainScene:enterReadyStage进入准备阶段")
	self.game_step = GAME_STEP.READY_STEP
	self:clearTimeDown()
	self:addTimeDown(four_niuniu_manager._mySeatOrder, READY_TIME)--调用倒计时

	self.panel_ui.btn_ready:setVisible(true)
	self.panel_ui.btnChangeTable:setVisible(true)	
end

--添加倒计时
function CFourNiuNiuMainScene:addTimeDown(order,time)
	-- dump(time)
	self:clearTimeDown()
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:addTimeDown(time, function ()
			self:timeEndCallBack()
		end)
	end
end

--清楚倒计时
function CFourNiuNiuMainScene:clearTimeDown()
	for k,seatObj in pairs(self._playerSeatMap) do
		seatObj:clearTimeDown()
	end
end
--玩家准备
function CFourNiuNiuMainScene:setPlayerReady( order )
	if order == four_niuniu_manager._mySeatOrder then
		self:exitReadyStage()
		self:resetGameData()
	end
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:setReady(true)
		if player_is_myself(order) then
			--准备.换桌
			self.panel_ui.btn_ready:setVisible(false)
			self.panel_ui.btnChangeTable:setVisible(false)
			self.panel_ui.btnExchange:setVisible(false)
			seatItem:clearTimeDown()
		end
	end
end

--倒计时结束回调函数
function CFourNiuNiuMainScene:timeEndCallBack( args )
	if self.game_step == GAME_STEP.READY_STEP then
		local seatObj = self._playerSeatMap[four_niuniu_manager._mySeatOrder]
		if seatObj and seatObj:readIsVisible() == false then
			send_sirenniuniu_ReqExitTable()
		end
	elseif self.game_step == GAME_STEP.CALL_STEP then
		send_sirenniuniu_ReqCallDealer({call = 0})
	elseif self.game_step == GAME_STEP.BET_STEP then
		if self._bankerOrder ~= four_niuniu_manager._mySeatOrder then
			send_sirenniuniu_ReqBet({chip = self.cashData[4] })
		end
	elseif self.game_step == GAME_STEP.SHOW_DOWN_STEP then
		send_sirenniuniu_ReqShowdown({})
	end
end


--重置所有阶段性的按钮
function CFourNiuNiuMainScene:resetAllStageButton()
	self.panel_ui.btn_ready:setVisible(false)
	self.panel_ui.btnChangeTable:setVisible(false)
	self.panel_ui.btnCallZ:setVisible(false)
	self.panel_ui.btnNoCallZ:setVisible(false)
	self.panel_ui.btnShowDown:setVisible(false)
	self.panel_ui.btnPointOut:setVisible(false)

	for i=1,TOTAL_SEAT_NUM do
		local key = "btnCash"..i
		self.panel_ui[key]:setVisible(false)
		key = "fnt_cash"..i
		self.panel_ui[key]:setVisible(false)		
	end
	for i=1,4 do
		key2="sprCardsType"..i
		self.panel_ui[key2]:setVisible(false)
	end

	for k,v in pairs(self._playerRobLightMap) do
		v:setVisible(false)
	end
end


--离开准备阶段
function CFourNiuNiuMainScene:exitReadyStage()
	self.panel_ui.btn_ready:setVisible(false)
	self.panel_ui.btnChangeTable:setVisible(false)
	self.panel_ui.btnExchange:setVisible(false)
	audio_manager:playOtherSound(4)
end

--进入抢庄阶段
function CFourNiuNiuMainScene:enterRobBankerStage()
	self.game_step = GAME_STEP.CALL_STEP
	self:resetAllStageButton()
	self.panel_ui.btnCallZ:setVisible(true)
	self.panel_ui.btnNoCallZ:setVisible(true)
	self.panel_ui.sprBankMark:setVisible(true)

	for order = 0, TOTAL_SEAT_NUM-1 do
		local seatObj = self._playerSeatMap[order]
		if seatObj then
			seatObj:setReady(false)
		end
	end

	self.game_step = GAME_STEP.CALL_STEP
	self:clearTimeDown()
	self:addTimeDown(four_niuniu_manager._mySeatOrder,CALL_TIME)

	-- if four_niuniu_manager.isAutoCallBanker then
	-- 	send_sirenniuniu_ReqCallDealer({call = 1})
	-- end

	audio_manager:playOtherSound(1)
end

--离开抢庄阶段
function CFourNiuNiuMainScene:exitRobBanckerStage()
	self.panel_ui.btnCallZ:setVisible(false)
	self.panel_ui.btnNoCallZ:setVisible(false)
end

--玩家抢庄结果
function CFourNiuNiuMainScene:robBankerHandler(order, value)
	-- dump(self._playerRobLightMap)
	if value then
		-- print("----755----order",order)
		self._playerRobLightMap[order]:loadTexture(four_niuniu_imgRes_config["灯亮"].resPath)
		self._playerRobLightMap[order]:setVisible(true)

		local seatObj = self._playerSeatMap[order]
		if seatObj then
			audio_manager:playPlayerSound(1, seatObj.sex)
		end
	else
		local seatObj = self._playerSeatMap[order]
		if seatObj then
			audio_manager:playPlayerSound(7, seatObj.sex)
		end
	--不抢图片
		local img = self._noRobotMap[order]
		if img then
			img:setVisible(true)
		end
	end
	self._playerRobResultMap[order] = value

	if order == four_niuniu_manager._mySeatOrder then
		self:exitRobBanckerStage()
	end
end

--最终庄家
function CFourNiuNiuMainScene:setBankerPlayer(order)
	self._bankerOrder = order
	-- dump(order)

	local orderList = {}
	for k,v in pairs(self._playerRobResultMap) do
		if v then
			table.insert(orderList, k)
		end
	end

	local function callback(index)
		for i,key in ipairs(orderList) do
			if key == index then
				self._playerRobLightMap[key]:loadTexture(four_niuniu_imgRes_config["灯亮"].resPath)
			else
				self._playerRobLightMap[key]:loadTexture(four_niuniu_imgRes_config["灯灭"].resPath)
			end
		end
	end
	--不抢图片
	for k,v in pairs(self._noRobotMap) do
		v:setVisible(false)
	end

	for i=1, 5 * #orderList do
		performWithDelay(self, function ()
			local j = i % #orderList + 1
			if i == 5 * #orderList then
				callback(order)

				self.panel_ui.sprBankMark:setPosition(self._playerRobLightMap[order]:getPosition())
				self.panel_ui.sprBankMark:setVisible(true)
				local params = {}
				params.endPos_x = self._bankerImgPosMap[order].x
				params.endPos_y = self._bankerImgPosMap[order].y
				params.flyendCallback = function ()
					if self._bankerOrder == four_niuniu_manager._mySeatOrder then
						local seatObj = self._playerSeatMap[order]
						if seatObj then
							audio_manager:playPlayerSound(math.random(2,4), seatObj.sex)
						end
					end					
					--进入下注阶段
					self:enterBetStage()
				end
				--抢庄灯
				for k,v in pairs(self._playerRobLightMap) do
					v:setVisible(false)
				end
			
				CFlyAction:Fly(self.panel_ui.sprBankMark, 1, params, CFlyAction.FLY_TYPE_CHIPS)

				audio_manager:playOtherSound(8)
			else
				callback(orderList[j])
			end
		end, i * 0.2)
	end

	if #orderList == 0 then
		self.panel_ui.sprBankMark:setPosition(self._playerRobLightMap[order]:getPosition())
		self.panel_ui.sprBankMark:setVisible(true)
		local params = {}
		params.endPos_x = self._bankerImgPosMap[order].x
		params.endPos_y = self._bankerImgPosMap[order].y
		params.flyendCallback = function ()
			--进入下注阶段
			self:enterBetStage()
		end
		CFlyAction:Fly(self.panel_ui.sprBankMark, 1, params, CFlyAction.FLY_TYPE_CHIPS)
	end
end


--进入下注阶段
function CFourNiuNiuMainScene:enterBetStage()
	self:resetAllStageButton()

	--自己是闲家
	if self._bankerOrder ~= four_niuniu_manager._mySeatOrder then
		for i=1,4 do
			local key = "btnCash"..i
			self.panel_ui[key]:setVisible(true)
			key = "fnt_cash"..i
			self.panel_ui[key]:setVisible(true)
		end

		local bankerChips = self._playerSeatMap[self._bankerOrder].chips
		local myChips = self._playerSeatMap[four_niuniu_manager._mySeatOrder].chips
		local totalChips = 0
		for k,seatObj in pairs(self._playerSeatMap) do
			if seatObj.isEnabled and k ~= self._bankerOrder then
				totalChips = long_plus(totalChips + seatObj.chips)
			end
		end
		local btndata = C4PNiuNiuCardCheck.calute_bottomCash(bankerChips, myChips, totalChips)

		self.cashData = btndata

		if self.autoMaxBet then
			if btndata[5] then
				send_sirenniuniu_ReqBet({chip = self.cashData[1] })	
			elseif btndata[6] then
				send_sirenniuniu_ReqBet({chip = self.cashData[2] })	
			elseif btndata[7] then
				send_sirenniuniu_ReqBet({chip = self.cashData[3] })	
			elseif btndata[8] then
				send_sirenniuniu_ReqBet({chip = self.cashData[4] })	
			end
		end

		--下注按钮
		self.panel_ui.btnCash1:setEnabled(btndata[5])
		self.panel_ui.btnCash1:setBright(btndata[5])
		self.panel_ui.fnt_cash1:setString(btndata[1])

		self.panel_ui.btnCash2:setEnabled(btndata[6])
		self.panel_ui.btnCash2:setBright(btndata[6])
		self.panel_ui.fnt_cash2:setString(btndata[2])

		self.panel_ui.btnCash3:setEnabled(btndata[7])
		self.panel_ui.btnCash3:setBright(btndata[7])
		self.panel_ui.fnt_cash3:setString(btndata[3])

		self.panel_ui.btnCash4:setEnabled(btndata[8])
		self.panel_ui.btnCash4:setBright(btndata[8])
		self.panel_ui.fnt_cash4:setString(btndata[4])

		-- if four_niuniu_manager.isAutoMaxBet then
		-- 	if btndata[5] then
		-- 		send_sirenniuniu_ReqBet({chip = self.cashData[1] })
		-- 	elseif btndata[6] then
		-- 		send_sirenniuniu_ReqBet({chip = self.cashData[2] })
		-- 	elseif btndata[7] then
		-- 		send_sirenniuniu_ReqBet({chip = self.cashData[3] })
		-- 	elseif btndata[8] then
		-- 		send_sirenniuniu_ReqBet({chip = self.cashData[4] })
		-- 	end
		-- end
	end

	for order,img in pairs(self._bettingMap) do
		if order ~=nil then
			local seatObj = self._playerSeatMap[order]
			if seatObj ~=nil then
				if order ~= self._bankerOrder and order ~= four_niuniu_manager._mySeatOrder and seatObj.isEnabled then
					img:setVisible(true)
				end
			end
		else
			return
		end
	end

	self.game_step = GAME_STEP.BET_STEP
	self:clearTimeDown()
	self:addTimeDown(four_niuniu_manager._mySeatOrder,BET_TIME)

	audio_manager:playOtherSound(10)
end

--玩家下注
function CFourNiuNiuMainScene:playerBetChips(order, chips)

	if self._playerSeatMap[order] == nil then
		return
	end

	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:setBetInfo(chips)

		audio_manager:playPlayerSound(5, seatObj.sex)
	end

	if order ~= self._bankerOrder and order ~= four_niuniu_manager._mySeatOrder then
		local img = self._bettingMap[order]
		if img then
			img:setVisible(false)
		end
	end
	-- 抛出筹码
	local numArr = gsplit(chips)
	numArr = table.reverse(numArr)
	for i,v in ipairs(numArr) do
		for k = 1,v do
			local params = {}
			params.endPos_x = math.random(self._playerBetPosMap[order].x, self._playerBetPosMap[order].x + self._playerBetPosMap[order].w)
			params.endPos_y = math.random(self._playerBetPosMap[order].y, self._playerBetPosMap[order].y + self._playerBetPosMap[order].h)

			local sprite = display.newSprite(sideResPathlist[i],self._playerSeatPosMap[order].x,self._playerSeatPosMap[order].y)
			sprite:setAnchorPoint(0.5,0.5)
			self.panel_ui.sprSceneBack:addChild(sprite)
			CFlyAction:Fly(sprite, 0.5, params, CFlyAction.FLY_TYPE_CHIPS)

			if self._playerBetChipsImgMap[order] == nil then
				self._playerBetChipsImgMap[order] = {}
			end
			table.insert( self._playerBetChipsImgMap[order], sprite )
		end
	end

	audio_manager:playOtherSound(4)

	if order == four_niuniu_manager._mySeatOrder then
		self:exitBetStage()
	end
end

--离开下注阶段
function CFourNiuNiuMainScene:exitBetStage()
	for i=1,TOTAL_SEAT_NUM do
		local key = "btnCash"..i
		self.panel_ui[key]:setVisible(false)
		key = "fnt_cash"..i
		self.panel_ui[key]:setVisible(false)
	end
	-- for order,img in pairs(self._bettingMap) do
	-- 	img:setVisible(false)
	-- end
end

--发牌
function CFourNiuNiuMainScene:sendCardsStage(tipsCards, cardsType)
	self.game_step = GAME_STEP.SEND_CARD_STEP

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

	-- local mainPlayerId = get_player_info().id
	for i,cardId in ipairs(list) do
		for j = 0, TOTAL_SEAT_NUM-1 do
			local seatObj = self._playerSeatMap[j]
			if seatObj and seatObj.isEnabled then
				local function callback()
					if j == four_niuniu_manager._mySeatOrder then

						seatObj:addCard(cardId)
						audio_manager:playOtherSound(5)
					else
						seatObj:addCard()
					end

					--所有牌发完
					if i == #list and j == four_niuniu_manager._mySeatOrder then
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

--进入摊牌阶段
function CFourNiuNiuMainScene:enterShowDownStage()
	self:resetAllStageButton()
	self.panel_ui.btnShowDown:setVisible(true)
	self.panel_ui.btnPointOut:setVisible(true)

	self.game_step = GAME_STEP.SHOW_DOWN_STEP
	self:clearTimeDown()
	self:addTimeDown(four_niuniu_manager._mySeatOrder, SHOW_DOWN_TIME)

	-- if four_niuniu_manager.isAutoShowDown then
	-- 	send_sirenniuniu_ReqShowdown({})
	-- end

	--处理缓存的出牌信息
	for order, msg in pairs(four_niuniu_manager.showDownMsgMap) do
		self:playerShowDown(msg.order, msg.cardsType, msg.bestCards)
	end
end

--离开摊牌阶段
function CFourNiuNiuMainScene:exitShowDownStage()
	-- self.game_step = GAME_STEP.SHOW_DOWN_STEP_END
	self.panel_ui.btnShowDown:setVisible(false)
	self.panel_ui.btnPointOut:setVisible(false)

end

--出牌操作
function CFourNiuNiuMainScene:showDownHandler()
	local seatObj = self._playerSeatMap[four_niuniu_manager._mySeatOrder]
	if seatObj == nil then
		return
	end
	send_sirenniuniu_ReqShowdown({cards = seatObj._selectCards})

    if C4PNiuNiuCardCheck.checkIsBestCardsType(self._myTipsCards, 
    seatObj._selectCards, self._myBestCardType) == false then
        TipsManager:showOneButtonTipsPanel(41, {}, true)
    end
end

--玩家出牌结果
function CFourNiuNiuMainScene:playerShowDown( order, cardsType, bestCards)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:showCards(cardsType, bestCards)
		if order == four_niuniu_manager._mySeatOrder then
			self:exitShowDownStage()
		end
		--摊牌音效
		audio_manager:playOtherSound(8)

		seatObj:clearTimeDown()
	end

	self:showCardsTypeEffect( order ,cardsType )
end


--显示卡牌牌型特效
function CFourNiuNiuMainScene:showCardsTypeEffect( order ,cardsType )

	print("显示卡牌牌型特效")
	print(cardsType)

	local effectSpr
	if cardsType >= C4PNiuNiuCardCheck.CardsKinds.NIU_NIU then
		effectSpr = animationUtils.createAndPlayAnimation(self, foursniuniu_effect_config[cardsType])
		effectSpr:setScale(2)
		effectSpr:setAnchorPoint(0.5,0.5)
		effectSpr:setPosition(self._effectPosMap[order])
	else
		effectSpr = cc.Sprite:create("game/foursniuniu_std/resource/word/NIU_"..cardsType..".png")
		effectSpr:setAnchorPoint(0.5,0.5)
		effectSpr:setPosition(self._effectPosMap[order])
		self:addChild(effectSpr)
	end

	self._effectMap[order] = effectSpr

	local seatObj = self._playerSeatMap[order]
	if seatObj == nil then
		return
	end
	----音效
	if cardsType == C4PNiuNiuCardCheck.CardsKinds.SI_ZHA then
		audio_manager:playPlayerSound(6, seatObj.sex)
	elseif cardsType == C4PNiuNiuCardCheck.CardsKinds.MEI_NIU then
		audio_manager:playPlayerSound(10, seatObj.sex)
	elseif cardsType == C4PNiuNiuCardCheck.CardsKinds.NIU_1 then
		audio_manager:playPlayerSound(11, seatObj.sex)
	elseif cardsType == C4PNiuNiuCardCheck.CardsKinds.NIU_2 then
		audio_manager:playPlayerSound(12, seatObj.sex)
	elseif cardsType == C4PNiuNiuCardCheck.CardsKinds.NIU_3 then
		audio_manager:playPlayerSound(13, seatObj.sex)
	elseif cardsType == C4PNiuNiuCardCheck.CardsKinds.NIU_4 then
		audio_manager:playPlayerSound(14, seatObj.sex)
	elseif cardsType == C4PNiuNiuCardCheck.CardsKinds.NIU_5 then
		audio_manager:playPlayerSound(15, seatObj.sex)
	elseif cardsType == C4PNiuNiuCardCheck.CardsKinds.NIU_6 then
		audio_manager:playPlayerSound(16, seatObj.sex)
	elseif cardsType == C4PNiuNiuCardCheck.CardsKinds.NIU_7 then
		audio_manager:playPlayerSound(17, seatObj.sex)
	elseif cardsType == C4PNiuNiuCardCheck.CardsKinds.NIU_8 then
		audio_manager:playPlayerSound(18, seatObj.sex)
	elseif cardsType == C4PNiuNiuCardCheck.CardsKinds.NIU_9 then
		audio_manager:playPlayerSound(19, seatObj.sex)
	elseif cardsType == C4PNiuNiuCardCheck.CardsKinds.NIU_NIU then
		audio_manager:playPlayerSound(20, seatObj.sex)
	elseif cardsType == C4PNiuNiuCardCheck.CardsKinds.WU_XIAO then
		audio_manager:playPlayerSound(21, seatObj.sex)
	elseif cardsType == C4PNiuNiuCardCheck.CardsKinds.WU_HUA then
		audio_manager:playPlayerSound(25, seatObj.sex)
	elseif cardsType == C4PNiuNiuCardCheck.CardsKinds.SI_HUA then
		audio_manager:playPlayerSound(26, seatObj.sex)
	end
end

--进入结算阶段
function CFourNiuNiuMainScene:enterCompleteStage()
	-- HallManager:addGameBalanceInTalk(self._playersBalanceMap)
	self.panel_ui.sprBankMark:setVisible(false)
	self.panel_ui.btnExchange:setVisible(true)
	self:enterReadyStage()
end

--退出结算
function CFourNiuNiuMainScene:exitCompleteStage()

	self.panel_ui.sprBankMark:setVisible(false)

	for k,v in pairs(self._playerSeatMap) do
		v:resetGame()
	end
end

--显示并设置牌型的提示图片
function CFourNiuNiuMainScene:showCardsTypeTipsImage(type)
	if  self.sprCardsType then
		self.sprCardsType:removeFromParent()
		self.sprCardsType=nil
	end
	self.sprCardsType = cc.Sprite:create("game/foursniuniu_std/resource/word/Nroom_niu"..type..".png")
	self.panel_ui.btnPointOut:addChild(self.sprCardsType)
	self.sprCardsType:setScale(2.5)
	self.sprCardsType:setPosition(-100,0)
	self.sprCardsType:setAnchorPoint(0.5,0.5)

end

--分发筹码
function CFourNiuNiuMainScene:splitChipsToPlayer(order, chips, clearAll)
	-- dump(order)
	-- print("self._bankerOrder==",self._bankerOrder)
	local params = {}
	

	-- if order == self._bankerOrder then
	-- 	self.bankerChips=chips
	-- 	if long_compare(bankerChips, 0) > 0 then

	-- 		if long_compare(chips, 0) > 0 then
	-- 			params.endPos_x = self._playerSeatPosMap[order].x
	-- 			params.endPos_y = self._playerSeatPosMap[order].y			
	-- 		else
	-- 			params.endPos_x = self._playerSeatPosMap[self._bankerOrder].x
	-- 			params.endPos_y = self._playerSeatPosMap[self._bankerOrder].y
	-- 		end
	-- 	else
	-- 	--do
	-- 		if long_compare(chips, 0) > 0 then
	-- 			params.endPos_x = self._playerSeatPosMap[order].x
	-- 			params.endPos_y = self._playerSeatPosMap[order].y
	-- 		end
	-- 	end	
	-- end

	-- print("self.bankerChips",self.bankerChips)
	-- if long_compare(self.bankerChips, 0) < 0 then 
	-- 	print("庄家输了>>>>>")
	-- 	self.sprgold=cc.Sprite:create("game/foursniuniu_std/resource/image/gold.png")
	-- 	self.panel_ui.playerNode:addChild(self.sprgold)
	-- 	self.sprgold:setPosition(self._playerSeatPosMap[self._bankerOrder].x,self._playerSeatPosMap[self._bankerOrder].y)
	-- end

	-- print("chips>>>>>>>>",chips)

	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:setBalanceInfo(order,chips)

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
	if order == four_niuniu_manager._mySeatOrder then
		local effectData
		local posX= self._playerSeatPosMap[order].x+220
		local posY= self._playerSeatPosMap[order].y+500
		if long_compare(chips, 0) > 0 then
			effectData = foursniuniu_effect_config["胜利"]
		else
			effectData = foursniuniu_effect_config["失败"]
		end
		if self._balanceEffect then
			self._balanceEffect:removeFromParent()
			self._balanceEffect = nil
		end
		self._balanceEffect = animationUtils.createAndPlayAnimation(self, effectData)
		self._balanceEffect:setAnchorPoint(0.5,0.5)
		self._balanceEffect:setPosition(posX, posY)
	end


	local imgList = self._playerBetChipsImgMap[order]

	if imgList == nil then
        if clearAll then
			self:clearAllChipsImg(order)
		end
		return
	end

	for k,sprite in pairs(imgList) do
		-- local params = {}
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
				self:clearAllChipsImg(order)
			end
		end

		CFlyAction:Fly(sprite, 1.0, params, CFlyAction.FLY_TYPE_CHIPS)

		-- if self.sprgold then
		-- 	CFlyAction:Fly(self.sprgold, 2.0, params, CFlyAction.FLY_TYPE_CHIPS)
		-- end					
	end
	self._playerBetChipsImgMap[order] = nil

end

--清理桌上的筹码
function CFourNiuNiuMainScene:clearAllChipsImg(order)
	for k,imgList in pairs(self._playerBetChipsImgMap) do
		for i,spr in ipairs(imgList) do
			spr:removeFromParent()
		end
	end
	self._playerBetChipsImgMap = {}
		----牛金币
	-- self.sprgold:removeFromParent()
	-- self.sprgold=nil
end