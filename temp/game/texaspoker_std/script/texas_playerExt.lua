--[[
玩家信息界面
]]

local READY_TIME = texaporker_time_config[1].time
local STAGE_TIME = texaporker_time_config[2].time

local panel_ui1 = require "game.texaspoker_std.script.ui_create.ui_texaspoker_player1"
local panel_ui2 = require "game.texaspoker_std.script.ui_create.ui_texaspoker_player2"
local panel_ui3 = require "game.texaspoker_std.script.ui_create.ui_texaspoker_player3"
local panel_ui4 = require "game.texaspoker_std.script.ui_create.ui_texaspoker_player4"
local panel_ui5 = require "game.texaspoker_std.script.ui_create.ui_texaspoker_player5"
local panel_ui6 = require "game.texaspoker_std.script.ui_create.ui_texaspoker_player6"
local panel_ui7 = require "game.texaspoker_std.script.ui_create.ui_texaspoker_player7"
local panel_ui8 = require "game.texaspoker_std.script.ui_create.ui_texaspoker_player8"
local panel_ui_lst = {panel_ui1,panel_ui2,panel_ui3,panel_ui4,panel_ui5,panel_ui6,panel_ui7,panel_ui8,}

CTexasPlayerExt = class("CTexasPlayerExt", function ()
	local ret = cc.Node:create()
	return ret
end)


function CTexasPlayerExt.create(order)
	local node = CTexasPlayerExt.new()
	if node ~= nil then
		node:init_ui(order)
		return node
	end
end

function CTexasPlayerExt:init_ui(order)
	local panel_ui = panel_ui_lst[order]
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)
	
	--进度槽
	self._trackSprite = cc.Sprite:create(texas_imageRes_config["进度槽"].resPath)
	self._trackSprite:setPosition(self.panel_ui.sprHeadBg:getContentSize().width/2,self.panel_ui.sprHeadBg:getContentSize().height/2)
	self.panel_ui.sprHeadBg:addChild(self._trackSprite)
	local trackSize = self._trackSprite:getContentSize()
	self._trackSprite:setAnchorPoint(0.5,0.5)
	--self._trackSprite:setPosition(trackSize.width/2+5,trackSize.height/2+52)

	--进度条
	self._progressTimer = cc.ProgressTimer:create(cc.Sprite:create(texas_imageRes_config["进度条"].resPath))
	self._progressTimer:setPosition(self.panel_ui.sprHeadBg:getContentSize().width/2,self.panel_ui.sprHeadBg:getContentSize().height/2)
	self.panel_ui.sprHeadBg:addChild(self._progressTimer)
	local progressSize = self._progressTimer:getContentSize()
	self._progressTimer:setAnchorPoint(0.5,0.5)
	--self._progressTimer:setPosition(trackSize.width/2+5,trackSize.height/2+52)
	self._progressTimer:setVisible(false)
	self._progressTimer:setReverseDirection(true)

	self.cardPosY = self.panel_ui.sprCard1:getPositionY()
end

function CTexasPlayerExt:setInfo( memberinfo )
    self:clearGameInfo()
    self:clearTimeDown()

    self.playerName = memberinfo.playerName
	self.order = memberinfo.order --座位顺序(0-1)
	self.playerId = memberinfo.playerId --玩家id,0代表座位上没有人
	self.state = memberinfo.state --状态(0:站立,1:入座,2:准备,3:游戏中)
	self.sex = memberinfo.sex --性别
	self.tableId = memberinfo.tableId
	self:setChips( memberinfo.chips ) --筹码
	self.panel_ui.labName:setString(textUtils.replaceStr(memberinfo.playerName, NAME_BITE_LIMIT, ".."))
	if long_compare(self.playerId, get_player_info().id) == 0 then
		self.panel_ui.labName:setColor(cc.c3b(255,233,47))
	end

	self.panel_ui.sprHead:setVisible(true)
	-- uiUtils:setPlayerHead(self.panel_ui.sprHead, memberinfo.icon, uiUtils.HEAD_SIZE_50)
	uiUtils:setPhonePlayerHead(self.panel_ui.sprHead, memberinfo.sex, uiUtils.HEAD_SIZE_223)
	self.panel_ui.imgReady:setVisible(self.state == 2)

	if memberinfo.state == 0 then
		self:clearPlayerInfo()
	end
end

function CTexasPlayerExt:setChips( value )
	self.chips = value
	self.panel_ui.labOwnChips:setString(value)

	if self.order == texaspoker_manager._mySeatOrder then
		texaspoker_manager._ownChips = value
	end 
end

function CTexasPlayerExt:clearPlayerInfo()
	self.panel_ui.imgReady:setVisible(false)
	self.panel_ui.sprHead:setVisible(false)
	self.panel_ui.labName:setString("")
	self.panel_ui.labOwnChips:setString(0)
end

--开始倒计时  type 1:准备倒计时  2:回合倒计时
function CTexasPlayerExt:startTimeDown(type, callBack)
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
function CTexasPlayerExt:clearGameInfo()
	self.panel_ui.sprCard1:stopAllActions()
	self.panel_ui.sprCard2:stopAllActions()
	self.panel_ui.sprCard1:setVisible(false)
	self.panel_ui.sprCard2:setVisible(false)
	self.panel_ui.imgFrame1:setVisible(false)
	self.panel_ui.imgFrame2:setVisible(false)
	self.panel_ui.imgReady:setVisible(false)
	self.panel_ui.sprBetType:setVisible(false)
	self.panel_ui.sprCard0:setVisible(false)
	self.handCardNum = 0
	self.cardFrameMap = {}
	self.cardImageMap = {}
	self.state = 1
end

--添加手牌
function CTexasPlayerExt:addOneHandCard(cardid)
	self.handCardNum = self.handCardNum + 1

	local sprFrame
    local key 
	if cardid then
		sprFrame = display.newSpriteFrame(texas_card_data[cardid].card_big)

        key = "imgFrame"..self.handCardNum
	    self.cardFrameMap[cardid] = self.panel_ui[key]
	else
		sprFrame = display.newSpriteFrame(texas_card_data[52].card_big)
	end

	key = "sprCard"..self.handCardNum
	self.panel_ui[key]:setSpriteFrame(sprFrame)
	self.panel_ui[key]:setVisible(cardid ~= nil)
	if cardid then
		self.cardImageMap[cardid] = self.panel_ui[key]
	end
	if cardid == nil and self.handCardNum == 2 then
		self.panel_ui.sprCard0:setVisible(true)
	end
end

--选中牌高亮
function CTexasPlayerExt:showSelectedCards(list)
	for i,id in ipairs(list) do
		self.cardFrameMap[id]:setVisible(true)

		self.cardImageMap[id]:stopAllActions()
		local jump1 = cc.JumpBy:create(1, cc.p(0, 0), 10, 4)
		local jump2 = jump1:reverse()
		local actions = cc.RepeatForever:create( cc.Sequence:create(jump1, jump2) )
		self.cardImageMap[id]:runAction(actions)
	end
end

function CTexasPlayerExt:hideSelectState()
	for k,card in pairs(self.cardFrameMap) do
		card:setVisible(false)
	end

	self.panel_ui.sprCard1:stopAllActions()
	self.panel_ui.sprCard1:setPositionY(self.cardPosY)
	self.panel_ui.sprCard2:stopAllActions()
	self.panel_ui.sprCard2:setPositionY(self.cardPosY)
end

--设置玩家状态
function CTexasPlayerExt:setPlayerState(state)
	self.state = state
	self.panel_ui.sprBetType:setVisible(true)
	self.panel_ui.sprBetType:setTexture(texas_imageRes_config[state].resPath)
end

--玩家准备
function CTexasPlayerExt:setPlayerReady(value)
	self.panel_ui.imgReady:setVisible(value)
	if value then
		self:clearTimeDown()
		self.panel_ui.sprBetType:setVisible(false)
		self.panel_ui.sprCard1:stopAllActions()
		self.panel_ui.sprCard1:setPositionY(self.cardPosY)
		self.panel_ui.sprCard2:stopAllActions()
		self.panel_ui.sprCard2:setPositionY(self.cardPosY)
	end
end

--清除倒计时
function CTexasPlayerExt:clearTimeDown()
	self._progressTimer:setVisible(false)
	self._trackSprite:setVisible(false)
	self._progressTimer:stopAllActions()
end