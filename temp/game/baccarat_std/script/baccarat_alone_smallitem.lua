--[[
百家乐小路单
]]

local panel_ui = require "game.baccarat_std.script.ui_create.ui_baccarat_aloneSmall"
local baccartRes = {"game/baccarat_std/resource/image/alone/hqs.png",
		"game/baccarat_std/resource/image/alone/lqs.png",
	}
local dragonRes = {"game/baccarat_std/resource/image/alone/hqs.png",
		"game/baccarat_std/resource/image/alone/jqs.png",
	}

CBaccaratAloneSmallItem = class("CBaccaratAloneSmallItem", function ()
	local ret = cc.Node:create()
	return ret
end)

--[[
	type:1百家乐，2龙虎
]]
function CBaccaratAloneSmallItem.create()
	local node = CBaccaratAloneSmallItem.new()
	if node ~= nil then
		node:init_ui(type,id)
		return node
	end
end

function CBaccaratAloneSmallItem:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
end

function CBaccaratAloneSmallItem:setInfo(type,id)
	if type == 1 then
		self.panel_ui.imgIcon:loadTexture(baccartRes[id])
	else
		self.panel_ui.imgIcon:loadTexture(dragonRes[id])
	end
end