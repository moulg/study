--[[
	游戏配置
]]
game_config = {

--			序号  	游戏名					游戏资源包信息																初始化文件入口									游戏入口函数
	-- [1] = {	id = 1,	name = "斗地主比赛",	pkg_lst = {[1] = {pkg_file = "ddz_match_std.pkg",dec_fext = ".*"},},		init_file = "game.ddz_match_std._init_ddz_match_std", play_state = 1},
	 [2] = {	id = 2,	name = "二人牛牛",		pkg_lst = {[1] = {pkg_file = "niuniu_std.pkg",dec_fext = ".*"},},	init_file = "game.niuniu_std._init_niuniu_std",	play_state = 1,},
	 [3] = {	id = 3,	name = "水浒传",		pkg_lst = {[1] = {pkg_file = "shuihu_std.pkg",dec_fext = ".*",},},	init_file = "game.shuihu_std._init_shuihu_std",	play_state = 1,},
	 [4] = {	id = 4,	name = "汽车4S店",		pkg_lst = {[1] = {pkg_file = "4s_std.pkg",dec_fext = ".*",},},		init_file = "game.4s_std._init_4s_std",			play_state = 1,},
	 [5] = {	id = 5,	name = "德州扑克",		pkg_lst = {[1] = {pkg_file = "texaspoker_std.pkg",dec_fext = ".*",},},init_file = "game.texaspoker_std._init_texaspoker_std", play_state = 1,},
	-- [6] = {	id = 6,	name = "欢乐五张",		pkg_lst = {[1] = {pkg_file = "joyfive_std.pkg",dec_fext = ".*",},},init_file = "game.joyfive_std._init_joyfive_std", play_state = 1,},
	-- [7] = {	id = 7,	name = "百人牛牛",		pkg_lst = {[1] = {pkg_file = "bairenniuniu_std.pkg",dec_fext = ".*",},},init_file = "game.bairenniuniu_std._init_bairenniuniu_std", play_state = 1,},
	-- [8] = {	id = 8,	name = "大闹天宫",		pkg_lst = {[1] = {pkg_file = "texaspoker_std.pkg",dec_fext = ".*",},},init_file = "game.texaspoker_std._init_texaspoker_std", play_state = 1,},
	 [9] = {	id = 9,	name = "金蟾捕鱼",		pkg_lst = {[1] = {pkg_file = "jcby.pkg",dec_fext = ".*",},},init_file = "game.jinchanbuyu.__init_jinchanbuyu", play_state = 1,},
	 [10] = {	id = 10, name = "金鲨银鲨",		pkg_lst = {[1] = {pkg_file = "shark_std.pkg",dec_fext = ".*",},},init_file = "game.shark_std._init_shark_std", play_state = 1,},
	 --[11] = {	id = 11, name = "空中打击",		pkg_lst = {[1] = {pkg_file = "texaspoker_std.pkg",dec_fext = ".*",},},init_file = "game.texaspoker_std._init_texaspoker_std", play_state = 1,},
	 --[12] = {	id = 12, name = "李逵劈鱼",		pkg_lst = {[1] = {pkg_file = "likuipiyu.pkg",dec_fext = ".*",},},init_file = "game.likuipiyu._init_lkpy", play_state = 1,},
	 [13] = {	id = 13, name = "四人牛牛",		pkg_lst = {[1] = {pkg_file = "foursniuniu_std.pkg",dec_fext = ".*",},},init_file = "game.foursniuniu_std._init_four_niuniu_std", play_state = 1,},
	 [14] = {	id = 14, name = "通比牛牛",		pkg_lst = {[1] = {pkg_file = "tongbiniuniu_std.pkg",dec_fext = ".*",},},init_file = "game.tongbiniuniu_std._init_tongbiniuniu_std", play_state = 1,},
	 [15] = {	id = 15, name = "二人德州",		pkg_lst = {[1] = {pkg_file = "errentexaspoker_std.pkg",dec_fext = ".*",},},init_file = "game.errentexaspoker_std._init_errentexaspoker_std",play_state = 1,},
	 [16] = {	id = 16, name = "乌龟快跑",		pkg_lst = {[1] = {pkg_file = "horserace_std.pkg",dec_fext = ".*",},},init_file = "game.horserace_std._init_horserace_std",play_state = 1,},
	[17] = {	id = 17, name = "炸金花",		pkg_lst = {[1] = {pkg_file = "goldflower_std.pkg",dec_fext = ".*",},},init_file = "game.goldflower_std._init_goldflower_std",play_state = 1,},
	-- [18] = {	id = 18, name = "百家乐",		pkg_lst = {[1] = {pkg_file = "baccarat_std.pkg",dec_fext = ".*",},},init_file = "game.baccarat_std._init_baccarat_std",play_state = 1,},
	 [20] = {	id = 20, name = "魏蜀吴",		pkg_lst = {[1] = {pkg_file = "weishuwu_std.pkg",dec_fext = ".*",},},init_file = "game.weishuwu_std._init_weishuwu_std",play_state = 1,},
}


--图标配置
game_icon_config = {

--			序号  	游戏名					大图标信息																游戏名
	[1] = {	id = 1,	name = "斗地主比赛",big_icon = {src = "lobby/resource/icon/big/bsddz.png",w = 412,h = 427,},  gameNameRes = "lobby/resource/icon/name/bsddz.png"},
	[2] = {	id = 2,	name = "二人牛牛",	big_icon = {src = "lobby/resource/icon/big/errnn.png",w = 412,h = 427,},  gameNameRes = "lobby/resource/icon/name/errnn.png"},
	[3] = {	id = 3,	name = "水浒传",	big_icon = {src = "lobby/resource/icon/big/shz.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/shz.png"},
	[4] = {	id = 4,	name = "汽车4S店",	big_icon = {src = "lobby/resource/icon/big/qc4sd.png",w = 412,h = 427,},  gameNameRes = "lobby/resource/icon/name/qc4sd.png"},
	[5] = {	id = 5,	name = "德州扑克",	big_icon = {src = "lobby/resource/icon/big/dzpk.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/dzpk.png"},
	[6] = {	id = 6, name = "欢乐五张",	big_icon = {src = "lobby/resource/icon/big/hlwz.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/hlwz.png"},
	[7] = {	id = 7,	name = "百人牛牛",	big_icon = {src = "lobby/resource/icon/big/brnn.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/crnn.png"},
	[8] = {	id = 8,	name = "大闹天宫",	big_icon = {src = "lobby/resource/icon/big/dntg.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/dntg.png"},
	[9] = {	id = 9,	name = "金蟾捕鱼",	big_icon = {src = "lobby/resource/icon/big/jcby.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/jcby.png"},
	[10] = {id = 10,name = "金鲨银鲨",	big_icon = {src = "lobby/resource/icon/big/jsys.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/jsys.png"},
	[11] = {id = 11,name = "空中打击",	big_icon = {src = "lobby/resource/icon/big/kzdj.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/kzdj.png"},
	[12] = {id = 12,name = "李逵劈鱼",	big_icon = {src = "lobby/resource/icon/big/lkpy.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/lkby.png"},
	[13] = {id = 13,name = "四人牛牛",	big_icon = {src = "lobby/resource/icon/big/srnn.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/srnn.png"},
	[14] = {id = 14,name = "通比牛牛",	big_icon = {src = "lobby/resource/icon/big/tbnn.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/tbnn.png"},
	[15] = {id = 15,name = "二人德州",	big_icon = {src = "lobby/resource/icon/big/errdz.png",w = 412,h = 427,},  gameNameRes = "lobby/resource/icon/name/errdz.png"},
	[16] = {id = 16,name = "乌龟快跑",	big_icon = {src = "lobby/resource/icon/big/wgkp.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/wgkp.png"},
	[17] = {id = 17,name = "炸金花",	big_icon = {src = "lobby/resource/icon/big/zjh.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/zjh.png"},
	[18] = {id = 18,name = "百家乐",	big_icon = {src = "lobby/resource/icon/big/bjl.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/bjl.png"},
	[20] = {id = 20,name = "魏蜀吴",	big_icon = {src = "lobby/resource/icon/big/wsw.png",w = 412,h = 427,},	  gameNameRes = "lobby/resource/icon/name/wsw.png"},
}


--游戏说明网址
game_rule_config = {
	--[1] = {id = 1,	name = "斗地主比赛",    address = "http://www.388r.com/page/doudizhu.html"},         -- 棋牌
	[2] = {id = 2,	name = "二人牛牛",	address = "http://www.388r.com/page/errenniuniu.html"},    -- 棋牌
	[3] = {id = 3,	name = "水浒传",	address = "http://www.388r.com/page/shuihu.html"},         -- 电玩
	[4] = {id = 4,	name = "汽车4S店",	address = "http://www.388r.com/page/foursshop.html"},      -- 街机
	[5] = {id = 5,	name = "德州扑克",	address = "http://www.388r.com/page/texaporker.html"},     -- 棋牌
	[6] = {id = 6,	name = "欢乐五张",	address = "http://www.388r.com/page/huanlewuzhang.html"},  -- 棋牌
    [7] = {id = 7,	name = "百人牛牛",	address = "http://www.388r.com/page/bairenniuniu.html"},   -- 棋牌
    [8] = {id = 8,	name = "大闹天宫",	address = "http://www.388r.com/page/category.html"},       -- 电玩
    [9] = {id = 9,	name = "金蟾捕鱼",	address = "http://www.388r.com/page/category/game"},       -- 捕鱼
    [10] = { id = 10,name = "金鲨银鲨",	address = "http://www.388r.com/page/jinshayinshayouxiguize.html"},  -- 街机
    [11] = { id = 11,name = "空中打击",	address = "http://www.388r.com/news/"},                 -- 电玩
    [12] = { id = 12,name = "李逵劈鱼",	address = "http://www.388r.com/news/"},                        -- 捕鱼
    [13] = { id = 13,name = "四人牛牛",	address = "http://www.388r.com/page/sirenniuniu.html.html"},   -- 棋牌
    [14] = { id = 14,name = "通比牛牛",	address = "http://www.388r.com/page/tongbiniuniu.html"},       -- 棋牌
    [15] = { id = 15,name = "二人德州",	address = "http://www.388r.com/news/"},                        -- 棋牌
    [16] = { id = 16,name = "乌龟快跑",	address = "http://www.388r.com/news/"},                        -- 街机
    [17] = { id = 17,name = "炸金花",	address = "http://www.388r.com/page/zhajinhua.html"},   -- 棋牌
    [18] = { id = 18,name = "百家乐",	address = "http://www.388r.com/page/zhajinhua.html"},   -- 棋牌
    [20] = { id = 20,name = "魏蜀吴",	address = "http://www.388r.com/page/weishuwu.html"},    -- 电玩
}

--游戏兑换面板
exchange_class_config = {
	[1] = {	id = 1,	name = "斗地主比赛",className = ""}, 
	[2] = {	id = 2,	name = "二人牛牛",	className = "game.niuniu_std.script.ui_create.ui_niuniu_exchange"}, 
	[3] = {	id = 3,	name = "水浒传",	className = "game.shuihu_std.script.ui_create.ui_shuihu_exchange"}, 
	[4] = {	id = 4,	name = "汽车4S店",	className = "game.4s_std.script.ui_create.ui_4s_exchange"}, 
	[5] = {	id = 5,	name = "德州扑克",	className = "game.texaspoker_std.script.ui_create.ui_texaspoker_exchange"}, 
	[6] = {	id = 6,	name = "欢乐五张",	className = ""}, 
    [7] = {	id = 7,	name = "百人牛牛",	className = "game.bairenniuniu_std.script.ui_create.ui_bairenniuniu_betDuih"}, 
    [8] = {	id = 8,	name = "大闹天宫",	className = ""}, 
    [9] = {	id = 9,	name = "金蟾捕鱼",	className = ""}, 
    [10] = { id = 10,name = "金鲨银鲨",	className = "game.shark_std.script.ui_create.ui_shark_exchange"}, 
    [11] = { id = 11,name = "空中打击",	className = ""}, 
    [13] = { id = 13,name = "四人牛牛",	className = "game.foursniuniu_std.script.ui_create.ui_fourniuniu_exchange"}, 
    [12] = { id = 12,name = "李逵劈鱼",	className = ""}, 
    [14] = { id = 14,name = "通比牛牛",	className = "game.tongbiniuniu_std.script.ui_create.ui_tongbiniuniu_exchange"}, 
    [15] = { id = 15,name = "二人德州",	className = "game.errentexaspoker_std.script.ui_create.ui_errentexaspoker_exchange"}, 
    [16] = { id = 16,name = "乌龟快跑",	className = "game.horserace_std.script.ui_create.ui_horserace_betDuih"}, 
    [17] = { id = 17,name = "炸金花",	className = "game.goldflower_std.script.ui_create.ui_goldflower_exchange"},
    [18] = { id = 18,name = "百家乐",	className = "game.baccarat_std.script.ui_create.ui_baccarat_exchange"},
    [20] = { id = 20,name = "魏蜀吴",	className = "game.weishuwu_std.script.ui_create.ui_weishuwu_duihuan"},
}
