




local GAME_STEP = {
	WAIT_STEP = -1,   	--等待
	REST_STEP = 0,   	--休息
	BET_STEP = 1,		--下注
	SHOW_STEP = 3,		--开奖
}


local panel_ui = require "game.shark_std.script.ui_create.ui_shark_mainscene"

CSharkMainScene = class("CSharkMainScene", function ()
	local ret = cc.Node:create()
	return ret
end)

ModuleObjMgr.add_module_obj(CSharkMainScene,"CSharkMainScene")
CSharkMainScene.GAME_STEP = GAME_STEP

function CSharkMainScene.create()
	local node = CSharkMainScene.new()
	if node ~= nil then
		node:init_ui()
		node:regEnterExit()
		node:loading()
		return node
	end
end

function CSharkMainScene:loading()
	local info = {
		parent 			= WindowScene.getInstance().game_layer,
		task_call 		= function (percent,index,texture) self:addImageSrc(percent,index,texture) end,
		complete_call 	= function () self:loadEnded() end,
		--task_lst = {[x] = {src = "",},},
		ui_info = {
			back_pic 		= "game/shark_std/resource/image/loadbg.jpg",
			bar_back_pic 	= "game/shark_std/resource/image/ldtbj.png",
			bar_process_pic = "game/shark_std/resource/image/ldtbj1.png",
			b_self_release 	= true,
		},
	}

	info.task_lst = {}
	for i=1,#Shark_effect_res_config do
		local item = {src = Shark_effect_res_config[i].imageName,}
		info.task_lst[i] = item
	end
	self._loadingTask = LoadingTask.create(info)
end

function CSharkMainScene:destoryLoading()
	if self._loadingTask then
    	self._loadingTask:forcedDestory()
        self._loadingTask = nil
    end
end

function CSharkMainScene:addImageSrc(percent,index,texture)
	local cache = cc.SpriteFrameCache:getInstance()
	cache:addSpriteFrames(Shark_effect_res_config[index].plistPath)
end

function CSharkMainScene:loadEnded()
    self._loadingTask = nil
	--添加图标
	self:createRewardIcons()

 --    local playerInfo = get_player_info()
	-- TipsManager:showExchangePanel(self._ownChips, playerInfo.gold)

	self.hideEffect = animationUtils.createAndPlayAnimation(self.panel_ui.ndHidEffect, shark_effect_config["hideEffect"])
	
	if shark_manager._isNeedWait then
		self:enterWaitStage()
	end

    self:registerHandler()
    
    send_shark_ReqStage()

    audio_manager:playBackgroundMusic(1, true)
end

function CSharkMainScene:regEnterExit()
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

function CSharkMainScene:onEnter()
	audio_manager:reloadMusicByConfig(shark_music_config)

end

function CSharkMainScene:onExit()
	self:clearPanel()

	EventUtils.removeEventListener(EventUtils.GOLD_CHANGE,self)

	-- WindowRegFun.reg_unreg_key_up_call(VK_F1)
end

--释放资源
function CSharkMainScene:clearPanel()
	local cache = cc.SpriteFrameCache:getInstance()
    
    for k,v in pairs(Shark_effect_res_config) do
    	cache:removeSpriteFramesFromFile(v.plistPath)
    end

    if self._animationEff then
		self._animationEff:removeFromParent()
		self._animationEff = nil
	end
	if self.hideEffect then
		self.hideEffect:removeFromParent()
		self.hideEffect = nil
	end

    if self._rewardlist then
	    local item = self._rewardlist:getFinalRewardItem()
	    if item then
	        item:reset()
        end
    end

    audio_manager:destoryAllMusicRes()

    if self._tipsPanel then
		self._tipsPanel:onHide()
		self._tipsPanel = nil
	end

    timeUtils:remove(self.panel_ui.fntTime)
    -- timeUtils:remove(self.panel_ui.fntStartCountDown)

    if self._eggEff then
		self._eggEff:removeFromParent()
		self._eggEff = nil
	end

	if self._waveEff then
		self._waveEff:removeFromParent()
		self._waveEff = nil
	end

	self:stopAllActions()
end

function CSharkMainScene:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	--游戏背景
	self.gameBackScene = CSharkBackScene.create()
	self.panel_ui.nodeBackScene:addChild(self.gameBackScene)
	self.gameBackScene:setPosition(960, 540)

	--庄家信息面板
	self.bankerPanel = CSharkBankerExt.create()
	self.panel_ui.imgBack:addChild(self.bankerPanel)
	self.bankerPanel:setPosition(0,0)

	-- self:addButtonHightLight()
	
	-- self.panel_ui.fntStartCountDown:setVisible(false)
	self:setShowBetPanel(false)

	self:initGameData()
end

function CSharkMainScene:addButtonHightLight()
	local btnArr = {self.panel_ui.btnAddChips, self.panel_ui.btnReduceChips, self.panel_ui.btnExit, 
					self.panel_ui.btnContinueBet, self.panel_ui.btnClear,
					self.panel_ui.btnLeft, self.panel_ui.btnRight,
					self.panel_ui.sbtnBet1, self.panel_ui.sbtnBet2,
					self.panel_ui.sbtnBet3, self.panel_ui.sbtnBet4,
					self.panel_ui.sbtnBet5, self.panel_ui.sbtnBet6,
					self.panel_ui.sbtnBet7, self.panel_ui.sbtnBet8,
					self.panel_ui.btnAnimation1, self.panel_ui.btnAnimation2,
					self.panel_ui.btnAnimation3, self.panel_ui.btnAnimation4,
					self.panel_ui.btnAnimation5, self.panel_ui.btnAnimation6,
					self.panel_ui.btnAnimation7, self.panel_ui.btnAnimation8,
					self.panel_ui.btnAnimation9, self.panel_ui.btnAnimation10,
					self.panel_ui.btnAnimation11, self.panel_ui.btnAnimation12,
				}

	local resArr = {"上分高亮", "下分高亮", "站起高亮",
					"续押高亮", "清空高亮",
					"左高亮", "右高亮",
					"1高亮", "10高亮","100高亮", "1千高亮",
					"1万高亮", "10万高亮","100万高亮", "1千万高亮",
					"狮子高亮", "熊猫高亮","猴子高亮", "兔子高亮",
					"老鹰高亮", "孔雀高亮","鸽子高亮", "燕子高亮",
					"银鲨高亮", "金鲨高亮","飞禽高亮", "走兽高亮",
					}

	for i,btn in ipairs(btnArr) do
		local mov_obj = cc.Sprite:create(shark_imgRes_config[resArr[i]].resPath)
		WindowScene.getInstance():registerBtnMouseMoveEff(btn,mov_obj,1)
	end
end

function CSharkMainScene:registerHandler()
	--标题
	local function tipsCallBack()
		-- send_shark_ReqExitTable()
		HallManager:reqExitCurGameTable()
	end

	local function closeFunc()
		if self._gameStep ~= GAME_STEP.REST_STEP then
			local playerInfo = get_player_info()
			if long_compare(playerInfo.id, shark_manager._bankerID) == 0 then--我是庄家
				TipsManager:showTwoButtonTipsPanel(77, {}, true, tipsCallBack)
			else
				if self._gameStep == GAME_STEP.BET_STEP then
					if long_compare(self._curBetChips, 0) > 0 then
						TipsManager:showOneButtonTipsPanel(72, {}, true)
					else
						tipsCallBack()
					end
				else
					TipsManager:showTwoButtonTipsPanel(73, {}, true, tipsCallBack)
				end
			end
		else
			tipsCallBack()
		end
	end
	local title = WindowScene.getInstance():getModuleObjByClassName("CTableTitleExt")
	if title then
		title:setCloseFunc(closeFunc)
	end

	--站起
	self.panel_ui.btnExit:onTouch(function (e) 
		if e.name == "ended" then
			closeFunc()
		end
	end)

	--显示下注界面
	self.panel_ui.btnBet:onTouch(function (e)
		if e.name == "ended" then
			-- self.panel_ui.imgBack1:setVisible(true)
			self:setShowBetPanel(true)
		end
	end)

	--隐藏下注界面
	self.panel_ui.btnHide:onTouch(function (e)
		if e.name == "ended" then
			-- self.panel_ui.imgBack1:setVisible(false)
			self:setShowBetPanel(false)
		end
	end)

	local function stateButtonEvent(sender, eventType)
		if (sender == self.panel_ui.cbAutoContinue) or (sender == self.panel_ui.cbAutoContinue1) then
			self._isAutoContinueBet = eventType == ccui.CheckBoxEventType.selected
			self.panel_ui.cbAutoContinue:setSelected(self._isAutoContinueBet)
			self.panel_ui.cbAutoContinue1:setSelected(self._isAutoContinueBet)
		end
	end
	self.panel_ui.cbAutoContinue:addEventListener(stateButtonEvent)
	self.panel_ui.cbAutoContinue1:addEventListener(stateButtonEvent)

	--兑换
	self.panel_ui.btnExchange:onTouch(function (e)
		if e.name == "ended" then
			local playerInfo = get_player_info()
			TipsManager:showExchangePanel(self._ownChips, playerInfo.gold)
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

	--下注注码 选择
	local betChipsTypecallback = function (sender, eventType)
		for i=1,5 do
			local key = "sbtnBet"..i
			if sender == self.panel_ui[key] then
				self._selectBetChips = 10^i
			end

			local isEnable = long_compare(self._ownChips, 10^i) >= 0 
			self.panel_ui[key]:setTouchEnabled(isEnable)
			self.panel_ui[key]:setBright(isEnable)
		end
	end

	local btn_group_lst = {}
	for i=1,5 do
		local key = "sbtnBet"..i
		table.insert(btn_group_lst, self.panel_ui[key])
	end
	WindowScene.getInstance():registerGroupEvent(btn_group_lst,betChipsTypecallback)

	--下注请求
	local function betRequestHandler(e)
		if e.name == "ended" then
			if long_compare(self._selectBetChips, self._ownChips) > 0 then
				-- TipsManager:showOneButtonTipsPanel( 76, {}, true)
				local playerInfo = get_player_info()
				TipsManager:showExchangePanel(self._ownChips, playerInfo.gold)
			else
				send_shark_ReqBet({icon = e.target.iconId, bet = self._selectBetChips})
			end
		end
	end
	for i=1,12 do
		local key = "btnAnimation"..i
		self.panel_ui[key].iconId = i
		self.panel_ui[key]:onTouch(betRequestHandler)
	end


	--续押
	self.panel_ui.btnContinueBet:onTouch(function (e)
		if e.name == "ended" then
			self:continueBet()
		end
	end)
	--清空
	self.panel_ui.btnClear:onTouch(function (e)
		if e.name == "ended" then
			send_shark_ReqClearBet({})
		end
	end)

	--做移动
	-- self.panel_ui.btnLeft:onTouch(function (e)
	-- 	if e.name == "ended" then
	-- 		self:leftMove()
	-- 	end
	-- end)
	-- --右移动
	-- self.panel_ui.btnRight:onTouch(function (e)
	-- 	if e.name == "ended" then
	-- 		self:rightMove()
	-- 	end
	-- end)

	--添加金币更新事件
	EventUtils.addEventListener(EventUtils.GOLD_CHANGE, self, function () self:setPlayerGold() end)

	-- local function keyUpHandler( key )
	-- 	if self._gameStep ~= GAME_STEP.BET_STEP then
	-- 		return
	-- 	end

	-- 	local keyNum = {["f1"] = 1, ["f2"] = 2, ["f3"] = 3, ["f4"] = 4, ["f5"] = 5, ["f6"] = 6, 
	-- 					["f7"] = 7, ["f8"] = 8, ["f9"] = 9, ["space"] = 10, ["f11"] = 11, ["f12"] = 12, }
	-- 					print(key)
	-- 	send_shark_ReqBet({icon = keyNum[key], bet = self._selectBetChips})
	-- end

	-- WindowRegFun.reg_key_up_call(keyUpHandler,VK_F1)
end

function CSharkMainScene:initGameData()
	for i=1,12 do
		local key = "fntSingleBetChips"..i
		self.panel_ui[key]:setString("0")
		key = "fntMultiple"..i
		self.panel_ui[key]:setString("0")
		key = "fntGameTotalChips"..i
		self.panel_ui[key]:setString("0")
	end
	self.panel_ui["fntMultiple11"]:setString("x2")
	self.panel_ui["fntMultiple12"]:setString("x2")

	for i=1,8 do
		local key = "sprRecordIcon"..i
		local key1 = "sprRecordIcon_"..i
		self.panel_ui[key]:setVisible(false)
		self.panel_ui[key1]:setVisible(false)
	end

	self.panel_ui.fntCurBetChips:setString(0)
	self.panel_ui.fntTotalBetChips:setString(0)
	self.panel_ui.fntTime:setString(0)
	self.panel_ui.fntReward:setString(0)

	self.panel_ui.cbAutoContinue:setSelected(false)
	self.panel_ui.cbAutoContinue1:setSelected(false)
	-- self.panel_ui.cbAutoOut:setSelected(false)

	-- self.panel_ui.fntAnimalMutiply:setVisible(false)

	local playerInfo = get_player_info()
	self.panel_ui.labMyName:setString(playerInfo.name)
	self.panel_ui.labMyChips:setString(0)
	self.panel_ui.labMyGold:setString(playerInfo.gold)
	self.panel_ui.labMyWin:setString(0)

	-- 头像
	local sex = get_player_info().sex == "男" and 0 or 1
	uiUtils:setPhonePlayerHead(self.panel_ui.sprMyHead, sex, uiUtils.HEAD_SIZE_223)


	self._isAutoContinueBet = false
	self._isAutoOut = false
	self._curBetChips = 0
	self._totalBetChips = 0
	self._ownChips = 0
	self._selectBetChips = 10
	self._myScore = 0
	shark_manager._betGoldSharkChips = 0

	--倍数
	self._betMultiplyMap = {}
	--当前下注结果
	self._myBetMap = {}
	--上一次下注结果
	self._lastBetMap = {}
	--中奖记录
	self._rewardRecordList = {}
	--记录查看点
	self._recordIndex = 0

	self.panel_ui.sbtnBet1:setSelected(true)

end

--清空下注信息
function CSharkMainScene:clearBetData()
	for i=1,12 do
		local key = "fntSingleBetChips"..i
		self.panel_ui[key]:setString("0")
	end

	self._curBetChips = 0
	self:setCurBetChips(0)

	self._myBetMap = {}
end

--重置游戏数据
function CSharkMainScene:resetGameData()
	for i=1,12 do
		local key = "fntSingleBetChips"..i
		self.panel_ui[key]:setString("0")

		key = "fntGameTotalChips"..i
		self.panel_ui[key]:setString("0")
	end

	self.panel_ui.fntCurBetChips:setString(0)
	self.panel_ui.fntTotalBetChips:setString(0)

	self._curBetChips = 0
	self._totalBetChips = 0

	shark_manager._betGoldSharkChips = 0

	--上一次下注结果
	self._lastBetMap = self._myBetMap
	--当前下注结果
	self._myBetMap = {}

	-- self.panel_ui.fntAnimalMutiply:setVisible(false)

	if self._rewardlist then
	    local item = self._rewardlist:getFinalRewardItem()
	    if item then
	        item:reset()
        end
    end

	if self._animationEff then
		self._animationEff:removeFromParent()
		self._animationEff = nil
	end

	if self._tipsPanel then
		self._tipsPanel:onHide()
		self._tipsPanel = nil
	end
end


function CSharkMainScene:createRewardIcons()
	--老虎机管理
	self.slotMachineCirCleCon = CSlotMachineConCirCle.create(CSlotMachineConCirCle.NORMAL_ALL)
	self.panel_ui.imgBack:addChild(self.slotMachineCirCleCon)

	local arr = {}
	for i,v in ipairs(shark_bonus_iconXY_config) do
		local reward = CSharkRewardItem.create()
		reward:initIconInfo(i, v.iconId)
		table.insert(arr, reward)
		reward:setPosition(v.posX, v.posY)
	end
	self._rewardlist = CRewardListCircle.create()

	self._rewardlist:initRewards(arr, self._rewardlist.ORDER_ROLL, 1)
	self._rewardlist:setPosition(0,0)

	self.slotMachineCirCleCon:addRewardList( self._rewardlist )
	self.slotMachineCirCleCon:setRewardListSpeed( 1 , 12 , 40 , 2 )
	self.slotMachineCirCleCon:setAnchorPoint(0,0)
	self.slotMachineCirCleCon:setPosition(0,0)
end

function CSharkMainScene:startGame( finalReward )
	
	self._rewardlist:setFinalReward(finalReward)

	self.slotMachineCirCleCon:startRoll( 2, 40 )
	audio_manager:pauseMusic()
	audio_manager:playOtherSound(3)

	local function actionEndCallBack()
		local item = self._rewardlist:getFinalRewardItem()
        if item then
	        item:playAction()
        end
		

		if self._animationEff then
			self._animationEff:removeFromParent()
			self._animationEff = nil
		end

		-- self._animationEff = animationUtils.createAndPlayAnimation(self, shark_effect_config[item.iconId + 1000])
		-- self._animationEff:setPosition(960, 650)
		-- self._animationEff:setAnchorPoint(0.5, 0.5)
		audio_manager:stopALLSound()
		audio_manager:playOtherSound(item.iconId + 5)

		-- self.panel_ui.fntAnimalMutiply:setVisible(true)
		-- self.panel_ui.fntAnimalMutiply:setString("x"..self._betMultiplyMap[item.iconId])

		self:addRecord(item.iconId)

		self.gameBackScene:setBackImage(item.iconId)

		if shark_manager._secondRewardIndex == 0 then
			self:showSettleInfo()
		else
		    if item then
		    	self.panel_ui.fntTime:setVisible(false)
				self.panel_ui.imgStageWord:setVisible(false)
				self.panel_ui.fntAnimalMutiply:setString("x"..self._betMultiplyMap[item.iconId])
				self.panel_ui.fntAnimalMutiply:setVisible(true)
		    	self._animationEff = animationUtils.createAndPlayAnimation(self, shark_effect_config[item.iconId + 1000])
				self._animationEff:setPosition(960, 540)
				self._animationEff:setAnchorPoint(0.5, 0.5)
		    	local key = "btnAnimation"..item.iconId
		    	self.panel_ui[key]:setBright(true)

		    	if item.iconId >= 1 and item.iconId <= 4 then
		    		self.panel_ui.btnAnimation12:setBright(true)
		    	elseif item.iconId >= 5 and item.iconId <= 8 then
		    		self.panel_ui.btnAnimation11:setBright(true)
		    	end
		    end
		end
	end

	EventUtils.addEventListener( self.slotMachineCirCleCon.ALL_CIRCLE_STOP, self, actionEndCallBack, true )
end

--第二次开奖
function CSharkMainScene:secondOpenReward()
	-- self.panel_ui.fntAnimalMutiply:setVisible(false)
	if self._animationEff then
		self._animationEff:removeFromParent()
		self._animationEff = nil
	end

	local item = self._rewardlist:getFinalRewardItem()
	if item then
		item:reset()
	end

	self:playGoldEggEffect()

	self:addTimeDown(shark_manager._secondRewardTime)
end

--播发金蛋特效
function CSharkMainScene:playGoldEggEffect()
	self.panel_ui.fntTime:setVisible(false)
	self.panel_ui.imgStageWord:setVisible(false)
	self.panel_ui.fntAnimalMutiply:setVisible(false)
	function callback()
		self.panel_ui.fntTime:setVisible(true)
		self.panel_ui.imgStageWord:setVisible(true)
	end

	self._eggEff = animationUtils.createAndPlayAnimation(self, shark_effect_config["彩金蛋特效"],callback)
	self._eggEff:setPosition(960, 580)
	self._eggEff:setAnchorPoint(0.5, 0.5)

	performWithDelay(self, function ()
		if self._eggEff then
			self._eggEff:removeFromParent()
			self._eggEff = nil
		end

		self:playWaveEffect()
	end, 3)
end

--播发水波特效
function CSharkMainScene:playWaveEffect()
	self._waveEff = animationUtils.createAndPlayAnimation(self.gameBackScene.clippingNode, shark_effect_config["水花特效"])
	self._waveEff:setPosition(960, 0)
	self._waveEff:setAnchorPoint(0.5, 0.5)

	audio_manager:playOtherSound(16)

	local function dipose(node)
		node:stopAllActions()
		node:removeFromParent()
		node = nil

		if self._waveEff then
			self._waveEff:removeFromParent()
			self._waveEff = nil
		end

		local item = self._rewardlist:getFinalRewardItem()
	    if item then
	    	local key = "btnAnimation"..item.iconId
	    	self.panel_ui[key]:setBright(false)

	    	if item.iconId >= 1 and item.iconId <= 4 then
	    		self.panel_ui.btnAnimation12:setBright(false)
	    	elseif item.iconId >= 5 and item.iconId <= 8 then
	    		self.panel_ui.btnAnimation11:setBright(false)
	    	end
	    end


		self:startGame(shark_manager._secondRewardIndex)
		shark_manager._secondRewardIndex = 0
	end
	local actionMove = cc.MoveBy:create(1,cc.p(0, 1080))
	local moveBack = actionMove:reverse()
	local call_action = cc.CallFunc:create(dipose)
	local seq_arr = {actionMove, moveBack, call_action}
	local seq = cc.Sequence:create(seq_arr)
	self._waveEff:runAction( seq )
end

--显示结算
function CSharkMainScene:showSettleInfo()
	if self._tipsPanel then
		self._tipsPanel:onHide()
		self._tipsPanel = nil
	end
	local item = self._rewardlist:getFinalRewardItem()
	self._tipsPanel = CSharkTipsPanel.create()
	local data = {banker = shark_manager._bankerBillChips, player = shark_manager._playerBillChips,mutiply="x"..self._betMultiplyMap[item.iconId],}
	self._tipsPanel:showMe(data)

	self._myScore = long_minus(self._myScore, self._curBetChips)
	self._myScore = long_plus(self._myScore, shark_manager._playerBillChips)
	self.panel_ui.labMyWin:setString(self._myScore)

	if long_compare(shark_manager._playerBillChips, 0) > 0 then
		audio_manager:playOtherSound(2)
	end
	
    if item then
    	if self._animationEff then
			self._animationEff:removeFromParent()
			self._animationEff = nil
		end
    	self._animationEff = animationUtils.createAndPlayAnimation(self._tipsPanel, shark_effect_config[item.iconId + 1000])
		self._animationEff:setPosition(700, 260)
		self._animationEff:setAnchorPoint(0.5, 0.5)

    	local key = "btnAnimation"..item.iconId
    	self.panel_ui[key]:setBright(true)

    	if item.iconId >= 1 and item.iconId <= 4 then
    		self.panel_ui.btnAnimation12:setBright(true)
    	elseif item.iconId >= 5 and item.iconId <= 8 then
    		self.panel_ui.btnAnimation11:setBright(true)
    	end
    end
end

function CSharkMainScene:setPlayerGold()
	local playerInfo = get_player_info()
	self.panel_ui.labMyGold:setString(playerInfo.gold)
end

--进入等待阶段
function CSharkMainScene:enterWaitStage()
	self._gameStep = GAME_STEP.WAIT_STEP
	self.panel_ui.imgStageWord:setVisible(false)
	self.panel_ui.fntTime:setVisible(false)
	self.panel_ui.imgStageWord:setTexture( shark_imgRes_config["休息"].resPath)
	self.panel_ui.imgStageWord1:setTexture( shark_imgRes_config["休息"].resPath)

	if self._tipsPanel then
		self._tipsPanel:onHide()
		self._tipsPanel = nil
	end
	self._tipsPanel = CSharkTipsPanel.create()
	self._tipsPanel:showMe()
end

--进入休息阶段
function CSharkMainScene:enterRestStage()
	print("CSharkMainScene:enterRestStage()")
	self._gameStep = GAME_STEP.REST_STEP
	self.panel_ui.imgStageWord:setTexture(shark_imgRes_config["休息"].resPath)
	self.panel_ui.imgStageWord1:setTexture(shark_imgRes_config["休息"].resPath)
	self.panel_ui.imgStageWord:setVisible(true)
	self.panel_ui.fntTime:setVisible(true)
	-- self:setShowBetPanel(true)
	self.panel_ui.btnBet:setTouchEnabled(false)
	self.panel_ui.btnBet:setEnabled(true)
	self.panel_ui.btnBet:setBright(true)
	self.panel_ui.btnContinueBet:setTouchEnabled(false)
--	self.panel_ui.btnContinueBet:setEnabled(false)
	self.panel_ui.btnContinueBet:setBright(false)
	self.panel_ui.btnClear:setTouchEnabled(false)
	self.panel_ui.btnClear:setBright(false)
	for i=1,12 do
		local key = "btnAnimation"..i
		self.panel_ui[key]:setTouchEnabled(false)
		self.panel_ui[key]:setBright(false)
	end

	for i=1,5 do
		local key = "sbtnBet"..i
		self.panel_ui[key]:setTouchEnabled(false)
		self.panel_ui[key]:setBright(false)
	end

	local playerInfo = get_player_info()
	-- if long_compare(playerInfo.id, shark_manager._bankerID) == 0 then--我是庄家，不准下分
	-- 	self.panel_ui.btnAddChips:setVisible(false)
	-- 	self.panel_ui.btnReduceChips:setVisible(false)
	-- else
	-- 	self.panel_ui.btnAddChips:setVisible(true)
	-- 	self.panel_ui.btnReduceChips:setVisible(true)
	-- end

	self:resetGameData()

	if self._isAutoOut then
		--请求退出
		send_shark_ReqExitTable()
	end

	audio_manager:stopALLSound()
	audio_manager:resumeMusic()
end

--进入下注阶段
function CSharkMainScene:enterBetStage()
	self._gameStep = GAME_STEP.BET_STEP
	self.panel_ui.imgStageWord:setTexture(shark_imgRes_config["下注"].resPath)
	self.panel_ui.imgStageWord1:setTexture(shark_imgRes_config["下注"].resPath)
	self.panel_ui.imgStageWord:setVisible(true)
	self.panel_ui.fntTime:setVisible(true)
	-- self.panel_ui.imgBack1:setVisible(true)
	
	self.panel_ui.btnBet:setTouchEnabled(true)
	self.panel_ui.btnBet:setBright(true)

	local isNotBanker = true
	local playerInfo = get_player_info()
	if long_compare(playerInfo.id, shark_manager._bankerID) == 0 then--我是庄家，不准下分
		self.bankerPanel:hideUnBankerButton()

		for i=1,5 do
			local key = "sbtnBet"..i
			self.panel_ui[key]:setTouchEnabled(false)
			self.panel_ui[key]:setBright(false)
		end

		isNotBanker = false
	else
		for i=1,5 do
			local isEnable = long_compare(self._ownChips, 10^i) >= 0 
			local key = "sbtnBet"..i
			self.panel_ui[key]:setTouchEnabled(isEnable)
			self.panel_ui[key]:setBright(isEnable)
		end
	end

	-- self.panel_ui.btnAddChips:setVisible(isNotBanker)
	-- self.panel_ui.btnReduceChips:setVisible(isNotBanker)

	if self._isAutoContinueBet == false and isNotBanker then
		self:setShowBetPanel(true)
	-- else
	-- 	self:setShowBetPanel(false)
	end
	self.panel_ui.btnContinueBet:setTouchEnabled(isNotBanker)
	self.panel_ui.btnContinueBet:setBright(isNotBanker)
	self.panel_ui.btnClear:setTouchEnabled(isNotBanker)
	self.panel_ui.btnClear:setBright(isNotBanker)

	for i=1,12 do
		local key = "btnAnimation"..i
		self.panel_ui[key]:setTouchEnabled(isNotBanker)
		self.panel_ui[key]:setBright(isNotBanker)
	end

	if self._tipsPanel then
		self._tipsPanel:onHide()
		self._tipsPanel = nil
	end

	if self._isAutoContinueBet and isNotBanker then
		self:continueBet()
	end

	--游戏背景
	self.gameBackScene:setBackImage()

	audio_manager:playOtherSound(1)
end

--进入开奖阶段
function CSharkMainScene:enterShowRewardStage(time)
	self._gameStep = SHOW_STEP
	self.panel_ui.imgStageWord:setTexture(shark_imgRes_config["开奖"].resPath)
	self.panel_ui.imgStageWord1:setTexture(shark_imgRes_config["开奖"].resPath)
	self.panel_ui.imgStageWord:setVisible(true)
	self.panel_ui.fntTime:setVisible(true)
	-- self.panel_ui.imgBack1:setVisible(false)
	self:setShowBetPanel(false)
	for i=1,12 do
		local key = "btnAnimation"..i
		self.panel_ui[key]:setTouchEnabled(false)
		self.panel_ui[key]:setBright(false)
	end

	for i=1,5 do
		local key = "sbtnBet"..i
		self.panel_ui[key]:setTouchEnabled(false)
		self.panel_ui[key]:setBright(false)
	end

	self.panel_ui.btnContinueBet:setTouchEnabled(false)
	self.panel_ui.btnContinueBet:setBright(false)
	self.panel_ui.btnClear:setTouchEnabled(false)
	self.panel_ui.btnClear:setBright(false)

	self.panel_ui.btnBet:setTouchEnabled(false)
	self.panel_ui.btnBet:setBright(false)

	if self._tipsPanel then
		self._tipsPanel:onHide()
		self._tipsPanel = nil
	end

	local item = self._rewardlist:getFinalRewardItem()
	if item then
	    item:reset()
    end

	if shark_manager._secondRewardIndex ~= 0 then
		print("有第二次奖励")
		self:addTimeDown(time, function ()
			self:secondOpenReward()
		end)
	else
		self:addTimeDown(time)
	end
end


--设置庄家信息
function CSharkMainScene:setBankerInfo( info )
	self.bankerPanel:setBankerInfo(info)
	local isNotBanker = true
	local playerInfo = get_player_info()
	if long_compare(playerInfo.id, shark_manager._bankerID) == 0 then
		isNotBanker = false
		self._isAutoContinueBet = false
	end
		
	self.panel_ui.cbAutoContinue:setTouchEnabled(isNotBanker)
	self.panel_ui.cbAutoContinue:setBright(isNotBanker)	
	self.panel_ui.cbAutoContinue1:setTouchEnabled(isNotBanker)
	self.panel_ui.cbAutoContinue1:setBright(isNotBanker)
	self.panel_ui.cbAutoContinue:setSelected(self._isAutoContinueBet)
	self.panel_ui.cbAutoContinue1:setSelected(self._isAutoContinueBet)
end

--设置申请玩家
function CSharkMainScene:setApplyPlayers( infolist )
	self.bankerPanel:setApplyPlayers(infolist)
end

--设置玩家筹码
function CSharkMainScene:setPlayerChips( value )
	self.panel_ui.labMyChips:setString(value)
	self._ownChips = value

	if self._gameStep == GAME_STEP.BET_STEP then
		for i=1,5 do
			local isEnable = long_compare(self._ownChips, 10^i) >= 0 
			local key = "sbtnBet"..i
			self.panel_ui[key]:setTouchEnabled(isEnable)
			self.panel_ui[key]:setBright(isEnable)
		end
	end
end

--设置当前下注
function CSharkMainScene:setCurBetChips( value )
	self._curBetChips = value
	self.panel_ui.fntCurBetChips:setString(value)
end

--设置总下注
function CSharkMainScene:setTotalBetChips( value )
	self._totalBetChips = value
	self.panel_ui.fntTotalBetChips:setString(value)
end

--设置倍数
function CSharkMainScene:setBetMultiplyNum( infos )
	for i,v in ipairs(infos) do
		local key = "fntMultiple"..v.icon
		self.panel_ui[key]:setString("x"..v.rate)

		self._betMultiplyMap[v.icon] = v.rate
	end
end

--设置自己下注结果
function CSharkMainScene:setMainPlayerBetChips( info )
	self._myBetMap[info.icon] = info.bet

    local key = "fntSingleBetChips"..info.icon
	self.panel_ui[key]:setString(self._myBetMap[info.icon])

	self._curBetChips = 0
	for k,v in pairs(self._myBetMap) do
		self._curBetChips = long_plus(self._curBetChips, v)
	end
	self:setCurBetChips(self._curBetChips)

	audio_manager:playOtherSound(4)
end

--设置所有玩家下注结果
function CSharkMainScene:setAllPlayerBetChips( infos )
	self._totalBetChips = 0

	local sharkChips = 0

	for i=1,12 do
		local key = "fntGameTotalChips"..i
		self.panel_ui[key]:setString(0)
	end
	

	for i,v in ipairs(infos) do
        local key = "fntGameTotalChips"..v.icon
	    self.panel_ui[key]:setString(v.bet)
	    self._totalBetChips = long_plus(self._totalBetChips, v.bet)

	    if v.icon == 10 or v.icon == 9 then
    	    sharkChips = long_plus(sharkChips, v.bet)
	    end
	end
	shark_manager._betGoldSharkChips = sharkChips

	self:setTotalBetChips(self._totalBetChips)
end

--设置奖金池
function CSharkMainScene:setRewardPool( icon )
	local value = long_multiply(self._betMultiplyMap[icon], shark_manager._betGoldSharkChips)

	self.panel_ui.fntReward:setString(value)
end

--续押
function CSharkMainScene:continueBet()
	local totalBet = 0
	for k,v in pairs(self._lastBetMap) do
		totalBet = long_plus(totalBet, v)
	end

	if long_compare(totalBet, self._ownChips) <= 0 then
		for k,v in pairs(self._lastBetMap) do
			send_shark_ReqBet({icon = k, bet = v})
		end
	else
		TipsManager:showOneButtonTipsPanel( 76, {}, true)
	end
end

--设置记录列表
function CSharkMainScene:setRecordList( idlist )
	for i,v in ipairs(idlist) do
		table.insert(self._rewardRecordList, v)

		if #self._rewardRecordList > 20 then
			table.remove(self._rewardRecordList, 1)
		end
	end

	local bIndex
	if #self._rewardRecordList > 8 then
		bIndex = #self._rewardRecordList - 8
	else
		bIndex = 0
	end

	for i=1,8 do
		local id = self._rewardRecordList[i + bIndex]
		local key = "sprRecordIcon"..i
		local key1 = "sprRecordIcon_"..i
		if id then
			self.panel_ui[key]:setVisible(true)
			self.panel_ui[key1]:setVisible(true)
			self.panel_ui[key]:setTexture("game/shark_std/resource/image/record/"..id..".png")
			self.panel_ui[key1]:setTexture("game/shark_std/resource/image/record/"..id..".png")
		else
			self.panel_ui[key]:setVisible(false)
			self.panel_ui[key1]:setVisible(false)
		end
	end

	self._recordIndex = 0
end

--添加记录
function CSharkMainScene:addRecord( id )
	table.insert(self._rewardRecordList, id)

	if #self._rewardRecordList > 20 then
		table.remove(self._rewardRecordList, 1)
	end

	local bIndex
	if #self._rewardRecordList > 8 then
		bIndex = #self._rewardRecordList - 8
	else
		bIndex = 0
	end
	self._recordIndex = bIndex

	for i=1,8 do
		local id = self._rewardRecordList[i + bIndex]
		local key = "sprRecordIcon"..i
		local key1 = "sprRecordIcon_"..i
		if id then
			self.panel_ui[key]:setVisible(true)
			self.panel_ui[key1]:setVisible(true)
			self.panel_ui[key]:setTexture("game/shark_std/resource/image/record/"..id..".png")
			self.panel_ui[key1]:setTexture("game/shark_std/resource/image/record/"..id..".png")
		else
			self.panel_ui[key]:setVisible(false)
			self.panel_ui[key1]:setVisible(false)
		end
	end
end

--左移项
-- function CSharkMainScene:leftMove()
-- 	if self._recordIndex > 0 then
-- 		self._recordIndex = self._recordIndex - 1

-- 		for i=1,8 do
-- 			local id = self._rewardRecordList[i + self._recordIndex]
-- 			local key = "sprRecordIcon"..i
-- 			if id then
-- 				self.panel_ui[key]:setVisible(true)
-- 				self.panel_ui[key]:setTexture("game/shark_std/resource/image/record/"..id..".png")
-- 			else
-- 				self.panel_ui[key]:setVisible(false)
-- 			end
-- 		end
-- 	end
-- end

--右移项
-- function CSharkMainScene:rightMove()
-- 	if self._recordIndex + 8 < #self._rewardRecordList then
-- 		self._recordIndex = self._recordIndex + 1

-- 		for i=1,8 do
-- 			local id = self._rewardRecordList[i + self._recordIndex]
-- 			local key = "sprRecordIcon"..i
-- 			if id then
-- 				self.panel_ui[key]:setVisible(true)
-- 				self.panel_ui[key]:setTexture("game/shark_std/resource/image/record/"..id..".png")
-- 			else
-- 				self.panel_ui[key]:setVisible(false)
-- 			end
-- 		end
-- 	end
-- end

function CSharkMainScene:addTimeDown(time,timeCallBack)
	local showtime = math.ceil(time-1)
	self.panel_ui.fntTime:setString(tostring(showtime))
	self.panel_ui.fntTime1:setString(tostring(showtime))

	timeUtils:addTimeDown(self.panel_ui.fntTime, time-1, function ( t ) self:timeCallBackHandler(t) end, timeCallBack)
end

--倒计时回调函数
function CSharkMainScene:timeCallBackHandler(time)
	local showtime = math.ceil(time)
	self.panel_ui.fntTime:setString(tostring(showtime))
	self.panel_ui.fntTime1:setString(tostring(showtime))

	if self._gameStep == GAME_STEP.BET_STEP then
		if showtime <= 3 then
			audio_manager:playOtherSound(5)
		end
	end
end

--显示/隐藏下注面板
function CSharkMainScene:setShowBetPanel(bIsShow)
	local posX,posY = self.panel_ui.imgBack1:getPosition()
	local size = self.panel_ui.imgBack1:getContentSize()
	local function callback()
		self.panel_ui.imgBack1:setVisible(bIsShow)
		self.panel_ui.imgBack1:setTouchEnabled(bIsShow)
	end
	local moveBy = cc.MoveBy:create(0.3, cc.p(0,size.height))
	local moveBack = cc.MoveBy:create(0.3, cc.p(0,-size.height))
	local call_back = cc.CallFunc:create(callback)
	local bcurShow = self.panel_ui.imgBack1:isVisible()
	if bIsShow ~= bcurShow then
		if bIsShow then
			self.panel_ui.imgBack1:setPosition(cc.p(960,size.height+size.height/2+24))
			self.panel_ui.imgBack1:runAction(cc.Sequence:create(call_back,moveBack))
		else
			self.panel_ui.imgBack1:setPosition(cc.p(960,size.height/2+24))
			self.panel_ui.imgBack1:runAction(cc.Sequence:create(moveBy,call_back))
		end
	end

end