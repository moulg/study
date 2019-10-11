--[[
魏蜀吴朱盘路
]]

local weishuwuRes = {"game/weishuwu_std/resource/image/shu.png",
						"game/weishuwu_std/resource/image/wei.png",
						"game/weishuwu_std/resource/image/wu.png"}

local panel_ui = require "game.weishuwu_std.script.ui_create.ui_weishuwu_zhupanlu"

CWeishuwuZhupanItem = class("CWeishuwuZhupanItem", function ()
	local ret = cc.Node:create()
	return ret
end)


function CWeishuwuZhupanItem.create()
	local node = CWeishuwuZhupanItem.new()
	if node ~= nil then
		-- node:initData()
		node:init_ui()
		return node
	end
end
function CWeishuwuZhupanItem:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.Img_dui1:setVisible(false)
	self.panel_ui.Img_dui2:setVisible(false)	

end
function CWeishuwuZhupanItem:setInfo(waybillList ,k,id)
	self.panel_ui.Img_zhupan:loadTexture(weishuwuRes[id])
	local shuduiList = {2,3,6,7,10,11}
	local wuduiList = {1,3,5,7,9,11}
	for _,v in pairs(shuduiList) do
		if long_compare(v,waybillList[k]) == 0 then
			self.panel_ui.Img_dui1:setVisible(true)
		end
	end
	for _,v in pairs(wuduiList) do
		if long_compare(v,waybillList[k]) == 0 then
			self.panel_ui.Img_dui2:setVisible(true)
		end
	end
end
