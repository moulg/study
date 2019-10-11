#remark
--[[
	商店面板
]]
local shop_ui = require "lobby.ui_create.ui_shop"

CShopPanel = class("CShopPanel",function()
	local ret = ccui.ImageView:create()
	ret:loadTexture("lobby/resource/hall_res/bgdat.jpg")
	ret:setScale9Enabled(true)
	return ret
end)
ModuleObjMgr.add_module_obj(CShopPanel,"CShopPanel")



--标签分类
--元宝
CShopPanel.Type_ACER = 1
--礼品
CShopPanel.Type_GIFT = 2
--喇叭
CShopPanel.Type_HORN = 3


function CShopPanel.create()
	-- body
	local layer = CShopPanel.new()
	if layer ~= nil then
		layer:regEnterExit()
		layer:init_ui()
		return layer
	end
end


function CShopPanel:regEnterExit()
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

function CShopPanel:onEnter()
	self:setTouchEnabled(true)
end

function CShopPanel:onExit()
	self.shopItemList = {}
end

function CShopPanel:init_ui()
	local size = WindowModule.get_window_size()
	self.shop_ui = shop_ui.create()
	self:addChild(self.shop_ui.root)
	self:setContentSize(1920, 1080)
	self.shop_ui.root:setPosition(size.width/2,size.height/2)

	self:setPlayerInfo()

	self:registerHandler()

	self:initShow()

	--self.shop_ui.CheckBox_horm:setVisible(false)
	
	local targetPlatform = CCApplication:getInstance():getTargetPlatform()
	
	if targetPlatform == cc.PLATFORM_OS_ANDROID or targetPlatform == cc.PLATFORM_OS_IPHONE then
		
		self.shop_ui.btnSmall:setVisible(false)
		self.shop_ui.btnExit:setVisible(false)
	end

	--注册最小化事件
	self.shop_ui.btnSmall:onTouch(function (e) 
		WindowModule.show_window(enum_win_show_mod.mod_mini)
	end)

	--注册关闭窗口事件
	self.shop_ui.btnExit:onTouch(function (e)
		WindowScene.getInstance():closeWindow()
	end)

	self:initAct()
	
end

function CShopPanel:initAct()
	local actSprite = self.shop_ui.shopping_wait_bg:getChildByName("shopping_wait_act")
	if actSprite  then
		local act = cc.RotateBy:create(1,180)
		actSprite:runAction(cc.RepeatForever:create(act))
	end
end

function CShopPanel:setActVisible(visible)
	self.shop_ui.shopping_wait_bg:setVisible(visible)
end

function CShopPanel:setPlayerInfo() 
	local pinfo = get_player_info()
	--头像
	local sex = pinfo.sex == "男" and 0 or 1
	uiUtils:setPhonePlayerHead(self.shop_ui.imgHead, sex, uiUtils.HEAD_SIZE_223)
	self.shop_ui.topBg:getChildByName("imgHeadBg"):getChildByName("tvName"):setString(pinfo.name)
	local str1 ,str2= ""
	if get_xue_Version()==2 then
		str1 = tostring(pinfo.gold)
		str2 = tostring(pinfo.acer)
	else
		str1 = string.format("%.2f",pinfo.gold)
		str2 = string.format("%.2f",pinfo.acer)
	end
	self.shop_ui.topBg:getChildByName("imgGoldBg"):getChildByName("tvGold"):setString(str1)
	
    self.shop_ui.topBg:getChildByName("imgYbBg"):getChildByName("tvYB"):setString(str2)
end

function CShopPanel:initShow()
	self.showList = {}
	
	for k,itemData in pairs(shop_item_config) do
		if self.itemType == itemData.type then
			table.insert(self.showList, itemData)
		end
	end

	local btns = {
				  [CShopPanel.Type_ACER]  = self.shop_ui.CheckBox_acer,
				  [CShopPanel.Type_GIFT]  = self.shop_ui.CheckBox_gift,
				  [CShopPanel.Type_HORN]  = self.shop_ui.CheckBox_horm,
				  }
	for k,v in pairs(btns) do
		v:setSelected(false)
		v:setEnabled(true)
	end

	self.itemType = CShopPanel.Type_ACER
	self.shop_ui.CheckBox_acer:setSelected(true)
	self.shop_ui.CheckBox_acer:setEnabled(false)

	self:setShopItems()
	self:palyShowAnim()
end

function CShopPanel:registerHandler()
	local btn_group_lst = {self.shop_ui.CheckBox_acer,self.shop_ui.CheckBox_gift,self.shop_ui.CheckBox_horm,}
	local function _onClickItemTypeButton(sender, eventType)
		self:onClickItemTypeButton(sender)
		global_music_ctrl.play_btn_one()
	end
	WindowScene.getInstance():registerGroupEvent(btn_group_lst,_onClickItemTypeButton)

	--返回
	self.shop_ui.btnClose:onTouch(function ( e )
		if e.name == "ended" then
			WindowScene.getInstance():closeDlg(self)
			global_music_ctrl.play_btn_one()
		end
	end)
end

function CShopPanel:setShopItems()

	self.shop_ui.PageViewGameItem:removeAllItems()
	self.shop_ui.PageViewGameItem:setItemsMargin(60)
	
	self:getShopItems()

	--按ID排序
	local function compareById(a,b)
		return a.id < b.id
	end
	table.sort(self.showList,compareById)

	for i, itemData in ipairs(self.showList) do

		local custom_item = ccui.Layout:create()
		custom_item:setAnchorPoint(0.5,0.5)
		custom_item:setContentSize(392,433)

		local node = CShopItem.create()
		node:setItemInfo(itemData)
		node:setPosition(custom_item:getContentSize().width/2,custom_item:getContentSize().height)
		custom_item:addChild(node)

		self.shop_ui.PageViewGameItem:pushBackCustomItem(custom_item)
	end

	self.shop_ui.PageViewGameItem:jumpToPercentHorizontal(0)
end

function CShopPanel:onClickItemTypeButton( sender )
	if sender == self.shop_ui.CheckBox_acer then
		self.itemType = CShopPanel.Type_ACER
	elseif sender == self.shop_ui.CheckBox_gift then
		self.itemType = CShopPanel.Type_GIFT
	elseif sender == self.shop_ui.CheckBox_horm then
		self.itemType = CShopPanel.Type_HORN
	end	

	self:setShopItems()
end

function CShopPanel:getShopItems()
	self.showList = {}
	if self.itemType == CShopPanel.Type_ACER then
        for k,v in pairs(shop_goods_config.items) do
			table.insert(self.showList, v)
		end
	else 
		for k,itemData in pairs(shop_item_config) do
			if self.itemType == itemData.type then
				table.insert(self.showList, itemData)
			end
		end
	end
end

function CShopPanel:setSelectType(id)
	if id == CShopPanel.Type_ACER then
		self.itemType = CShopPanel.Type_ACER
		self.shop_ui.CheckBox_acer:setSelected(true)
		self.shop_ui.CheckBox_acer:setEnabled(false)

		self.shop_ui.CheckBox_gift:setSelected(false)
		self.shop_ui.CheckBox_gift:setEnabled(true)

		self.shop_ui.CheckBox_horm:setSelected(false)
		self.shop_ui.CheckBox_horm:setEnabled(true)
	elseif id == CShopPanel.Type_GIFT then
		self.itemType = CShopPanel.Type_GIFT
		self.shop_ui.CheckBox_acer:setSelected(false)
		self.shop_ui.CheckBox_acer:setEnabled(true)

		self.shop_ui.CheckBox_gift:setSelected(true)
		self.shop_ui.CheckBox_gift:setEnabled(false)

		self.shop_ui.CheckBox_horm:setSelected(false)
		self.shop_ui.CheckBox_horm:setEnabled(true)
	elseif id == CShopPanel.Type_HORN then
		self.itemType = CShopPanel.Type_HORN
		self.shop_ui.CheckBox_acer:setSelected(false)
		self.shop_ui.CheckBox_acer:setEnabled(true)

		self.shop_ui.CheckBox_gift:setSelected(false)
		self.shop_ui.CheckBox_gift:setEnabled(true)

		self.shop_ui.CheckBox_horm:setSelected(true)
		self.shop_ui.CheckBox_horm:setEnabled(false)
	end

	self:setShopItems()
end

function CShopPanel:palyShowAnim()

	local targetPlatform = cc.Application:getInstance():getTargetPlatform()
	if cc.PLATFORM_OS_IPHONE ~= targetPlatform then
		local size = WindowScene.getInstance():getDesSize()
		local posX, posY= self.shop_ui.root:getPosition()
		self.shop_ui.root:setPosition(cc.p(posX + size.w, posY))
		local moveBack = cc.MoveBy:create(0.5,cc.p(-size.w, 0))
		self.shop_ui.root:runAction(moveBack)
	end
end

function CShopPanel:showWebView( url )
	local size = cc.Director:getInstance():getVisibleSize()
	local webview = ccexp.WebView:create()
	webview:setVisible(true)
	webview:setScalesPageToFit(true)
	webview:loadURL(url)
	webview:setContentSize(size.width,size.height)
	self.shop_ui.root:addChild(webview)
end




-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
