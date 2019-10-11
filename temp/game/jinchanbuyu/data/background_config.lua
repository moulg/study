

--[[
	背景配置
	common = {
		mus_id,切换时音效id
		wave_src_id,切换水波资源id
		cut_t,场景切换时间
	}

	data = {--背景场景集合
	
		[1] = {--一个背景场景
			id,场景id
			bk_mus_id,背景音
			bk_pic_id,背景图
			view_inf = {
				[1] = {
					src_id,资源id [spr_ani_config.lua]
					pos = {x,y},坐标
				},

				[...] = {...},
			},
		},

		[...] = {...},
	}
]]

background_config = {
	common = {
		mus_id = 3,
		wave_src_id  = 57,
		cut_t 		 = 6,
	},

	data = {
		[1] = {
			id = 1,
			bk_mus_id = 1,
			bk_pic_id = 66,
			view_inf = {
				[1] = {src_id = 88,pos = {x = 600,y = 600,},},
				[2] = {src_id = 92,pos = {x = 1500,y = 920,},},
				[3] = {src_id = 89,pos = {x = 300,y = 200,},},
			},
		},

		[2] = {
			id = 2,
			bk_mus_id = 2,
			bk_pic_id = 67,
			view_inf = {
				[1] = {src_id = 88,pos = {x = 600,y = 600,},},
				[2] = {src_id = 92,pos = {x = 1500,y = 620,},},
				[3] = {src_id = 89,pos = {x = 300,y = 200,},},
			},
		},

		[3] = {
			id = 3,
			bk_mus_id = 3,
			bk_pic_id = 68,
			view_inf = {
				[1] = {src_id = 88,pos = {x = 600,y = 600,},},
				[2] = {src_id = 92,pos = {x = 1500,y = 620,},},
				[3] = {src_id = 89,pos = {x = 300,y = 200,},},
			},
		},

		[4] = {
			id = 1,
			bk_mus_id = 1,
			bk_pic_id = 66,
			view_inf = {
				[1] = {src_id = 88,pos = {x = 600,y = 600,},},
				[2] = {src_id = 92,pos = {x = 1500,y = 920,},},
				[3] = {src_id = 89,pos = {x = 300,y = 200,},},
			},
		},

		[5] = {
			id = 2,
			bk_mus_id = 2,
			bk_pic_id = 67,
			view_inf = {
				[1] = {src_id = 88,pos = {x = 600,y = 600,},},
				[2] = {src_id = 92,pos = {x = 1500,y = 620,},},
				[3] = {src_id = 89,pos = {x = 300,y = 200,},},
			},
		},

		[6] = {
			id = 3,
			bk_mus_id = 3,
			bk_pic_id = 68,
			view_inf = {
				[1] = {src_id = 88,pos = {x = 600,y = 600,},},
				[2] = {src_id = 92,pos = {x = 1500,y = 620,},},
				[3] = {src_id = 89,pos = {x = 300,y = 200,},},
			},
		},		
	},
}
