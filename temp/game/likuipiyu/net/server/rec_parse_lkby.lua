--[[
	FishDieInfo ={
		名称:fishId 类型:int 备注:鱼id
		名称:score 类型:int 备注:分数
	}
]]
function read_com_wly_game_games_lkby_dto_FishDieInfo(sobj)
	local obj = {};
	obj.fishId = sobj:readInt()
	obj.score = sobj:readInt()
	
	return obj		
end

--[[
	BatteryInfo ={
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:座位顺序
		名称:score 类型:int 备注:炮管分数
		名称:num 类型:int 备注:炮管数量
		名称:power 类型:int 备注:是否能量炮(0:不是,非0:能量炮)
	}
]]
function read_com_wly_game_games_lkby_dto_BatteryInfo(sobj)
	local obj = {};
	obj.playerId = sobj:readLong()
	obj.order = sobj:readInt()
	obj.score = sobj:readInt()
	obj.num = sobj:readInt()
	obj.power = sobj:readInt()
	
	return obj		
end

--[[
	RoomTypeDetailInfo ={
		名称:type 类型:int 备注:房间类型id
		名称:typeName 类型:String 备注:房间类型名称
		名称:rooms 类型:List<RoomInfo> 备注:房间
	}
]]
function read_com_wly_game_games_lkby_dto_RoomTypeDetailInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.typeName = sobj:readString()
	local roomsSize = sobj:readInt()
	obj.rooms = {}
	for i=1, roomsSize do  
		obj.rooms[i] = read_com_wly_game_games_lkby_dto_RoomInfo(sobj)
	end 	
	
	return obj		
end

--[[
	RoomInfo ={
		名称:roomId 类型:int 备注:房间id
		名称:name 类型:String 备注:房间名称
		名称:type 类型:int 备注:房间类型
		名称:maxNum 类型:int 备注:房间最大人数
		名称:free 类型:int 备注:空闲状态人数
		名称:general 类型:int 备注:普通状态人数
		名称:crowded 类型:int 备注:拥挤状态人数
		名称:lower 类型:int 备注:进入下限
		名称:upper 类型:int 备注:进入上限
		名称:proportionGold 类型:int 备注:金币比例
		名称:proportionChips 类型:int 备注:筹码比例
		名称:tabble 类型:int 备注:每桌椅子数
		名称:afee 类型:int 备注:单局台费
		名称:inType 类型:int 备注:进入类型（0点击入座，1自动分配）
		名称:playerNum 类型:int 备注:玩家人数
		名称:status 类型:String 备注:状态(空闲,普通,拥挤,爆满)
		名称:displayNames 类型:String 备注:展示的属性名称
		名称:placeHolder 类型:String 备注:展示的属性名称占位符
	}
]]
function read_com_wly_game_games_lkby_dto_RoomInfo(sobj)
	local obj = {};
	obj.roomId = sobj:readInt()
	obj.name = sobj:readString()
	obj.type = sobj:readInt()
	obj.maxNum = sobj:readInt()
	obj.free = sobj:readInt()
	obj.general = sobj:readInt()
	obj.crowded = sobj:readInt()
	obj.lower = sobj:readInt()
	obj.upper = sobj:readInt()
	obj.proportionGold = sobj:readInt()
	obj.proportionChips = sobj:readInt()
	obj.tabble = sobj:readInt()
	obj.afee = sobj:readInt()
	obj.inType = sobj:readInt()
	obj.playerNum = sobj:readInt()
	obj.status = sobj:readString()
	obj.displayNames = sobj:readString()
	obj.placeHolder = sobj:readString()
	
	return obj		
end

--[[
	FishInfo ={
		名称:id 类型:int 备注:鱼id
		名称:type 类型:int 备注:鱼的类型
		名称:x 类型:int 备注:起点x
		名称:y 类型:int 备注:起点y
		名称:road 类型:int 备注:路径id
		名称:t 类型:long 备注:时间
		名称:angle 类型:int 备注:夹角(负数不处理)
	}
]]
function read_com_wly_game_games_lkby_dto_FishInfo(sobj)
	local obj = {};
	obj.id = sobj:readInt()
	obj.type = sobj:readInt()
	obj.x = sobj:readInt()
	obj.y = sobj:readInt()
	obj.road = sobj:readInt()
	obj.t = sobj:readLong()
	obj.angle = sobj:readInt()
	
	return obj		
end



--[[
	进入游戏大厅返回房间数据
	msg ={
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function rec_parse_lkby_ResEnterGameHall(sobj)

	if sobj then
		local msg = {}
		local roomTypesSize = sobj:readInt()
		msg.roomTypes = {}
		for i=1, roomTypesSize do  
			msg.roomTypes[i] = read_com_wly_game_games_lkby_dto_RoomTypeDetailInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	玩家筹码变化消息
	msg ={
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:座位顺序
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
function rec_parse_lkby_ResChipsChange(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.order = sobj:readInt()
		msg.chips = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	玩家请求快速进入房间牌桌结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
function rec_parse_lkby_ResFastEnterTable(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	进入房间结果
	msg ={
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
function rec_parse_lkby_ResEnterRoom(sobj)

	if sobj then
		local msg = {}
		local tablesSize = sobj:readInt()
		msg.tables = {}
		for i=1, tablesSize do  
			msg.tables[i] = read_com_wly_game_gamehall_dto_TableInfo(sobj)
		end 	
		local membersSize = sobj:readInt()
		msg.members = {}
		for i=1, membersSize do  
			msg.members[i] = read_com_wly_game_gamehall_dto_MemInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	进入牌桌结果
	msg ={
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
function rec_parse_lkby_ResEnterTable(sobj)

	if sobj then
		local msg = {}
		local memsSize = sobj:readInt()
		msg.mems = {}
		for i=1, memsSize do  
			msg.mems[i] = read_com_wly_game_gamehall_dto_MemInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	玩家请求退出房间
	msg ={
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
function rec_parse_lkby_ResExitRoom(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	玩家请求退出房间牌桌结果
	msg ={
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:座位顺序
	}
]]
function rec_parse_lkby_ResExitTable(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.order = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	其他人进入桌子
	msg ={
		名称:battery 类型:BatteryInfo 备注:炮台
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
function rec_parse_lkby_ResOtherEnterTable(sobj)

	if sobj then
		local msg = {}
		msg.battery = read_com_wly_game_games_lkby_dto_BatteryInfo(sobj)
		msg.mem = read_com_wly_game_gamehall_dto_MemInfo(sobj)
		return msg
	end
	return nil
end


--[[
	玩家请求开炮结果
	msg ={
		名称:playerId 类型:long 备注:发炮玩家
		名称:order 类型:int 备注:位置
		名称:bulletId 类型:int 备注:子弹id
		名称:angle 类型:int 备注:夹角
	}
]]
function rec_parse_lkby_ResFire(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.order = sobj:readInt()
		msg.bulletId = sobj:readInt()
		msg.angle = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	玩家炮台改变消息
	msg ={
		名称:battery 类型:BatteryInfo 备注:炮台
	}
]]
function rec_parse_lkby_ResBatteryChange(sobj)

	if sobj then
		local msg = {}
		msg.battery = read_com_wly_game_games_lkby_dto_BatteryInfo(sobj)
		return msg
	end
	return nil
end


--[[
	子弹打死鱼
	msg ={
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:位置
		名称:dies 类型:List<FishDieInfo> 备注:死亡的鱼
	}
]]
function rec_parse_lkby_ResHit(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.order = sobj:readInt()
		local diesSize = sobj:readInt()
		msg.dies = {}
		for i=1, diesSize do  
			msg.dies[i] = read_com_wly_game_games_lkby_dto_FishDieInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	切换场景
	msg ={
		名称:scene 类型:int 备注:场景id
	}
]]
function rec_parse_lkby_ResSwitchScene(sobj)

	if sobj then
		local msg = {}
		msg.scene = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	产生鱼消息
	msg ={
		名称:fishs 类型:List<FishInfo> 备注:鱼
	}
]]
function rec_parse_lkby_ResProduceFish(sobj)

	if sobj then
		local msg = {}
		local fishsSize = sobj:readInt()
		msg.fishs = {}
		for i=1, fishsSize do  
			msg.fishs[i] = read_com_wly_game_games_lkby_dto_FishInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	玩家请求场景数据结果
	msg ={
		名称:scenceId 类型:int 备注:场景id
		名称:fishs 类型:List<FishInfo> 备注:鱼
		名称:batterys 类型:List<BatteryInfo> 备注:炮台
		名称:insteadPlayers 类型:List<long> 备注:代发碰撞玩家列表
	}
]]
function rec_parse_lkby_ResScence(sobj)

	if sobj then
		local msg = {}
		msg.scenceId = sobj:readInt()
		local fishsSize = sobj:readInt()
		msg.fishs = {}
		for i=1, fishsSize do  
			msg.fishs[i] = read_com_wly_game_games_lkby_dto_FishInfo(sobj)
		end 	
		local batterysSize = sobj:readInt()
		msg.batterys = {}
		for i=1, batterysSize do  
			msg.batterys[i] = read_com_wly_game_games_lkby_dto_BatteryInfo(sobj)
		end 	
		local insteadPlayersSize = sobj:readInt()
		msg.insteadPlayers = {}
		for i=1, insteadPlayersSize do  
			msg.insteadPlayers[i] = sobj:readLong()
		end 	
		return msg
	end
	return nil
end


--[[
	玩家请求锁定结果
	msg ={
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:位置
		名称:fishId 类型:int 备注:锁定鱼
	}
]]
function rec_parse_lkby_ResLock(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.order = sobj:readInt()
		msg.fishId = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	玩家取消锁定
	msg ={
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:位置
	}
]]
function rec_parse_lkby_ResCancelLock(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.order = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	李逵升级
	msg ={
		名称:fishId 类型:int 备注:李逵的鱼id
		名称:rate 类型:int 备注:升级后的倍率
	}
]]
function rec_parse_lkby_ResLikuiUpgrade(sobj)

	if sobj then
		local msg = {}
		msg.fishId = sobj:readInt()
		msg.rate = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	代发碰撞玩家列表更新
	msg ={
		名称:insteadPlayers 类型:List<long> 备注:代发碰撞玩家列表
	}
]]
function rec_parse_lkby_ResInsteadPlayersUpgrade(sobj)

	if sobj then
		local msg = {}
		local insteadPlayersSize = sobj:readInt()
		msg.insteadPlayers = {}
		for i=1, insteadPlayersSize do  
			msg.insteadPlayers[i] = sobj:readLong()
		end 	
		return msg
	end
	return nil
end


s2c_lkby_ResEnterGameHall_msg = 521201 --[[进入游戏大厅返回房间数据]]
s2c_lkby_ResChipsChange_msg = 521202 --[[玩家筹码变化消息]]
s2c_lkby_ResFastEnterTable_msg = 521210 --[[玩家请求快速进入房间牌桌结果]]
s2c_lkby_ResEnterRoom_msg = 521211 --[[进入房间结果]]
s2c_lkby_ResEnterTable_msg = 521212 --[[进入牌桌结果]]
s2c_lkby_ResExitRoom_msg = 521215 --[[玩家请求退出房间]]
s2c_lkby_ResExitTable_msg = 521216 --[[玩家请求退出房间牌桌结果]]
s2c_lkby_ResOtherEnterTable_msg = 521219 --[[其他人进入桌子]]
s2c_lkby_ResFire_msg = 521231 --[[玩家请求开炮结果]]
s2c_lkby_ResBatteryChange_msg = 521232 --[[玩家炮台改变消息]]
s2c_lkby_ResHit_msg = 521233 --[[子弹打死鱼]]
s2c_lkby_ResSwitchScene_msg = 521234 --[[切换场景]]
s2c_lkby_ResProduceFish_msg = 521236 --[[产生鱼消息]]
s2c_lkby_ResScence_msg = 521237 --[[玩家请求场景数据结果]]
s2c_lkby_ResLock_msg = 521238 --[[玩家请求锁定结果]]
s2c_lkby_ResCancelLock_msg = 521239 --[[玩家取消锁定]]
s2c_lkby_ResLikuiUpgrade_msg = 521240 --[[李逵升级]]
s2c_lkby_ResInsteadPlayersUpgrade_msg = 521241 --[[代发碰撞玩家列表更新]]

ReceiveMsg.regParseRecMsg(521201, rec_parse_lkby_ResEnterGameHall)--[[进入游戏大厅返回房间数据]]
ReceiveMsg.regParseRecMsg(521202, rec_parse_lkby_ResChipsChange)--[[玩家筹码变化消息]]
ReceiveMsg.regParseRecMsg(521210, rec_parse_lkby_ResFastEnterTable)--[[玩家请求快速进入房间牌桌结果]]
ReceiveMsg.regParseRecMsg(521211, rec_parse_lkby_ResEnterRoom)--[[进入房间结果]]
ReceiveMsg.regParseRecMsg(521212, rec_parse_lkby_ResEnterTable)--[[进入牌桌结果]]
ReceiveMsg.regParseRecMsg(521215, rec_parse_lkby_ResExitRoom)--[[玩家请求退出房间]]
ReceiveMsg.regParseRecMsg(521216, rec_parse_lkby_ResExitTable)--[[玩家请求退出房间牌桌结果]]
ReceiveMsg.regParseRecMsg(521219, rec_parse_lkby_ResOtherEnterTable)--[[其他人进入桌子]]
ReceiveMsg.regParseRecMsg(521231, rec_parse_lkby_ResFire)--[[玩家请求开炮结果]]
ReceiveMsg.regParseRecMsg(521232, rec_parse_lkby_ResBatteryChange)--[[玩家炮台改变消息]]
ReceiveMsg.regParseRecMsg(521233, rec_parse_lkby_ResHit)--[[子弹打死鱼]]
ReceiveMsg.regParseRecMsg(521234, rec_parse_lkby_ResSwitchScene)--[[切换场景]]
ReceiveMsg.regParseRecMsg(521236, rec_parse_lkby_ResProduceFish)--[[产生鱼消息]]
ReceiveMsg.regParseRecMsg(521237, rec_parse_lkby_ResScence)--[[玩家请求场景数据结果]]
ReceiveMsg.regParseRecMsg(521238, rec_parse_lkby_ResLock)--[[玩家请求锁定结果]]
ReceiveMsg.regParseRecMsg(521239, rec_parse_lkby_ResCancelLock)--[[玩家取消锁定]]
ReceiveMsg.regParseRecMsg(521240, rec_parse_lkby_ResLikuiUpgrade)--[[李逵升级]]
ReceiveMsg.regParseRecMsg(521241, rec_parse_lkby_ResInsteadPlayersUpgrade)--[[代发碰撞玩家列表更新]]
