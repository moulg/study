local sideResPathlist = {"game/bairenniuniu_std/resource/image/1.png",
	"game/bairenniuniu_std/resource/image/2.png",
	"game/bairenniuniu_std/resource/image/3.png",
	"game/bairenniuniu_std/resource/image/4.png",
	"game/bairenniuniu_std/resource/image/5.png",
	"game/bairenniuniu_std/resource/image/6.png",
	"game/bairenniuniu_std/resource/image/7.png",
	"game/bairenniuniu_std/resource/image/8.png",}
local recordResPathlist = {"game/bairenniuniu_std/resource/image/XX.png","game/bairenniuniu_std/resource/image/gg.png",}
--发牌终点坐标
local cardEndPosArr = {{x = 432, y = 476}, {x = 680, y = 476}, {x = 936, y = 476}, {x = 1188, y = 476}, {x = 806, y = 620}}	
--发牌速度
local SEND_CARD_SPEED = 0.2  
local panel_ui = require "game.bairenniuniu_std.script.ui_create.ui_bairenniuniu_main"

CBaiRenNiuNiuMainScene = class("CBaiRenNiuNiuMainScene", function ()
	local ret = cc.Node:create()
	return ret		
end)

ModuleObjMgr.add_module_obj(CBaiRenNiuNiuMainScene,"CBaiRenNiuNiuMainScene")
-- CBaiRenNiuNiuMainScene.GAME_STEP = GAME_STEP

function CBaiRenNiuNiuMainScene.create()
	local node = CBaiRenNiuNiuMainScene.new()
	if node ~= nil then
		-- node:init_ui()
		node:loading()
		node:regEnterExit()
		node:regTouch()
		return node
	end
end

function CBaiRenNiuNiuMainScene:loading()
    self.isLoadEnd = false
	local info = {
		parent 			= WindowScene.getInstance().game_layer,
		task_call 		= function (percent,index,texture) self:addImageSrc(percent,index,texture) end,
		complete_call 	= function () self:loadEnded() end,
		--task_lst = {[x] = {src = "",},},
		ui_info = {
			back_pic 		= "game/bairenniuniu_std/resource/image/loading.jpg",
			bar_back_pic 	= "game/bairenniuniu_std/resource/image/loadbg.png",
			bar_process_pic = "game/bairenniuniu_std/resource/image/loadt.png",
			b_self_release 	= true,
			bar_Pos 		= cc.p(960,170)
		},
	}

	info.task_lst = {}
	for i=1,#bairenniuniu_effect_res_config do
		local item = {src = bairenniuniu_effect_res_config[i].imageName,}
		info.task_lst[i] = item
	end
	self._loadingTask = LoadingTask.create(info)
end

function CBaiRenNiuNiuMainScene:addImageSrc(percent,index,texture)
	-- print("index = " .. index .. ",plist path  = " .. bairenniuniu_effect_res_config[index].plistPath)
	local cache = cc.SpriteFrameCache:getInstance()
	cache:addSpriteFrames(bairenniuniu_effect_res_config[index].plistPath)
end

function CBaiRenNiuNiuMainScene:regEnterExit()
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

function CBaiRenNiuNiuMainScene:onEnter()
	audio_manager:reloadMusicByConfig(bairenniuniu_music_config)
	local cache = cc.SpriteFrameCache:getInstance()
    -- for k,v in pairs(bairenniuniu_effect_res_config) do
    -- 	cache:addSpriteFrames(v.plistPath)
    -- end
    -- 记录
	-- bairenniuniu_manager._record = {}
 	--显示倒数计时
	self.schedulHandler = scheduler:scheduleScriptFunc(handler(self,self.updateCountdownAndState),1,false)
	--每个区域下注的每种类型筹码个数
	bairenniuniu_manager._numberList = {[1] = {0,0,0,0,0,0,0,0},
									    [2] = {0,0,0,0,0,0,0,0},
									    [3] = {0,0,0,0,0,0,0,0},
									    [4] = {0,0,0,0,0,0,0,0},
									}
end

function CBaiRenNiuNiuMainScene:onExit()
	audio_manager:destoryAllMusicRes()
	local cache = cc.SpriteFrameCache:getInstance()
    for k,v in pairs(bairenniuniu_effect_res_config) do
    	cache:removeSpriteFramesFromFile(v.plistPath)
    end
	if self.schedulHandler ~=nil then
		scheduler:unscheduleScriptEntry(self.schedulHandler)
		self.schedulHandler = nil
	end
	--check button 组处理
	self.btn_group_info_lst = {}
	--申请列表
	bairenniuniu_manager._applyListData = {}
	--成绩
	bairenniuniu_manager._playerScore = 0
	--当前玩家下注的筹码
	bairenniuniu_manager.curBetChipsMap = {}
	--庄家筹码的变化
	bairenniuniu_manager._bankerChipschanges = 0
	--玩家筹码变化
	bairenniuniu_manager._playerChipschanges = 0
	--用于记录当前玩家在每个区域下注的用于续押的总筹码数
	bairenniuniu_manager._continueChips = nil
	--申请坐庄排队列表
	bairenniuniu_manager._applyListData = {}
	--成绩
	bairenniuniu_manager._playerScore = 0 
	--记录
	bairenniuniu_manager._record = {}
	--重置选择筹码小图标
	bairenniuniu_manager._selectChipsType = nil
	--每个区域下注的每种类型筹码个数
	bairenniuniu_manager._numberList = {[1] = {0,0,0,0,0,0,0,0},
									    [2] = {0,0,0,0,0,0,0,0},
									    [3] = {0,0,0,0,0,0,0,0},
									    [4] = {0,0,0,0,0,0,0,0},
									}
	bairenniuniu_manager._countdown = 0
	bairenniuniu_manager._state = 1
end

function CBaiRenNiuNiuMainScene:destoryLoading()
	if self._loadingTask then
    	self._loadingTask:forcedDestory()
        self._loadingTask = nil
    end
end
function CBaiRenNiuNiuMainScene:loadEnded()
	print("loadEnded>>>>>>>")
	self._loadingTask = nil
    self.isLoadEnd = true
	self:init_ui()    
    self:registerHandler()
	self:initData()
	self:resetGame()
	self:updatePlayerInfo()
	self:updateBankerInfo()
	self:updateRecord(bairenniuniu_manager._record)--更新历史记录
	
	if table.nums(bairenniuniu_manager.totalBetChipsInfo) > 0 and bairenniuniu_manager._state == 2 then
		print("添加下已经注筹码图片>>>>>>>>>>>")
	    for k,v in pairs(bairenniuniu_manager.totalBetChipsInfo) do
	    	dump(v)
	    	self:addBetChips(v.area,v.chips,0)
	    	self.fntTotalBetChipsList[v.area]:setString(v.chips)
	    	self.fntTotalBetChipsList[v.area]:setVisible(true)
	    	bairenniuniu_manager.totalBetChipsMap[v.area] = v.chips
	    end
	end
    --背景音乐
	audio_manager:playBackgroundMusic(1, true)
    local _playerInfo = get_player_info()
    local userConfig = get_user_config()
	local gameSetData = userConfig[_playerInfo.curGameID]
	if gameSetData then
		audio_manager:setMusicVolume(gameSetData.musicVol)
	end
end

--初始化UI
function CBaiRenNiuNiuMainScene:init_ui()
	-- self:resetGame()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)


	--历史记录面板
	self.recordPanel= CBaiRenNiuNiuRecord.create()
	self:addChild(self.recordPanel)
	--self.recordPanel:setPosition(0,0)
	--self.recordPanel:setAnchorPoint(0,0)
	self.panel_ui.BtnLsjlb:onTouch(function (e)
		if e.name == "ended" then
			self.recordPanel:showHidePanel()
		end
	end)

	--菜单界面
	--self.controlPanel= CBaiRenNiuNiuControl.create()
	--self:addChild(self.controlPanel)
	--self.controlPanel:setPosition(0,0)
	--self.controlPanel:setAnchorPoint(0,0)
	--申请坐庄列表界面
	self.applyListPanel = CBaiRenNiuNiuApplyList.create()
	self:addChild(self.applyListPanel)
	self.applyListPanel:setPosition(0,0)
	self.applyListPanel:setAnchorPoint(0,0)
	self.panel_ui.BtnShangz:onTouch(function (e)
		if e.name == "ended" then
			self.applyListPanel:showHidePanel()
		end
	end)

	--添加5组牌
	self.cardItemList = {CBaiRenNiuNiuCardItem.create(1), CBaiRenNiuNiuCardItem.create(2),
					  CBaiRenNiuNiuCardItem.create(3), CBaiRenNiuNiuCardItem.create(4),CBaiRenNiuNiuCardItem.create(5)}
  	for k,v in pairs(self.cardItemList) do
  		self.panel_ui.carItemNode:addChild(v,10)
  	end
	
	--添加高亮
	-- self:addButtonHightLight()

	--下注筹码放置节点
	self.nodeBetList = {self.panel_ui.NodeChips1,self.panel_ui.NodeChips2,self.panel_ui.NodeChips3,self.panel_ui.NodeChips4,}
	--下注区域按钮
	self.btnSelectedList = {self.panel_ui.BtnSelected1,self.panel_ui.BtnSelected2,self.panel_ui.BtnSelected3,self.panel_ui.BtnSelected4,}
	for i,v in pairs(self.btnSelectedList) do
		v:setTag(i)
	end
	self.fntTotalBetChipsList = {self.panel_ui.FntBetTotal1,self.panel_ui.FntBetTotal2,self.panel_ui.FntBetTotal3,self.panel_ui.FntBetTotal4,}
	self.fntCurBetChipsList = {self.panel_ui.FntBetMy1,self.panel_ui.FntBetMy2,self.panel_ui.FntBetMy3,self.panel_ui.FntBetMy4,}
	self.imgTotalBetBgList = {self.panel_ui.imgTotalBetBg1,self.panel_ui.imgTotalBetBg2,self.panel_ui.imgTotalBetBg3,self.panel_ui.imgTotalBetBg4,}

	self:resetBetNum()

	--check button 组处理
	self.btn_group_info_lst = {}
	--筹码按钮
	self.btnBetList = {self.panel_ui.btnBet1,self.panel_ui.btnBet2,self.panel_ui.btnBet3, self.panel_ui.btnBet4,
						self.panel_ui.btnBet5,self.panel_ui.btnBet6,self.panel_ui.btnBet7,self.panel_ui.btnBet8,}
	for i,v in pairs(self.btnBetList) do
		v:setEnabled(false)
		v:setBright(false)
	end
	self:registerGroupEvent(self.btnBetList,function (s,e) self:betButtonHandler(s,e) end)

	self.nodeOtherPlayerList = {self.panel_ui.NodeOtherPlayerChips1,self.panel_ui.NodeOtherPlayerChips2,self.panel_ui.NodeOtherPlayerChips3,}

	self.bIsShowCardPanel = false
	-- self.bIsShowCaidanPanel = false
	self.panel_ui.LabBetBg:setVisible(false)
	self.panel_ui.FntClock:setString(" ")
    self.panel_ui.FntClock:setVisible(false) 
    self.panel_ui.ImgStage:setTexture(" ")
    self.panel_ui.ImgStage:setVisible(false)
end

--设置禁用或启用筹码按钮
function CBaiRenNiuNiuMainScene:setBtnBetEnable(value)
	-- self.panel_ui.LabBetBg:setVisible(true)
	if value then
		for i,v in pairs(self.btnBetList) do
			v:setSelected(false)
			local requireChips = long_multiply(long_plus(self:getTotalBetChips(),10^(8-i)),8)
			if (long_compare(bairenniuniu_manager._ownChips, requireChips) >= 0) then
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
		end
	end
end

--根据当前筹码更新筹码按钮状态
function CBaiRenNiuNiuMainScene:updateBtnChipsState()
	if bairenniuniu_manager._state == 2 then
		for i,v in pairs(self.btnBetList) do
			local requireChips = long_multiply(long_plus(self:getTotalBetChips(),10^(8-i)),8)
			if (long_compare(bairenniuniu_manager._ownChips, requireChips) >= 0) then
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

--设置禁用或启用下注区域按纽
function CBaiRenNiuNiuMainScene:setBtnSelectEnable(value)
	for k,v in pairs(self.btnSelectedList) do
		v:setEnabled(value)
		v:setBright(value)
	end
end

--设置禁用或启用兑换按钮
function CBaiRenNiuNiuMainScene:setBtnDuihEnable(value)
	self.panel_ui.BtnDuih:setEnabled(value)	
	self.panel_ui.BtnDuih:setBright(value)
end
--设置禁用下分按钮
function CBaiRenNiuNiuMainScene:setReduceEnable(value)

end

--重置显示下注的数字
function CBaiRenNiuNiuMainScene:resetBetNum()
	for i=1,4 do
		self.fntTotalBetChipsList[i]:setString("")
		self.fntCurBetChipsList[i]:setString("")
		self.fntTotalBetChipsList[i]:setVisible(false)
		self.fntCurBetChipsList[i]:setVisible(false)
		self.imgTotalBetBgList[i]:setVisible(false)
	end
end

--判断当前筹码是否可以续押
function CBaiRenNiuNiuMainScene:calculateContinue()
	if (self.applyListPanel:isBanker() ~= true) and (bairenniuniu_manager._state == 2) then
		if (bairenniuniu_manager._continueChips ~= nil) and (table.nums(bairenniuniu_manager._continueChips) > 0) then
			local totalContinueChips = self:getContinueBetRequireChips()
			local requireChips = long_multiply(long_plus(totalContinueChips,self:getTotalBetChips()),8)
	
			if long_compare(bairenniuniu_manager._ownChips, requireChips) >= 0 then 
				self.panel_ui.BtnContinue:setEnabled(true)
				self.panel_ui.BtnContinue:setBright(true)
			else
				self.panel_ui.BtnContinue:setEnabled(false)
				self.panel_ui.BtnContinue:setBright(false)
			end	
		else
			self.panel_ui.BtnContinue:setEnabled(false)
			self.panel_ui.BtnContinue:setBright(false)
		end
	else
		self.panel_ui.BtnContinue:setEnabled(false)
		self.panel_ui.BtnContinue:setBright(false)
	end
end

--获取续押的筹码总数
function CBaiRenNiuNiuMainScene:getContinueBetRequireChips()
	local continueRequireChips = 0
	if bairenniuniu_manager._continueChips then
		for k,v in pairs(bairenniuniu_manager._continueChips) do
			continueRequireChips = long_plus(continueRequireChips,v)
		end
	end
	return continueRequireChips
end


function CBaiRenNiuNiuMainScene:init_after_enter()
	print("init_after_enter")
    self:registerHandler()
	self:initData()	
	self:updatePlayerInfo()
	self:updateBankerInfo()
    --背景音乐
	audio_manager:playBackgroundMusic(1, true)
    local _playerInfo = get_player_info()
    local userConfig = get_user_config()
	local gameSetData = userConfig[_playerInfo.curGameID]
	if gameSetData then
		audio_manager:setMusicVolume(gameSetData.musicVol)
	end
end

--更新玩家信息
function CBaiRenNiuNiuMainScene:updatePlayerInfo()
	local playerInfo = get_player_info()
	local playerSex = playerInfo.sex
	if playerSex == "男"then
		playerSex = 0
	else
		playerSex = 1
	end	
	self.panel_ui.LabPlayerGold:setString(bairenniuniu_manager._ownChips)
	self.panel_ui.LabPlayerName:setString(playerInfo.name)
	uiUtils:setPlayerHead(self.panel_ui.Img_PlayerHead, playerSex, uiUtils.HEAD_SIZE_115)
end

--更新庄家信息
function CBaiRenNiuNiuMainScene:updateBankerInfo()
	-- dump(bairenniuniu_manager._bankerInfo)
	if table.nums(bairenniuniu_manager._bankerInfo) > 0 then
		local bankerSex = bairenniuniu_manager._bankerInfo.sex
		if bankerSex == 3 then
			bankerSex = 2
		end
		-- dump()
		if long_compare(bairenniuniu_manager._bankerInfo.playerId, 0 ) >  0 then
			-- dump(bairenniuniu_manager._bankerInfo)
			-- local playerInfo = get_player_info()
			-- local playerSex = playerInfo.sex
			-- if playerSex == "男"then
			-- 	playerSex = 0
			-- else
			-- 	playerSex = 1
			-- end
			-- local playerId = get_player_info().id
			
			-- if playerId == bairenniuniu_manager._bankerInfo.playerId then
			-- 	bankerSex = playerSex
			-- end
			self.panel_ui.LabBankerName:setString(bairenniuniu_manager._bankerInfo.name)
			self.panel_ui.LabBankerGold:setString(bairenniuniu_manager._bankerInfo.chips)
			--self.panel_ui.Image_cm1:loadTexture("game/bairenniuniu_std/resource/image/cm.png")
			uiUtils:setPlayerHead(self.panel_ui.Img_BankerHead, bankerSex, uiUtils.HEAD_SIZE_115)
			self.panel_ui.Img_BankerHead:setFlippedX(true)
		else
			-- print("bairenniuniu_manager._bankerInfo.score",bairenniuniu_manager._bankerInfo.score)
			self.panel_ui.LabBankerName:setString(bairenniuniu_manager._bankerInfo.name)
			self.panel_ui.LabBankerGold:setString(bairenniuniu_manager._bankerInfo.score)
			--self.panel_ui.Image_cm1:loadTexture("game/bairenniuniu_std/resource/image/cj.png")
			uiUtils:setPlayerHead(self.panel_ui.Img_BankerHead, bankerSex, uiUtils.HEAD_SIZE_115)
			self.panel_ui.Img_BankerHead:setFlippedX(false)	
		end
	end
end
function CBaiRenNiuNiuMainScene:initData()
	--下注的筹码图片
	self.betChipsImgList = {}
	--所有下注的筹码
	bairenniuniu_manager.totalBetChipsMap = {}
	--当前玩家下注的筹码
	bairenniuniu_manager.curBetChipsMap = {}
	--是否是刚进游戏
	bairenniuniu_manager._bFirstEnter = true

end

--根据状态重置游戏数据
function CBaiRenNiuNiuMainScene:resetGame()
	print("根据状态重置游戏数据")
	-- print("bairenniuniu_manager._state = " ..bairenniuniu_manager._state)
	if bairenniuniu_manager._bFirstEnter == true then
		--显示兑换界面
		if bairenniuniu_manager._state ~= 3 then 
			TipsManager:showExchangePanel(bairenniuniu_manager._ownChips, get_player_info().gold)
		end
		bairenniuniu_manager._bFirstEnter = false
	end
	self.panel_ui.LabBetBg:setVisible(false)
	self:setBtnSelectEnable(false)
	self:setBtnBetEnable(false)
	self:setBtnDuihEnable(false)

	--判断是否可续押
	self:calculateContinue()
	self.applyListPanel:updateApplyListInfo()

	if bairenniuniu_manager._state == 1 then
		--成绩
		bairenniuniu_manager._playerScore = long_plus(bairenniuniu_manager._playerScore, bairenniuniu_manager._playerChipschanges)
		--刷新玩家信息
		self:updatePlayerInfo()
		self:resetBetNum()
		--续押
		bairenniuniu_manager._continueChips = bairenniuniu_manager.curBetChipsMap
		--所有下注的筹码
		bairenniuniu_manager.totalBetChipsMap = {}
		--当前玩家下注的筹码
		bairenniuniu_manager.curBetChipsMap = {}


		--清除牌
		for k,v in pairs(self.cardItemList) do
			v:resetGame()
		end
		--移除结算面板
		self:removeSettleAccountsPanel()
		--当前玩家下注的筹码
		bairenniuniu_manager.curBetChipsMap = {}
		--兑换按钮
		self:setBtnDuihEnable(true)
	elseif bairenniuniu_manager._state == 2 then
		--重置选择筹码小图标
		bairenniuniu_manager._selectChipsType = nil
		--开始下注音效
		audio_manager:playOtherSound(8, false)
		--兑换按钮
		self:setBtnDuihEnable(true)
		--下注阶段禁用下分
		self:setReduceEnable(true)

		--自动续押
		-- self:autoContinueBetHandler()
		--自动退出
		-- self:autoExitHandler()
		if long_compare(bairenniuniu_manager._bankerInfo.playerId, get_player_info().id) == 0 then
			self.panel_ui.LabBetBg:setVisible(false)
		else
			self.panel_ui.LabBetBg:setVisible(true)
		end

		local playerInfo = get_player_info()
		if self.applyListPanel:isBanker() ~= true then
			self:setBtnSelectEnable(true)
			self:setBtnBetEnable(true)
		end		
	elseif bairenniuniu_manager._state == 3 then
		-- print("--------kaijiangshijain------")
		--禁用兑换按钮
		self:setBtnDuihEnable(false)
		bairenniuniu_manager._continueChips = nil	
					
	end
end

--按钮高亮
function CBaiRenNiuNiuMainScene:addButtonHightLight()
	local btnArr = {self.panel_ui.btnBetContinue, self.panel_ui.btnClean,
					self.panel_ui.btnAddChips, self.panel_ui.btnReduceChips,
					self.panel_ui.btnSelected1,self.panel_ui.btnSelected2,
					self.panel_ui.btnSelected3,self.panel_ui.btnSelected4,
				}

	local resArr = {"续押高亮", "清空高亮","上分高亮", "下分高亮","下注区域一",
				"下注区域二","下注区域三","下注区域四",}

	for i,btn in pairs(btnArr) do
		local mov_obj = cc.Sprite:create(bairenniuniu_imgRes_config[resArr[i]].resPath)
		WindowScene.getInstance():registerBtnMouseMoveEff(btn,mov_obj,1)
	end
end


function CBaiRenNiuNiuMainScene:betButtonHandler(sender,event)
	for k,v in pairs(self.btnBetList) do
		if sender == v then

			bairenniuniu_manager._selectChipsType = k
			break
		end
	end
end

--续押
function CBaiRenNiuNiuMainScene:continueBetHandler()
	if bairenniuniu_manager._continueChips then
		local totalContinueChips = self:getContinueBetRequireChips()
		local requireChips = long_multiply(long_plus(totalContinueChips,self:getTotalBetChips()),8)
		--判断当前筹码是否够
		if long_compare(bairenniuniu_manager._ownChips, requireChips) >= 0 then
			for k,v in pairs(bairenniuniu_manager._continueChips) do
				send_bairenniuniu_ReqBet({area = k, chips = v})
			end
		else
			TipsManager:showOneButtonTipsPanel(76, {}, true)
		end 
	end
end

--自动续押
function CBaiRenNiuNiuMainScene:autoContinueBetHandler()
	if self.applyListPanel:isBanker() == false then
    	if (self.panel_ui.btnAutoContinue:isSelected() == true) and (bairenniuniu_manager._continueChips ~= nil) then
    		local totalContinueChips = self:getContinueBetRequireChips()
    		local requireChips = long_multiply(totalContinueChips,8)
			--判断当前筹码是否够
    		if long_compare(bairenniuniu_manager._ownChips, requireChips) >= 0 then
	    		for k,v in pairs(bairenniuniu_manager._continueChips) do
					send_bairenniuniu_ReqBet({area = k, chips = v})
				end
			else
				self.panel_ui.btnAutoContinue:setSelected(false)
			end
    	end
    end
end

--自动退出
function CBaiRenNiuNiuMainScene:autoExitHandler()
	if self.panel_ui.btnAutoExit:isSelected() == true then
		send_bairenniuniu_ReqExitTable()
	end
end


function CBaiRenNiuNiuMainScene:registerHandler()
	--标题
	local function closeFunc()
		local function tipsCallBack()
			send_bairenniuniu_ReqExitTable()
		end

		if long_compare(bairenniuniu_manager._bankerInfo.playerId, get_player_info().id) == 0 then
			if bairenniuniu_manager._state ~= 1 then
				TipsManager:showTwoButtonTipsPanel(77, {}, true, tipsCallBack)
			else
				tipsCallBack()
			end
		else
			if bairenniuniu_manager._state == 2 then
				if long_compare(self:getTotalBetChips(),0) ~= 0 then
					TipsManager:showOneButtonTipsPanel(72, {}, true)
				else
					tipsCallBack()
				end
			elseif bairenniuniu_manager._state == 3 then
				TipsManager:showTwoButtonTipsPanel(73, {}, true, tipsCallBack)
			else
				tipsCallBack()
			end
		end
	end
	local title = WindowScene.getInstance():getModuleObjByClassName("CTableTitleExt")
	if title then
		title:setCloseFunc(closeFunc)
	end

	--兑换按钮
	self.panel_ui.BtnDuih:onTouch(function(e)
		if e.name == "ended" then
		local playerInfo = get_player_info()
			TipsManager:showExchangePanel(bairenniuniu_manager._ownChips, playerInfo.gold)
		end
	end)
	--续押
	self.panel_ui.BtnContinue:onTouch(function (e)
		if e.name == "ended" then
			print("续押")
			CBaiRenNiuNiuMainScene:continueBetHandler()
		end
	end)
	--清空
	self.panel_ui.btnClean:onTouch(function (e)
		if e.name == "ended" then
			local curTotalBetChips = CBaiRenNiuNiuMainScene:getTotalBetChips()
			-- print("curTotalBetChips == " ..curTotalBetChips)
			-- dump(bairenniuniu_manager.curBetChipsMap)
			if long_compare(curTotalBetChips,0) > 0 then
				send_bairenniuniu_ReqClearBet()
			end
		end
	end)

		--倍率
	self.panel_ui.BtnBeil:onTouch(function (e)
		if e.name == "ended" then
			if self.bIsShowCardPanel == false then
				self.bIsShowCardPanel = true
				self.panel_ui.LabBeilv:setVisible(true)
				self.panel_ui.LabBeilv:setTouchEnabled(true)
				-- self.controlPanel:moveIn()
				-- self.controlPanel.ismoveOut = true
			else
				self.bIsShowCardPanel = false
				self.panel_ui.LabBeilv:setVisible(false)
				self.panel_ui.LabBeilv:setTouchEnabled(false)
			end
		end
	end)
	--设置
	self.panel_ui.BtnSet:onTouch(function (e)
		if e.name == "ended" then
			local gameid = get_player_info().curGameID
			if gameid ~= nil then
				WindowScene.getInstance():showDlgByName("CHallSet")
			end
		end
	end)
	--退出
	self.panel_ui.BtnExit:onTouch(function (e)
		if e.name == "ended" then
			closeFunc()
		end
	end)
	-- --菜单 
	-- self.panel_ui.BtnCaid:onTouch(function (e)
	-- 	if e.name == "ended" then
	-- 		if self.bIsShowCaidanPanel == false then
	-- 			self.bIsShowCaidanPanel = true
	-- 			self.panel_ui.Image_Bg:setVisible(true)
	-- 			self.panel_ui.Image_Bg:setTouchEnabled(true)
	-- 			if self.bIsShowCaidanPanel == true then
	-- 				--帮助
	-- 				self.panel_ui.BtnHelp:onTouch(function (e)
	-- 					if e.name == "ended" then
	-- 						if self.bIsShowCardPanel == false then
	-- 							self.bIsShowCardPanel = true
	-- 							self.panel_ui.LabBeilv:setVisible(true)
	-- 							self.panel_ui.LabBeilv:setTouchEnabled(true)
	-- 						else
	-- 							self.bIsShowCardPanel = false
	-- 							self.panel_ui.LabBeilv:setVisible(false)
	-- 							self.panel_ui.LabBeilv:setTouchEnabled(false)
	-- 						end
	-- 					end
	-- 				end)
	-- 				--设置
	-- 				self.panel_ui.BtnSet:onTouch(function (e)
	-- 					if e.name == "ended" then
	-- 						local gameid = get_player_info().curGameID
	-- 						if gameid ~= nil then
	-- 							WindowScene.getInstance():showDlgByName("CHallSet")
	-- 						end
	-- 					end
	-- 				end)
	-- 				--退出
	-- 				self.panel_ui.BtnExit:onTouch(function (e)
	-- 					if e.name == "ended" then
	-- 						closeFunc()
	-- 					end
	-- 				end)
	-- 			end	
	-- 		else
	-- 			self.bIsShowCaidanPanel = false
	-- 			self.panel_ui.Image_Bg:setVisible(false)
	-- 			self.panel_ui.Image_Bg:setTouchEnabled(false)
	-- 		end		
	-- 	end
	-- end)



	--下注
	for k,v in pairs(self.btnSelectedList) do
		v:onTouch(function (e)
			if e.name == "ended" then
				if bairenniuniu_manager._selectChipsType ~= nil then
					local tag = e.target:getTag()
					local curBetChips = bairenniuniu_manager._chipsValueList[bairenniuniu_manager._selectChipsType]

					local requireChips = long_multiply(long_plus(self:getTotalBetChips(), curBetChips),8)
					--判断当前筹码是否够下注
					if long_compare(bairenniuniu_manager._ownChips, requireChips) >= 0 then
						send_bairenniuniu_ReqBet({area = tag, chips = curBetChips})
						-- bairenniuniu_manager._bCanBet = false
					else
						print("筹码不足!!!!!!!!!!!!")
						TipsManager:showOneButtonTipsPanel(76, {}, true)
					end 
				end
			end
		end)
	end
end


--倒计时和游戏状态
function CBaiRenNiuNiuMainScene:updateCountdownAndState(dt)
    --倒计时音效
	if (bairenniuniu_manager._state == 2) and (bairenniuniu_manager._countdown <= 5) then 
		audio_manager:playOtherSound(7, false)
	end
    self.panel_ui.FntClock:setString(bairenniuniu_manager._countdown)
    self.panel_ui.FntClock:setVisible(true)
    -- self.panel_ui.imgClockBg:setVisible(true)
    --游戏状态
    if bairenniuniu_manager._state ~= nil then  
    	self.panel_ui.ImgStage:setTexture("game/bairenniuniu_std/resource/word/bairenniuniu_state_" ..bairenniuniu_manager._state ..".png")
    	self.panel_ui.ImgStage:setVisible(true)
    end 
	--倒计时
	if (bairenniuniu_manager._countdown~=nil) and (bairenniuniu_manager._countdown>0) then
		bairenniuniu_manager._countdown = bairenniuniu_manager._countdown-1
    end
end

--添加下注筹码,area:下注区域,chips:下注筹码数,isMyBet:0->其它下注，1->当前玩家下注
function CBaiRenNiuNiuMainScene:addBetChips(area,chips,isMyBet)
	-- dump(area)
	audio_manager:playOtherSound(4, false) 
	local numArr = gsplit(chips)  
	numArr = table.reverse(numArr)
	for i,v in pairs(numArr) do
		for k = 1,v do
			if (bairenniuniu_manager._numberList[area][i] < 9) or (isMyBet == 1) then
				local params = {}
				-- dump(area)
				-- dump(self.nodeBetList[area]:getPosition())
				local PosX,PosY = self.nodeBetList[area]:getPosition()
				params.endPos_x = math.random(PosX-70, PosX+70) 
				params.endPos_y = math.random(PosY-70, PosY+70)

				local startP_x, startP_y = 0,0
				if isMyBet == 1 then
					startP_x, startP_y = self.panel_ui.NodePlayerChips:getPosition()
				else
					startP_x, startP_y = self.nodeOtherPlayerList[math.random(1,3)]:getPosition()
				end
				local sprite = display.newSprite(sideResPathlist[i], startP_x, startP_y)
				sprite:setTag(isMyBet)
				sprite:setAnchorPoint(0.5,0.5)
				sprite:setScale(0.5)
				self.panel_ui.BackImage:addChild(sprite)
				CFlyAction:Fly(sprite, 0.2, params, CFlyAction.FLY_TYPE_CHIPS)

				if self.betChipsImgList[area] == nil then
					-- print("betChipsImgList[area] is nil >>")
					self.betChipsImgList[area] = {}
				end
				table.insert( self.betChipsImgList[area], sprite )
				bairenniuniu_manager._numberList[area][i] = bairenniuniu_manager._numberList[area][i] + 1
			end
		end

	end
	-- self.fntTotalBetChipsList[area]:setString(bairenniuniu_manager.totalBetChipsMap[area])
	-- self.fntTotalBetChipsList[area]:setVisible(true)
	-- self.imgTotalBetBgList[area]:setVisible(true)
		
	-- if bairenniuniu_manager.curBetChipsMap[area] ~= nil then
	-- 	self.fntCurBetChipsList[area]:setString(bairenniuniu_manager.curBetChipsMap[area])
	-- 	self.fntCurBetChipsList[area]:setVisible(true)
	-- end
end

--清空当前玩家下注的筹码
function CBaiRenNiuNiuMainScene:cleanCurBetChips()
	for i=1,4 do
		if bairenniuniu_manager.curBetChipsMap[i] then
			bairenniuniu_manager.totalBetChipsMap[i]=long_minus(bairenniuniu_manager.totalBetChipsMap[i], bairenniuniu_manager.curBetChipsMap[i])
			bairenniuniu_manager.curBetChipsMap[i] = nil
		end
	end
	bairenniuniu_manager.curBetChipsMap = {}
	
	for area=1,4 do
		if self.betChipsImgList[area] ~= nil then
			local tmpTab = {}
			for i,v in pairs(self.betChipsImgList[area]) do
				if v ~= nil then
					if v:getTag() == 1 then
						table.insert(tmpTab, v)
					end
				end
			end
			if tmpTab then
				for k,v in pairs(tmpTab) do
				  table.removebyvalue(self.betChipsImgList[area], v)
				  v:removeFromParent()
				  v = nil
				end
			end
			tmpTab = nil
		end
	end
	-- self.betChipsImgList = {}
	self:updateTotalBetChips()
	self:updatePlayerBetChips()
end

--更新总的下注数
function CBaiRenNiuNiuMainScene:updateTotalBetChips()
	-- dump(bairenniuniu_manager.totalBetChipsMap)
	for area=1,4 do
		if bairenniuniu_manager.totalBetChipsMap[area] ~= nil then
			if long_compare(bairenniuniu_manager.totalBetChipsMap[area], 0) > 0 then
				self.fntTotalBetChipsList[area]:setString(bairenniuniu_manager.totalBetChipsMap[area])
				self.fntTotalBetChipsList[area]:setVisible(true)
				self.imgTotalBetBgList[area]:setVisible(true)
			else
				self.fntTotalBetChipsList[area]:setVisible(false)
				self.imgTotalBetBgList[area]:setVisible(false)
			end
		else
			self.fntTotalBetChipsList[area]:setVisible(false)
			self.imgTotalBetBgList[area]:setVisible(false)
		end
	end
end

--更新当前玩家的下注数
function CBaiRenNiuNiuMainScene:updatePlayerBetChips()
	for area=1,4 do
		if bairenniuniu_manager.curBetChipsMap[area] ~= nil then
			if long_compare(bairenniuniu_manager.curBetChipsMap[area], 0) > 0 then
				self.fntCurBetChipsList[area]:setString(bairenniuniu_manager.curBetChipsMap[area])
				self.fntCurBetChipsList[area]:setVisible(true)
			else
				self.fntCurBetChipsList[area]:setVisible(false)
			end
		else
			self.fntCurBetChipsList[area]:setVisible(false)
		end
	end
end


--更新玩家筹码
function CBaiRenNiuNiuMainScene:updateChips()
	self:updatePlayerInfo()
	self:updateBtnChipsState()
end

--清除筹码图片
function CBaiRenNiuNiuMainScene:cleanChipsImg()
	if table.nums(bairenniuniu_manager._record) > 0 then            
		local function callback1()
			local curRecord = bairenniuniu_manager._record[1]
			local accountData = bairenniuniu_manager:convertToBinTable(curRecord)
			if accountData then
				for i,v in pairs(accountData) do
					if self.betChipsImgList[i] ~= nil then
						if v == 1 then
							for k,sprite in pairs(self.betChipsImgList[i]) do
								if sprite ~= nil then
									local params = {}
									params.endPos_x,params.endPos_y = self.panel_ui.NodePlayerChips:getPosition()
							        params.flyendCallback = function ()
										sprite:removeFromParent()
										sprite = nil
									end
									CFlyAction:Fly(sprite, 1, params, CFlyAction.FLY_TYPE_CHIPS)
								end
							end
						end
					end
				end
			end
		end

		local function callback2()
			for i,chipsImgList in pairs(self.betChipsImgList) do
				if chipsImgList ~= nil then
					for k,sprite in pairs(chipsImgList) do
						if sprite ~= nil then 
							local params = {}
							params.endPos_x,params.endPos_y = self.panel_ui.NodeBankerChips:getPosition()
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
			--每个区域下注的每种类型筹码个数
			bairenniuniu_manager._numberList = {[1] = {0,0,0,0,0,0,0,0},
											    [2] = {0,0,0,0,0,0,0,0},
											    [3] = {0,0,0,0,0,0,0,0},
											    [4] = {0,0,0,0,0,0,0,0},
											}
			self:updateRecord(bairenniuniu_manager._record)--更新历史记录
		end

		local call_action1 = cc.CallFunc:create(callback1)
		local call_action2 = cc.CallFunc:create(callback2)
		local seq_arr = {}
		table.insert(seq_arr,call_action1)
		table.insert(seq_arr,cc.DelayTime:create(1))
		table.insert(seq_arr,call_action2)
		local seq = cc.Sequence:create(seq_arr)
		self:runAction(seq)
	end
end

--发牌
function CBaiRenNiuNiuMainScene:sendCardsStage(tipsCards)
	self.panel_ui.LabBetBg:setVisible(false)
	for k,v in pairs(tipsCards) do
		self.cardItemList[k]:setCardInfo(v)
	end

	local function sendCardCallBack()
		for i=1,5 do
			local function sendCard()
				self.cardItemList[i]:addCard()
				--发牌音效
				audio_manager:playOtherSound(5)
			end
			performWithDelay(self.cardItemList[i], function ()
				self:showSendHandCardAction(cardEndPosArr[i], sendCard)
			end, 0.1*i)
		end
	end
	for k=1,5 do
		performWithDelay(self, function () sendCardCallBack() end, 0.5*k)
	end

	local function flopCardCallBack()
		for i=1,5 do
			local function flopCard()
				self.cardItemList[i]:playFlopAnimation()
			end
			performWithDelay(self.cardItemList[i], function () flopCard() end, 2.4*(i-1))
		end
	end
	-- local function showCardCallBack()
	-- 	for i=1,5 do
	-- 		local function showcallback()
	-- 			-- self.cardItemList[i]:showCards()
	-- 			self.cardItemList[i]:showCardType()
	-- 		end
	-- 		performWithDelay(self.cardItemList[i], function () showcallback() end, 0.5*(i-1))
	-- 	end
	-- end
	
	performWithDelay(self, function () flopCardCallBack() end, 3)
	-- 闪动动画
	performWithDelay(self, function () self:playBlinkAnimation() end, 15)
	-- 结算面板
	performWithDelay(self, function ()
		 self:addSettleAccountsPanel() 
		 -- self:playBankerAnimation()
		end, 16)
	-- 庄通吃通赔动画
	performWithDelay(self, function () self:playBankerAnimation() end, 17)
end

--播发发牌动作
function CBaiRenNiuNiuMainScene:showSendHandCardAction(endPos, callback)
	local imgFrame = display.newSpriteFrame(bairenniuniu_card_data[54].card_big)
    local imgBackCard = cc.Sprite:createWithSpriteFrame(imgFrame)
    self:addChild(imgBackCard)
    imgBackCard:setPosition(self.panel_ui.NodePoker:getPosition())

    local moveAction = cc.MoveTo:create(SEND_CARD_SPEED, endPos)
    local call_action = cc.CallFunc:create(function (node)
		node:stopAllActions() 
		node:removeFromParent()
		node = nil

    	callback()
    end)

    local seq = cc.Sequence:create({moveAction, call_action})
    imgBackCard:runAction(seq)
end

--添加结算界面
function CBaiRenNiuNiuMainScene:addSettleAccountsPanel()
	--结算界面
	if self.settleAccountsPanel == nil then 
		self.settleAccountsPanel =  CBaiRenNiuNiuSettleAccounts.create()
		self:addChild(self.settleAccountsPanel, 100)
		self.settleAccountsPanel:setPosition(0,0)
		self.settleAccountsPanel:setAnchorPoint(0,0)
	end
	-- 结算面板
	self.settleAccountsPanel:balance()
	-- 延迟清除筹码图片
	performWithDelay(self, function () self:cleanChipsImg() end, 1)
	--刷新庄家玩家信息
	performWithDelay(self, function () 
		print("*******刷新庄家玩家信息*****")
		self:updateChips()
		self:updateBankerInfo()
		end,2)
	 
end

--移除结算界面
function CBaiRenNiuNiuMainScene:removeSettleAccountsPanel()
	if self.settleAccountsPanel ~= nil then
		self.settleAccountsPanel:removeFromParent()
		self.settleAccountsPanel = nil
	end
	if self.bankerEffect ~= nil then
		self.bankerEffect:removeFromParent()
		self.bankerEffect = nil 
	end
end

--更新记录
function CBaiRenNiuNiuMainScene:updateRecord(recordList)
	self.recordPanel:updateRecord(recordList)
end

--获取当前玩家当前下注的总筹码数
function CBaiRenNiuNiuMainScene:getTotalBetChips()
	local totalBetChips = 0
	for i,v in pairs(bairenniuniu_manager.curBetChipsMap) do
		totalBetChips = long_plus(totalBetChips,v)
	end
	return totalBetChips
end

--播放闪动动画
function CBaiRenNiuNiuMainScene:playBlinkAnimation()
	if table.nums(bairenniuniu_manager._record) > 0 then
		local curRecord = bairenniuniu_manager._record[1]
		local accountData = bairenniuniu_manager:convertToBinTable(curRecord)
		for k,v in pairs(accountData) do
			self.cardItemList[k]:setBalance(v)
		end
	end
end

--播放庄通吃、通赔特效
function CBaiRenNiuNiuMainScene:playBankerAnimation()
	if table.nums(bairenniuniu_manager._record) > 0 then
		local curRecord = bairenniuniu_manager._record[1]
		if self.bankerEffect ~= nil then
			self.bankerEffect = nil
		end
		if curRecord == 15 then
			audio_manager:playOtherSound(2, false)
			local effectData = bairenniuniu_effect_config["庄通赔"]
			self.bankerEffect = animationUtils.createAndPlayAnimationNoAutoRemove(self.panel_ui.NodeBankerEffect,effectData)
			self.bankerEffect:setAnchorPoint(0.5,0.5)
			self.bankerEffect:setPosition(cc.p(0,0))
		elseif curRecord == 0 then
			audio_manager:playOtherSound(3, false)
			local effectData = bairenniuniu_effect_config["庄通吃"]
			self.bankerEffect = animationUtils.createAndPlayAnimationNoAutoRemove(self.panel_ui.NodeBankerEffect,effectData)
			self.bankerEffect:setAnchorPoint(0.5,0.5)
			self.bankerEffect:setPosition(cc.p(0,0))
		end
	end
end

function CBaiRenNiuNiuMainScene:registerGroupEvent(obj_lst,call_back)
	-- body
	-- print("筹码下注按钮>>>>>>")
	for k,v in pairs(obj_lst) do
		self.btn_group_info_lst[v] = {call = call_back,mutex = obj_lst,}
		local function __on_group_deal_pro(sender,event_type)
			self:onGroupDealPro(sender,event_type)
		end
		v:addEventListener(__on_group_deal_pro)
	end
end


function CBaiRenNiuNiuMainScene:onGroupDealPro(sender,event_type)
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

function CBaiRenNiuNiuMainScene:regTouch()
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

function CBaiRenNiuNiuMainScene:onTouchEnded(touch, event)
	
	local a,b = self.recordPanel.panel_ui.LabRecord:getPosition()
	--倍率
	local beilvPos = self.panel_ui.LabBeilv:convertToWorldSpace(cc.p(0,0))
	local beilvboundingBox = self.panel_ui.LabBeilv:getBoundingBox()
	beilvboundingBox.x = beilvPos.x
	beilvboundingBox.y = beilvPos.y
	--历史记录
	-- local recordPos = self.recordPanel.panel_ui.LabRecord:convertToWorldSpace(cc.p(0,0))
	-- local recordboundingBox = self.recordPanel.panel_ui.LabRecord:getBoundingBox()
	-- recordboundingBox.x = recordPos.x
	-- recordboundingBox.y = recordPos.y
	--菜单
	-- local controlPos = self.controlPanel.panel_ui.ImageBg:convertToWorldSpace(cc.p(0,0))
	-- local controlboundingBox = self.controlPanel.panel_ui.ImageBg:getBoundingBox()
	-- controlboundingBox.x = controlPos.x
	-- controlboundingBox.y = controlPos.y
	--申请列表
	local applylistPos = self.applyListPanel.panel_ui.LabShangz_Bg:convertToWorldSpace(cc.p(0,0))
	local applylistboundingBox = self.applyListPanel.panel_ui.LabShangz_Bg:getBoundingBox()
	applylistboundingBox.x = applylistPos.x
	applylistboundingBox.y = applylistPos.y

	local pt = touch:getLocation()
	-- dump(pt)
	if self.bIsShowCardPanel then
		if cc.rectContainsPoint(beilvboundingBox, pt) ~= true then		
			self.bIsShowCardPanel = false
			self.panel_ui.LabBeilv:setVisible(false)
			self.panel_ui.LabBeilv:setTouchEnabled(false)
		end
	end

	-- if self.recordPanel.ismoveOut == false then
	-- 	if cc.rectContainsPoint(recordboundingBox, pt) ~= true then
	-- 		self.recordPanel:moveIn()
	-- 		self.recordPanel.ismoveOut = true
	-- 	end
	-- end

	-- if self.controlPanel.ismoveOut == false then
	-- 	if cc.rectContainsPoint(controlboundingBox, pt) ~= true then
	-- 		self.controlPanel:moveIn()
	-- 		self.controlPanel.ismoveOut = true
	-- 	end
	-- end

	if self.applyListPanel.ismoveOut then
		if cc.rectContainsPoint(applylistboundingBox, pt) ~= true then
			self.applyListPanel:moveOut()
			self.applyListPanel.ismoveOut = false
		end
	end
end


