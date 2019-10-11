#remark
local data = {
	property = {
		name = "baccarat_std",
		win_size = {w = 1700,h = 956,},
		win_mod = 1,
		title_h = 30,
		is_reset_des = true,
	},
	member = {
		[1] = {
			class_name 	= "CBaccaratMainScene",
			z_order = 1,
			pos 	= {x = 0,y = 0,},
			scale   = {x = 1.0,y = 1.0,},
			visible = true,
		},
		[2] = {
			class_name 	= "CTableTalkExt",
			z_order = 2,
			pos 	= {x = 0,y = 0,},
			scale   = {x = 1.0,y = 1.0,},
			visible = true,
		},
		[3] = {
			class_name 	= "CTableTitleExt",
			z_order = 3,
			pos 	= {x = 0,y = 0,},
			scale   = {x = 1.0,y = 1.0,},
			visible = true,
		},
	},
}

return data
