--[[
魏蜀吴大眼路单
]]


local panel_ui = require "game.weishuwu_std.script.ui_create.ui_weishuwu_dayanlu"

local weishuwuRes = {"game/weishuwu_std/resource/image/2.png",
						"game/weishuwu_std/resource/image/3.png",
						"game/weishuwu_std/resource/image/1.png",
						"game/weishuwu_std/resource/image/gang.png",
					}

CWeishuwuAloneBigEyeItem = class("CWeishuwuAloneBigEyeItem", function ()
	local ret = cc.Node:create()
	return ret
end)

--[[
	id:1蜀，2魏，3吴
]]
function CWeishuwuAloneBigEyeItem.create()
	local node = CWeishuwuAloneBigEyeItem.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end

function CWeishuwuAloneBigEyeItem:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
end

function CWeishuwuAloneBigEyeItem:setInfo(id)
	self.panel_ui.Img_Lu:loadTexture(weishuwuRes[id])
end
