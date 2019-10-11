--[[
欢乐五张主场景

]]

--是否进入准备阶段
local bEnterReadyStage = false
--发手牌终点坐标
local cardEndPosArr = {{x = 1280, y = 890}, {x = 1170, y = 600}, {x = 825, y = 410}, {x = 440, y = 590},{x = 350, y = 880},}
--玩家位置坐标
local playerPosArr = {{x = 1770, y = 788}, {x = 1540, y = 420}, {x = 850, y = 130}, {x = 330, y = 420},{x = 160, y = 790},}
--下注筹码坐标
local chipsEndPosArr = {x=960,y=550}

--投掷范围
local THROW_WIDTH = 360
local THROW_HEIGHT = 160
--发牌速度
local SEND_CARD_SPEED = 0.3  
--筹码图标
local sideResPathlist = {"lobby/resource/chips/70/1.png",
	"lobby/resource/chips/70/10.png",
	"lobby/resource/chips/70/100.png",
	"lobby/resource/chips/70/1k.png",
	"lobby/resource/chips/70/1w.png",
	"lobby/resource/chips/70/10w.png",
	"lobby/resource/chips/70/100w.png",
	"lobby/resource/chips/70/1000w.png",}
--每个位置上的筹码数量
-- local chipsNum = {[1]={0,0,0,0,0,0,0,0,},
-- 				  [2]={0,0,0,0,0,0,0,0,},
-- 				  [3]={0,0,0,0,0,0,0,0,},
-- 				  [4]={0,0,0,0,0,0,0,0,},}

local panel_ui = require "game.goldflower_std.script.ui_create.ui_goldflower_main"
--local title_create =  require "lobby.script.ui_create.title"




CGoldFlowerMainScene = class("CGoldFlowerMainScene", function ()
	local ret = cc.Node:create()
	return ret
end)
ModuleObjMgr.add_module_obj(CGoldFlowerMainScene,"CGoldFlowerMainScene")

function CGoldFlowerMainScene.create()
	local node = CGoldFlowerMainScene.new()
	if node ~= nil then
		node:loading()
		node:regEnterExit()
	end
	return node
end

function CGoldFlowerMainScene:loading()
    self.isLoadEnd = false
    self:initData()

	local info = {
		parent 			= WindowScene.getInstance().game_layer,
		task_call 		= function (percent,index,texture) self:addImageSrc(percent,index,texture) end,
		complete_call 	= function () self:loadEnded() end,
		--task_lst = {[x] = {src = "",},},
		ui_info = {
			back_pic 		= "game/goldflower_std/resource/image/loading/bg.png",
			bar_back_pic 	= "game/goldflower_std/resource/image/loading/loadingbg.png",
			bar_process_pic = "game/goldflower_std/resource/image/loading/loading.png",
			b_self_release 	= true,
		},
	}

	info.task_lst = {}
	for i=1,#goldflower_effect_res_config do
		local item = {src = goldflower_effect_res_config[i].imageName,}
		info.task_lst[i] = item
	end
	self._loadingTask = LoadingTask.create(info)
end

function CGoldFlowerMainScene:addImageSrc(percent,index,texture)
	print("index = " .. index .. ",plist path  = " .. goldflower_effect_res_config[index].plistPath)

	local cache = cc.SpriteFrameCache:getInstance()
	cache:addSpriteFrames(goldflower_effect_res_config[index].plistPath)
end
function CGoldFlowerMainScene:regEnterExit()
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

function CGoldFlowerMainScene:onEnter()
	--加载音效资源
	audio_manager:reloadMusicByConfig(goldflower_music_config)
end

function CGoldFlowerMainScene:onExit()
	for k,v in pairs(self._playerSeatMap) do
		v:removeTimeDown()
		v:removeFromParent()
	end
	self._playerSeatMap = nil
	
	--是否正在进行游戏
	self._gameIsGoing = false
	--自动跟注
	goldflower_manager.isAutoKeepAny = false
	--自动准备
	goldflower_manager.isAutoReady = false
	--记录
	goldflower_manager._recordData = {}
	--移除动画资源
	for i,v in ipairs(goldflower_effect_res_config) do
		display.removeSpriteFrames(v.plistPath,v.imageName)
	end
	--释放音效资源
	audio_manager:destoryAllMusicRes()
end

function CGoldFlowerMainScene:destoryLoading()
	if self._loadingTask then
    	self._loadingTask:forcedDestory()
        self._loadingTask = nil
    end
end

function CGoldFlowerMainScene:initData()
	--座位列表
	self.seatObjList = {}
	--记录
	goldflower_manager._recordData = {}

	--统计数据
	self.statistics_data = {count = 0, totalCount = 0}

	self.playerChipsImgList = {}
	--下注的总筹码
	self.playerTotalBet = "0"

	--下一个操作
	goldflower_manager.nextOpt = {}
	--是否看过牌
	goldflower_manager.bIsSawCard = false
	--是否已下注
	goldflower_manager.bIsBet = false
	--结算信息
	goldflower_manager.billInfo = nil
	--是否正在播放比牌特效
	goldflower_manager.bIsVersusing = false
	--是否已收到结算消息
	goldflower_manager.bIsGameOver = false
	--是否正在进行游戏
	self._gameIsGoing = false
	--自动跟注
	goldflower_manager.isAutoKeepAny = false
	--自动准备
	goldflower_manager.isAutoReady = false
end

function CGoldFlowerMainScene:loadEnded()
	self._loadingTask = nil
	
	self:init_ui()
	self:initGameSeats(goldflower_manager._seatsMap)
    self.isLoadEnd = true
    -- self:resetGame()
    --背景音乐
	audio_manager:playBackgroundMusic(1, true)
end


function CGoldFlowerMainScene:init_ui()
	--基础界面 
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	-- self.statistics_ui = CGoldFlowerStatistics.create()
	-- self.panel_ui.imgBg:addChild(self.statistics_ui)
	-- self.statistics_ui:setPosition(1150, 1050)
	-- self.statistics_ui.panel_ui.btnStatistics:onTouch(function (e)
	-- 	if e.name == "ended" then
	-- 		self.statistics_ui:showHidePanel()
	-- 	end
	-- end)

	self.panel_ui.fntCapping1:setString("")
	self.panel_ui.fntCapping2:setString("")

	self.panel_ui.imgCardbg:setVisible(false)
	self.bIsShowCardPanel = false

	self.panel_ui.imgJiazhubg:setVisible(false)
	self:showBetPanel(false)
	self.panel_ui.imgAntebg:setVisible(false)

	self:registerHandler()	
end

function CGoldFlowerMainScene:registerHandler()
	--标题
	local function tipsCallBack()
		send_zjh_ReqExitTable()
	end

	local function closeFunc()
		if self._gameIsGoing then
			TipsManager:showTwoButtonTipsPanel(36, {}, true, tipsCallBack)
		else
			tipsCallBack()
		end
	end
	-- local title = WindowScene.getInstance():getModuleObjByClassName("CTableTitleExt")
	-- if title then
	-- 	title:setCloseFunc(closeFunc)
	-- end
    
    --退出
	self.panel_ui.btnExit:onTouch(function (e)
		if e.name == "ended" then
			closeFunc()
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
	--准备
	self.panel_ui.btnReady:onTouch(function (e)
		if e.name == "ended" then
			self:readyClickHandler(function ()
				send_zjh_ReqReady()
			end)
		end
	end)

	--换桌
	self.panel_ui.btnChangeTable:onTouch(function (e)
		if e.name == "ended" then
			send_zjh_ReqExchangeTable()
		end
	end)

	--兑换
	self.panel_ui.btnExchange:onTouch(function (e)
		if e.name == "ended" then
			dump(e)
			print("gold = " ..get_player_info().gold)
			print("chips = " ..goldflower_manager._ownChips)

			TipsManager:showExchangePanel(goldflower_manager._ownChips, get_player_info().gold)
		end
	end)
	--牌型
	self.panel_ui.btnCardPatterns:onTouch(function (e)
		if e.name == "ended" then
			if self.bIsShowCardPanel == false then
				self.bIsShowCardPanel = true
				self.panel_ui.imgCardbg:setVisible(true)
				self.panel_ui.imgCardbg:setTouchEnabled(true)
			else
				self.bIsShowCardPanel = false
				self.panel_ui.imgCardbg:setVisible(false)
				self.panel_ui.imgCardbg:setTouchEnabled(false)
			end
		end
	end)
	--看牌
	self.panel_ui.btnKanpai:onTouch(function (e)
		if e.name == "ended" then
			self:showVersusEffect(false)
			self:showAddBetPanel(false)
			send_zjh_ReqSeeCard()
		end
	end)
	--跟注
	self.panel_ui.btnGenzhu:onTouch(function (e)
		if e.name == "ended" then
			print("跟注")
			self:showVersusEffect(false)
			self:showAddBetPanel(false)
			local requireChips = goldflower_manager.nextOpt.nextBetChips
			if self._playerSeatMap[goldflower_manager._mySeatOrder].bIsSawCard then 
				requireChips = long_multiply(goldflower_manager.nextOpt.nextBetChips,2) 
			end

			print("跟注筹码：" ..requireChips)
			if long_compare(goldflower_manager._ownChips,requireChips) >= 0 then
				send_zjh_ReqBet({chips = requireChips})
			else
				TipsManager:showGoldExchangePanel(goldflower_manager._ownChips, get_player_info().gold)
			end
		end
	end)
	--加注
	self.panel_ui.btnJiazhu:onTouch(function (e)
		if e.name == "ended" then
			self:showVersusEffect(false)
			self:showAddBetPanel(true)
		end
	end)
	--比牌
	self.panel_ui.btnBipai:onTouch(function (e)
		if e.name == "ended" then
			print("比牌")
			if long_compare(goldflower_manager._ownChips,goldflower_manager.nextOpt.nextBetChips) >= 0 then
				self:showAddBetPanel(false)
				self.panel_ui.btnBipai:setVisible(false)
				self:showVersusEffect(true)
			else
				TipsManager:showGoldExchangePanel(goldflower_manager._ownChips, get_player_info().gold)
			end
			
		end
	end)
	--取消
	self.panel_ui.btnCancel:onTouch(function (e)
		if e.name == "ended" then
			self:showVersusEffect(false)
			self.panel_ui.btnBipai:setVisible(true)
		end
	end)
	--弃牌
	self.panel_ui.btnQipai:onTouch(function (e)
		if e.name == "ended" then
			print("弃牌")
			self:showVersusEffect(false)
			self:showAddBetPanel(false)
			send_zjh_ReqDiscard()
			self:exitBetStage(goldflower_manager.nextOpt.nextOptOrder)
		end
	end)
	--加注1
	self.panel_ui.btnAddChip1:onTouch(function (e)
		if e.name == "ended" then
			print("加注1")
			self:showVersusEffect(false)
			local playerInfo = get_player_info()
			local roomInfo = playerInfo:get_cur_roomInfo()
			local requireChips =roomInfo.chip1
			if self._playerSeatMap[goldflower_manager._mySeatOrder].bIsSawCard then
				requireChips = long_multiply(requireChips,2)
			end
			if long_compare(goldflower_manager._ownChips,requireChips) >= 0 then
				print("加注数：" ..requireChips)
				send_zjh_ReqBet({chips = requireChips})
				self:showAddBetPanel(false)
			else
				TipsManager:showGoldExchangePanel(goldflower_manager._ownChips, get_player_info().gold)
			end
		end
	end)
	--加注2
	self.panel_ui.btnAddChip2:onTouch(function (e)
		if e.name == "ended" then
			print("加注2")
			self:showVersusEffect(false)
			local playerInfo = get_player_info()
			local roomInfo = playerInfo:get_cur_roomInfo()
			local requireChips =roomInfo.chip2
			if self._playerSeatMap[goldflower_manager._mySeatOrder].bIsSawCard then
				requireChips = long_multiply(requireChips,2)
			end
			if long_compare(goldflower_manager._ownChips,requireChips) >= 0 then
				print("加注数：" ..requireChips)
				send_zjh_ReqBet({chips = requireChips})
				self:showAddBetPanel(false)
			else
				TipsManager:showGoldExchangePanel(goldflower_manager._ownChips, get_player_info().gold)
			end
		end
	end)
	--加注3
	self.panel_ui.btnAddChip3:onTouch(function (e)
		if e.name == "ended" then
			print("加注3")
			self:showVersusEffect(false)
			local playerInfo = get_player_info()
			local roomInfo = playerInfo:get_cur_roomInfo()
			local requireChips =roomInfo.chip3
			if self._playerSeatMap[goldflower_manager._mySeatOrder].bIsSawCard then
				requireChips = long_multiply(requireChips,2)
			end
			if long_compare(goldflower_manager._ownChips,requireChips) >= 0 then
				print("加注数：" ..requireChips)
				send_zjh_ReqBet({chips = requireChips})
				self:showAddBetPanel(false)
			else
				TipsManager:showGoldExchangePanel(goldflower_manager._ownChips, get_player_info().gold)
			end
		end
	end)
	--关闭加注面板
	self.panel_ui.btnExitAddPanel:onTouch(function (e)
		if e.name == "ended" then
			print("关闭加注面板")
			self:showAddBetPanel(false)
		end
	end)

	--自动准备
    local autoReadyClickCallback = function (e)
        if e.name == "selected" then
            goldflower_manager.isAutoReady = true
        elseif e.name == "unselected" then
            goldflower_manager.isAutoReady = false
        end
    end
    self.panel_ui.sbtnAutoReady:onEvent(autoReadyClickCallback)
    --自动跟注
    local autoKeepBetClickCallback = function (e)
        if e.name == "selected" then
            goldflower_manager.isAutoKeepAny = true
        elseif e.name == "unselected" then
            goldflower_manager.isAutoKeepAny = false
        end
    end
    self.panel_ui.sbtnKeepAny:onEvent(autoKeepBetClickCallback)
end

--是否显示下注界面
function CGoldFlowerMainScene:showBetPanel(bShow)
	self.panel_ui.btnKanpai:setVisible(bShow)
	self.panel_ui.btnGenzhu:setVisible(bShow)
	self.panel_ui.btnJiazhu:setVisible(bShow)
	self.panel_ui.btnBipai:setVisible(bShow)
	self.panel_ui.btnQipai:setVisible(bShow)
	self.panel_ui.btnCancel:setVisible(bShow)
	-- self.panel_ui.sbtnAutoReady:setVisible(bShow == false)
	-- self.panel_ui.sbtnKeepAny:setVisible(bShow == false)
	
	if bShow then
		self.panel_ui.btnKanpai:setEnabled(goldflower_manager.bIsSawCard == false)
		self.panel_ui.btnKanpai:setBright(goldflower_manager.bIsSawCard == false)

		self.panel_ui.btnBipai:setEnabled(goldflower_manager.bIsBet)
		self.panel_ui.btnBipai:setBright(goldflower_manager.bIsBet)

		local playerInfo = get_player_info()
		local roomInfo = playerInfo:get_cur_roomInfo()
		local addBetChip3 = roomInfo.chip3
		local requireChips = goldflower_manager.nextOpt.nextBetChips

		if long_compare(self.playerTotalBet,roomInfo.top) >= 0 then
			self.panel_ui.btnGenzhu:setEnabled(false)
			self.panel_ui.btnGenzhu:setBright(false)
			self.panel_ui.btnJiazhu:setEnabled(false)
			self.panel_ui.btnJiazhu:setBright(false)
		else
			self.panel_ui.btnGenzhu:setEnabled((long_compare(goldflower_manager.nextOpt.nextBetChips ,0) > 0))
			self.panel_ui.btnGenzhu:setBright((long_compare(goldflower_manager.nextOpt.nextBetChips ,0) > 0))
			self.panel_ui.btnJiazhu:setEnabled(long_compare(requireChips,addBetChip3) < 0)
			self.panel_ui.btnJiazhu:setBright(long_compare(requireChips,addBetChip3) < 0)
		end
	end
end

--显示/隐藏选择比牌特效
function CGoldFlowerMainScene:showVersusEffect(bShow,bNotShowBtnBiPai)
	for k,v in pairs(self._playerSeatMap) do
		if k ~= goldflower_manager._mySeatOrder then
			v:showVersusEffect(bShow)
		end
	end
	if (bShow == false) and goldflower_manager.bIsBet then
		if bNotShowBtnBiPai then
			self.panel_ui.btnBipai:setVisible(false)
		else
			self.panel_ui.btnBipai:setVisible(true)
		end
	end
end

--初始化桌位信息
function CGoldFlowerMainScene:initGameSeats(seats)
	--清理座位
	if self._playerSeatMap ~= nil then
		for k,img in pairs(self._playerSeatMap) do
			img:removeFromParent()
		end
	end
	self._playerSeatMap = {}
	for k,seatinfo in pairs(seats) do
		if long_compare(seatinfo.playerId, 0) ~= 0 then 
			local realOrder = goldflower_manager:getRealOrder(seatinfo.order)
			local seatObj = CGoldFlowerPlayerExt.create(realOrder)
			self.panel_ui.nodePlayer:addChild(seatObj)
			self.seatObjList[realOrder] = seatObj
			self.seatObjList[realOrder]:setInfo(seatinfo)
			self.seatObjList[realOrder]:setChips(seatinfo.chips)
			self.seatObjList[realOrder]:setRealOrder(realOrder)
			self._playerSeatMap[seatinfo.order] = self.seatObjList[realOrder]
		end
	end
	--进入准备阶段
	self:enterReadyStage()
end

--其它玩家进桌
function CGoldFlowerMainScene:OtherPlayerEnterTable(memberInfo)
	local realOrder= goldflower_manager:getRealOrder(memberInfo.order)
	local seatObj = CGoldFlowerPlayerExt.create(realOrder)
	self.panel_ui.nodePlayer:addChild(seatObj)
	self.seatObjList[realOrder] = seatObj
	self.seatObjList[realOrder]:setInfo(memberInfo)
	self.seatObjList[realOrder]:setVisible(true)
	self.seatObjList[realOrder]:setChips(memberInfo.chips)
	self.seatObjList[realOrder]:setRealOrder(realOrder)
	self._playerSeatMap[memberInfo.order] = self.seatObjList[realOrder]
end

--删除玩家
function CGoldFlowerMainScene:removePlayer(order)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:removeTimeDown()
		seatObj:clearGameInfo()
		seatObj:removeFromParent()
		self._playerSeatMap[order] = nil
	end
end
--玩家准备
function CGoldFlowerMainScene:setPlayerReady(order)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:setPlayerReady(true)
	end
	
	--离开准备阶段
	if goldflower_manager._mySeatOrder == order then
		-- self:clearWinOrLostEffect()
		self:exitReadyStage()
	end
	--开始游戏
	--self:startGame()
end

--进入准备阶段
function CGoldFlowerMainScene:enterReadyStage()
	local seatinfo= goldflower_manager._seatsMap[goldflower_manager._mySeatOrder]
	if seatinfo.state == 1 then
		local seatObj = self._playerSeatMap[goldflower_manager._mySeatOrder]
		seatObj:startTimeDown(1,function ()
			send_zjh_ReqExitTable()
		end)

		self.panel_ui.btnChangeTable:setVisible(true)
		self.panel_ui.btnReady:setVisible(true)
		self.panel_ui.btnExchange:setVisible(true)
		self.panel_ui.btnCardPatterns:setVisible(true)

		--显示房间底注和封顶值
		local playerInfo = get_player_info()
		local roomInfo = playerInfo:get_cur_roomInfo()
		self.panel_ui.fntCapping1:setString(roomInfo.top)
		self.panel_ui.fntCapping2:setString(roomInfo.base)

		if goldflower_manager.isAutoReady then
			self:readyClickHandler(function ()
					send_zjh_ReqReady()
				end)
		end
	end
end

--离开准备阶段
function CGoldFlowerMainScene:exitReadyStage()
	self.panel_ui.btnChangeTable:setVisible(false)
	self.panel_ui.btnReady:setVisible(false)
	self.panel_ui.btnExchange:setVisible(false)
	-- self.panel_ui.btnCardPatterns:setVisible(false)
end


--准备
function CGoldFlowerMainScene:readyClickHandler(callback)
	local roomInfo = get_player_info():get_cur_roomInfo()
	local myChips = goldflower_manager._ownChips
	print("minOne = " ..roomInfo.top)
	print("myChips = " ..myChips)
	if long_compare(roomInfo.top, myChips) >= 0 then
		TipsManager:showExchangePanel(myChips, get_player_info().gold, callback)
	else
		send_zjh_ReqReady()
	end
end
--玩家 进入下注阶段
function CGoldFlowerMainScene:enterBetStage()
	local callback = function()
		if goldflower_manager._mySeatOrder == goldflower_manager.nextOpt.nextOptOrder then
			send_zjh_ReqDiscard()
		end
		self:exitBetStage(goldflower_manager.nextOpt.nextOptOrder)
	end
	local seatObj = self._playerSeatMap[goldflower_manager.nextOpt.nextOptOrder]
	if seatObj then
		seatObj:startTimeDown(2,callback)
	end

	if goldflower_manager._mySeatOrder == goldflower_manager.nextOpt.nextOptOrder then
		if goldflower_manager.isAutoKeepAny then
		   self:autoKeepAny()
		else
		   self:showBetPanel(true)
		end
	end
end

--自动跟注
function CGoldFlowerMainScene:autoKeepAny()
	local playerInfo = get_player_info()
	local roomInfo = playerInfo:get_cur_roomInfo()
	local requireChips = goldflower_manager.nextOpt.nextBetChips
	if long_compare(requireChips ,0) > 0 then
		if long_compare(self.playerTotalBet,roomInfo.top) >= 0 then
			local restPlayerList = {}
			for k,v in pairs(self._playerSeatMap) do
				if (v.bIsFail == false) and (v.order ~= goldflower_manager._mySeatOrder) then
					restPlayerList[#restPlayerList+1] = v
				end
			end
			local restNum = table.nums(restPlayerList)
			local playerId = restPlayerList[math.random(restNum)].playerId
			print("自动随机比牌")
			send_zjh_ReqVersus({other = playerId})
		else
			if self._playerSeatMap[goldflower_manager._mySeatOrder].bIsSawCard then 
				requireChips = long_multiply(requireChips,2) 
			end

			print("跟注筹码：" ..requireChips)
			if long_compare(goldflower_manager._ownChips,requireChips) >= 0 then
				send_zjh_ReqBet({chips = requireChips})
			else
				TipsManager:showGoldExchangePanel(goldflower_manager._ownChips, get_player_info().gold)
			end
		end
	else
		requireChips = roomInfo.chip1
		if self._playerSeatMap[goldflower_manager._mySeatOrder].bIsSawCard then 
			requireChips = long_multiply(requireChips,2) 
		end
		print("跟注筹码：" ..requireChips)
		send_zjh_ReqBet({chips = requireChips})
	end
end

--显示/隐藏加注界面
function CGoldFlowerMainScene:showAddBetPanel(bShow)
	self.panel_ui.imgJiazhubg:setVisible(bShow)
	if bShow then
		local playerInfo = get_player_info()
		local roomInfo = playerInfo:get_cur_roomInfo()
		-- dump(roomInfo)
		local addBetChip1 = roomInfo.chip1
		local addBetChip2 = roomInfo.chip2
		local addBetChip3 = roomInfo.chip3
		local requireChips = goldflower_manager.nextOpt.nextBetChips
		
		if (self._playerSeatMap[goldflower_manager._mySeatOrder].bIsSawCard) then
			addBetChip1 = long_multiply(roomInfo.chip1,2)
			addBetChip2 = long_multiply(roomInfo.chip2,2)
			addBetChip3 = long_multiply(roomInfo.chip3,2)
			requireChips = long_multiply(goldflower_manager.nextOpt.nextBetChips,2)
		end

		self.panel_ui.fntAddChip1:setString(addBetChip1)
		self.panel_ui.fntAddChip2:setString(addBetChip2)
		self.panel_ui.fntAddChip3:setString(addBetChip3)

		self.panel_ui.btnAddChip1:setEnabled(long_compare(requireChips,addBetChip1) < 0)
		self.panel_ui.btnAddChip1:setBright(long_compare(requireChips,addBetChip1) < 0)
		self.panel_ui.btnAddChip2:setEnabled(long_compare(requireChips,addBetChip2)< 0)
		self.panel_ui.btnAddChip2:setBright(long_compare(requireChips,addBetChip2) < 0)
		self.panel_ui.btnAddChip3:setEnabled(long_compare(requireChips,addBetChip3) < 0)
		self.panel_ui.btnAddChip3:setBright(long_compare(requireChips,addBetChip3) < 0)
	end
end

--玩家 离开下注阶段
function CGoldFlowerMainScene:exitBetStage(order)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:removeTimeDown()
	end

	if order == goldflower_manager._mySeatOrder then
		self:showBetPanel(false)
		self:showVersusEffect(false,true)
	end
end

--添加下注筹码
function CGoldFlowerMainScene:addChipsToPanelByValue(order,value)
	--音效
	audio_manager:playOtherSound(2)

	self.playerTotalBet = long_plus(self.playerTotalBet,value)
	self.panel_ui.fntAnte:setString(self.playerTotalBet)
	self.panel_ui.imgAntebg:setVisible(true)

	local numArr = gsplit(value)
	numArr = table.reverse(numArr) 
	for i,v in ipairs(numArr) do
		for k = 1,v do
			local params = {}
			local realOrder = goldflower_manager:getRealOrder(order)
			params.endPos_x = math.random(chipsEndPosArr.x - THROW_WIDTH, chipsEndPosArr.x + THROW_WIDTH)
			params.endPos_y = math.random(chipsEndPosArr.y - THROW_HEIGHT, chipsEndPosArr.y + THROW_HEIGHT)
			local startP_x = playerPosArr[realOrder+1].x
			local startP_y = playerPosArr[realOrder+1].y
			local sprite = display.newSprite(sideResPathlist[i], startP_x, startP_y)
			sprite:setAnchorPoint(0.5,0.5)
			self.panel_ui.nodeChips:addChild(sprite)
			CFlyAction:Fly(sprite, 0.2, params, CFlyAction.FLY_TYPE_CHIPS)
			-- if self.playerChipsImgList == nil then
			-- 	self.playerChipsImgList = {}
			-- end
			table.insert( self.playerChipsImgList, sprite )
		end
	end
end

--发牌
function CGoldFlowerMainScene:enterSendHandCardStage()
	--隐藏准备图片和下注状态
	for k,seatobj in pairs(self._playerSeatMap) do
		seatobj:setPlayerReady(false)
	end
	
	local count = 0
	local num = table.nums(self._playerSeatMap) * 3
	for i=1,3 do
		for k,seatObj in pairs(self._playerSeatMap) do
			
			local function sendCardCallBack(isFinal)
				seatObj:addOneHandCard()
				--添加底注进入下注阶段
				if isFinal then
					self:betBaseChips()
					self:enterBetStage()
				end
			end
			--发底牌音效
			print("播放发牌音效")
			audio_manager:playOtherSound(8)

			performWithDelay(seatObj, function ()
				count = count + 1
				local realOrder = seatObj:getRealOrder()
				print("realOrder = " ..realOrder)
				self:showSendHandCardAction(cardEndPosArr[seatObj:getRealOrder()+1], sendCardCallBack,count == num)
			end, 0.2*i)
		end
	end
end

--播放发牌动作
function CGoldFlowerMainScene:showSendHandCardAction(endPos, callback, isFinal)
	local imgFrame = display.newSpriteFrame(goldflower_card_data[52].card_big)
    local imgBackCard = cc.Sprite:createWithSpriteFrame(imgFrame)
    self:addChild(imgBackCard)
    imgBackCard:setPosition(cc.p(830,1000))

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
function CGoldFlowerMainScene:updateChips(order, chips)
	local seatObj = self._playerSeatMap[order]
	if seatObj then
		seatObj:setChips(chips)
	end

    local seatInfo = goldflower_manager._seatsMap[order]
    if seatInfo then
        seatInfo.chips = chips
    end
end

--将筹码全都分给winner
function CGoldFlowerMainScene:giveWinnerAllChips(order,chips)
	local realOrder = self._playerSeatMap[order]:getRealOrder()
	for k,img in ipairs(self.playerChipsImgList) do
		local params = {}
		params.endPos_x = playerPosArr[realOrder+1].x
		params.endPos_y = playerPosArr[realOrder+1].y
		--回调选择
		if k == #self.playerChipsImgList then
			params.flyendCallback = function ()
				img:removeFromParent()
				img = nil
			end
		else
			params.flyendCallback = function ()
				img:removeFromParent()
				img = nil
			end
		end

		CFlyAction:Fly(img, 1, params, CFlyAction.FLY_TYPE_CHIPS)
	end

	self.playerTotalBet = "0"

    self.playerChipsImgList = {}
end

--进入结算阶段
function CGoldFlowerMainScene:enterBanlanceStage()
	if goldflower_manager.billInfo then
		for k,v in pairs(goldflower_manager.billInfo) do
			if self._playerSeatMap[v.order] then
				self._playerSeatMap[v.order]:setSeeCardResult(v.cards)
				if long_compare(v.chips,0) > 0 then
					self:giveWinnerAllChips(v.order,v.chips)
				end
			end
		end
		self:showVersusEffect(false,true)
		self._gameIsGoing = false
		--延迟
		performWithDelay(self, function ()
			self:addSettleAccountsPanel()
			self:resetGame()
			--重置准备
			goldflower_manager:resetReadyState()
		end, 1.5)
	end
end

--结算完毕
function CGoldFlowerMainScene:enterCompleteBanlance()
	print("结算完毕")
	for k,seatObj in pairs(self._playerSeatMap) do
	    seatObj:setShowCard(false)
    end
	self:removeSettleAccountsPanel()
	self:showBetPanel(false)
    self:enterReadyStage()
end

--重置
function CGoldFlowerMainScene:resetGame()
	if self._playerSeatMap then
	    for k,seatObj in pairs(self._playerSeatMap) do
		    seatObj:clearGameInfo()
	    end
    end
    
    --清理玩家筹码
    if self.playerChipsImgList then
	    for k,img in pairs(self.playerChipsImgList) do
		    img:removeFromParent()
	    end
    end
	self.playerChipsImgList = {}
	--下注的总筹码
	self.playerTotalBet = "0"

	--下一个操作
	goldflower_manager.nextOpt = {}
	--是否看过牌
	goldflower_manager.bIsSawCard = false
	--是否已下注
	goldflower_manager.bIsBet = false
	--结算信息
	goldflower_manager.billInfo = nil
	--是否正在播放比牌特效
	goldflower_manager.bIsVersusing = false
	--是否已收到结算消息
	goldflower_manager.bIsGameOver = false

	self.panel_ui.imgAntebg:setVisible(false)

	self._gameIsGoing = false
	
	--更新记录
	-- goldflower_manager:updateRecord()
	--各个玩家结算
	-- self._playersBalanceMap = {}
	
end

function CGoldFlowerMainScene:showHideAddRecChipsButton(bIsShow)
	self.panel_ui.btnExchange:setVisible(bIsShow)
	-- self.panel_ui.btnCardPatterns:setVisible(bIsShow)
end

--下底注
function CGoldFlowerMainScene:betBaseChips()
	local playerInfo = get_player_info()
	local roomInfo = playerInfo:get_cur_roomInfo()
	for k,v in pairs(self._playerSeatMap) do
		self:addChipsToPanelByValue(v.order,roomInfo.base)
	end
end

--添加结算界面
function CGoldFlowerMainScene:addSettleAccountsPanel()
	--结算界面
	if self.settleAccountsPanel == nil then 
		local callback = function ()
			self:enterCompleteBanlance()
		end
		self.settleAccountsPanel =  CGoldFlowerSettleAccounts.create(callback)
		self.panel_ui.nodeChips:addChild(self.settleAccountsPanel, 100)
		self.settleAccountsPanel:setPosition(0,0)
		self.settleAccountsPanel:setAnchorPoint(0,0)
	end
	self.settleAccountsPanel:balance()
end

--移除结算界面
function CGoldFlowerMainScene:removeSettleAccountsPanel()
	if self.settleAccountsPanel ~= nil then
		self.settleAccountsPanel:removeFromParent()
		self.settleAccountsPanel = nil
	end
end

--看牌结果
function CGoldFlowerMainScene:setSeeCardResult(cards)
	self._playerSeatMap[goldflower_manager._mySeatOrder]:setSeeCardResult(cards)
end

--看过牌
function CGoldFlowerMainScene:setSawCard(order)
	if self._playerSeatMap[order] then
		self._playerSeatMap[order]:setSawCard()
	end
end

--弃牌
function CGoldFlowerMainScene:setDisCard(order)
	self:exitBetStage(order)
	if self._playerSeatMap[order] then
		self._playerSeatMap[order]:setDisCard()
	end
end

function CGoldFlowerMainScene:setVersusResult(playerId,vsPlayerId,win)
	local order
	local vsOrder
	for k,v in pairs(self._playerSeatMap) do
		if (v.playerId == playerId) then
			order = v.order
		elseif v.playerId == vsPlayerId then
			vsOrder = v.order
		end
	end

	if self._playerSeatMap[order] and self._playerSeatMap[vsOrder] then
		local move_act = cc.CallFunc:create(function ()
			if self._playerSeatMap[order] then self._playerSeatMap[order]:setVersusMoveTo() end
			if self._playerSeatMap[vsOrder] then self._playerSeatMap[vsOrder]:setVersusMoveToVs() end
		end)

		function playEffect()
			audio_manager:playOtherSound(5)
			local effectData = goldflower_effect_config["比牌"]
			self.versusEffect = animationUtils.createAndPlayAnimation(self.panel_ui.nodeEffect,effectData,nil)
		end

		local showResult_act = cc.CallFunc:create(function ()
			if self._playerSeatMap[order] then self._playerSeatMap[order]:setVersusResult(playerId,vsPlayerId,win) end
			if self._playerSeatMap[vsOrder] then self._playerSeatMap[vsOrder]:setVersusResult(playerId,vsPlayerId,win) end
		end)

		local moveBack_act = cc.CallFunc:create(function ()
			if self._playerSeatMap[order] then self._playerSeatMap[order]:setVersusMoveBack(playerId,vsPlayerId,win) end
			if self._playerSeatMap[vsOrder] then self._playerSeatMap[vsOrder]:setVersusMoveBack(playerId,vsPlayerId,win) end
		end)

		local showCardsAfterVersus = cc.CallFunc:create(function ()
			if self._playerSeatMap[order] then self._playerSeatMap[order]:showCardsAfterVersus(playerId,vsPlayerId,win) end
			if self._playerSeatMap[vsOrder] then self._playerSeatMap[vsOrder]:showCardsAfterVersus(playerId,vsPlayerId,win) end
		end)

		function complete_callBack()
			goldflower_manager.bIsVersusing = false
			if goldflower_manager.bIsGameOver then
				self:enterBanlanceStage()
			else
				self:enterBetStage()
			end
		end

		local seq_arr = {}
		table.insert(seq_arr,move_act)
		table.insert(seq_arr,cc.DelayTime:create(0.5))
		table.insert(seq_arr,cc.CallFunc:create(playEffect))
		table.insert(seq_arr,cc.DelayTime:create(2))
		table.insert(seq_arr,showResult_act)
		table.insert(seq_arr,cc.DelayTime:create(1))
		table.insert(seq_arr,moveBack_act)
		table.insert(seq_arr,cc.DelayTime:create(0.5))
		table.insert(seq_arr,showCardsAfterVersus)
		table.insert(seq_arr,cc.DelayTime:create(2.0))
		table.insert(seq_arr,cc.CallFunc:create(complete_callBack))
		local seq = cc.Sequence:create(seq_arr)
		self:runAction(seq)
	end
	
end