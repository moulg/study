
--[[
	音效特效播放
]]
MusicEffectPlayer = class("MusicEffectPlayer",function ()
	local obj = {}
	return obj
end)

local __music_eff_player_obj = nil


function MusicEffectPlayer.getInstance()
	if __music_eff_player_obj == nil then
		__music_eff_player_obj = MusicEffectPlayer.new()
	end

	return __music_eff_player_obj
end

function MusicEffectPlayer.destroyInstance()
	if __music_eff_player_obj then
		__music_eff_player_obj:destroy()
	end
	__music_eff_player_obj = nil
end

function MusicEffectPlayer:init()
	print("music effect player initialize!")

	self.all_music_eff_lst = {}

	local function __update(dt) self:update(dt) end
	local scheduler = cc.Director:getInstance():getScheduler()
	self.sch_handle = scheduler:scheduleScriptFunc(__update,0.0,false)
end

function MusicEffectPlayer:update(dt)

	for i=1,#self.all_music_eff_lst do
		local litem = self.all_music_eff_lst[i]
		local litem_bcmp = true

		for j=1,#litem.mus_data_lst do
			local llitem = litem.mus_data_lst[j]
			if llitem.bplay_cmp == false then
				litem_bcmp = false
				break
			end
		end

		if litem_bcmp == true then
			table.remove(self.all_music_eff_lst,i)
			--print("remove has play music effect!")
			break
		end
	end

	for i=1,#self.all_music_eff_lst do

		local litem = self.all_music_eff_lst[i]

		for j=1,#litem.mus_data_lst do
			local llitem = litem.mus_data_lst[j]

			if llitem.cur_play_index <= #llitem.data_lst then
				if llitem.cur_add_time >= llitem.data_lst[llitem.cur_play_index].t then

					--播放音效
					local src = voice_config[llitem.data_lst[llitem.cur_play_index].src_id].file
					local loop = llitem.data_lst[llitem.cur_play_index].loop
					AudioEngine.playEffect(src,loop)

					llitem.cur_add_time   = 0
					llitem.cur_play_index = llitem.cur_play_index + 1
				else
					llitem.cur_add_time = llitem.cur_add_time + dt
					print("=======================================================================================");
				end
			else
				llitem.bplay_cmp = true
			end
		end
	end
end

function MusicEffectPlayer:destroy()
	local scheduler = cc.Director:getInstance():getScheduler()
	scheduler:unscheduleScriptEntry(self.sch_handle)
	self:stopAlMusiclEffect()
end

function MusicEffectPlayer:stopAlMusiclEffect()
	AudioEngine.destroyInstance()
	self.all_music_eff_lst = {}
end

function MusicEffectPlayer:play(mus_id)
	if mus_id ~= nil and mus_id ~= -1 then
		local cfg_data = music_effect_config[mus_id]
		local lst = self:analyze(cfg_data)

		if #lst.mus_data_lst > 0 then
			table.insert(self.all_music_eff_lst,lst)
		end
	end
end

function MusicEffectPlayer:analyze(data)

	local result_lst = {
		mus_eff_id = data.id,
		mus_data_lst = {},
	}

	if data then
		local mus_lst = data.mus_lst	
		local cur_new_index = 1

		local new_item = {cur_add_time = 0,cur_play_index = 1,data_lst = {},bplay_cmp = false,}
		table.insert(result_lst.mus_data_lst,new_item)

		local eff_len = #mus_lst

		for i=1,eff_len do
			table.insert(result_lst.mus_data_lst[cur_new_index].data_lst,mus_lst[i])
			if mus_lst[i].nxt_idx == -1 and i < eff_len then
				local new_item = {cur_add_time = 0,cur_play_index = 1,data_lst = {},bplay_cmp = false,}
				table.insert(result_lst.mus_data_lst,new_item)
				cur_new_index = #result_lst.mus_data_lst
			end
		end
	end

	return result_lst
end


