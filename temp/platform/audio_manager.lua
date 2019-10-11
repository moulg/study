#remark
--[[
音乐管理
]]

audio_manager = {}

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

audio_manager.backMusicId = nil

audio_manager.music_table = {}
audio_manager.effect_other_table = {}
audio_manager.effect_male_table = {}
audio_manager.effect_female_table = {}

--配置表预加载音乐 和 音效
function audio_manager:reloadMusicByConfig(cfg_list)
	self.music_table = cfg_list.music_table
	self.effect_other_table = cfg_list.effect_other_table
	self.effect_male_table = cfg_list.effect_male_table
	self.effect_female_table = cfg_list.effect_female_table

	-- if cfg_list.music_table ~= nil then
		-- for k,v in pairs(cfg_list.music_table) do
		--    	AudioEngine.preloadMusic( v.resPath )
		-- end
	-- end

	-- if cfg_list.effect_other_table ~= nil then
		-- for k,v in pairs(cfg_list.effect_other_table) do
		--    	AudioEngine.preloadEffect( v.resPath )
		-- end
	-- end

	-- if cfg_list.effect_male_table ~= nil then
		-- for k,v in pairs(cfg_list.effect_male_table) do
		--    	AudioEngine.preloadEffect( v.resPath )
		-- end
	-- end

	-- if cfg_list.effect_female_table ~= nil then
		-- for k,v in pairs(cfg_list.effect_female_table) do
		--    	AudioEngine.preloadEffect( v.resPath )
		-- end
	-- end
end

--销毁音乐资源
function audio_manager:destoryAllMusicRes()
	AudioEngine.destroyInstance()
end

--设置背景音乐音量
function audio_manager:setMusicVolume(value)
	AudioEngine.setMusicVolume(value/100)
end

--设置音效音量
function audio_manager:setSoundVolmue(value)
	AudioEngine.setEffectsVolume(value/100)
end

--播发背景音乐
function audio_manager:playBackgroundMusic(id, loop)
	if self.music_table[id] then
		AudioEngine.playMusic(self.music_table[id].resPath, loop)
	end
end

--播发音效  0:男,1:女
function audio_manager:playPlayerSound(id, sex)
	local effectList

	if sex == 0 then
		effectList = self.effect_male_table
	elseif sex == 1 then
		effectList = self.effect_female_table
	else
		effectList = self.effect_other_table
	end

	if effectList[id] then
		return AudioEngine.playEffect(effectList[id].resPath)
	end
end

--播发其他音效
function audio_manager:playOtherSound(id, loop)
	local effectList=self.effect_other_table
	if effectList[id] then
		return AudioEngine.playEffect(effectList[id].resPath, loop)
	end
end

function audio_manager:stopSound(handler)
	AudioEngine.stopEffect(handler)
end

function audio_manager:stopALLSound()
	AudioEngine.stopAllEffects()
end

--游戏音效初始化
function audio_manager:initGameAudio()
	--音效设置
    local _playerInfo = get_player_info()
	local userConfig = get_user_config()
	local setData = userConfig[_playerInfo.curGameID]
	if setData then
		--声音设置
		if setData.musicCheck == 1 then
			audio_manager:setMusicVolume(setData.musicVol)
		else
			audio_manager:setMusicVolume(0)
		end

		--音效设置
		if setData.soundCheck == 1 then
			audio_manager:setSoundVolmue(setData.soundVol)
		else
			audio_manager:setSoundVolmue(0)
		end
	else
		audio_manager:setMusicVolume(100)
		audio_manager:setSoundVolmue(100)
	end
end

function audio_manager:pauseMusic()
	AudioEngine.pauseMusic()
end

function audio_manager:resumeMusic()
	AudioEngine.resumeMusic()
end


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
