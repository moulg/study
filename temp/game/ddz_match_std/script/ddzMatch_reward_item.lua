
local panel_ui = require "game.ddz_match_std.script.ui_create.ui_ddzMatch_reward"

local _contentSize = cc.size(90, 90)

CDdzMatchRewardItem = class("CDdzMatchRewardItem", function ()
	local ret = cc.Node:create()
	return ret
end)

function CDdzMatchRewardItem.getContentSize()
	return _contentSize
end

function CDdzMatchRewardItem.create()
	-- body
	local layer = CDdzMatchRewardItem.new()
	if layer ~= nil then
		layer:init_ui()
		return layer
	end
end

function CDdzMatchRewardItem:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)

	self._labelList = {}
end

function CDdzMatchRewardItem:setRewardInfo( beginRank, endRank, rewards )
	if endRank - beginRank <= 1 then
		self.panel_ui.sprRank:setTexture("game/ddz_match_std/resource/word/di"..endRank..".png")
		self.panel_ui.sprRank:setVisible(true)
		self.panel_ui.fntRank:setVisible(false)
	else
		self.panel_ui.sprRank:setVisible(false)
		self.panel_ui.fntRank:setVisible(true)
		beginRank = beginRank + 1
		self.panel_ui.fntRank:setString(beginRank.."~"..endRank)
	end

	local beginY = 4
	for id,num in pairs(rewards) do
		local lab = self.panel_ui.labReward:clone()
		table.insert(self._labelList, lab)
		lab:enableOutline(cc.c4b(0, 0, 0, 255), 1)
		self:addChild(lab)

		local name = item_config.item_table[tonumber(id)].name
		lab:setString(num..name)
		lab:setPosition(0, beginY)
		beginY = beginY - 24
	end

	self.panel_ui.labReward:removeFromParent()
end
