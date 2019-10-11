--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
local function rec_pro_shuihu_ResEnterGameHall(msg)
	--add your logic code here
	shuihu_manager:resEnterGameHallMsg(msg)
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
local function rec_pro_shuihu_ResChipsChange(msg)
	--add your logic code here
	shuihu_manager:resChipsChangeMsg(msg)
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
local function rec_pro_shuihu_ResFastEnterTable(msg)
	--add your logic code here
	HallManager:resQuickEnterCurGame(msg)
end

--[[
	请求进入房间结果消息
	msg = {
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
local function rec_pro_shuihu_ResEnterRoom(msg)
	--add your logic code here
	HallManager:resEnterRoomMsg(msg)
end

--[[
	请求进入牌桌消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
local function rec_pro_shuihu_ResEnterTable(msg)
	--add your logic code here
	shuihu_manager.resEnterTableMsg(msg)
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
local function rec_pro_shuihu_ResExitRoom(msg)
	--add your logic code here
	-- HallManager:resExitRoomMsg()
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
	}
]]
local function rec_pro_shuihu_ResExitTable(msg)
	--add your logic code here
	shuihu_manager:resExitTableMsg(msg)
end

--[[
	水浒传游戏开始结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:筹码不足
		名称:type 类型:int 备注:类型(0:普通连线奖励 ,全盘奖励[1:铁斧,2:银枪,3:金刀,4:鲁智深,5:林冲,6:宋江,7:替天行道,8:忠义堂,9:水浒传,10:人物,11:武器]
		名称:bonus 类型:int 备注:bonus次数
		名称:icons 类型:List<int> 备注:图标(固定15个,按行取,每行5个)
		名称:lineRewards 类型:List<LineRewardIcons> 备注:线路中奖图标信息
		名称:totalWin 类型:long 备注:合计赢的筹码(0:没有赢)
	}
]]
local function rec_pro_shuihu_ResShuiHuStart(msg)
	--add your logic code here
	shuihu_manager:resShuihuStartMsg(msg)
end

--[[
	骰子游戏开始结果消息
	msg = {
		名称:res 类型:int 备注:0:开始成功,1:双比筹码不足
		名称:win 类型:long 备注:0:输,非0:本局赢得的筹码
		名称:point1 类型:int 备注:骰子1点数
		名称:point2 类型:int 备注:骰子2点数
		名称:totalWin 类型:long 备注:合计赢的筹码(0:没有赢)
	}
]]
local function rec_pro_shuihu_ResDiceGameStart(msg)
	--add your logic code here
	shuihu_manager:resDIceGameStartMsg(msg)
end

--[[
	小玛丽开始消息
	msg = {
		名称:insideIcons 类型:List<int> 备注:内部图标
		名称:outsideIcon 类型:int 备注:外部图标
		名称:win 类型:long 备注:当前赢的筹码(0:没有赢)
		名称:totalWin 类型:long 备注:合计赢的筹码(0:没有赢)
		名称:over 类型:int 备注:是否结束(0:没有结束,非0:结束)
	}
]]
local function rec_pro_shuihu_ResXiaoMaLiStart(msg)
	--add your logic code here
	shuihu_manager:resXiaoMaLiStartMsg(msg)
end

--[[
	请求结算结果消息
	msg = {
	}
]]
local function rec_pro_shuihu_ResBill(msg)
	--add your logic code here
	shuihu_manager:resBillMsg()
end

--[[
	请求兑换筹码结果消息
	msg = {
		名称:chips 类型:long 备注:兑换后的筹码
	}
]]
local function rec_pro_shuihu_ResExchangeChips(msg)
	--add your logic code here
	shuihu_manager:resChipsExChangeMsg(msg)
end


ReceiveMsg.regProRecMsg(503201, rec_pro_shuihu_ResEnterGameHall)--进入游戏大厅返回房间数据 处理
ReceiveMsg.regProRecMsg(503202, rec_pro_shuihu_ResChipsChange)--玩家筹码变化消息 处理
ReceiveMsg.regProRecMsg(503206, rec_pro_shuihu_ResFastEnterTable)--玩家请求快速进入房间牌桌结果 处理
ReceiveMsg.regProRecMsg(503207, rec_pro_shuihu_ResEnterRoom)--请求进入房间结果 处理
ReceiveMsg.regProRecMsg(503208, rec_pro_shuihu_ResEnterTable)--请求进入牌桌 处理
ReceiveMsg.regProRecMsg(503210, rec_pro_shuihu_ResExitRoom)--玩家请求退出房间 处理
ReceiveMsg.regProRecMsg(503211, rec_pro_shuihu_ResExitTable)--玩家请求退出房间牌桌结果 处理
ReceiveMsg.regProRecMsg(503212, rec_pro_shuihu_ResShuiHuStart)--水浒传游戏开始结果 处理
ReceiveMsg.regProRecMsg(503213, rec_pro_shuihu_ResDiceGameStart)--骰子游戏开始结果 处理
ReceiveMsg.regProRecMsg(503214, rec_pro_shuihu_ResXiaoMaLiStart)--小玛丽开始 处理
ReceiveMsg.regProRecMsg(503215, rec_pro_shuihu_ResBill)--请求结算结果 处理
ReceiveMsg.regProRecMsg(503216, rec_pro_shuihu_ResExchangeChips)--请求兑换筹码结果 处理

--传输对象说明
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
		full, --爆满人数
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
	LineRewardIcons = {
		line, --中奖线路(从1开始)
		icon, --中奖图标
		indexs, --中奖图标索引(从1开始)
	}
]]
