--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
local function rec_pro_jcby_ResEnterGameHall(msg)
	--add your logic code here
	JinChanNetPro.recEnterGameHallMsg(msg)
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:座位顺序
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
local function rec_pro_jcby_ResChipsChange(msg)
	--add your logic code here
	JinChanNetPro.recChipsChange(msg)
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
local function rec_pro_jcby_ResFastEnterTable(msg)
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
local function rec_pro_jcby_ResEnterRoom(msg)
	--add your logic code here
	HallManager:resEnterRoomMsg(msg)
end

--[[
	进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
local function rec_pro_jcby_ResEnterTable(msg)
	--add your logic code here
	JinChanNetPro.recEnterTableMsg(msg)
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
local function rec_pro_jcby_ResExitRoom(msg)
	--add your logic code here
	
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:座位顺序
	}
]]
local function rec_pro_jcby_ResExitTable(msg)
	--add your logic code here
	JinChanNetPro.recExitTableMsg(msg)
end

--[[
	其他人进入桌子消息
	msg = {
		名称:battery 类型:BatteryInfo 备注:炮台
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
local function rec_pro_jcby_ResOtherEnterTable(msg)
	--add your logic code here
	JinChanNetPro.recOtherPlayerEnterTableMgs(msg)
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
local function rec_pro_jcby_ResFire(msg)
	--add your logic code here
	JinChanNetPro.recFire(msg)
end

--[[
	玩家炮台改变消息消息
	msg = {
		名称:battery 类型:BatteryInfo 备注:炮台
	}
]]
local function rec_pro_jcby_ResBatteryChange(msg)
	--add your logic code here
	JinChanNetPro.recCutBattery(msg)
end

--[[
	子弹打死鱼消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:位置
		名称:dies 类型:List<FishDieInfo> 备注:死亡的鱼
	}
]]
local function rec_pro_jcby_ResHit(msg)
	--add your logic code here
	JinChanNetPro.recShotFish(msg)
end

--[[
	切换场景消息
	msg = {
		名称:scene 类型:int 备注:场景id
	}
]]
local function rec_pro_jcby_ResSwitchScene(msg)
	--add your logic code here
	JinChanNetPro.recCutScene(msg)
end

--[[
	产生鱼消息消息
	msg = {
		名称:fishs 类型:List<FishInfo> 备注:鱼
	}
]]
local function rec_pro_jcby_ResProduceFish(msg)
	--add your logic code here
	JinChanNetPro.recFreshFish(msg)
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
local function rec_pro_jcby_ResScence(msg)
	--add your logic code here
	JinChanNetPro.recEnterScene(msg)
end

--[[
	玩家请求锁定结果消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:位置
		名称:fishId 类型:int 备注:锁定鱼
	}
]]
local function rec_pro_jcby_ResLock(msg)
	--add your logic code here
	JinChanNetPro.recLockFish(msg)
end

--[[
	玩家取消锁定消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:位置
	}
]]
local function rec_pro_jcby_ResCancelLock(msg)
	--add your logic code here
	JinChanNetPro.recUnLockFish(msg)
end

--[[
	李逵升级消息
	msg = {
		名称:fishId 类型:int 备注:李逵的鱼id
		名称:rate 类型:int 备注:升级后的倍率
	}
]]
local function rec_pro_jcby_ResLikuiUpgrade(msg)
	--add your logic code here
	JinChanNetPro.recChangeFishLevel(msg)
end

--[[
	代发碰撞玩家列表更新消息
	msg = {
		名称:insteadPlayers 类型:List<long> 备注:代发碰撞玩家列表
	}
]]
local function rec_pro_jcby_ResInsteadPlayersUpgrade(msg)
	--add your logic code here
	JinChanNetPro.recInsteadPlayerLst(msg)
end

ReceiveMsg.regProRecMsg(520201, rec_pro_jcby_ResEnterGameHall)--进入游戏大厅返回房间数据 处理
ReceiveMsg.regProRecMsg(520202, rec_pro_jcby_ResChipsChange)--玩家筹码变化消息 处理
ReceiveMsg.regProRecMsg(520210, rec_pro_jcby_ResFastEnterTable)--玩家请求快速进入房间牌桌结果 处理
ReceiveMsg.regProRecMsg(520211, rec_pro_jcby_ResEnterRoom)--进入房间结果 处理
ReceiveMsg.regProRecMsg(520212, rec_pro_jcby_ResEnterTable)--进入牌桌结果 处理
ReceiveMsg.regProRecMsg(520215, rec_pro_jcby_ResExitRoom)--玩家请求退出房间 处理
ReceiveMsg.regProRecMsg(520216, rec_pro_jcby_ResExitTable)--玩家请求退出房间牌桌结果 处理
ReceiveMsg.regProRecMsg(520219, rec_pro_jcby_ResOtherEnterTable)--其他人进入桌子 处理
ReceiveMsg.regProRecMsg(520231, rec_pro_jcby_ResFire)--玩家请求开炮结果 处理
ReceiveMsg.regProRecMsg(520232, rec_pro_jcby_ResBatteryChange)--玩家炮台改变消息 处理
ReceiveMsg.regProRecMsg(520233, rec_pro_jcby_ResHit)--子弹打死鱼 处理
ReceiveMsg.regProRecMsg(520234, rec_pro_jcby_ResSwitchScene)--切换场景 处理
ReceiveMsg.regProRecMsg(520236, rec_pro_jcby_ResProduceFish)--产生鱼消息 处理
ReceiveMsg.regProRecMsg(520237, rec_pro_jcby_ResScence)--玩家请求场景数据结果 处理
ReceiveMsg.regProRecMsg(520238, rec_pro_jcby_ResLock)--玩家请求锁定结果 处理
ReceiveMsg.regProRecMsg(520239, rec_pro_jcby_ResCancelLock)--玩家取消锁定 处理
ReceiveMsg.regProRecMsg(520240, rec_pro_jcby_ResLikuiUpgrade)--李逵升级 处理
ReceiveMsg.regProRecMsg(520241, rec_pro_jcby_ResInsteadPlayersUpgrade)--代发碰撞玩家列表更新 处理

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
