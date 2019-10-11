
--[[
	系统配置
]]

jc_system_config = {
	scene_size 	 				= {width = 1920,height = 1080,},--场景大小
	bonding_size 				= {width = 1920,height = 1080,},--子弹运动范围
	mouse_move_size				= {width = 1920,height = 1040,},--鼠标有效范围
	rotate_score_pos			= { x = 200,y = 200,},--分数转圈的位置
	gold_arrang_way 			= 1,--arr_way:金币排列方式 1->排成一行，2->排成一个矩形
	max_gold_arrange_way 		= 10,--一次最多显示的金币数量
	max_gold_arrange_way2_line 	= 5,--为矩形排列时，一行最多排列金币数量
	gold_distance 				= 0,--两金币之间的距离
	gold_move_v 				= 1200,--金币飞入玩家的速度
	gold_mus_id 				= 4,--爆金币时的音效id
	gold_fnt_index 				= 1,--显示鱼分数的字体
	gold_column_max_number 		= 100,--金币柱最大表示金币个数
	gold_column_ani_src_id 		= 65,--金币柱上的金币旋转特效资源
	energy_connon_act_id  		= 18,--能量炮图标动作id
	lock_fish_mark_act_id 		= 7,--锁定鱼图标动作id
	cut_scene_fish_vx 			= 20,--切换场景时鱼游动速度倍率
	spot_light_pos				= {x = 960,y = 640,z = 1000,},--光源位置
	fish_shadow_alpha			= 100,--鱼阴影透明值
	fish_light_distance			= 60,--鱼距池底距离

	selfbat_enter_ani_id		= 94,--自己炮台进入的动画
	otherbat_enter_ani_id		= 95,--别人炮台进入的动画
	selfbat_hit_ani_id			= 93,--自己炮台位置提示动画

	lock_ctrl_pos				= {x = 1000,y = 80,}, --锁定按钮位置
}
