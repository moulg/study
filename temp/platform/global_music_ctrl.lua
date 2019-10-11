
BUTTON_AUDIO_1_WAV = "common/prop/music/button.wav"
BUTTON_AUDIO_1_MP3 = "common/prop/music/button.mp3"



global_music_ctrl = {}

function global_music_ctrl.play_eff(src)
	AudioEngine.playEffect(src)
end

function global_music_ctrl.play_btn_one()
	AudioEngine.playEffect(BUTTON_AUDIO_1_MP3)
end

