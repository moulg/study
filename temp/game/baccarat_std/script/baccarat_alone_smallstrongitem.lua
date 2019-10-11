--[[
百家乐小强路单
]]

local panel_ui = require "game.baccarat_std.script.ui_create.ui_baccarat_aloneXQ"
local baccartRes = {"game/baccarat_std/resource/image/alone/xiehongtiao.png",
		"game/baccarat_std/resource/image/alone/xielantiao.png",
	}
local dragonRes = {"game/baccarat_std/resource/image/alone/xiehongtiao.png",
		"game/baccarat_std/resource/image/alone/juhongtiao.png",
	}

CBaccaratAloneSmallStrongItem = class("CBaccaratAloneSmallStrongItem", function ()
	local ret = cc.Node:create()
	return ret
end)

--[[
	type:1百家乐，2龙虎
]]
function CBaccaratAloneSmallStrongItem.create()
	local node = CBaccaratAloneSmallStrongItem.new()
	if node ~= nil then
		node:init_ui(type,id)
		return node
	end
end

function CBaccaratAloneSmallStrongItem:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self:setScale(0.9)
end

function CBaccaratAloneSmallStrongItem:setInfo(type,id)
	if type == 1 then
		self.panel_ui.imgIcon:loadTexture(baccartRes[id])
	else
		self.panel_ui.imgIcon:loadTexture(dragonRes[id])
	end
end