--[[
	保险箱--存取面板
]]

CBankExt = class("CBankExt",function()
	local  ret = cc.Layer:create()
	return ret
end)

ModuleObjMgr.add_module_obj(CBankExt,"CBankExt")

function CBankExt.create()
	-- body
	local layer = CBankExt.new()
	if layer ~= nil then
		layer:regEnterExit()
		layer:init_ui()
		layer:registerHandler()
		return layer
	end
end

function CBankExt:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(_onEnterOrExit);
end

function CBankExt:onEnter()
	--防止穿透
	self:setTouchEnabled(true)
end

function CBankExt:onExit()
	EventUtils.removeEventListener(EventUtils.GOLD_CHANGE,self)
	EventUtils.removeEventListener(EventUtils.SAFEGOLD_CHANGE,self)
	EventUtils.removeEventListener(EventUtils.FRESH_RECORD,self)
end

function CBankExt:init_ui()
	--local size = WindowModule.get_window_size()
	--self:setContentSize(cc.size(size.width, size.height))

	self.panel_ui = require("lobby.ui_create.ui_bank").create()
	self:addChild(self.panel_ui.root)
	--self.panel_ui.root:setPosition(size.width/2,size.height/2)

    --init bank
    self:setData()

    --init record
    self.recordItem = self.panel_ui.Panel_gaveRec:getChildByName("ListView_1"):getChildByName("Panel_item")
    self.recordItem:retain()
    self.panel_ui.Panel_gaveRec:getChildByName("ListView_1"):removeAllChildren()
end

function CBankExt:registerHandler()

	self:refreshCheckContent("Panel_myBank")
   if get_xue_Version() == 2 then

        self.panel_ui.Panel_CheckBox:setVisible(true)
        self.panel_ui.Panel_CheckBox1:setVisible(false)

        self.panel_ui.Panel_CheckBox:getChildByName("CheckBox_bank"):onEvent(function(e)
            if e.name == "selected" then
                self.panel_ui.Panel_CheckBox:getChildByName("CheckBox_bank"):setEnabled(false)
                self:refreshCheckContent("Panel_myBank")

                self.panel_ui.Panel_CheckBox:getChildByName("CheckBox_record"):setEnabled(true)
                self.panel_ui.Panel_CheckBox:getChildByName("CheckBox_record"):setSelected(false)
            end
        end)
        self.panel_ui.Panel_CheckBox:getChildByName("CheckBox_record"):onEvent(function(e)
            if e.name == "selected" then
                self.panel_ui.Panel_CheckBox:getChildByName("CheckBox_record"):setEnabled(false)
                self:refreshCheckContent("Panel_gaveRec")
                self:reqRecord()

                self.panel_ui.Panel_CheckBox:getChildByName("CheckBox_bank"):setEnabled(true)
                self.panel_ui.Panel_CheckBox:getChildByName("CheckBox_bank"):setSelected(false)
            end
        end)
    else 
        self.panel_ui.Panel_CheckBox:setVisible(false)
        self.panel_ui.Panel_CheckBox1:setVisible(true)

        self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_bank"):onEvent(function(e)
            if e.name == "selected" then
                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_bank"):setEnabled(false)
                self:refreshCheckContent("Panel_myBank")

                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_record"):setEnabled(true)
                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_record"):setSelected(false)

                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_exchange"):setEnabled(true)
                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_exchange"):setSelected(false)
            end
        end)
        self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_record"):onEvent(function(e)
            if e.name == "selected" then
                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_record"):setEnabled(false)
                self:refreshCheckContent("Panel_gaveRec")
                self:reqRecord()

                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_bank"):setEnabled(true)
                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_bank"):setSelected(false)

                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_exchange"):setEnabled(true)
                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_exchange"):setSelected(false)
            end
        end)

        self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_exchange"):onEvent(function(e)
            if e.name == "selected" then
                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_exchange"):setEnabled(false)
                self:refreshCheckContent("Panel_exchange")

                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_bank"):setEnabled(true)
                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_bank"):setSelected(false)

                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_record"):setEnabled(true)
                self.panel_ui.Panel_CheckBox1:getChildByName("CheckBox_record"):setSelected(false)
            end
        end)
    end

	--返回
	self.panel_ui.Button_Close:onTouch(function (e)
	     
		if e.name == "ended" then 

			WindowScene.getInstance():closeDlg(self)
			global_music_ctrl.play_btn_one()
		end
	end)

    --取消赠送
	self.panel_ui.Panel_gave:getChildByName("btnZhuanz"):onTouch(function (e)
	     
		if e.name == "ended" then 

			self:refreshCheckContent("Panel_myBank")
			global_music_ctrl.play_btn_one()
		end
	end)

	--减
	self.panel_ui.Panel_myBank:getChildByName("btnDown"):onTouch(function (e)
		if e.name == "ended" then 
            local sliderGole =  self.panel_ui.Panel_myBank:getChildByName("Slider_gold")
			local percent = sliderGole:getPercent()
			percent = percent - 10
			percent = percent > 0 and percent or 0
			sliderGole:setPercent(percent)

			self:updateTakeOutGold()
			global_music_ctrl.play_btn_one()
		end
	end)

	--加
	self.panel_ui.Panel_myBank:getChildByName("btnUp"):onTouch(function (e)
		if e.name == "ended" then 
			local sliderGole =  self.panel_ui.Panel_myBank:getChildByName("Slider_gold")
			local percent = sliderGole:getPercent()
			percent = percent + 10
			percent = percent <= 100 and percent or 100
			sliderGole:setPercent(percent)

			self:updateTakeOutGold()
			global_music_ctrl.play_btn_one()
		end
	end)

	--滑动条
	self.panel_ui.Panel_myBank:getChildByName("Slider_gold"):onEvent(function (e)
		if e.name == "ON_PERCENTAGE_CHANGED" then 
			self:updateTakeOutGold()
		end
	end)

	--取出
	self.panel_ui.Panel_myBank:getChildByName("btnTakeOut") :onTouch(function (e)
		if e.name == "ended" then 
			local goldNum = self.panel_ui.Panel_myBank:getChildByName("imgNumBj"):getChildByName("TextField_num"):getString()
			local code = self.panel_ui.Panel_myBank:getChildByName("imgKeyBj"):getChildByName("TextField_key"):getString()

            if tonumber(goldNum) and 0<tonumber(goldNum) and "" ~= code then
            	--取出
				local playerInfo = get_player_info()
				if long_compare(goldNum, playerInfo.safeGold) > 0 then
					TipsManager:showOneButtonTipsPanel(512, {}, true)
				else
					send_bank_ReqWithdrawGold({bankPwd = code, gold = goldNum})
				end
            else
            	--取出金额或密码为空
				TipsManager:showOneButtonTipsPanel(517, {}, true)
            end

			global_music_ctrl.play_btn_one()
		end
	end)

	--赠送
	self.panel_ui.Panel_gave:getChildByName("btnTakeOut") :onTouch(function (e)

		if e.name == "ended" then 

			local transOutNum = string.trim(self.panel_ui.Panel_gave:getChildByName("imgNumBj"):getChildByName("TextField_num"):getString())
			local transInId = string.trim(self.panel_ui.Panel_gave:getChildByName("imgIDBj"):getChildByName("TextField_num"):getString())
			local safePW = string.trim(self.panel_ui.Panel_gave:getChildByName("imgKeyBj"):getChildByName("TextField_key"):getString())
			local playerInfo = get_player_info()
			if transInId == "" then
				--转入账号不能为空
				TipsManager:showOneButtonTipsPanel(515, {}, true)
			elseif transOutNum == "" then
				--转出金额不能为空
				TipsManager:showOneButtonTipsPanel(514, {}, true)
			elseif safePW == "" then
				--保险柜密码不能为空
				TipsManager:showOneButtonTipsPanel(513, {}, true)
			elseif tonumber(playerInfo.safeGold) < tonumber(transOutNum) then
				--保险柜金额不足
				TipsManager:showOneButtonTipsPanel(512, {}, true)
			elseif tonumber(playerInfo.id) == tonumber(transInId) then
				--不能转给自己！
				TipsManager:showOneButtonTipsPanel(5130, {}, true)
			else
				self:reqPlayerName(tonumber(transInId), function(name)
						-- local content = textUtils.connectParam(message_config[5131].name, {123, "chen"})
						--    print(content)
						
							TipsManager:showTwoButtonTipsPanel(5131, {name,  transInId,transOutNum}, true,function()
							  send_bank_ReqTransferGold({bankPwd = safePW, gold = tonumber(transOutNum), target = tonumber(transInId)})	 
						 end )
				   end )
			end

			global_music_ctrl.play_btn_one()
		end
	end)

	--存入
	self.panel_ui.Panel_myBank:getChildByName("btnSaveIn"):onTouch(function (e)
		if e.name == "ended" then 

			local gold = self.panel_ui.Panel_myBank:getChildByName("imgNumBj"):getChildByName("TextField_num"):getString()

			--local safePW = string.trim(self.panel_ui.inputSaveKey:getString())
			if long_compare(gold, 0) == 0 then
				--存入金额不能为空
				TipsManager:showOneButtonTipsPanel(516, {}, true)
			else
				--存入
				local playerInfo = get_player_info()
				if long_compare(gold, playerInfo.gold) > 0 then
					TipsManager:showOneButtonTipsPanel(511, {}, true)
				else
					if long_compare(gold, 0) < 0  then
						TipsManager:showOneButtonTipsPanel(531, {}, true)
						return
					end
					send_bank_ReqDepositeGold({gold = gold})
				end
			end
			global_music_ctrl.play_btn_one()
		end
	end)

    --记住密码
	self.panel_ui.Panel_myBank:getChildByName("CheckBox_remember"):onEvent(function (e)

        self.panel_ui.Panel_gave:getChildByName("CheckBox_remember"):setSelected(self.panel_ui.Panel_myBank:getChildByName("CheckBox_remember"):isSelected())

        if e.name == "selected" then

            local str = self.panel_ui.Panel_myBank:getChildByName("imgKeyBj"):getChildByName("TextField_key"):getString()
            cc.UserDefault:getInstance():setStringForKey("b_bank_code",str)
            cc.UserDefault:getInstance():setBoolForKey("b_bank_rember_code",true)

		elseif e.name == "unselected" then

            cc.UserDefault:getInstance():setStringForKey("b_bank_code","")
            cc.UserDefault:getInstance():setBoolForKey("b_bank_rember_code",false)
		end

	end)

    --记住密码
	self.panel_ui.Panel_gave:getChildByName("CheckBox_remember"):onEvent(function (e)
        
        self.panel_ui.Panel_myBank:getChildByName("CheckBox_remember"):setSelected(self.panel_ui.Panel_gave:getChildByName("CheckBox_remember"):isSelected())

        if e.name == "selected" then

            local str = self.panel_ui.Panel_gave:getChildByName("imgKeyBj"):getChildByName("TextField_key"):getString()
            cc.UserDefault:getInstance():setStringForKey("b_bank_code",str)
            cc.UserDefault:getInstance():setBoolForKey("b_bank_rember_code",true)

		elseif e.name == "unselected" then

            cc.UserDefault:getInstance():setStringForKey("b_bank_code","")
            cc.UserDefault:getInstance():setBoolForKey("b_bank_rember_code",false)
		end

	end)

	--输入存取金额
	 self.panel_ui.Panel_myBank:getChildByName("imgKeyBj"):getChildByName("TextField_key"):onEvent(function (e)
        local str =  self.panel_ui.Panel_myBank:getChildByName("imgKeyBj"):getChildByName("TextField_key"):getString()
		if is_chinese(str) == true then

            self.panel_ui.Panel_gave:getChildByName("imgKeyBj"):getChildByName("TextField_key"):setString("")
			return
		end

        if self.panel_ui.Panel_myBank:getChildByName("CheckBox_remember"):isSelected() then

            cc.UserDefault:getInstance():setStringForKey("b_bank_code",str)
        end
	end)

	--输入赠送金额
    self.panel_ui.Panel_gave:getChildByName("imgKeyBj"):getChildByName("TextField_key"):onEvent(function (e)

        local str =  self.panel_ui.Panel_gave:getChildByName("imgKeyBj"):getChildByName("TextField_key"):getString()
		if is_chinese(str) == true then

            self.panel_ui.Panel_gave:getChildByName("imgKeyBj"):getChildByName("TextField_key"):setString("")
			return
		end

        if self.panel_ui.Panel_gave:getChildByName("CheckBox_remember"):isSelected() then

            cc.UserDefault:getInstance():setStringForKey("b_bank_code",str)
        end
	end)


    --修改密码
    self.panel_ui.Panel_myBank:getChildByName("btnChangeKey"):onTouch(function (e)
		if e.name == "ended" then
			local reset_obj = CBankRePassword.create()
			WindowScene.getInstance():showDlg(reset_obj)
			global_music_ctrl.play_btn_one()
		end
	end)

    --修改密码
    self.panel_ui.Panel_gave:getChildByName("btnChangeKey"):onTouch(function (e)
		if e.name == "ended" then
			local reset_obj = CBankRePassword.create()
			WindowScene.getInstance():showDlg(reset_obj)
			global_music_ctrl.play_btn_one()
		end
	end)
    --粘贴id
    self.panel_ui.Panel_gave:getChildByName("Button_paste"):onTouch(function (e)
		if e.name == "ended" then
			    local str = WindowModule.getTextFromClipboard()
			    if tonumber(str) == nil or string.len(str) >6 then
				    str = ""
			    end

                self.panel_ui.Panel_gave:getChildByName("imgIDBj"):getChildByName("TextField_num"):setString(str)
		end
	end)

    local targetPlatform = CCApplication:getInstance():getTargetPlatform()

    if targetPlatform == cc.PLATFORM_OS_ANDROID or targetPlatform == cc.PLATFORM_OS_IPHONE then
		
        self.panel_ui.Panel_gave:getChildByName("Button_paste"):setVisible(false)
	end

	--大写提示
    self.panel_ui.Panel_gave:getChildByName("imgNumBj"):getChildByName("TextField_num"):onEvent(function (e)
        
        local str = self.panel_ui.Panel_gave:getChildByName("imgNumBj"):getChildByName("TextField_num"):getString()
        self.panel_ui.Panel_gave:getChildByName("Text_DaXie"):setString(self:numberToString(str))
    end)

	--赠送
	 self.panel_ui.Panel_myBank:getChildByName("btnZhuanz"):onTouch(function (e)
		if e.name == "ended" then

            self:refreshCheckContent("Panel_gave")

			global_music_ctrl.play_btn_one()
		end
	end)

    --先玩下
    self.panel_ui.Panel_exchange:getChildByName("Panel_unbangding"):getChildByName("Button_close"):onTouch(function (e)
		if e.name == "ended" then

            WindowScene.getInstance():closeDlg(self)
			global_music_ctrl.play_btn_one()
		end
	end)

    --前往绑定银行卡
    self.panel_ui.Panel_exchange:getChildByName("Panel_unbangding"):getChildByName("Button_bangding"):onTouch(function (e)
		if e.name == "ended" then

			WindowScene.getInstance():showDlgByName("CBangding")
			global_music_ctrl.play_btn_one()
		end
	end)

    --确认体现
    self.panel_ui.Panel_exchange:getChildByName("Panel_bangding"):getChildByName("Button_apply"):onTouch(function (e)
		if e.name == "ended" then
            local str = self.panel_ui.Panel_exchange:getChildByName("Panel_bangding"):getChildByName("Image_input_bg"):getChildByName("TextField_num"):getString()
			local msg ={
				money=str,
			}

			if ""== msg.money then
				local bk_hit_obj = BlackMessageHit.create({txt = "请输入下分金额",color = cc.c3b(255,255,255),})
				WindowScene.getInstance():showDlg(bk_hit_obj)
				return
			end

			send_bank_ReqBankReflect(msg)
			global_music_ctrl.play_btn_one()
		end
	end)

	--刷新转账记录
	EventUtils.addEventListener(EventUtils.FRESH_RECORD, self, function () self:reqRecord() end)
	--添加保险金更新事件
	EventUtils.addEventListener(EventUtils.SAFEGOLD_CHANGE, self, function () self:setData() end)
	--添加金币更新事件
	EventUtils.addEventListener(EventUtils.GOLD_CHANGE, self, function () self:setData() end)
end

function CBankExt:refreshCheckContent(ui)
    self.panel_ui.Panel_myBank:setVisible(false)
    self.panel_ui.Panel_gaveRec:setVisible(false)
    self.panel_ui.Panel_exchange:setVisible(false)
    self.panel_ui.Panel_gave:setVisible(false)
    self.panel_ui[ui]:setVisible(true)
    
    self:setData()
end

function CBankExt:refreshRecord(pdata)

	WaitMessageHit.closeWaitMessageHit()

	self.panel_ui.Panel_gaveRec:getChildByName("ListView_1"):removeAllChildren()

    local size = #pdata
    if 0==size then
    	local bk_hit_obj = BlackMessageHit.create({txt = "暂无记录",color = cc.c3b(255,255,255),})
		WindowScene.getInstance():showDlg(bk_hit_obj)
        return
    end

	if self.recordItem then
		
        local player = get_player_info()

        for k,v in ipairs(pdata) do 
            
            local str = ""

            if v.transferType ==0 then
                str = "转出"
            else
                str = "转入"
            end

            local item = self.recordItem:clone()

            item:getChildByName("Text_6"):setString(str)

            str = tostring(v.targetPlayer)
            item:getChildByName("Text_6_0"):setString(str)

            str = tonumber(v.changeSafeGold)
            if str <0 then str = str *(-1) end
            item:getChildByName("Text_6_1"):setString(tostring(str))

            str = tostring(v.playerName)
            item:getChildByName("Text_6_2"):setString(str)

			str = os.date("%Y/%m/%d %H:%M:%S",tonumber(v.time)/1000)
            item:getChildByName("Text_6_3"):setString(str)

            self.panel_ui.Panel_gaveRec:getChildByName("ListView_1"):pushBackCustomItem(item)
		end
        
    end
end

function CBankExt:setData()

    local remember = cc.UserDefault:getInstance():getBoolForKey("b_bank_rember_code",false)
    local code = cc.UserDefault:getInstance():getStringForKey("b_bank_code","")

	self.panel_ui.Panel_myBank:getChildByName("CheckBox_remember"):setSelected(remember)
	self.panel_ui.Panel_myBank:getChildByName("imgKeyBj"):getChildByName("TextField_key"):setString(code)

    self.panel_ui.Panel_gave:getChildByName("CheckBox_remember"):setSelected(remember)
	self.panel_ui.Panel_gave:getChildByName("imgKeyBj"):getChildByName("TextField_key"):setString(code)

    local pInfo = get_player_info()
	self.panel_ui.Panel_myBank:getChildByName("Text_current_gold"):setString(pInfo.gold)
	self.panel_ui.Panel_myBank:getChildByName("Text_strongbox_gold"):setString(pInfo.safeGold)

    self.panel_ui.Panel_gave:getChildByName("Text_current_gold"):setString(pInfo.gold)
	self.panel_ui.Panel_gave:getChildByName("Text_strongbox_gold"):setString(pInfo.safeGold)

	local pinfo = get_player_info()
	if ""==pinfo.bankCardnumber then 
		self.panel_ui.Panel_exchange:getChildByName("Panel_bangding"):setVisible(false)
		self.panel_ui.Panel_exchange:getChildByName("Panel_unbangding"):setVisible(true)
	else
		self.panel_ui.Panel_exchange:getChildByName("Panel_bangding"):setVisible(true)
		self.panel_ui.Panel_exchange:getChildByName("Panel_unbangding"):setVisible(false)
	end
end

function CBankExt:reqPlayerName(pid,pcall)
	local xhr = cc.XMLHttpRequest:new()
	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
	xhr:open("GET", "http://".."manage.388r.com".."/playersys/gold/GetPlayerName?playerId="..pid)
	xhr:registerScriptHandler(function () 
		if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
			local response   = xhr.response
			if response~="" then
			--    local output = json.decode(response,1)
			--    print(response)
			   pcall(response)
			end	
		else
			print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
		end
		xhr:unregisterScriptHandler()
	end)
	xhr:send()
end

function CBankExt:reqRecord()

    WaitMessageHit.showWaitMessageHit(2)
	--  local xhr = cc.XMLHttpRequest:new()
	--  xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
	--  local pid=get_player_info().id
	--  local reqUrl="http://".."manage.388r.com".."/playersys/gold/GameTransferRecord?playerId="..pid
	--  print(reqUrl)
	--  xhr:open("GET", reqUrl)
	--  local  function onReadyStateChanged()
		
	-- 	 if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
	-- 		 local response   = xhr.response
	-- 		 if response~="" then
	-- 			local output = json.decode(response,1)
	-- 			table.foreach(output,function(i, parseTable) 
	-- 			   self:refreshRecord(parseTable)
	-- 			 end) 
	-- 		 end
	-- 	 else
	-- 		 print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
	-- 	 end
	-- 	 xhr:unregisterScriptHandler()
	--  end
	--  xhr:registerScriptHandler(onReadyStateChanged)
	--  xhr:send()
	send_bank_ReqGaveRecord()
end

--更新取款金币
function CBankExt:updateTakeOutGold()

	local percent = self.panel_ui.Panel_myBank:getChildByName("Slider_gold"):getPercent()
	local bankGold = get_player_info().gold

	self.panel_ui.Panel_myBank:getChildByName("imgNumBj"):getChildByName("TextField_num"):setString(math.floor( bankGold * percent / 100 ))	
end

--文字转换  
function  CBankExt:numberToString(szNum) 
	local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    local szChMoney = ""  
    local iLen = 0  
    local iNum = 0  
    local iAddZero = 0  
    local hzUnit = {"金币", "拾", "佰", "仟", "万", "拾", "佰", "仟", "亿", "拾", "佰", "仟", "万", "拾", "佰", "仟"}  
    local hzNum = {"零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖"}  
  
  if nil == tonumber(szNum) then
	return ""
  end  
    
  iLen =string.len(szNum) 

   if iLen > 15 or iLen == 0 or tonumber(szNum) < 0 then  
	if cc.PLATFORM_OS_WINDOWS ~= targetPlatform then
		return "错误的金额"
	else
		return ""
	end   
	end  
	
  local i = 0  
  for i = 1, iLen  do   
    iNum = string.sub(szNum,i,i)  
    if iNum == 0 then  
      iAddZero = iAddZero + 1  
    else  
      if iAddZero > 0 then  
        szChMoney = szChMoney..hzNum[1]    
      end  
  
      szChMoney = szChMoney..hzNum[iNum + 1] --//转换为相应的数字  
      iAddZero = 0  
  
    end  
  
    if iNum ~=0 or iLen-i==3 or iLen-i==11 or ((iLen-i+1)%8==0 and iAddZero<4) then  
      szChMoney = szChMoney..hzUnit[iLen-i+1]  
    end  
  
  end  
  
  return szChMoney  
  
end
