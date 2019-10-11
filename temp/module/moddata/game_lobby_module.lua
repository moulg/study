#remark
local data = {
	property = {
		name = "game_lobby",
		win_size = {w = 1137,h = 640,},
		win_mod = 1,
		title_h = 30,
		--is_reset_des = false,
		is_reset_des = true,
	},
	member = {
		[1] = {
			class_name 	= "CGameLobby",
			z_order = 1,
			pos 	= {x = 0,y = 0,},
			scale   = {x = 1.0,y = 1.0,},
			visible = true,
		},
	},
}
return data