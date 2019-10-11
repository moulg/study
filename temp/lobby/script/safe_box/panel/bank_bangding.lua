--[[
	保险箱--绑定银行卡面板
]]

local panel_ui_bank_bangding = require "lobby.ui_create.ui_bank_exchange"

CBangding = class("CBangding",function()
	-- body
	local  ret = cc.Layer:create();
	return ret
end)
ModuleObjMgr.add_module_obj(CBangding,"CBangding")

function CBangding.create()
	-- body
	local layer = CBangding.new()
	if layer ~= nil then
		layer:init_ui()
		layer:init_data()
		layer:regEnterExit()
	    layer:registerHandler()

		return layer
	end

end

function CBangding:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter();
		elseif event == "enterTransitionFinish" then
            self:onEnterTransitionFinish()
		elseif event == "exit" then
			self:onExit();
		end
	end

	self:registerScriptHandler(_onEnterOrExit);
end

function CBangding:onEnter()
	-- body
	self:regTouchFunction()
end

function CBangding:onEnterTransitionFinish()
	-- body
end

function CBangding:onExit()
	-- body
end

function CBangding:regTouchFunction()
	-- body
    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        return self:ccTouchBegan(location.x,location.y)
    end

    local function onTouchMoved(touch, event)
        local location = touch:getLocation()
        return self:ccTouchMoved(location.x,location.y)
    end

    local function onTouchEnded(touch, event)
        local location = touch:getLocation()
        return self:ccTouchEnded(location.x,location.y)
    end
    
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)

end


function CBangding:ccTouchBegan(x,y)
	-- body
	--print("touch begin")
	return true
end

function CBangding:ccTouchMoved(x,y)
	-- body
	--print("touch moved")
	return true
end

function CBangding:ccTouchEnded(x,y)
	-- body
	--print("touch end")
	return true
end

function CBangding:init_ui()

	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))

	self.panel_ui_bank_bangding = panel_ui_bank_bangding.create()
	self:addChild(self.panel_ui_bank_bangding.root)
	self:setPosition(size.width/2,size.height/2)

end

function CBangding:init_data()

end

function CBangding:registerHandler()
	--关闭
	self.panel_ui_bank_bangding.Button_close:onTouch(function (e)
		if e.name == "ended" then

		 	 WindowScene.getInstance():closeDlg(self)
		 	global_music_ctrl.play_btn_one()
		 end
	end)

    --确认绑定
	self.panel_ui_bank_bangding.Button_sure:onTouch(function (e)
		if e.name == "ended" then
            local ReqBankBandding ={
                bcnumber=self.panel_ui_bank_bangding.Image_bank_card_number_bg:getChildByName("TextField_input"):getString(),
                bcholdername =self.panel_ui_bank_bangding.Image_bank_card_name_bg:getChildByName("TextField_input"):getString(),
                bcbank=self.panel_ui_bank_bangding.Image_bank_open_bg:getChildByName("Text_content"):getString(),
                contacts=self.panel_ui_bank_bangding.Image_bank_contact_bg:getChildByName("TextField_input"):getString(),
                bcbankprovince=self.panel_ui_bank_bangding.Image_bank_open_province_bg:getChildByName("Text_content"):getString(),
                bankbranch=self.panel_ui_bank_bangding.Image_bank_open_branch_bg:getChildByName("Text_content"):getString(),
            }

            if ""==ReqBankBandding.bcholdername then
                local bk_hit_obj = BlackMessageHit.create({txt = "请输入您的姓名",color = cc.c3b(255,255,255),})
                WindowScene.getInstance():showDlg(bk_hit_obj)
                return
            elseif ""==ReqBankBandding.bcnumber then
                local bk_hit_obj = BlackMessageHit.create({txt = "请输入银行卡号",color = cc.c3b(255,255,255),})
                WindowScene.getInstance():showDlg(bk_hit_obj)
                return
            elseif ""==ReqBankBandding.contacts then
                local bk_hit_obj = BlackMessageHit.create({txt = "请填写联系方式",color = cc.c3b(255,255,255),})
                WindowScene.getInstance():showDlg(bk_hit_obj)
                return
            elseif ""==ReqBankBandding.bcbank then
                local bk_hit_obj = BlackMessageHit.create({txt = "请选择开户行",color = cc.c3b(255,255,255),})
                WindowScene.getInstance():showDlg(bk_hit_obj)
                return
            elseif ""==ReqBankBandding.bcbankprovince then
                local bk_hit_obj = BlackMessageHit.create({txt = "请选择开户行省份",color = cc.c3b(255,255,255),})
                WindowScene.getInstance():showDlg(bk_hit_obj)
                return
            end

            send_bank_ReqBankBandding(ReqBankBandding)
            global_music_ctrl.play_btn_one()
            print("====================self.panel_ui_bank_bangding.Button_sure:onTouch(function (e)")
		 end
	end)

    self.panel_ui_bank_bangding.CheckBox_bank_open_more:onEvent(function (e)

		if e.name == "selected" then
            self:refreshContent(1)
            self.panel_ui_bank_bangding.Image_bg_bank_open:runAction(cc.ScaleTo:create(0.1,1.0,1.0))
		 	global_music_ctrl.play_btn_one()
        elseif e.name == "unselected" then
            self.panel_ui_bank_bangding.Image_bg_bank_open:runAction(cc.ScaleTo:create(0.1,1.0,0.001))
		end
	end)

    self.panel_ui_bank_bangding.CheckBox_bank_open_province_more:onEvent(function (e)

        if e.name == "selected" then
            self:refreshContent(2)
            self.panel_ui_bank_bangding.Image_bg_bank_open_province:runAction(cc.ScaleTo:create(0.1,1.0,1.0))
		 	global_music_ctrl.play_btn_one()
        elseif e.name == "unselected" then
            self.panel_ui_bank_bangding.Image_bg_bank_open_province:runAction(cc.ScaleTo:create(0.1,1.0,0.001))
		end
	end)

    self.panel_ui_bank_bangding.Image_bank_card_number_bg:getChildByName("TextField_input"):onEvent(function (e)
        local str = self.panel_ui_bank_bangding.Image_bank_card_number_bg:getChildByName("TextField_input"):getString()
        if nil == tonumber(str) then
            self.panel_ui_bank_bangding.Image_bank_card_number_bg:getChildByName("TextField_input"):setString("")
        end
    end)

    self.listView_list_group = {
		[1] = {
                parent = self.panel_ui_bank_bangding.Image_bg_bank_open,
                check = self.panel_ui_bank_bangding.CheckBox_bank_open_more,
                list = self.panel_ui_bank_bangding.Image_bg_bank_open:getChildByName("ListView_list"),  
                text = self.panel_ui_bank_bangding.Image_bank_open_bg:getChildByName("Text_content"),
                config = bank_config_name, 
            },
		[2] = {
                parent = self.panel_ui_bank_bangding.Image_bg_bank_open_province,
                check = self.panel_ui_bank_bangding.CheckBox_bank_open_province_more,
                list = self.panel_ui_bank_bangding.Image_bg_bank_open_province:getChildByName("ListView_list"),  
                text = self.panel_ui_bank_bangding.Image_bank_open_province_bg:getChildByName("Text_content"),
                config = bank_config_province,
            },
	}

    for k,v in ipairs(self.listView_list_group) do
        if v and v.list and v.text then
            v.list:removeAllChildren()
        end
    end

    self.panel_ui_bank_bangding.Text_acc:setString(tostring(get_player_info().id))
end
 
 function CBangding:refreshContent(index)
    print("===================="..index)

    --关闭其他

    for i,v in ipairs(self.listView_list_group) do 
        if v and v.check and v.parent and index ~= i then
            v.check:setSelected(false)
            v.parent:runAction(cc.ScaleTo:create(0.1,1.0,0.001))
        end
    end

    local group = self.listView_list_group[index]
    if group and group.list and group.text and group.config then
        group.list:removeAllChildren()


        for i , v in ipairs ( group.config ) do
            local item = ccui.Text:create()
            item:setString(v.name)
            item:setFontSize(34)
            item:setTextVerticalAlignment(1)
            item:setTouchEnabled(true)
            item:addClickEventListener(function(e)
                group.text:setString(v.name)
                group.check:setSelected(false)
                group.parent:runAction(cc.ScaleTo:create(0.1,1.0,0.001))
            end)
            group.list:pushBackCustomItem(item)
        end

    end
 end

