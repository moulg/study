--[[
	结算面板
]]

-- local panel_ui = require "game.goldflower_std.script.ui_create.ui_goldflower_settle"
local cardsType = {"235","单张","对子","顺子","金花","顺金","豹子"}

CGoldFlowerSettleAccounts = class("CGoldFlowerSettleAccounts",function()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
    return ret
end)

function CGoldFlowerSettleAccounts.create(callback)
	-- body
	local layer = CGoldFlowerSettleAccounts.new()
	if layer ~= nil then
		layer:init_ui(callback)
		layer:regEnterExit()
		return layer
	end
end
function CGoldFlowerSettleAccounts:regEnterExit()
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

function CGoldFlowerSettleAccounts:onEnter()
	--防止穿透
	self:setTouchEnabled(true)
end

function CGoldFlowerSettleAccounts:onExit()
	self:removeTimeDown()
end
function CGoldFlowerSettleAccounts:init_ui(callback)
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))

	local node = cc.CSLoader:createNode("game/goldflower_std/script/ui_create/ui_goldflower_settle.csb")
	-- dump(node)
	node:setPosition(size.width/2,size.height/2+100)
	self:addChild(node)
    local action = cc.CSLoader:createTimeline("game/goldflower_std/script/ui_create/ui_goldflower_settle.csb")
    node:runAction(action)
    action:gotoFrameAndPlay(0, false)

    self.panel_ui = node:getChildByName("imgBack")

    self.labPlayerNameList = {self.panel_ui:getChildByName("namePlayer1"),self.panel_ui:getChildByName("namePlayer2"),self.panel_ui:getChildByName("namePlayer3"),
		self.panel_ui:getChildByName("namePlayer4"),self.panel_ui:getChildByName("namePlayer5"),}
	self.labCardTypeList = {self.panel_ui:getChildByName("typePlayer1"),self.panel_ui:getChildByName("typePlayer2"),self.panel_ui:getChildByName("typePlayer3"),
		self.panel_ui:getChildByName("typePlayer4"),self.panel_ui:getChildByName("typePlayer5"),}
	self.labChipsList = {self.panel_ui:getChildByName("chipPlayer1"),self.panel_ui:getChildByName("chipPlayer2"),self.panel_ui:getChildByName("chipPlayer3"),
	self.panel_ui:getChildByName("chipPlayer4"),self.panel_ui:getChildByName("chipPlayer5"),}
	for i=1,5 do
		self.labPlayerNameList[i]:setString("")
		self.labCardTypeList[i]:setString("")
		self.labChipsList[i]:setString("")
	end

	self.nodeCardList = {self.panel_ui:getChildByName("nodeCard1"),self.panel_ui:getChildByName("nodeCard2"),self.panel_ui:getChildByName("nodeCard3"),
		self.panel_ui:getChildByName("nodeCard4"),self.panel_ui:getChildByName("nodeCard5"),}

	self.fntExit = self.panel_ui:getChildByName("fntExit")
	self.btnExit = self.panel_ui:getChildByName("btnExit")

	 self.effectNode = node:getChildByName("effectNode")
	 self.effectWin = self.effectNode:getChildByName("effectWin")
	 self.effectLose = self.effectNode:getChildByName("effectLose")

	 if self.effectWin then self.effectWin:setVisible(false) end
	 if self.effectLose then self.effectLose:setVisible(false) end

    self.nodeXiQianEffect = cc.CSLoader:createNode("game/goldflower_std/script/ui_create/nodeXiQianEffect.csb")
	-- dump(node)
	self.nodeXiQianEffect:setPosition(size.width/2,size.height/2+100)
	self:addChild(self.nodeXiQianEffect)
    self.NodeCard = self.nodeXiQianEffect:getChildByName("NodeCard")
    self.sprTongHuaShun = self.NodeCard:getChildByName("sprTongHuaShun")
    self.sprBaoZi = self.NodeCard:getChildByName("sprBaoZi")
    self.PlayerName = self.NodeCard:getChildByName("PlayerName")
    self.PlayerNumber = self.NodeCard:getChildByName("PlayerNumber")
    self.nodeXiQianEffect:setVisible(false)


	

	self.btnExit:onTouch(function (e)
		if e.name == "ended" then
			callback()
		end
	end)
	self:startTimeDown(callback)

end

--开始倒计时
function CGoldFlowerSettleAccounts:startTimeDown(callback)
	timeUtils:remove(self.fntExit)
	local time = goldflower_time_config[3].time

	self.fntExit:setVisible(true)
	self:timeCallBackHandler(time)
	
	timeUtils:addTimeDown(self.fntExit, time, function ( t ) self:timeCallBackHandler(t) end,
		function ( args ) 
			if callback then callback() end
		end)
end

--倒计时回调函数
function CGoldFlowerSettleAccounts:timeCallBackHandler(time)
	self.fntExit:setVisible(true)
	local showtime = math.ceil(time)
	if self.fntExit then
		self.fntExit:setString(tostring(showtime))
	end
end
--移除倒计时
function CGoldFlowerSettleAccounts:removeTimeDown()
	self.fntExit:setVisible(false)
	timeUtils:remove(self.fntExit)
end
function CGoldFlowerSettleAccounts:balance()
	if goldflower_manager.billInfo then
		-- goldflower_manager:updateRecord()
		local bIsWin = false 
		for k,v in pairs(goldflower_manager.billInfo) do
			if goldflower_manager._seatsMap[v.order] then
				if goldflower_manager._recordData[v.playerName] then
					goldflower_manager._recordData[v.playerName].count = v.chips
					goldflower_manager._recordData[v.playerName].totalCount = long_plus(goldflower_manager._recordData[v.playerName].totalCount, v.chips)
				end

				if v.order == goldflower_manager._mySeatOrder then
					if long_compare(v.chips,0) > 0 then
						bIsWin = true 
					end
				end
			end

			self.labPlayerNameList[k]:setString(textUtils.replaceStr(v.playerName, NAME_BITE_LIMIT, ".."))
			self.labCardTypeList[k]:setString(cardsType[v.cardsType+1])
			self.labChipsList[k]:setString(v.chips)

			if v.cards then
				for i,cardId in pairs(v.cards) do
					local sprCard = cc.Sprite:create()
					local sprFrame = display.newSpriteFrame(goldflower_card_data[cardId].card_big)
					sprCard:setSpriteFrame(sprFrame)
					sprCard:setScale(0.3)
					sprCard:setPositionX((i-1)*15)
					self.nodeCardList[k]:addChild(sprCard)
				end
			end

			if long_compare(v.luck,0) > 0 then
				self.PlayerName:setString(playerName)
			    self.PlayerNumber:setString(v.luck)
				self.sprTongHuaShun:setVisible(v.cardsType == 5)
			    self.sprBaoZi:setVisible(v.cardsType == 6)
			 
			    performWithDelay(self,function ()
			    	self:playXiQianEffect()
			    end,1.5)
			    
			end
		end

		--胜利失败特效
		if bIsWin then 
			self.effectWin:setVisible(true)
			audio_manager:playOtherSound(4)
		else
			self.effectLose:setVisible(true)
			audio_manager:playOtherSound(3)
		end

		--统计
		-- local game_goldflower = WindowScene.getInstance():getModuleObjByClassName("CGoldFlowerMainScene")
		-- if game_goldflower and game_goldflower.isLoadEnd == true then
		-- 	game_goldflower.statistics_ui:updateUi(goldflower_manager._recordData)
		-- end
	end
end

function CGoldFlowerSettleAccounts:playXiQianEffect()
	self.nodeXiQianEffect:setVisible(true)
	local actionXiQianEffect = cc.CSLoader:createTimeline("game/goldflower_std/script/ui_create/nodeXiQianEffect.csb")
    self.nodeXiQianEffect:runAction(actionXiQianEffect)
    actionXiQianEffect:gotoFrameAndPlay(0, false)
end