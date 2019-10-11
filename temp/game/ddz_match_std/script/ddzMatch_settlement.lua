

CDdzMatchSettlement = class("CDdzMatchSettlement", function ()
	-- body
	local  ret = cc.Node:create()
	return ret
end)

function CDdzMatchSettlement.create()
	-- body
	local layer = CDdzMatchSettlement.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end

function CDdzMatchSettlement:regEnterExit()
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

function CDdzMatchSettlement:onEnter()
	
end

function CDdzMatchSettlement:onExit()
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.btnEnter)
	if self.effectSpr then
		self.effectSpr:removeFromParent()
		self.effectSpr = nil
	end
end

function CDdzMatchSettlement:init_ui()
	local node = cc.CSLoader:createNode("game/ddz_match_std/script/ui_create/ui_ddzMatch_settlement.csb")
	self:addChild(node)
    local action = cc.CSLoader:createTimeline("game/ddz_match_std/script/ui_create/ui_ddzMatch_settlement.csb")
    node:runAction(action)
    action:gotoFrameAndPlay(0, false)

	self.root = node:getChildByTag(2)
	self.effectNode = node:getChildByTag(45)
	self.btnEnter = self.root:getChildByName("btnEnter")
end

function CDdzMatchSettlement:setInfo( info )
	local fntBoom = self.root:getChildByName("fntBoom")
	fntBoom:setString(info.boomMultiply)
	local fntRocket = self.root:getChildByName("fntRocket")
	fntRocket:setString(info.rocketMultiply)
	local fntSpring = self.root:getChildByName("fntSpring")
	fntSpring:setString(info.springMultiply)

	for i,v in ipairs(info.playerScores) do

		local sprMark = self.root:getChildByName("sprMark"..i)
		local fntScore = sprMark:getChildByName("fntScore"..i)
		if long_compare(v.cedits, 0) > 0 then
			fntScore:setFntFile("game/ddz_match_std/resource/number/jiesuanWin.fnt")
			fntScore:setString("+"..v.cedits)
		else
			fntScore:setFntFile("game/ddz_match_std/resource/number/jiesuanLose.fnt")
			fntScore:setString(v.cedits)
		end
		local labName = sprMark:getChildByName("labName"..i)

		local name = textUtils.replaceStr(v.playerName, NAME_BITE_LIMIT, "..")
		labName:setString(name)
	end
	
	-- local function timeHandler()
	-- 	local effectNode = self.root:getChildByName("effectNode")
	-- 	local animation, effectSpr = animationUtils.createAnimation(ddz_match_effect_config[info.effectKey])
	-- 	self.effectSpr = effectSpr
	-- 	effectNode:addChild(self.effectSpr)
	-- 	self.effectSpr:runAction(cc.Animate:create(animation))
	-- end
	-- performWithDelay(self, timeHandler, 22/60)
	
	if info.effectKey == "win" then
		local effect = self.effectNode:getChildByName("effectLose")
		effect:setVisible(false)
	else
		local effect = self.effectNode:getChildByName("effectWin")
		effect:setVisible(false)
	end
end