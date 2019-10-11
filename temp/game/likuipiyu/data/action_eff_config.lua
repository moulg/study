
--[[
	动作效果配置,动作链
	id: 索引
	init_param = {起始参数，此项不填，则为默认
		angle,初始旋转多少度
		sax,初始x方向缩放因子 0~1
		say,初始y入射缩放因子 0~1
		skx,初始x方向倾斜角度 0~360
		sky,初始y方向倾斜角度 0~360
		srkx,初始x方向旋转倾斜角度 0~360
		srky,初始y方向旋转倾斜角度 0~360
		zorder,初始化zorder
	}
	eff_lst = {--动作链
		[x] = {
			key,动作id
			loop,播放次数,-1为无限循环
			breeserve,是否生成应该动作的反向动作，指定后会生成两个动作，一个正向一个反向，有些动作不支持反向，自动忽略此参数
			nxt_idx,下一动作索引，-1表示该动作链结束，非-1时nxt_idx表示下一动作索引，此时会视下一动作为同一动作链
			param = {--动作对应参数
				
			}
		}
	}
]]
action_eff_config = {
	[1] = {id = 1,   init_param={},eff_lst={[1]={key = "tint_by",loop = -1,breserver = true,nxt_idx = -1,param={t = 0.5,r = 0,g = 255,b = 255,}, }, }, },
	[2] = {id = 2,   init_param={zorder = 100000,},eff_lst={[1]={key = "tint_by",loop = 6,breserver = true,nxt_idx = -1,param = {t = 0.05,r = 0,g = 255,b = 255,}, }, }, },
	[3] = {id = 3,   init_param={},eff_lst={[1]={key = "delay",loop = 1,breserver = false,nxt_idx = -1,param = {t = 0.9,}, }, }, },
	[4] = {id = 4,   init_param={},eff_lst={[1]={key = "move_by",loop = 1,breserver = true,nxt_idx = -1,param={t = 0.2,pos = {x = 0,y = -100},}, },[2]={key = "delay",loop = 1,breserver = false,	nxt_idx = -1,param = {t = 1,}, }, }, },
	[5] = {id = 5,   eff_lst = {[1] = {key = "move_by",loop = -1,breserver = true,nxt_idx = -1,param={t = 0.5,pos = {x = 0,y = -20},}, }, }, },
	[6] = {id = 6,   init_param={},eff_lst={[1]={key = "ffshake",loop = 1,breserver = false,nxt_idx = -1,param={t = 1,dx = 20,dy = 20,}, }, },},
	[7] = {id = 7,   init_param={},eff_lst={[1]={key = "circle",loop = -1,breserver = false,nxt_idx = -1,param={t = 3,pos = {x = 180,y = 150,},sl = 0.0,angle = 360,}, }, }, },
	[8] = {id = 8,   init_param={},eff_lst={[1]={key = "rotate_by",loop = 5,breserver = true,nxt_idx = -1,param={t = 0.5,angle = 60,}, }, }, },
	[9] = {id = 9,   init_param={},eff_lst={[1]={key = "rotate_by",loop = -1,breserver = false,nxt_idx = -1,param={t = 0.3,angle = 360,}, }, }, },
   [10] = {id = 10,  init_param={sax = 1.8,say = 1.8,},eff_lst = {[1] = {key = "delay",loop = 1,breserver = false,  nxt_idx = -1,param={t = 2, sx = 1.2,sy = 1.2}, }, }, },
   [11] = {id = 11,  init_param={sax = 2,say = 2,},eff_lst = {[1] = {key = "delay",loop = 1,breserver = false,  nxt_idx = -1,param={t = 1, sx = 1.2,sy = 1.2}, }, }, },
   [12] = {id = 12,  init_param={sax = 1.5,say = 1.5,},eff_lst = {[1] = {key = "delay",loop = 1,breserver = false,  nxt_idx = -1,param={t = 1.5, sx = 1.2,sy = 1.2}, }, }, },
   [13] = {id = 13,  eff_lst = {[1] = {key = "scale_by",loop = 1,breserver = false,  nxt_idx = -1,param={t = 5, sx = 1.5,sy = 1.5}, }, }, },
   [14] = {id = 14,  eff_lst = {[1] = {key = "rotate_by",loop = -1,breserver = false,  nxt_idx = -1,param={t = 1.5, angle = 360}, }, }, },
   [15] = {id = 15,  init_param={sax = 1.8,say = 1.8,},eff_lst = {[1] = {key = "delay",loop = 1,breserver = false,  nxt_idx = -1,param={t = 2.5, sx = 1.2,sy = 1.2},}, [2] = {key = "rotate_by",loop = 3,breserver = false,  nxt_idx = -1,param={t = 1.5, angle = 360},  },  }, },
   [16] = {id = 16,  init_param={sax = 0.6,say = 0.6,},eff_lst={},},
   [17] = {id = 17,  eff_lst = {[1] = {key = "rotate_by",loop = -1,breserver = false,  nxt_idx = -1,param={t = 3, angle = -360}, }, }, },
   [18] = {id = 18,   init_param={},eff_lst={[1]={key = "circle",loop = -1,breserver = false,nxt_idx = -1,param={t = 3,pos = {x = -180,y = 150,},sl = 0.0,angle = -360,}, }, }, },
   [19] = {id = 19,   init_param={sax = 3,say = 3,},eff_lst={[1]={key = "scale_by",loop = -1,breserver = false,nxt_idx = -1,param={t = 3, sx = 0.5,sy = 0.5},}, [2]={key = "fade_out",loop = 1,breserver = false,	nxt_idx = -1,param = {t = 6,}, },},  },
   [20] = {id = 20,   init_param={},eff_lst={[1]={key = "blink",loop = -1,breserver = false,nxt_idx = -1,param={t = 3, ts = 1},},},  },
   [21] = {id = 21,  eff_lst = {[1] = {key = "rotate_by",loop = -1,breserver = false,  nxt_idx = -1,param={t = 10, angle = 360}, }, }, },
   [22] = {id = 22,  eff_lst = {[1] = {key = "rotate_by",loop = 4,breserver = false,  nxt_idx = -1,param={t = 1.5, angle = 360}, }, }, },
   [23] = {id = 23,  init_param={sax = 2,say = 2,},eff_lst = {[1] = {key = "delay",loop = 1,breserver = false,  nxt_idx = -1,param={t = 3, sx = 1.2,sy = 1.2}, }, }, },  
   [24] = {id = 24,  init_param={sax = 0.5,say = 0.5,},eff_lst = {}, }, 
   [25] = {id = 25,  init_param={sax = 0.8,say = 0.8,},eff_lst = {}, }, 
   [26] = {id = 26,  init_param={sax = 1.5,say = 1.5,},eff_lst = {}, }, 


	--end
}