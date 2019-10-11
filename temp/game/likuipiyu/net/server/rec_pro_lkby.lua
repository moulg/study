--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
local function rec_pro_lkby_ResEnterGameHall(msg)
	--add your logic code here
	LikuiNetPro.recEnterGameHallMsg(msg)
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:座位顺序
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
local function rec_pro_lkby_ResChipsChange(msg)
	--add your logic code here
	LikuiNetPro.recChipsChange(msg)
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
local function rec_pro_lkby_ResFastEnterTable(msg)
	--add your logic code here
	HallManager:resQuickEnterCurGame(msg)
end

--[[
	进入房间结果消息
	msg = {
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
local function rec_pro_lkby_ResEnterRoom(msg)
	--add your logic code here
	HallManager:resEnterRoomMsg(msg)
end

--[[
	进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
local function rec_pro_lkby_ResEnterTable(msg)
	--add your logic code here
	LikuiNetPro.recEnterTableMsg(msg)
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
local function rec_pro_lkby_ResExitRoom(msg)
	--add your logic code here
	
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:座位顺序
	}
]]
local function rec_pro_lkby_ResExitTable(msg)
	--add your logic code here
	LikuiNetPro.recExitTableMsg(msg)
end

--[[
	其他人进入桌子消息
	msg = {
		名称:battery 类型:BatteryInfo 备注:炮台
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
local function rec_pro_lkby_ResOtherEnterTable(msg)
	--add your logic code here
	LikuiNetPro.recOtherPlayerEnterTableMgs(msg)
end

--[[
	玩家请求开炮结果消息
	msg = {
		名称:playerId 类型:long 备注:发炮玩家
		名称:order 类型:int 备注:位置
		名称:bulletId 类型:int 备注:子弹id
		名称:angle 类型:int 备注:夹角
	}
]]
local function rec_pro_lkby_ResFire(msg)
	--add your logic code here
	LikuiNetPro.recFire(msg)
end

--[[
	玩家炮台改变消息消息
	msg = {
		名称:battery 类型:BatteryInfo 备注:炮台
	}
]]
local function rec_pro_lkby_ResBatteryChange(msg)
	--add your logic code here
	LikuiNetPro.recCutBattery(msg)
end

--[[
	子弹打死鱼消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:位置
		名称:dies 类型:List<FishDieInfo> 备注:死亡的鱼
	}
]]
local function rec_pro_lkby_ResHit(msg)
	--add your logic code here
	LikuiNetPro.recShotFish(msg)
end

--[[
	切换场景消息
	msg = {
		名称:scene 类型:int 备注:场景id
	}
]]
local function rec_pro_lkby_ResSwitchScene(msg)
	--add your logic code here
	LikuiNetPro.recCutScene(msg)
end

--[[
	产生鱼消息消息
	msg = {
		名称:fishs 类型:List<FishInfo> 备注:鱼
	}
]]
local function rec_pro_lkby_ResProduceFish(msg)
	--add your logic code here
	LikuiNetPro.recFreshFish(msg)
end

--[[
	玩家请求场景数据结果消息
	msg = {
		名称:scenceId 类型:int 备注:场景id
		名称:fishs 类型:List<FishInfo> 备注:鱼
		名称:batterys 类型:List<BatteryInfo> 备注:炮台
		名称:insteadPlayers 类型:List<long> 备注:代发碰撞玩家列表
	}
]]
local function rec_pro_lkby_ResScence(msg)
	--add your logic code here
	LikuiNetPro.recEnterScene(msg)
end

--[[
	玩家请求锁定结果消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:位置
		名称:fishId 类型:int 备注:锁定鱼
	}
]]
local function rec_pro_lkby_ResLock(msg)
	--add your logic code here
	LikuiNetPro.recLockFish(msg)
end

--[[
	玩家取消锁定消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:位置
	}
]]
local function rec_pro_lkby_ResCancelLock(msg)
	--add your logic code here
	LikuiNetPro.recUnLockFish(msg)
end

--[[
	李逵升级消息
	msg = {
		名称:fishId 类型:int 备注:李逵的鱼id
		名称:rate 类型:int 备注:升级后的倍率
	}
]]
local function rec_pro_lkby_ResLikuiUpgrade(msg)
	--add your logic code here
	LikuiNetPro.recChangeFishLevel(msg)
end

--[[
	代发碰撞玩家列表更新消息
	msg = {
		名称:insteadPlayers 类型:List<long> 备注:代发碰撞玩家列表
	}
]]
local function rec_pro_lkby_ResInsteadPlayersUpgrade(msg)
	--add your logic code here
	LikuiNetPro.recInsteadPlayerLst(msg)
end


ReceiveMsg.regProRecMsg(521201, rec_pro_lkby_ResEnterGameHall)--进入游戏大厅返回房间数据 处理
ReceiveMsg.regProRecMsg(521202, rec_pro_lkby_ResChipsChange)--玩家筹码变化消息 处理
ReceiveMsg.regProRecMsg(521210, rec_pro_lkby_ResFastEnterTable)--玩家请求快速进入房间牌桌结果 处理
ReceiveMsg.regProRecMsg(521211, rec_pro_lkby_ResEnterRoom)--进入房间结果 处理
ReceiveMsg.regProRecMsg(521212, rec_pro_lkby_ResEnterTable)--进入牌桌结果 处理
ReceiveMsg.regProRecMsg(521215, rec_pro_lkby_ResExitRoom)--玩家请求退出房间 处理
ReceiveMsg.regProRecMsg(521216, rec_pro_lkby_ResExitTable)--玩家请求退出房间牌桌结果 处理
ReceiveMsg.regProRecMsg(521219, rec_pro_lkby_ResOtherEnterTable)--其他人进入桌子 处理
ReceiveMsg.regProRecMsg(521231, rec_pro_lkby_ResFire)--玩家请求开炮结果 处理
ReceiveMsg.regProRecMsg(521232, rec_pro_lkby_ResBatteryChange)--玩家炮台改变消息 处理
ReceiveMsg.regProRecMsg(521233, rec_pro_lkby_ResHit)--子弹打死鱼 处理
ReceiveMsg.regProRecMsg(521234, rec_pro_lkby_ResSwitchScene)--切换场景 处理
ReceiveMsg.regProRecMsg(521236, rec_pro_lkby_ResProduceFish)--产生鱼消息 处理
ReceiveMsg.regProRecMsg(521237, rec_pro_lkby_ResScence)--玩家请求场景数据结果 处理
ReceiveMsg.regProRecMsg(521238, rec_pro_lkby_ResLock)--玩家请求锁定结果 处理
ReceiveMsg.regProRecMsg(521239, rec_pro_lkby_ResCancelLock)--玩家取消锁定 处理
ReceiveMsg.regProRecMsg(521240, rec_pro_lkby_ResLikuiUpgrade)--李逵升级 处理
ReceiveMsg.regProRecMsg(521241, rec_pro_lkby_ResInsteadPlayersUpgrade)--代发碰撞玩家列表更新 处理

--传输对象说明
--[[
	FishDieInfo = {
		fishId, --鱼id
		score, --分数
	}
]]
--[[
	BatteryInfo = {
		playerId, --玩家id
		order, --座位顺序
		score, --炮管分数
		num, --炮管数量
		power, --是否能量炮(0:不是,非0:能量炮)
	}
]]
--[[
	RoomTypeDetailInfo = {
		type, --房间类型id
		typeName, --房间类型名称
		rooms, --房间
	}
]]
--[[
	RoomInfo = {
		roomId, --房间id
		name, --房间名称
		type, --房间类型
		maxNum, --房间最大人数
		free, --空闲状态人数
		general, --普通状态人数
		crowded, --拥挤状态人数
		lower, --进入下限
		upper, --进入上限
		proportionGold, --金币比例
		proportionChips, --筹码比例
		tabble, --每桌椅子数
		afee, --单局台费
		inType, --进入类型（0点击入座，1自动分配）
		playerNum, --玩家人数
		status, --状态(空闲,普通,拥挤,爆满)
		displayNames, --展示的属性名称
		placeHolder, --展示的属性名称占位符
	}
]]
--[[
	FishInfo = {
		id, --鱼id
		type, --鱼的类型
		x, --起点x
		y, --起点y
		road, --路径id
		t, --时间
		angle, --夹角(负数不处理)
	}
]]
