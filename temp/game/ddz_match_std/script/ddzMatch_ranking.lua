
local panel_ui = require "game.ddz_match_std.script.ui_create.ui_ddzMatch_rank"

CDdzMatchRanking = class("CDdzMatchRanking", function ()
	local ret = cc.Node:create()
	return ret
end)

function CDdzMatchRanking.create()
	-- body
	local layer = CDdzMatchRanking.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end

function CDdzMatchRanking:regEnterExit()
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

function CDdzMatchRanking:onEnter()
	
end

function CDdzMatchRanking:onExit()
	timeUtils:remove(self.panel_ui.fntMatchTime)
end

function CDdzMatchRanking:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)

	self._labelList = {}

	self:registerHandler()
	self:addButtonHighLight()

	self.panel_ui.btnIn:setVisible(false)
	self.panel_ui.btnOut:setVisible(true)

	self.panel_ui.fntMatchTime:setString("00r00r00")
	timeUtils:addTimeUp(self.panel_ui.fntMatchTime, function ( t )
		local str = textUtils.timeToSecondStr( t )
		str = (string.gsub(str, ":", "r"))
		self.panel_ui.fntMatchTime:setString(str)
	end)
end

function CDdzMatchRanking:registerHandler()
	self.panel_ui.btnIn:onTouch(function (e)
		if e.name == "ended" then
			self:moveIn()
			self.panel_ui.btnIn:setVisible(false)
			self.panel_ui.btnOut:setVisible(true)
		end
	end)

	self.panel_ui.btnOut:onTouch(function (e)
		if e.name == "ended" then
			self:moveOut()
			self.panel_ui.btnIn:setVisible(true)
			self.panel_ui.btnOut:setVisible(false)
		end
	end)
end

function CDdzMatchRanking:addButtonHighLight()
	local btnArr = {self.panel_ui.btnIn, self.panel_ui.btnOut,
			}

	local resArr = {"shouru2.png", "tanchu2.png",
					}

	for i,btn in ipairs(btnArr) do
		local mov_obj = cc.Sprite:create("game/ddz_match_std/resource/button/"..resArr[i])
		WindowScene.getInstance():registerBtnMouseMoveEff(btn,mov_obj,1)
	end
end

function CDdzMatchRanking:setRankingInfo( seatsInfo, runsPlayerNum )
	for i=1,3 do
		local key = "labRank"..i
		self.panel_ui[key]:setString("")
		key = "labName"..i
		self.panel_ui[key]:setString("")
		key = "labScore"..i
		self.panel_ui[key]:setString("")		
	end

	self.panel_ui.fntTotalNum:setString("r"..runsPlayerNum)

	table.sort( seatsInfo, function ( info1, info2 )
		if info1.order == ddz_match_manager._mySeatOrder then
			return true
		elseif info2.order == ddz_match_manager._mySeatOrder then
			return false
		else
			if info1.rank < info2.rank then
				return true
			else
				return false
			end
		end
	end )

	for i,info in ipairs(seatsInfo) do
		if info.order == ddz_match_manager._mySeatOrder then
			self.panel_ui.fntMyRank:setString(info.rank)
		end

		local key = "labRank"..i
		self.panel_ui[key]:setString(info.rank)
		key = "labName"..i
		local name = textUtils.replaceStr(info.playerName, NAME_BITE_LIMIT, "..")
		self.panel_ui[key]:setString(name)
		key = "labScore"..i
		self.panel_ui[key]:setString(info.cedits)
	end
end

function CDdzMatchRanking:moveIn()
	local size = self.panel_ui.sprBack:getContentSize()

	local windowSize = WindowScene.getInstance():getDesSize()
	local move_action = cc.MoveTo:create(0.3, cc.p(windowSize.w, windowSize.h/3))
	self:runAction(move_action)
end

function CDdzMatchRanking:moveOut()
	local size = self.panel_ui.sprBack:getContentSize()

	local windowSize = WindowScene.getInstance():getDesSize()
	local move_action = cc.MoveTo:create(0.3, cc.p(windowSize.w-size.width, windowSize.h/3))
	self:runAction(move_action)
end