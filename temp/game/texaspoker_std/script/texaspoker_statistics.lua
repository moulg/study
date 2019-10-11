--[[
德州统计
]]

local panel_ui = require "game.texaspoker_std.script.ui_create.ui_texaspoker_int_statistics"

CTexaspokerStatistics = class("CTexaspokerStatistics", function ()
	local ret = cc.Node:create()
	return ret
end)

function CTexaspokerStatistics.create()
	-- body
	local node = CTexaspokerStatistics.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end

function CTexaspokerStatistics:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	self.panel_ui.btnStatistics:onTouch(function (e)
		if e.name == "ended" then
			self:showHidePanel()
		end
	end)

	self.ismoveOut = true

	local name = textUtils.replaceStr(get_player_info().name, NAME_BITE_LIMIT, "..")
	self.panel_ui.labName1:setString(name)
end

function CTexaspokerStatistics:showHidePanel()
	if self.ismoveOut then
		self:moveOut()
	else
		self:moveIn()
	end
	self.ismoveOut = not self.ismoveOut
end

function CTexaspokerStatistics:moveIn()
	local size = self.panel_ui.bg:getContentSize()

	local move_action = cc.MoveBy:create(0.3, cc.p(0, size.height))
	self:runAction(move_action)
end

function CTexaspokerStatistics:moveOut()
	local size = self.panel_ui.bg:getContentSize()

	local move_action = cc.MoveBy:create(0.3, cc.p(0, -size.height))
	self:runAction(move_action)
end

function CTexaspokerStatistics:setInfo( datalist )
	self.panel_ui.labCount1:setString(datalist.count)

	self.panel_ui.labTotalCount1:setString(datalist.totalCount)

    print("结算记录------",datalist.count.."    "..datalist.totalCount)
end