--[[
魏蜀吴主场景
]]

--游戏阶段
local stateRes = {"game/weishuwu_std/resource/word/xiuxiyixia.png",
				"game/weishuwu_std/resource/word/xiazhushijian.png",
				"game/weishuwu_std/resource/word/kaipaishijian.png",
				}
--抛出筹码图片
--小
-- local sideResPathlist = {"lobby/resource/chips/35/chips_s_8.png",
-- 	"lobby/resource/chips/35/chips_s_7.png",
-- 	"lobby/resource/chips/35/chips_s_6.png",
-- 	"lobby/resource/chips/35/chips_s_5.png",
-- 	"lobby/resource/chips/35/chips_s_4.png",
-- 	"lobby/resource/chips/35/chips_s_3.png",
-- 	"lobby/resource/chips/35/chips_s_2.png",
-- 	"lobby/resource/chips/35/chips_s_1.png",}
--大
local sideResPathlist = {"game/weishuwu_std/resource/image/chips/sidegray.png",
	"game/weishuwu_std/resource/image/chips/sidepink.png",
	"game/weishuwu_std/resource/image/chips/sidegreen.png",
	"game/weishuwu_std/resource/image/chips/sideblue.png",
	"game/weishuwu_std/resource/image/chips/sideblack.png",
	"game/weishuwu_std/resource/image/chips/sidecoffe.png",
	"game/weishuwu_std/resource/image/chips/sidepurple.png",
	"game/weishuwu_std/resource/image/chips/sidered.png",}

--发牌终点坐标
local cardEndPosArr = {{x = 580, y = 560}, {x = 1220, y = 560},{x = 730,y = 560},{x =1370,y =560}}
--发牌速度
local SEND_CARD_SPEED = 0.2
local panel_ui = require "game.weishuwu_std.script.ui_create.ui_weishuwu_main"

CWeishuwuMainScene = class("CWeishuwuMainScene", function ()
	local ret = cc.Node:create()
	return ret
end)
ModuleObjMgr.add_module_obj(CWeishuwuMainScene,"CWeishuwuMainScene")

function CWeishuwuMainScene.create()
	local node = CWeishuwuMainScene.new()
	if node ~= nil then
		node:loading()
		node:regTouch()
		-- node:init_ui()
		node:regEnterExit()
		-- node:regMouseEvent()
	end
	return node
end

function CWeishuwuMainScene:loading()
    self.isLoadEnd = false
    self:initData()

	local info = {
		parent 			= WindowScene.getInstance().game_layer,
		task_call 		= function (percent,index,texture) self:addImageSrc(percent,index,texture) end,
		complete_call 	= function () self:loadEnded() end,
		--task_lst = {[x] = {src = "",},},
		ui_info = {
			back_pic 		= "game/weishuwu_std/resource/image/start.jpg",
			bar_back_pic 	= "game/weishuwu_std/resource/image/loadingbg.png",
			bar_process_pic = "game/weishuwu_std/resource/image/loading.png",
			b_self_release 	= true,
		},
	}

	info.task_lst = {}
	for i=1,#weishuwu_effect_res_config do
		local item = {src = weishuwu_effect_res_config[i].imageName,}
		info.task_lst[i] = item
	end
	self._loadingTask = LoadingTask.create(info)
end

function CWeishuwuMainScene:addImageSrc(percent,index,texture)
	local cache = cc.SpriteFrameCache:getInstance()
	cache:addSpriteFrames(weishuwu_effect_res_config[index].plistPath)
end

function CWeishuwuMainScene:regEnterExit()
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

function CWeishuwuMainScene:onEnter()
	audio_manager:reloadMusicByConfig(weishuwu_music_config)
end

function CWeishuwuMainScene:onExit()
	if self.schedulHandler ~=nil then
		scheduler:unscheduleScriptEntry(self.schedulHandler)
		self.schedulHandler = nil
	end
	--移除动画资源
	for i,v in ipairs(weishuwu_effect_res_config) do
		display.removeSpriteFrames(v.plistPath,v.imageName)
	end

	if table.nums(self.record_ui.record) > 0 then
		self.record_ui.record = nil
		self.record_ui.record = {}
	end
	for k,v in pairs(self.record_ui.recordItemList) do
		if v ~= nil then
			v:setVisible(false)
			v=nil
		end
	end
	-- self.player_ui.playerScore = 0
	weishuwu_manager._bFirstEnter = true
	audio_manager:destoryAllMusicRes()
end

function CWeishuwuMainScene:init_after()

end

function CWeishuwuMainScene:destoryLoading()
	if self._loadingTask then
    	self._loadingTask:forcedDestory()
        self._loadingTask = nil
    end
end

function CWeishuwuMainScene:loadEnded()
	self._loadingTask = nil
	
	self:init_ui()
	self:registerHandler()

	self.isLoadEnd = true
	self.isUpdateRecord = false

	self.soundIsplay = {}	
	for i = 1, 9 do
		self.soundIsplay[i] = false
	end
	
	weishuwu_manager.alonePanel = false
	self.isShowRecordPanel = false


	--刷新玩家庄家信息
	self:updatePlayerInfo()
	self:updateBankerInfo()


    self.schedulHandler = scheduler:scheduleScriptFunc(handler(self,self.updateCountdownAndState),1,false)

    self:resetGame()
    -- self:updateNumberOfGames()

    -- 添加下注筹码图片
	if table.nums(weishuwu_manager.totalBetChipsInfo) > 0 and weishuwu_manager._state == 2 then
	    for k,v in pairs(weishuwu_manager.totalBetChipsInfo) do
	    	-- dump(v)
	    	self:addChipsToPanel(v.area+1,v.chips,0)
	    	self.fntTotalBetList[v.area+1]:setString(v.chips)
	    	self.fntTotalBetList[v.area+1]:setVisible(true)
	    	weishuwu_manager.totalBetChipsMap[v.area] = v.chips
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

function CWeishuwuMainScene:initData()		
end

function CWeishuwuMainScene:init_ui()
	--基础界面 
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	--申请列表
	self.applyList_ui = CWeishuwuApplyList.create()
	self.panel_ui.nodeCardscene:addChild(self.applyList_ui)
	self.applyList_ui:setPosition(0,0)

	--菜单设置
	self.control_ui = CWeishuwuCaidan.create()
	self.panel_ui.nodeCardscene:addChild(self.control_ui)
	self.control_ui:setPosition(0,0)

	--发牌界面
	self.card_ui = CWeishuwuSendcard.create()
	self.panel_ui.nodeCardscene:addChild(self.card_ui)
	self.card_ui:setPosition(0,0)
	--结算面板
	self.balance_ui=CWeishuwuSettlement.create()
	self.panel_ui.nodeCardscene:addChild(self.balance_ui)
	self.balance_ui:setPosition(0,0)

	--路单界面
	self.alone_ui = CWeishuwuAlone.create()
	self.panel_ui.nodeAlone:addChild(self.alone_ui)
	self.alone_ui:setPosition(0,0)

	--历史记录
	self.record_ui = CWeishuwuRecord.create()
	self.panel_ui.nodeAlone:addChild(self.record_ui)
	self.record_ui:setPosition(0,0)


	--当前玩家下注筹码背景
	self.imgCurBetBgList = {self.panel_ui.fntBetMyBG1,self.panel_ui.fntBetMyBG2,self.panel_ui.fntBetMyBG3,
							self.panel_ui.fntBetMyBG4,self.panel_ui.fntBetMyBG5,self.panel_ui.fntBetMyBG6,
							self.panel_ui.fntBetMyBG7,self.panel_ui.fntBetMyBG8,self.panel_ui.fntBetMyBG9,}
	--开中区域标识
	self.imgMaskList = {self.panel_ui.Img_eff1,self.panel_ui.Img_eff2,self.panel_ui.Img_eff3,
						self.panel_ui.Img_eff4,self.panel_ui.Img_eff5,self.panel_ui.Img_eff6,
						self.panel_ui.Img_eff7,self.panel_ui.Img_eff8,self.panel_ui.Img_eff9,}
	--当前玩家下注筹码
	self.fntCurBetList = {	self.panel_ui.fntBetMy1,self.panel_ui.fntBetMy2,self.panel_ui.fntBetMy3,
							self.panel_ui.fntBetMy4,self.panel_ui.fntBetMy5,self.panel_ui.fntBetMy6,
							self.panel_ui.fntBetMy7,self.panel_ui.fntBetMy8,self.panel_ui.fntBetMy9,}
	--所有人下注总筹码
	self.fntTotalBetList = {self.panel_ui.fntBetTotal1,self.panel_ui.fntBetTotal2,self.panel_ui.fntBetTotal3,
							self.panel_ui.fntBetTotal4,self.panel_ui.fntBetTotal5,self.panel_ui.fntBetTotal6,
							self.panel_ui.fntBetTotal7,self.panel_ui.fntBetTotal8,self.panel_ui.fntBetTotal9,}
	--下注区选择按钮
	self.btnSelectList = {	self.panel_ui.btnSelected1,self.panel_ui.btnSelected2,self.panel_ui.btnSelected3,
							self.panel_ui.btnSelected4,self.panel_ui.btnSelected5,self.panel_ui.btnSelected6,
							self.panel_ui.btnSelected7,self.panel_ui.btnSelected8,self.panel_ui.btnSelected9,}
	--筹码节点
	self.nodeChipsList ={self.panel_ui.nodeChips1,self.panel_ui.nodeChips2,self.panel_ui.nodeChips3,
						self.panel_ui.nodeChips4,self.panel_ui.nodeChips5,self.panel_ui.nodeChips6,
						self.panel_ui.nodeChips7,self.panel_ui.nodeChips8,self.panel_ui.nodeChips9,}
	--其他玩家下注节点
	self.nodeOtherPlayerList = {self.panel_ui.nodeOtherPlayerChips1,self.panel_ui.nodeOtherPlayerChips2,
								self.panel_ui.nodeOtherPlayerChips3,self.panel_ui.nodeOtherPlayerChips4,}

	for i=1,9 do
		self.imgCurBetBgList[i]:setVisible(false)
		self.imgMaskList[i]:setVisible(false)
		self.fntCurBetList[i]:setString("")
		self.fntTotalBetList[i]:setString("")
		self.btnSelectList[i]:setTag(i)
	end
    self.panel_ui.Img_state:setVisible(false)
    self.panel_ui.clock:setVisible(false)

	--玩家牌
	self.palyerCards = {}
	--庄家牌
	self.bankerCards = {}
	--历史记录
	-- self.record = {}
	--历史记录图片
	-- self.recordItemList = {}
	--下注的筹码图片
	self.betChipsImgList = {}
	--check button 组处理
	self.btn_group_info_lst = {}
	--筹码按钮
	self.btnBetList = {self.panel_ui.Btn_CM1,self.panel_ui.Btn_CM2,self.panel_ui.Btn_CM3,self.panel_ui.Btn_CM4,
						self.panel_ui.Btn_CM5,self.panel_ui.Btn_CM6,self.panel_ui.Btn_CM7,self.panel_ui.Btn_CM8,}
	for i,v in pairs(self.btnBetList) do
		v:setEnabled(false)
		v:setBright(false)
	end
	self:registerGroupEvent(self.btnBetList,function (s,e) self:betButtonHandler(s,e) end)

	-- self:addButtonHightLight()
	-- self:playAnimation()	
end

function CWeishuwuMainScene:addButtonHightLight()
	local btnArr = {self.panel_ui.Btn_lvdan,self.panel_ui.Btn_on,self.panel_ui.Btn_under,
					self.panel_ui.Btn_Continue,self.panel_ui.Btn_clean,}

	local resArr = {"查看路单","上分高亮", "下分高亮","续押高亮", "清空高亮",}

	for i,btn in ipairs(btnArr) do
		local mov_obj = cc.Sprite:create(weishuwu_imageRes_config[resArr[i]].resPath)
		WindowScene.getInstance():registerBtnMouseMoveEff(btn,mov_obj,1)
	end
end

--动画
function CWeishuwuMainScene:playAnimation()

	local effectData = weishuwu_effect_config["光标"]
	self.leftEffect = animationUtils.createAndPlayAnimation(self.panel_ui.NodeYidEffect1,effectData)
	self.leftEffect:setAnchorPoint(0.5,0.5)

	self.rightEffect = animationUtils.createAndPlayAnimation(self.panel_ui.NodeYidEffect2,effectData)
	self.rightEffect:setAnchorPoint(0.5,0.5)
	self.rightEffect:setFlippedX(true)
end

function CWeishuwuMainScene:registerHandler()
	--标题
	local function tipsCallBack()
		send_weishuwu_ReqExitTable()
	end
	local function closeFunc()
		print("ExitTable>>>>>>>>")
		if not weishuwu_manager or not get_player_info() then
			tipsCallBack()
		elseif long_compare(weishuwu_manager._bankerInfo.playerId, get_player_info().id) == 0 then
			if weishuwu_manager._state ~= 1 then
				TipsManager:showTwoButtonTipsPanel(77, {}, true, tipsCallBack)
			else
				tipsCallBack()
			end
		else
			if weishuwu_manager._state == 2 then
				if long_compare(self:getTotalBetChips(),0) ~= 0 then
					TipsManager:showOneButtonTipsPanel(72, {}, true)
				else
					tipsCallBack()
				end
			elseif weishuwu_manager._state == 3 then
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

	-- --上分
	-- self.panel_ui.Btn_on:onTouch(function (e)
	-- 	if e.name == "ended" then
	-- 		TipsManager:showChipsExchangePanel(weishuwu_manager._ownChips, get_player_info().gold)
	-- 	end
	-- end)
	-- --下分
	-- self.panel_ui.Btn_under:onTouch(function (e)
	-- 	if e.name == "ended" then
	-- 		TipsManager:showGoldExchangePanel(weishuwu_manager._ownChips, get_player_info().gold)
	-- 	end
	-- end)

	--历史记录
	self.panel_ui.Btn_lishi:onTouch(function(e)
		if e.name == "ended" then
			print("历史记录")
			if self.isShowRecordPanel == false then
				self.record_ui.panel_ui.ImgBg:setVisible(true)
				self.isShowRecordPanel = true
			else
				self.record_ui.panel_ui.ImgBg:setVisible(false)
				self.isShowRecordPanel = false
			end
		end
	end)

	--兑换
	self.panel_ui.Btn_duih:onTouch(function(e)
		if e.name == "ended" then
		-- audio_manager:playOtherSound(1, false)
		local playerInfo = get_player_info()
			TipsManager:showExchangePanel(weishuwu_manager._ownChips, playerInfo.gold)
		end
	end)

	--续押
	self.panel_ui.Btn_Continue:onTouch(function (e)
		if e.name == "ended" then
			print("续押")
			self:continueBetHandler()
		end
	end)

	-- 清空
	self.panel_ui.Btn_clean:onTouch(function (e)
		if e.name == "ended" then
			print("清空")
			send_weishuwu_ReqClearBet(msg)
		end
	end)
	--路单
	self.control_ui.panel_ui.Btn_lvdan:onTouch(function(e)
		if e.name == "ended" then
			if weishuwu_manager.alonePanel == false then
				self.alone_ui.panel_ui.Img_BG:setVisible(true)
				weishuwu_manager.alonePanel = true
			else
				self.alone_ui.panel_ui.Img_BG:setVisible(false)
				weishuwu_manager.alonePanel = false
			end
		end
	end)

	--设置
	self.control_ui.panel_ui.Btn_shezhi:onTouch(function(e)
		if e.name == "ended" then
			local gameid = get_player_info().curGameID
			if gameid ~= nil then
				WindowScene.getInstance():showDlgByName("CHallSet")
			end
		end
	end)
	--退出
	self.control_ui.panel_ui.Btn_tuichu:onTouch(function(e)
		if e.name == "ended" then
			closeFunc()			
		end
	end)	

	
	--下注
	for k,v in pairs(self.btnSelectList) do
		v:onTouch(function (e)
			if e.name == "ended" then
				-- print("下注")
				self.imgMaskList[k]:setVisible(false)

				if weishuwu_manager._selectChipsType ~= nil then
					local tag = e.target:getTag()
					if long_compare(weishuwu_manager.totalBetChipsMap[tag-1], 10000000) < 0 then

						local curBetChips = weishuwu_manager._chipsValueList[weishuwu_manager._selectChipsType]

						-- local requireChips = long_plus(self:getTotalBetChips(), curBetChips)
						--判断当前筹码是否够下注
						if long_compare(weishuwu_manager._ownChips, curBetChips) >= 0 then
							send_weishuwu_ReqBet({area = tag-1, chips = curBetChips})
							-- print("向服务器发送下注请求")
							-- weishuwu_manager._bCanBet = false
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
--刷新玩家信息
function CWeishuwuMainScene:updatePlayerInfo()
	print("刷新玩家信息>>>>")
	local playerInfo = get_player_info()
	-- dump(playerInfo)
	local playerTotalChips = 0
	-- local score = 0
	for area = 0,8 do	
		if weishuwu_manager.curBetChipsMap[area] ~= nil then		
			playerTotalChips = playerTotalChips + weishuwu_manager.curBetChipsMap[area]
		end
	end
	if weishuwu_manager._state == 1 then
		self.playerScore = long_plus(self.playerScore,long_minus(weishuwu_manager.chipsChange,playerTotalChips))
		-- dump(self.playerScore)
	end
	uiUtils:setPhonePlayerHead(self.panel_ui.player_head, ((playerInfo.sex == "女") and 1 or 0), uiUtils.HEAD_SIZE_223)
	-- uiUtils:setPlayerHead(self.panel_ui.player_head, ((playerInfo.sex == "女") and 1 or 0), uiUtils.HEAD_SIZE_223)
	self.panel_ui.PlayerName:setString(textUtils.replaceStr(playerInfo.name, NAME_BITE_LIMIT, ".."))
	-- self.panel_ui.PlayerID:setString(playerInfo.id)	
	-- self.panel_ui.PlayerCJ:setString(self.playerScore)	
	self.panel_ui.PlayerCM:setString(weishuwu_manager._ownChips)
end

--刷新庄家信息
function CWeishuwuMainScene:updateBankerInfo()
	print("刷新庄家信息")
	local bankerSex = weishuwu_manager._bankerInfo.sex
		if bankerSex == 3 then
			bankerSex = 2
		end
	if table.nums(weishuwu_manager._bankerInfo) > 0 then
		if long_compare(weishuwu_manager._bankerInfo.playerId, 0 ) >  0 then
			self.panel_ui.BankerName:setString(weishuwu_manager._bankerInfo.name)
			self.panel_ui.BankerCM:setString(weishuwu_manager._bankerInfo.chips)
			-- self.panel_ui.Image_cm1:loadTexture("game/weishuwu_std/resource/image/cm.png")
			uiUtils:setPlayerHead(self.panel_ui.bank_head, bankerSex, uiUtils.HEAD_SIZE_223)
			self.panel_ui.bank_head:setFlippedX(true)
		else
			-- print("weishuwu_manager._bankerInfo.score",weishuwu_manager._bankerInfo.score)
			self.panel_ui.BankerName:setString(weishuwu_manager._bankerInfo.name)
			self.panel_ui.BankerCM:setString(weishuwu_manager._bankerInfo.score)
			-- self.panel_ui.Image_cm1:loadTexture("game/weishuwu_std/resource/image/cj.png")
			uiUtils:setPlayerHead(self.panel_ui.bank_head, bankerSex, uiUtils.HEAD_SIZE_223)
			self.panel_ui.bank_head:setFlippedX(false)	
		end
		-- self.panel_ui.BankerName:setString(weishuwu_manager._bankerInfo.name)
		-- self.panel_ui.BankerCM:setString(weishuwu_manager._bankerInfo.chips)
		-- uiUtils:setPhonePlayerHead(self.panel_ui.bank_head,bankerSex, uiUtils.HEAD_SIZE_223)
	end
end
--设置禁用或启用筹码按钮
function CWeishuwuMainScene:setBtnBetEnable(value)
	if value then
		for i,v in pairs(self.btnBetList) do
			v:setSelected(false)
			-- local requireChips = long_plus(self:getTotalBetChips(), 10^(i-1))
			if (long_compare(weishuwu_manager._ownChips, 10^(i-1)) >= 0) then
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
	-- self.panel_ui.Btn_clean:setVisible(value)
end

--根据当前筹码更新筹码按钮状态
function CWeishuwuMainScene:updateBtnChipsState()
	if weishuwu_manager._state == 2 then
		for i,v in pairs(self.btnBetList) do
			-- local requireChips = long_plus(self:getTotalBetChips(), 10^(i-1))
			if (long_compare(weishuwu_manager._ownChips, 10^(i-1)) >= 0) and self.applyList_ui:isBanker() == false then
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
function CWeishuwuMainScene:setBtnSelectEnable(value)
	if self.btnSelectList then
		for k,v in pairs(self.btnSelectList) do
			v:setEnabled(value)
			v:setBright(value)
		end
	end
end

--设置禁用或启用上分下分按钮
function CWeishuwuMainScene:setBtnAddAndReduceEnable(value)
	self.panel_ui.Btn_duih:setEnabled(value)
	self.panel_ui.Btn_duih:setBright(value)
	-- self.panel_ui.Btn_under:setEnabled(value)
	-- self.panel_ui.Btn_under:setBright(value)
end

--重置显示下注的数字
function CWeishuwuMainScene:resetBetNum()
	for i=1,9 do
		self.fntTotalBetList[i]:setString("")
		self.fntCurBetList[i]:setString("")
		self.fntTotalBetList[i]:setVisible(false)
		self.fntCurBetList[i]:setVisible(false)
		self.imgCurBetBgList[i]:setVisible(false)
	end
end

--获取当前玩家当前下注的总筹码数
function CWeishuwuMainScene:getTotalBetChips()
	local totalBetChips = 0
	for i,v in pairs(weishuwu_manager.curBetChipsMap) do
		totalBetChips = long_plus(totalBetChips,v)
	end
	return totalBetChips
end

--判断当前筹码是否可以续押
function CWeishuwuMainScene:calculateContinue()
	if weishuwu_manager._state == 2 then
		if (weishuwu_manager._continueChips ~= nil) and (table.nums(weishuwu_manager._continueChips) > 0) then
			local totalContinueChips = self:getContinueBetRequireChips()
			-- local requireChips = long_plus(self:getTotalBetChips(),totalContinueChips)
	
			if long_compare(weishuwu_manager._ownChips, totalContinueChips) >= 0 and self.applyList_ui:isBanker() ~= true then 
				self.panel_ui.Btn_Continue:setEnabled(true)
				self.panel_ui.Btn_Continue:setBright(true)
			else
				self.panel_ui.Btn_Continue:setEnabled(false)
				self.panel_ui.Btn_Continue:setBright(false)
			end	
		else
			self.panel_ui.Btn_Continue:setEnabled(false)
			self.panel_ui.Btn_Continue:setBright(false)
		end
	else
		self.panel_ui.Btn_Continue:setEnabled(false)
		self.panel_ui.Btn_Continue:setBright(false)
	end
end

--续押
function CWeishuwuMainScene:continueBetHandler()
	if weishuwu_manager._continueChips then
		local totalContinueChips = self:getContinueBetRequireChips()
		-- local requireChips = long_plus(self:getTotalBetChips(),totalContinueChips)
		--判断当前筹码是否够
		if long_compare(weishuwu_manager._ownChips, totalContinueChips) >= 0 then
			for k,v in pairs(weishuwu_manager._continueChips) do
				send_weishuwu_ReqBet({area = k, chips = v})
			end
		else
			TipsManager:showOneButtonTipsPanel(76, {}, true)
		end 
	end
end



-----wuxiao-----
--自动续押
function CWeishuwuMainScene:autoContinueBetHandler()
	if (self.panel_ui.Btn_ZDcontinue:isSelected() == true) and (weishuwu_manager._continueChips ~= nil) then
		local totalContinueChips = self:getContinueBetRequireChips()
		-- local requireChips = long_plus(self:getTotalBetChips(),totalContinueChips)
		--判断当前筹码是否够
		if long_compare(weishuwu_manager._ownChips, totalContinueChips) >= 0 then
    		for k,v in pairs(weishuwu_manager._continueChips) do
				send_weishuwu_ReqBet({area = k, chips = v})
			end
		else
			self.panel_ui.Btn_ZDcontinue:setSelected(false)
		end
	end
end
--自动退出
function CWeishuwuMainScene:autoExitHandler()
	if self.panel_ui.Btn_ZDExit:isSelected() == true then
		send_weishuwu_ReqExitTable()
	end
end
-----wuxiao-----



--获取续押的筹码总数
function CWeishuwuMainScene:getContinueBetRequireChips()
	local continueRequireChips = 0
	if weishuwu_manager._continueChips then
		for k,v in pairs(weishuwu_manager._continueChips) do
			continueRequireChips = long_plus(continueRequireChips,v)
		end
	end
	return continueRequireChips
end

--倒计时和游戏状态
function CWeishuwuMainScene:updateCountdownAndState(dt)
    -- 倒计时音效
	if weishuwu_manager._state == 2 then
		if  weishuwu_manager._countdown <= 1 then
			-- 下注阶段最后1秒每秒播一次
			audio_manager:playOtherSound(1, false)
			-- self.soundIsplay = true
		end
		if  weishuwu_manager._countdown <= 1 then
			-- 下注阶段最后一秒播放
			-- audio_manager:playOtherSound(5, false)
		end
	end
    self.panel_ui.clock:setString(weishuwu_manager._countdown)
    --游戏状态
    if weishuwu_manager._state ~= nil then  
    	self.panel_ui.Img_state:loadTexture(stateRes[weishuwu_manager._state])
    	self.panel_ui.Img_state:setVisible(true)
    	self.panel_ui.clock:setVisible(true)

    end 
	--倒计时
	if (weishuwu_manager._countdown~=nil) and (weishuwu_manager._countdown>0) then
		weishuwu_manager._countdown = weishuwu_manager._countdown-1
    end
end

--添加下注筹码,area:下注区域,chips:下注筹码数,isMyBet:0->其它下注，1->当前玩家下注
function CWeishuwuMainScene:addChipsToPanel(area,chips,isMyBet)
	audio_manager:playOtherSound(2, false) 
	local numArr = gsplit(chips)  
	numArr = table.reverse(numArr)
	for i,v in pairs(numArr) do
		for k = 1,v do
			local params = {}
			local size = self.btnSelectList[area]:getContentSize()
			params.endPos_x = math.random(30, size.width-30) 
			-- params.endPos_x = math.random(-size.width/2+30, size.width/2-30) 
			params.endPos_y = math.random(30, size.height-30)
			-- params.endPos_y = math.random(-size.height/2+30, size.height/2-30)

			-- local startPos = self.nodeChipsList[area]:convertToNodeSpace(cc.p(800,0))
			local startPos = self.btnSelectList[area]:convertToNodeSpace(cc.p(800,0))


			if isMyBet ~= 1 then
				local otherStartPos_x,otherStartPos_y = self.nodeOtherPlayerList[math.random(1,4)]:getPosition()
				startPos = self.btnSelectList[area]:convertToNodeSpace(cc.p(otherStartPos_x,otherStartPos_y))
			end  
			-- local startPos = cc.p(800,0)
			local sprite = display.newSprite(sideResPathlist[i], startPos.x, startPos.y)
			sprite:setTag(isMyBet)
			sprite:setAnchorPoint(0.5,0.5)
			self.btnSelectList[area]:addChild(sprite)
			CFlyAction:Fly(sprite, 0.2, params, CFlyAction.FLY_TYPE_CHIPS)

			if self.betChipsImgList[area] == nil then
				self.betChipsImgList[area] = {}
			end
			table.insert( self.betChipsImgList[area], sprite)
		end
	end
end

--清除筹码图片
function CWeishuwuMainScene:cleanChipsImg()
	local endPos = cc.p(1700,1000)
	if long_compare(weishuwu_manager.chipsChange,0) > 0 then
		endPos = cc.p(960,100)
	end
	for i,chipsImgList in pairs(self.betChipsImgList) do
		if chipsImgList ~= nil then
			--筹码移动音效
			audio_manager:playOtherSound(2, false)
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
function CWeishuwuMainScene:cleanCurBetChips()
	for i=0,8 do
		if weishuwu_manager.curBetChipsMap[i] then
			weishuwu_manager.totalBetChipsMap[i]=long_minus(weishuwu_manager.totalBetChipsMap[i], weishuwu_manager.curBetChipsMap[i])
			weishuwu_manager.curBetChipsMap[i] = nil
		end
	end
	weishuwu_manager.curBetChipsMap = {}
	
	-- for i,chipsImgList in pairs(self.betChipsImgList) do
	-- 	if chipsImgList ~= nil then
	-- 		for k,sprite in pairs(chipsImgList) do
	-- 			if sprite ~= nil then 
	-- 				sprite:removeFromParent()
	-- 				sprite = nil
	-- 			end
	-- 		end
	-- 	end
	-- end
	for area=1,9 do
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
function CWeishuwuMainScene:updateTotalBetChips()
	print("更新总的下注数")

	for area=1,9 do
		self.fntTotalBetList[area]:setString("")
		self.fntTotalBetList[area]:setVisible(false)
		if weishuwu_manager.totalBetChipsMap[area-1] ~= nil then
			if long_compare(weishuwu_manager.totalBetChipsMap[area-1], 0) > 0 then
				self.fntTotalBetList[area]:setString(weishuwu_manager.totalBetChipsMap[area-1])
				self.fntTotalBetList[area]:setVisible(true)
			else
				self.fntTotalBetList[area]:setVisible(false)
			end
		else
			self.fntTotalBetList[area]:setVisible(false)
		end
		--一个区域下注总数超过万播放一次
		if long_compare(weishuwu_manager.totalBetChipsMap[area-1], 1000000) >= 0 and self.soundIsplay[area] == false then
			audio_manager:playOtherSound(3, false)
			self.soundIsplay[area] = true
		end		
	end
end

--更新当前玩家的下注数
function CWeishuwuMainScene:updatePlayerBetChips()
	print("更新当前玩家的下注数")
	for area=1,9 do
		if weishuwu_manager.curBetChipsMap[area-1] ~= nil then
			if long_compare(weishuwu_manager.curBetChipsMap[area-1], 0) > 0 then
				self.fntCurBetList[area]:setString(weishuwu_manager.curBetChipsMap[area-1])
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
function CWeishuwuMainScene:updateChips()
	self:updatePlayerInfo()
	self:updateBtnChipsState()
end

--刷新上庄列表信息
function CWeishuwuMainScene:updateApplyListInfo()
	-- print("刷新上庄列表信息")
	self.applyList_ui:updateApplyListInfo()
end

--根据游戏状态重置游戏
function CWeishuwuMainScene:resetGame()
	print("根据游戏状态重置游戏")
	
	if weishuwu_manager._bFirstEnter == true  and self.isLoadEnd == true then
		--显示兑换界面
		if weishuwu_manager._state ~= 3 then
			TipsManager:showExchangePanel(weishuwu_manager._ownChips, get_player_info().gold)
		end
		weishuwu_manager._bFirstEnter = false
	end
	if self.isUpdateRecord == false then
		print("第一次进游戏更新历史记录，路单")
		self:updateRecord(weishuwu_manager._record)
		self.alone_ui:updateAlone(weishuwu_manager.alone)
		self.alone_ui:updateHero(weishuwu_manager.alone)
	end

	self:setBtnSelectEnable(false)
	self:setBtnBetEnable(false)
	self:setBtnAddAndReduceEnable(false)
	self:regMouseEvent(false)	
	--判断是否可续押
	self:calculateContinue()
	self:updateApplyListInfo()
	self.soundIsplay = {}
	for i=1,9 do
		-- print(i)
		self.soundIsplay[i] = false
	end
	
	if weishuwu_manager._state == 1 then
		--休息阶段开始时播放
		-- audio_manager:playOtherSound(7, false)		
		self:showBlance(false)
		self:cleanCard()
		self:cleanChipsImg()
		self:resetBetNum()
		self:stopResultEffect()
		--上分下分
		self:setBtnAddAndReduceEnable(true)

		--刷新玩家信息
		self:updatePlayerInfo()

		weishuwu_manager._continueChips = weishuwu_manager.curBetChipsMap
		--当前玩家下注的筹码
		weishuwu_manager.curBetChipsMap = {}
		--所有下注的筹码
		weishuwu_manager.totalBetChipsMap = {}
		--自动退出
		-- self:autoExitHandler()
	elseif weishuwu_manager._state == 2 then

		self:playAnimation()	
		--重置选择筹码小图标
		weishuwu_manager._selectChipsType = nil
		--开始下注音效
		audio_manager:playOtherSound(4, false)
		--上分下分
		self:setBtnAddAndReduceEnable(true)
		
		--下注阶段禁用下分
		-- self.panel_ui.btnDda:setEnabled(false)
		-- self.panel_ui.btnDda:setBright(false)

		if self.applyList_ui:isBanker() ~= true then
			--自动续押
			-- self:autoContinueBetHandler()
			self:setBtnSelectEnable(true)
			self:setBtnBetEnable(true)
		end

		self:regMouseEvent(true)
	elseif weishuwu_manager._state == 3 then
		if self.leftEffect ~= nil then
			self.leftEffect:removeFromParent()
			self.leftEffect = nil
		end
		if self.rightEffect ~= nil then
			self.rightEffect:removeFromParent()
			self.rightEffect = nil
		end
		self:regMouseEvent(false)
		weishuwu_manager._continueChips = nil
		--发牌
		-- self:sendCardStage()
	end
end

--播放开奖动画 
function CWeishuwuMainScene:playResultEffect(list)
	for i,v in pairs(self.imgMaskList) do
		v:stopAllActions()
		v:setVisible(false)
	end
	for k,v in pairs(list) do
		self.imgMaskList[v+1]:runAction(cc.RepeatForever:create(cc.Blink:create(1,1)))
	end
	if long_compare(weishuwu_manager.chipsChange, self:getTotalBetChips()) >= 0 then
		audio_manager:playOtherSound(6, false)
	else
		audio_manager:playOtherSound(7, false)
	end
end

--停止开奖动画
function CWeishuwuMainScene:stopResultEffect()
	for i,v in pairs(self.imgMaskList) do
		v:stopAllActions()
		v:setVisible(false)
	end
end

--发牌
function CWeishuwuMainScene:sendCardStage(tipsCards)
	self.alone_ui.panel_ui.Img_BG:setVisible(false)
	weishuwu_manager.alonePanel = false

	-- dump(tipsCards.cardsInfo)
	self.palyerCards = {}
	self.bankerCards = {}
	for k,v in pairs(tipsCards.cardsInfo) do
		-- dump(v.cardsType)
		if v.id == 0 then
			self.bankerCards = v.cards
			-- self.bankerPoint = v.cardsType
		else
			self.palyerCards = v.cards
			-- self.palyerPoint = v.cardsType
		end
	end
	local cardsTypeList = {}
	local cardsList = {}
	for i=1,2 do
		if self.palyerCards[i] ~= nil then
			local temp = {cardId = self.palyerCards[i],endPos = cardEndPosArr[1],node=1,palyerpower=weishuwu_card_data[self.palyerCards[i]].mathpower,}
			table.insert(cardsList, temp)
		end
		if self.bankerCards[i] ~= nil then
			local temp = {cardId = self.bankerCards[i],endPos = cardEndPosArr[2],node=2,bankerpower=weishuwu_card_data[self.bankerCards[i]].mathpower,}
			table.insert(cardsList, temp)
		end
	end
	local gambleCardList = {}
	--玩家是否有补牌
	if self.palyerCards[3] ~= nil then
		local temp = {cardId = self.palyerCards[3],palyergamble=true,gamble = 1, endPos = cardEndPosArr[3],node=1,palyerpower=weishuwu_card_data[self.palyerCards[3]].mathpower,}
		table.insert(gambleCardList, temp)
	end

	--庄家是否有补牌
	if self.bankerCards[3] ~= nil then
		local temp = {cardId = self.bankerCards[3],bankergamble=true,gamble = 2,endPos = cardEndPosArr[4],node=2,bankerpower=weishuwu_card_data[self.bankerCards[3]].mathpower,}
		table.insert(gambleCardList, temp)
	end
	--发手牌
	local sendCardsCallBack = function ()
		for k,v in pairs(cardsList) do
			local function sendCard()
				-- dump(v.palyerPower)
				self.card_ui:addCard(v)
				-- self.card_ui:showCardsType(v)
			end
			performWithDelay(self.card_ui, function ()
				self:showSendHandCardAction(v.endPos, sendCard)
			end, 0.4*k)
		end
	end
	--发补牌
	local sendGambleCardCallBack = function ()
		local function delay_call()
			self:showBlance(true)
		end
		if table.nums(gambleCardList) > 0 then

			local send_first = function ()
				local firstData = gambleCardList[1]
				self.card_ui:showGamble(firstData)
				local function sendCard()
					self.card_ui:addGambleCard(firstData)
				end
				performWithDelay(self.card_ui, function ()
					self:showSendHandCardAction(firstData.endPos, sendCard)
				end, 1.5)
			end

			local send_second = function ()
				if gambleCardList[2] then
					local secondData = gambleCardList[2]
					self.card_ui:showGamble(secondData)
					local function sendCard()
						self.card_ui:addGambleCard(secondData)
					end
					performWithDelay(self.card_ui, function ()
						self:showSendHandCardAction(secondData.endPos, sendCard)
					end, 1.5)
					self:runAction(cc.Sequence:create(cc.DelayTime:create(2.5),cc.CallFunc:create(delay_call)))
				else
					self:runAction(cc.Sequence:create(cc.DelayTime:create(3),cc.CallFunc:create(delay_call)))
				end
			end

			local seq_lst = {}
			table.insert(seq_lst,cc.CallFunc:create(send_first))
			table.insert(seq_lst,cc.DelayTime:create(1.5))
			table.insert(seq_lst,cc.CallFunc:create(send_second))
			local seq_act = cc.Sequence:create(seq_lst)
			self:runAction(seq_act)
		else
			self:runAction(cc.Sequence:create(cc.DelayTime:create(4),cc.CallFunc:create(delay_call)))
		end
	end
	local seq_arr = {}
	table.insert(seq_arr,cc.CallFunc:create(sendCardsCallBack))
	table.insert(seq_arr,cc.DelayTime:create(2))
	table.insert(seq_arr,cc.CallFunc:create(sendGambleCardCallBack))
	local seq = cc.Sequence:create(seq_arr)
	self:runAction(seq)
end

--播发发牌动作
function CWeishuwuMainScene:showSendHandCardAction(endPos, callback)
	audio_manager:playOtherSound(5, false)
	local imgFrame = display.newSpriteFrame(weishuwu_card_data[52].card_big)
    local imgBackCard = cc.Sprite:createWithSpriteFrame(imgFrame)
    self.panel_ui.nodeCardscene:addChild(imgBackCard)
    imgBackCard:setPosition(0,0)
    imgBackCard:setPosition(self.panel_ui.nodePoker:getPosition())

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

--显示点数
function CWeishuwuMainScene:showCardsType(bShow)
end

--结算
function CWeishuwuMainScene:showBlance(bShow)	
	local function showBlancePanel()
		-- body
		self.balance_ui.panel_ui.ImgBg:setVisible(bShow)
		self.alone_ui.panel_ui.Img_BG:setVisible(false)
		weishuwu_manager.alonePanel = false
		self:updateRecord(weishuwu_manager._record)
		self.alone_ui:updateAlone(weishuwu_manager.alone)
		self.alone_ui:updateHero(weishuwu_manager.alone)
		-- self:updateChips()
		self.balance_ui:balance(weishuwu_manager.result)
	end
	if bShow == true then
		self.card_ui:showWiner()
		self:playResultEffect(weishuwu_manager.result)
		performWithDelay(self, function () showBlancePanel() end, 2)
	else
		self.balance_ui.panel_ui.ImgBg:setVisible(bShow)
		self.balance_ui:resetGame()
	end
end

--清理牌
function CWeishuwuMainScene:cleanCard()
	if self.card_ui then
		self.card_ui:restGame()
	end

	if table.nums(self.palyerCards) > 0 then
		self.palyerCards=nil
		self.palyerCards={}
	end
	if table.nums(self.bankerCards) > 0 then
		self.bankerCards=nil
		self.bankerCards={}
	end
end

--历史记录
function CWeishuwuMainScene:updateRecord(recordList)
	print("更新历史记录>>>>>>>>")
	self.isUpdateRecord = true
	self.record_ui:updateRecord(recordList)

	-- if long_compare(table.nums(self.record),0) <= 0 then
	-- 	for k,v in pairs(recordList) do
	-- 		local temp = {winId = v,res = 1 }
	-- 		table.insert(self.record, temp)
	-- 	end
	-- else
	-- 	print("添加表尾元素>>>>>>>>")
	-- 	-- elseif table.nums(self.record) > 0 then
	-- 	local playerTotalChips = 0
	-- 	for area = 0,8 do	
	-- 		if weishuwu_manager.curBetChipsMap[area] ~= nil then		
	-- 			playerTotalChips = playerTotalChips + weishuwu_manager.curBetChipsMap[area]
	-- 		end
	-- 	end	
	-- 	dump(playerTotalChips)

	-- 	if long_compare(weishuwu_manager.chipsChange, self:getTotalBetChips()) > 0 then
	-- 		print("赢>>>>>>>>>")
	-- 		local temp = {winId = recordList[table.nums(recordList)],res = 2,}
	-- 		table.insert(self.record, temp)
	-- 		if table.nums(self.record) > 20 then
	-- 			table.remove(self.record,1)
	-- 		end			
	-- 	elseif long_compare(weishuwu_manager.chipsChange, self:getTotalBetChips()) < 0 then
	-- 		print("输>>>>>>>>>")
	-- 		local temp = {winId = recordList[table.nums(recordList)],res = 3,}
	-- 		table.insert(self.record, temp)
	-- 		if table.nums(self.record) > 20 then
	-- 			table.remove(self.record,1)
	-- 		end
	-- 		-- table.remove(self.record,1)
	-- 	else
	-- 		local temp = {winId = recordList[table.nums(recordList)],res = 1,}
	-- 		table.insert(self.record, temp)
	-- 		if table.nums(self.record) > 20 then
	-- 			table.remove(self.record,1)
	-- 		end
	-- 		-- table.remove(self.record,1)
	-- 	end
	-- end
	-- for k,v in pairs(self.recordItemList) do
	-- 	if v ~= nil then
	-- 		v:setVisible(false)
	-- 		v=nil
	-- 	end
	-- end
	-- -- dump(self.record)
	-- if long_compare(table.nums(self.record),0) > 0 then
	-- 	print("添加历史记录item>>>>>>>>")
	-- 	-- if recordList then
	-- 	local listLen = table.nums(self.record)
	-- 	local function move_callbck()
	-- 		if listLen > 16 then
	-- 		-- if table.nums(recordList) > 16 then
	-- 			local moveAction = cc.MoveBy:create(0.5, cc.p(-33,0))
	-- 			self.panel_ui.pnlRecordItem:runAction(moveAction)
	-- 		end
	-- 	end
	-- 	local function update_callback()

	-- 		for k,v in pairs(self.record) do
	-- 		-- for k,v in pairs(recordList) do
	-- 			-- dump(v.winId)
	-- 			-- table.insert(self.record, v)
	-- 			local num = listLen-16
	-- 			local n = k
	-- 			if num > 0 then
	-- 				n = k-num
	-- 			end 			
	-- 			if n > 0 and n < 17 then			
	-- 				-- dump(v)
	-- 				local item = weishuwuRecordItem.create()
	-- 				local m = v.winId
	-- 				if m == 3 then m = 1 end
	-- 				if m == 4 then m = 3 end
	-- 				self.recordItemList[n] = item
	-- 				self.recordItemList[n]:setPosition(16+32*(n-1),16+32*(m-1))
	-- 				self.recordItemList[n]:setInfo(v.res)
	-- 				self.panel_ui.pnlRecordItem:addChild(item)
	-- 				-- self.recordItemList[n]:setVisible(true)				
	-- 				-- index=index+1
	-- 			end
	-- 		end
	-- 		if listLen > 16 then
	-- 			local moveAction = cc.MoveBy:create(0.01, cc.p(33,0))
	-- 			self.panel_ui.pnlRecordItem:runAction(moveAction)
	-- 		end
	-- 	end
		
	-- 	local move_call_action = cc.CallFunc:create(move_callbck)
 --    	local update_call_action = cc.CallFunc:create(update_callback)
 --    	local seq_arr = {}
 --    	table.insert(seq_arr,move_call_action)
 --    	table.insert(seq_arr,cc.DelayTime:create(0.2))
	-- 	table.insert(seq_arr,update_call_action)
	-- 	local seq = cc.Sequence:create(seq_arr)
	-- 	self:runAction(seq)
	-- end
end

function CWeishuwuMainScene:betButtonHandler(sender,event)
	for k,v in pairs(self.btnBetList) do
		if sender == v then
			weishuwu_manager._selectChipsType = k
			break
		end
	end
end

function CWeishuwuMainScene:registerGroupEvent(obj_lst,call_back)
	-- body
	for k,v in pairs(obj_lst) do
		self.btn_group_info_lst[v] = {call = call_back,mutex = obj_lst,}
		local function __on_group_deal_pro(sender,event_type)
			self:onGroupDealPro(sender,event_type)
		end
		v:addEventListener(__on_group_deal_pro)
	end
end

function CWeishuwuMainScene:onGroupDealPro(sender,event_type)
	for k,v in pairs(self.btn_group_info_lst[sender].mutex) do
		if sender ~= v then
			v:setSelected(false)
		else
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

function CWeishuwuMainScene:regMouseEvent(value)
	local function _on_mouse_move(e)
		self:onMouseMove(e,value)
	end
	local function _on_mouse_down(e)
		-- self:onMouseDown(e)
	end
	local function _on_mouse_up(e)
		-- self:onMouseUp(e)
	end
	local mouse_listener = cc.EventListenerMouse:create()
	mouse_listener:registerScriptHandler(_on_mouse_move,cc.Handler.EVENT_MOUSE_MOVE)
	mouse_listener:registerScriptHandler(_on_mouse_down,cc.Handler.EVENT_MOUSE_DOWN)
	mouse_listener:registerScriptHandler(_on_mouse_up,cc.Handler.EVENT_MOUSE_UP)

	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(mouse_listener,self)
end

function CWeishuwuMainScene:onMouseMove(e,value)
	if value == true then
		local pt = cc.Director:getInstance():convertToGL(e:getLocation())
		for k,v in pairs(self.btnSelectList) do
			local boundingBox = cc.rect(0,0,v:getContentSize().width,v:getContentSize().height)
			local pos = v:convertToNodeSpace(pt)
			if cc.rectContainsPoint(boundingBox, pos) == true then
				self.imgMaskList[k]:setVisible(true)
			else
				self.imgMaskList[k]:setVisible(false)			
			end
		end
	else
		for k,v in pairs(self.imgMaskList) do
			v:setVisible(false)
		end
	end
end

function CWeishuwuMainScene:regTouch()
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

function CWeishuwuMainScene:onTouchEnded(touch, event)
	local a,b = self.record_ui.panel_ui.ImgBg:getPosition()
	--历史记录
	local recordPos = self.record_ui.panel_ui.ImgBg:convertToWorldSpace(cc.p(0,0))
	local recordboundingBox = self.record_ui.panel_ui.ImgBg:getBoundingBox()
	recordboundingBox.x = recordPos.x
	recordboundingBox.y = recordPos.y
	local pt = touch:getLocation()
	-- dump(pt)
	if self.isShowRecordPanel then
		if cc.rectContainsPoint(recordboundingBox, pt) ~= true then		
			self.isShowRecordPanel = false
			self.record_ui.panel_ui.ImgBg:setVisible(false)
			self.record_ui.panel_ui.ImgBg:setTouchEnabled(false)
		end
	end
end