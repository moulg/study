
local panel_ui = require "game.ddz_match_std.script.ui_create.ui_ddzMatch_certificate"

local _contentSize = cc.size(832, 590)

CDdzMatchCertificate = class("CDdzMatchCertificate", function ()
	-- body
	local  ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:setContentSize(_contentSize)
    ret:setAnchorPoint(0, 0)
	return ret
end)

function CDdzMatchCertificate.getContentSize()
	return _contentSize
end

function CDdzMatchCertificate.create()
	-- body
	local layer = CDdzMatchCertificate.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end

function CDdzMatchCertificate:regEnterExit()
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

function CDdzMatchCertificate:onEnter()
	
end

function CDdzMatchCertificate:onExit()

end

function CDdzMatchCertificate:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)

end

function CDdzMatchCertificate:setInfo( rank, rewards )
	self.panel_ui.fntRanking:setString(rank)

	local beginY = -142
	for i,data in pairs(rewards) do
		local lab = self.panel_ui.labReward:clone()
		self:addChild(lab)

		local name = item_config.item_table[data.id].name
		lab:setString(data.num..name)
		lab:setPosition(0, beginY)
		beginY = beginY - 42
	end

	self.panel_ui.labReward:removeFromParent()
end

