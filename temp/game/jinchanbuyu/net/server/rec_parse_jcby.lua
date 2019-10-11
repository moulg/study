--[[
	FishDieInfo ={
		名称:fishId 类型:int 备注:鱼id
		名称:score 类型:int 备注:分数
	}
]]
function read_com_wly_game_games_jcby_dto_FishDieInfo(sobj)
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
function read_com_wly_game_games_jcby_dto_BatteryInfo(sobj)
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
function read_com_wly_game_games_jcby_dto_RoomTypeDetailInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.typeName = sobj:readString()
	local roomsSize = sobj:readInt()
	obj.rooms = {}
	for i=1, roomsSize do  
		obj.rooms[i] = read_com_wly_game_games_jcby_dto_RoomInfo(sobj)
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
function read_com_wly_game_games_jcby_dto_RoomInfo(sobj)
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
function read_com_wly_game_games_jcby_dto_FishInfo(sobj)
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
function rec_parse_jcby_ResEnterGameHall(sobj)

	if sobj then
		local msg = {}
		local roomTypesSize = sobj:readInt()
		msg.roomTypes = {}
		for i=1, roomTypesSize do  
			msg.roomTypes[i] = read_com_wly_game_games_jcby_dto_RoomTypeDetailInfo(sobj)
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
function rec_parse_jcby_ResChipsChange(sobj)

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
function rec_parse_jcby_ResFastEnterTable(sobj)

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
function rec_parse_jcby_ResEnterRoom(sobj)

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
function rec_parse_jcby_ResEnterTable(sobj)

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
function rec_parse_jcby_ResExitRoom(sobj)

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
function rec_parse_jcby_ResExitTable(sobj)

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
function rec_parse_jcby_ResOtherEnterTable(sobj)

	if sobj then
		local msg = {}
		msg.battery = read_com_wly_game_games_jcby_dto_BatteryInfo(sobj)
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
function rec_parse_jcby_ResFire(sobj)

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
function rec_parse_jcby_ResBatteryChange(sobj)

	if sobj then
		local msg = {}
		msg.battery = read_com_wly_game_games_jcby_dto_BatteryInfo(sobj)
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
function rec_parse_jcby_ResHit(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.order = sobj:readInt()
		local diesSize = sobj:readInt()
		msg.dies = {}
		for i=1, diesSize do  
			msg.dies[i] = read_com_wly_game_games_jcby_dto_FishDieInfo(sobj)
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
function rec_parse_jcby_ResSwitchScene(sobj)

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
function rec_parse_jcby_ResProduceFish(sobj)

	if sobj then
		local msg = {}
		local fishsSize = sobj:readInt()
		msg.fishs = {}
		for i=1, fishsSize do  
			msg.fishs[i] = read_com_wly_game_games_jcby_dto_FishInfo(sobj)
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
function rec_parse_jcby_ResScence(sobj)

	if sobj then
		local msg = {}
		msg.scenceId = sobj:readInt()
		local fishsSize = sobj:readInt()
		msg.fishs = {}
		for i=1, fishsSize do  
			msg.fishs[i] = read_com_wly_game_games_jcby_dto_FishInfo(sobj)
		end 	
		local batterysSize = sobj:readInt()
		msg.batterys = {}
		for i=1, batterysSize do  
			msg.batterys[i] = read_com_wly_game_games_jcby_dto_BatteryInfo(sobj)
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
function rec_parse_jcby_ResLock(sobj)

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
function rec_parse_jcby_ResCancelLock(sobj)

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
function rec_parse_jcby_ResLikuiUpgrade(sobj)

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
function rec_parse_jcby_ResInsteadPlayersUpgrade(sobj)

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


s2c_jcby_ResEnterGameHall_msg = 520201 --[[进入游戏大厅返回房间数据]]
s2c_jcby_ResChipsChange_msg = 520202 --[[玩家筹码变化消息]]
s2c_jcby_ResFastEnterTable_msg = 520210 --[[玩家请求快速进入房间牌桌结果]]
s2c_jcby_ResEnterRoom_msg = 520211 --[[进入房间结果]]
s2c_jcby_ResEnterTable_msg = 520212 --[[进入牌桌结果]]
s2c_jcby_ResExitRoom_msg = 520215 --[[玩家请求退出房间]]
s2c_jcby_ResExitTable_msg = 520216 --[[玩家请求退出房间牌桌结果]]
s2c_jcby_ResOtherEnterTable_msg = 520219 --[[其他人进入桌子]]
s2c_jcby_ResFire_msg = 520231 --[[玩家请求开炮结果]]
s2c_jcby_ResBatteryChange_msg = 520232 --[[玩家炮台改变消息]]
s2c_jcby_ResHit_msg = 520233 --[[子弹打死鱼]]
s2c_jcby_ResSwitchScene_msg = 520234 --[[切换场景]]
s2c_jcby_ResProduceFish_msg = 520236 --[[产生鱼消息]]
s2c_jcby_ResScence_msg = 520237 --[[玩家请求场景数据结果]]
s2c_jcby_ResLock_msg = 520238 --[[玩家请求锁定结果]]
s2c_jcby_ResCancelLock_msg = 520239 --[[玩家取消锁定]]
s2c_jcby_ResLikuiUpgrade_msg = 520240 --[[李逵升级]]
s2c_jcby_ResInsteadPlayersUpgrade_msg = 520241 --[[代发碰撞玩家列表更新]]

ReceiveMsg.regParseRecMsg(520201, rec_parse_jcby_ResEnterGameHall)--[[进入游戏大厅返回房间数据]]
ReceiveMsg.regParseRecMsg(520202, rec_parse_jcby_ResChipsChange)--[[玩家筹码变化消息]]
ReceiveMsg.regParseRecMsg(520210, rec_parse_jcby_ResFastEnterTable)--[[玩家请求快速进入房间牌桌结果]]
ReceiveMsg.regParseRecMsg(520211, rec_parse_jcby_ResEnterRoom)--[[进入房间结果]]
ReceiveMsg.regParseRecMsg(520212, rec_parse_jcby_ResEnterTable)--[[进入牌桌结果]]
ReceiveMsg.regParseRecMsg(520215, rec_parse_jcby_ResExitRoom)--[[玩家请求退出房间]]
ReceiveMsg.regParseRecMsg(520216, rec_parse_jcby_ResExitTable)--[[玩家请求退出房间牌桌结果]]
ReceiveMsg.regParseRecMsg(520219, rec_parse_jcby_ResOtherEnterTable)--[[其他人进入桌子]]
ReceiveMsg.regParseRecMsg(520231, rec_parse_jcby_ResFire)--[[玩家请求开炮结果]]
ReceiveMsg.regParseRecMsg(520232, rec_parse_jcby_ResBatteryChange)--[[玩家炮台改变消息]]
ReceiveMsg.regParseRecMsg(520233, rec_parse_jcby_ResHit)--[[子弹打死鱼]]
ReceiveMsg.regParseRecMsg(520234, rec_parse_jcby_ResSwitchScene)--[[切换场景]]
ReceiveMsg.regParseRecMsg(520236, rec_parse_jcby_ResProduceFish)--[[产生鱼消息]]
ReceiveMsg.regParseRecMsg(520237, rec_parse_jcby_ResScence)--[[玩家请求场景数据结果]]
ReceiveMsg.regParseRecMsg(520238, rec_parse_jcby_ResLock)--[[玩家请求锁定结果]]
ReceiveMsg.regParseRecMsg(520239, rec_parse_jcby_ResCancelLock)--[[玩家取消锁定]]
ReceiveMsg.regParseRecMsg(520240, rec_parse_jcby_ResLikuiUpgrade)--[[李逵升级]]
ReceiveMsg.regParseRecMsg(520241, rec_parse_jcby_ResInsteadPlayersUpgrade)--[[代发碰撞玩家列表更新]]
