--[[
	魏蜀吴历史记录
]]
weishuwuRes={"game/weishuwu_std/resource/image/gou.png","game/weishuwu_std/resource/image/gou2.png","game/weishuwu_std/resource/image/cha.png"}
local panel_ui = require "game.weishuwu_std.script.ui_create.ui_weishuwu_recordItem"

weishuwuRecordItem = class("weishuwuRecordItem", function ()
	local ret = cc.Node:create()
	return ret
end)

function weishuwuRecordItem.create()
	local node = weishuwuRecordItem.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end

function weishuwuRecordItem:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
end

function weishuwuRecordItem:setInfo(res)
	self.panel_ui.Img_gou:loadTexture(weishuwuRes[res])
end