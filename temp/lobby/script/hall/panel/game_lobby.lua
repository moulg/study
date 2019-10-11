#remark
--[[
	游戏大厅场景
]]

local lobby_ui

CGameLobby = class("CGameLobby",function()
	local  obj = cc.Node:create()
	return obj
end)
ModuleObjMgr.add_module_obj(CGameLobby,"CGameLobby")

CGameLobby.PANEL_TYPE_FIRST_HALL 	= 0 --一级大厅
CGameLobby.PANEL_TYPE_SECOND_HALL 	= 1 --二级大厅

CGameLobby.PANEL_TYPE_GAME = 101     -- 游戏分类层 （第一层）

CGameLobby.BIG_GAME=5

function CGameLobby.create()
	local obj = CGameLobby.new()
	if obj then obj:init() end
	return obj
end

function CGameLobby:init()
	self:init_data()
	self:init_ui()
	self:registerEE()
	self:registerTouch()
	-- 获取元宝列表
	if shop_goods_config.size == 0 then
		--print("加载商品")
	    send_shop_ReqGoodsItem()
	end
end

function CGameLobby:registerEE()
	local function _onEnterOrExit(event)
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(_onEnterOrExit)
end

function CGameLobby:registerUpdate()
	self:scheduleUpdateWithPriorityLua(function (dt) self:update(dt) end,0)
end


function CGameLobby:registerTouch()
	local touch_node = cc.Node:create()
	self:addChild(touch_node)
	touch_node:setLocalZOrder(100)
	touch_node:setPosition(0,0)
	local function __on_touch_began(touch, event) return self:onTouchBegan(touch) end
    local function __on_touch_moved(touch, event) return self:onTouchMoved(touch) end
    local function __on_touch_ended(touch, event) return self:onTouchEnded(touch) end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(__on_touch_began,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(__on_touch_moved,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(__on_touch_ended,cc.Handler.EVENT_TOUCH_ENDED)
    touch_node:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener,touch_node)
end

function CGameLobby:onEnter()
	self:registerUpdate()
	--签到
	local playerInfo = get_player_info()
	local welfares = playerInfo.welfares 
	for k,v in pairs(welfares) do
		if (v.type == 1) and (v.num > 0) then
			--send_welfare_ReqSignIn()
		end
	end
end

function CGameLobby:onExit()

	EventUtils.removeEventListener(EventUtils.GOLD_CHANGE,self)
	EventUtils.removeEventListener(EventUtils.LEVEL_CHANGE,self)
	EventUtils.removeEventListener(EventUtils.ACER_CHANGE,self)

	AudioEngine.stopMusic(true)
	WaitMessageHit.closeWaitMessageHit()
end

function CGameLobby:onTouchBegan(e)
	return true
end

function CGameLobby:onTouchMoved(e)

	return true
end

function CGameLobby:onTouchEnded(e)
	local pos = e:getLocation()
	return false
end

function CGameLobby:update(dt)

	if self.bk_mus_info.time_add >= self.bk_mus_info.time then
		self.bk_mus_info.time_add = 0
		AudioEngine.playMusic(self.bk_mus_info.src,false)
	else
		self.bk_mus_info.time_add = self.bk_mus_info.time_add + dt
	end
end

function CGameLobby:init_data()
	self.resume_scroll_time = 0.5
	self.resume_scroll_time_add = 0
	self.bresume_scroll = false
	self.PLAY_SCROLLING = true
	self.SCROLLING_P = 0
end

function CGameLobby:init_ui()
	lobby_ui = require("lobby.ui_create.ui_GameHall").create()
	self:addChild(lobby_ui.root)

	lobby_ui.btnClose:loadTextures("lobby/resource/hall_res/Exitbutton.png","")

	self:registerAllEvent()
	self:setPlayerInfo()

	self._curUpPage 	= 0
	self._totalUpPage 	= 0

	-- 显示游戏类别
	self._selectGameType = HallManager.ALL

   -- self:showPanelByType(CGameLobby.PANEL_TYPE_FIRST_HALL)
   	self:createGameTypeItems()
    self:showPanelByType(CGameLobby.PANEL_TYPE_GAME)
	self:resetUIState(false)
	--self.game_cfg_item = game_config[CGameLobby.BIG_GAME]

	--背景音控制
	self.bk_mus_info = {
		src = "common/prop/music/bj1.mp3",
		time = 96,
		time_add = 0,
	}

	AudioEngine.playMusic(self.bk_mus_info.src,true)
end

function CGameLobby:resetUIState(show)
	--lobby_ui.btnLeftUp:setVisible(show)
	--lobby_ui.btnRightUp:setVisible(show)

	--lobby_ui.PageViewGameItem:setBounceEnabled(true)
end


--注册所有事件
function CGameLobby:registerAllEvent()
	--注册关闭窗口事件
	lobby_ui.btnClose:onTouch(function (e) self:onCloseClick(e) end)

	lobby_ui.btnSet:onTouch(function (e)
		if e.name == "ended" then
			WindowScene.getInstance():showDlgByName("CHallSet")
			global_music_ctrl.play_btn_one()
		end
	end)

	local targetPlatform = CCApplication:getInstance():getTargetPlatform()
	
	if targetPlatform == cc.PLATFORM_OS_ANDROID or targetPlatform == cc.PLATFORM_OS_IPHONE then
	
		lobby_ui.btnSmall:setVisible(false)
		lobby_ui.btnExit:setVisible(false)
	end

	--注册最小化事件
	lobby_ui.btnSmall:onTouch(function (e) 
		WindowModule.show_window(enum_win_show_mod.mod_mini)
	end)

	--注册关闭窗口事件
	lobby_ui.btnExit:onTouch(function (e)
		WindowScene.getInstance():closeWindow()
	end)

	--注册商场按钮事件
	lobby_ui.btnShop:onTouch(function ( e )
		if e.name == "ended" then
			WindowScene.getInstance():showDlgByName("CShopPanel")
			global_music_ctrl.play_btn_one()
		end
	end)

	--注册银行按钮事件
	lobby_ui.btnBank:onTouch(function ( e )
		if e.name == "ended" then
			WindowScene.getInstance():showDlgByName("CBankExt")
			--WindowScene.getInstance():showDlg(CBankExt.create())
			global_music_ctrl.play_btn_one()
		end
	end)

	--客服
	lobby_ui.btnService:onTouch(function (e)
		if e.name == "ended" then
		    self:onGotoKeFu(e)
		    global_music_ctrl.play_btn_one()
	    end
	end)

	--排行榜
	lobby_ui.btnRank:onTouch(function(e)
		if e.name == "ended" then

            WaitMessageHit.showWaitMessageHit(2)
		    send_rank_ReqRank()
			global_music_ctrl.play_btn_one()
		end
	end)

	--个人中心
	lobby_ui.imgHead:setTouchEnabled(true)
	lobby_ui.imgHead:onTouch(function (e)
		if e.name  == "ended" then
			personal_manager:showPersonalCenter()
			global_music_ctrl.play_btn_one()
		end
	end)

	lobby_ui.imgHeadBg:setTouchEnabled(true)
	lobby_ui.imgHeadBg:onTouch(function (e)
		if e.name  == "ended" then
			personal_manager:showPersonalCenter()
			global_music_ctrl.play_btn_one()
		end
	end)

	--账号升级
	lobby_ui.btnUpLeve:onTouch(function ( e )
		if e.name  == "ended" then
			self:upAccount()
			global_music_ctrl.play_btn_one()
		end
	end)


	--系统消息
	-- lobby_ui.btnSysMessage:onTouch(function ( e )
	-- 	if e.name  == "ended" then
	-- 		WindowScene.getInstance():showDlgByName("CSystemMessage")
	-- 		--lobby_ui.imgBj:setVisible(false)
	-- 		global_music_ctrl.play_btn_one()
	-- 	end
	-- end)

	--昵称
	lobby_ui.tvName:setTouchEnabled(true)
	lobby_ui.tvName:onTouch(function (e)
		if e.name == "ended" then
			personal_manager:showPersonalCenter()
			global_music_ctrl.play_btn_one()
		end
	end)

    -- 我的足迹
	lobby_ui.btnHistory:onTouch(function(e)
		if e.name == "ended" then
		    global_music_ctrl.play_btn_one()
		    self._selectGameType = HallManager.MYGAME
		    self:showPanelByType(CGameLobby.PANEL_TYPE_FIRST_HALL)
	    end
	end)

    -- 所有游戏
	lobby_ui.btnAll:onTouch(function(e)
		if e.name == "ended" then
		    global_music_ctrl.play_btn_one()
		    self._selectGameType = HallManager.ALL
		    self:showPanelByType(CGameLobby.PANEL_TYPE_FIRST_HALL)
	    end
	end)

	--金币
	lobby_ui.btnGoldAdd:onTouch(function (e)
		if e.name == "ended" then
			WindowScene.getInstance():showDlgByName("CShopPanel"):setSelectType(CShopPanel.Type_GIFT)
			global_music_ctrl.play_btn_one()
		end
	end)

	--元宝
	lobby_ui.btnYbAdd:onTouch(function (e)
		if e.name == "ended" then
			WindowScene.getInstance():showDlgByName("CShopPanel"):setSelectType(CShopPanel.Type_ACER)
			global_music_ctrl.play_btn_one()
		end
	end)

	lobby_ui.btnGame:onTouch(function(e) self:onBigGameClick(e) end)

	--添加金币更新事件
	EventUtils.addEventListener(EventUtils.GOLD_CHANGE, self, function () 
		self:setPlayerInfo() 
		local shop = WindowScene:getInstance():getDlgByName("CShopPanel")
		if shop then
			shop:setPlayerInfo()
		end
	end)
	--添加元宝更新事件
	EventUtils.addEventListener(EventUtils.ACER_CHANGE, self, function () 
		self:setPlayerInfo() 
		local shop = WindowScene:getInstance():getDlgByName("CShopPanel")
		if shop then
			shop:setPlayerInfo()
		end
	end)

	--添加等级更新事件
	EventUtils.addEventListener(EventUtils.LEVEL_CHANGE, self, function () self:setPlayerInfo() end)
end

function CGameLobby:onCloseClick(e)
	if e.name == "ended" then
		if self.panel_type == CGameLobby.PANEL_TYPE_FIRST_HALL then
			self:showPanelByType(CGameLobby.PANEL_TYPE_GAME)
		elseif self.panel_type == CGameLobby.PANEL_TYPE_SECOND_HALL then
			self:showPanelByType(CGameLobby.PANEL_TYPE_FIRST_HALL)
	    elseif self.panel_type == CGameLobby.PANEL_TYPE_GAME then
		    WindowScene.getInstance():showDlgByName("CLeaveLobbyTipsExt")
	    end
		global_music_ctrl.play_btn_one()
	end
end

--升级账号
function CGameLobby:upAccount()
	self.tmp_dlg_account = CAccountUpgrade.create()
	WindowScene.getInstance():showDlg(self.tmp_dlg_account)
	self.tmp_dlg_account:setCloseCallBack(function ()
		self.tmp_dlg_account = nil
	end)
end

-- 客服
function CGameLobby:onGotoKeFu(e)
	if e.name == "ended" then
		WindowScene:getInstance():showDlgByName("CHelp")
		--WindowScene:getInstance():showDlgByName("CHelp")
		--local url = http_address_cfg[5].http_add
		--WindowScene.getInstance():openurl(url)
	end
end

function CGameLobby:setPlayerInfo()
	local pinfo = get_player_info()
	lobby_ui.tvName:setString(pinfo.name)
	--init head
	local sex = pinfo.sex == "男" and 0 or 1  
	
	uiUtils:setPhonePlayerHead(lobby_ui.imgHead, sex, uiUtils.HEAD_SIZE_223)

	local str1,str2 = ""
	if get_xue_Version()==2 then
		str1 = tostring(pinfo.gold)
		str2 = tostring(pinfo.acer)
	else
		str1 = string.format("%.2f",pinfo.gold)
		str2 = string.format("%.2f",pinfo.acer)
	end
	lobby_ui.tvYB:setString(str2)
	lobby_ui.tvGold:setString(str1)
	if pinfo.is_tourist then
		lobby_ui.btnUpLeve:setVisible(true)
		--lobby_ui.btnBank:setVisible(false)
    else 
    	lobby_ui.btnUpLeve:setVisible(false)
    	--lobby_ui.btnBank:setVisible(true)
	end
end

--创建游戏分类表
function CGameLobby:createGameTypeItems()
	lobby_ui.PageViewGameType:removeAllItems()
	lobby_ui.PageViewGameType:setScrollBarEnabled(false)
	lobby_ui.PageViewGameType:setItemsMargin(40) --设置间距

	for i,data in ipairs(game_classify_cfg) do
		if data.is_show then
			local btn_item = CGameTypeItem:create(data, function(gameType)
				local pinfo = get_player_info()
    	        self._selectGameType = gameType
    	        pinfo.selectGameType = gameType
    	        self:showPanelByType(CGameLobby.PANEL_TYPE_FIRST_HALL)
			end)
		    local custom_item = ccui.Layout:create()
		    custom_item:setContentSize(btn_item:getContentSize())
	        btn_item:setPosition(cc.p(custom_item:getContentSize().width/2,custom_item:getContentSize().height/2))
	        custom_item:addChild(btn_item)
	        lobby_ui.PageViewGameType:pushBackCustomItem(custom_item)
	    end
	end
end

-- 升级成功
function CGameLobby:upAccountSuccess()
	local pinfo = get_player_info()
	lobby_ui.tvName:setString(pinfo.name)
	if pinfo.is_tourist then
		lobby_ui.btnUpLeve:setVisible(true)
		--lobby_ui.btnBank:setVisible(false)
    else 
    	lobby_ui.btnUpLeve:setVisible(false)
    	--lobby_ui.btnBank:setVisible(true)
	end
	
	saveUserNameLst()
	TipsManager:showOneButtonTipsPanel( 300000, {}, true)
end


-- --创建游戏表
-- function CGameLobby:createGameItems( gameType )
-- 	local idList = HallManager:getGamesByType(gameType).games
	
-- 	lobby_ui.svGame:removeAllChildren()


--     local gameList = {}

-- 	for k,v in pairs(idList) do
-- 		if game_config[v] and 
-- 		game_icon_config[v] and 
-- 		game_config[v].id ~= CGameLobby.BIG_GAME then
-- 			if get_platform_code() ~=2  then
-- 				table.insert(gameList, v) 
-- 			elseif game_config[v].name == "四人牛牛" then
-- 				table.insert(gameList, v) 
-- 			end
-- 		end
-- 	end

--     local itemSize = #gameList
--     print("gameSize:"..itemSize)
--     if itemSize > 0 then
--     	lobby_ui.svGame:setInnerContainerSize(cc.size(math.ceil( itemSize / 2 ) * 330 + 250, 340 * 2 + 40))
--     	for i, v in ipairs( gameList ) do
--     		self:addItem(i-1, v)
--     	end
--     end
-- end


function CGameLobby:addItem(i, itemData)
    local node 	= GameBtnItem.create(itemData)
    node:setContentSize(cc.size(330, 340))

    lobby_ui.svGame:addChild(node)
            
    local listview_w = lobby_ui.svGame:getContentSize().width
    local listview_h = lobby_ui.svGame:getContentSize().height
	local itemSize = node:getContentSize()

    local verticle_count = 2
    local space = math.floor(i / verticle_count) * 40

    local dif = (listview_w - verticle_count * itemSize.width) / (verticle_count + 1)
    local x = math.floor(i / verticle_count) * itemSize.width + space + dif + 40
    local y = (1 - (i % verticle_count)) * itemSize.height + itemSize.height / 2 

    node:setPosition(x, y)
end

--创建游戏表
function CGameLobby:createGameItems( gameType )
	local idList = HallManager:getGamesByType(gameType).games
	lobby_ui.PageViewGameItem:removeAllItems()
	lobby_ui.PageViewGameItem:setScrollBarEnabled(false)
	lobby_ui.PageViewGameItem:setItemsMargin(80)
	lobby_ui.PageViewGameItem:jumpToPercentHorizontal(0)
	lobby_ui.PageViewGameItem:stopAllActions()
	self.SCROLLING_P=0

	for k,v in pairs(idList) do
		if game_config[v] and game_icon_config[v] then
			local btn_item 		= GameBtnItem.create(v)
	        lobby_ui.PageViewGameItem:pushBackCustomItem(btn_item) 
		end
	end


	if true == self.PLAY_SCROLLING  then

		self.PLAY_SCROLLING = false

		local delayIndex = 1
		lobby_ui.PageViewGameItem:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.001),cc.CallFunc:create(function()

			lobby_ui.PageViewGameItem:jumpToPercentHorizontal(delayIndex)
			delayIndex = delayIndex+0.1
			if delayIndex>100 then
				lobby_ui.PageViewGameItem:stopAllActions()
			end
		end
		))))

		lobby_ui.PageViewGameItem:onScroll(function(e)
            if e.name == "SCROLLING" then
		        lobby_ui.PageViewGameItem:stopAllActions()
            end
		end)
	end

	-- idList = 100/4

	-- lobby_ui.btnLeft:onTouch(function (e)
	-- 	if e.name == "ended" and self.SCROLLING_P+idList <= 100 then
	-- 		self.SCROLLING_P = self.SCROLLING_P+idList
	-- 		lobby_ui.PageViewGameItem:jumpToPercentHorizontal(self.SCROLLING_P)
	-- 		print("==================="..self.SCROLLING_P)
	-- 	end
	-- end)

	-- lobby_ui.btnRight:onTouch(function (e)
	-- 	if e.name == "ended" and self.SCROLLING_P-idList >=0 then
	-- 		self.SCROLLING_P = self.SCROLLING_P-idList
	-- 		lobby_ui.PageViewGameItem:jumpToPercentHorizontal(self.SCROLLING_P)
	-- 		print("==================="..self.SCROLLING_P)
	-- 	end
	-- end)
end

--创建房间项
function CGameLobby:createRoomItems()

	lobby_ui.PageViewGameRoom:removeAllItems()
	lobby_ui.PageViewGameRoom:setItemsMargin(60)
	lobby_ui.PageViewGameRoom:setScrollBarEnabled(false)
	local pinfo = get_player_info()
	for k,v in pairs(pinfo.myRoomTypeInfo) do
		for m,n in pairs(v.rooms) do

            local btnStr = "lobby.ui_create.ui_room_item_1_"..v.type
            local btn_item = require(btnStr).create()

            if btn_item then
                
                local custom_item 	= ccui.Layout:create()
	            custom_item:setContentSize(btn_item.Button_enter:getContentSize())
			    custom_item:addChild(btn_item.root)

                local displayNames = string.split(v.rooms[1].displayNames, ",")
		        local placeHolder = string.split(v.rooms[1].placeHolder, ",")
				local text = ""
		        for i=1,#displayNames do

                    local info = v.rooms[1][displayNames[i]]
			        if placeHolder[i] and info  then

						local temp = textUtils.connectParam( placeHolder[i], { v.rooms[1][displayNames[i]] } )
						text = text..temp.."\n"
			        end
				end
				
				btn_item.Button_enter:getChildByName("Text_Content"):setString(text)

                btn_item.Button_enter:onTouch(function(e)

                    if e.name == "ended" then

                        HallManager:reqEnterCurGameRoom(v.rooms[1].roomId)
				        global_music_ctrl.play_btn_one()
				        WaitMessageHit.showWaitMessageHit(1)
                    end
                end)

                lobby_ui.PageViewGameRoom:pushBackCustomItem(custom_item)
            end
		end
	end

	lobby_ui.PageViewGameRoom:jumpToPercentHorizontal(0)
end

-- 显示面板
-- TYPE 
-- CGameLobby.PANEL_TYPE_FIRST_HALL   = 0    --一级大厅
-- CGameLobby.PANEL_TYPE_SECOND_HALL 	  = 1    --游戏房间
function CGameLobby:showPanelByType(type)
	
	if (self.panel_type == type) and (type == CGameLobby.PANEL_TYPE_GAME) then
		return
	end

	local _playerInfo = get_player_info()

	if type == CGameLobby.PANEL_TYPE_FIRST_HALL then

		lobby_ui.PageViewGameType:setVisible(false)
		lobby_ui.PageViewGameItem:setVisible(true)

        -- 房间
        lobby_ui.PageViewGameRoom:setVisible(false)
		lobby_ui.GameContainer:setVisible(false)

        lobby_ui.imgBottom:setVisible(true)
		self:resetUIState(true)
		self.panel_type = CGameLobby.PANEL_TYPE_FIRST_HALL
		lobby_ui.imgGameName:setVisible(false)

		self._selectGameType = _playerInfo.selectGameType
		if self._selectGameType == nil then
			self._selectGameType = HallManager.ALL
			_playerInfo.selectGameType = HallManager.ALL
		end
		self:createGameItems(self._selectGameType)

		lobby_ui.btnClose:loadTextures("lobby/resource/hall_res/Backbutton.PNG","")

	elseif type == CGameLobby.PANEL_TYPE_SECOND_HALL then

		lobby_ui.PageViewGameItem:setVisible(false)
		lobby_ui.PageViewGameType:setVisible(false)

        -- 游戏房间显示
		lobby_ui.PageViewGameRoom:setVisible(true)
		lobby_ui.GameContainer:setVisible(false)
		self.panel_type = CGameLobby.PANEL_TYPE_SECOND_HALL
		lobby_ui.imgBottom:setVisible(false)
		self:resetUIState(false)
		self:createRoomItems()

		-- 游戏名称
		local resConfig = game_icon_config[get_player_info().curGameID]
		lobby_ui.imgGameName:loadTexture(resConfig.gameNameRes)
		lobby_ui.imgGameName:setVisible(false)
		lobby_ui.btnClose:loadTextures("lobby/resource/button/Backbutton.PNG","")

	elseif type == CGameLobby.PANEL_TYPE_GAME then

		self.panel_type = CGameLobby.PANEL_TYPE_GAME
		self:showBottomPanel(true)
		self:resetUIState(false)
		lobby_ui.btnGame:setVisible(false)
        lobby_ui.PageViewGameItem:setVisible(false)
        lobby_ui.PageViewGameType:setVisible(true)
        lobby_ui.PageViewGameRoom:setVisible(false)
        lobby_ui.imgGameName:setVisible(false)
        lobby_ui.btnClose:loadTextures("lobby/resource/hall_res/Exitbutton.png","")
	end

end

function CGameLobby:showBottomPanel(show) 
    lobby_ui.imgBottom:setVisible(show)
    --lobby_ui.btnSysMessage:setVisible(show)
    -- lobby_ui.btnBank:setVisible(show)
    -- lobby_ui.btnRank:setVisible(show)
    -- lobby_ui.btnService:setVisible(show)
    -- lobby_ui.btnSet:setVisible(show)
    -- lobby_ui.btnShop:setVisible(show)
end

function CGameLobby:onRecCheckAccount(msg)
	if self.tmp_dlg_account then
		self.tmp_dlg_account:onRecChekcAccount(msg)
	end
end

function CGameLobby:onRecCheckUsername(msg)
	if self.tmp_dlg_account then
		self.tmp_dlg_account:onRecCheckUserName(msg)
	end
end


function CGameLobby:setPlayerHeadSex()
	self:setPlayerInfo()
	local dlg_obj = WindowScene.getInstance():getDlgByName("CPersonalCenterMain")
	if dlg_obj then
		dlg_obj:setInfo()
	end
end


function CGameLobby:showRank(rankList)
	local num = #rankList
	print("============================================="..num)
	local rank = CRank:create(rankList)
	rank:createRankItems(rankList)
	local size = WindowModule.get_window_size()
	rank:setPosition(cc.p(size.width/2, size.height/2))
	self:addChild(rank)
end


-- 游戏大按钮
function CGameLobby:onBigGameClick(e)
	if e.name == "ended" then
		global_music_ctrl.play_btn_one()
		if self.game_cfg_item.play_state == 0 then
			TipsManager:showOneButtonTipsPanel(902,{},true)
			return
		end

		if is_inner_ver() == true then
			WindowScene.getInstance():loadGame(CGameLobby.BIG_GAME)
			return
		end
		
		if self.game_cfg_item then
			if self:isGameDownload() == false then --check game is exist
				self:showHitDlg(" 没有安装，是否安装？",true,0)			
			else --check game update version
				local is_update = GameUpdateStateRec.isUpdate(CGameLobby.BIG_GAME)
				if is_update == false then
					print("this game need to check update on server!")
					self:checkUpdate()
				else
					print("the game is update in this playing gamestate !")
					WindowScene.getInstance():loadGame(CGameLobby.BIG_GAME)
				end
			end
		end
	end
end

function CGameLobby:showHitDlg(msg,blink,code)
	--local win_size = WindowScene.getInstance():getWindowSize()
	local win_size = cc.Director:getInstance():getVisibleSize()
	local dlg  = GameUpdateAsk.create()
	if msg == nil then msg = "" end
	local str = msg
	if blink == true then str = self.game_cfg_item.name .. str end

	dlg:setHitMessage(str)
	dlg:setGameKey(self.game_cfg_item.id)
	dlg:setShowModule(code)

	local function __on_ok_click_call() self:checkUpdate() end
	dlg:setOkClickCall(__on_ok_click_call)

	local dlg_size = dlg:getWinSize()
	local pos = {x = win_size.width/2 - dlg_size.width/2,
		y = win_size.height/2 - dlg_size.height/2,
	}

	dlg:doModule(pos)
end

function CGameLobby:checkUpdate()
	local function __on_update_game_call(code) self:isUpdateCall(code) end
	GameVersionMgr.check_game_version_update(self.game_cfg_item.id,__on_update_game_call)
end

function CGameLobby:isGameDownload(game_id)
	if self.game_cfg_item then
		for k,v in pairs(self.game_cfg_item.pkg_lst) do
			local path_name = v.pkg_file
			if cc.FileUtils:getInstance():isFileExist(path_name) == false then
				return false
			end
		end

		return true
	end

	return false
end

function CGameLobby:isUpdateCall(code)
	if code == -1 then
		self:showHitDlg("检查更新失败，是否重试？",false,2)
	elseif code == 0 then
		WindowScene.getInstance():loadGame(self.game_cfg_item.id)
	elseif code == 1 then
		self:showHitDlg(" 有更新，是否更新？",true,1)
	end
end

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
