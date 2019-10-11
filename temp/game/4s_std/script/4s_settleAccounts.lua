--[[
	结算面板
]]

local panel_ui = require "game.4s_std.script.ui_create.ui_4s_accounts"
local carRes = {
	"game/4s_std/resource/image/logo/logo_press/fll.png",
	"game/4s_std/resource/image/logo/logo_press/bc.png",
	"game/4s_std/resource/image/logo/logo_press/bm.png",
	"game/4s_std/resource/image/logo/logo_press/ad.png",
	"game/4s_std/resource/image/logo/logo_press/ft.png",
	"game/4s_std/resource/image/logo/logo_press/dz.png",
	"game/4s_std/resource/image/logo/logo_press/bk.png",
	"game/4s_std/resource/image/logo/logo_press/mzd.png",
}

CFSSettleAccounts = class("CFSSettleAccounts",function()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
    return ret
end)

function CFSSettleAccounts.create()
	-- body
	local layer = CFSSettleAccounts.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end
function CFSSettleAccounts:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter();
		elseif event == "exit" then
			self:onExit();
		end
	end

	self:registerScriptHandler(_onEnterOrExit);
end

function CFSSettleAccounts:onEnter()
	--防止穿透
	self:setTouchEnabled(true)
end
function CFSSettleAccounts:onExit()
end
function CFSSettleAccounts:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.root:setPosition(0,0)
end
function CFSSettleAccounts:balance()
	local victoryResPath = "game/4s_std/resource/word/ying.png"
	local failureResPath = "game/4s_std/resource/word/shu.png"
	self.panel_ui.sprResule:setTexture((long_compare(fs_manager._playerChipschanges, 0) > 0) and victoryResPath or failureResPath)
	--庄家筹码变化
	if self.panel_ui.fntBankerChips ~= nil then 
		local bankerStr = (long_compare(fs_manager._bankerChipschanges, 0) >= 0) and "+" or ""
		self.panel_ui.fntBankerChips:setString(bankerStr ..fs_manager._bankerChipschanges)
	end
	--玩家筹码变化
	if self.panel_ui.fntPlayerChips ~= nil then
		local playerStr = (long_compare(fs_manager._playerChipschanges, 0) >= 0) and "+" or ""
		self.panel_ui.fntPlayerChips:setString(playerStr ..fs_manager._playerChipschanges)
	end

	self.panel_ui.sprIcon:setTexture(carRes[fs_manager._finalCarId])
	self.panel_ui.fntBeiShu:setString("x" ..fs_manager._rate)

	local action = cc.Sequence:create(cc.ScaleTo:create(0.1,0.9),cc.ScaleTo:create(0.2,1.2),cc.ScaleTo:create(0.1,1.0))
	self.panel_ui.bg:runAction(action)

end