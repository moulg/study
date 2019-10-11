--[[
玩家信息界面
]]

local READY_TIME = goldflower_time_config[1].time
local STAGE_TIME = goldflower_time_config[2].time

local panel_ui1 = require "game.goldflower_std.script.ui_create.ui_goldflower_player1"
local panel_ui2 = require "game.goldflower_std.script.ui_create.ui_goldflower_player2"
local panel_ui3 = require "game.goldflower_std.script.ui_create.ui_goldflower_player3"
local panel_ui4 = require "game.goldflower_std.script.ui_create.ui_goldflower_player4"
local panel_ui5 = require "game.goldflower_std.script.ui_create.ui_goldflower_player5"

--比牌位置坐标
local versusPos = {{x = 600, y = 780}, {x = 1300, y = 780},}
local panel_ui_lst = {panel_ui1,panel_ui2,panel_ui3,panel_ui4,panel_ui5,}

CGoldFlowerPlayerExt = class("CGoldFlowerPlayerExt", function ()
	local ret = cc.Node:create()
	return ret
end)


function CGoldFlowerPlayerExt.create(order)
	local node = CGoldFlowerPlayerExt.new()
	if node ~= nil then
		node:init_ui(order)
		return node
	end
end

function CGoldFlowerPlayerExt:init_ui(order)
	local panel_ui = panel_ui_lst[order+1]
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)
	
	self.sprCardList = {self.panel_ui.sprCard1,self.panel_ui.sprCard2,self.panel_ui.sprCard3,}
	
	local startPosX,startPosY = self.panel_ui.nodeCardParent:getPosition()
	self.nodeCardStartPos = cc.p(startPosX,startPosY)

	self.nodeVersusEffect = cc.CSLoader:createNode("game/goldflower_std/script/ui_create/nodEffect.csb")
	self.panel_ui.nodeCard:addChild(self.nodeVersusEffect)
    local action = cc.CSLoader:createTimeline("game/goldflower_std/script/ui_create/nodEffect.csb")
    self.nodeVersusEffect:runAction(action)
    action:gotoFrameAndPlay(0, true)
    self.imgSelectVersus = self.nodeVersusEffect:getChildByTag(485)
    self.imgSelectVersus:setTouchEnabled(false)
    self.nodeVersusEffect:setVisible(false)
    self.imgSelectVersus:onTouch(function (e)
		if e.name == "ended" then
			local game_goldflower = WindowScene.getInstance():getModuleObjByClassName("CGoldFlowerMainScene")
			if game_goldflower then
				game_goldflower:showVersusEffect(false)
			end
			send_zjh_ReqVersus({other = self.playerId})
		end
	end)

	--进度槽
	self._trackSprite = cc.Sprite:create(goldflower_imageRes_config["进度槽"].resPath)
	self.panel_ui.imgHeadBg:addChild(self._trackSprite)
	local trackSize = self._trackSprite:getContentSize()
	self._trackSprite:setAnchorPoint(0.5,0.5)
	self._trackSprite:setPosition(trackSize.width/2,trackSize.height/2)

	--进度条
	self._progressTimer = cc.ProgressTimer:create(cc.Sprite:create(goldflower_imageRes_config["进度条"].resPath))
	self.panel_ui.imgHeadBg:addChild(self._progressTimer)
	local progressSize = self._progressTimer:getContentSize()
	self._progressTimer:setAnchorPoint(0.5,0.5)
	self._progressTimer:setPosition(progressSize.width/2,progressSize.height/2)
	self._progressTimer:setVisible(false)
	self._progressTimer:setReverseDirection(true)

	self.panel_ui.imgStatusbg:setVisible(false)
	self.panel_ui.sprDiscard:setVisible(false)
	self.panel_ui.sprFail:setVisible(false)
end

function CGoldFlowerPlayerExt:setInfo( memberinfo )
    self:clearGameInfo()
    self:removeTimeDown()
    self:setShowCard(false)

    self.playerName = memberinfo.playerName
	self.order = memberinfo.order --座位顺序(0-1)
	self.playerId = memberinfo.playerId --玩家id,0代表座位上没有人
	self.state = memberinfo.state --状态(0:站立,1:入座,2:准备,3:游戏中)
	self.sex = memberinfo.sex --性别
	self.tableId = memberinfo.tableId
	self:setChips( memberinfo.chips ) --筹码
	self.panel_ui.labName:setString(textUtils.replaceStr(memberinfo.playerName, NAME_BITE_LIMIT, ".."))
	self.bIsSawCard = false --是否看过牌
	

	self.panel_ui.sprHead:setVisible(true)
	-- uiUtils:setPlayerHead(self.panel_ui.imgHead, memberinfo.icon, uiUtils.HEAD_SIZE_115)
	uiUtils:setPhonePlayerHead(self.panel_ui.sprHead, memberinfo.sex, uiUtils.HEAD_SIZE_223)
	self.panel_ui.imgReady:setVisible(self.state == 2)

	if memberinfo.state == 0 then
		self:clearPlayerInfo()
	end
end

function CGoldFlowerPlayerExt:setChips( value )
	self.chips = value
	self.panel_ui.labChips:setString(value)

	if self.order == goldflower_manager._mySeatOrder then
		goldflower_manager._ownChips = value
	end 
end

function CGoldFlowerPlayerExt:clearPlayerInfo()
	self.panel_ui.imgReady:setVisible(false)
	self.panel_ui.imgHead:setVisible(false)
	self.panel_ui.labName:setString("")
	self.panel_ui.labChips:setString(0)
end

--开始倒计时  type 1:准备倒计时  2:回合倒计时
function CGoldFlowerPlayerExt:startTimeDown(type, callBack)
	timeUtils:remove(self.panel_ui.fntClock)
	local time = 0
	if type == 1 then
		time = READY_TIME
	else
		time = STAGE_TIME
	end

	self._progressTimer:stopAllActions()
	self._trackSprite:setVisible(true)
	self._progressTimer:setVisible(true)
	self._progressTimer:setPercentage(100)

	local seq_arr = {}
	local progressAction = cc.RepeatForever:create(cc.ProgressTo:create(time, 0)) 

	self._progressTimer:runAction(progressAction)

	performWithDelay(self._progressTimer, function ()
		if callBack then
			callBack()
		end
		self:removeTimeDown()
	end, time)
end

--移除倒计时
function CGoldFlowerPlayerExt:removeTimeDown()
	self._progressTimer:setVisible(false)
	self._trackSprite:setVisible(false)
	self._progressTimer:stopAllActions()
end

--清除游戏数据
function CGoldFlowerPlayerExt:clearGameInfo()
	self.panel_ui.nodeCard:setVisible(true)
	self.panel_ui.imgStatusbg:setVisible(false)
	self.panel_ui.sprDiscard:setVisible(false)
	self.panel_ui.sprFail:setVisible(false)
	self.panel_ui.imgReady:setVisible(false)
	self.panel_ui.imgStatusbg:setVisible(false)
	
	self.handCardNum = 0
	self.cardArr = {}
	self.state = 1
	self.chips = "0"
	self.bIsSawCard = false
	self.cardList = nil
	self.bIsFail = false
end

--显示/隐藏手牌
function CGoldFlowerPlayerExt:setShowCard(bShow)
	for k,v in pairs(self.sprCardList) do
		if bShow == false then
			local sprFrame = display.newSpriteFrame(goldflower_card_data[52].card_big)
			v:setSpriteFrame(sprFrame)
		end
		v:setVisible(bShow)
	end
end

--添加手牌
function CGoldFlowerPlayerExt:addOneHandCard(cardid)
	self.handCardNum = self.handCardNum + 1
	
	if cardid then table.insert(self.cardArr, cardid) end
	if self.sprCardList[self.handCardNum] then 
		local sprFrame = display.newSpriteFrame(goldflower_card_data[52].card_big)
		self.sprCardList[self.handCardNum]:setSpriteFrame(sprFrame)
		self.sprCardList[self.handCardNum]:setVisible(true)
	else
		print("手牌数量出错：" ..self.handCardNum)
	end
end

--玩家准备
function CGoldFlowerPlayerExt:setPlayerReady(value)
	if value then
		self.state = 2
		self:clearGameInfo()
		--停止倒计时
		self:removeTimeDown()
	end
	self.panel_ui.imgReady:setVisible(value)
end

function CGoldFlowerPlayerExt:setRealOrder(realOrder)
	self.realOrder = realOrder
end
function CGoldFlowerPlayerExt:getRealOrder()
	return self.realOrder
end

--看过牌
function CGoldFlowerPlayerExt:setSawCard()
	self.bIsSawCard = true
	if self.order ~= goldflower_manager._mySeatOrder then
		self.panel_ui.imgStatusbg:setVisible(true)
		self.panel_ui.sprStatus:setTexture("game/goldflower_std/resource/word/kanpai.png")
		self.panel_ui.sprStatus:setVisible(true)
	end
end

--自己看牌结果
function CGoldFlowerPlayerExt:setSeeCardResult(cardList)
	self.panel_ui.sprDiscard:setVisible(false)
	self.panel_ui.imgStatusbg:setVisible(false)
	self.panel_ui.sprFail:setVisible(false)
	self.panel_ui.nodeCard:setVisible(true)
	self.cardList = cardList
	for k,v in pairs(cardList) do
		local sprFrame = display.newSpriteFrame(goldflower_card_data[v].card_big)
		self.sprCardList[k]:setSpriteFrame(sprFrame)
	end
end

--弃牌
function CGoldFlowerPlayerExt:setDisCard()
	self.panel_ui.nodeCard:setVisible(false)
	self.panel_ui.sprDiscard:setVisible(true)
	self.bIsFail = true
end

--比牌失败
function CGoldFlowerPlayerExt:setVersusFail()
	self.panel_ui.nodeCard:setVisible(false)
	self.panel_ui.sprFail:setVisible(true)
end

--播放选择比牌效果
function CGoldFlowerPlayerExt:showVersusEffect(bShow)
	self.nodeVersusEffect:setVisible(bShow)
	self.imgSelectVersus:setTouchEnabled(bShow)
end

--主动比牌移动动画
function CGoldFlowerPlayerExt:setVersusMoveTo()
	self.panel_ui.imgStatusbg:setVisible(false)
	self.panel_ui.nodeCardParent:setPosition(self.nodeCardStartPos)
	local endPos = versusPos[1]

	if (self.order == goldflower_manager._mySeatOrder) and self.bIsSawCard then
		for k,v in pairs(self.sprCardList) do
		 	local sprFrame = display.newSpriteFrame(goldflower_card_data[52].card_big)
			v:setSpriteFrame(sprFrame)
		end
	end

	local moveTo = cc.MoveTo:create(0.5,cc.p(endPos.x,endPos.y))
	self.panel_ui.nodeCardParent:runAction(moveTo)

end

--被动比牌移动动画
function CGoldFlowerPlayerExt:setVersusMoveToVs()
	self.panel_ui.imgStatusbg:setVisible(false)
	self.panel_ui.nodeCardParent:setPosition(self.nodeCardStartPos)
	local endPos = versusPos[2]

	if (self.order == goldflower_manager._mySeatOrder) and self.bIsSawCard then
		for k,v in pairs(self.sprCardList) do
		 	local sprFrame = display.newSpriteFrame(goldflower_card_data[52].card_big)
			v:setSpriteFrame(sprFrame)
		end
	end
	
	local moveTo = cc.MoveTo:create(0.5,cc.p(endPos.x,endPos.y))
	self.panel_ui.nodeCardParent:runAction(moveTo)
end

--比牌结果
function CGoldFlowerPlayerExt:setVersusResult(playerId,vsPlayerId,win)
	local endPosX,endPosY = self.panel_ui.nodeCardParent:getPosition()
	if ((self.playerId == playerId) and (win == 0)) or ((self.playerId == vsPlayerId) and (win ~= 0)) then
		self.panel_ui.nodeCard:setVisible(false)
		self.panel_ui.sprFail:setVisible(true)
		self.bIsFail = true
	end

	local bIsWin = self:getMyselfIsWin(playerId,vsPlayerId,win)
	local bIsLose = self:getMyselfIsLose(playerId,vsPlayerId,win)
	
	if bIsWin then audio_manager:playOtherSound(7) end
	if bIsLose then audio_manager:playOtherSound(6) end

end

--比牌返回动画
function CGoldFlowerPlayerExt:setVersusMoveBack(playerId,vsPlayerId,win)
	local moveTo = cc.MoveTo:create(1.0,self.nodeCardStartPos)
	self.panel_ui.nodeCardParent:runAction(moveTo)
end

--如果是自己已看牌，比牌胜利则显示牌
function CGoldFlowerPlayerExt:showCardsAfterVersus(playerId,vsPlayerId,win)
	if self.bIsSawCard then
		if ((self.playerId == playerId) and (win ~= 0)) or ((self.playerId == vsPlayerId) and (win == 0)) then
			if self:getMyselfIsWin(playerId,vsPlayerId,win) and self.cardList then
				for k,v in pairs(self.cardList) do
					local sprFrame = display.newSpriteFrame(goldflower_card_data[v].card_big)
					self.sprCardList[k]:setSpriteFrame(sprFrame)
				end
			else
				self:setSawCard()
			end
		end
	end
end

--判断自己是否赢
function CGoldFlowerPlayerExt:getMyselfIsWin(playerId,vsPlayerId,win)
	local bIsWin = false
	local playerInfo = get_player_info()
	if ((playerInfo.id == playerId) and (win ~= 0)) or ((playerInfo.id == vsPlayerId) and (win == 0)) then
		bIsWin = true
	end
	return bIsWin
end

--判断自己是否输
function CGoldFlowerPlayerExt:getMyselfIsLose(playerId,vsPlayerId,win)
	local bIsLose = false
	local playerInfo = get_player_info()
	if ((playerInfo.id == playerId) and (win == 0)) or ((playerInfo.id == vsPlayerId) and (win ~= 0)) then
		bIsLose = true
	end
	return bIsLose
end