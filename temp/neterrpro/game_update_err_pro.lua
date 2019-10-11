#remark
--游戏更新记录
local game_update_rec = {}

GameUpdateStateRec = {}

function GameUpdateStateRec.recodGameUpdate(game_id)
	if game_update_rec[game_id] == nil then
		game_update_rec[game_id] = {}
		game_update_rec[game_id].game_info = game_config[game_index]
		game_update_rec[game_id].is_update = false
	end
end

function GameUpdateStateRec.isUpdate(game_index)
	if game_update_rec[game_index] then
		return game_update_rec[game_index].is_update
	end

	return false
end

function GameUpdateStateRec.setUpdateState(game_index,state)
	if game_update_rec[game_index] then
		game_update_rec[game_index].is_update = state
	end
end

function GameUpdateStateRec.resetGameUpdateState()
	game_update_rec = {}
end

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
