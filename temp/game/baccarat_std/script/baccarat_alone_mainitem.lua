--[[
百家乐主路单
]]

local panel_ui = require "game.baccarat_std.script.ui_create.ui_baccarat_aloneZhupan"
local aloneRes = {"game/baccarat_std/resource/image/alone/zhuang.png",
	"game/baccarat_std/resource/image/alone/he.png",
	"game/baccarat_std/resource/image/alone/xian.png",
	"game/baccarat_std/resource/image/alone/da.png",
	"game/baccarat_std/resource/image/alone/xiao.png",
	"game/baccarat_std/resource/image/alone/long.png",
	"game/baccarat_std/resource/image/alone/hu.png",
	}

CBaccaratAloneMainItem = class("CBaccaratAloneMainItem", function ()
	local ret = cc.Node:create()
	return ret
end)

--[[
	type:1庄闲，2大小，3龙虎
]]
function CBaccaratAloneMainItem.create()
	local node = CBaccaratAloneMainItem.new()
	if node ~= nil then
		node:init_ui(type,id)
		return node
	end
end

function CBaccaratAloneMainItem:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0.5,0)
	self.panel_ui.Sprite_zhuangTwo:setVisible(false)
	self.panel_ui.Sprite_xianTwo:setVisible(false)
end

function CBaccaratAloneMainItem:setInfo(type,id)
	self.panel_ui.Sprite_zhuangTwo:setVisible(false)
	self.panel_ui.Sprite_xianTwo:setVisible(false)

	if type == 1 then
		local zhuang_flag = math.floor(id/4)
		local two_flag = math.fmod(id, 4)
		self.panel_ui.Sprite_zhuangxian:setTexture(aloneRes[zhuang_flag+1])
		if two_flag == 1 then
			self.panel_ui.Sprite_xianTwo:setVisible(true)
		elseif two_flag == 2 then
			self.panel_ui.Sprite_zhuangTwo:setVisible(true)
		elseif two_flag == 3 then
			self.panel_ui.Sprite_xianTwo:setVisible(true)
			self.panel_ui.Sprite_zhuangTwo:setVisible(true)
		else
			--
		end
		
	elseif type == 2 then
		if id == 3 then
			self.panel_ui.Sprite_zhuangxian:setTexture(aloneRes[4])
		else
			self.panel_ui.Sprite_zhuangxian:setTexture(aloneRes[5])
		end

	elseif type == 3 then
		if id == 1 then
			self.panel_ui.Sprite_zhuangxian:setTexture(aloneRes[6])
		elseif id == 2 then 
			self.panel_ui.Sprite_zhuangxian:setTexture(aloneRes[2])
		else 
			self.panel_ui.Sprite_zhuangxian:setTexture(aloneRes[7])
		end
	end
end