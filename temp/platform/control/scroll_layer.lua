#remark
--[[
	非排序滚动层  
]]

CScrollLayer = class("CScrollLayer",function()
	-- body
	local  ret = cc.Layer:create()
	return ret
end)


function CScrollLayer.create()
	local layer = CScrollLayer.new()
	if layer ~= nil then
		layer:regEnterExit()
		layer:init_ui()
		return layer
	end
end


function CScrollLayer:regEnterExit()
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

function CScrollLayer:onEnter()
	self:setTouchEnabled(true)
end

function CScrollLayer:onExit()
	self:unscheduleUpdate()
end

function CScrollLayer:regTouchFunction()
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
	-- 	-- body
	-- 	self:onMouseScrollHandler(e)
	-- end,cc.Handler.EVENT_MOUSE_SCROLL)
	-- eventDispatcher:addEventListenerWithSceneGraphPriority(roll_listener,self)

	-- local mov_listener = cc.EventListenerMouse:create()
	-- mov_listener:registerScriptHandler(function ( e )
	-- 	-- body
	-- 	self:onMouseMoveHandler(e)
	-- end,cc.Handler.EVENT_MOUSE_MOVE)
	-- eventDispatcher:addEventListenerWithSceneGraphPriority(mov_listener,self)


    self:scheduleUpdateWithPriorityLua(function (delta)
    	self:displayUpdate(delta)
    end, 0)

    self._scrollView:onEvent(function ( e )
    	if e.name == "SCROLLING" then
    		self:resetSliderButtonSize()
    	end
    end)
end

function CScrollLayer:displayUpdate(delta)
	if self._refreshViewDirty == true then
		self:refreshView()

		self._refreshViewDirty = false
	end
end

local function isAncestorsVisible(node)
	if node:isVisible() == false then
		return false
	end

	local parent = node:getParent()
	if parent then
		return isAncestorsVisible(parent)
	end

	return true
end

function CScrollLayer:onMouseMoveHandler( e )
	-- body
	local pt = e:getLocation()
	pt = cc.Director:getInstance():convertToGL(pt)
	if self._scrollView:hitTest(pt) and isAncestorsVisible(self) then
		self.isCanScroll = true
	else
		self.isCanScroll = false
	end

	if self.dir == 0 and self.clickSlider == false then
		if self.btnSlider:hitTest(pt) == false then
			if self.sliderData and self.btnSlider then
				self.btnSlider:loadTextureNormal(self.sliderData.normalRes)
			end
		else
			if self.sliderData and self.btnSlider then
				self.btnSlider:loadTextureNormal(self.sliderData.overRes)
			end
		end
	elseif self.dir == 1 and self.clickSlider == false then
		if self.btnSlider2:hitTest(pt) == false then
			if self.sliderData and self.btnSlider2 then
				self.btnSlider2:loadTextureNormal(self.sliderData.normalRes)
			end
		else
			if self.sliderData and self.btnSlider2 then
				self.btnSlider2:loadTextureNormal(self.sliderData.overRes)
			end
		end
	end

	
end

function CScrollLayer:onMouseScrollHandler( e )
	if self.isCanScroll == false then
		return
	end

	--隐藏玩家菜单
	player_manager:hidePlayerMenu()
	
	self:setScollPixel(e:getScrollY())
end


function CScrollLayer:setScollPixel(pixel)

	if self.dir == 0 then
		local dif = pixel*self.rowMove
		local innerSize = self._scrollView:getInnerContainerSize()
		local _listViewSize = self._scrollView:getContentSize()
		local innerCon = self._scrollView:getInnerContainer()
		local moveHeight = _listViewSize.height - innerSize.height
		local con_cur_y = innerCon:getPositionY()

		if moveHeight == 0 then
			return
		end

		local  per = 100 - 100 * (con_cur_y + dif) / moveHeight
		if con_cur_y + dif < moveHeight then
			per = 0
			self._scrollView:scrollToPercentVertical ( 0, 0.1, false )
		elseif con_cur_y + dif > 0 then
			per = 100
			self._scrollView:scrollToPercentVertical ( 100, 0.1, false )
		else
			self._scrollView:scrollToPercentVertical ( per, 0.1, false )
		end

		local barSize = self.ImgBar:getContentSize()
		local sliderSize = self.btnSlider:getContentSize()
		self.btnSlider:setPositionY( barSize.height - (barSize.height - sliderSize.height) * per / 100) 
	else
		local dif = pixel*self.colMove
		local innerSize = self._scrollView:getInnerContainerSize()
		local _listViewSize = self._scrollView:getContentSize()
		local innerCon = self._scrollView:getInnerContainer()
		local moveWidth = _listViewSize.width - innerSize.width
		local con_cur_x = innerCon:getPositionX()

		if moveWidth == 0 then
			return
		end

		local  per = 100 * (con_cur_x - dif) / moveWidth
		if con_cur_x - dif < moveWidth then
			per = 100
			self._scrollView:scrollToPercentHorizontal ( 100, 0.1, false )
		elseif con_cur_x - dif > 0 then
			per = 0
			self._scrollView:scrollToPercentHorizontal ( 0, 0.1, false )
		else
			self._scrollView:scrollToPercentHorizontal ( per, 0.1, false )
		end


		local barSize = self.ImgBar2:getContentSize()
		local sliderSize = self.btnSlider2:getContentSize()
		self.btnSlider2:setPositionX((barSize.height - sliderSize.height) * per / 100 ) 
	end
end

function CScrollLayer:ccTouchBegan(x,y)
	-- body
	--print("touch begin")

	local innerSize = self._scrollView:getInnerContainerSize()
	local _listViewSize = self._scrollView:getContentSize()
	local moveHeight = _listViewSize.height - innerSize.height
	local moveWidth = _listViewSize.width - innerSize.width

	if self.dir == 0 then
		if self.btnSlider and self.btnSlider:hitTest(cc.p(x, y)) then
			if self.sliderData then
				self.btnSlider:loadTextureNormal(self.sliderData.selectRes)
			end

			if moveHeight == 0 then
				return true
			end

			self.clickSlider = true
			self.beginY = y
		end
	else
		if self.btnSlider2 and self.btnSlider2:hitTest(cc.p(x, y)) then
			if self.sliderData then
				self.btnSlider2:loadTextureNormal(self.sliderData.selectRes)
			end

			if moveWidth == 0 then
				return true
			end

			self.clickSlider2 = true
			self.beginX = x
		end
	end


	return true
end

function CScrollLayer:ccTouchMoved(x,y)
	-- body
	if self.clickSlider == true then
		local dif = y - self.beginY
		local barSize = self.ImgBar:getContentSize()
		local sliderSize = self.btnSlider:getContentSize()

		local slider_cur_y = self.btnSlider:getPositionY()
		local zero_y = self.ImgBar:getPositionY()
		local end_y = self.ImgBar:getPositionY() - barSize.height


		if slider_cur_y + dif - sliderSize.height < end_y then
			self.btnSlider:setPositionY(end_y + sliderSize.height)
		elseif slider_cur_y + dif > zero_y then
			self.btnSlider:setPositionY(zero_y)
		else
			self.btnSlider:setPositionY(slider_cur_y + dif)
		end

		self.beginY = y

		self:setListViewContentPos()
	end

	if self.clickSlider2 == true then
		local dif = x - self.beginX
		local barSize = self.ImgBar2:getContentSize()
		local sliderSize = self.btnSlider2:getContentSize()

		local slider_cur_x = self.btnSlider2:getPositionX()
		local zero_x = self.ImgBar2:getPositionX()
		local end_x = self.ImgBar2:getPositionX() + barSize.height - sliderSize.height


		if slider_cur_x + dif > end_x then
			self.btnSlider:setPositionX(end_x)
		elseif slider_cur_x + dif < zero_x then
			self.btnSlider2:setPositionX(zero_x)
		else
			self.btnSlider2:setPositionX(slider_cur_x + dif)
		end

		self.beginX = x

		self:setListViewContentPos()
	end

	return true
end

function CScrollLayer:ccTouchEnded(x,y)
	-- body
	--print("touch end")
	self.clickSlider = false
	self.clickSlider2 = false

	if self.dir == 0 then
		if self.sliderData and self.btnSlider then
			self.btnSlider:loadTextureNormal(self.sliderData.normalRes)
		end
	else
		if self.sliderData and self.btnSlider2 then
			self.btnSlider2:loadTextureNormal(self.sliderData.normalRes)
		end
	end

	return true
end

function CScrollLayer:init_ui()
	-- body
	self._scrollView = ccui.ScrollView:create()
	self:addChild(self._scrollView)
	self._scrollView:setPosition(0,0)

	self._itemsMargin = 0
	self._objlist = {}
	self._objOriginPosList = {}

	self._refreshViewDirty = false
end

--[[
progms   sliderRes_config
]]
--size 不能小于100   0 垂直滚动  1 水平滚动 
function CScrollLayer:init_sliderScroll( size, dir, progms )
	progms = progms == nil and {} or progms
	self:init_contorlUI(dir, progms.sliderData, progms.barRes)

	self.sliderData = progms.sliderData
	self.dir = dir
	self.rowMove = 0
	self.colMove = 0
	self._contentSize = size
	self._scrollView:setContentSize(size)
	
	if dir == 0 then
		size.width = size.width - self.btnSlider:getContentSize().width
		self:setContentSize(size)

		self.ImgBar:setAnchorPoint(0, 1)
		self.ImgBar:setPosition(size.width, size.height )
		local barSize = self.ImgBar:getContentSize()
		self.ImgBar:setContentSize(cc.size(barSize.width, size.height))

		--滑块宽
    	self._sliderW = self.btnSlider:getContentSize().width
		self.btnSlider:setAnchorPoint(0, 1)
		self.btnSlider:setPosition(size.width + (barSize.width - self._sliderW)/2, size.height)

	else
		size.height = size.height - self.btnSlider2:getContentSize().height
		self:setContentSize(size)

		self._scrollView:setDirection(2)

		self.ImgBar2:setAnchorPoint(1, 1)
		self.ImgBar2:setPosition(0, 0)
		local barSize = self.ImgBar:getContentSize()
		self.ImgBar:setContentSize(cc.size(size.width, barSize.width))

		--滑块宽
    	self._sliderW = self.btnSlider2:getContentSize().width
		self.btnSlider2:setAnchorPoint(1, 1)		
		self.btnSlider2:setPosition(size.width + (barSize.width - self._sliderW)/2, 0)

	end

	self:removeAllObjects()

	self:resetSliderButtonSize()

    self:regTouchFunction()
    self._scrollView:setTouchEnabled(true)
end

function CScrollLayer:init_contorlUI(dir, sliderData, barRes)
	if dir == 0 then
		if barRes then
			self.ImgBar = ccui.ImageView:create(barRes)
		else
			self.ImgBar = ccui.ImageView:create()
		end
	    self.ImgBar:setScale9Enabled(true);
	    self:addChild(self.ImgBar)

	    self.btnSlider = self:creatButton(sliderData)
	else
		if barRes then
			self.ImgBar2 = ccui.ImageView:create(barRes)
		else
			self.ImgBar2 = ccui.ImageView:create()
		end
	    self.ImgBar2:setScale9Enabled(true);
	    self:addChild(self.ImgBar2)

	    self.btnSlider2 = self:creatButton(sliderData)
	end
	
end

function CScrollLayer:creatButton(data)
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

--显示/隐藏滚动条
function CScrollLayer:showHideSlider(value)
	if self.dir == 1 then
		self.ImgBar2:setVisible(value)
		self.btnSlider2:setVisible(value)
	else
		self.ImgBar:setVisible(value)
		self.btnSlider:setVisible(value)
	end
end

function CScrollLayer:onButtonUpClick( e )
	-- body
	if e.name == "ended" then

		local innerSize = self._scrollView:getInnerContainerSize()
		local dif = self.colMove / innerSize.height * 100
		local curPer = self:getScrollPercent() * 100

		if curPer - dif < 0 then
			self._scrollView:jumpToPercentVertical ( 0 )
		else
			self._scrollView:jumpToPercentVertical ( curPer - dif )
		end

		self:setSliderButtonPosition()
	end
end

function CScrollLayer:onButtonDownClick( e )
	-- body
	if e.name == "ended" then
		local innerSize = self._scrollView:getInnerContainerSize()
		local dif = self.colMove / innerSize.height * 100
		local curPer = self:getScrollPercent() * 100

		if curPer + dif > 100 then
			self._scrollView:jumpToPercentVertical ( 100 )
		else
			self._scrollView:jumpToPercentVertical ( curPer + dif )
		end

		self:setSliderButtonPosition()
	end
end


function CScrollLayer:onButtonLeftClick( e )
	-- body
	if e.name == "ended" then
		local innerSize = self._scrollView:getInnerContainerSize()
		local dif = self.rowMove / innerSize.width * 100
		local curPer = self:getScrollPercent() * 100

		if curPer - dif < 0 then
			self._scrollView:jumpToPercentHorizontal ( 0 )
		else
			self._scrollView:jumpToPercentHorizontal ( curPer - dif )
		end

		self:setSliderButtonPosition()
	end
end

function CScrollLayer:onButtonRightClick( e )
	-- body
	if e.name == "ended" then
		local innerSize = self._scrollView:getInnerContainerSize()
		local dif = self.rowMove / innerSize.width * 100
		local curPer = self:getScrollPercent() * 100

		if curPer + dif > 100 then
			self._scrollView:jumpToPercentHorizontal ( 100 )
		else
			self._scrollView:jumpToPercentHorizontal ( curPer + dif )
		end

		self:setSliderButtonPosition()
	end
end

--设置间隔距离
function CScrollLayer:setItemsMargin( val )
	self._itemsMargin = val
end

function CScrollLayer:refreshView()
	self:updateInnerContainerSize()
	self:resetSliderButtonSize()
end

function CScrollLayer:updateInnerContainerSize()
	local leftX = 0
	local rightX = 0
	local topY = 0
	local bottomY = 0
	for i,obj in ipairs(self._objlist) do
		local anchorP = obj:getAnchorPoint()
		local pos = {}
		pos.x, pos.y = obj:getPosition()
		local size = obj:getContentSize()
		pos.x = pos.x - size.width * anchorP.x
		pos.y = pos.y + size.height * (1 - anchorP.y)

		leftX = pos.x < leftX and pos.x or leftX
		rightX = pos.x > rightX and pos.x or rightX

		topY = pos.y > topY and pos.y or topY
		bottomY = pos.y < bottomY and pos.y or bottomY

		if self._objOriginPosList[obj] == nil then
			self._objOriginPosList[obj] = pos
		end
	end
	local _listViewSize = self._scrollView:getContentSize()
	local innerSize = {}
	innerSize.width = (rightX - leftX) < _listViewSize.width and _listViewSize.width or (rightX - leftX)
	innerSize.height = (topY - bottomY) < _listViewSize.height and _listViewSize.height or (topY - bottomY)
	self._scrollView:setInnerContainerSize(innerSize)

	local difInc = innerSize.height - _listViewSize.height	

	for i,obj in ipairs(self._objlist) do
		if self._objOriginPosList[obj] then
			obj:setPositionY(difInc + self._objOriginPosList[obj].y)
		end
	end

	-- --垂直
	-- if self.dir == 0 then
	-- 	local totalHeight = (#self._objlist - 1) * self._itemsMargin
	-- 	for i,obj in ipairs(self._objlist) do
	-- 		totalHeight = totalHeight + obj:getContentSize().height
	-- 	end
	-- 	local finalWidth = self._contentSize.width
	-- 	self._scrollView:setInnerContainerSize(cc.size(finalWidth, totalHeight))
	-- else--水平
	-- 	local totalWidth = (#self._objlist - 1) * self._itemsMargin
	-- 	for i,obj in ipairs(self._objlist) do
	-- 		totalWidth = totalWidth + obj:getContentSize().width
	-- 	end
	-- 	local finalHeigth = self._contentSize.height
	-- 	self._scrollView:setInnerContainerSize(cc.size(totalWidth, finalHeigth))
	-- end
end

function CScrollLayer:addObject( item )
	self._scrollView:addChild(item)
	self.rowMove = item:getContentSize().height
	self.colMove = item:getContentSize().width

	table.insert(self._objlist, item)

	self._refreshViewDirty = true
end

function CScrollLayer:getScrollObject()
	return self._scrollView
end

function CScrollLayer:removeObject( obj, cleanup )
	-- body
	self._scrollView:removeChild(obj, cleanup)

	for i,v in ipairs(self._objlist) do
		if v == obj then
			table.remove(self._objlist, i)
			self._objOriginPosList[v] = nil
			break
		end
	end

	self._refreshViewDirty = true
end

function CScrollLayer:removeAllObjects(  )
	self._scrollView:removeAllChildren()
	self._objlist = {}
	self._objOriginPosList = {}
	self._refreshViewDirty = true
end

--重置滑块的大小
function CScrollLayer:resetSliderButtonSize(  )
	-- body
	local innerSize = self._scrollView:getInnerContainerSize()
	local _listViewSize = self._scrollView:getContentSize()

	if self.dir == 0 then
		local barSize = self.ImgBar:getContentSize()
		self.btnSlider:setContentSize(self._sliderW, _listViewSize.height / innerSize.height * barSize.height)

		self:showHideSlider(not (_listViewSize.height == innerSize.height))
	else
		local barSize = self.ImgBar2:getContentSize()
		self.btnSlider2:setContentSize(self._sliderW, _listViewSize.width / innerSize.width * barSize.height)

		self:showHideSlider(not (_listViewSize.width == innerSize.width))
	end

	self:setSliderButtonPosition()
end

--获得当前滚动层的百分比位置
function CScrollLayer:getScrollPercent()
	-- body
	local innerSize = self._scrollView:getInnerContainerSize()
	local _listViewSize = self._scrollView:getContentSize()
	local innerCon = self._scrollView:getInnerContainer()

	if self.dir == 0 then
		local inner_originPos_y = innerSize.height - _listViewSize.height
		if inner_originPos_y <= 0 then
			return 0
		end
		return (inner_originPos_y + innerCon:getPositionY()) / inner_originPos_y
	else
		local inner_originPos_x = innerSize.width - _listViewSize.width

		if inner_originPos_x <= 0 then
			return 0
		end
		return -innerCon:getPositionX() / inner_originPos_x	

	end
end

--根据滚动层的位置 重置滑块位置
function CScrollLayer:setSliderButtonPosition()
	local percent = self:getScrollPercent()

	if self.dir == 0 then
		local barSize = self.ImgBar:getContentSize()
		local sliderSize = self.btnSlider:getContentSize()
		self.btnSlider:setPositionY( barSize.height - (barSize.height - sliderSize.height) * percent) 
	else
		local barSize = self.ImgBar2:getContentSize()
		local sliderSize = self.btnSlider2:getContentSize()
		self.btnSlider2:setPositionX((barSize.height - sliderSize.height) * percent) 
	end

end

--根据滑块的位置 设置滚动层的位置
function CScrollLayer:setListViewContentPos()
	if self.dir == 0 then
		local barSize = self.ImgBar:getContentSize()
		local sliderSize = self.btnSlider:getContentSize()
		local slider_cur_y = self.btnSlider:getPositionY()
		local zero_y = self.ImgBar:getPositionY()
		local end_y = self.ImgBar:getPositionY() - barSize.height + sliderSize.height

		local per = (zero_y - slider_cur_y) / (zero_y - end_y) * 100

		self._scrollView:scrollToPercentVertical ( per, 0.1, false )
	else
		local barSize = self.ImgBar2:getContentSize()
		local sliderSize = self.btnSlider2:getContentSize()
		local slider_cur_x = self.btnSlider2:getPositionX()
		local zero_x = self.ImgBar2:getPositionX()
		local end_x = self.ImgBar2:getPositionX() + barSize.height - sliderSize.height

		local per = (zero_x - slider_cur_x) / (zero_x - end_x) * 100

		self._scrollView:scrollToPercentHorizontal ( per, 0.1, false )

	end
end


function CScrollLayer:getInnerContainerSize()
	return self._scrollView:getInnerContainerSize()
end