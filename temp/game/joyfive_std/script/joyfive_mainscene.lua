--[[
欢乐五张主场景

]]

--是否进入准备阶段
local bEnterReadyStage = false
--发手牌终点坐标
local cardEndPosArr = {{x = 970, y = 45}, {x = 90, y = 375}, {x = 970, y = 870}, {x = 1280, y = 375},}
--玩家位置坐标
local playerPosArr = {{x = 710, y = 50}, {x = 84, y = 626 }, {x = 710, y = 960}, {x = 1356, y = 620},}
--立整整的筹码坐标
--local chipsEndPosArr = {{x=797,y=521},{x =838,y=522},{x=796,y=449},{x=837,y=450},{x=757,y=523},{x=756, y=451},{x=880, y=522},{x=879,y=450},}
--投掷范围
local THROW_WIDTH = 112
local THROW_HEIGHT = 112
--发牌速度
local SEND_CARD_SPEED = 0.2  
--筹码图标
local sideResPathlist = {"lobby/resource/chips/35/chips_s_8.png",
	"lobby/resource/chips/35/chips_s_7.png",
	"lobby/resource/chips/35/chips_s_6.png",
	"lobby/resource/chips/35/chips_s_5.png",
	"lobby/resource/chips/35/chips_s_4.png",
	"lobby/resource/chips/35/chips_s_3.png",
	"lobby/resource/chips/35/chips_s_2.png",
	"lobby/resource/chips/35/chips_s_1.png",}
--每个位置上的筹码数量
-- local chipsNum = {[1]={0,0,0,0,0,0,0,0,},
-- 				  [2]={0,0,0,0,0,0,0,0,},
-- 				  [3]={0,0,0,0,0,0,0,0,},
-- 				  [4]={0,0,0,0,0,0,0,0,},}

local joyfive_ui = require "game.joyfive_std.script.ui_create.ui_joyfive_mainscene"
--local title_create =  require "lobby.script.ui_create.title"

require "game.joyfive_std.script.joyfive_player"
require "game.joyfive_std.script.joyfive_bet"
require "game.joyfive_std.script.joyfive_statistics"


CJoyFiveGame = class("CJoyFiveGame", function ()
	local ret = cc.Layer:create()
	return ret
end)
ModuleObjMgr.add_module_obj(CJoyFiveGame,"CJoyFiveGame")

function CJoyFiveGame.create()
	local layer = CJoyFiveGame.new()
	if layer ~= nil then
		layer:init()
		--layer:regEnterExit()
	end
	return layer
end
function CJoyFiveGame:init()
	self:init_ui()
	self:regEnterExit()
	--self:registerHandler()
	--self:init_after_enter()
end
function CJoyFiveGame:regEnterExit()
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

function CJoyFiveGame:onEnter()
	--加载动画资源
	for i,v in ipairs(joyfive_effect_res_config) do
		display.loadSpriteFrames(v.plistPath,v.imageName)
	end
	--加载音效资源
	audio_manager:reloadMusicByConfig(joyfive_music_config)
end

function CJoyFiveGame:onExit()
	for k,v in pairs(self._playerSeatMap) do
		v:removeTimeDown()
		v:removeFromParent()
	end
	self._playerSeatMap = nil
	--是否已发手牌
    joyfive_manager._start = false
    --发牌次数
    joyfive_manager._sendCardsCount = 0 
    --加注次数
	joyfive_manager._addBetCount = 0
	--是否有人梭哈
	joyfive_manager._BetAll = false
	--记录
	joyfive_manager._recordData = {}
	--移除动画资源
	for i,v in ipairs(joyfive_effect_res_config) do
		display.removeSpriteFrames(v.plistPath,v.imageName)
	end
	--释放音效资源
	audio_manager:destoryAllMusicRes()
end

function CJoyFiveGame:init_ui()
	--基础界面 
	self.joyfive_ui = joyfive_ui.create()
	self:addChild(self.joyfive_ui.root)
	self.joyfive_ui.root:setPosition(0,0)
	self.joyfive_ui.root:setAnchorPoint(0,0)
	self.playerChipsConList = {self.joyfive_ui.playerChipsCon_1,self.joyfive_ui.playerChipsCon_2,self.joyfive_ui.playerChipsCon_3,self.joyfive_ui.playerChipsCon_4,}
	self.fntChipsList = {self.joyfive_ui.fntChips_1,self.joyfive_ui.fntChips_2,self.joyfive_ui.fntChips_3,self.joyfive_ui.fntChips_4,}
	for k,v in pairs(self.fntChipsList) do
		v:setVisible(false)
	end
	--统计界面
	self.statistics_ui = CJoyFiveStatistics.create()
	self.joyfive_ui.imgBg:addChild(self.statistics_ui)
	self.statistics_ui:setPosition(0,0)
	self.statistics_ui:setAnchorPoint(0,0)
	--下注界面
	self.bet_ui = CJoyFiveBet.create()
	self:addChild(self.bet_ui)
	self.bet_ui:setPosition(0,0)
	self.bet_ui:setAnchorPoint(0,0)
	self:showBetPanel(false)
	
	--筹码面板
	self.chips = "0"
	self.chipsPanel = CChipsPanel.create()
	self:addChild(self.chipsPanel)
	self.chipsPanel:setPosition(0,0)
	self.chipsPanel:setChips(self.chips)

	--self:createSeat()

	self:registerHandler()	
end
--是否显示下注界面
function CJoyFiveGame:showBetPanel(bShow)
	if self.bet_ui then
		self.bet_ui:setVisible(bShow)
		if bShow then
			--self.bet_ui:setBtnEnabled(true)
			self.bet_ui:updateBetUi()
			--self.bet_ui:setBtnEnabled(true)
		end
	end
end
function CJoyFiveGame:init_after_enter()	
	--退出
	local function closeFunc()
		local function tipsCallBack()
			for k,v in pairs(self._playerSeatMap) do
			 	v:removeTimeDown()
			 end 
			send_happyfive_ReqExitTable()
			joyfive_manager:resExitTable()
		end
		local playerInfo = get_player_info()
		local state = HallManager._members[playerInfo.id].state
		if state == 3 then
			TipsManager:showTwoButtonTipsPanel(36, {}, true, tipsCallBack)
		else
			tipsCallBack()
		end
	end
	--标题
	local title = WindowScene.getInstance():getModuleObjByClassName("CTableTitleExt")
	if title then
		title:setCloseFunc(closeFunc)
	end
	--汇总筹码图片
	self.dealerChipsImgList = {}
	--汇总筹码
	self.dealerChips = "0"
	--玩家的筹码图片
	self.playerChipsImgList = {}
	--玩家下注筹码
	self.playerChipsMap = {}
	--座位列表
	self.seatObjList = {}
	--玩家的牌
	self._playerCardMap = {}
	--玩家手中牌的张数
	self._playerCardIndex = {}
	--记录
	joyfive_manager._recordData = {}
	--各个玩家结算
	self._playersBalanceMap = {}
		
	self:initGameSeats(joyfive_manager._seatsMap)
	--背景音乐
	audio_manager:playBackgroundMusic(1, true)
end
--初始化桌位信息
function CJoyFiveGame:initGameSeats(seats)
	--清理座位
	if self._playerSeatMap ~= nil then
		for k,img in pairs(self._playerSeatMap) do
			img:removeFromParent()
		end
	end
	self._playerSeatMap = {}
	for k,seatinfo in pairs(seats) do
		if long_compare(seatinfo.playerId, 0) ~= 0 then 
			local realOrder = joyfive_manager:getRealOrder(seatinfo.order)
			local seatObj = CJoyFivePlayer.create(realOrder)
			self:addChild(seatObj)
			self.seatObjList[realOrder] = seatObj
			self.seatObjList[realOrder]:setInfo(seatinfo)
			self.seatObjList[realOrder]:setVisible(true)
			self.seatObjList[realOrder]:setChips(seatinfo.chips)
			self.seatObjList[realOrder]:setRealOrder(realOrder)
			self.seatObjList[realOrder]:setVisible(true)
			self._playerSeatMap[seatinfo.order] = self.seatObjList[realOrder]
		end
	end
	--进入准备阶段
	self:enterReadyStage()
end

--其它玩家进桌
function CJoyFiveGame:OtherPlayerEnterTable(memberInfo)
	local realOrder= joyfive_manager:getRealOrder(memberInfo.order)
	local seatObj = CJoyFivePlayer.create(realOrder)
	self:addChild(seatObj)
	self.seatObjList[realOrder] = seatObj
	self.seatObjList[realOrder]:setInfo(memberInfo)
	self.seatObjList[realOrder]:setVisible(true)
	self.seatObjList[realOrder]:setChips(memberInfo.chips)
	self.seatObjList[realOrder]:setRealOrder(realOrder)
	self.seatObjList[realOrder]:setVisible(true)
	self._playerSeatMap[memberInfo.order] = self.seatObjList[realOrder]
end

--删除玩家
function CJoyFiveGame:removePlayer(order)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:clearGameInfo()
		seatObj:removeFromParent()
		self._playerSeatMap[order] = nil
	end
end
--玩家准备
function CJoyFiveGame:setPlayerReady(order)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:setPlayerReady(true)
	end
	print("玩家准备")
	print("order = " ..order)
	print("mySeatOrder = " ..joyfive_manager._mySeatOrder)
	--离开准备阶段
	if joyfive_manager._mySeatOrder == order then
		self:clearWinOrLostEffect()
		self:exitReadyStage()
	end
	--开始游戏
	--self:startGame()
end

--进入准备阶段
function CJoyFiveGame:enterReadyStage()
	local seatinfo= joyfive_manager._seatsMap[joyfive_manager._mySeatOrder]
	if seatinfo.state == 1 then
		local seatObj = self._playerSeatMap[joyfive_manager._mySeatOrder]
		seatObj:startTimeDown(1,function ()
			send_happyfive_ReqExitTable()
		end)

		self.joyfive_ui.btnChangeTable:setVisible(true)
		self.joyfive_ui.btnStart:setVisible(true)
		self.joyfive_ui.btnAddChips:setVisible(true)
		self.joyfive_ui.btnSubtractChips:setVisible(true)
	end
end

--离开准备阶段
function CJoyFiveGame:exitReadyStage()
	self.joyfive_ui.btnChangeTable:setVisible(false)
	self.joyfive_ui.btnStart:setVisible(false)
	self.joyfive_ui.btnAddChips:setVisible(false)
	self.joyfive_ui.btnSubtractChips:setVisible(false)
end
--开始游戏
function CJoyFiveGame:startGame(cardList)
	--游戏开始音效
	audio_manager:playOtherSound(1)
	dump(cardList)
	joyfive_manager._start = true
	joyfive_manager._hiddenCardList = {}
	local hiddenCardList = clone(cardList)
	for k,v in pairs(hiddenCardList) do
		if v.order == joyfive_manager._mySeatOrder then
			v.card = joyfive_manager._hiddenCards
			joyfive_manager._hiddenCardList[k] = v
		else
			v.card = nil
			joyfive_manager._hiddenCardList[k] = v
		end
	end
	local num = table.nums(joyfive_manager._hiddenCardList)
	for k,v in pairs(cardList) do
		local tab = {order = v.order,card = v.card}
		joyfive_manager._hiddenCardList[num+k] = tab
	end

	for k,v in pairs(self._playerSeatMap) do
		self._playerCardIndex[v.order] = 1
		self._playerCardMap[v.order] = {}
	end
	print("客户端第一次发牌")
	--dump(joyfive_manager._hiddenCardList)
	--发牌
	self:enterSendHandCardStage(joyfive_manager._hiddenCardList)
	
end
function CJoyFiveGame:registerHandler()
    
	--开始
	self.joyfive_ui.btnStart:onTouch(function(e)
		if e.name == "ended" then
			self:readyClickHandler(function ()
				send_happyfive_ReqReady()
			end)
		end
	end)
	--换桌
	self.joyfive_ui.btnChangeTable:onTouch(function(e)
		if e.name == "ended" then
			send_happyfive_ReqExchangeTable()
		end
	end)
	--上分
	self.joyfive_ui.btnAddChips:onTouch(function(e)
		if e.name == "ended" then
			local playerInfo = get_player_info()
			TipsManager:showChipsExchangePanel(joyfive_manager._ownChips, playerInfo.gold)
		end
	end)
	--下分
	self.joyfive_ui.btnSubtractChips:onTouch(function(e)
		if e.name == "ended" then
			local playerInfo = get_player_info()
			TipsManager:showGoldExchangePanel(joyfive_manager._ownChips, playerInfo.gold)
		end
	end)
	--积分统计
	self.statistics_ui.panel_ui.btnStatistics:onTouch(function(e)
		if e.name == "ended" then
			self.statistics_ui:showHidePanel()
		end
	end)
end
--准备
function CJoyFiveGame:readyClickHandler(callback)
	local roominfo = get_player_info():get_cur_roomInfo()
	local myChips = self._playerSeatMap[joyfive_manager._mySeatOrder].chips
	print("minOne = " ..roominfo.minOne)
	print("myChips = " ..myChips)
	if long_compare(long_multiply(roominfo.minOne,3), myChips) >= 0 then
		TipsManager:showChipsExchangePanel(myChips, get_player_info().gold, callback)
	else
		send_happyfive_ReqReady()
	end
end
--玩家 进入下注阶段
function CJoyFiveGame:enterBetStage(order, maxBet, allInBet)
	--已经下的注
	local alreadyBetChips = self.playerChipsMap[order] == nil and 0 or self.playerChipsMap[order]
    print("已经下注的筹码：", alreadyBetChips)
    print("当前轮次最大下注数:", maxBet)
    print("当前轮次梭哈数:" ..allInBet)
    local tmpNum = long_minus(maxBet, alreadyBetChips)
	self.bet_ui:setKeepBet(tmpNum)
	self.bet_ui:setMaxBet(maxBet)
	self.bet_ui:setAllInBet(allInBet)

	print("order = " ..order)
	print("mySeatOrder = " ..joyfive_manager._mySeatOrder)
	if order == joyfive_manager._mySeatOrder then
		self:showBetPanel(true)
	else
		self:showBetPanel(false)
	end


	local callback = function()
		local roominfo = get_player_info():get_cur_roomInfo()
		local seatInfo = joyfive_manager._seatsMap[order]
		send_happyfive_ReqBetDecision({type = 5,roomId = roominfo.roomId,tableId = seatInfo.tableId})
		self:exitBetStage(order)
	end
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:startTimeDown(2,callback)
	end
end

--玩家下注  isInform 是否通知后端下注动作 结束
function CJoyFiveGame:playerBetChips(order, betType, value, isInform)
	if self._playerSeatMap[order] == nil then
		return
	end
	if order == joyfive_manager._mySeatOrder then
		if (betType == 1)or(betType == 2)or(betType == 3) then
			joyfive_manager._AddBet = true
		end
		if betType == 0 then
			joyfive_manager._keepBet = true
		end
	end

	--有人梭哈
	if betType == 4 then
		joyfive_manager._BetAll = true
	end

	--玩家下注音效
	local sex = self._playerSeatMap[order].sex
	if betType == 0 then
		audio_manager:playPlayerSound(3, sex)
	elseif (betType == 1)or(betType == 2)or(betType == 3) then
		audio_manager:playPlayerSound(1, sex)
	elseif (betType == 4) then
		audio_manager:playPlayerSound(2, sex)
	elseif (betType == 5) then
		audio_manager:playPlayerSound(5, sex)
	end

	self._playerSeatMap[order]:setPlayerBetType(betType)
	--汇总筹码
	self.dealerChips = long_plus(self.dealerChips, value)

	if self.playerChipsMap[order] == nil then
		self.playerChipsMap[order] = value
	else
		self.playerChipsMap[order] = long_plus(value, self.playerChipsMap[order])
	end

	self:addChipsToPanelByValue(order,value)
	--显示该轮次下注数
	local realOrder = self._playerSeatMap[order]:getRealOrder()
	self.fntChipsList[realOrder]:setString(self.playerChipsMap[order])
	self.fntChipsList[realOrder]:setVisible(true)

	if long_compare(value, 0) > 0 then
		--下注音效
		audio_manager:playOtherSound(4)
	end
	if order == joyfive_manager._mySeatOrder and isInform then
		send_happyfive_ReqNextStep()
	end

end

--玩家 离开下注阶段
function CJoyFiveGame:exitBetStage(order)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:removeTimeDown()
	end

	if order == joyfive_manager._mySeatOrder then
		self:showBetPanel(false)
	end
end

--添加下注筹码
function CJoyFiveGame:addChipsToPanelByValue(order,value)
	--清理玩家筹码
	-- if self.playerChipsImgList[order] ~= nil then 
	-- 	for k,img in pairs(self.playerChipsImgList[order]) do
	-- 		img:removeFromParent()
	-- 	end
	-- end
	-- self.playerChipsImgList[order] = {}
	local numArr = gsplit(value)
	numArr = table.reverse(numArr) 
	for i,v in ipairs(numArr) do
		for k = 1,v do
			local params = {}
			local realOrder = self._playerSeatMap[order]:getRealOrder()
			local posX,posY = self.playerChipsConList[realOrder]:getPosition()
			params.endPos_x = math.random(posX, posX + THROW_WIDTH)
			params.endPos_y = math.random(posY, posY + THROW_HEIGHT)
			--params.endPos_y = params.endPos_y + 1*k
			local startP_x = playerPosArr[realOrder].x
			local startP_y = playerPosArr[realOrder].y
			local sprite = display.newSprite(sideResPathlist[i], startP_x, startP_y)
			sprite:setAnchorPoint(0.5,0.5)
			self.joyfive_ui.imgBg:addChild(sprite)
			CFlyAction:Fly(sprite, 0.2, params, CFlyAction.FLY_TYPE_CHIPS)
			if self.playerChipsImgList[order] == nil then
				self.playerChipsImgList[order] = {}
			end
			table.insert( self.playerChipsImgList[order], sprite )
		end
	end
end
--将玩家下注筹码集合到汇总筹码
function CJoyFiveGame:playerBetTogether(callback)
    local callCount = 0
    local totalCount = table.nums(self.playerChipsImgList)
    local isNoChips = true
	for order,imgs in pairs(self.playerChipsImgList) do
		local nums = table.nums(imgs)
		if nums == 0 then
			callCount = callCount + 1
			isNoChips = true
		else
			for i,img in ipairs(imgs) do
				local params = {}
				params.endPos_x = self.joyfive_ui.totalChipsCon:getPositionX()
				params.endPos_y = self.joyfive_ui.totalChipsCon:getPositionY()
				--回调选择
				if i == #imgs then
					params.flyendCallback = function ()
						img:removeFromParent()
						self:updateDealerChips()
	                    callCount = callCount + 1
	                    if callCount == totalCount then
	                    	if callback then
		                        callback()
		                    end
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
	end

	self.playerChipsImgList = {}
	self.playerChipsMap = {}
	for k,v in pairs(self.fntChipsList) do
		v:setString(0)
		v:setVisible(false)
	end

	if isNoChips then
		if callback then
	        callback()
	    end
    else
    	--播发筹码集合的音效
    	audio_manager:playOtherSound(6)
    end
end
--更新汇总的筹码
function CJoyFiveGame:updateDealerChips()
	for k,img in pairs(self.dealerChipsImgList) do
		img:removeFromParent()
	end
	self.dealerChipsImgList = {}

	if long_compare(self.dealerChips, 0) > 0 then
		self.joyfive_ui.txtTotalBetChips:setString(self.dealerChips)
		self.joyfive_ui.txtTotalBetChips:setVisible(true)
	end

	local numArr = gsplit(self.dealerChips)
	numArr = table.reverse(numArr)

	local sprWidth = 0
	for i,v in ipairs(numArr) do
		for k = 1,v do
			local startP_x = self.joyfive_ui.totalChipsCon:getPositionX()
			local startP_y = 5 * (k - 1) + self.joyfive_ui.totalChipsCon:getPositionY()
			local sprite = display.newSprite(sideResPathlist[i])
			sprite:setAnchorPoint(0.5,0.5)

			sprWidth = sprite:getContentSize().width
			local init_x = startP_x + sprWidth * math.floor(#numArr / 2)
			startP_x = init_x - sprWidth * (i-1)

			sprite:setPosition(startP_x, startP_y)
			self.joyfive_ui.imgBg:addChild(sprite)

			table.insert(self.dealerChipsImgList, sprite)
		end
	end
end
--将筹码全都分给winner
function CJoyFiveGame:giveWinnerAllChips(order,chips)
	local realOrder = self._playerSeatMap[order]:getRealOrder()
	for k,img in ipairs(self.dealerChipsImgList) do
		local params = {}
		params.endPos_x = playerPosArr[realOrder].x
		params.endPos_y = playerPosArr[realOrder].y
		--回调选择
		if k == #self.dealerChipsImgList then
			params.flyendCallback = function ()
						img:removeFromParent()
						img = nil

						-- local seatObj = self._playerSeatMap[order]
						-- if seatObj then
						-- 	seatObj:setChips(seatObj.chips + chips)

						-- 	if order == joyfive_manager._mySeatOrder then
						-- 		self.chipsPanel:setChips(seatObj.chips)
						-- 	end
						-- end

						-- self:enterCompleteBanlance()
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
	self.joyfive_ui.txtTotalBetChips:setString(self.dealerChips)
	self.joyfive_ui.txtTotalBetChips:setVisible(false)

    self.dealerChipsImgList = {}
end
--发牌
function CJoyFiveGame:enterSendHandCardStage(cardsList)
	--隐藏准备图片和下注状态
	for k,seatobj in pairs(self._playerSeatMap) do
		seatobj:setPlayerReady(false)
		seatobj:hiddenPlayerBetType()
	end
	--记录发牌次数
	joyfive_manager._sendCardsCount = joyfive_manager._sendCardsCount + 1
	local count = 0
	local num = table.nums(cardsList)
	for i,v in ipairs(cardsList) do
		local seatObj = self._playerSeatMap[v.order]
		local function sendCardCallBack(isFinal)
			if seatObj.handCardNum == 0 then
				if seatObj.order == joyfive_manager._mySeatOrder then
					seatObj:addOneHandCard(v.card)
					table.insert(self._playerCardMap[v.order],self._playerCardIndex[v.order],v.card)
					self._playerCardIndex[v.order] = self._playerCardIndex[v.order] + 1
				else
					seatObj:addOneHandCard()
				end
			else
				seatObj:addOneHandCard(v.card)
				table.insert(self._playerCardMap[v.order],self._playerCardIndex[v.order],v.card)
				self._playerCardIndex[v.order] = self._playerCardIndex[v.order] + 1
			end
			--通知后端发牌结束
			if isFinal then
				local _playerInfo = get_player_info()
				send_happyfive_ReqDealCardOver({roomId = _playerInfo.myDesksInfo[1].roomId, tableId = seatObj.tableId})
				print("通知后端发牌结束")
			end
		end
		--发底牌音效
		print("播放发牌音效")
		audio_manager:playOtherSound(5)

		performWithDelay(seatObj, function ()
			count = count + 1
			self:showSendHandCardAction(cardEndPosArr[seatObj:getRealOrder()], sendCardCallBack,count == num)
		end, 0.2*i)
	end
end
--播发发牌动作
function CJoyFiveGame:showSendHandCardAction(endPos, callback, isFinal)
	local imgFrame = display.newSpriteFrame(joyfive_card_data[52].card_big)
    local imgBackCard = cc.Sprite:createWithSpriteFrame(imgFrame)
    self:addChild(imgBackCard)
    imgBackCard:setPosition(self.joyfive_ui.totalChipsCon:getPosition())

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
function CJoyFiveGame:updateChips(order, chips)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:setChips(chips)
	end

    local seatInfo = joyfive_manager._seatsMap[order]
    if seatInfo then
        seatInfo.chips = chips
    end

	if order == joyfive_manager._mySeatOrder then
		self.chipsPanel:setChips(chips)
	end
end
--结算
function CJoyFiveGame:gameBanlance(msg)
	print("结算")
	if msg.type == 0 then
		if msg.cards then
			for k,v in pairs(msg.cards) do
				local seatObj = self._playerSeatMap[v.order]
				if seatObj then
					seatObj:showhiddenCards(v.cards[1])
					seatObj:showCardTyopeEffect(v.type)
				end
			end
		end
	end
	if msg.billInfo then
		for k,v in pairs(msg.billInfo) do
			if long_compare(v.bet, 0) > 0 then
				self:giveWinnerAllChips(v.order,v.bet)
				self:showWinOrLostEffect(v.order == joyfive_manager._mySeatOrder)
			end
			local seatObj = self._playerSeatMap[v.order]
			if seatObj then
				seatObj:setBanlance(v.bet)
				if self._playersBalanceMap[v.order] == nil then
					self._playersBalanceMap[v.order] = {}
				end
				self._playersBalanceMap[v.order].name = seatObj.playerName
				self._playersBalanceMap[v.order].chips = v.bet
			end
			--统计
			joyfive_manager:updateRecord() 
			local seatInfo = joyfive_manager._seatsMap[v.order]
			if seatInfo then
				joyfive_manager._recordData[seatInfo.playerName].count = v.bet
				joyfive_manager._recordData[seatInfo.playerName].totalCount = long_plus(joyfive_manager._recordData[seatInfo.playerName].totalCount, v.bet)
			end
		end
		HallManager:addGameBalanceInTalk(self._playersBalanceMap)
		self.statistics_ui:updateUi(joyfive_manager._recordData)

	end
	--延迟
	performWithDelay(self, function ()
		self:enterCompleteBanlance()
	end, 3)
end
--显示游戏胜利失败特效
function CJoyFiveGame:showWinOrLostEffect(isWin)
	local effectType = 2
	if isWin then
		effectType = 1
		if joyfive_manager._BetAll == true then
			audio_manager:playOtherSound(9)
		else
			audio_manager:playOtherSound(9)
		end
	else
		print("播放失败音效1")
		audio_manager:playOtherSound(8)
		print("播放失败音效2")
	end
	self:clearWinOrLostEffect()
	local effecName = joyfive_manager._winAndLostEffectList[effectType]
	self.winAndLostEffect = animationUtils.createAndPlayAnimation(self.joyfive_ui.totalChipsCon, joyfive_effect_config[effecName], nil)
	self.winAndLostEffect:setAnchorPoint(cc.p(0.5,0.5))
end
--移除胜利失败特效
function CJoyFiveGame:clearWinOrLostEffect()
	if self.winAndLostEffect then
		self.winAndLostEffect:removeFromParent()
    	self.winAndLostEffect = nil
	end
end
--结算完毕
function CJoyFiveGame:enterCompleteBanlance()
	print("结算完毕")
	self:showBetPanel(false)
	--重置准备
	joyfive_manager:resetReadyState()
    self:enterReadyStage()
end
--重置
function CJoyFiveGame:resetGame()
	if self._playerSeatMap then
	    for k,seatObj in pairs(self._playerSeatMap) do
		    seatObj:clearGameInfo()
	    end
    end
    if self.bet_ui then
    	self.bet_ui:setBtnEnabled(true)
    end
    self:clearWinOrLostEffect()
    --是否已发手牌
    joyfive_manager._start = false
    --发牌次数
    joyfive_manager._sendCardsCount = 0 
    --加注次数
	joyfive_manager._addBetCount = 0
	--是否有人梭哈
	joyfive_manager._BetAll = false
    --玩家的筹码图片
	self.playerChipsImgList = {}
	--玩家下注筹码
	self.playerChipsMap = {}
	--玩家的牌
	self._playerCardMap = {}
	--玩家手中牌的张数
	self._playerCardIndex = {}
	--更新记录
	joyfive_manager:updateRecord()
	--各个玩家结算
	self._playersBalanceMap = {}
	
end
--添加底注
function CJoyFiveGame:addBottomBet(bottomBet)
	--local num = table.nums(self._playerSeatMap)
	self.dealerChips = long_plus(self.dealerChips,bottomBet)
	self:updateDealerChips()
end
--玩家看牌
function CJoyFiveGame:checkCard(order)
	for k,v in pairs(self._playerSeatMap) do
		v:checkCard(order)
	end
end