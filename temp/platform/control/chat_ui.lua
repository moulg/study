#remark
--[[
聊天通用类
]]

ChatUIExt = class("ChatUIExt",function()
	-- body
	local  ret = ccui.Layout:create()
	return ret
end)

local MAX_LINE = 30

function ChatUIExt.create()
	local layer = ChatUIExt.new()
	if layer ~= nil then
		layer:regEnterExit()
		return layer
	end
end


function ChatUIExt:regEnterExit()
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

function ChatUIExt:onEnter()
	self:setTouchEnabled(true)
end

function ChatUIExt:onExit()
	self._richChat:clearAll()
	self:unscheduleUpdate()
end


------------------------------------------------外部函数接口-----------------------------------

function ChatUIExt:clearAll()
	self._richChat:clearAll()
	self._richChat:setInnerContainerSize(self:viewSize())
	self:resetSliderButton()
end

--[[
progms   sliderRes_config
]]
function ChatUIExt:initChatUI( originSize, fontData, progms)
	progms = progms == nil and {} or progms
    self.sliderData = progms.sliderData
	self:init_contorlUI(progms.sliderData, progms.barRes)

	local barWidth = self.imgBar:getContentSize().width
	local size = clone(originSize)
	size.width = size.width - barWidth
	self:setContentSize(originSize)

	self._richChat = ccui.RichTextUI:create(size)
    self._richChat:setAnchorPoint(cc.p(0,0))
    self._richChat:setPosition(cc.p(0,0))
    self._richChat:setMaxLine(MAX_LINE)
    self._richChat:setTouchEnabled(true)
    self:addChild(self._richChat)

    self:setChatFontByConfig(fontData)



    
    self.imgBar:setContentSize(cc.size(barWidth, size.height))
    self.imgBar:setAnchorPoint(0,1)
    self.imgBar:setPosition(size.width, size.height)

    local btnWidth = self.btnSlider:getContentSize().width

    self.btnSlider:setAnchorPoint(0,1)
	self.btnSlider:setPositionX(size.width + (barWidth - btnWidth)/2)

    
    --滑块移动范围
    self._btnMoveHeight = self:viewSize().height
    --滑块宽
    self._sliderW = self.btnSlider:getContentSize().width
    --滑块起始Y
    self._sliderBeginY = self._btnMoveHeight

    self:registerHandler()
    -------------------------------

    self._scrollPercent = 100

    self:resetSliderButton()
end

--设置聊天字体信息
function ChatUIExt:setChatFontByConfig( data )
	self.fontConfig = data
end

--聊天中添加游戏结算
function ChatUIExt:addGameSolution(channel ,billInfos)
	local rcm = ccui.RichItemText:create(channel, self.fontConfig[channel].channelColor, 255, "本局结束，结果统计：", 
    												self.fontConfig[channel].fontName, self.fontConfig[channel].fontSize)  
    self._richChat:insertElement(rcm)
    self._richChat:insertNewLine()

    for i,v in pairs(billInfos) do
    	local msg = v.name.."："..v.chips
		local rcm = ccui.RichItemText:create(channel, self.fontConfig[channel].channelColor, 255, msg, 
	    	self.fontConfig[channel].fontName, self.fontConfig[channel].fontSize)  
	    self._richChat:insertElement(rcm)
	    self._richChat:insertNewLine()
    end
end

function ChatUIExt:addChatMsg(channel, roleName, chatmsg)
    local rcm = ccui.RichItemText:create(channel, self.fontConfig[channel].channelColor, 255, roleName, 
    	self.fontConfig[channel].fontName, self.fontConfig[channel].fontSize)  
    self._richChat:insertElement(rcm)

    local rcm = ccui.RichItemText:create(channel, self.fontConfig[channel].msgColor, 255, chatmsg, 
    	self.fontConfig[channel].fontName, self.fontConfig[channel].fontSize)
    self._richChat:insertElement(rcm)

    self._richChat:insertNewLine()

    self._refreshViewDirty = true
end

function ChatUIExt:innerSize()
	return self._richChat:getInnerContainerSize()
end

function ChatUIExt:viewSize()
	return self._richChat:getContentSize()
end

function ChatUIExt:getPercent()
	return self._scrollPercent
end


----------------------------------内部逻辑函数------------------------------------

function ChatUIExt:init_contorlUI(sliderData, barRes)
	if barRes then
		self.imgBar = ccui.ImageView:create(barRes)
	else
		self.imgBar = ccui.ImageView:create()
	end
    self.imgBar:setScale9Enabled(true);
    self:addChild(self.imgBar)

    self.btnSlider = self:creatButton(sliderData)
end

function ChatUIExt:creatButton(data)
	local btn
	if data then
		btn = ccui.Button:create(data.normalRes, data.selectRes, "")
		local size = btn:getContentSize();
	    btn:setScale9Enabled(true)
		btn:setCapInsets(cc.rect(0,data.cir_h,size.width,size.height - data.cir_h*2))
	else
		btn = ccui.Button:create()
	end
	self:addChild(btn)
	btn:setTouchEnabled(false)

	return btn
end


--设置滑动条显示
function ChatUIExt:setSliderButtomVisible( value )
	self.btnSlider:setVisible(value)
	-- self.btnDown:setVisible(value)
	-- self.btnUp:setVisible(value)
	self.imgBar:setVisible(value)
end

function ChatUIExt:registerHandler()
    self:scheduleUpdateWithPriorityLua(function (delta)
    	self:displayUpdate(delta)
    end, 0)

    self._richChat:onEvent(function ( e )
    	if e.name == "SCROLLING" then
    		--触摸移动 根据inner位置偏移 来 计算 百分比
    		self._scrollPercent = self:getScrollPercent()
    		self:resetSliderButton()
    	end
    end)

    self:regTouchFunction()
end

function ChatUIExt:displayUpdate(delta)
	if self._refreshViewDirty == true then
		self._scrollPercent = 100
        self:resetSliderButton()

        self._richChat:scrollToPercentVertical( self._scrollPercent, 0.1, false )

		self._refreshViewDirty = false
	end
end

--滑块终点Y
function ChatUIExt:getSliderEndY()
	-- return self.btnUp:getContentSize().height + self.btnSlider:getContentSize().height
	return self.btnSlider:getContentSize().height
end


function ChatUIExt:regTouchFunction()
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

 --    local roll_listener = cc.EventListenerMouse:create()
	-- roll_listener:registerScriptHandler(function ( e )
	-- 	self:onMouseScrollHandler(e)
	-- end,cc.Handler.EVENT_MOUSE_SCROLL)
	-- eventDispatcher:addEventListenerWithSceneGraphPriority(roll_listener,self)

	-- local mov_listener = cc.EventListenerMouse:create()
	-- mov_listener:registerScriptHandler(function ( e )
	-- 	-- body
	-- 	self:onMouseMoveHandler(e)
	-- end,cc.Handler.EVENT_MOUSE_MOVE)
	-- eventDispatcher:addEventListenerWithSceneGraphPriority(mov_listener,self)
end

function ChatUIExt:onMouseScrollHandler( e )
	if self.isCanScroll == false then
		return
	end

	--隐藏玩家菜单
	player_manager:hidePlayerMenu()

	local dif = e:getScrollY() * self._richChat:getMoveDiff()
	local innerSize = self:innerSize()
	local _listViewSize = self:viewSize()
	local innerCon = self._richChat:getInnerContainer()
	local moveHeight = _listViewSize.height - innerSize.height
	local con_cur_y = innerCon:getPositionY()

	if moveHeight == 0 then
		return
	end

	local  per = 100 - 100 * (con_cur_y + dif) / moveHeight
	if con_cur_y + dif < moveHeight then
		per = 0
	elseif con_cur_y + dif > 0 then
		per = 100
	end
	self._richChat:scrollToPercentVertical ( per, 0.1, false )
	self._scrollPercent = per

	self:setSliderButtonPos(per)
end

function ChatUIExt:onMouseMoveHandler( e )
	-- body
	local pt = e:getLocation()
	pt = cc.Director:getInstance():convertToGL(pt)
	if self._richChat:hitTest(pt) then
		self.isCanScroll = true
	else
		self.isCanScroll = false
	end

	if self.btnSlider:hitTest(pt) == false then
		if self.sliderData then
			self.btnSlider:loadTextureNormal(self.sliderData.normalRes)
		end
	else
		if self.sliderData then
			self.btnSlider:loadTextureNormal(self.sliderData.overRes)
		end
	end
end

function ChatUIExt:ccTouchBegan(x,y)
	-- body
	--print("touch begin")

	local innerSize = self:innerSize()
	local _listViewSize = self:viewSize()
	local moveHeight = _listViewSize.height - innerSize.height
	local moveWidth = _listViewSize.width - innerSize.width

	if self.btnSlider:hitTest(cc.p(x, y)) then
		if moveHeight == 0 then
			return true
		end

		self.clickSlider = true
		if self.sliderData then
			self.btnSlider:loadTextureNormal(self.sliderData.selectRes)
		end
		
		self.beginY = y
	end

	return true
end

function ChatUIExt:ccTouchMoved(x,y)
	-- body
	if self.clickSlider == true then
		local sliderSize = self.btnSlider:getContentSize()

		local dif = y - self.beginY
		local slider_cur_y = self.btnSlider:getPositionY()
		local end_y = self:getSliderEndY()

		if slider_cur_y + dif < end_y then
			-- self.btnSlider:setPositionY(end_y)
			slider_cur_y = end_y
		elseif slider_cur_y + dif > self._sliderBeginY then
			-- self.btnSlider:setPositionY(self._sliderBeginY)
			slider_cur_y = self._sliderBeginY
		else
			slider_cur_y = slider_cur_y + dif
		end

		self.btnSlider:setPositionY(slider_cur_y)
		self.beginY = y

		self:setListViewContentPos()
	end

	return true
end

function ChatUIExt:ccTouchEnded(x,y)
	self.clickSlider = false

	if self.sliderData and self.btnSlider then
		self.btnSlider:loadTextureNormal(self.sliderData.normalRes)
	end

	return true
end

function ChatUIExt:setSliderButtonPos(percent)
	local endY = self:getSliderEndY()
	self.btnSlider:setPositionY( self._sliderBeginY - (self._sliderBeginY - endY) * percent / 100)
end

function ChatUIExt:resetSliderButton()
	local percent = self:getPercent()

	self.btnSlider:setContentSize(self._sliderW, self:viewSize().height / self:innerSize().height * self._btnMoveHeight)
	self:setSliderButtonPos(percent)

	self.imgBar:setVisible(not (self:viewSize().height == self:innerSize().height))
	self.btnSlider:setVisible(not (self:viewSize().height == self:innerSize().height))
end

--根据滑块的位置 设置滚动层的位置
function ChatUIExt:setListViewContentPos()
	local slider_cur_y = self.btnSlider:getPositionY()
	local end_y = self:getSliderEndY()

	local per = (self._sliderBeginY - slider_cur_y) / (self._sliderBeginY - end_y) * 100

	self._richChat:scrollToPercentVertical( per, 0.1, false )
	self._scrollPercent = per
end

function ChatUIExt:onButtonDownClick( e )
	-- body
	if e.name == "ended" then

		local innerSize = self:innerSize()
		local _listViewSize = self:viewSize()
		local moveHeight = innerSize.height - _listViewSize.height
        if moveHeight == 0 then
            return
        end
		local dif = self._richChat:getMoveDiff() / moveHeight * 100
		local curPer = self:getPercent()

		if curPer + dif > 100 then
			curPer = 100
		else
			curPer = curPer + dif
		end
		self._richChat:jumpToPercentVertical ( curPer )
		self:setSliderButtonPos(curPer)
		self._scrollPercent = curPer
	end
end

function ChatUIExt:onButtonUpClick( e )
	-- body
	if e.name == "ended" then
		local innerSize = self:innerSize()
		local _listViewSize = self:viewSize()
		local moveHeight = innerSize.height - _listViewSize.height
        if moveHeight == 0 then
            return
        end
		local dif = self._richChat:getMoveDiff() / moveHeight * 100
		local curPer = self:getPercent()

		if curPer - dif < 0 then
			curPer = 0
		else
			curPer = curPer - dif
		end
		self._richChat:jumpToPercentVertical ( curPer )
		self:setSliderButtonPos(curPer)
		self._scrollPercent = curPer
	end
end

--获得当前滚动层的百分比位置
function ChatUIExt:getScrollPercent()
	-- body
	local innerSize = self._richChat:getInnerContainerSize()
	local _listViewSize = self._richChat:getContentSize()
	local innerCon = self._richChat:getInnerContainer()

	local inner_originPos_y = innerSize.height - _listViewSize.height
	if inner_originPos_y <= 0 then
		return 0
	end
	return (inner_originPos_y + innerCon:getPositionY()) / inner_originPos_y * 100
end