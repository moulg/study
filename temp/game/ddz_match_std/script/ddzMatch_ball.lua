
CDdzMatchBall = class("CDdzMatchBall", function ()
	local  ret = cc.Node:create()
	return ret
end)

function CDdzMatchBall:getContentSize()
	return self._contentSize
end

function CDdzMatchBall.create()
	-- body
	local layer = CDdzMatchBall.new()
	if layer ~= nil then
		layer:regEnterExit()
		return layer
	end
end

function CDdzMatchBall:regEnterExit()
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

function CDdzMatchBall:onEnter()
	
end

function CDdzMatchBall:onExit()
	
end

function CDdzMatchBall:setInfo( playerNum )
	self.playerNum = playerNum

end

function CDdzMatchBall:createBeginMatchBall()
	local sprBallBack = cc.Sprite:create("game/ddz_match_std/resource/image/promotion2Bj.png")
	self:addChild(sprBallBack)
	self._contentSize = sprBallBack:getContentSize()

	local sprBall = cc.Sprite:create("game/ddz_match_std/resource/image/promotion1Bj.png")
	self:addChild(sprBall)

	local fntPlayerNum2 = ccui.TextBMFont:create()
	fntPlayerNum2:setFntFile("game/ddz_match_std/resource/number/promotion2.fnt")
	fntPlayerNum2:setString(self.playerNum.."r")
	self:addChild(fntPlayerNum2)
	fntPlayerNum2:setPosition(-30, 18)

	local imgWord2 = cc.Sprite:create("game/ddz_match_std/resource/word/begin.png")
	self:addChild(imgWord2)
	imgWord2:setPosition(-30, -18)
end

--创建晋级完的球
function CDdzMatchBall:createAdvancedBall()
	local sprBallBack = cc.Sprite:create("game/ddz_match_std/resource/image/promotion2Bj.png")
	self:addChild(sprBallBack)
	self._contentSize = sprBallBack:getContentSize()

	local sprBall = cc.Sprite:create("game/ddz_match_std/resource/image/promotion1Bj.png")
	self:addChild(sprBall)

	local fntPlayerNum2 = ccui.TextBMFont:create()
	fntPlayerNum2:setFntFile("game/ddz_match_std/resource/number/promotion2.fnt")
	fntPlayerNum2:setString(self.playerNum.."r")
	self:addChild(fntPlayerNum2)
	fntPlayerNum2:setPosition(-30, 18)

	local imgWord2 = cc.Sprite:create("game/ddz_match_std/resource/word/promotion1.png")
	self:addChild(imgWord2)
	imgWord2:setPosition(-30, -18)
end

--创建准备晋级的球
function CDdzMatchBall:createAdvanceBall()
	local sprBallBack = cc.Sprite:create("game/ddz_match_std/resource/image/promotion2Bj.png")
	self:addChild(sprBallBack)
	self._contentSize = sprBallBack:getContentSize()

	local fntPlayerNum1 = ccui.TextBMFont:create()
	fntPlayerNum1:setFntFile("game/ddz_match_std/resource/number/promotion1.fnt")
	fntPlayerNum1:setString(self.playerNum.."r")
	self:addChild(fntPlayerNum1)
	fntPlayerNum1:setPosition(-30, 18)

	local imgWord1 = cc.Sprite:create("game/ddz_match_std/resource/word/promotion1.png")
	self:addChild(imgWord1)
	imgWord1:setPosition(-30, -18)

	--遮罩
	local stencilNode = cc.Node:create()
	self.maskDemo = cc.Sprite:create("game/ddz_match_std/resource/image/promotion1Bj.png")
	local size = self.maskDemo:getContentSize()
	self.maskDemo:setAnchorPoint(0,0)
	self.maskDemo:setPosition(-size.width/2,-size.height/2)
	self.maskDemo:setScale(0, 1)

	stencilNode:addChild(self.maskDemo)
	stencilNode:setPosition(0, 0)
	self.layer = cc.ClippingNode:create(stencilNode)
	self:addChild(self.layer)
	self.layer:setPosition(0, 0)

	self.layer:setInverted(false)
	self.layer:setAlphaThreshold(1)

	local sprBall = cc.Sprite:create("game/ddz_match_std/resource/image/promotion1Bj.png")
	self.layer:addChild(sprBall)

	local fntPlayerNum2 = ccui.TextBMFont:create()
	fntPlayerNum2:setFntFile("game/ddz_match_std/resource/number/promotion2.fnt")
	fntPlayerNum2:setString(self.playerNum.."r")
	self.layer:addChild(fntPlayerNum2)
	fntPlayerNum2:setPosition(-30, 18)

	local imgWord2 = cc.Sprite:create("game/ddz_match_std/resource/word/promotion2.png")
	self.layer:addChild(imgWord2)
	imgWord2:setPosition(-30, -18)
end

function CDdzMatchBall:createChampion()
	local sprBallBack = cc.Sprite:create("game/ddz_match_std/resource/image/winner.png")
	self:addChild(sprBallBack)
	self._contentSize = sprBallBack:getContentSize()
end

function CDdzMatchBall:playAdvanceAction()
	if self.maskDemo then
		local actionScaleTo = cc.ScaleTo:create(3, 1, 1)
		local function dipose(node)
			send_doudizhu_ReqReady()
		end

		local call_action = cc.CallFunc:create(dipose)
		local seq = cc.Sequence:create({actionScaleTo, call_action})
		self.maskDemo:runAction(seq)
	end
end