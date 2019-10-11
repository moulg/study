--[[
百家乐主场景

]]

--是否进入准备阶段
local bEnterReadyStage = false
--发切牌终点坐标
local cardEndPosArr = {{x = 947, y = 764}, {x = 302, y = 547}, {x = 514, y = 547}, {x = 726, y = 547},{x = 937, y = 547},
   {x = 1148, y = 547},{x = 1360, y = 547},{x = 1571, y = 547},{x = 415, y = 325},{x = 622, y = 325},{x = 827, y = 325},
   {x = 1032, y =325},{x = 1238, y = 325},{x = 1440, y = 325},}
--玩家位置坐标
local playerPosArr = {{x = 1500, y = 950}, {x = 1300, y = 456}, {x = 650, y = 155}, {x = 106, y = 456},{x = 120, y = 950},}
--下注筹码坐标
local chipsEndPosArr = {x=800,y=800}
--闲家牌位置坐标
local playerCardEndPos = {{x = 460, y = 860},{x = 645, y = 860},{x = 550, y = 860},}
--庄家牌位置坐标
local bankerCardEndPos = {{x = 1260, y = 860},{x = 1440, y = 860},{x = 1350, y = 860},}
--博牌位置坐标
local gambleCardEndPos = {{x = 1650, y = 810},{x = 1820, y = 810},}
--黄牌位置坐标
local yellowCardEndPos = {x = 200, y = 740}
--废牌位置坐标
local disuseCardEndPos = {x=200,y=600}

--投掷范围
local THROW_WIDTH = 210
local THROW_HEIGHT = 180
--发牌速度
local SEND_CARD_SPEED = 0.3  
--游戏状态
local stateRes = {"game/baccarat_std/resource/word/qxz.png",
	"game/baccarat_std/resource/word/kpz.png",
	"game/baccarat_std/resource/word/xxyx.png",
	"game/baccarat_std/resource/word/xpz.png",}
--筹码图标
local sideResPathlist = {"lobby/resource/chips/70/1.png",
	"lobby/resource/chips/70/10.png",
	"lobby/resource/chips/70/100.png",
	"lobby/resource/chips/70/1k.png",
	"lobby/resource/chips/70/1w.png",
	"lobby/resource/chips/70/10w.png",
	"lobby/resource/chips/70/100w.png",
	"lobby/resource/chips/70/1000w.png",}
--开牌结果
local settleRes = {"game/baccarat_std/resource/word/zy.png",
	"game/baccarat_std/resource/word/xy.png",
	"game/baccarat_std/resource/word/he.png",}


local panel_ui = require "game.baccarat_std.script.ui_create.ui_baccarat_main"

CBaccaratMainScene = class("CBaccaratMainScene", function ()
	local ret = cc.Node:create()
	return ret
end)
ModuleObjMgr.add_module_obj(CBaccaratMainScene,"CBaccaratMainScene")

function CBaccaratMainScene.create()
	local node = CBaccaratMainScene.new()
	if node ~= nil then
		node:loading()
		node:regEnterExit()
		node:regTouch()
	end
	return node
end

function CBaccaratMainScene:loading()
    self.isLoadEnd = false
    self:initData()

	local info = {
		parent 			= WindowScene.getInstance().game_layer,
		task_call 		= function (percent,index,texture) self:addImageSrc(percent,index,texture) end,
		complete_call 	= function () self:loadEnded() end,
		--task_lst = {[x] = {src = "",},},
		ui_info = {
			back_pic 		= "game/baccarat_std/resource/image/loading/loadingmap.png",
			bar_back_pic 	= "game/baccarat_std/resource/image/loading/loadingbg.png",
			bar_process_pic = "game/baccarat_std/resource/image/loading/loading.png",
			b_self_release 	= true,
		},
	}

	info.task_lst = {}
	for i=1,#baccarat_effect_res_config do
		local item = {src = baccarat_effect_res_config[i].imageName,}
		info.task_lst[i] = item
	end
	self._loadingTask = LoadingTask.create(info)
end

function CBaccaratMainScene:addImageSrc(percent,index,texture)
	-- print("index = " .. index .. ",plist path  = " .. baccarat_effect_res_config[index].plistPath)

	local cache = cc.SpriteFrameCache:getInstance()
	cache:addSpriteFrames(baccarat_effect_res_config[index].plistPath)
end
function CBaccaratMainScene:regEnterExit()
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

function CBaccaratMainScene:onEnter()
	--加载音效资源
	audio_manager:reloadMusicByConfig(baccarat_music_config)
	--添加金币更新事件
	EventUtils.addEventListener(EventUtils.GOLD_CHANGE,self,function ()
		if baccarat_manager._state ~= 2 then 
			self:updateChips() 
		end
	end)
end

function CBaccaratMainScene:onExit()
	if self.schedulHandler ~=nil then
		scheduler:unscheduleScriptEntry(self.schedulHandler)
		self.schedulHandler = nil
	end

	--用于记录当前玩家在每个区域下注的用于续押的总筹码数
	baccarat_manager._continueChips = nil
	--所有下注的筹码
	baccarat_manager.totalBetChipsMap = {}
	--当前玩家下注的筹码
	baccarat_manager.curBetChipsMap = {}
	--开奖结果
	baccarat_manager.result = nil
	--玩家筹码变化
	baccarat_manager.chipsChange = "0"
	--切牌列表
	baccarat_manager.cutCardList = nil
	--统计数据
	baccarat_manager.statisticsData = {}
	--路单
	baccarat_manager.alone = nil
	--玩家筹码
	baccarat_manager._ownChips = "0"
	--游戏状态:1下注，2开奖，3休息，4洗牌
	baccarat_manager._state = 3

	EventUtils.removeEventListener(EventUtils.GOLD_CHANGE,self)
	--移除动画资源
	for i,v in ipairs(baccarat_effect_res_config) do
		display.removeSpriteFrames(v.plistPath,v.imageName)
	end
	-- --释放音效资源
	audio_manager:destoryAllMusicRes()
end

function CBaccaratMainScene:destoryLoading()
	if self._loadingTask then
    	self._loadingTask:forcedDestory()
        self._loadingTask = nil
    end
end

function CBaccaratMainScene:initData()		
	--下注的筹码图片
	self.betChipsImgList = {}
	--check button 组处理
	self.btn_group_info_lst = {}
	--是否正在进行游戏
	self._gameIsGoing = false
	--玩家筹码
	baccarat_manager._ownChips = "0"
	--当前选择筹码小图标
	baccarat_manager._selectChipsType = nil
	
	self.palyerCards = {}
	self.bankerCards = {}
	self.cardIndex = 1
end

function CBaccaratMainScene:loadEnded()
	self._loadingTask = nil
	
	self:init_ui()
	--刷新个人信息
	self.player_ui:updatePlayerInfo()
    self.isLoadEnd = true

    self.schedulHandler = scheduler:scheduleScriptFunc(handler(self,self.updateCountdownAndState),1,false)

    self:resetGame()
    self:updateNumberOfGames()

    --显示筹码兑换界面
	-- if baccarat_manager._state ~= 2 then
	-- 	TipsManager:showChipsExchangePanel(baccarat_manager._ownChips, get_player_info().gold)
	-- end

    --背景音乐
	audio_manager:playBackgroundMusic(1, true)
end


function CBaccaratMainScene:init_ui()
	--基础界面 
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)
	--玩家信息
	self.player_ui = CBaccaratPlayer.create()
	self.panel_ui.ImgBj:addChild(self.player_ui)
	self.player_ui:setPosition(0, 0)
	self.player_ui.panel_ui.btnPlayer:onTouch(function (e)
		if e.name == "ended" then
			self.player_ui:showHidePanel()
		end
	end)
	--洗牌界面
	self.shuffle_ui = CBaccaratShuffle.create()
	self.panel_ui.ImgBj:addChild(self.shuffle_ui)
	self.shuffle_ui:setVisible(false)
	--路单
	self.alone_ui = CBaccaratAlone.create()
	self.panel_ui.nodeshuffle:addChild(self.alone_ui)
	self.alone_ui:setPosition(0, 940)
	self.alone_ui.panel_ui.btnUp:onTouch(function (e)
		if e.name == "ended" then
			self.alone_ui:showHidePanel()
		end
	end)
	--设置
	self.set_ui = CBaccaratSet.create()
	self.panel_ui.nodeshuffle:addChild(self.set_ui)
	self.set_ui:setPosition(1920, 500)
	self.set_ui.panel_ui.sbtn_Set:onTouch(function (e)
		if e.name == "ended" then
			self.set_ui:showHidePanel()
		end
	end)

	--当前玩家下注筹码背景
	self.imgCurBetBgList = {self.panel_ui.imgZhuangMy,self.panel_ui.imgXianMy,self.panel_ui.imgHeMy,self.panel_ui.imgBigMy,
	self.panel_ui.imgXianTwoMy,self.panel_ui.imgLongMy,self.panel_ui.imgXianBLMy,self.panel_ui.imgXiaoMy,self.panel_ui.imgHuMy,
	self.panel_ui.imgZhuangTwoMy,self.panel_ui.imgZhuangBLMy,self.panel_ui.imgLHHMy,}
	--开中区域标识
	self.imgMaskList = {self.panel_ui.imgZhuang,self.panel_ui.imgXian,self.panel_ui.imgHe,self.panel_ui.imgBig,
	self.panel_ui.imgXianTwo,self.panel_ui.imgLong,self.panel_ui.imgXianBL,self.panel_ui.imgSmall,self.panel_ui.imgHu,
	self.panel_ui.imgZhuangTwo,self.panel_ui.imgZhuangBL,self.panel_ui.imgLHH,}
	--当前玩家下注筹码
	self.fntCurBetList = {self.panel_ui.fntZhuangMy,self.panel_ui.fntXianMy,self.panel_ui.fntHeMy,self.panel_ui.fntBigMy,
	self.panel_ui.fntXianTwoMy,self.panel_ui.fntLongMy,self.panel_ui.fntXianBLMy,self.panel_ui.fntXiaoMy,self.panel_ui.fntHuMy,
	self.panel_ui.fntZhuangTwoMy,self.panel_ui.fntZhuangBLMy,self.panel_ui.fntLHHMy,}
	--所有人下注总筹码
	self.fntTotalBetList = {self.panel_ui.fntZhuangOther,self.panel_ui.fntXianOther,self.panel_ui.fntHeOther,self.panel_ui.fntBigOther,
	self.panel_ui.fntXianTwoOther,self.panel_ui.fntLongOther,self.panel_ui.fntXianBLOther,self.panel_ui.fntXiaoOther,self.panel_ui.fntHuOther,
	self.panel_ui.fntZhuangTwoOther,self.panel_ui.fntZhuangBLOther,self.panel_ui.fntLHHOther,}
	--下注区选择按钮
	self.btnSelectList = {self.panel_ui.btnZhuang,self.panel_ui.btnXian,self.panel_ui.btnHe,self.panel_ui.btnBig,
	self.panel_ui.btnXianTwo,self.panel_ui.btnLong,self.panel_ui.btnXianBL,self.panel_ui.btnSmall,self.panel_ui.btnHu,
	self.panel_ui.btnZhuangTwo,self.panel_ui.btnZhuangBL,self.panel_ui.btnLHH,}
	--闲家的牌
	self.sprPlayerCards = {self.panel_ui.Card1,self.panel_ui.Card3,self.panel_ui.Card5,}
	--庄家的牌
	self.sprBankerCards = {self.panel_ui.Card2,self.panel_ui.Card4,self.panel_ui.Card6,}
	--用来博牌的牌
	self.sprGambleCards = {self.panel_ui.CardA,self.panel_ui.CardB,}
	--牌
	self.sprCardList = {self.panel_ui.Card1,self.panel_ui.Card2,self.panel_ui.Card3,self.panel_ui.Card4,self.panel_ui.CardA,
	self.panel_ui.CardB,self.panel_ui.Card5,self.panel_ui.Card6,}
	--黄牌
	self.panel_ui.CardXipai:setVisible(false)
	--废牌顶
	self.panel_ui.imgBackCardOne:setVisible(false)
	--废牌进度条
	self.panel_ui.LoadingBar_BackCard:setPercent(0)
	--博派特效
	self.sprGambleEffect = {self.panel_ui.sprPlayerGamble,self.panel_ui.sprBankerGamble,}
	for k,v in pairs(self.sprGambleEffect) do
		v:setVisible(false)
	end
	--切牌
	self.sprCutCardList = {self.panel_ui.cutCrd1,self.panel_ui.cutCrd2,self.panel_ui.cutCrd3,self.panel_ui.cutCrd4,self.panel_ui.cutCrd5,
	self.panel_ui.cutCrd6,self.panel_ui.cutCrd7,self.panel_ui.cutCrd8,self.panel_ui.cutCrd9,self.panel_ui.cutCrd10,self.panel_ui.cutCrd11,
	self.panel_ui.cutCrd12,self.panel_ui.cutCrd13,self.panel_ui.cutCrd14,}
	for k,v in pairs(self.sprCutCardList) do
		v:setVisible(false)
	end
	--结算
	self.panel_ui.sprSettle:setVisible(false)
	self.panel_ui.fntSettle:setString("")

	for i=1,12 do
		self.imgCurBetBgList[i]:setVisible(false)
		self.imgMaskList[i]:setVisible(false)
		self.fntCurBetList[i]:setString("")
		self.fntTotalBetList[i]:setString("")
		self.btnSelectList[i]:setTag(i)
	end

	for k,v in pairs(self.sprCardList) do
		v:setVisible(false)
	end

	--check button 组处理
	self.btn_group_info_lst = {}
	--筹码按钮
	self.btnBetList = {self.panel_ui.sbtnBet1,self.panel_ui.sbtnBet2,self.panel_ui.sbtnBet3,self.panel_ui.sbtnBet4,
		self.panel_ui.sbtnBet5,self.panel_ui.sbtnBet6,self.panel_ui.sbtnBet7,self.panel_ui.sbtnBet8,}
	self:registerGroupEvent(self.btnBetList,function (s,e) self:betButtonHandler(s,e) end)

	--庄宝龙
	self.panel_ui.imgZhuangBLPanel:setVisible(false)
	self.panel_ui.imgZhuangBLPanel:setTouchEnabled(false)
	self.bIsShowZhuangBLPanel = false
	--闲宝龙
	self.panel_ui.imgXianBLPanel:setVisible(false)
	self.panel_ui.imgXianBLPanel:setTouchEnabled(false)
	self.bIsShowXianBLPanel = false

	self.panel_ui.sprXZ:setVisible(false)
	self.panel_ui.sprXY:setVisible(false)

	-- self:addButtonHightLight()
	self:registerHandler()	
end

function CBaccaratMainScene:addButtonHightLight()
	-- local btnArr = {self.alone_ui.panel_ui.btnUp,self.alone_ui.panel_ui.sbtn_baccarat,self.alone_ui.panel_ui.sbtn_longhu,self.player_ui.panel_ui.btnPlayer,self.panel_ui.btnAdd,
	-- self.panel_ui.btnDda,self.panel_ui.btnBetContinue,self.panel_ui.btnOut,self.panel_ui.sbtnBet1,self.panel_ui.sbtnBet2,
	-- self.panel_ui.sbtnBet3,self.panel_ui.sbtnBet4,self.panel_ui.sbtnBet5,self.panel_ui.sbtnBet6,self.panel_ui.sbtnBet7,
	-- self.panel_ui.sbtnBet8,}

	-- local resArr = {"查看路单","百家乐","龙虎","个人信息","上分高亮", "下分高亮","续押高亮", "退出高亮",
	-- "筹码高亮", "筹码高亮","筹码高亮", "筹码高亮","筹码高亮", "筹码高亮","筹码高亮", "筹码高亮",}

	-- for i,btn in ipairs(btnArr) do
	-- 	local mov_obj = cc.Sprite:create(baccarat_imageRes_config[resArr[i]].resPath)
	-- 	WindowScene.getInstance():registerBtnMouseMoveEff(btn,mov_obj,1)
	-- end
end

function CBaccaratMainScene:betButtonHandler(sender,event)
	for k,v in pairs(self.btnBetList) do
		if sender == v then
			baccarat_manager._selectChipsType = k
			v:runAction(cc.RepeatForever:create(cc.Blink:create(1, 4) ))
		else 
			v:stopAllActions()
			v:setVisible(true)
		end
	end
end

--设置禁用或启用筹码按钮
function CBaccaratMainScene:setBtnBetEnable(value)
	if value then
		for i,v in pairs(self.btnBetList) do
			v:setSelected(false)
			-- local requireChips = long_plus(self:getTotalBetChips(), 10^(i-1))
			if (long_compare(baccarat_manager._ownChips, 10^(i-1)) >= 0) then
				v:setEnabled(true)
				v:setBright(true)
			else
				v:setEnabled(false)
				v:setBright(false)
			end
		end
	else
		for k,v in pairs(self.btnBetList) do
			v:setEnabled(value)
			v:setBright(value)
			v:setSelected(false)
			v:stopAllActions()
			v:setVisible(true)
		end
	end
	-- self.panel_ui.btnClean:setVisible(value)
end

function CBaccaratMainScene:playEffectSelected( var )
	if not var then
		var:runAction(cc.RepeatForever:create(cc.Blink:create(1, 2) ))
	end 
end

--根据当前筹码更新筹码按钮状态
function CBaccaratMainScene:updateBtnChipsState()
	if baccarat_manager._state == 1 then
		for i,v in pairs(self.btnBetList) do
			local requireChips = long_plus(self:getTotalBetChips(), 10^(i-1))
			if (long_compare(baccarat_manager._ownChips, 10^(i-1)) >= 0) then
				v:setEnabled(true)
				v:setBright(true)
			else
				v:setSelected(false)
				v:setEnabled(false)
				v:setBright(false)
			end
		end
	end
	self:calculateContinue()
end

--设置禁用或启用下注按纽
function CBaccaratMainScene:setBtnSelectEnable(value)
	if self.btnSelectList then
		for k,v in pairs(self.btnSelectList) do
			v:setEnabled(value)
			v:setBright(value)
		end
		if baccarat_manager.statisticsData.score then
			self.panel_ui.sprXZ:setVisible(baccarat_manager.statisticsData.score >= 30)
			self.panel_ui.sprXY:setVisible(baccarat_manager.statisticsData.score >= 30)
			self.btnSelectList[4]:setEnabled(baccarat_manager.statisticsData.score < 30)
			self.btnSelectList[4]:setBright(baccarat_manager.statisticsData.score < 30)
			self.btnSelectList[8]:setEnabled(baccarat_manager.statisticsData.score < 30)
			self.btnSelectList[8]:setBright(baccarat_manager.statisticsData.score < 30)
		end
	end
end

--设置禁用或启用上分下分按钮
function CBaccaratMainScene:setBtnAddAndReduceEnable(value)
	self.panel_ui.btnExchange:setEnabled(value)
	self.panel_ui.btnExchange:setBright(value)
	-- self.panel_ui.btnDda:setEnabled(value)
	-- self.panel_ui.btnDda:setBright(value)
end

--重置显示下注的数字
function CBaccaratMainScene:resetBetNum()
	for i=1,12 do
		self.fntTotalBetList[i]:setString("")
		self.fntCurBetList[i]:setString("")
		self.fntTotalBetList[i]:setVisible(false)
		self.fntCurBetList[i]:setVisible(false)
		self.imgCurBetBgList[i]:setVisible(false)
	end
end

--获取当前玩家当前下注的总筹码数
function CBaccaratMainScene:getTotalBetChips()
	local totalBetChips = 0
	for i,v in pairs(baccarat_manager.curBetChipsMap) do
		totalBetChips = long_plus(totalBetChips,v)
	end
	return totalBetChips
end

--判断当前筹码是否可以续押
function CBaccaratMainScene:calculateContinue()
	if baccarat_manager._state == 1 then
		if (baccarat_manager._continueChips ~= nil) and (table.nums(baccarat_manager._continueChips) > 0) then
			local totalContinueChips = self:getContinueBetRequireChips()
			-- local requireChips = long_plus(self:getTotalBetChips(),totalContinueChips)
	
			if long_compare(baccarat_manager._ownChips, totalContinueChips) >= 0 then 
				self.panel_ui.btnBetContinue:setEnabled(true)
				self.panel_ui.btnBetContinue:setBright(true)
			else
				self.panel_ui.btnBetContinue:setEnabled(false)
				self.panel_ui.btnBetContinue:setBright(false)
			end	
		else
			self.panel_ui.btnBetContinue:setEnabled(false)
			self.panel_ui.btnBetContinue:setBright(false)
		end
	else
		self.panel_ui.btnBetContinue:setEnabled(false)
		self.panel_ui.btnBetContinue:setBright(false)
	end
end

--续押
function CBaccaratMainScene:continueBetHandler()
	if baccarat_manager._continueChips then
		local totalContinueChips = self:getContinueBetRequireChips()
		local requireChips = long_plus(self:getTotalBetChips(),totalContinueChips)
		--判断当前筹码是否够
		if long_compare(baccarat_manager._ownChips, totalContinueChips) >= 0 then
			local Onlyshow = false
			for k,v in pairs(baccarat_manager._continueChips) do
				if long_compare(baccarat_manager.totalBetChipsMap[k], 10000000) < 0 then
					send_baccarat_ReqBet({area = k, chips = v})
				else
				 	if Onlyshow == false then
					 	Onlyshow = true
						TipsManager:showOneButtonTipsPanel(2009, {}, true)
					end
					
				end
				
			end
		else
			TipsManager:showOneButtonTipsPanel(76, {}, true)
		end 
	end
end

--自动续押
function CBaccaratMainScene:autoContinueBetHandler()
	if (self.panel_ui.sbtnAutoContinue:isSelected() == true) and (baccarat_manager._continueChips ~= nil) then
		local totalContinueChips = self:getContinueBetRequireChips()
		local requireChips = long_plus(self:getTotalBetChips(),totalContinueChips)
		--判断当前筹码是否够
		if long_compare(baccarat_manager._ownChips, totalContinueChips) >= 0 then
    		for k,v in pairs(baccarat_manager._continueChips) do
				send_baccarat_ReqBet({area = k, chips = v})
			end
		else
			self.panel_ui.sbtnAutoContinue:setSelected(false)
		end
	end
end

--自动退出
function CBaccaratMainScene:autoExitHandler()
	if self.panel_ui.sbtnAutoExit:isSelected() == true then
		send_baccarat_ReqExitTable()
	end
end

--获取续押的筹码总数
function CBaccaratMainScene:getContinueBetRequireChips()
	local continueRequireChips = 0
	if baccarat_manager._continueChips then
		for k,v in pairs(baccarat_manager._continueChips) do
			continueRequireChips = long_plus(continueRequireChips,v)
		end
	end
	return continueRequireChips
end

function CBaccaratMainScene:registerHandler()
	--标题
	local function tipsCallBack()
		send_baccarat_ReqExitTable()
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

	--兑换
	self.panel_ui.btnExchange:onTouch(function (e)
		if e.name == "ended" then
			TipsManager:showExchangePanel(baccarat_manager._ownChips, get_player_info().gold)
		end
	end)
	--设置
	self.set_ui.panel_ui.btn_set:onTouch(function (e)
		if e.name == "ended" then
			local gameid = get_player_info().curGameID
			if gameid ~= nil then
				WindowScene.getInstance():showDlgByName("CHallSet")
			end
		end
	end)
	-- 续押
	self.panel_ui.btnBetContinue:onTouch(function (e)
		if e.name == "ended" then
			print("续押")
			self:continueBetHandler()
		end
	end)
	--退出
	self.set_ui.panel_ui.btn_out:onTouch(function (e)
		if e.name == "ended" then
			print("退出")
			if baccarat_manager._state == 1 then
				if long_compare(self:getTotalBetChips(),0) ~= 0 then
					TipsManager:showOneButtonTipsPanel(72, {}, true)
				else
					send_baccarat_ReqExitTable()
				end
			elseif baccarat_manager._state == 2 then
				TipsManager:showTwoButtonTipsPanel(73, {}, true, tipsCallBack)
			else
				send_baccarat_ReqExitTable()
			end
		end
	end)
	-- 清空
	self.panel_ui.btnClean:onTouch(function (e)
		if e.name == "ended" then
			print("清空")
			send_baccarat_ReqClearBet(msg)
		end
	end)
	--庄宝龙
	self.panel_ui.btnZhuangbaolong:onTouch(function (e)
		if e.name == "ended" then
			print("庄宝龙")
			if self.bIsShowXianBLPanel == true then
				self.bIsShowXianBLPanel = false
				self.panel_ui.imgXianBLPanel:setVisible(false)
				self.panel_ui.imgXianBLPanel:setTouchEnabled(false)
			end
			if self.bIsShowZhuangBLPanel == false then
				self.bIsShowZhuangBLPanel = true
				self.panel_ui.imgZhuangBLPanel:setVisible(true)
				self.panel_ui.imgZhuangBLPanel:setTouchEnabled(true)
			else
				self.bIsShowZhuangBLPanel = false
				self.panel_ui.imgZhuangBLPanel:setVisible(false)
				self.panel_ui.imgZhuangBLPanel:setTouchEnabled(false)
			end
		end
	end)
	--闲宝龙
	self.panel_ui.btnXianbaolong:onTouch(function (e)
		if e.name == "ended" then
			print("闲宝龙")
			if self.bIsShowZhuangBLPanel == true then
				self.bIsShowZhuangBLPanel = false
				self.panel_ui.imgZhuangBLPanel:setVisible(false)
				self.panel_ui.imgZhuangBLPanel:setTouchEnabled(false)
			end
			if self.bIsShowXianBLPanel == false then
				self.bIsShowXianBLPanel = true
				self.panel_ui.imgXianBLPanel:setVisible(true)
				self.panel_ui.imgXianBLPanel:setTouchEnabled(true)
			else
				self.bIsShowXianBLPanel = false
				self.panel_ui.imgXianBLPanel:setVisible(false)
				self.panel_ui.imgXianBLPanel:setTouchEnabled(false)
			end
		end
	end)

	--下注
	for k,v in pairs(self.btnSelectList) do
		v:onTouch(function (e)
			if e.name == "ended" then
				print("下注")
				if baccarat_manager._selectChipsType ~= nil then
					local tag = e.target:getTag()
					if long_compare(baccarat_manager.totalBetChipsMap[tag-1], 10000000) < 0 then

						local curBetChips = baccarat_manager._chipsValueList[baccarat_manager._selectChipsType]

						local requireChips = long_plus(self:getTotalBetChips(), curBetChips)
						--判断当前筹码是否够下注
						if long_compare(baccarat_manager._ownChips, curBetChips) >= 0 then
							send_baccarat_ReqBet({area = tag-1, chips = curBetChips})
							print("向服务器发送下注请求")
							-- baccarat_manager._bCanBet = false
						else
							print("筹码不足!!!!!!!!!!!!")
							TipsManager:showOneButtonTipsPanel(76, {}, true)
						end
					else
						TipsManager:showOneButtonTipsPanel(2009, {}, true)
					end
				end
			end
		end)
	end
end

--倒计时和游戏状态
function CBaccaratMainScene:updateCountdownAndState(dt)
    -- 倒计时音效
	if baccarat_manager._state == 1 then
		if  baccarat_manager._countdown <= 5 then
			-- 下注阶段最后5秒每秒播一次
			audio_manager:playOtherSound(6, false)
		end
		if  baccarat_manager._countdown <= 1 then
			-- 下注阶段最后一秒播放
			audio_manager:playOtherSound(5, false)
		end
	end
    self.panel_ui.fntClock:setString(baccarat_manager._countdown)
    --游戏状态
    if baccarat_manager._state ~= nil then  
    	self.panel_ui.ImgJieduan:loadTexture(stateRes[baccarat_manager._state])
    end 
	--倒计时
	if (baccarat_manager._countdown~=nil) and (baccarat_manager._countdown>0) then
		baccarat_manager._countdown = baccarat_manager._countdown-1
    end
    
end

--添加下注筹码,area:下注区域,chips:下注筹码数
function CBaccaratMainScene:addChipsToPanel(area,chips)
	audio_manager:playOtherSound(4, false) 
	local numArr = gsplit(chips)  
	numArr = table.reverse(numArr)
	for i,v in pairs(numArr) do
		for k = 1,v do
			local params = {}
			local size = self.btnSelectList[area]:getContentSize()
			params.endPos_x = math.random(30, size.width-30) 
			params.endPos_y = math.random(40, size.height-40)

			local startPos = self.btnSelectList[area]:convertToNodeSpace(cc.p(800,0)) 
			local sprite = display.newSprite(sideResPathlist[i], startPos.x, startPos.y)
			sprite:setAnchorPoint(0.5,0.5)
			self.btnSelectList[area]:addChild(sprite)
			CFlyAction:Fly(sprite, 0.2, params, CFlyAction.FLY_TYPE_CHIPS)

			if self.betChipsImgList[area] == nil then
				self.betChipsImgList[area] = {}
			end
			table.insert( self.betChipsImgList[area], sprite )
		end
	end

end

--清除筹码图片
function CBaccaratMainScene:cleanChipsImg()
	local endPos = cc.p(800,1080)
	if long_compare(baccarat_manager.chipsChange,0) > 0 then
		endPos = cc.p(800,0)
	end
	for i,chipsImgList in pairs(self.betChipsImgList) do
		if chipsImgList ~= nil then
			--筹码移动音效
			audio_manager:playOtherSound(4, false)
			for k,sprite in pairs(chipsImgList) do
				if sprite ~= nil then 
					local params = {}
					local endPos = self.btnSelectList[i]:convertToNodeSpace(endPos) 
					params.endPos_x,params.endPos_y = endPos.x,endPos.y
			        params.flyendCallback = function ()
						sprite:removeFromParent()
						sprite = nil
					end
					CFlyAction:Fly(sprite, 1, params, CFlyAction.FLY_TYPE_CHIPS)
				end
			end
		end
	end
	self.betChipsImgList = {}
end

--清空当前玩家下注的筹码
function CBaccaratMainScene:cleanCurBetChips()
	for i=0,11 do
		if baccarat_manager.curBetChipsMap[i] then
			baccarat_manager.totalBetChipsMap[i]=long_minus(baccarat_manager.totalBetChipsMap[i], baccarat_manager.curBetChipsMap[i])
			baccarat_manager.curBetChipsMap[i] = nil
		end
	end
	baccarat_manager.curBetChipsMap = {}
	
	for i,chipsImgList in pairs(self.betChipsImgList) do
		if chipsImgList ~= nil then
			for k,sprite in pairs(chipsImgList) do
				if sprite ~= nil then 
					sprite:removeFromParent()
					sprite = nil
				end
			end
		end
	end
	self.betChipsImgList = {}
	self:updateTotalBetChips()
	self:updatePlayerBetChips()
end

--更新总的下注数
function CBaccaratMainScene:updateTotalBetChips()
	for area=1,12 do
		if baccarat_manager.totalBetChipsMap[area-1] ~= nil then
			if long_compare(baccarat_manager.totalBetChipsMap[area-1], 0) > 0 then
				self.fntTotalBetList[area]:setString(baccarat_manager.totalBetChipsMap[area-1])
				self.fntTotalBetList[area]:setVisible(true)
			else
				self.fntTotalBetList[area]:setVisible(false)
			end
		else
			self.fntTotalBetList[area]:setVisible(false)
		end
	end
end

--更新当前玩家的下注数
function CBaccaratMainScene:updatePlayerBetChips()
	for area=1,12 do
		if baccarat_manager.curBetChipsMap[area-1] ~= nil then
			if long_compare(baccarat_manager.curBetChipsMap[area-1], 0) > 0 then
				self.fntCurBetList[area]:setString(baccarat_manager.curBetChipsMap[area-1])
				self.fntCurBetList[area]:setVisible(true)
				self.imgCurBetBgList[area]:setVisible(true)
			else
				self.fntCurBetList[area]:setVisible(false)
				self.imgCurBetBgList[area]:setVisible(false)
			end
		else
			self.fntCurBetList[area]:setVisible(false)
			self.imgCurBetBgList[area]:setVisible(false)
		end
	end
	self:updateBtnChipsState()
end

--更新玩家筹码
function CBaccaratMainScene:updateChips()
	self.player_ui:updatePlayerInfo()
	self:updateBtnChipsState()
end

function CBaccaratMainScene:resetGame()
	self:setBtnSelectEnable(false)
	self:setBtnBetEnable(false)
	self:setBtnAddAndReduceEnable(false)
	-- --判断是否可续押
	self:calculateContinue()
	
	if baccarat_manager._state == 1 then
		--重置选择筹码小图标
		baccarat_manager._selectChipsType = nil
		--开始下注音效
		audio_manager:playOtherSound(1, false)
		--上分下分
		self:setBtnAddAndReduceEnable(true)

		self:setBtnSelectEnable(true)
		self:setBtnBetEnable(true)
		
	elseif baccarat_manager._state == 2 then
		baccarat_manager._continueChips = nil
		--发牌
		-- self:sendCardStage()

	elseif baccarat_manager._state == 3 then
		--休息阶段开始时播放
		audio_manager:playOtherSound(7, false)
		self:showBlance(false)
		self:cleanCard()
		self:cleanChipsImg()
		self:resetBetNum()
		self:stopResultEffect()
		--上分下分
		self:setBtnAddAndReduceEnable(true)
		--判断是否大于30局
		if baccarat_manager.statisticsData.score then
			if baccarat_manager.statisticsData.score >= 30 then
				if baccarat_manager.curBetChipsMap[3] ~= nil then baccarat_manager.curBetChipsMap[3] = nil end
				if baccarat_manager.curBetChipsMap[7] ~= nil then baccarat_manager.curBetChipsMap[7] = nil end
			end
		end
		baccarat_manager._continueChips = baccarat_manager.curBetChipsMap
		--当前玩家下注的筹码
		baccarat_manager.curBetChipsMap = {}
		--所有下注的筹码
		baccarat_manager.totalBetChipsMap = {}
	elseif baccarat_manager._state == 4 then
		self.panel_ui.CardXipai:setVisible(false)
		self.panel_ui.ImgBackCard:setVisible(false)
		self.panel_ui.imgBackCardOne:setVisible(false)
		self.panel_ui.LoadingBar_BackCard:setVisible(false)
		self.shuffle_ui:setVisible(true)
		self.shuffle_ui:shuffleCards()
	end
end

--播放开奖动画 
function CBaccaratMainScene:playResultEffect(list)
	for i,v in pairs(self.imgMaskList) do
		v:stopAllActions()
		v:setVisible(false)
	end
	for k,v in pairs(list) do
		self.imgMaskList[v+1]:runAction(cc.RepeatForever:create(cc.Blink:create(1,1)))
	end
end

--停止开奖动画
function CBaccaratMainScene:stopResultEffect()
	for i,v in pairs(self.imgMaskList) do
		v:stopAllActions()
		v:setVisible(false)
	end
end


function CBaccaratMainScene:sendCardStage(tipsCards)
	if tipsCards.leftNum == 2 then
		self.sprCardList[5]:setVisible(true)
		self.sprCardList[6]:setVisible(true)
	elseif tipsCards.leftNum == 1 then
		self.sprCardList[6]:setVisible(true)
	else
		--todo
	end
	self.palyerCards = {}
	self.bankerCards = {}
	self.cardIndex = tipsCards.cardIndex
	for k,v in pairs(tipsCards.cardsInfo) do
		if v.id == 0 then
			self.bankerCards = v.cards
			self.bankerPoint = v.point
		else
			self.palyerCards = v.cards
			self.palyerPoint = v.point
		end
	end

	local cardsList = {}

	local startPos = cc.p(1517,967)
	for i=1,2 do
		if self.palyerCards[i] ~= nil then
			if i == 1 then
				if tipsCards.leftNum == 2 then
					startPos = gambleCardEndPos[1]
				elseif tipsCards.leftNum == 1 then
					startPos = gambleCardEndPos[2]
				end
			end
			local temp = {cardId = self.palyerCards[i],res = baccarat_card_data[self.palyerCards[i]].card_big,startPos = startPos,endPos = playerCardEndPos[i],node = self.sprPlayerCards[i]}
			table.insert(cardsList, temp)
		end
		if self.bankerCards[i] ~= nil then
			if  i == 1 and tipsCards.leftNum == 2 then
				startPos = gambleCardEndPos[2]
			end
			local temp = {cardId = self.bankerCards[i],res = baccarat_card_data[self.bankerCards[i]].card_big,startPos = startPos,endPos = bankerCardEndPos[i],node = self.sprBankerCards[i]}
			table.insert(cardsList, temp)
		end
	end

	for i=1,2 do
		local temp = {cardId = 52,res = baccarat_card_data[52].card_big,startPos = startPos,endPos = gambleCardEndPos[i],node = self.sprGambleCards[i]}
		table.insert(cardsList, temp)
	end

	local gambleCardList = {}
	if self.palyerCards[3] ~= nil then
		local temp = {cardId = self.palyerCards[3],gamble = 1,res = baccarat_card_data[self.palyerCards[3]].card_sm,startPos = gambleCardEndPos[1],endPos = playerCardEndPos[3],node = self.sprPlayerCards[3]}
		table.insert(gambleCardList, temp)
	end

	if self.bankerCards[3] ~= nil then
		local startPos = gambleCardEndPos[1]
		if self.palyerCards[3] ~= nil then
			startPos = gambleCardEndPos[2]
		end
		local temp = {cardId = self.bankerCards[3],gamble = 2,res = baccarat_card_data[self.bankerCards[3]].card_sm,startPos = startPos,endPos = bankerCardEndPos[3],node = self.sprBankerCards[3]}
		table.insert(gambleCardList, temp)
	end

	if tipsCards.yellowCard ~= 0 then
		local temp = {cardId = 53,res = nil,startPos = startPos,endPos = yellowCardEndPos,node = self.panel_ui.CardXipai}
		table.insert(cardsList,tipsCards.yellowCard+tipsCards.leftNum,temp)
	end
	
	local sendCardsCallBack = function ()
		for k,v in pairs(cardsList) do
			local function sendCard()
				v.node:setVisible(true)
				if v.cardId ~= 53 then
					--翻牌音效
					audio_manager:playOtherSound(2)
					local sprFrame = display.newSpriteFrame(v.res)
					v.node:setSpriteFrame(sprFrame)
					v.node:setVisible(true)
				end
			end
			performWithDelay(v.node, function ()
				self:showSendHandCardAction(v.cardId == 53,v.startPos,v.endPos, sendCard)
			end, 0.5*(k-1))
		end
	end

	local sendGambleCardCallBack = function ()
		local function delay_call()
			self:showBlance(true)
		end
		if table.nums(gambleCardList) > 0 then
			local send_first = function ()
				local firstData = gambleCardList[1]
				local function sendCard()
					firstData.node:setVisible(true)
					if firstData.cardId ~= 53 then
						--翻牌音效
						audio_manager:playOtherSound(2)
						local sprFrame = display.newSpriteFrame(firstData.res)
						firstData.node:setSpriteFrame(sprFrame)
						firstData.node:setVisible(true)
					end
				end

				self.sprGambleEffect[firstData.gamble]:setVisible(true)
				function callback()
					self.sprGambleEffect[firstData.gamble]:setVisible(false)
				end
				--博牌时音效
				audio_manager:playOtherSound(28, false)
				self.sprGambleEffect[firstData.gamble]:runAction(cc.Sequence:create(cc.Blink:create(2, 8),cc.CallFunc:create(callback)))
				self:showSendGambleCardAction(firstData.startPos,firstData.endPos, sendCard)
			end

			local send_second = function ()
				if gambleCardList[2] then
					local secondData = gambleCardList[2]
					local function sendCard()
						secondData.node:setVisible(true)
						if secondData.cardId ~= 53 then
							local sprFrame = display.newSpriteFrame(secondData.res)
							secondData.node:setSpriteFrame(sprFrame)
							secondData.node:setVisible(true)
						end
						self:runAction(cc.Sequence:create(cc.DelayTime:create(2),cc.CallFunc:create(delay_call)))
						--发牌音效
						-- audio_manager:playOtherSound(5)
					end
					self.sprGambleEffect[secondData.gamble]:setVisible(true)
					function callback()
						self.sprGambleEffect[secondData.gamble]:setVisible(false)
					end
					--博牌时音效
					audio_manager:playOtherSound(28, false)
					self.sprGambleEffect[secondData.gamble]:runAction(cc.Sequence:create(cc.Blink:create(2, 8),cc.CallFunc:create(callback)))
					self:showSendGambleCardAction(secondData.startPos,secondData.endPos, sendCard)
				else
					self:runAction(cc.Sequence:create(cc.DelayTime:create(2),cc.CallFunc:create(delay_call)))
				end
			end

			local seq_lst = {}
			table.insert(seq_lst,cc.CallFunc:create(send_first))
			table.insert(seq_lst,cc.DelayTime:create(3))
			table.insert(seq_lst,cc.CallFunc:create(send_second))
			local seq_act = cc.Sequence:create(seq_lst)
			self:runAction(seq_act)
		else
			self:runAction(cc.Sequence:create(cc.DelayTime:create(2),cc.CallFunc:create(delay_call)))
		end
	end

	local seq_arr = {}
	table.insert(seq_arr,cc.CallFunc:create(sendCardsCallBack))
	table.insert(seq_arr,cc.DelayTime:create(5))
	table.insert(seq_arr,cc.CallFunc:create(sendGambleCardCallBack))
	local seq = cc.Sequence:create(seq_arr)
	self:runAction(seq)
end

--结算
function CBaccaratMainScene:showBlance(bShow)
	if bShow then
		local function showBlanceCall()
			if baccarat_manager.result then
				self.panel_ui.sprSettle:setTexture(settleRes[baccarat_manager.result[1]+1])
				local str = (long_compare(baccarat_manager.chipsChange,0) >= 0) and "+" or ""
				self.panel_ui.fntSettle:setString(str ..baccarat_manager.chipsChange)
				self.panel_ui.sprSettle:setVisible(true)
				self.panel_ui.fntSettle:setVisible(true)
				self.panel_ui.sprSettle:setScale(0.2)
				self.panel_ui.fntSettle:setScale(0.2)
				local spr_scale_act = cc.ScaleTo:create(0.5,1,1)
				local fnt_scale_act = cc.ScaleTo:create(0.5,1,1)
				self.panel_ui.sprSettle:runAction(spr_scale_act)
				self.panel_ui.fntSettle:runAction(fnt_scale_act)
				self:playResultEffect(baccarat_manager.result)

				local playerInfo = get_player_info()
				--胜利失败音效
				audio_manager:playPlayerSound((long_compare(baccarat_manager.chipsChange,0) > 0) and math.random(1,2) or math.random(3,4), (playerInfo.sex == "男") and 0 or 1)

				self:updateChips()
				self.alone_ui:showCurSelect()
				self.alone_ui:updateStatistics()
			end
		end

		--闲家点数音效
		local function playerMuicCall()
			if self.palyerPoint then
				audio_manager:playOtherSound(8+tonumber(self.palyerPoint), false)
			end
		end
		
		--闲家点数音效
		local function bankerMuicCall()
			if self.palyerPoint then
				audio_manager:playOtherSound(18+tonumber(self.bankerPoint), false)
			end
		end

		local seq_arr = {}
		table.insert(seq_arr,cc.CallFunc:create(playerMuicCall))
		table.insert(seq_arr,cc.DelayTime:create(1))
		table.insert(seq_arr,cc.CallFunc:create(bankerMuicCall))
		table.insert(seq_arr,cc.DelayTime:create(1))
		table.insert(seq_arr,cc.CallFunc:create(showBlanceCall))
		local seq = cc.Sequence:create(seq_arr)
		self:runAction(seq)
	else
		self.panel_ui.sprSettle:setVisible(false)
		self.panel_ui.fntSettle:setVisible(false)
	end
	
end

--清理牌
function CBaccaratMainScene:cleanCard()
	local cleanCards = {}
	if table.nums(self.palyerCards) > 0 then
		for k,v in pairs(self.palyerCards) do
			self.sprPlayerCards[k]:runAction(cc.ScaleTo:create(-1,1,1))
			self.sprPlayerCards[k]:setVisible(false)
			local imgFrame = display.newSpriteFrame(baccarat_card_data[52].card_big)
			-- if k == 3 then
			-- 	imgFrame = display.newSpriteFrame(baccarat_card_data[52].card_sm)
			-- end
    		local imgCard = cc.Sprite:createWithSpriteFrame(imgFrame)
    		imgCard:setPosition(playerCardEndPos[k])
    		self.panel_ui.ImgBj:addChild(imgCard)
    		table.insert(cleanCards,imgCard)
		end
	end
	if table.nums(self.bankerCards) > 0 then
		for k,v in pairs(self.bankerCards) do
			self.sprBankerCards[k]:runAction(cc.ScaleTo:create(-1,1,1))
			self.sprBankerCards[k]:setVisible(false)
			local imgFrame = display.newSpriteFrame(baccarat_card_data[52].card_big)
			-- if k == 3 then
			-- 	imgFrame = display.newSpriteFrame(baccarat_card_data[52].card_sm)
			-- end
    		local imgCard = cc.Sprite:createWithSpriteFrame(imgFrame)
    		imgCard:setPosition(bankerCardEndPos[k])
    		self.panel_ui.ImgBj:addChild(imgCard)
    		table.insert(cleanCards,imgCard)
		end
	end
	self.palyerCards = {}
	self.bankerCards = {}

	if table.nums(cleanCards) > 0 then
		for k,imgCard in pairs(cleanCards) do
			if imgCard ~= nil then 
				local params = {}
				local endPos = disuseCardEndPos 
				params.endPos_x,params.endPos_y = self.panel_ui.imgBackCardOne:getPosition()--endPos.x,endPos.y
		        params.flyendCallback = function ()
					imgCard:removeFromParent()
					imgCard = nil
				end
				CFlyAction:Fly(imgCard, 1, params, CFlyAction.FLY_TYPE_CHIPS)
			end
		end
	end

	local percent = (tonumber(self.cardIndex) / 416) 
	print("percent === " ..percent)
	self.panel_ui.LoadingBar_BackCard:setVisible(true)
	self.panel_ui.LoadingBar_BackCard:setPercent(percent * 100)
	self.panel_ui.imgBackCardOne:setPositionY(200 * percent + 680)
	self.panel_ui.imgBackCardOne:setVisible(true)
	cleanCards = {}
end

--切牌
function CBaccaratMainScene:sendCutCard()
	print("切牌")
	dump(baccarat_manager.cutCardList)
	self.panel_ui.ImgBackCard:setVisible(true)
	for k,v in pairs(self.sprGambleCards) do
		v:setVisible(false)
	end
	local cleanCards = {}
	if baccarat_manager.cutCardList ~= nil then
		local num = table.nums(baccarat_manager.cutCardList)
		local function send_fist()
			local function sendCard()
				local sprFrame = display.newSpriteFrame(baccarat_card_data[baccarat_manager.cutCardList[1]].card_big)
				self.sprCutCardList[1]:setSpriteFrame(sprFrame)
				self.sprCutCardList[1]:setVisible(true)
			end
			self:showSendCutCardAction(cc.p(cardEndPosArr[1].x,cardEndPosArr[1].y), sendCard)
		end
		local function send_follow()
			for i=2,num do
				local function sendCard()
					local sprFrame = display.newSpriteFrame(baccarat_card_data[baccarat_manager.cutCardList[i]].card_big)
					self.sprCutCardList[i]:setSpriteFrame(sprFrame)
					self.sprCutCardList[i]:setVisible(true)
				end
				performWithDelay(self.sprCutCardList[i], function ()
					self:showSendCutCardAction(cc.p(cardEndPosArr[i].x,cardEndPosArr[i].y), sendCard)
				end, 0.2*(i-1))
				
			end
		end
		local function clean_call()
			for k,v in pairs(self.sprCutCardList) do
				v:setVisible(false)
			end
			for i=1,num do
				local sprite = cc.Sprite:create()
				local sprFrame = display.newSpriteFrame(baccarat_card_data[52].card_big)
				sprite:setSpriteFrame(sprFrame)
				sprite:setPosition(cardEndPosArr[i].x,cardEndPosArr[i].y)
				self.panel_ui.ImgBj:addChild(sprite)
				table.insert(cleanCards,sprite)
			end
			if table.nums(cleanCards) > 0 then
				for k,imgCard in pairs(cleanCards) do
					if imgCard ~= nil then 
						local params = {}
						local endPos = disuseCardEndPos 
						params.endPos_x,params.endPos_y = endPos.x,endPos.y
				        params.flyendCallback = function ()
							imgCard:removeFromParent()
							imgCard = nil
						end
						CFlyAction:Fly(imgCard, 1, params, CFlyAction.FLY_TYPE_CHIPS)
					end
				end
			end

			local percent = (tonumber(num) / 416) 
			self.panel_ui.LoadingBar_BackCard:setVisible(true)
			self.panel_ui.LoadingBar_BackCard:setPercent(percent * 100)
			self.panel_ui.imgBackCardOne:setPositionY(200 * percent + 745)
			self.panel_ui.imgBackCardOne:setVisible(true)
			cleanCards = {}
		end

		local seq_arr = {}
		table.insert(seq_arr,cc.CallFunc:create(send_fist))
		table.insert(seq_arr,cc.DelayTime:create(2))
		table.insert(seq_arr,cc.CallFunc:create(send_follow))
		table.insert(seq_arr,cc.DelayTime:create(7))
		table.insert(seq_arr,cc.CallFunc:create(clean_call))
		local seq = cc.Sequence:create(seq_arr)
		self:runAction(seq)

	end
end

--播放发牌动作
function CBaccaratMainScene:showSendHandCardAction(bIsYellowCard,startPos,endPos, callback)
	local imgBackCard = nil 
	if bIsYellowCard then
		imgBackCard = cc.Sprite:create("game/baccarat_std/resource/image/fgz.png")
	else
		local imgFrame = display.newSpriteFrame(baccarat_card_data[52].card_big)
    	imgBackCard = cc.Sprite:createWithSpriteFrame(imgFrame)
	end
	if imgBackCard then
		self.panel_ui.ImgBj:addChild(imgBackCard)
	    imgBackCard:setPosition(startPos)
	    --发牌音效
		audio_manager:playOtherSound(3, false)

	    if (startPos.x == gambleCardEndPos[1].x) and (startPos.y == gambleCardEndPos[1].y) then
	    	self.sprGambleCards[1]:setVisible(false)
    	elseif (startPos.x == gambleCardEndPos[2].x) and (startPos.y == gambleCardEndPos[2].y) then
	    	self.sprGambleCards[2]:setVisible(false)
	    end
	    if endPos.x == disuseCardEndPos.x then
	    	self:playSendCardEffect(2)
	    else
	    	self:playSendCardEffect(1)
		end

	    local scaleAction = cc.ScaleTo:create(1,-1,1)
	    if endPos.x == gambleCardEndPos[1].x or endPos.x == gambleCardEndPos[2].x then
	    	scaleAction = cc.ScaleTo:create(0.1,1)
		end
	    local moveAction = cc.MoveTo:create(SEND_CARD_SPEED, endPos)
	    local call_action = cc.CallFunc:create(function (node)
			node:stopAllActions() 
			node:removeFromParent()
			node = nil

	    	callback()
	    end)

	    local seq = cc.Sequence:create({moveAction,scaleAction, call_action})
	    imgBackCard:runAction(seq)
	end
end

--播放发牌特效
function CBaccaratMainScene:playSendCardEffect(effectType)
	local effecName = baccarat_manager._cardEffectTypeList[effectType]
	self.sendCardEffect = animationUtils.createAndPlayAnimation(self.panel_ui.nodeSendCardEffect, baccarat_effect_config[effecName], nil)
	self.sendCardEffect:setAnchorPoint(cc.p(0.5,0.5))
end

--播放发博牌动作
function CBaccaratMainScene:showSendGambleCardAction(startPos,endPos, callback)
	local imgFrame = display.newSpriteFrame(baccarat_card_data[52].card_sm)
	local imgBackCard = cc.Sprite:createWithSpriteFrame(imgFrame)
	self.panel_ui.ImgBj:addChild(imgBackCard)
    imgBackCard:setPosition(startPos)

    if (startPos.x == gambleCardEndPos[1].x) and (startPos.y == gambleCardEndPos[1].y) then
    	self.sprGambleCards[1]:setVisible(false)
	elseif (startPos.x == gambleCardEndPos[2].x) and (startPos.y == gambleCardEndPos[2].y) then
    	self.sprGambleCards[2]:setVisible(false)
    end
    local scaleAction = cc.ScaleTo:create(1,1,-1)
    local moveAction = cc.MoveTo:create(SEND_CARD_SPEED, endPos)
    local call_action = cc.CallFunc:create(function (node)
		node:stopAllActions() 
		node:removeFromParent()
		node = nil
    	callback()
    end)

    local seq = cc.Sequence:create({moveAction,scaleAction, call_action})
    imgBackCard:runAction(seq)
end

--播放发切牌动作
function CBaccaratMainScene:showSendCutCardAction(endPos, callback)
	local imgFrame = display.newSpriteFrame(baccarat_card_data[52].card_big)
	local imgBackCard = cc.Sprite:createWithSpriteFrame(imgFrame)
	self.panel_ui.ImgBj:addChild(imgBackCard)
    imgBackCard:setPosition(cc.p(1800,987))
    local scaleAction = cc.ScaleTo:create(0.2,-1,1)
    local moveAction = cc.MoveTo:create(SEND_CARD_SPEED, endPos)
    local call_action = cc.CallFunc:create(function (node)
		node:stopAllActions() 
		node:removeFromParent()
		node = nil

    	callback()
    end)

    local seq = cc.Sequence:create({moveAction,scaleAction, call_action})
    imgBackCard:runAction(seq)
end



function CBaccaratMainScene:registerGroupEvent(obj_lst,call_back)
	-- body
	for k,v in pairs(obj_lst) do
		self.btn_group_info_lst[v] = {call = call_back,mutex = obj_lst,}
		local function __on_group_deal_pro(sender,event_type)
			self:onGroupDealPro(sender,event_type)
		end
		v:addEventListener(__on_group_deal_pro)
	end
end


function CBaccaratMainScene:onGroupDealPro(sender,event_type)
	for k,v in pairs(self.btn_group_info_lst[sender].mutex) do
		if sender ~= v then
			-- v:setEnabled(true)
			v:setSelected(false)
			-- v:setBright(true)
		else
			-- v:setEnabled(false)
			v:setSelected(true)
		end
	end

	--回调函数最后处理
	local func = self.btn_group_info_lst[sender].call
	if func then 
		func(sender,event_type) 
		return
	end
end

function CBaccaratMainScene:regTouch()
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

function CBaccaratMainScene:onTouchEnded(touch, event)
	local a,b = self.panel_ui.imgXianBLPanel:getPosition()
	local pos = self.panel_ui.imgXianBLPanel:convertToWorldSpace(cc.p(a,b))
	local boundingBox = self.panel_ui.imgXianBLPanel:getBoundingBox()
	boundingBox.x = pos.x
	boundingBox.y = pos.y
	local pt = cc.Director:getInstance():convertToGL(touch:getLocation())
	if cc.rectContainsPoint(boundingBox, pt) ~= true then
		if self.bIsShowXianBLPanel then
			self.bIsShowXianBLPanel = false
			self.panel_ui.imgXianBLPanel:setVisible(false)
			self.panel_ui.imgXianBLPanel:setTouchEnabled(false)
		end
		if self.bIsShowZhuangBLPanel then
			self.bIsShowZhuangBLPanel = false
			self.panel_ui.imgZhuangBLPanel:setVisible(false)
			self.panel_ui.imgZhuangBLPanel:setTouchEnabled(false)
		end
	end
end

--更新当前局数
function CBaccaratMainScene:updateNumberOfGames()
	if baccarat_manager.statisticsData.score then
		self.panel_ui.fntTimeNum:setString(baccarat_manager.statisticsData.score+1)
	end
end