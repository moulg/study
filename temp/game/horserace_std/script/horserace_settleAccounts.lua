--[[
	结算面板
]]

local panel_ui = require "game.horserace_std.script.ui_create.ui_horserace_settlement"

local resourcePath = {"game/horserace_std/resource/image/Horse_End_Word_0.png",
					"game/horserace_std/resource/image/Horse_End_Word_1.png",
					"game/horserace_std/resource/image/Horse_End_Word_2.png",
				}

CHorseRaceSettleAccounts = class("CHorseRaceSettleAccounts",function()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
    return ret
end)

function CHorseRaceSettleAccounts.create()
	-- body
	local layer = CHorseRaceSettleAccounts.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end
function CHorseRaceSettleAccounts:regEnterExit()
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

function CHorseRaceSettleAccounts:onEnter()
	--防止穿透
	self:setTouchEnabled(true)
end
function CHorseRaceSettleAccounts:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.root:setPosition(0,0)
end
function CHorseRaceSettleAccounts:balance()
	print("*****************结算****************")
	local game_ui = WindowScene.getInstance():getModuleObjByClassName("CHorseRaceMainScene")
	if game_ui then
		local totalBet = game_ui:getTotalBetChips()
		if long_compare(totalBet,0) > 0 then
			if long_compare(horserace_manager._playerChangeChips,0) > 0 then
				self.panel_ui.ImgZhuangtai:loadTexture(resourcePath[2])
			else
				self.panel_ui.ImgZhuangtai:loadTexture(resourcePath[1])
			end
		else
			self.panel_ui.ImgZhuangtai:loadTexture(resourcePath[3])
		end
		-- self:addEffect()
		self.panel_ui.FntZuhe:setString(horserace_manager._areaData[horserace_manager._areaId])
		self.panel_ui.FntPeilv:setString(horserace_manager._listMultiple[horserace_manager._areaId].rate)
		self.panel_ui.FntChengji:setString(horserace_manager._playerChangeChips)
	end
end

function CHorseRaceSettleAccounts:addEffect()
	-- dump(horserace_effect_config)
	local effectData = horserace_effect_config["Horse_End_Effect"]
	-- dump(effectData)
	self.flyEffect = animationUtils.createAndPlayAnimation(self.panel_ui.nodeEffect,effectData,nil)
end