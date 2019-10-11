

--[[
	连线技能项
]]

local line_zorder = 1000


SkillItemLine = class("SkillItemLine",function ()
	local  obj = cc.Sprite:create()
	return obj
end)

--info = {pos1,pos2,parent,src_id,}
function SkillItemLine.create(info)
	local obj = SkillItemLine.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function SkillItemLine:init(info)
	self.init_info = info
	self:runLine()
end


function SkillItemLine:runLine()
	local src_cfg = sprite_ani_config[self.init_info.src_id]

	if src_cfg then
		self.init_info.parent:addChild(self)
		self:setAnchorPoint({x = 0,y = 0.5,})

		self:setLocalZOrder(line_zorder)
		local fname = string.format(sprite_ani_config[self.init_info.src_id].pattern,1)
		self:setSpriteFrame(fname)

		self:setPosAndRotate()

		local exit_ani = cc.AnimationCache:getInstance():getAnimation(src_cfg.key)
		if exit_ani == nil then
			local animation = jc_create_animation(src_cfg)
			cc.AnimationCache:getInstance():addAnimation(animation,src_cfg.key)
		end

		local ani = cc.AnimationCache:getInstance():getAnimation(src_cfg.key)
		if ani then
			ani:retain()
			local amt  = cc.Animate:create(ani)
			ani:release()
			self:runAction(cc.RepeatForever:create(amt))
		end
	end
end

function SkillItemLine:setPosAndRotate()
	self:setPosition(self.init_info.pos1.x,self.init_info.pos1.y)

	local size = self:getContentSize()
	local pos_dis = math.sqrt(math.pow(self.init_info.pos1.x - self.init_info.pos2.x,2) + math.pow(self.init_info.pos1.y - self.init_info.pos2.y,2))
	local sx = pos_dis/size.width
	self:setScaleX(sx)

	local angle = self:getAngleByPos(self.init_info.pos1,self.init_info.pos2)
	self:setRotation(360 - angle)
end

function SkillItemLine:getAngleByPos(pos1,pos2)
	local angle = 0
	local side = self:getSideByPos(pos1,pos2)

	if pos1.x == pos2.x then
		if side == 1 then
			angle = 90
		elseif side == 4 then
			angle = 270
		elseif side == 2 then
			angle = 90
		elseif side == 3 then
			angle = 270
		end
	else
		local k = (pos1.y - pos2.y)/(pos1.x - pos2.x)
		angle = math.atan(k)*180/math.pi

		if side == 1 and angle <= 0 then
			angle = -angle
		elseif side == 2 and angle < 0 then
			angle = 180 + angle
		elseif side == 3 and angle > 0 then
			angle = 180 + angle
		elseif side == 3 and angle <= 0 then
			angle = 180 - angle
		elseif side == 4 and angle <= 0 then
			angle = 2*180 + angle
		end
	end

	return angle
end

function SkillItemLine:getSideByPos(pos1,pos2)
	local side = 0

	local sp = {x = pos2.x - pos1.x,y = pos2.y - pos1.y,}

	if sp.x >= 0 and sp.y >= 0 then
		side = 1
	elseif sp.x >= 0 and sp.y <= 0 then
		side = 4
	elseif sp.x <= 0 and sp.y >= 0 then
		side = 2
	elseif sp.x <= 0 and sp.y <= 0 then
		side = 3
	end

	return side
end

