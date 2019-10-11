--[[
德州统计
]]

local panel_ui = require "game.foursniuniu_std.script.ui_create.ui_4p_statistic"

CFourNiuNiuStatistics = class("CFourNiuNiuStatistics", function ()
	local ret = cc.Node:create()
	return ret
end)

function CFourNiuNiuStatistics.create()
	-- body
	local node = CFourNiuNiuStatistics.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end

function CFourNiuNiuStatistics:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	self.panel_ui.btnStatistic:onTouch(function (e)
		if e.name == "ended" then
			self:showHidePanel()
		end
	end)

	self.ismoveOut = true
end

function CFourNiuNiuStatistics:showHidePanel()
	if self.ismoveOut then
		self:moveOut()
	else
		self:moveIn()
	end
	self.ismoveOut = not self.ismoveOut
end

function CFourNiuNiuStatistics:moveIn()
	local size = self.panel_ui.Nroom_bg1_1:getContentSize()

	local move_action = cc.MoveBy:create(0.3, cc.p(0, size.height))
	self:runAction(move_action)
end

function CFourNiuNiuStatistics:moveOut()
	local size = self.panel_ui.Nroom_bg1_1:getContentSize()

	local move_action = cc.MoveBy:create(0.3, cc.p(0, -size.height))
	self:runAction(move_action)
end

function CFourNiuNiuStatistics:setInfo( datalist )
	local order = 0
	local function findNext()
		if datalist[order] then
			return datalist[order]
		elseif order < 4 then
			order = order + 1
			return findNext(order)
		end

		return nil
	end

	for i = 1, 4 do
		local data = findNext()
		if data then
			order = order + 1
			local name = textUtils.replaceStr(data.name, NAME_BITE_LIMIT, "..")
			local key = "labName"..i
			self.panel_ui[key]:setString(name)
			key = "labCount"..i
			self.panel_ui[key]:setString(data.count)
			key = "labTotalCount"..i
			self.panel_ui[key]:setString(data.totalCount)
		else
			local key = "labName"..i
			self.panel_ui[key]:setString("")
			key = "labCount"..i
			self.panel_ui[key]:setString("")
			key = "labTotalCount"..i
			self.panel_ui[key]:setString("")
		end
	end

end