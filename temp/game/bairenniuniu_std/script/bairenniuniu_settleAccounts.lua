--[[
	结算面板
]]

local panel_ui = require "game.bairenniuniu_std.script.ui_create.ui_bairenniuniu_settlement"

CBaiRenNiuNiuSettleAccounts = class("CBaiRenNiuNiuSettleAccounts",function()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    -- ret:loadTexture("lobby/resource/general/heidi.png")
    return ret
end)

function CBaiRenNiuNiuSettleAccounts.create()
	-- body
	local layer = CBaiRenNiuNiuSettleAccounts.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end
function CBaiRenNiuNiuSettleAccounts:regEnterExit()
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

function CBaiRenNiuNiuSettleAccounts:onEnter()
	--防止穿透
	self:setTouchEnabled(true)
end
function CBaiRenNiuNiuSettleAccounts:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.root:setPosition(0,0)

	self.starsEffectlist={[1]=self.panel_ui.Broken_starsEffect1,[2]=self.panel_ui.Broken_starsEffect2,
					[3]=self.panel_ui.Broken_starsEffect3,[4]=self.panel_ui.Broken_starsEffect4,}

	self:niuEffect()
	self:brokenStars()
	self:yziEffect()
	-- self:cryEffect()
	
end

function CBaiRenNiuNiuSettleAccounts:brokenStars()

	local function call_back(node)
		-- body
		local effectData = bairenniuniu_effect_config["星星"]
		animationUtils.createAndPlayAnimation(node,effectData)
	end

	local nodeeffmap = {1,2,3,4}

	-- for k,v in pairs(self.starsEffectlist) do
	for k = 1 , 4 do	
		performWithDelay(self, function ()
			local randomNum = nodeeffmap[math.random(1,table.nums(nodeeffmap))]
			local nodeEff =  self.starsEffectlist[randomNum]
			table.removebyvalue(nodeeffmap,randomNum)
			-- dump(randomNum)
			local effectData = bairenniuniu_effect_config["星星"]
			animationUtils.createAndPlayAnimation(nodeEff,effectData)

		end,0.9*(k-1))
	end
end

function CBaiRenNiuNiuSettleAccounts:yziEffect()
	local effectData = bairenniuniu_effect_config["yzi"]
	self.cryingEffect = animationUtils.createAndPlayAnimationNoAutoRemove(self.panel_ui.JieSuanEffect,effectData)
	self.cryingEffect:setPosition(0,-30)
end

function CBaiRenNiuNiuSettleAccounts:cryEffect()
	local effectData = bairenniuniu_effect_config["crying"]
	self.cryingEffect = animationUtils.createAndPlayAnimationNoAutoRemove(self.panel_ui.JieSuanEffect,effectData)
	self.cryingEffect:setFlippedX(true)
	self.cryingEffect:setPosition(120,-25)
end

function CBaiRenNiuNiuSettleAccounts:niuEffect()
	local effectData = bairenniuniu_effect_config["niu"]
	self.niuEffect = animationUtils.createAndPlayAnimationNoAutoRemove(self.panel_ui.JieSuanEffect,effectData)
	self.niuEffect:setFlippedX(true)
	self.niuEffect:setPosition(-20,140)
end

function CBaiRenNiuNiuSettleAccounts:balance()
	print("***********结算*****************")
	-- dump(bairenniuniu_manager._bankerInfo)
	--庄家筹码变化
	-- dump(self.panel_ui.fntBanker)
	if self.panel_ui.fntBanker ~= nil then 
		local bankerStr = (long_compare(bairenniuniu_manager._bankerChipschanges, 0) >= 0) and "+" or ""
		self.panel_ui.fntBanker:setString(bankerStr ..bairenniuniu_manager._bankerChipschanges)
		-- self.panel_ui.imgBankerBg:setTexture((long_compare(bairenniuniu_manager._bankerChipschanges, 0) > 0) and self.victoryResPath or self.failureResPath)
	end
	--玩家筹码变化
	if self.panel_ui.fntPlayer ~= nil then
		local playerStr = (long_compare(bairenniuniu_manager._playerChipschanges, 0) >= 0) and "+" or ""
		self.panel_ui.fntPlayer:setString(playerStr ..bairenniuniu_manager._playerChipschanges)
		local member = HallManager._members[get_player_info().id]
		if long_compare(bairenniuniu_manager._playerChipschanges, 0) > 0 then
			audio_manager:playPlayerSound(math.random(23,24), member.sex)
			-- self:brokenStars()
		else
			audio_manager:playPlayerSound(math.random(8,9), member.sex)
			-- self:yziEffect()
			-- self:cryEffect()
		end
	end
end