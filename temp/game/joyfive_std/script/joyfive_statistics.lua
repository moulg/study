--[[
欢乐五张统计界面
]]

local panel_ui = require "game.joyfive_std.script.ui_create.ui_joyfive_statistics"

CJoyFiveStatistics = class("CJoyFiveStatistics", function ()
	local ret = cc.Node:create()
	return ret
end)


function CJoyFiveStatistics.create()
	local node = CJoyFiveStatistics.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end

function CJoyFiveStatistics:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.ismoveOut = true
	self.labNameList = {self.panel_ui.labName1,self.panel_ui.labName2,self.panel_ui.labName3,self.panel_ui.labName4,}
	self.labCountList = {self.panel_ui.labCount1,self.panel_ui.labCount2,self.panel_ui.labCount3,self.panel_ui.labCount4,}
	self.labTotalList = {self.panel_ui.labTotalCount1,self.panel_ui.labTotalCount2,self.panel_ui.labTotalCount3,self.panel_ui.labTotalCount4,}
end
function CJoyFiveStatistics:showHidePanel()
	if self.ismoveOut then
		self:moveOut()
	else
		self:moveIn()
	end
	self.ismoveOut = not self.ismoveOut
end

function CJoyFiveStatistics:moveIn()
	local size = self.panel_ui.StatisticsBg:getContentSize()

	local move_action = cc.MoveBy:create(0.3, cc.p(0, size.height))
	self:runAction(move_action)
end

function CJoyFiveStatistics:moveOut()
	local size = self.panel_ui.StatisticsBg:getContentSize()

	local move_action = cc.MoveBy:create(0.3, cc.p(0, -size.height))
	self:runAction(move_action)
end
--刷新统计记录
function CJoyFiveStatistics:updateUi(dataList)
	--按实际位置排序
	local function compareByRealOrder(a,b)
		return a.realOrder < b.realOrder
	end
	table.sort(dataList,compareByRealOrder)
	
	local recordData = {}
	for k,v in pairs(dataList) do
		recordData[#recordData + 1] = {name = v.name,count = v.count,totalCount = v.totalCount}
	end
	dump(recordData)
	for i=1,4 do
		self.labNameList[i]:setString("")
		self.labCountList[i]:setString("") 
		self.labTotalList[i]:setString("")
	end
	for k,v in pairs(recordData) do
		self.labNameList[k]:setString(textUtils.replaceStr(v.name, NAME_BITE_LIMIT, ".."))
		self.labCountList[k]:setString(v.count) 
		self.labTotalList[k]:setString(v.totalCount) 
	end
end