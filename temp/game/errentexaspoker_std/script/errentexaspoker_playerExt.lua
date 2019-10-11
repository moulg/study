--[[
玩家信息界面
]]

local READY_TIME = errentexaspoker_time_config[1].time
local STAGE_TIME = errentexaspoker_time_config[2].time





CErRenTexasPlayerExt = class("CErRenTexasPlayerExt", function ()
	local ret = cc.Node:create()
	return ret
end)

CErRenTexasPlayerExt.SELF = 1
CErRenTexasPlayerExt.OTHER = 2

function CErRenTexasPlayerExt.create(dir)
	local node = CErRenTexasPlayerExt.new()
	if node ~= nil then
		node:init_ui(dir)
		return node
	end
end

function CErRenTexasPlayerExt:init_ui(dir)
	self.dir = dir
	local panel_ui = nil
	if dir == self.SELF then
		panel_ui = require "game.errentexaspoker_std.script.ui_create.ui_errentexaspoker_player1"
	else
		panel_ui = require "game.errentexaspoker_std.script.ui_create.ui_errentexaspoker_player2"
	end
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)
	
	-- 进度槽
	self._trackSprite = cc.Sprite:create(errentexaspoker_imageRes_config["进度槽"].resPath)
	self._trackSprite:setPosition(self.panel_ui.sprHeadBg:getContentSize().width/2,self.panel_ui.sprHeadBg:getContentSize().height/2)
	self.panel_ui.sprHeadBg:addChild(self._trackSprite)
	local trackSize = self._trackSprite:getContentSize()
	--self._trackSprite:setPosition(0,0)
	self._trackSprite:setAnchorPoint(0.5,0.5)
	--self._trackSprite:setPosition(trackSize.width/2+5,trackSize.height/2+52)
	self._trackSprite:setVisible(false)

	--进度条
	self._progressTimer = cc.ProgressTimer:create(cc.Sprite:create(errentexaspoker_imageRes_config["进度条"].resPath))
	self._progressTimer:setPosition(self.panel_ui.sprHeadBg:getContentSize().width/2,self.panel_ui.sprHeadBg:getContentSize().height/2)
	self.panel_ui.sprHeadBg:addChild(self._progressTimer)
	self._progressTimer:setAnchorPoint(0.5,0.5)
	--self._progressTimer:setPosition(trackSize.width/2+5,trackSize.height/2+52)
	self._progressTimer:setVisible(false)
	self._progressTimer:setReverseDirection(true)

	self.cardList = {self.panel_ui.sprCard1,self.panel_ui.sprCard2}
	self.imgFrameList = {self.panel_ui.imgFrame1,self.panel_ui.imgFrame2}
end

function CErRenTexasPlayerExt:setInfo( memberinfo )
    self:clearGameInfo()
    self:clearTimeDown()

    self.playerName = memberinfo.playerName
	self.order = memberinfo.order --座位顺序(0-1)
	self.playerId = memberinfo.playerId --玩家id,0代表座位上没有人
	self.state = memberinfo.state --状态(0:站立,1:入座,2:准备,3:游戏中)
	self.sex = memberinfo.sex --性别
	self.tableId = memberinfo.tableId
	self:setChips( memberinfo.chips ) --筹码
	-- self.panel_ui.labName:setString(textUtils.replaceStr(memberinfo.playerName, NAME_BITE_LIMIT, ".."))
	self.panel_ui.labName:setString(memberinfo.playerName)
	-- if long_compare(self.playerId, get_player_info().id) == 0 then
	-- 	self.panel_ui.labName:setColor(cc.c3b(0,0,255))
	-- end
	--$(SolutionDir)$(Configuration).win32;

	self.panel_ui.sprHead:setVisible(true)
	uiUtils:setPlayerHead(self.panel_ui.sprHead, memberinfo.sex, uiUtils.HEAD_SIZE_223)
	self.panel_ui.imgReady:setVisible(self.state == 2)

	if memberinfo.state == 0 then
		self:clearPlayerInfo()
	end
end

function CErRenTexasPlayerExt:setChips( value )
	self.chips = value
	self.panel_ui.labOwnChips:setString(value)

	if self.order == errentexaspoker_manager._mySeatOrder then
		errentexaspoker_manager._ownChips = value
	end 
end

function CErRenTexasPlayerExt:clearPlayerInfo()
	self.panel_ui.imgReady:setVisible(false)
	self.panel_ui.sprHead:setVisible(false)
	self.panel_ui.labName:setString("")
	self.panel_ui.labOwnChips:setString(0)
end

--开始倒计时  type 1:准备倒计时  2:回合倒计时
function CErRenTexasPlayerExt:startTimeDown(type, callBack)
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

		self:clearTimeDown()
	end, time)
end

--清除游戏数据
function CErRenTexasPlayerExt:clearGameInfo()
	print("--清除游戏数据")
	self.panel_ui.sprCard1:stopAllActions()
	self.panel_ui.sprCard2:stopAllActions()

	self.panel_ui.sprCard0:setVisible(false)
	self.panel_ui.sprCard1:setVisible(false)
	self.panel_ui.sprCard2:setVisible(false)
	self.panel_ui.imgFrame1:setVisible(false)
	self.panel_ui.imgFrame2:setVisible(false)

	self.panel_ui.sprCardType:setVisible(false)

	self.panel_ui.imgReady:setVisible(false)
	self.panel_ui.sprBetType:setVisible(false)
	self.handCardNum = 0

	-- if self.cardFrameMap then
	--     for k,img in pairs(self.cardFrameMap) do
	-- 	    img:removeFromParent()
	--     end
	--     self.cardFrameMap = {}
 --    end
 --    if self.cardImageMap then
	--     for k,img in pairs(self.cardImageMap) do
	-- 	    img:removeFromParent()
	--     end
	--     self.cardImageMap = {}
 --    end

	self.cardFrameMap = {}
	self.cardImageMap = {}
	self.state = 1
end

--添加手牌
function CErRenTexasPlayerExt:addOneHandCard(cardid)
	print("cardid:",cardid)
	self.handCardNum = self.handCardNum + 1
	local sprFrame
    local key 
	if cardid then
		sprFrame = display.newSpriteFrame(errentexaspoker_card_data[cardid].card_big)
	    self.cardFrameMap[cardid] = self.imgFrameList[self.handCardNum]

	    self.cardList[self.handCardNum]:setSpriteFrame(sprFrame)
		self.cardList[self.handCardNum]:setVisible(true)
	else
		sprFrame = display.newSpriteFrame(errentexaspoker_card_data[52].card_big)
		self.cardList[self.handCardNum]:setSpriteFrame(sprFrame)
		-- self.cardList[self.handCardNum]:setVisible(true)
		-- self.panel_ui.sprCard0:setVisible(true)
	end

	if cardid == nil and self.handCardNum == 2 then
		self.panel_ui.sprCard0:setVisible(true)
	end
	
	if cardid then
		self.cardImageMap[cardid] = self.cardList[self.handCardNum]
	end
end

--选中牌高亮
function CErRenTexasPlayerExt:showSelectedCards(list)
	-- dump(list)	
	for i,id in ipairs(list) do
		print("id >>>>",id)
		-- dump(self.cardFrameMap[id])
		self.cardFrameMap[id]:setVisible(true)

		self.cardImageMap[id]:stopAllActions()
		local jump1 = cc.JumpBy:create(1, cc.p(0, 0), 20, 4)
		local jump2 = jump1:reverse()
		local actions = cc.RepeatForever:create( cc.Sequence:create(jump1, jump2) )
		self.cardImageMap[id]:runAction(actions)
	end
end

function CErRenTexasPlayerExt:hideSelectState()
	for k,card in pairs(self.cardFrameMap) do
		card:setVisible(false)
	end

	self.panel_ui.sprCard1:stopAllActions()
	self.panel_ui.sprCard2:stopAllActions()

	if self.dir == 1 then
		self.panel_ui.sprCard1:setPositionY(230)
		self.panel_ui.sprCard2:setPositionY(220) 
	else
		self.panel_ui.sprCard1:setPositionY(20)
		self.panel_ui.sprCard2:setPositionY(20)
	end
end

function CErRenTexasPlayerExt:showCardType(cardType)
	print("显示牌型")
	self.panel_ui.sprCardType:setTexture(errentexaspoker_cardtype_config[cardType].resPath)
	self.panel_ui.sprCardType:setVisible(true)
end
--设置玩家状态
function CErRenTexasPlayerExt:setPlayerState(state)
	self.state = state
	self.panel_ui.sprBetType:setVisible(true)
	self.panel_ui.sprBetType:setTexture(errentexaspoker_imageRes_config[state].resPath)
end

--玩家准备
function CErRenTexasPlayerExt:setPlayerReady(value)
	self.panel_ui.imgReady:setVisible(value)
	if value then
		self:clearTimeDown()
		
		if self.dir == 1 then
			self.panel_ui.sprCard1:stopAllActions()
			self.panel_ui.sprCard2:stopAllActions()
			self.panel_ui.sprCard1:setPositionY(230)
			self.panel_ui.sprCard2:setPositionY(230)
		else
			self.panel_ui.sprCard1:setPositionY(20)
			self.panel_ui.sprCard2:setPositionY(20)
		end
	end
end

--清除倒计时
function CErRenTexasPlayerExt:clearTimeDown()
	self._progressTimer:setVisible(false)
	self._trackSprite:setVisible(false)
	self._progressTimer:stopAllActions()
end