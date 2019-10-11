#remark

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

--[[
	GameType ={
		名称:type 类型:int 备注:游戏类型(0:我的游戏;1:扑克厅;2:麻将厅;3:街机厅;4:比赛厅;5:休闲厅;6:所有游戏;7:推荐游戏)
		名称:index 类型:int 备注:位置索引
		名称:games 类型:List<int> 备注:游戏列表
	}
]]
function read_com_wly_game_plaza_dto_GameType(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.index = sobj:readInt()
	local gamesSize = sobj:readInt()
	obj.games = {}
	for i=1, gamesSize do  
		obj.games[i] = sobj:readInt()
	end 	
	
	return obj		
end



--[[
	游戏类型
	msg ={
		名称:types 类型:List<GameType> 备注:游戏类型
	}
]]
function rec_parse_plaza_ResGameTypes(sobj)

	if sobj then
		local msg = {}
		local typesSize = sobj:readInt()
		msg.types = {}
		for i=1, typesSize do  
			msg.types[i] = read_com_wly_game_plaza_dto_GameType(sobj)
		end 	
		return msg
	end
	return nil
end


s2c_plaza_ResGameTypes_msg = 111201 --[[游戏类型]]

ReceiveMsg.regParseRecMsg(111201, rec_parse_plaza_ResGameTypes)--[[游戏类型]]
