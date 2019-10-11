
--[[
	背景场景切换管理
]]

local __seawave_zorder = 1000000

BackgroundSceneManager = class("BackgroundSceneManager",function ()
	local obj  = {}
	return obj
end)

local __background_scene_manager_obj = nil

function BackgroundSceneManager.getInstance()

	if __background_scene_manager_obj == nil then
		__background_scene_manager_obj = BackgroundSceneManager.new()
	end

	return __background_scene_manager_obj
end

function BackgroundSceneManager.destroyInstance()
	for k,v in pairs(background_config.data) do
		local src = sprite_ani_config[v.bk_pic_id].file
		cc.Director:getInstance():getTextureCache():removeTextureForKey(src)
	end
	
	__background_scene_manager_obj = nil
end

function BackgroundSceneManager:init(parent)
	self.parent = parent
	self.bg_com_cfg = background_config.common
	self.cur_scene = nil
	self.front_scene = nil

	self.cut_scene_state = 0--背景场景状态  0 无场景，1 场景切换完成，2 正在切换场景
	self.cut_scene_time = self.bg_com_cfg.cut_t
	self.cut_scene_time_add = 0
	self.cur_scene_id = -1
	self.front_scene_id = -1
	self.buse_water_wave = true

	for k,v in pairs(background_config.data) do
		local src = sprite_ani_config[v.bk_pic_id].file
		cc.Director:getInstance():getTextureCache():addImage(src)
	end

	self.finishCallBack = nil		--场景切换完成回调
end

function BackgroundSceneManager:createSeawaveObj(callback)

	self.finishCallBack = callback

	self.seawave_obj = self:createSpr(sprite_ani_config[self.bg_com_cfg.wave_src_id])
	self.parent:addChild(self.seawave_obj)

	self.seawave_obj:setPosition(0,0)
	self.seawave_obj:setVisible(false)
	self.seawave_obj:setLocalZOrder(__seawave_zorder)

	self.seawave_size = self.seawave_obj:getContentSize()

	if self.buse_water_wave == true and self.fish_water_obj == nil then
		self.fish_water_obj = FishWater.create()
		self.parent:addChild(self.fish_water_obj)
		self.fish_water_obj:setPosition(0,0)
		self.fish_water_obj:setVisible(true)
	end
end

function BackgroundSceneManager:cutBackgroundScene(id)

	BatteryManager.getInstance():clearAllLockState()

	if self.cur_scene then
		self.front_scene = self.cur_scene
		self.cur_scene = nil
	end

	local scene_info = background_config.data[id]

	if scene_info then
		self.cur_scene = BackgroundScene.create(self.cut_scene_state,self.bg_com_cfg.cut_t,scene_info)
		self.parent:addChild(self.cur_scene)
		self.front_scene_id = self.cur_scene_id
		self.cur_scene_id 	= id

		local pos = {x = jc_system_config.scene_size.width + self.seawave_size.width/4,y = jc_system_config.scene_size.height/2,}

		self.seawave_obj:setPosition(pos)

		if self.cut_scene_state == 0 then
			self.seawave_obj:setVisible(false)
		else
			self.seawave_obj:setVisible(true)
		end

		if self.cut_scene_state == 1 then
			local frame_name = string.format(sprite_ani_config[self.bg_com_cfg.wave_src_id].pattern,1)
			self.seawave_obj:setSpriteFrame(frame_name)

			MusicEffectPlayer.getInstance():play(self.bg_com_cfg.mus_id)

			local exit_ani = cc.AnimationCache:getInstance():getAnimation(sprite_ani_config[self.bg_com_cfg.wave_src_id].key)
			if exit_ani == nil then
				local animation = self:createAnimation(sprite_ani_config[self.bg_com_cfg.wave_src_id])
				cc.AnimationCache:getInstance():addAnimation(animation,sprite_ani_config[self.bg_com_cfg.wave_src_id].key)
			end

			local ani_key = sprite_ani_config[self.bg_com_cfg.wave_src_id].key
			local animation = cc.AnimationCache:getInstance():getAnimation(ani_key)

			if animation then
				animation:retain()
				local animate = cc.Animate:create(animation)
				animation:release()
				local action  = cc.RepeatForever:create(animate)
				self.seawave_obj:runAction(action)
			end

			local need_t = self.bg_com_cfg.cut_t*((jc_system_config.scene_size.width + 2.5*self.seawave_size.width/4)/jc_system_config.scene_size.width)
			self.cut_scene_time = need_t
			local mov_obj = cc.MoveTo:create(need_t,{x = -self.seawave_size.width/2,y = jc_system_config.scene_size.height/2,})

			self.seawave_obj:runAction(mov_obj)
			self.cut_scene_state = 2
			self.cut_scene_time_add = 0
			self.cur_scene:setLocalZOrder(__seawave_zorder - 100)

		else
			self.cut_scene_state = 1
			self.cut_scene_time_add = 0
			print("cut background scene complete>>>>>>>>>>>>")
			FishManager.getInstance():clearAllFish()
			self.finishCallBack()
		end
	else
		self.cut_scene_state = 0
		self.cut_scene_time_add = 0
		self.cur_scene_id = -1
		self.front_scene_id = -1
		print("cut background scene failed!")
	end
end

function BackgroundSceneManager:getSceneState()
	return self.cut_scene_state 
end

function BackgroundSceneManager:forceChangeBkMus(mus_id)
	local mus_src = background_music_src_config[mus_id].file
	if mus_src then
		AudioEngine.playMusic(mus_src,true)
	end
end

function BackgroundSceneManager:resumeBkMus()
	if self.cur_scene then
		local mus_src = background_music_src_config[self.cur_scene:getBkMusicId()]
		AudioEngine.playMusic(mus_src,true)
	end
end

function BackgroundSceneManager:update(dt)
	if self.cut_scene_state == 2 then
		if self.cut_scene_time_add >= self.cut_scene_time then
			self.cut_scene_state    = 1
			self.cut_scene_time_add = 0
			self.seawave_obj:setVisible(false)
			self.seawave_obj:stopAllActions()
			self.cur_scene:setLocalZOrder(1)

			if self.front_scene then
				self.front_scene:removeFromParent()
				self.front_scene = nil
				

				self.cut_scene_state = 1
				self.cut_scene_time_add = 0
				print("cut background scene complete>>>>>>>>>>>>")
				FishManager.getInstance():clearAllFish()
				self.finishCallBack()
			end
		else
			self.cut_scene_time_add = self.cut_scene_time_add + dt
		end
	end
end

function BackgroundSceneManager:createAnimation(cfg_item,bregorg)
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

function BackgroundSceneManager:createSpr(cfg_item)
	local spr = nil
	if cfg_item then
		local frame_name = string.format(cfg_item.pattern,1)
		spr = cc.Sprite:createWithSpriteFrameName(frame_name)
	end

	return spr
end

function BackgroundSceneManager:getCurrentBkSenceObj()
	return self.cur_scene
end

function BackgroundSceneManager:getCurrentSceneId()
	return self.cur_scene_id
end

function BackgroundSceneManager:getFrontSceneId()
	return self.front_scene_id
end

function BackgroundSceneManager:useWaterWave(buse)
	self.buse_water_wave = buse
	if self.buse_water_wave == true and self.fish_water_obj == nil then
		self.fish_water_obj = FishWater.create()
		self.parent:addChild(self.fish_water_obj)
		self.fish_water_obj:setPosition(0,0)
		self.fish_water_obj:setVisible(true)
	end

	if self.buse_water_wave == false and self.fish_water_obj ~= nil then
		self.fish_water_obj:removeFromParent()
		self.fish_water_obj = nil
	end
end
