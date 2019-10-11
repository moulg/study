
local panel_ui = require "game.ddz_match_std.script.ui_create.ui_ddzMatch_rankWait"


CDdzMatchRankingWait = class("CDdzMatchRankingWait", function ()
	-- body
	local  ret = cc.Node:create()
	return ret
end)

function CDdzMatchRankingWait.create()
	-- body
	local layer = CDdzMatchRankingWait.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end

function CDdzMatchRankingWait:regEnterExit()
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

function CDdzMatchRankingWait:onEnter()
	
end

function CDdzMatchRankingWait:onExit()
	for i,v in ipairs(self._ballList) do
		v:removeFromParent()
	end
	self._ballList = nil
	self._ballMap = nil
end

function CDdzMatchRankingWait:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)

	self._ballList = {}
	self._ballMap = {}
end

--[[
	info = {
		名称:runs 类型:int 备注:比赛轮数(0:预赛)
		名称:nums 类型:List<int> 备注:比赛轮数人数
		名称:tables 类型:int 备注:正在比赛的桌子数
	}
]]
function CDdzMatchRankingWait:setInfo( info )
	if #self._ballList > 0 then
		return
	end

	local list = info.nums
	self._curIndex = info.runs
	local i = 1
	local endIndex = self._curIndex + 5

	for curIndex = self._curIndex, endIndex do
		if list[curIndex] then
			local item = CDdzMatchBall.create()
			item:setInfo(list[curIndex])
			self.panel_ui.nodeBall:addChild(item)
			table.insert(self._ballList, item)
			self._ballMap[curIndex] = item

			if curIndex == 1 then
				item:createBeginMatchBall()
			else
				if i == 1 then
					item:createAdvancedBall()
				else
					item:createAdvanceBall()
				end
			end
			i = i + 1
		elseif curIndex <= endIndex then
			local item = CDdzMatchBall.create()
			item:setInfo(1)
			self.panel_ui.nodeBall:addChild(item)
			table.insert(self._ballList, item)
			self._ballMap[curIndex] = item
			item:createChampion()
			break
		end
	end

	local size = self._ballList[1]:getContentSize()
	size.width = size.width - 10
	local num = #self._ballList
	local beginX = -(num - 1)*size.width/2
	for i,v in ipairs(self._ballList) do
		local px
		if i ~= #self._ballList then
			px = beginX + (i - 1) * size.width
		else
			px = beginX + (i - 2) * size.width
			px = px + size.width/2
			px = px + (v:getContentSize().width - 10)/2
		end
		v:setPositionX(px)
		v:setLocalZOrder(i)
	end

	self.panel_ui.fntTableNum:setString(info.tables)
end

function CDdzMatchRankingWait:updateTableNum( num )
	self.panel_ui.fntTableNum:setString(num)
end

function CDdzMatchRankingWait:rankingResult()
	self._curIndex = self._curIndex + 1
	if self._ballMap[self._curIndex] then
		self._ballMap[self._curIndex]:playAdvanceAction()
	end
end