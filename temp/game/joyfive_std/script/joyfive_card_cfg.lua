
--牌类型
joyfive_card_type = {
	FANG_KUAI 	= 0, --方块
	MEI_HUA 	= 1, --梅花
	HONG_TAO 	= 3, --红桃
	HEI_TAO 	= 4, --黑桃
}

joyfive_card_data = {
		--方块 A - K ; 0 - 12
		[0] = {name = "方块 A",power = 14, type = joyfive_card_type.FANG_KUAI,card_big = "FK_1.png", card_sm = "SFK_1.png",},
		[1] = {name = "方块 2",	power = 2,	type = joyfive_card_type.FANG_KUAI,card_big = "FK_2.png", card_sm = "SFK_2.png",},
		[2] = {name = "方块 3",	power = 3,	type = joyfive_card_type.FANG_KUAI,card_big = "FK_3.png", card_sm = "SFK_3.png",},
		[3] = {name = "方块 4",	power = 4,	type = joyfive_card_type.FANG_KUAI,card_big = "FK_4.png", card_sm = "SFK_4.png",},
		[4] = {name = "方块 5",	power = 5,	type = joyfive_card_type.FANG_KUAI,card_big = "FK_5.png", card_sm = "SFK_5.png",},
		[5] = {name = "方块 6",	power = 6,	type = joyfive_card_type.FANG_KUAI,card_big = "FK_6.png", card_sm = "SFK_6.png",},
		[6] = {name = "方块 7",	power = 7,	type = joyfive_card_type.FANG_KUAI,card_big = "FK_7.png", card_sm = "SFK_7.png",},
		[7] = {name = "方块 8",	power = 8,	type = joyfive_card_type.FANG_KUAI,card_big = "FK_8.png", card_sm = "SFK_8.png",},
		[8] = {name = "方块 9",	power = 9,	type = joyfive_card_type.FANG_KUAI,card_big = "FK_9.png", card_sm = "SFK_9.png",},
		[9] = {name = "方块 10",power = 10,	type = joyfive_card_type.FANG_KUAI,card_big = "FK_10.png", card_sm = "SFK_10.png",},
		[10] = {name = "方块 J",power = 11,	type = joyfive_card_type.FANG_KUAI,card_big = "FK_J.png", card_sm = "SFK_J.png",},
		[11] = {name = "方块 Q",power = 12,	type = joyfive_card_type.FANG_KUAI,card_big = "FK_Q.png", card_sm = "SFK_Q.png",},
		[12] = {name = "方块 K",power = 13,	type = joyfive_card_type.FANG_KUAI,card_big = "FK_K.png", card_sm = "SFK_K.png",},


		--梅花 A - K ; 13 - 25
		[13] = {name = "梅花 A",	power = 14,	type = joyfive_card_type.MEI_HUA,card_big = "MH_1.png", card_sm = "SMH_1.png",},
		[14] = {name = "梅花 2",	power = 2,	type = joyfive_card_type.MEI_HUA,card_big = "MH_2.png", card_sm = "SMH_2.png",},
		[15] = {name = "梅花 3",	power = 3,	type = joyfive_card_type.MEI_HUA,card_big = "MH_3.png", card_sm = "SMH_3.png",},
		[16] = {name = "梅花 4",	power = 4,	type = joyfive_card_type.MEI_HUA,card_big = "MH_4.png", card_sm = "SMH_4.png",},
		[17] = {name = "梅花 5",	power = 5,	type = joyfive_card_type.MEI_HUA,card_big = "MH_5.png", card_sm = "SMH_5.png",},
		[18] = {name = "梅花 6",	power = 6,	type = joyfive_card_type.MEI_HUA,card_big = "MH_6.png", card_sm = "SMH_6.png",},
		[19] = {name = "梅花 7",	power = 7,	type = joyfive_card_type.MEI_HUA,card_big = "MH_7.png", card_sm = "SMH_7.png",},
		[20] = {name = "梅花 8",	power = 8,	type = joyfive_card_type.MEI_HUA,card_big = "MH_8.png", card_sm = "SMH_8.png",},
		[21] = {name = "梅花 9",	power = 9,	type = joyfive_card_type.MEI_HUA,card_big = "MH_9.png", card_sm = "SMH_9.png",},
		[22] = {name = "梅花 10",	power = 10,	type = joyfive_card_type.MEI_HUA,card_big = "MH_10.png", card_sm = "SMH_10.png",},
		[23] = {name = "梅花 J",	power = 11,	type = joyfive_card_type.MEI_HUA,card_big = "MH_J.png", card_sm = "SMH_J.png",},
		[24] = {name = "梅花 Q",	power = 12,	type = joyfive_card_type.MEI_HUA,card_big = "MH_Q.png", card_sm = "SMH_Q.png",},
		[25] = {name = "梅花 K",	power = 13,	type = joyfive_card_type.MEI_HUA,card_big = "MH_K.png", card_sm = "SMH_K.png",},

		--红桃 A - K ; 26 - 38
		[26] = {name = "红桃 A",	power = 14,	type = joyfive_card_type.HONG_TAO,card_big = "HTAO_1.png", card_sm = "SHTAO_1.png",},
		[27] = {name = "红桃 2",	power = 2,	type = joyfive_card_type.HONG_TAO,card_big = "HTAO_2.png", card_sm = "SHTAO_2.png",},
		[28] = {name = "红桃 3",	power = 3,	type = joyfive_card_type.HONG_TAO,card_big = "HTAO_3.png", card_sm = "SHTAO_3.png",},
		[29] = {name = "红桃 4",	power = 4,	type = joyfive_card_type.HONG_TAO,card_big = "HTAO_4.png", card_sm = "SHTAO_4.png",},
		[30] = {name = "红桃 5",	power = 5,	type = joyfive_card_type.HONG_TAO,card_big = "HTAO_5.png", card_sm = "SHTAO_5.png",},
		[31] = {name = "红桃 6",	power = 6,	type = joyfive_card_type.HONG_TAO,card_big = "HTAO_6.png", card_sm = "SHTAO_6.png",},
		[32] = {name = "红桃 7",	power = 7,	type = joyfive_card_type.HONG_TAO,card_big = "HTAO_7.png", card_sm = "SHTAO_7.png",},
		[33] = {name = "红桃 8",	power = 8,	type = joyfive_card_type.HONG_TAO,card_big = "HTAO_8.png", card_sm = "SHTAO_8.png",},
		[34] = {name = "红桃 9",	power = 9,	type = joyfive_card_type.HONG_TAO,card_big = "HTAO_9.png", card_sm = "SHTAO_9.png",},
		[35] = {name = "红桃 10",	power = 10,	type = joyfive_card_type.HONG_TAO,card_big = "HTAO_10.png", card_sm = "SHTAO_10.png",},
		[36] = {name = "红桃 J",	power = 11,	type = joyfive_card_type.HONG_TAO,card_big = "HTAO_J.png", card_sm = "SHTAO_J.png",},
		[37] = {name = "红桃 Q",	power = 12,	type = joyfive_card_type.HONG_TAO,card_big = "HTAO_Q.png", card_sm = "SHTAO_Q.png",},
		[38] = {name = "红桃 K",	power = 13,	type = joyfive_card_type.HONG_TAO,card_big = "HTAO_K.png", card_sm = "SHTAO_K.png",},

		--黑桃 A - K ; 39 - 51
		[39] = {name = "黑桃 A",	power = 14,	type = joyfive_card_type.HEI_TAO,card_big = "HT_1.png", card_sm = "SHT_1.png",},
		[40] = {name = "黑桃 2",	power = 2,	type = joyfive_card_type.HEI_TAO,card_big = "HT_2.png", card_sm = "SHT_2.png",},
		[41] = {name = "黑桃 3",	power = 3,	type = joyfive_card_type.HEI_TAO,card_big = "HT_3.png", card_sm = "SHT_3.png",},
		[42] = {name = "黑桃 4",	power = 4,	type = joyfive_card_type.HEI_TAO,card_big = "HT_4.png", card_sm = "SHT_4.png",},
		[43] = {name = "黑桃 5",	power = 5,	type = joyfive_card_type.HEI_TAO,card_big = "HT_5.png", card_sm = "SHT_5.png",},
		[44] = {name = "黑桃 6",	power = 6,	type = joyfive_card_type.HEI_TAO,card_big = "HT_6.png", card_sm = "SHT_6.png",},
		[45] = {name = "黑桃 7",	power = 7,	type = joyfive_card_type.HEI_TAO,card_big = "HT_7.png", card_sm = "SHT_7.png",},
		[46] = {name = "黑桃 8",	power = 8,	type = joyfive_card_type.HEI_TAO,card_big = "HT_8.png", card_sm = "SHT_8.png",},
		[47] = {name = "黑桃 9",	power = 9,	type = joyfive_card_type.HEI_TAO,card_big = "HT_9.png", card_sm = "SHT_9.png",},
		[48] = {name = "黑桃 10",	power = 10,	type = joyfive_card_type.HEI_TAO,card_big = "HT_10.png", card_sm = "SHT_10.png",},
		[49] = {name = "黑桃 J",	power = 11,	type = joyfive_card_type.HEI_TAO,card_big = "HT_J.png", card_sm = "SHT_J.png",},
		[50] = {name = "黑桃 Q",	power = 12,	type = joyfive_card_type.HEI_TAO,card_big = "HT_Q.png", card_sm = "SHT_Q.png",},
		[51] = {name = "黑桃 K",	power = 13,	type = joyfive_card_type.HEI_TAO,card_big = "HT_K.png", card_sm = "SHT_K.png",},

		[52] = {name = "背景", card_big = "BM.png", card_sm = "SBM.png",},
}
