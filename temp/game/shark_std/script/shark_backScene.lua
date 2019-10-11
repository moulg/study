local water_pos_config = {
	{x = 192,y = 192,},
	{x = 576,y = 192,},
	{x = 960,y = 192,},
	{x = 1334,y = 192,},
	{x = 1728,y = 192,},
	{x = 192,y = 576,},
	{x = 576,y = 576,},
	{x = 960,y = 576,},
	{x = 1334,y = 576,},
    {x = 1728,y = 576,},
	{x = 192,y = 960,},
	{x = 576,y = 960,},
	{x = 960,y = 960,},
	{x = 1334,y = 960,},
	{x = 1728,y = 960,},
}
CSharkBackScene = class("CSharkBackScene", function ()
	local ret = cc.Sprite:create()
	return ret
end)

function CSharkBackScene.create()
	local node = CSharkBackScene.new()
	if node then
		node:init_ui()
		return node
	end
end

function CSharkBackScene:init_ui()
	self:setTexture(shark_imgRes_config["下注背景"].resPath)
	self:setAnchorPoint(0.5, 0.5)

	--遮罩-0------------------------------------
	self.clippingNode = cc.ClippingNode:create()
	self:addChild(self.clippingNode)
	self.clippingNode:setPosition(0, 0)
	self.clippingNode:setInverted(false)
	self.clippingNode:setAlphaThreshold(1)

	self.stencilNode = cc.Node:create()
	local demo = cc.Sprite:create(shark_imgRes_config["下注背景"].resPath)
	demo:setAnchorPoint(0,0)
	demo:setPosition(0,0)

	self.stencilNode:addChild(demo)
	self.stencilNode:setAnchorPoint(0,0)
	self.stencilNode:setPosition(0, 0)
	self.clippingNode:setStencil(self.stencilNode)
	------------------------------------------------

	self._fishList = {}
end

function CSharkBackScene:setBackImage(rewardID)
	self:removeFishs()

	if self._waterEff then
		for k,v in pairs(self._waterEff) do
			v:removeFromParent()
			v = nil
			self._waterEff = {}
		end
	end

	if rewardID then
		if rewardID == 9 or rewardID == 10 then
			self:setTexture(shark_imgRes_config["鲨鱼背景"].resPath)
		else
			if rewardID >= 1 and rewardID <= 4 then--走兽
				self:setTexture(shark_imgRes_config["走兽背景"].resPath)
			else--飞禽
				self:setTexture(shark_imgRes_config["飞禽背景"].resPath)
			end
		end
	else
		self:setTexture(shark_imgRes_config["下注背景"].resPath)

		self:createFishs()
		
		-- self._waterEff = animationUtils.createAndPlayAnimation(self, shark_effect_config["water"])
		-- self._waterEff:setPosition(315, 225)
		-- self._waterEff:setAnchorPoint(0.5, 0.5)
		self._waterEff = {}
		for k,v in pairs(water_pos_config) do
			local sprEffect = animationUtils.createAndPlayAnimation(self, shark_effect_config["water"])
			sprEffect:setPosition(v.x,v.y)
			sprEffect:setAnchorPoint(0.5, 0.5)
			table.insert(self._waterEff,sprEffect)
		end
	end
end

function CSharkBackScene:createFishs()
	for i=1,3 do
		if i == 1 then
			self:createFish()
		else
			local delay = math.random(2, 5)
			performWithDelay(self, function ()
				self:createFish()
			end, delay)
		end
	end
end

function CSharkBackScene:createFish()
	local id = math.random(1, 6)
	local key
	local fish
	key = "fish"..id
	fish = animationUtils.createAndPlayAnimation(self.clippingNode, shark_effect_config[key])
	table.insert(self._fishList, fish)

	local size = self:getContentSize()
	-- 上下左右
	local bornPoint = math.random(1, 4)
	local begin_pos
	local end_pos

	if bornPoint == 1 then--上
		begin_pos = {x = math.random(-10, size.width), y = size.height}
		end_pos = {x = math.random(-10, size.width), y = -30}
	elseif bornPoint == 2 then--下
		begin_pos = {x = math.random(-10, size.width), y = -10}
		end_pos = {x = math.random(-10, size.width), y = size.height + 30}
	elseif bornPoint == 3 then--左
		begin_pos = {x = -10, y = math.random(-10, size.height)}
		end_pos = {x = size.width + 30, y = math.random(-10, size.height)}
	else--右
		begin_pos = {x = size.width, y = math.random(-10, size.height)}
		end_pos = {x = -30, y = math.random(-10, size.height)}
	end

	fish:setPosition(begin_pos.x, begin_pos.y)


	local addDelay = math.random(3, 8)
	local moveAction = cc.MoveTo:create(25 + addDelay,end_pos)
	fish:runAction(moveAction)

	local vector = {x = end_pos.x - begin_pos.x, y = end_pos.y - begin_pos.y}
	local angle = math.deg(self:atan2( vector.y, -vector.x ))
	fish:setRotation(angle - 90)
end

function CSharkBackScene:removeFishs()
	for i,v in ipairs(self._fishList) do
		v:removeFromParent()
	end
	self._fishList = {}
end

function CSharkBackScene:atan2(y, x)
	if x > 0 then
		return math.atan(y/x)
	elseif x < 0 and y >= 0 then
		return math.atan(y/x) + math.pi
	elseif x < 0 and y < 0 then
		return math.atan(y/x) - math.pi
	elseif x == 0 and y > 0 then
		return math.pi/2
	elseif x == 0 and y < 0 then
		return -math.pi/2
	end
end
