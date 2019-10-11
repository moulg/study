

--[[
	背景
]]


local bk_zorder = 1


BackgroundScene = class("BackgroundScene",function ()
	local obj = cc.Sprite:create()
	return obj
end)

--[[
	bk_state
	cut_t,
	info = {
		bk_mus_id,
		bk_pic_id,
		view_inf ={
			[1] = {
				src_id,pos = {x,y,},
			}
		}
	}
]]
function BackgroundScene.create(bk_state,cut_t,info)
	local obj = BackgroundScene.new()

	if obj then
		obj:init(bk_state,cut_t,info)
	end

	return obj
end

function BackgroundScene:init(bk_state,cut_t,info)
	self.org_mus_id = info.bk_mus_id

	local mus_src = background_music_src_config[info.bk_mus_id].file
	if mus_src then AudioEngine.playMusic(mus_src,true) end

	local bk_src = sprite_ani_config[info.bk_pic_id].file

	if bk_src then
		local texture = cc.Director:getInstance():getTextureCache():getTextureForKey(bk_src)
		self:setTexture(texture)
		local size = texture:getContentSize()
		self:setTextureRect({x = 0,y = 0,width = size.width,height = size.height})
	end

	local pic_size = self:getContentSize()

	local pos = {x = jc_system_config.scene_size.width + pic_size.width/2,y = jc_system_config.scene_size.height/2}

	if bk_state == 0 then
		pos.x = jc_system_config.scene_size.width/2
		pos.y = jc_system_config.scene_size.height/2
	end

	self:setPosition(pos)
	self:createView(info.view_inf)

	self:setLocalZOrder(bk_zorder)

	if bk_state == 1 then
		local mov_obj = cc.MoveTo:create(cut_t,{x = jc_system_config.scene_size.width/2,y = jc_system_config.scene_size.height/2})
		self:runAction(mov_obj)
	end
end


function BackgroundScene:getBkMusicId()
	return self.org_mus_id
end

function BackgroundScene:createView(view_inf)
	for k,v in pairs(view_inf) do
		local src_cfg = sprite_ani_config[v.src_id]

		if src_cfg then
			if src_cfg.stype == 1 then --animation
				local spr = self:createSpr(src_cfg)

				local exit_ani = cc.AnimationCache:getInstance():getAnimation(src_cfg.key)
				if exit_ani == nil then
					local animation = self:createAnimation(src_cfg)
					cc.AnimationCache:getInstance():addAnimation(animation,src_cfg.key)
				end

				self:addChild(spr)
				spr:setPosition(v.pos.x,v.pos.y)

				local animation = cc.AnimationCache:getInstance():getAnimation(src_cfg.key)
				if animation then
					animation:retain()
					local animate = cc.Animate:create(animation)
					animation:release()
					local action  = cc.RepeatForever:create(animate)
					spr:runAction(action)
				end
			elseif src_cfg.stype == 2 then--pic
				local spr = cc.Sprite:create(src_cfg.file)
				self:addChild(spr)
				spr:setPosition(v.pos.x,v.pos.y)
			elseif src_cfg.stype == 3 then --pirticle

			end
		end
	end
end


function BackgroundScene:createAnimation(cfg_item,bregorg)
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

function BackgroundScene:createSpr(cfg_item)
	local spr = nil
	if cfg_item then
		local frame_name = string.format(cfg_item.pattern,1)
		spr = cc.Sprite:createWithSpriteFrameName(frame_name)
	end

	return spr
end



