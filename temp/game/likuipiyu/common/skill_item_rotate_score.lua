
--[[
	分数旋转特技
]]


RotateScore = class("RotateScore",function ()
	local obj = cc.Node:create()

	return obj
end)

--[[
	info = {
		obj,id,end_call,param
	}
]]
function RotateScore.create(info)
	local obj = RotateScore.new()
	if obj then
		obj:rtt(info)
	end

	return obj
end


function RotateScore:rtt(info)
	self.rtt_info = info
	self:createItem()
end

function RotateScore:createItem()

	self.rtt_info.obj:addChild(self)
	self:setLocalZOrder(-10)

	local side    = self.rtt_info.obj:getSide()
	local new_pos = self:rotateRoot(side,self.rtt_info.param.pos)
	self:setPosition(new_pos.x,new_pos.y)
	self:setVisible(true)




	if skill_config[self.rtt_info.id] then
		local cfg 		= skill_config[self.rtt_info.id]
		local src_cfg 	= sprite_ani_config[cfg.bk_src_id]

		if src_cfg.stype == 1 then --ainimation
			self.spr1 = jc_create_spr_by_plist(src_cfg)
			self:addChild(self.spr1)

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
				if cfg.floop == -1 then
					self.spr1.runAction(cc.RepeatForever:create(amt))
				else
					self.spr1.runAction(cc.Repeat:create(amt,cfg.floop))
				end
			end
		elseif src_cfg.stype == 2 then --img
			self.spr1 = cc.Sprite:create(src_cfg.file)
			self:addChild(self.spr1)

			ActionEffectPlayer.getInstance():play(self.spr1,nil,cfg.bk_act_id,self)
		end

		--self.fnt_label  = cc.Label:createWithBMFont(cfg.score_fnt_src,string.format("%d",self.rtt_info.param.score))
		self.fnt_label = ccui.TextAtlas:create(tostring(self.rtt_info.param.score), cfg.score_fnt_src, cfg.size.x, cfg.size.y, "0")
		if item_config.scale then 
        	self.fnt_label:setScale(cfg.scale)
    	end
		self:addChild(self.fnt_label)

		local function __rotate_score_end_call()
			self.fnt_label:removeFromParent()
			self.spr1:removeFromParent()
		end

		ActionEffectPlayer.getInstance():play(self.fnt_label,__rotate_score_end_call,cfg.score_act_id,self)
	end
end

function RotateScore:rotateRoot(side,pos)
	local angle = 0
	if side == 1 then
		angle = 90
	elseif side == 2 then
		angle = 270
	elseif side == 3 then
		angle = 180
	elseif side == 4 then
		angle = 0
	end

	local new_x = pos.x*math.cos((angle/180)*math.pi) + pos.y*math.sin((angle/180)*math.pi)
	local new_y = pos.y*math.cos((angle/180)*math.pi) - pos.x*math.sin((angle/180)*math.pi)

	return {x = new_x,y = new_y,}
end

