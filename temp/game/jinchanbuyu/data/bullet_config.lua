

--[[
	子弹配置
	id,子弹id
	act_v,子弹发运动速度
	bonding_box = {--包围盒
		[1] = {--一个圆
			a,b,r：圆心坐标，半径
		},
	}

	src_key,子弹资源
	my_fnet_id,为自己炮台时鱼网资源id
	oth_net_id,为其它人炮台时鱼网资源id
	desc,描述信息
]]
bullet_config = {
	[1] = {id = 1,desc = "单管，黄",act_v = 900,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet1_1.png",my_fnet_id = 1,oth_net_id = 5,},
	[2] = {id = 2,desc = "双管，黄",act_v = 1000,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet1_2.png",my_fnet_id = 2,oth_net_id = 6,},
	[3] = {id = 3,desc = "三管，黄",act_v = 1200,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet1_3.png",my_fnet_id = 3,oth_net_id = 7,},

	[4] = {id = 4,desc = "单管，橘",act_v = 900,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet2_1.png",my_fnet_id = 1,oth_net_id = 5,},
	[5] = {id = 5,desc = "双管，橘",act_v = 1000,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet2_2.png",my_fnet_id = 2,oth_net_id = 6,},
	[6] = {id = 6,desc = "三管，橘",act_v = 1200,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet2_3.png",my_fnet_id = 3,oth_net_id = 7,},

	[7]  = {id = 7, desc = "单管，橘黄",act_v = 900,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet3_1.png",my_fnet_id = 1,oth_net_id = 5,},
	[8]  = {id = 8, desc = "双管，橘黄",act_v = 1000,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet3_2.png",my_fnet_id = 2,oth_net_id = 6,},
	[9]  = {id = 9, desc = "三管，橘黄",act_v = 1200,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet3_3.png",my_fnet_id = 3,oth_net_id = 7,},

	[10] = {id = 10,desc = "单管，绿",act_v = 900,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet4_1.png",my_fnet_id = 1,oth_net_id = 5,},
	[11] = {id = 11,desc = "双管，绿",act_v = 1000,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet4_2.png",my_fnet_id = 2,oth_net_id = 6,},
	[12] = {id = 12,desc = "三管，绿",act_v = 1200,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet4_3.png",my_fnet_id = 3,oth_net_id = 7,},

	[13] = {id = 13,desc = "单管，红",act_v = 900,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet5_1.png",my_fnet_id = 1,oth_net_id = 5,},
	[14] = {id = 14,desc = "双管，红",act_v = 1000,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet5_2.png",my_fnet_id = 2,oth_net_id = 6,},
	[15] = {id = 15,desc = "三管，红",act_v = 1200,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet5_3.png",my_fnet_id = 3,oth_net_id = 7,},

	[16] = {id = 16,desc = "单管，蓝",act_v = 900,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet6_1.png",my_fnet_id = 1,oth_net_id = 5,},
	[17] = {id = 17,desc = "双管，蓝",act_v = 1000,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet6_2.png",my_fnet_id = 2,oth_net_id = 6,},
	[18] = {id = 18,desc = "三管，蓝",act_v = 1200,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet6_3.png",my_fnet_id = 3,oth_net_id = 7,},

	[19] = {id = 19,desc = "单管，浅蓝",act_v = 900,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet7_1.png",my_fnet_id = 1,oth_net_id = 5,},
	[20] = {id = 20,desc = "双管，浅蓝",act_v = 1000,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet7_2.png",my_fnet_id = 2,oth_net_id = 6,},
	[21] = {id = 21,desc = "三管，浅蓝",act_v = 1200,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet7_3.png",my_fnet_id = 3,oth_net_id = 7,},

	[22] = {id = 22,desc = "单管，紫",act_v = 900,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet8_1.png",my_fnet_id = 1,oth_net_id = 5,},
	[23] = {id = 23,desc = "双管，紫",act_v = 1000,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet8_2.png",my_fnet_id = 2,oth_net_id = 6,},
	[24] = {id = 24,desc = "三管，紫",act_v = 1200,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet8_3.png",my_fnet_id = 3,oth_net_id = 7,},

	[25] = {id = 25,desc = "单管，能量",act_v = 900,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet9_1.png",my_fnet_id = 1,oth_net_id = 5,},
	[26] = {id = 26,desc = "双管，能量",act_v = 1000,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet9_2.png",my_fnet_id = 2,oth_net_id = 6,},
	[27] = {id = 27,desc = "三管，能量",act_v = 1200,bonding_box = {[1]={a=0,b=0,r=16,}, },src_key = "bullet9_3.png",my_fnet_id = 3,oth_net_id = 7,},
}