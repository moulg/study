--[[
4S店主场景

]]

local shop4s_ui = require "game.4s_std.script.ui_create.ui_4s_mainscene"

local carRes = {
	"game/4s_std/resource/image/logo/logo/4sshop_game_fl.png",
	"game/4s_std/resource/image/logo/logo/4sshop_game_bc.png",
	"game/4s_std/resource/image/logo/logo/4sshop_game_bm.png",
	"game/4s_std/resource/image/logo/logo/4sshop_game_ad.png",
	"game/4s_std/resource/image/logo/logo/4sshop_game_ft.png",
	"game/4s_std/resource/image/logo/logo/4sshop_game_dz.png",
	"game/4s_std/resource/image/logo/logo/4sshop_game_bk.png",
	"game/4s_std/resource/image/logo/logo/4sshop_game_mz.png",
}
local scheduler = cc.Director:getInstance():getScheduler()
local testTime = {}
local throwTime = 2
local trowBeginPos = {
	[1] = {x = 40, y = 128},
	[2] = {x = 40, y = 1000},
}
local chipsPos = {
	[1] = {x = 445, y  = 615},
	[2] = {x = 633, y  = 615},
	[3] = {x = 820, y  = 615},
	[4] = {x = 1008, y = 615},
	[5] = {x = 445, y  = 413},
	[6] = {x = 632, y  = 413},
	[7] = {x = 820, y  = 413},
	[8] = {x = 1007, y = 413},
}

CFSMainScene = class("CFSMainScene", function ()
	local ret = cc.Layer:create()
	return ret
end)
ModuleObjMgr.add_module_obj(CFSMainScene,"CFSMainScene")

function CFSMainScene.create()
	local layer = CFSMainScene.new()
	if layer ~= nil then
		layer:loading()
		layer:regEnterExit()
	end
	return layer
end

function CFSMainScene:loading()
    self.isLoadEnd = false
    self:initData()

	local info = {
		parent 			= WindowScene.getInstance().game_layer,
		task_call 		= function (percent,index,texture) self:addImageSrc(percent,index,texture) end,
		complete_call 	= function () self:loadEnded() end,
		--task_lst = {[x] = {src = "",},},
		ui_info = {
			back_pic 		= "game/4s_std/resource/image/loading/loading.jpg",
			bar_back_pic 	= "game/4s_std/resource/image/loading/loadingbg.png",
			bar_process_pic = "game/4s_std/resource/image/loading/loading.png",
			b_self_release 	= true,
		},
	}

	info.task_lst = {}
	for i=1,#fs_effect_res_config do
		local item = {src = fs_effect_res_config[i].imageName,}
		info.task_lst[i] = item
	end
	self._loadingTask = LoadingTask.create(info)
end

function CFSMainScene:addImageSrc(percent,index,texture)
	-- print("index = " .. index .. ",plist path  = " .. baccarat_effect_res_config[index].plistPath)

	local cache = cc.SpriteFrameCache:getInstance()
	cache:addSpriteFrames(fs_effect_res_config[index].plistPath)
end

function CFSMainScene:initData()		
	self.tab = {"0","0","0","0","0","0","0","0","0","0"}	
	self.btn_mouse_move_sprite_info_lst = {}
	--存放当前玩家添加的所有筹码
	self.spChipsItem = {}
	--续押
	fs_manager._continueChips = nil
	--当前玩家在每个区域的下注
	fs_manager._chipsNumberList = {0,0,0,0,0,0,0,0}
	--当前每个区域下注的总筹码数
	fs_manager._chipsTotalNumberList = {0,0,0,0,0,0,0,0}
	
	--将筹码清零
    fs_manager._ownChips = 0
    --当前开奖记录
	fs_manager._curRecord = 1
	--所有开奖记录
	fs_manager._recordData = {}
	--当前是否可以下注
	fs_manager._bCanBet = true 
	--是否自动续押
	fs_manager._bAutoContinue = false
	--是否自动退出
	fs_manager._bAutoExit = false
	--总押注
	fs_manager._totalBetChips = 0
	--是否开在开奖之前进入
	fs_manager._beforeStart = false
	fs_manager._playerChipschanges = 0
	fs_manager._bankerChipschanges = 0
end

function CFSMainScene:loadEnded()
	self._loadingTask = nil
	
	self:init_ui()

	local _playerInfo = get_player_info()
	fs_manager._deskId = _playerInfo.myDesksInfo[1].seats[1].tableId
	--显示倒数计时
	self.schedulHandler = scheduler:scheduleScriptFunc(handler(self,self.updateCountdownAndState),1,false)

	-- 添加金币更新事件
	EventUtils.addEventListener(EventUtils.GOLD_CHANGE,self,function () self.chipsPanel:updatePlayerInfo() end)
	--加载音效
	audio_manager:reloadMusicByConfig(fours_music_config)

    self.isLoadEnd = true
    
	self.bankerPanel:updateBankerInfo()
	self.applyListPanel:updateApplyListInfo()
	self.chipsPanel:updatePlayerInfo()
	self:updateLottery(false)
	--初始化续押
	fs_manager._continueChips = nil
	self.chipsPanel:calculateContinue()
	--设置倍数
	self:setMultiple()
	self:resetGame()
	--更新筹码按钮状态
	self:updateChipsBtn()
	--显示彩金池
	self:updateLottery(false)
    --背景音乐
	audio_manager:playBackgroundMusic(1, true)
end
function CFSMainScene:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter();
		elseif event == "exit" then
			self:onExit();
		end
	end

	self:registerScriptHandler(_onEnterOrExit)
end


function CFSMainScene:onEnter()	
end

function CFSMainScene:onExit()
	if self.schedulHandler ~=nil then
		scheduler:unscheduleScriptEntry(self.schedulHandler)
		self.schedulHandler = nil
	end
	
    for k,v in pairs(fs_effect_res_config) do
    	cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile(v.plistPath)
    end

    --check button 组处理
	self.btn_group_info_lst = {}
    --申请排队列表
	fs_manager._applyListData = {}
	--庄家信息
	fs_manager._bankerInfo = {}
	--是否第一次进游戏
	fs_manager._firstEnter = true
	--开奖记录
	fs_manager._recordData = {}
	--恢复下注
	fs_manager._bCanBet = true
	--游戏状态
	fs_manager._state = 1
	--倒计时时间
	fs_manager._countdown = nil
	--当前玩家下注的所有筹码
	self.spChipsItem = {}
	--成绩
	fs_manager._playerScore = 0 
	fs_manager._playerChipschanges = 0
	fs_manager._bankerChipschanges = 0
	fs_manager._listMultiple = nil
	--每个区域下注的筹码个数
	fs_manager._numberList = {[1] = {0,0,0,0,0,0,0,0},
						  [2] = {0,0,0,0,0,0,0,0},
						  [3] = {0,0,0,0,0,0,0,0},
						  [4] = {0,0,0,0,0,0,0,0},
						  [5] = {0,0,0,0,0,0,0,0},
						  [6] = {0,0,0,0,0,0,0,0},
						  [7] = {0,0,0,0,0,0,0,0},
						  [8] = {0,0,0,0,0,0,0,0},
						}
	--是否开在开奖之前进入
	fs_manager._beforeStart = false
	EventUtils.removeEventListener(EventUtils.GOLD_CHANGE,self)
	audio_manager:destoryAllMusicRes()
end

function CFSMainScene:registerGroupEvent(obj_lst,call_back)
	-- body
	for k,v in pairs(obj_lst) do
		self.btn_group_info_lst[v] = {call = call_back,mutex = obj_lst,}
		local function __on_group_deal_pro(sender,event_type)
			self:onGroupDealPro(sender,event_type)
		end
		v:addEventListener(__on_group_deal_pro)
	end
end


function CFSMainScene:onGroupDealPro(sender,event_type)
	for k,v in pairs(self.btn_group_info_lst[sender].mutex) do
		if sender ~= v then
			-- v:setTouchEnabled(true)
			v:setSelected(false)
			-- v:setBright(true)
			self.selectedEffectList[k]:stopAllActions()
			self.selectedEffectList[k]:setVisible(false)
		else
			-- v:setTouchEnabled(false)
			v:setSelected(true)
			self.selectedEffectList[k]:setVisible(true)
			self.selectedEffectList[k]:runAction(cc.RepeatForever:create(cc.RotateBy:create(0.5, 360)))
		end
	end

	--回调函数最后处理
	local func = self.btn_group_info_lst[sender].call
	if func then 
		func(sender,event_type) 
		return
	end
end

function CFSMainScene:init_ui()
	--基础界面
	self.shop4s_ui = shop4s_ui.create()
	self:addChild(self.shop4s_ui.root)
	self.shop4s_ui.root:setPosition(0,0)
	self.shop4s_ui.root:setAnchorPoint(0,0)

	--庄家界面
	self.bankerPanel =  CFSBanker.create()
	self:addChild(self.bankerPanel)
	self.bankerPanel:setPosition(0,0)
	self.bankerPanel:setAnchorPoint(0,0)

	--申请开店列表界面
	self.applyListPanel =  CFSApplyList.create()
	self:addChild(self.applyListPanel)
	self.applyListPanel:setPosition(0,0)
	self.applyListPanel:setAnchorPoint(0,0)

	--创建默认图标
	self:createCardIcons()

	--汽车老虎机
	self.slotMachineCirCleCon = CSlotMachineConCirCle.create(CSlotMachineConCirCle.NORMAL_ALL)
	self:addChild(self.slotMachineCirCleCon)
    self.slotMachineCirCleCon:setAnchorPoint(0,0)
	self.slotMachineCirCleCon:setPosition(0,0)  

	--彩金池老虎机
	self.slotMachineCon = CSlotMachineCon.create(CSlotMachineCon.NORMAL_ALL)
	self:addChild(self.slotMachineCon)
	self.slotMachineCon:setAnchorPoint(0,0)
	self.slotMachineCon:setPosition(626,907)

	--下注界面
	self.chipsPanel =  CFSChipsPanel.create()
	self:addChild(self.chipsPanel, 4)
	self.chipsPanel:setPosition(0,0)
	self.chipsPanel:setAnchorPoint(0,0)
	self.chipsPanel:setVisible(false)
	self.chipsPanel.panel_ui.imgBg:setTouchEnabled(false)
	self.bIsShowBetPanel = false

	--check button 组处理
	self.btn_group_info_lst = {}
	--筹码按钮
	self.btnChipsList = {self.chipsPanel.panel_ui.btnChipsPink, self.chipsPanel.panel_ui.btnChipsGreen, 
		self.chipsPanel.panel_ui.btnChipsBlue, self.chipsPanel.panel_ui.btnChipsBlack,self.chipsPanel.panel_ui.btnChipsCoffe,
	}
	self:registerGroupEvent(self.btnChipsList,function (s,e) self:betButtonHandler(s,e) end)

	self.selectedEffectList = {self.chipsPanel.panel_ui.sprChipEffect1,self.chipsPanel.panel_ui.sprChipEffect2,self.chipsPanel.panel_ui.sprChipEffect3,
		self.chipsPanel.panel_ui.sprChipEffect4,self.chipsPanel.panel_ui.sprChipEffect5,
	}
	for k,v in pairs(self.selectedEffectList) do
		v:setVisible(false)
	end

    --开奖区标记
    self.imgMaskList = {self.shop4s_ui.imgMaskFL,self.shop4s_ui.imgMaskBC,self.shop4s_ui.imgMaskBM,self.shop4s_ui.imgMaskAD,
        self.shop4s_ui.imgMaskFT,self.shop4s_ui.imgMaskDZ,self.shop4s_ui.imgMaskBK,self.shop4s_ui.imgMaskMZ,
    }
	
	--历史记录
	self.imgRecordList1 = {self.chipsPanel.panel_ui.imgIconBg1,self.chipsPanel.panel_ui.imgIconBg2,
		self.chipsPanel.panel_ui.imgIconBg3,self.chipsPanel.panel_ui.imgIconBg4,
	}
	self.imgRecordList2 = {self.shop4s_ui.imgIconBg1,self.shop4s_ui.imgIconBg2,
		self.shop4s_ui.imgIconBg3,self.shop4s_ui.imgIconBg4,
	}
	for i=1,4 do
		self.imgRecordList1[i]:setVisible(false)
		self.imgRecordList2[i]:setVisible(false)
	end

	self:createLotteryGridObj()
	
	self:registerHandler()
end

function CFSMainScene:betButtonHandler(sender,event)
	for k,v in pairs(self.btnChipsList) do
		if sender == v then
			fs_manager._betChipsType = k
			break
		end
	end
	self:playSelectedBtnChipsEffect()
end

function CFSMainScene:playSelectedBtnChipsEffect()
	for k,v in pairs(self.selectedEffectList) do
		v:stopAllActions()
		v:setVisible(false)
	end
	if fs_manager._betChipsType then
		for k,v in pairs(self.selectedEffectList) do
			if (k == fs_manager._betChipsType) and self.btnChipsList[k]:isEnabled() and self.btnChipsList[k]:isEnabled() then
				v:setVisible(true)
				v:runAction(cc.RepeatForever:create(cc.RotateBy:create(0.5, -360)))
			end
		end
	end
end

--根据当前筹码更新筹码按钮状态
function CFSMainScene:updateChipsBtn()
	if fs_manager._state == 2 then
		if self.applyListPanel:isBanker() == false then
			self.chipsPanel.panel_ui.btnExchange:setTouchEnabled(true)
			self.chipsPanel.panel_ui.btnExchange:setBright(true)
			for i,v in pairs(self.btnChipsList) do
				if (long_compare(fs_manager._ownChips, 10^i) >= 0) then
					v:setTouchEnabled(true)
					v:setBright(true)
					 
				else
					v:setSelected(false)
					v:setTouchEnabled(false)
					v:setBright(false)
				end
			end
			self:playSelectedBtnChipsEffect()
		else
			self.chipsPanel:setButtonsEnable(false)
		end
	else
		self.chipsPanel:setButtonsEnable(false)
	end
end

function CFSMainScene:setShowBetPanel(bShow)
	local function callback()
		self.bIsShowBetPanel = bShow
		self.chipsPanel:setVisible(bShow)
		self.chipsPanel.panel_ui.imgBg:setTouchEnabled(bShow)
	end
	performWithDelay(self,callback, 0.5)

end

function CFSMainScene:registerHandler()
	--下注
	self.shop4s_ui.btnBet:onTouch(function(e)
		if e.name == "ended" then
			self:setShowBetPanel(self.bIsShowBetPanel == false)
		end
	end)
	--设置
	self.shop4s_ui.btnSet:onTouch(function(e)
		if e.name == "ended" then
			local gameid = get_player_info().curGameID
			if gameid ~= nil then
				WindowScene.getInstance():showDlgByName("CHallSet")
			end
		end
	end)
	-- 退出
	self.shop4s_ui.btnExit:onTouch(function(e)
		if e.name == "ended" then
			local game_FoursShop = WindowScene.getInstance():getModuleObjByClassName("CFSMainScene")
			if game_FoursShop then
				local function tipsCallBack()
					send_foursshop_ReqExitTable()
				end

				if long_compare(fs_manager._bankerInfo.playerId, get_player_info().id) == 0 then
					if (fs_manager._state == 2) or (fs_manager._state == 3) then
						TipsManager:showTwoButtonTipsPanel(77, {}, true, tipsCallBack)
					else
						tipsCallBack()
					end
				else
					if fs_manager._state == 2 then
						if long_compare(game_FoursShop:getTotalBetChips(),0) ~= 0 then
							TipsManager:showOneButtonTipsPanel(72, {}, true)
						else
							tipsCallBack()
						end
					elseif fs_manager._state == 3 then
						TipsManager:showTwoButtonTipsPanel(73, {}, true, tipsCallBack)
					else
						tipsCallBack()
					end
				end
			end	
		end
	end)
end
--添加结算界面
function CFSMainScene:addSettleAccountsPanel()
	--结算界面
	if self.settleAccountsPanel == nil then 
		self.settleAccountsPanel =  CFSSettleAccounts.create()
		self:addChild(self.settleAccountsPanel, 100)
		self.settleAccountsPanel:setPosition(0,0)
		self.settleAccountsPanel:setAnchorPoint(0,0)
	end
	self.settleAccountsPanel:balance()
end
--移除结算界面
function CFSMainScene:removeSettleAccountsPanel()
	if self.settleAccountsPanel ~= nil then
		self.settleAccountsPanel:removeFromParent()
		self.settleAccountsPanel = nil
	end
end

--创建默认图标
function CFSMainScene:createCardIcons()
	for k,v in pairs(fs_bonus_iconXY_config) do
		local sprite = cc.Sprite:create(carRes[v.iconId])
		sprite:setAnchorPoint(0.5,0.5)
		sprite:setPosition(cc.p(v.posX,v.posY))
		self:addChild(sprite)
	end
end
--创建单个旋转图标
function CFSMainScene:createRewardIcons()
	self.slotMachineCirCleCon:clearRewardList()
	local arr = {}
	for i=1,32 do
        local  v = fs_bonus_iconXY_config[i];
		local reward = CFS_rewardBitmap.create()
		reward:initBitmapInfo(i, v.iconId)
		table.insert(arr, reward) 
		reward:setPosition(v.posX, v.posY)
	end
	self._rewardlist = CRewardListCircle.create()
	self._rewardlist:initRewards(arr, self._rewardlist.RANDOM_ROLL)
	self._rewardlist:setPosition(0,0)

	self.slotMachineCirCleCon:addRewardList( self._rewardlist )
	self.slotMachineCirCleCon:setRewardListSpeed( 1 , 1 , 20 , 5 )
	self.slotMachineCirCleCon:startRoll(8)
end
--创建一组旋转图标
function CFSMainScene:createListRewardIcons()
	self.slotMachineCirCleCon:clearRewardList()
	local arr = {}
	for i=1,32 do
        local  v = fs_bonus_iconXY_config[i];
		local reward = CFS_rewardListBitmap.create()
		reward:initBitmapInfo(i, v.iconId)
		table.insert(arr, reward)
		reward:setPosition(v.posX, v.posY)
	end
	self._rewardlist = CRewardListCircle.create()
	self._rewardlist:initRewards(arr, self._rewardlist.ORDER_ROLL)
	self._rewardlist:setPosition(0,0)

	self.slotMachineCirCleCon:addRewardList( self._rewardlist )
	self.slotMachineCirCleCon:setRewardListSpeed( 1 , 1 , 60 , 5 )
	self._rewardlist:setFinalReward(fs_manager._finalCarId)
	self._rewardlist:setStartIndex(fs_manager._startIndex)
	audio_manager:playOtherSound(1, false)
	self.slotMachineCirCleCon:startRoll(fs_manager._rewardTime)

	EventUtils.addEventListener( self.slotMachineCirCleCon.ALL_CIRCLE_STOP, self, function ()
		if self.slotMachineCirCleCon._rewardListVec ~= nil then
			for i,v in pairs(self.slotMachineCirCleCon._rewardListVec) do
				for k,j in pairs(v._rewards) do
					if j.myIndex ~= fs_manager._finalId then
						j:setVisible(false)
                    else
                        j:setVisible(true)  
                        j:runAction(cc.RepeatForever:create(cc.Blink:create(1,1)))
					end
				end
				
			end
		end
		-- if fs_manager._finalCarId ~= nil then 
		-- 	self.imgMaskList[fs_manager._finalCarId]:runAction(cc.RepeatForever:create(cc.Blink:create(1,1)))
		-- end
		-- self:PlayMaskBlinkAnim()
		audio_manager:playOtherSound(3, false)
	end, true )
end
--播放开奖时的闪动动画
function CFSMainScene:PlayMaskBlinkAnim()
	--停止闪动遮罩 
	-- for i,v in pairs(self.imgMaskList) do
	-- 	v:stopAllActions()
	-- 	v:setVisible(false)
	-- end
	-- if fs_manager._finalCarId ~= nil then 
	-- 	self.imgMaskList[fs_manager._finalCarId]:runAction(cc.RepeatForever:create(cc.Blink:create(1,1)))
	-- end
end
function CFSMainScene:playLotteryBgAnim()
	self:stopLotteryBgAnim()
	self.lottery = animationUtils.createAndPlayAnimation(self.shop4s_ui.root, fs_effect_config["Handsel"])
	self.lottery:setAnchorPoint(cc.p(0,0))
	self.lottery:setPosition(cc.p(705,205))
	
end

function CFSMainScene:stopLotteryBgAnim()
	if self.lottery then
		--self.lottery:stopAllActions()
		self.lottery:removeFromParent()
		self.lottery = nil
	end
end
--创建彩金池格子
function CFSMainScene:createLotteryGridObj()
	if self.lotteryGridList == nil then
		self.lotteryGridList = {}
	end
	for j=1,10 do
		local obj = CFS_rewardLotteryBitmap.create()
		obj:initBitmapInfo(j)
		obj:setAnchorPoint(cc.p(0.5,0.5))
		obj:setPosition( cc.p(760 + (j-1) * 45, 255))
		self.shop4s_ui.root:addChild(obj)
		self.lotteryGridList[j] = obj
	end	
end
--更新彩金池奖金
function CFSMainScene:updateLottery(bPlayAnimation)
	local str = tostring(fs_manager._lottery)
	local tab = gsplit(str)
    local finaltab = {"0","0","0","0","0","0","0","0","0","0"}
	for i =1 ,#tab do
	    finaltab[10-#tab+i] = tab[i]
	end
	--self.tab = finaltab
	local aimTab = {}
	local bEqual = false
	for i,v in pairs(self.tab) do
		if v ~= finaltab[i] then
			bEqual = true
		end
		if bEqual then
			table.insert(aimTab,i)
		end
	end
	if bEqual then
		self.tab = finaltab
		bEqual = false
	end
	for k=1,10 do
		--最终数字
		self.lotteryGridList[k]:initBitmapInfo(tonumber(finaltab[k]))
	end
	--播放滚动动画和特效
	if (fs_manager._state == 4) and (long_compare(fs_manager._bankerInfo.playerId, 0) == 0) then
		if long_compare(self:getAllPlayerTotalBetChips(),0) ~= 0 then 
			for i,v in pairs(self.lotteryGridList) do
				-- for k,j in pairs(aimTab) do
				-- 	if i == j then
						v:playRollAction()
				-- 	end
				-- end
			end
		end
	end
	if bPlayAnimation == true then 
		audio_manager:playOtherSound(9, false)
		self.lotterySprite = animationUtils.createAndPlayAnimation(self.shop4s_ui.root, fs_effect_config["canjin"], nil)
		self.lotterySprite:setAnchorPoint(cc.p(0.5,0.5))
		self.lotterySprite:setPosition(cc.p(845,935))
		if long_compare(fs_manager._lotteryNum,0) > 0 then
			TipsManager:showOneButtonTipsPanel(79, {fs_manager._lotteryNum}, true)
			fs_manager._lotteryNum = 0
		end
	end
end
--倒计时和游戏状态
function CFSMainScene:updateCountdownAndState(dt)
    --倒计时音效
	if (fs_manager._state == 2) and (fs_manager._countdown <= 3) then 
		audio_manager:playOtherSound(8, false)
	end
    self.shop4s_ui.fntCountdown:setString(fs_manager._countdown)
    self.chipsPanel.panel_ui.fntCountdown:setString(fs_manager._countdown)
    --游戏状态
    if fs_manager._state ~= nil then  
    	self.shop4s_ui.imgState:setTexture("game/4s_std/resource/word/gameState/4sshop_state_" ..fs_manager._state ..".png")
    	self.chipsPanel.panel_ui.imgState:setTexture("game/4s_std/resource/word/gameState/4sshop_state_" ..fs_manager._state ..".png")
    end 
  --   if (fs_manager._state == 1) or (fs_manager._state == 2) then
  --   	self:setShowBetPanel(true)
  --   else
  --   	self:setShowBetPanel(false)
 	-- end 
    
	--倒计时
	if (fs_manager._countdown~=nil) and (fs_manager._countdown>0) then
		fs_manager._countdown = fs_manager._countdown-1
    end
end

--更新开奖记录
function CFSMainScene:updteRecord()
	if table.nums(fs_manager._recordData) > 0 then
		local ListRecordData = {}
		for i=1,4 do
	        if fs_manager._recordData[fs_manager._curRecord + i -1] ~= nil then
	            ListRecordData[i] = fs_manager._recordData[fs_manager._curRecord + i -1]
	        end
		end
		for i,v in ipairs(ListRecordData) do
			if v ~= nil then
				self.imgRecordList1[i]:setTexture("game/4s_std/resource/image/logo/logo_s/4sshop_game_" ..v.finalCarId ..".png")
				self.imgRecordList1[i]:setVisible(true)
				self.imgRecordList2[i]:setTexture("game/4s_std/resource/image/logo/logo_s/4sshop_game_" ..v.finalCarId ..".png")
				self.imgRecordList2[i]:setVisible(true)
			end
		end
	end
end

--添加筹码,根据下注的车标ID和筹码类型添加,isMyBet:0->其它下注，1->当前玩家下注
function CFSMainScene:addChipsToPanelByType(carId,chipsType,isMyBet)
	if isMyBet == 1 then
		self.chipsPanel:playBetResultAnimation(carId)
	end
	audio_manager:playOtherSound(4, false)
end
--清空当前玩家下注的筹码
function CFSMainScene:cleanChipsPanel()
	for i=1,8 do
		fs_manager._chipsTotalNumberList[i]=long_minus(fs_manager._chipsTotalNumberList[i], fs_manager._chipsNumberList[i])
	end
	fs_manager._chipsNumberList = {0,0,0,0,0,0,0,0}
	
	self:updateTotalBetChips()
	self:updatePlayerBetChips()
end
--清空所有筹码
function CFSMainScene:cleanAllChips()
	fs_manager._chipsNumberList = {0,0,0,0,0,0,0,0}
	fs_manager._chipsTotalNumberList = {0,0,0,0,0,0,0,0}
	
	self:updateTotalBetChips()
	self:updatePlayerBetChips()
end

function CFSMainScene:playChipsAnimation()
	if long_compare(fs_manager._playerChipschanges,0) > 0 then
		local chipsImglist = {}
		local addChips = fs_manager._playerChipschanges
		local numlist = {0,0,0,0,0,0,0,0}
		while(long_compare(addChips,0)>0)
	    do 
	    	addChips = fs_manager:getChipsNumByValue(addChips)
		end
	    for k,j in pairs(fs_manager._chipsNumListPerType) do
	    	if j > 0 then
	    		for n=1,j do
	    			local  res = "game/4s_std/resource/image/chips/chips_s_" ..k ..".png"
					local sprite = cc.Sprite:create(res)
					if sprite ~= nil then
						self.betPanel.pnlChips:addChild(sprite)
						table.insert(chipsImglist,1,sprite)
						
						sprite:setAnchorPoint(cc.p(0.5,0.5))
				   		local x =  math.random(10,280);
				   		local y = math.random(890,1040);
						sprite:setPosition(cc.p(x,y))
						numlist[k] = numlist[k]+1
						if numlist[k] >= 10 then 
							break
						end
					end
	    		end 
	    	end
	    end	
		fs_manager._chipsNumListPerType = {0,0,0,0,0,0,0,0}

		local mod = 1
		for k,sprite in pairs(chipsImglist) do
			local params = {}
			params.endPos_x = trowBeginPos[mod].x
			params.endPos_y = trowBeginPos[mod].y
	        params.flyendCallback = function ()
				sprite:removeFromParent()
				sprite = nil
			end
			CFlyAction:Fly(sprite, throwTime, params, CFlyAction.FLY_TYPE_CHIPS)
		end
		chipsImglist = {}
	end
end
--重置
function CFSMainScene:resetGame()
	--重置续押按钮
    self.chipsPanel.panel_ui.btnContinued:setTouchEnabled(false)
    self.chipsPanel.panel_ui.btnContinued:setBright(false)
     --重置清空按钮
    self.chipsPanel.panel_ui.btnClean:setTouchEnabled(false)
    self.chipsPanel.panel_ui.btnClean:setBright(false)
    --更新申请列表
    if self.applyListPanel ~= nil then 
    	self.applyListPanel:updateApplyListInfo()
    end
    --下注按钮
    self.shop4s_ui.btnBet:setTouchEnabled((self.applyListPanel:isBanker() == false) and (fs_manager._state <= 2) or (fs_manager._state <= 1))
    self.shop4s_ui.btnBet:setBright((self.applyListPanel:isBanker() == false) and (fs_manager._state <= 2) or (fs_manager._state <= 1))
    if fs_manager._state == 1 then

    	self:setShowBetPanel(true)
		--刷新庄家信息 
    	self.bankerPanel:updateBankerInfo()
    	fs_manager._finalCarId = nil
		fs_manager._carId = nil
		fs_manager._finalId = nil
		fs_manager._bankerChipschanges = 0
		fs_manager._playerChipschanges = 0
    	--重置下注区当前玩家的下注数和总的下注数
    	fs_manager._chipsNumberList = {0,0,0,0,0,0,0,0}
		fs_manager._chipsTotalNumberList = {0,0,0,0,0,0,0,0}
		--每个区域下注的筹码个数
		fs_manager._numberList = {[1] = {0,0,0,0,0,0,0,0},
						  [2] = {0,0,0,0,0,0,0,0},
						  [3] = {0,0,0,0,0,0,0,0},
						  [4] = {0,0,0,0,0,0,0,0},
						  [5] = {0,0,0,0,0,0,0,0},
						  [6] = {0,0,0,0,0,0,0,0},
						  [7] = {0,0,0,0,0,0,0,0},
						  [8] = {0,0,0,0,0,0,0,0},
						}
		self:updatePlayerBetChips()
		self:updateTotalBetChips()
		--移除结算界面
		self:removeSettleAccountsPanel()
		--停止闪动格子
		if self.slotMachineCirCleCon._rewardListVec ~= nil then
			for i,v in pairs(self.slotMachineCirCleCon._rewardListVec) do
				for k,j in pairs(v._rewards) do
					j:stopAllActions()
					j:setVisible(false)
				end
			end	
		end
		--清空老虎机
    	self.slotMachineCirCleCon:clearRewardList()
    	self.chipsPanel:setButtonsEnable(false)
    	self.chipsPanel:setAddAndSubtractBtn(true)
    	self:playSelectedBtnChipsEffect() 
    elseif fs_manager._state == 2 then
    	self.chipsPanel:setButtonsEnable(self.applyListPanel:isBanker() == false)
    	self:updateChipsBtn()
    	self.chipsPanel:calculateContinue()
    	self:setSelectBtnEnable(self.applyListPanel:isBanker() == false)
    	self:playSelectedBtnChipsEffect()
    	self:createRewardIcons()
    	self:setShowBetPanel(self.applyListPanel:isBanker() == false)
    	fs_manager._beforeStart = true
    	--恢复下注
		fs_manager._bCanBet = true
    elseif fs_manager._state == 3 then
    	self:setShowBetPanel(false)
    	self.chipsPanel:setButtonsEnable(false)
    	self.chipsPanel:setAddAndSubtractBtn(false)
		self:setSelectBtnEnable(false)
		self:playSelectedBtnChipsEffect()
	    fs_manager._continueChips = nil
	    if fs_manager._beforeStart == true then
	    	self:createListRewardIcons()
	    	self:playLotteryBgAnim()
	    else
	    	self:createRewardIcons()
	    end
    elseif fs_manager._state == 4 then
    	--清空老虎机
    	-- self.slotMachineCirCleCon:clearRewardList()

    	self:setShowBetPanel(false)
    	
    	if long_compare(fs_manager._playerChipschanges,0) > 0 then
    		audio_manager:playOtherSound(7, false)
    	else
    		audio_manager:playOtherSound(6, false)
    	end
    	
    	if fs_manager._beforeStart == true then
    		--更新续押记录值
	    	if long_compare(self:getTotalBetChips(), 0) ~= 0 then
	    		fs_manager._continueChips = fs_manager._chipsNumberList
	    	end
	    	--移除筹码
	    	local function bankerCallBack()
	    		self:cleanAllChips()
	    	end 
	    	local function playerCallBack()
	    		-- self:playChipsAnimation()
	    	end
	    	local banker_call_action = cc.CallFunc:create(bankerCallBack)
	    	local plyerer_call_action = cc.CallFunc:create(playerCallBack)
	    	local seq_arr = {}
	    	table.insert(seq_arr,banker_call_action)
	    	table.insert(seq_arr,cc.DelayTime:create(2))
			table.insert(seq_arr,plyerer_call_action)
			local seq = cc.Sequence:create(seq_arr)
			self:runAction(seq)
			
    		--停止彩金池背景动画
    		self:stopLotteryBgAnim()
    		--添加结算界面
	    	self:addSettleAccountsPanel()
	    	--更新彩金池
	    	self:updateLottery(fs_manager._bTriggerLottery)
	    	--重置彩金触发		
			fs_manager._bTriggerLottery = false
	    	--刷新玩家信息
	    	fs_manager._playerScore = long_minus(long_plus(fs_manager._playerScore, fs_manager._playerChipschanges), self:getTotalBetChips())
	    	self.chipsPanel:updatePlayerInfo()
	    	--刷新庄家信息 
	    	self.bankerPanel:updateBankerInfo()
	    	--刷新开奖记录信息
	    	self:updteRecord()
	    end
    	
    end
end
--显示当前玩家在每个区域下注的总数
function CFSMainScene:updatePlayerBetChips()
	self.chipsPanel:updatePlayerBetChips()
end
--显示每个区域所有玩家下注的总数
function CFSMainScene:updateTotalBetChips()
	self.chipsPanel:updateTotalBetChips()
end
--设置倍数
function CFSMainScene:setMultiple()
	self.chipsPanel:setMultiple()
end

--设置下注区按钮是否可点
function CFSMainScene:setSelectBtnEnable(value)
	self.chipsPanel:setSelectBtnEnable(value)
end

--获取玩家当前下注的总筹码数
function CFSMainScene:getTotalBetChips()
	local totalBetChips = 0
	for i,v in pairs(fs_manager._chipsNumberList) do
		totalBetChips = long_plus(totalBetChips, v)
	end
	return totalBetChips
end
--获取所有玩家下注的总筹码数
function CFSMainScene:getAllPlayerTotalBetChips()
	local totalBetChips = 0
	for i,v in pairs(fs_manager._chipsTotalNumberList) do
		totalBetChips = long_plus(totalBetChips, v)
	end
	return totalBetChips
end
----获取玩家当前续押的总筹码数
function CFSMainScene:getTotalContinueBetChips() 
	local totalContinueBetChips = 0
	for i,v in pairs(fs_manager._continueChips) do
		totalContinueBetChips = long_plus(totalContinueBetChips, v)
	end
	return totalContinueBetChips	
end
--添加续押筹码
function CFSMainScene:addContinueChips()
	if (fs_manager._continueChips ~= nil) then
		for i,v in pairs(fs_manager._continueChips) do
			fs_manager._chipsTotalNumberList[i] = long_plus(fs_manager._chipsTotalNumberList[i], v)
			fs_manager._chipsNumberList[i] = long_plus(fs_manager._chipsNumberList[i], v)
			while(long_compare(v,0)>0)
			do 
				v = fs_manager:getChipsNumByValue(v)
			end
			for k,j in pairs(fs_manager._chipsNumListPerType) do
				if j > 0 then
				    for n=1,j do
				    	self:addChipsToPanelByType(i,k,1)
				    end
				end
		    end	
			fs_manager._chipsNumListPerType = {0,0,0,0,0,0,0,0}
		end
		self:updateTotalBetChips()
		self:updatePlayerBetChips()
	end
end