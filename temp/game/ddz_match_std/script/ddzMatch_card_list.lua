--[[
卡组对象
]]

CDdzMatchCardList = class("CDdzMatchCardList", function ()
	local ret = cc.Node:create()
	return ret
end)

function CDdzMatchCardList.create()
	local node =  CDdzMatchCardList.new()
	if node then
		node:init()
		return node
	end
end

function CDdzMatchCardList:init()
	self._cardItemList = {}
	self._begin_x = 0
	self:regTouchFunction()	

end

function CDdzMatchCardList:regEnterExit()
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

function CDdzMatchCardList:onEnter()

end

function CDdzMatchCardList:onExit()

end

function CDdzMatchCardList:clear()
	for i,v in ipairs(self._cardItemList) do
		v:removeFromParent()
	end
	self._cardItemList = {}
end

function CDdzMatchCardList:regTouchFunction()
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


    local function __on_mouse_down(e)
    	self:onMouseDown(e)
    end
    local mouse_listener = cc.EventListenerMouse:create()
	mouse_listener:registerScriptHandler(__on_mouse_down,cc.Handler.EVENT_MOUSE_DOWN)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)
    eventDispatcher:addEventListenerWithSceneGraphPriority(mouse_listener,self)
end

function CDdzMatchCardList:onMouseDown(e)
	-- body
	local btn_type = e:getMouseButton()

	if btn_type == 0 then --left mouse button
		
	elseif btn_type == 1 then --right mouse button
		local game_ui = WindowScene.getInstance():getModuleObjByClassName("CDdzMatchMainScene")
		if game_ui then
			game_ui:mainPlayerOutCardsHandler()
		end
	elseif btn_type == 2 then --center mouse button
	end
end

function CDdzMatchCardList:ccTouchBegan(x,y)

	ddz_match_manager._tmpSelectCards:clear()
	local selectCard = nil
	for i,card in ipairs(self._cardItemList) do
		if card:hitTest(cc.p(x, y)) then
			selectCard = card
		end
	end
	if selectCard then
		ddz_match_manager._tmpSelectCards:addItem(selectCard)
		ddz_match_manager._tmpSelectEnabled = true
		selectCard:showShader()
	else
		if ddz_match_manager:checkIsContainButton( cc.p(x, y) ) == false then
			for i,card in ipairs(self._cardItemList) do
				if card._isSelect then
					card:clickHandler()
				end
			end

			ddz_match_manager._tmpSelectCards:clear()

		    ddz_match_manager:setOutCardButtonState()
		end
	end

	local mousePos = self:convertToNodeSpace(cc.p(x,y))
	self._begin_x = mousePos.x
	return true
end

function CDdzMatchCardList:ccTouchMoved(x,y)
	if ddz_match_manager._tmpSelectEnabled == false or #ddz_match_manager._tmpSelectCards.list < 1 then
		return true
	end
	local mousePos = self:convertToNodeSpace(cc.p(x,y))

	local moveDir = -1
	if self._begin_x < mousePos.x then
		moveDir = 1
	end

	for i,card in ipairs(self._cardItemList) do
		local cardSize = card:getContentSize()
		local card_x = card:getPositionX()
		local firstCard_x = ddz_match_manager._tmpSelectCards.list[1]:getPositionX()

		if moveDir == 1 then--向右选择
			if card_x - cardSize.width/2 < mousePos.x and card_x > firstCard_x then
				ddz_match_manager._tmpSelectCards:addItem(card)
				card:showShader()
			else
				if card.id ~= ddz_match_manager._tmpSelectCards.list[1].id then
					ddz_match_manager._tmpSelectCards:removeItem(card)
					card:hideShader()
				end
			end
		else--向左选择
			if card_x - cardSize.width/4 > mousePos.x and card_x < firstCard_x then
				ddz_match_manager._tmpSelectCards:addItem(card)
				card:showShader()
			else
				if card.id ~= ddz_match_manager._tmpSelectCards.list[1].id then
					ddz_match_manager._tmpSelectCards:removeItem(card)
					card:hideShader()
				end
			end
		end
	end

	return true
end

function CDdzMatchCardList:ccTouchEnded(x,y)
	if ddz_match_manager._tmpSelectEnabled then
		ddz_match_manager._tmpSelectEnabled = false

		local list = ddz_match_manager._tmpSelectCards:getTipsCards()
		for k,card in pairs(list) do
			card:clickHandler()
		end

		for i,card in ipairs(ddz_match_manager._tmpSelectCards.list) do
			card:hideShader()
		end

	    ddz_match_manager._tmpSelectCards:clear()

	    ddz_match_manager:setOutCardButtonState()
	end
	return true
end

function CDdzMatchCardList:addCard( id )
	local item = CDdzMatchCardItem.create(id)
	self:addChild(item)
	table.insert(self._cardItemList, item)

	local cardSize = item:getContentSize()
	local num = #self._cardItemList
	local beginX = -(num - 1)*cardSize.width/6
	for i,v in ipairs(self._cardItemList) do
		local px = beginX + (i - 1) * cardSize.width/3
		v:setPositionX(px)
	end

	audio_manager:playOtherSound(2)
end

function CDdzMatchCardList:removeCards( idList )
	for i,id in ipairs(idList) do
		for k,item in ipairs(self._cardItemList) do
			if id == item.id then
				item:removeFromParent()
				table.remove(self._cardItemList, k)
				break
			end
		end
	end

	self:sortCardList()
end

--整理牌组
function CDdzMatchCardList:sortCardList()
	if self._cardItemList == nil or #self._cardItemList <= 1 then
		return
	end

	local function sortFunc(card1, card2)
		if ddzMatch_card_data[card1.id].power > ddzMatch_card_data[card2.id].power then
			return true
		elseif ddzMatch_card_data[card1.id].power < ddzMatch_card_data[card2.id].power then
			return false
		else
			if card1.id > card2.id then
				return true
			else
				return false
			end
		end
	end
	table.sort(self._cardItemList, sortFunc)

	local cardSize = self._cardItemList[1]:getContentSize()
	local num = #self._cardItemList
	local beginX = -(num - 1)*cardSize.width/6
	for i,v in ipairs(self._cardItemList) do
		local px = beginX + (i - 1) * cardSize.width/3
		v:setPositionX(px)
		v:setLocalZOrder(i)
	end
end


--牌型提示
function CDdzMatchCardList:cardsPrompt( idList )
	for i,card in ipairs(self._cardItemList) do
		if card._isSelect then
			card:clickHandler()
		end
		
		for k,id in ipairs(idList) do
			if id == card.id then
				card:clickHandler()
			end
		end
	end

	ddz_match_manager:setOutCardButtonState()
end