
--[[
	炮台配置
	id: 索引id
	send_v : 子弹发射速度
	bubr_info ={ 子弹，炮管对应关系
		[1] = {[1]:普通子弹id bullet_config.lua,[2]：能量子弹id,[3]：自己炮管id spr_ani_config.lua,[4]：别人炮管id,[5]：能量炮管id}, -> 单管
		[2] = {[1]:普通子弹id bullet_config.lua,[2]：能量子弹id,[3]：自己炮管id spr_ani_config.lua,[4]：别人炮管id,[5]：能量炮管id}, -> 双管
		[3] = {[1]:普通子弹id bullet_config.lua,[2]：能量子弹id,[3]：自己炮管id spr_ani_config.lua,[4]：别人炮管id,[5]：能量炮管id}, -> 三管
		[4] = {[1]:普通子弹id bullet_config.lua,[2]：能量子弹id,[3]：自己炮管id spr_ani_config.lua,[4]：别人炮管id,[5]：能量炮管id}, -> 四管
	}
	offset_dis: 子弹发射点偏移距离
	mus_eff_id: 发射子弹声音
	gold_cl_spos: 金币柱起始位置
	gold_cl_num: 金币柱数量
	gold_cl_way: 金币柱排列方向 1->x正方向，-1->x负方向
	frame_key: 积分框资源
	lock_line_key: 锁定线资源
]]
battery_config = {
	[1] = {id = 1,desc = "黄  ",send_v = 0.25,bubr_info = {{1,25,54,71,74,},{2,26,69,72,75,},{3,27,70,73,76,},},offset_dis = 120,mus_eff_lst = {2,35},gold_cl_spos = {x=257,y=65,},gold_cl_num = 4,gold_cl_way = 1,frame_key  = "kuang6.png",lock_line_key = "lock_1",},
	[2] = {id = 2,desc = "橘  ",send_v = 0.25,bubr_info = {{4,25,54,71,74,},{5,26,69,72,75,},{6,27,70,73,76,},},offset_dis = 120,mus_eff_lst = {2,35},gold_cl_spos = {x=257,y=65,},gold_cl_num = 4,gold_cl_way = 1,frame_key  = "kuang3.png",lock_line_key = "lock_2",},
	[3] = {id = 3,desc = "橘黄",send_v = 0.25,bubr_info = {{7,25,54,71,74,},{8,26,69,72,75,},{9,27,70,73,76,},},offset_dis = 120,mus_eff_lst = {2,35},gold_cl_spos = {x=257,y=65,},gold_cl_num = 4,gold_cl_way = 1,frame_key  = "kuang4.png",lock_line_key = "lock_3",},
	[4] = {id = 4,desc = "绿  ",send_v = 0.25,bubr_info = {{10,25,54,71,74,},{11,26,69,72,75,},{12,27,70,73,76,},},offset_dis = 120,mus_eff_lst = {2,35},gold_cl_spos = {x=257,y=65,},gold_cl_num = 4,gold_cl_way = 1,frame_key  = "kuang7.png",lock_line_key = "lock_4",},
	[5] = {id = 5,desc = "红  ",send_v = 0.25,bubr_info = {{13,25,54,71,74,},{14,26,69,72,75,},{15,27,70,73,76,},},offset_dis = 120,mus_eff_lst = {2,35},gold_cl_spos = {x=257,y=65,},gold_cl_num = 4,gold_cl_way = 1,frame_key  = "kuang2.png",lock_line_key = "lock_5",},
	[6] = {id = 6,desc = "蓝  ",send_v = 0.25,bubr_info = {{16,25,54,71,74,},{17,26,69,72,75,},{18,27,70,73,76,},},offset_dis = 120,mus_eff_lst = {2,35},gold_cl_spos = {x=257,y=65,},gold_cl_num = 4,gold_cl_way = 1,frame_key  = "kuang1.png",lock_line_key = "lock_6",},
	[7] = {id = 7,desc = "浅蓝",send_v = 0.25,bubr_info = {{19,25,54,71,74,},{20,26,69,72,75,},{21,27,70,73,76,},},offset_dis = 120,mus_eff_lst = {2,35},gold_cl_spos = {x=257,y=65,},gold_cl_num = 4,gold_cl_way = 1,frame_key  = "kuang5.png",lock_line_key = "lock_7",},
	[8] = {id = 8,desc = "紫  ",send_v = 0.25,bubr_info = {{22,25,54,71,74,},{23,26,69,72,75,},{24,27,70,73,76,},},offset_dis = 120,mus_eff_lst = {2,35},gold_cl_spos = {x=257,y=65,},gold_cl_num = 4,gold_cl_way = 1,frame_key  = "kuang8.png",lock_line_key = "lock_8",},
}