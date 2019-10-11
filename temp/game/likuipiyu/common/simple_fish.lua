--[[
	简单鱼，忽略所以特效，音效，路径，包围盒等条件
]]

SimpleFish = class("SimpleFish",function ()
	local obj = cc.Node:create()
	return obj
end)

--[[
	info = {
		id,--配置id
		balive,--创建活，死时的鱼资源
	}
]]
function SimpleFish.create(info)
	local obj = SimpleFish.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function SimpleFish:init(info)
	self.fcfg   = clone(fish_config[info.id])
	self.balive = info.balive

	self.spr_lst = {}

	if self.balive == true then
		self:createFishItem(self.fcfg.alive,self.spr_lst)
		self:setContentSize(self.fcfg.alive.size)
	else
		self:createFishItem(self.fcfg.death,self.spr_lst)
		self:setContentSize(self.fcfg.death.size)
	end

	self:start(self.spr_lst)
end

function SimpleFish:createAnimation(cfg_item,bregorg)
	local animation = nil
	if cfg_item then
		local frames = display.newFrames(cfg_item.pattern,1,cfg_item.fs)
		animation = cc.Animation:createWithSpriteFrames(frames,cfg_item.ft)
		if bregorg == true then
			animation:setRestoreOriginalFrame(bregorg)
		end
	end

	return animation
end

function SimpleFish:createFishSpr(cfg_item)
	local spr = nil
	if cfg_item then
		local frame_name = string.format(cfg_item.pattern,1)
		spr = cc.Sprite:createWithSpriteFrameName(frame_name)
	end

	return spr
end

function SimpleFish:createFishItem(data,item_lst)
	local len 	= #data.view_inf

	for i=1,len do
		local src_cfg = sprite_ani_config[data.view_inf[i].src_id]

		local item  = {}
		item.loop 	= data.view_inf[i].loop
		item.act_id = data.view_inf[i].act_id
		item.stype	= src_cfg.stype
		item.ani_key = src_cfg.key


		if src_cfg.stype == 1 then
			item.spr = self:createFishSpr(src_cfg)

			local exit_ani = cc.AnimationCache:getInstance():getAnimation(item.ani_key)
			if exit_ani == nil then
				local animation = self:createAnimation(src_cfg,true)
				cc.AnimationCache:getInstance():addAnimation(animation,item.ani_key)
			end

			self:addChild(item.spr)
			item.spr:setPosition(data.view_inf[i].pos.x,data.view_inf[i].pos.y)
		elseif src_cfg.stype == 2 then
			item.spr = cc.Sprite:create(src_cfg.file)
			self:addChild(item.spr)
			item.spr:setPosition(data.view_inf[i].pos.x,data.view_inf[i].pos.y)
		elseif src_cfg.stype == 3 then
			--pirticle
			local pit_obj = cc.ParticleSystemQuad:create(src_cfg.file)
			self:addChild(pit_obj)
			pit_obj:setPosition(data.view_inf[i].pos.x,data.view_inf[i].pos.y)
			pit_obj:setAutoRemoveOnFinish(true)
		end

		table.insert(item_lst,item)
	end
end

function SimpleFish:start(spr_lst)
	for k,v in pairs(spr_lst) do
		if v.stype == 1 then
			local animation = cc.AnimationCache:getInstance():getAnimation(v.ani_key)
			if animation then
				local action = nil
				animation:retain()
				local animate = cc.Animate:create(animation)
				animation:release()
				if v.loop == -1 then
					action = cc.RepeatForever:create(animate)
				else
					action = cc.Repeat:create(animate,v.loop)
				end

				if v.spr then
					v.spr:runAction(action)
				end
				
			end
		elseif v.stype == 2 then
			--todo
		elseif v.stype == 3 then
			--todo
		end

		if v.spr then
			ActionEffectPlayer.getInstance():play(v.spr,nil,v.act_id)
		end
	end
end


