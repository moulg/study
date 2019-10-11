
--牌类型
ddzMatch_card_type = {
	FANG_KUAI 	= 0, --方块
	MEI_HUA 	= 1, --梅花
	HONG_TAO 	= 3, --红桃
	HEI_TAO 	= 4, --黑桃
	XIAO_WANG	= 5, --小王
	DA_WANG		= 6, --大王
}

ddzMatch_card_data = {
		--方块 A - K ; 0 - 12
		[0] = {name = "方块 A",	power = 14,	type = ddzMatch_card_type.FANG_KUAI,card_big = "FKA.png", card_sm = "FKAs.png", card_mini = "cardxiao_01.png",},
		[1] = {name = "方块 2",	power = 15,	type = ddzMatch_card_type.FANG_KUAI,card_big = "FK2.png", card_sm = "FK2s.png", card_mini = "cardxiao_02.png",},
		[2] = {name = "方块 3",	power = 3,	type = ddzMatch_card_type.FANG_KUAI,card_big = "FK3.png", card_sm = "FK3s.png", card_mini = "cardxiao_03.png",},
		[3] = {name = "方块 4",	power = 4,	type = ddzMatch_card_type.FANG_KUAI,card_big = "FK4.png", card_sm = "FK4s.png", card_mini = "cardxiao_04.png",},
		[4] = {name = "方块 5",	power = 5,	type = ddzMatch_card_type.FANG_KUAI,card_big = "FK5.png", card_sm = "FK5s.png", card_mini = "cardxiao_05.png",},
		[5] = {name = "方块 6",	power = 6,	type = ddzMatch_card_type.FANG_KUAI,card_big = "FK6.png", card_sm = "FK6s.png", card_mini = "cardxiao_06.png",},
		[6] = {name = "方块 7",	power = 7,	type = ddzMatch_card_type.FANG_KUAI,card_big = "FK7.png", card_sm = "FK7s.png", card_mini = "cardxiao_07.png",},
		[7] = {name = "方块 8",	power = 8,	type = ddzMatch_card_type.FANG_KUAI,card_big = "FK8.png", card_sm = "FK8s.png", card_mini = "cardxiao_08.png",},
		[8] = {name = "方块 9",	power = 9,	type = ddzMatch_card_type.FANG_KUAI,card_big = "FK9.png", card_sm = "FK9s.png", card_mini = "cardxiao_09.png",},
		[9] = {name = "方块 10",power = 10,	type = ddzMatch_card_type.FANG_KUAI,card_big = "FK10.png", card_sm = "FK10s.png", card_mini = "cardxiao_10.png",},
		[10] = {name = "方块 J",power = 11,	type = ddzMatch_card_type.FANG_KUAI,card_big = "FKJ.png", card_sm = "FKJs.png", card_mini = "cardxiao_11.png",},
		[11] = {name = "方块 Q",power = 12,	type = ddzMatch_card_type.FANG_KUAI,card_big = "FKQ.png", card_sm = "FKQs.png", card_mini = "cardxiao_12.png",},
		[12] = {name = "方块 K",power = 13,	type = ddzMatch_card_type.FANG_KUAI,card_big = "FKK.png", card_sm = "FKKs.png", card_mini = "cardxiao_13.png",},


		--梅花 A - K ; 13 - 25
		[13] = {name = "梅花 A",	power = 14,	type = ddzMatch_card_type.MEI_HUA,card_big = "MHA.png", card_sm = "MHAs.png", card_mini = "cardxiao_14.png",},
		[14] = {name = "梅花 2",	power = 15,	type = ddzMatch_card_type.MEI_HUA,card_big = "MH2.png", card_sm = "MH2s.png", card_mini = "cardxiao_15.png",},
		[15] = {name = "梅花 3",	power = 3,	type = ddzMatch_card_type.MEI_HUA,card_big = "MH3.png", card_sm = "MH3s.png", card_mini = "cardxiao_16.png",},
		[16] = {name = "梅花 4",	power = 4,	type = ddzMatch_card_type.MEI_HUA,card_big = "MH4.png", card_sm = "MH4s.png", card_mini = "cardxiao_17.png",},
		[17] = {name = "梅花 5",	power = 5,	type = ddzMatch_card_type.MEI_HUA,card_big = "MH5.png", card_sm = "MH5s.png", card_mini = "cardxiao_18.png",},
		[18] = {name = "梅花 6",	power = 6,	type = ddzMatch_card_type.MEI_HUA,card_big = "MH6.png", card_sm = "MH6s.png", card_mini = "cardxiao_19.png",},
		[19] = {name = "梅花 7",	power = 7,	type = ddzMatch_card_type.MEI_HUA,card_big = "MH7.png", card_sm = "MH7s.png", card_mini = "cardxiao_20.png",},
		[20] = {name = "梅花 8",	power = 8,	type = ddzMatch_card_type.MEI_HUA,card_big = "MH8.png", card_sm = "MH8s.png", card_mini = "cardxiao_21.png",},
		[21] = {name = "梅花 9",	power = 9,	type = ddzMatch_card_type.MEI_HUA,card_big = "MH9.png", card_sm = "MH9s.png", card_mini = "cardxiao_22.png",},
		[22] = {name = "梅花 10",	power = 10,	type = ddzMatch_card_type.MEI_HUA,card_big = "MH10.png", card_sm = "MH10s.png", card_mini = "cardxiao_23.png",},
		[23] = {name = "梅花 J",	power = 11,	type = ddzMatch_card_type.MEI_HUA,card_big = "MHJ.png", card_sm = "MHJs.png", card_mini = "cardxiao_24.png",},
		[24] = {name = "梅花 Q",	power = 12,	type = ddzMatch_card_type.MEI_HUA,card_big = "MHQ.png", card_sm = "MHQs.png", card_mini = "cardxiao_25.png",},
		[25] = {name = "梅花 K",	power = 13,	type = ddzMatch_card_type.MEI_HUA,card_big = "MHK.png", card_sm = "MHKs.png", card_mini = "cardxiao_26.png",},

		--红桃 A - K ; 26 - 38
		[26] = {name = "红桃 A",	power = 14, type = ddzMatch_card_type.HONG_TAO,card_big = "RHA.png", card_sm = "RHAs.png", card_mini = "cardxiao_27.png",},
		[27] = {name = "红桃 2",	power = 15, type = ddzMatch_card_type.HONG_TAO,card_big = "RH2.png", card_sm = "RH2s.png", card_mini = "cardxiao_28.png",},
		[28] = {name = "红桃 3",	power = 3, type = ddzMatch_card_type.HONG_TAO,card_big = "RH3.png", card_sm = "RH3s.png", card_mini = "cardxiao_29.png",},
		[29] = {name = "红桃 4",	power = 4, type = ddzMatch_card_type.HONG_TAO,card_big = "RH4.png", card_sm = "RH4s.png", card_mini = "cardxiao_30.png",},
		[30] = {name = "红桃 5",	power = 5, type = ddzMatch_card_type.HONG_TAO,card_big = "RH5.png", card_sm = "RH5s.png", card_mini = "cardxiao_31.png",},
		[31] = {name = "红桃 6",	power = 6, type = ddzMatch_card_type.HONG_TAO,card_big = "RH6.png", card_sm = "RH6s.png", card_mini = "cardxiao_32.png",},
		[32] = {name = "红桃 7",	power = 7, type = ddzMatch_card_type.HONG_TAO,card_big = "RH7.png", card_sm = "RH7s.png", card_mini = "cardxiao_33.png",},
		[33] = {name = "红桃 8",	power = 8, type = ddzMatch_card_type.HONG_TAO,card_big = "RH8.png", card_sm = "RH8s.png", card_mini = "cardxiao_34.png",},
		[34] = {name = "红桃 9",	power = 9, type = ddzMatch_card_type.HONG_TAO,card_big = "RH9.png", card_sm = "RH9s.png", card_mini = "cardxiao_35.png",},
		[35] = {name = "红桃 10",	power = 10, type = ddzMatch_card_type.HONG_TAO,card_big = "RH10.png", card_sm = "RH10s.png", card_mini = "cardxiao_36.png",},
		[36] = {name = "红桃 J",	power = 11, type = ddzMatch_card_type.HONG_TAO,card_big = "RHJ.png", card_sm = "RHJs.png", card_mini = "cardxiao_37.png",},
		[37] = {name = "红桃 Q",	power = 12, type = ddzMatch_card_type.HONG_TAO,card_big = "RHQ.png", card_sm = "RHQs.png", card_mini = "cardxiao_38.png",},
		[38] = {name = "红桃 K",	power = 13, type = ddzMatch_card_type.HONG_TAO,card_big = "RHK.png", card_sm = "RHKs.png", card_mini = "cardxiao_39.png",},

		--黑桃 A - K ; 39 - 51
		[39] = {name = "黑桃 A",	power = 14, type = ddzMatch_card_type.HEI_TAO,card_big = "HTA.png", card_sm = "HTAs.png", card_mini = "cardxiao_40.png",},
		[40] = {name = "黑桃 2",	power = 15, type = ddzMatch_card_type.HEI_TAO,card_big = "HT2.png", card_sm = "HT2s.png", card_mini = "cardxiao_41.png",},
		[41] = {name = "黑桃 3",	power = 3, type = ddzMatch_card_type.HEI_TAO,card_big = "HT3.png", card_sm = "HT3s.png", card_mini = "cardxiao_42.png",},
		[42] = {name = "黑桃 4",	power = 4, type = ddzMatch_card_type.HEI_TAO,card_big = "HT4.png", card_sm = "HT4s.png", card_mini = "cardxiao_43.png",},
		[43] = {name = "黑桃 5",	power = 5, type = ddzMatch_card_type.HEI_TAO,card_big = "HT5.png", card_sm = "HT5s.png", card_mini = "cardxiao_44.png",},
		[44] = {name = "黑桃 6",	power = 6, type = ddzMatch_card_type.HEI_TAO,card_big = "HT6.png", card_sm = "HT6s.png", card_mini = "cardxiao_45.png",},
		[45] = {name = "黑桃 7",	power = 7, type = ddzMatch_card_type.HEI_TAO,card_big = "HT7.png", card_sm = "HT7s.png", card_mini = "cardxiao_46.png",},
		[46] = {name = "黑桃 8",	power = 8,	type = ddzMatch_card_type.HEI_TAO,card_big = "HT8.png", card_sm = "HT8s.png", card_mini = "cardxiao_47.png",},
		[47] = {name = "黑桃 9",	power = 9,	type = ddzMatch_card_type.HEI_TAO,card_big = "HT9.png", card_sm = "HT9s.png", card_mini = "cardxiao_48.png",},
		[48] = {name = "黑桃 10",	power = 10,	type = ddzMatch_card_type.HEI_TAO,card_big = "HT10.png", card_sm = "HT10s.png", card_mini = "cardxiao_49.png",},
		[49] = {name = "黑桃 J",	power = 11,	type = ddzMatch_card_type.HEI_TAO,card_big = "HTJ.png", card_sm = "HTJs.png", card_mini = "cardxiao_50.png",},
		[50] = {name = "黑桃 Q",	power = 12,	type = ddzMatch_card_type.HEI_TAO,card_big = "HTQ.png", card_sm = "HTQs.png", card_mini = "cardxiao_51.png",},
		[51] = {name = "黑桃 K",	power = 13,	type = ddzMatch_card_type.HEI_TAO,card_big = "HTK.png", card_sm = "HTKs.png", card_mini = "cardxiao_52.png",},

		--大小王
		[52] = {name = "小王",	power = 16,	type = ddzMatch_card_type.XIAO_WANG,card_big = "J2.png", card_sm = "J2s.png", card_mini = "cardxiao_53.png",},
		[53] = {name = "大王",	power = 17,	type = ddzMatch_card_type.DA_WANG,card_big = "J1.png", card_sm = "J1s.png", card_mini = "cardxiao_54.png",},

		[54] = {name = "背景", card_big = "dp.png", card_sm = "dps.png", card_mini = "cardxiao_55.png",},

}
