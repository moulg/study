--[[
	乌龟快跑店主界面
]]

local gameStateResPathList = {"game/horserace_std/resource/word/BetDown_Award_State_0.png",
							"game/horserace_std/resource/word/BetDown_Award_State_1.png",
							"game/horserace_std/resource/word/BetDown_Award_State_2.png",
							"game/horserace_std/resource/word/BetDown_Award_State_3.png",
							}
local bgList = { 
	[1] = {"game/horserace_std/resource/image/BetDown_Horse_Bg_He_1.jpg",
		"game/horserace_std/resource/image/BetDown_Horse_Bg_He_2.jpg",
		"game/horserace_std/resource/image/BetDown_Horse_Bg_He_3.jpg",
	},
	[2] = {"game/horserace_std/resource/image/BetDown_Horse_Bg_lan_1.jpg",
		"game/horserace_std/resource/image/BetDown_Horse_Bg_lan_2.jpg",
		"game/horserace_std/resource/image/BetDown_Horse_Bg_lan_3.jpg",
	},
	[3] = {"game/horserace_std/resource/image/BetDown_Horse_Bg_lv_1.jpg",
		"game/horserace_std/resource/image/BetDown_Horse_Bg_lv_2.jpg",
		"game/horserace_std/resource/image/BetDown_Horse_Bg_lv_3.jpg",
	},
	[4] = {"game/horserace_std/resource/image/BetDown_Horse_Bg_qing_1.jpg",
		"game/horserace_std/resource/image/BetDown_Horse_Bg_qing_2.jpg",
		"game/horserace_std/resource/image/BetDown_Horse_Bg_qing_3.jpg",
	},
	[5] = {"game/horserace_std/resource/image/BetDown_Horse_Bg_tu_1.jpg",
		"game/horserace_std/resource/image/BetDown_Horse_Bg_tu_2.jpg",
		"game/horserace_std/resource/image/BetDown_Horse_Bg_tu_3.jpg",
	},
}
local panel_ui = require "game.horserace_std.script.ui_create.ui_horserace_main"

CHorseRaceMainScene = class("CHorseRaceMainScene", function ()
	local ret = cc.Node:create()
	return ret		
end)

ModuleObjMgr.add_module_obj(CHorseRaceMainScene,"CHorseRaceMainScene")
-- CHorseRaceMainScene.GAME_STEP = GAME_STEP

function CHorseRaceMainScene.create()
	local node = CHorseRaceMainScene.new()
	if node ~= nil then
		-- node:init_ui()
		node:loading()
		node:regEnterExit()
		node:regTouch()
		return node
	end
end
--加载
function CHorseRaceMainScene:loading()
    self.isLoadEnd = false

	local info = {
		parent 			= WindowScene.getInstance().game_layer,
		task_call 		= function (percent,index,texture) self:addImageSrc(percent,index,texture) end,
		complete_call 	= function () self:loadEnded() end,
		--task_lst = {[x] = {src = "",},},
		ui_info = {
			back_pic 		= "game/horserace_std/resource/image/loadbg.jpg",
			bar_back_pic 	= "game/horserace_std/resource/image/loadbg.png",
			bar_process_pic = "game/horserace_std/resource/image/loadt.png",
			b_self_release 	= true,
		},
	}

	info.task_lst = {}
	for i=1,#horserace_effect_res_config do
		local item = {src = horserace_effect_res_config[i].imageName,}
		info.task_lst[i] = item
	end
	self._loadingTask = LoadingTask.create(info)
end

function CHorseRaceMainScene:addImageSrc(percent,index,texture)
	local cache = cc.SpriteFrameCache:getInstance()
	cache:addSpriteFrames(horserace_effect_res_config[index].plistPath)
end

--加载结束
function CHorseRaceMainScene:loadEnded()
	self._loadingTask = nil
	self:init_ui()
	self:initData()
	self:resetGame()
    self.isLoadEnd = true
    self.panel_ui.pnlWaterWave:setTouchEnabled(false)
end

function CHorseRaceMainScene:regEnterExit()
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

function CHorseRaceMainScene:onEnter()
	audio_manager:reloadMusicByConfig(horserace_music_config)
 	--显示倒数计时
 	self.circleTime = 0
	self.schedulHandler = scheduler:scheduleScriptFunc(handler(self,self.updateCountdownAndState),1,false) 
end

function CHorseRaceMainScene:onExit()
	audio_manager:destoryAllMusicRes()
	if self.schedulHandler ~=nil then
		scheduler:unscheduleScriptEntry(self.schedulHandler)
		self.schedulHandler = nil
	end
	if self.schedulMoveBg ~= nil then
		scheduler:unscheduleScriptEntry(self.schedulMoveBg)
		self.schedulMoveBg = nil
	end
	if self.schedulCountdown ~= nil then
		-- print("clean schedulCountdown>>>>>>")
		scheduler:unscheduleScriptEntry(self.schedulCountdown)
		self.schedulCountdown = nil
	end
	--移除奔跑动画
	self:remvoeRunningSpr()
	--移除休息时背景动画
	self:remvoeRestSpr()
	--释放animationCache
	cc.AnimationCache:destroyInstance()

	local cache = cc.SpriteFrameCache:getInstance()
    for k,v in pairs(horserace_effect_res_config) do
    	cache:removeSpriteFramesFromFile(v.plistPath)
    end
	
	-- self.recordPanel:unregisterBtnMouseMoveEff()
	--check button 组处理
	self.betPanel.btn_group_info_lst = {}
	--是否开在开奖之前进入
	horserace_manager._beforeStart = false
	--是否显示押注面板
	horserace_manager._betPanelIsShow = false

	--当前玩家下注的筹码
	horserace_manager.curBetChipsMap = {}
	--用于记录当前玩家在每个区域下注的用于续押的总筹码数
	horserace_manager._continueChips = nil
	--重置选择筹码小图标
	horserace_manager._selectChipsType = nil
end

--初始化UI
function CHorseRaceMainScene:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	-- --开奖记录界面
	-- self.recordPanel =  CHorseRaceRecord.create()
	-- self:addChild(self.recordPanel)
	-- self.recordPanel:setPosition(0,0)
	-- self.recordPanel:setAnchorPoint(0,0)

	--下注面板
	self.betPanel =  CHorseRaceBet.create()
	self:addChild(self.betPanel)
	self.betPanel:setPosition(0,0)
	self.betPanel:setAnchorPoint(0,0)
	
	-- 添加高亮
	-- self:addButtonHightLight()

	--添加马的节点
	self.nodeHorseList = {self.panel_ui.nodePurple,self.panel_ui.nodeRed,self.panel_ui.nodeOrange,
						self.panel_ui.nodeYellow,self.panel_ui.nodeGreen,self.panel_ui.nodeBlue,}
	--滑块列表
	self.sprHorseList ={self.panel_ui.sprPlanPurple,self.panel_ui.sprPlanRed,self.panel_ui.sprPlanOrange,
						self.panel_ui.sprPlanYellow,self.panel_ui.sprPlanGreen,self.panel_ui.sprPlanBlue,}
	--添加休息马的节点
	self.nodeRestHorseList = {self.panel_ui.NodeHuangbie,self.panel_ui.NodeHongbie}
	
	--水波纹特效节点列表
	self.WaterWaveEffectList = {self.panel_ui.nodeWaterWave1,self.panel_ui.nodeWaterWave2,self.panel_ui.nodeWaterWave3,
						self.panel_ui.nodeWaterWave4,self.panel_ui.nodeWaterWave5,self.panel_ui.nodeWaterWave6,
						self.panel_ui.nodeWaterWave7,self.panel_ui.nodeWaterWave8,self.panel_ui.nodeWaterWave9,
						self.panel_ui.nodeWaterWave10,self.panel_ui.nodeWaterWave11,self.panel_ui.nodeWaterWave12,
						self.panel_ui.nodeWaterWave13,self.panel_ui.nodeWaterWave14,self.panel_ui.nodeWaterWave15,
						self.panel_ui.nodeWaterWave16,self.panel_ui.nodeWaterWave17,self.panel_ui.nodeWaterWave18,
						self.panel_ui.nodeWaterWave19,self.panel_ui.nodeWaterWave20,self.panel_ui.nodeWaterWave21,
						self.panel_ui.nodeWaterWave22,self.panel_ui.nodeWaterWave23,self.panel_ui.nodeWaterWave24,
						self.panel_ui.nodeWaterWave25,self.panel_ui.nodeWaterWave26,self.panel_ui.nodeWaterWave27,
						self.panel_ui.nodeWaterWave28,
					}
	--根据ID更新背景
	self.curSceneId = 1
	self:updateBackGroundById(self.curSceneId)
	--根据ID添加Item
	self:addItemBySceneId(self.curSceneId)
	--添加马到场景中
	self:addHorse()
	self:playRunningAnimation()
	--添加水波纹
	self:addWaterWaveEffect()
	self.panel_ui.imgRestBg:setVisible(false)
	self.panel_ui.imgRest:setVisible(false)
	self.betPanel.panel_ui.ImgBg:setVisible(false)	
end

--设置禁用或启用筹码按钮
function CHorseRaceMainScene:setBtnBetEnable(value)
	self.betPanel:setBtnBetEnable(value)
end

--根据当前筹码更新筹码按钮状态
function CHorseRaceMainScene:updateBtnChipsState()
	self:calculateContinue()
	self.betPanel:updateBtnChipsState(value)
end

--设置禁用或启用下注按纽
function CHorseRaceMainScene:setBtnSelectEnable(value)
	self.betPanel:setBtnSelectEnable(value)
end

--设置禁用或启用兑换按钮
function CHorseRaceMainScene:setBtnExchangeEnable(value)
	self.panel_ui.btnDuihuan:setEnabled(value)
	self.panel_ui.btnDuihuan:setBright(value)
end

--重置显示下注的数字
function CHorseRaceMainScene:resetBetNum()
	self.betPanel:resetBetNum()
end

--判断当前筹码是否可以续押
function CHorseRaceMainScene:calculateContinue()
	self.betPanel:calculateContinue()	
end

--获取续押的筹码总数
function CHorseRaceMainScene:getContinueBetRequireChips()
	local continueRequireChips = 0
	if horserace_manager._continueChips then
		for k,v in pairs(horserace_manager._continueChips) do
			continueRequireChips = long_plus(continueRequireChips,v)
		end
	end
	return continueRequireChips
end


function CHorseRaceMainScene:initData()

    self:registerHandler()
	--更新玩家信息
	self:updatePlayerInfo()
	--更新记录
	-- self.recordPanel:updateRecordUi()
	--更新倍数
	self:setMultiple()
	self:updateTotalBetChips()
	self:updatePlayerBetChips()
	self:updateChips()
	--隐藏倒计时旋转特效
	self:setCountDownEffect(false)
	--是否开在开奖之前进入
	horserace_manager._beforeStart = false
	--是否显示押注面板
	horserace_manager._betPanelIsShow = false

end

--根据状态重置游戏数据
function CHorseRaceMainScene:resetGame()
	print("根据状态重置游戏数据")
	-- print("horserace_manager._state = " ..horserace_manager._state)
	-- if horserace_manager._bFirstEnter == true then
	-- 	--显示兑换界面
	-- 	if horserace_manager._state ~= 3 then
	-- 		TipsManager:showChipsExchangePanel(horserace_manager._ownChips, get_player_info().gold)
	-- 	end
	-- end
	-- self.betPanelIsShow = false
	-- horserace_manager._betPanelIsShow = false
	-- self.betPanel.panel_ui.ImgBg:setVisible(false)
	self:setBtnSelectEnable(false)
	self:setBtnBetEnable(false)
	self:setBtnExchangeEnable(false)
	-- self:stopRunningAnimation()
	--判断是否可续押
	self:calculateContinue()

	if horserace_manager._state == 1 then
		audio_manager:playBackgroundMusic(1, true)
		self:hiddenRestBackGround()
		self:showRestBackGround(true)
		--刷新玩家信息
		self:updatePlayerInfo()
		self:resetBetNum()
		self:stopMoveBackGround()
		--将马恢复到初始位置
		self:resetHorsePosition()
		--续押
		horserace_manager._continueChips = horserace_manager.curBetChipsMap
		--所有下注的筹码
		horserace_manager.totalBetChipsMap = {}
		--当前玩家下注的筹码
		horserace_manager.curBetChipsMap = {}
		-- 移除结算面板
		self:removeSettleAccountsPanel()
		--当前玩家下注的筹码
		horserace_manager.curBetChipsMap = {}
		--兑换按钮
		self:setBtnExchangeEnable(true)
	elseif horserace_manager._state == 2 then
		audio_manager:playBackgroundMusic(2, true)
		if horserace_manager._iSceneId ~= self.curSceneId then
			self.curSceneId = horserace_manager._iSceneId
			self:updateBackGroundById(self.curSceneId)
			self:addItemBySceneId(self.curSceneId)
		end
		self:hiddenRestBackGround()
		--重置选择筹码小图标
		horserace_manager._selectChipsType = nil
		--兑换按钮
		self:setBtnExchangeEnable(true)
		--自动续押
		-- self:autoContinueBetHandler()

		self:setBtnSelectEnable(true)
		self:setBtnBetEnable(true)
		
	elseif horserace_manager._state == 3 then
		self.betPanel.panel_ui.ImgBg:setVisible(false)
		horserace_manager._betPanelIsShow = false
		if horserace_manager._beforeStart then
			self.circleTime = 5
			if self.schedulCountdown ~= nil then
				scheduler:unscheduleScriptEntry(self.schedulCountdown)
				self.schedulCountdown = nil
			end
			self.schedulCountdown = scheduler:scheduleScriptFunc(handler(self,self.updateCountdown),1,false)
		else
			audio_manager:playBackgroundMusic(1, true)
			self:showRestBackGround(false)
		end
		horserace_manager._continueChips = nil
	elseif horserace_manager._state == 4 then

		if horserace_manager._beforeStart == true then
			self.betPanel.panel_ui.ImgBg:setVisible(false)
			horserace_manager._betPanelIsShow = false
			--添加结算面板
			self:addSettleAccountsPanel()
		else
		self:showRestBackGround(false)			
		end
		--更新记录
		-- self.recordPanel:updateRecordUi()
	end
end

function CHorseRaceMainScene:updateCountdown(dt)
	-- print("updateCountdown>>>>>>")
	if self.circleTime ~= nil and self.circleTime > 0 then
		if self.circleTime == 3 then
			audio_manager:playOtherSound(3, false)
		end
		
		self:setCountDownEffect(true)
		self.circleTime = self.circleTime -1
	else
		audio_manager:playBackgroundMusic(3, true)
		audio_manager:playOtherSound(6, false)
		self:setCountDownEffect(false)
		if self.schedulCountdown ~= nil then
			scheduler:unscheduleScriptEntry(self.schedulCountdown)
			self.schedulCountdown = nil
		end
		if self.schedulMoveBg ~= nil then
			scheduler:unscheduleScriptEntry(self.schedulMoveBg)
			self.schedulMoveBg = nil
		end
		self.moveTime = horserace_manager._secondTotalTime / 1000
		self.moveSpeed = 3300 / self.moveTime
		-- self:playRunningAnimation()
		self.schedulMoveBg = scheduler:scheduleScriptFunc(handler(self,self.moveBackGround),0.01,false)
		self:playHorseMoveAnimation(horserace_manager._horseData)
	end
end

--[[
-- 按钮高亮
	function CHorseRaceMainScene:addButtonHightLight()
		local btnArr = {self.panel_ui.btnBetContinue, self.panel_ui.btnClean,
						self.panel_ui.btnAddChips, self.panel_ui.btnReduceChips,
						-- self.panel_ui.btnSelected1,self.panel_ui.btnSelected2,
						-- self.panel_ui.btnSelected3,self.panel_ui.btnSelected4,
					}

		local resArr = {"续押高亮", "清空高亮","上分高亮", "下分高亮",}

		for i,btn in pairs(btnArr) do
			-- local mov_obj = cc.Sprite:create(horserace_imgRes_config[(resArr[i])].resPath)
			WindowScene.getInstance():registerBtnMouseMoveEff(btn,mov_obj,1)
		end
	end
]]

--[[
--自动续押
	function CHorseRaceMainScene:autoContinueBetHandler()
		if (self.panel_ui.btnAutoContinue:isSelected() == true) and (horserace_manager._continueChips ~= nil) then
			local totalContinueChips = self:getContinueBetRequireChips()
			local requireChips = long_multiply(totalContinueChips,8)
			--判断当前筹码是否够
			if long_compare(horserace_manager._ownChips, totalContinueChips) >= 0 then
	    		for k,v in pairs(horserace_manager._continueChips) do
					send_horserace_ReqBet({area = k, chips = v})
				end
			else
				self.panel_ui.btnAutoContinue:setSelected(false)
			end
		end
	end
]]


--按钮事件
function CHorseRaceMainScene:registerHandler()
	--标题
	local function tipsCallBack()
		send_horserace_ReqExitTable()
	end
	local function closeFunc()
		if horserace_manager._state == 2 then
			if long_compare(self:getTotalBetChips(),0) ~= 0 then
				TipsManager:showOneButtonTipsPanel(72, {}, true)
			else
				tipsCallBack()
			end
		elseif (horserace_manager._state == 3) and (horserace_manager._beforeStart == true) then
			TipsManager:showTwoButtonTipsPanel(73, {}, true, tipsCallBack)
		else
			tipsCallBack()
		end
	end
	local title = WindowScene.getInstance():getModuleObjByClassName("CTableTitleExt")
	if title then
		title:setCloseFunc(closeFunc)
	end
	--兑换按钮
	self.panel_ui.btnDuihuan:onTouch(function(e)
		if e.name == "ended" then
		audio_manager:playOtherSound(1, false)
		local playerInfo = get_player_info()
			TipsManager:showExchangePanel(horserace_manager._ownChips, playerInfo.gold)
		end
	end)
	--押注按钮
	self.panel_ui.btnYazhu:onTouch(function(e)
		if e.name == "ended" then
		audio_manager:playOtherSound(1, false)
			if horserace_manager._betPanelIsShow == false then
				-- self.betPanelIsShow = true
				horserace_manager._betPanelIsShow = true
				self.betPanel.panel_ui.ImgBg:setVisible(true)
				self:betPanelscale()			
			else
				-- self.betPanelIsShow = false
				horserace_manager._betPanelIsShow = false
				self.betPanel.panel_ui.ImgBg:setVisible(false)
			end
		end
	end)

	--设置
	self.panel_ui.btnSet:onTouch(function (e)
		if e.name == "ended" then
		audio_manager:playOtherSound(1, false)
			local gameid = get_player_info().curGameID
			if gameid ~= nil then
				WindowScene.getInstance():showDlgByName("CHallSet")
			end
		end
	end)
	--退出
	self.panel_ui.btnExit:onTouch(function (e)
		if e.name == "ended" then
		audio_manager:playOtherSound(1, false)
			closeFunc()
		end
	end)
end

function CHorseRaceMainScene:betPanelscale()
	-- if self.betPanel.panel_ui.ImgBg ~= nil then
		local scaleSmall =cc.ScaleTo:create(0.1,0.9)
		local scaleBig =cc.ScaleTo:create(0.2,1.05)
		local scaleNormal = cc.ScaleTo:create(0.1,1.0)
		local action = cc.Sequence:create(scaleSmall,scaleBig,scaleNormal)
		self.betPanel.panel_ui.ImgBg:runAction(action)
	-- else
	-- 	print("self.betPanel.panel_ui.ImgBg=====nil")
	-- end
end
--倒计时和游戏状态
function CHorseRaceMainScene:updateCountdownAndState(dt)
    --倒计时音效
	if horserace_manager._state == 2 then 
		audio_manager:playOtherSound(4, false)
		-- if (horserace_manager._countdown < 6) and (self.clockEffect == nil) then
			-- local effectData = horserace_effect_config["CountDown_Effect"]
			-- -- dump(effectData) 
			-- self.clockEffect = animationUtils.createAndPlayAnimation(self.panel_ui.nodeClockEffect,effectData,nil)
		-- end
	end
	if self.isLoadEnd then
	    self.panel_ui.fntClock:setString(horserace_manager._countdown)
	    self.panel_ui.fntClock:setVisible(true)
	    self.panel_ui.imgClockBg:setVisible(true)
	    --游戏状态
	    if horserace_manager._state ~= nil then  
	    	self.panel_ui.imgState:loadTexture(gameStateResPathList[horserace_manager._state])
	    	self.panel_ui.imgState:setVisible(true)
	    end 
		--倒计时
		if (horserace_manager._countdown~=nil) and (horserace_manager._countdown>0) then
			horserace_manager._countdown = horserace_manager._countdown-1
	    end
    end
end

--更新总的下注数
function CHorseRaceMainScene:updateTotalBetChips()
	self.betPanel:updateTotalBetChips()
end

--清空当前玩家下注的筹码
function CHorseRaceMainScene:cleanChipsPanel()
	for area=1,15 do
		if horserace_manager.curBetChipsMap[area] ~= nil then
			horserace_manager.totalBetChipsMap[area]=long_minus(horserace_manager.totalBetChipsMap[area], horserace_manager.curBetChipsMap[area])
		end
	end
	horserace_manager.curBetChipsMap = {}
	
	self:updateTotalBetChips()
	self:updatePlayerBetChips()
end

--更新当前玩家的下注数
function CHorseRaceMainScene:updatePlayerBetChips()
	self.betPanel:updatePlayerBetChips()
end


--更新玩家筹码
function CHorseRaceMainScene:updateChips()
	self:updatePlayerInfo()
	self:updateBtnChipsState()
end

--获取当前玩家当前下注的总筹码数
function CHorseRaceMainScene:getTotalBetChips()
	local totalBetChips = 0
	for i,v in pairs(horserace_manager.curBetChipsMap) do
		totalBetChips = long_plus(totalBetChips,v)
	end
	return totalBetChips
end

--更新玩家信息
function CHorseRaceMainScene:updatePlayerInfo()
	local playerInfo = get_player_info()
	local playerSex = playerInfo.sex
	if playerSex == "男"then
		playerSex = 0
	else
		playerSex = 1
	end	
	self.panel_ui.labChips:setString(horserace_manager._ownChips)
	self.panel_ui.labName:setString(playerInfo.name)
	uiUtils:setPlayerHead(self.panel_ui.imgPlayerHead, playerSex, uiUtils.HEAD_SIZE_223)
end

--设置倍数
function CHorseRaceMainScene:setMultiple()
	self.betPanel:setMultiple()
end

--设置下注时的转圈倒计时
function CHorseRaceMainScene:setCountDownEffect(value)
	self.panel_ui.imgCircleBg:setVisible(value)
	self.panel_ui.fntCircleTime:setVisible(value)
	self.panel_ui.imgCircle:setVisible(value)
	if value then
		self.panel_ui.fntCircleTime:setString(self.circleTime)
		self.panel_ui.fntCircleTime:setScale(0)
    	self.panel_ui.fntCircleTime:runAction(cc.ScaleTo:create(0.8, 1.0))
		self.panel_ui.imgCircle:setOpacity(125)
    	self.panel_ui.imgCircle:runAction(cc.RotateBy:create(1, 360)) 
	end
end

--根据Id更新背景
function CHorseRaceMainScene:updateBackGroundById(iSceneId)
	local bgWidth = 0
	local sceneData = horserace_sence_type_config[iSceneId]
	local bgData = bgList[iSceneId]
	--left
	local spBgLeft = cc.Sprite:create(bgData[1])
	spBgLeft:setAnchorPoint(0,0)
	spBgLeft:setPosition(bgWidth,0)
	self.panel_ui.nodeRaceTrack:addChild(spBgLeft)
	bgWidth = bgWidth + spBgLeft:getContentSize().width
	--middle
	for i=1,sceneData.middle do
		local spBgMiddle = cc.Sprite:create(bgData[2])
		spBgMiddle:setAnchorPoint(0,0)
		spBgMiddle:setPosition(bgWidth,0)
		self.panel_ui.nodeRaceTrack:addChild(spBgMiddle)
		bgWidth = bgWidth + spBgMiddle:getContentSize().width
	end
	self.bgWidth = bgWidth
	--right
	local spBgRight = cc.Sprite:create(bgData[3])
	spBgRight:setAnchorPoint(0,0)
	spBgRight:setPosition(bgWidth,0)
	self.panel_ui.nodeRaceTrack:addChild(spBgRight)
	bgWidth = bgWidth + spBgRight:getContentSize().width
end

--添加小道具
function CHorseRaceMainScene:addItemBySceneId(iSceneId)
	local ItemData = horserace_sence_config[iSceneId]
	for k,v in pairs(ItemData) do
		if horserace_item_config[v.itemId].type == 1 then
			local resPath = horserace_item_config[v.itemId].imageName
			local sprite = cc.Sprite:create(resPath)
			if sprite ~= nil then
				sprite:setPosition(v.pX,v.pY)
				self.panel_ui.nodeRaceTrack:addChild(sprite)
			else
				print("!!!!!!!!!!!!!item资源为空!!!!!!!!!!!")
			end
		elseif horserace_item_config[v.itemId].type == 2 then
			local key = horserace_item_config[v.itemId].imageName
			local effectData = horserace_effect_config[key]
			dump(effectData)
			local sprEffect = animationUtils.createAndPlayAnimation(self.panel_ui.nodeRaceTrack,effectData,nil)
			sprEffect:setPosition(v.pX,v.pY)
		end
	end
end

--移动背景
function CHorseRaceMainScene:moveBackGround(dt)
	local PosX = self.panel_ui.nodeRaceTrack:getPositionX()
	-- if (self.bgWidth ~= nil) and (self.bgWidth+PosX <= 724) then
	if self.moveTime <= 0 then
		audio_manager:playOtherSound(5, false)
		if self.schedulMoveBg ~= nil then
			scheduler:unscheduleScriptEntry(self.schedulMoveBg)
			self.schedulMoveBg = nil
		end
		self:stopAllHorse()
		-- self:stopRunningAnimation()
	else
		PosX = PosX - (dt*self.moveSpeed)
		self.moveTime = self.moveTime - dt
		self.panel_ui.nodeRaceTrack:setPositionX(PosX)
	end
end

--停止背景移动
function CHorseRaceMainScene:stopMoveBackGround()
	if self.schedulMoveBg ~= nil then
		scheduler:unscheduleScriptEntry(self.schedulMoveBg)
		self.schedulMoveBg = nil
	end
	self.panel_ui.nodeRaceTrack:setPositionX(0)
end

--添加马
function CHorseRaceMainScene:addHorse()
	self.horseData = {}
	for k,v in pairs(self.nodeHorseList) do
		local animationData = horserace_effect_config[k]
		local frames = display.newFrames(animationData.picName, animationData.beginFrame, animationData.length)
		local animation,sprite = display.newAnimation(frames, animationData.frameTime)
		sprite:setAnchorPoint(1,0.5)
		v:addChild(sprite)
		self.horseData[#self.horseData + 1] = {sprHorse = sprite, animation = animation}
	end
end

--播放马奔跑动画
function CHorseRaceMainScene:playRunningAnimation()
	if table.nums(self.horseData) > 0 then
		for k,v in pairs(self.horseData) do
			if v.sprHorse and v.animation then
				-- if k == 1 then
				-- 	v.animation:setDelayUnits(0.5)
				-- end
				v.sprHorse:runAction(cc.RepeatForever:create(cc.Animate:create(v.animation)))
			end
		end
	end
end

--停止播放马奔跑的动画
function CHorseRaceMainScene:stopRunningAnimation()
	if self.horseData ~= nil then
		if table.nums(self.horseData) > 0 then
			for k,v in pairs(self.horseData) do
				v.animation:retain()
				v.sprHorse:stopAllActions()
			end
		end
	end
end

--显示休息时的背景
function CHorseRaceMainScene:showRestBackGround(value)
	self.panel_ui.imgRestBg:setVisible(true)
	self.panel_ui.imgWait:setVisible(value ~= true)
	if value and self.isLoadEnd then
		if self.restHorseData == nil then			
			self.panel_ui.imgRest:setVisible(value)
			self.restHorseData = {}
			for k,v in pairs(self.nodeRestHorseList) do
				local animationData = horserace_effect_config[(k+6)]
				local frames = display.newFrames(animationData.picName, animationData.beginFrame, animationData.length)
				local animation,sprite = display.newAnimation(frames, animationData.frameTime)
				v:addChild(sprite)
				sprite:runAction(cc.RepeatForever:create(cc.Animate:create(animation)))
				local moveAction = cc.MoveBy:create(9,cc.p(800,0))
				-- v:runAction(moveAction)
				self.panel_ui.imgRest:runAction(moveAction)
				self.restHorseData[#self.restHorseData + 1] = {sprHorse = sprite, animation = animation}
			end
		else
			-- self.panel_ui.imgRest:setVisible(false)
			for k,v in pairs(self.restHorseData) do
				if v.sprHorse and v.animation then
					v.sprHorse:runAction(cc.RepeatForever:create(cc.Animate:create(v.animation)))
				end
			end
			for k,v in pairs(self.nodeRestHorseList) do
				-- v:runAction(cc.MoveBy:create(9,cc.p(800,0)))
				self.panel_ui.imgRest:runAction(cc.MoveBy:create(9,cc.p(800,0)))

			end
		end
	end
end

--隐藏休息背景
function CHorseRaceMainScene:hiddenRestBackGround()
	self.panel_ui.imgRestBg:setVisible(false)
	if self.restHorseData then
		if table.nums(self.restHorseData) > 0 then
			for k,v in pairs(self.restHorseData) do
				v.animation:retain()
				v.sprHorse:stopAllActions()
			end
		end
	end
	for k,v in pairs(self.nodeRestHorseList) do
		v:setPositionX(80)
	end
	self.panel_ui.imgRest:setPositionX(100)
end

--马移动动画
function CHorseRaceMainScene:playHorseMoveAnimation(horseData)
	-- dump(horseData)
	local actionHorseData = {}
	local actionSpriteData = {}
	for k,v in pairs(horseData) do
		actionHorseData[k] = {}
		actionSpriteData[k] = {}
		local perHorseDistance = 1435 / v.segement
		local perSpriteDistance = 330 / v.segement
		
		for i,perTime in pairs(v.perTime) do
			local time = perTime / 1000
			if (v.horseId == horserace_manager._firstHorseId) and (i == table.nums(v.perTime)) then
				 perHorseDistance = perHorseDistance + (perHorseDistance/time)*((horserace_manager._secondTotalTime - v.totalTime)/1000)
				 perSpriteDistance = perSpriteDistance + (perSpriteDistance/time)*((horserace_manager._secondTotalTime - v.totalTime)/1000)
				 time = time + (horserace_manager._secondTotalTime - v.totalTime)/1000
				 -- print("perHorseDistance ====== " ..perHorseDistance)
			end
			table.insert(actionHorseData[k],cc.MoveBy:create(time,cc.p(perHorseDistance,0)))
			table.insert(actionSpriteData[k],cc.MoveBy:create(time,cc.p(perSpriteDistance,0)))
		end
	end
	for k,v in pairs(self.nodeHorseList) do
		local seq = cc.Sequence:create(actionHorseData[k])
		v:runAction(seq)
	end
	for k,v in pairs(self.sprHorseList) do
		local seq = cc.Sequence:create(actionSpriteData[k])
		v:runAction(seq)
	end
end

--停止所有的马和滑块
function CHorseRaceMainScene:stopAllHorse()
	for k,v in pairs(self.nodeHorseList) do
		v:stopAllActions()
	end
	for k,v in pairs(self.sprHorseList) do
		v:stopAllActions()
	end
	--延迟2秒
	-- performWithDelay(self, function () self:playRunningAnimation() end, 2)
	
end

--将马和滑块恢复到初始位置
function CHorseRaceMainScene:resetHorsePosition()
	for k,v in pairs(self.nodeHorseList) do
		v:setPositionX(260)
	end
	for k,v in pairs(self.sprHorseList) do
		v:setPositionX(1488) 
	end
end

--添加结算界面
function CHorseRaceMainScene:addSettleAccountsPanel()
	--结算界面
	if self.settleAccountsPanel == nil then 
		self.settleAccountsPanel =  CHorseRaceSettleAccounts.create()
		self:addChild(self.settleAccountsPanel, 100)
		self.settleAccountsPanel:setPosition(0,0)
		self.settleAccountsPanel:setAnchorPoint(0,0)
	end
	audio_manager:playBackgroundMusic(4, false)
	self.settleAccountsPanel:balance()
end

--移除结算界面
function CHorseRaceMainScene:removeSettleAccountsPanel()
	if self.settleAccountsPanel ~= nil then
		self.settleAccountsPanel:removeFromParent()
		self.settleAccountsPanel = nil
	end
end

--添加下注特效
function CHorseRaceMainScene:addBetEffect(areaId)
	self.betPanel:addBetEffect(areaId)
end

--添加水波纹特效
function CHorseRaceMainScene:addWaterWaveEffect()
	self.WaterWaveEffect = {}
	for k,v in pairs(self.WaterWaveEffectList) do
		local effectData = horserace_effect_config["WaterWave"]
		self.WaterWaveEffect[k] = animationUtils.createAndPlayAnimation(v,effectData,nil)
	end
end

--移除水波纹特效
function CHorseRaceMainScene:removeWaterWaveEffect()
	if self.WaterWaveEffec then
		for k,v in pairs(self.WaterWaveEffec) do
			v:removeFromParent()
		end
	end
end
function CHorseRaceMainScene:regTouch()
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

function CHorseRaceMainScene:onTouchEnded(touch, event)
	local a,b = self.betPanel.panel_ui.ImgBg:getPosition()
	--下注面板
	local betPos = self.betPanel.panel_ui.ImgBg:convertToWorldSpace(cc.p(0,0))
	local betboundingBox = self.betPanel.panel_ui.ImgBg:getBoundingBox()
	betboundingBox.x = betPos.x
	betboundingBox.y = betPos.y
	local pt = touch:getLocation()
	-- dump(pt)	
	if cc.rectContainsPoint(betboundingBox, pt) ~= true then
		if horserace_manager._betPanelIsShow == true  then
			horserace_manager._betPanelIsShow = false
			self.betPanel.panel_ui.ImgBg:setVisible(false)
		end
	end
end