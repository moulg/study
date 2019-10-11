--[[
斗地主比赛玩家
]]

CDdzMatchPlayer = class("CDdzMatchPlayer",function()
	local  ret = cc.Node:create()
	return ret
end)

CDdzMatchPlayer.BOTTOM = 1
CDdzMatchPlayer.RIGHT = 2
CDdzMatchPlayer.LEFT = 3

function CDdzMatchPlayer.create(dir)
	-- body
	local node = CDdzMatchPlayer.new()
	if node ~= nil then
		node:init_ui(dir)
		node:regEnterExit()
		return node
	end
end

function CDdzMatchPlayer:regEnterExit()
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

function CDdzMatchPlayer:onEnter()
	
end

function CDdzMatchPlayer:onExit()
	timeUtils:remove(self)
end

function CDdzMatchPlayer:init_ui(dir)
	if dir == self.BOTTOM then
		panel_ui = require "game.ddz_match_std.script.ui_create.ui_ddzMatch_playerB"
	elseif dir == self.LEFT then
		panel_ui = require "game.ddz_match_std.script.ui_create.ui_ddzMatch_playerL"
	else
		panel_ui = require "game.ddz_match_std.script.ui_create.ui_ddzMatch_playerR"
	end
	self.dir = dir

	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)
	self:clearInfo()
end

function CDdzMatchPlayer:clearInfo()
	timeUtils:remove(self)
	self:setVisible(false)
	self.panel_ui.imgDoubled:setVisible(false)
	self.panel_ui.talkBg:setVisible(false)
end

function CDdzMatchPlayer:showDoubled()
	self.panel_ui.imgDoubled:setVisible(true)
end


function CDdzMatchPlayer:setInfo( seatInfo )
	self:setVisible(true)
	self.order = seatInfo.order --座位顺序(0-1)
	self.playerId = seatInfo.playerId --玩家id,0代表座位上没有人
	self.sex = seatInfo.sex --性别
	self.playerName = seatInfo.playerName
	self.panel_ui.fntScore:setString(seatInfo.cedits)
	uiUtils:setPlayerHead(self.panel_ui.sprHead, seatInfo.icon, uiUtils.HEAD_SIZE_115)
	self.panel_ui.imgClock:setVisible(false)
	self.panel_ui.sprMark:setVisible(false)

	self._cardNum = 0
	if self.dir ~= self.BOTTOM then
		self.panel_ui.fntCardNum:setString(self._cardNum)
		self.panel_ui.sprOutLine:setVisible(false)
	end
end

function CDdzMatchPlayer:startTimeDown( time, callback )
	local function secondCallBack( t )
		self.panel_ui.fntTime:setString(t)
		if t <= 5 then
			audio_manager:playOtherSound(3)
		end	
	end

	local function endCallBack( t )
		if callback then
			-- callback()
		end
		self.panel_ui.imgClock:setVisible(false)	
	end

	timeUtils:addTimeDown(self, time, secondCallBack, endCallBack)
		
	self.panel_ui.fntTime:setString(time)
	self.panel_ui.imgClock:setVisible(true)
end

function CDdzMatchPlayer:removeTimeDown()
	timeUtils:remove(self)
	self.panel_ui.imgClock:setVisible(false)
end

function CDdzMatchPlayer:setDiZhu( order )
	local resUrl = "game/ddz_match_std/resource/image/"
	if order == self.order then
		resUrl = resUrl.."dizhutoubiao.png"
	else
		resUrl = resUrl.."nongmingtoubiao.png"
	end
	self.panel_ui.sprMark:setVisible(true)
	self.panel_ui.sprMark:setTexture(resUrl)
end

--更新积分/在线状态
function CDdzMatchPlayer:updateInfo( seatInfo )
	self.panel_ui.fntScore:setString(seatInfo.cedits)

	if self.dir ~= self.BOTTOM then
		if seatInfo.offline == 0 then
			self.panel_ui.sprOutLine:setVisible(false)
		else
			self.panel_ui.sprOutLine:setVisible(true)
		end
	end
end

--增加牌数量
function CDdzMatchPlayer:addCardNum( num )
	if self.dir ~= self.BOTTOM then
		self._cardNum = self._cardNum + num
		self.panel_ui.fntCardNum:setString(self._cardNum)
	end
end

--减少牌数量
function CDdzMatchPlayer:reduceCardNum( num )
	if self.dir ~= self.BOTTOM then
		self._cardNum = self._cardNum - num
		self.panel_ui.fntCardNum:setString(self._cardNum)
	end
end

--显示对话框
function CDdzMatchPlayer:showDialog( soundId )
	local resMap = {[53] = "cuipai1.png", [54] = "cuipai2.png", [55] = "zanyang1.png", [56] = "zanyang2.png", [57] = "chaofeng1.png", [58] = "chaofeng2.png"}
	self.panel_ui.sprTalkWord:setTexture("game/ddz_match_std/resource/word/"..resMap[soundId])
	self.panel_ui.talkBg:setVisible(true)
	self:stopAllActions()
	performWithDelay(self, function ()
		self.panel_ui.talkBg:setVisible(false)
	end, 2)
end

--玩家淘汰
function CDdzMatchPlayer:playerElimination( order )
	local node = cc.CSLoader:createNode("game/ddz_match_std/script/ui_create/ui_ddzMatch_dieOut.csb")
	self:addChild(node)
    local action = cc.CSLoader:createTimeline("game/ddz_match_std/script/ui_create/ui_ddzMatch_dieOut.csb")
    node:runAction(action)
    action:gotoFrameAndPlay(0, false)
end