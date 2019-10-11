--[[
百家乐大路单
]]

local panel_ui = require "game.baccarat_std.script.ui_create.ui_baccarat_aloneBig"
local baccartRes = {"game/baccarat_std/resource/image/alone/hongquanquan.png",
		"game/baccarat_std/resource/image/alone/dalanq.png",
	}
local dragonRes = {"game/baccarat_std/resource/image/alone/hongquanquan.png",
		"game/baccarat_std/resource/image/alone/juhongquan.png",
	}

CBaccaratAloneBigItem = class("CBaccaratAloneBigItem", function ()
	local ret = cc.Node:create()
	return ret
end)

--[[
	type:1百家乐，2龙虎
]]
function CBaccaratAloneBigItem.create()
	local node = CBaccaratAloneBigItem.new()
	if node ~= nil then
		node:init_ui(type,id)
		return node
	end
end

function CBaccaratAloneBigItem:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	-- self.panel_ui.root:setAnchorPoint(0.5,0)
	self.panel_ui.imgHeIcon:setVisible(false)
	self.panel_ui.fntHeNum:setVisible(false)

	self:setScale(0.9)
end

function CBaccaratAloneBigItem:setInfo(type,result,drawNum)
	self.panel_ui.imgHeIcon:setVisible(false)
	self.panel_ui.fntHeNum:setVisible(false)

	if type == 1 then
		self.panel_ui.imgBigIcon:loadTexture((result == 1) and baccartRes[1] or baccartRes[2])
		self.panel_ui.imgHeIcon:setVisible(drawNum >= 1)
		if drawNum > 1 then
			self.panel_ui.fntHeNum:setString(drawNum)
			self.panel_ui.fntHeNum:setVisible(true)
		end
		
	else
		self.panel_ui.imgBigIcon:loadTexture((result == 1) and dragonRes[1]or dragonRes[2])
		self.panel_ui.imgHeIcon:setVisible(drawNum >= 1)
		if drawNum > 1 then
			self.panel_ui.fntHeNum:setString(drawNum)
			self.panel_ui.fntHeNum:setVisible(true)
		end
	end
end