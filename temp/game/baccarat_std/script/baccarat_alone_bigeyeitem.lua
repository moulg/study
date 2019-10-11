--[[
百家乐大眼路单
]]

local panel_ui = require "game.baccarat_std.script.ui_create.ui_baccarat_aloneBigEye"

local baccartRes = {"game/baccarat_std/resource/image/alone/hqd.png",
		"game/baccarat_std/resource/image/alone/lqd.png",
	}
local dragonRes = {"game/baccarat_std/resource/image/alone/hqd.png",
		"game/baccarat_std/resource/image/alone/jqd.png",
	}

CBaccaratAloneBigEyeItem = class("CBaccaratAloneBigEyeItem", function ()
	local ret = cc.Node:create()
	return ret
end)

--[[
	type:1百家乐，2龙虎
]]
function CBaccaratAloneBigEyeItem.create()
	local node = CBaccaratAloneBigEyeItem.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end

function CBaccaratAloneBigEyeItem:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	-- self.panel_ui.root:setAnchorPoint(0.5,0)
end

function CBaccaratAloneBigEyeItem:setInfo(type,id)
	if type == 1 then
		self.panel_ui.imgIcon:loadTexture(baccartRes[id])
	else
		self.panel_ui.imgIcon:loadTexture(dragonRes[id])
	end
end