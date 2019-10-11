--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
local function rec_pro_foursshop_ResEnterGameHall(msg)
	fs_manager:resEnterGameHall(msg)
	
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
local function rec_pro_foursshop_ResChipsChange(msg)
	fs_manager:resChipsChange(msg)
	
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
local function rec_pro_foursshop_ResFastEnterTable(msg)
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
local function rec_pro_foursshop_ResEnterRoom(msg)
	HallManager:resEnterRoomMsg(msg)
	
end

--[[
	请求进入牌桌消息
	msg = {
		名称:players 类型:List<long> 备注:牌桌中的玩家
	}
]]
local function rec_pro_foursshop_ResEnterTable(msg)
	fs_manager.resEnterTableMsg(msg)
end

--[[
	4s房间人数消息
	msg = {
		名称:roomId 类型:int 备注:房间
		名称:type 类型:int 备注:房间类型
		名称:num 类型:int 备注:房间人数
	}
]]
local function rec_pro_foursshop_ResRoomPlayerNum(msg)
	--add your logic code here
	
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
local function rec_pro_foursshop_ResExitRoom(msg)
	--add your logic code here
	-- HallManager:resExitRoomMsg()
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
	}
]]
local function rec_pro_foursshop_ResExitTable(msg)
	fs_manager:resExitTable(msg)
	
end

--[[
	请求结算结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有可结算筹码
	}
]]
local function rec_pro_foursshop_ResBill(msg)
	--add your logic code here
	
end

--[[
	4s店当前开出的概率和出现的车标消息
	msg = {
		名称:carId 类型:int 备注:车标ID
		名称:rate 类型:int 备注:本次游戏开出的倍率
		名称:startIndex 类型:int 备注:开始位置
		名称:rewardTime 类型:int 备注:开奖时间
	}
]]
local function rec_pro_foursshop_ResRandCarResult(msg)
	fs_manager:resRandCarResult(msg)
	
end

--[[
	返回倍率结果消息
	msg = {
		名称:foursPlan 类型:List<FoursIconMultiple> 备注:本局所开出的倍率
	}
]]
local function rec_pro_foursshop_ResMultiple(msg)
	fs_manager:resMultiple(msg)
	
end

--[[
	返回结算结果消息
	msg = {
		名称:billChips 类型:long 备注:获得筹码数
		名称:totalChips 类型:long 备注:总筹码数
		名称:bankerEarn 类型:long 备注:庄家收益
		名称:mosaicGold 类型:long 备注:彩金池数
		名称:bankerTotalChips 类型:long 备注:庄家身上的总筹码
	}
]]
local function rec_pro_foursshop_ResBalance(msg)
	fs_manager:resBalance(msg)
	
end

--[[
	返回上庄结果消息
	msg = {
		名称:result 类型:int 备注:上庄结果0：成功，1：失败
		名称:bankers 类型:List<BankerRanker> 备注:目前在队列里面的庄家
	}
]]
local function rec_pro_foursshop_ResOnBanker(msg)
	fs_manager:resOnBanker(msg)
	
end

--[[
	通知客户端计时消息
	msg = {
		名称:state 类型:int 备注:告知客户端游戏进行到的阶段
		名称:time 类型:int 备注:计时时间(单位秒)
	}
]]
local function rec_pro_foursshop_ResTime(msg)
	fs_manager:resTime(msg)
	
end

--[[
	返回下注结果消息
	msg = {
		名称:result 类型:int 备注:下注结果返回0：成功，1：失败
	}
]]
local function rec_pro_foursshop_ResBetResult(msg)
	fs_manager:resBetResult(msg)
	
end

--[[
	返回下庄结果消息
	msg = {
		名称:result 类型:int 备注:下注结果返回0：成功，1：失败
	}
]]
local function rec_pro_foursshop_ResCancelBanker(msg)
	fs_manager:resCancelBanker(msg)
	
end

--[[
	总筹码数发生的变化消息
	msg = {
		名称:bestInfo 类型:List<BetsInfo> 备注:变化的筹码
	}
]]
local function rec_pro_foursshop_ResBetsChange(msg)
	fs_manager:resBetsChange(msg)
	
end

--[[
	返回取消上庄结果消息
	msg = {
		名称:result 类型:int 备注:上庄结果0：成功，1：失败
		名称:banker 类型:List<BankerRanker> 备注:队列里面的申请庄家信息
	}
]]
local function rec_pro_foursshop_ResCancelOnBanker(msg)
	fs_manager:resCancelOnBanker(msg)
	
end

--[[
	庄家信息消息
	msg = {
		名称:playerId 类型:int 备注:庄家id
		名称:name 类型:String 备注:昵称
		名称:gold 类型:long 备注:筹码数
		名称:count 类型:int 备注:局数
		名称:score 类型:long 备注:成绩
		名称:immediately 类型:int 备注:是否立刻刷新:0是，1否
	}
]]
local function rec_pro_foursshop_ResBankerInfo(msg)
	fs_manager:resBankerInfo(msg)
	
end

--[[
	申请庄家列表消息
	msg = {
		名称:banker 类型:List<BankerRanker> 备注:队列里面的申请庄家信息
	}
]]
local function rec_pro_foursshop_ResBankerList(msg)
	fs_manager:resBankerList(msg)
	
end

--[[
	续押返回：0成功,1失败消息
	msg = {
		名称:result 类型:int 备注:续押返回：0成功,1失败
	}
]]
local function rec_pro_foursshop_ResContinueBet(msg)
	fs_manager:resContinueBet(msg)
	
end

--[[
	清空下注：0成功,1失败消息
	msg = {
		名称:result 类型:int 备注:清空下注：0成功,1失败
	}
]]
local function rec_pro_foursshop_ResClearBet(msg)
		fs_manager:reqClearBet(msg)
	
end

--[[
	触发彩金池消息
	msg = {
		名称:num 类型:long 备注:获得的彩金数
	}
]]
local function rec_pro_foursshop_ResMosaic(msg)
	fs_manager:resMosaic(msg)
	
end
--[[
	机器人下注区域消息
	msg = {
		名称:carId 类型:List<int> 备注:下注区域
	}
]]
local function rec_pro_foursshop_ResRobtCarArea(msg)
	--add your logic code here
	
end

--[[
	彩金池数量消息
	msg = {
		名称:mosaicGold 类型:long 备注:彩金池数量
	}
]]
local function rec_pro_foursshop_ResMosaicGold(msg)
	fs_manager:resMosaicGold(msg)
	
end

ReceiveMsg.regProRecMsg(504201, rec_pro_foursshop_ResEnterGameHall)--进入游戏大厅返回房间数据 处理
ReceiveMsg.regProRecMsg(504202, rec_pro_foursshop_ResChipsChange)--玩家筹码变化消息 处理
ReceiveMsg.regProRecMsg(504206, rec_pro_foursshop_ResFastEnterTable)--玩家请求快速进入房间牌桌结果 处理
ReceiveMsg.regProRecMsg(504207, rec_pro_foursshop_ResEnterRoom)--请求进入房间结果 处理
ReceiveMsg.regProRecMsg(504208, rec_pro_foursshop_ResEnterTable)--请求进入牌桌 处理
ReceiveMsg.regProRecMsg(504209, rec_pro_foursshop_ResRoomPlayerNum)--4s房间人数 处理
ReceiveMsg.regProRecMsg(504210, rec_pro_foursshop_ResExitRoom)--玩家请求退出房间 处理
ReceiveMsg.regProRecMsg(504211, rec_pro_foursshop_ResExitTable)--玩家请求退出房间牌桌结果 处理
ReceiveMsg.regProRecMsg(504215, rec_pro_foursshop_ResBill)--请求结算结果 处理
ReceiveMsg.regProRecMsg(504216, rec_pro_foursshop_ResRandCarResult)--4s店当前开出的概率和出现的车标 处理
ReceiveMsg.regProRecMsg(504217, rec_pro_foursshop_ResMultiple)--返回倍率结果 处理
ReceiveMsg.regProRecMsg(504218, rec_pro_foursshop_ResBalance)--返回结算结果 处理
ReceiveMsg.regProRecMsg(504219, rec_pro_foursshop_ResOnBanker)--返回上庄结果 处理
ReceiveMsg.regProRecMsg(504220, rec_pro_foursshop_ResTime)--通知客户端计时 处理
ReceiveMsg.regProRecMsg(504221, rec_pro_foursshop_ResBetResult)--返回下注结果 处理
ReceiveMsg.regProRecMsg(504222, rec_pro_foursshop_ResCancelBanker)--返回下庄结果 处理
ReceiveMsg.regProRecMsg(504223, rec_pro_foursshop_ResBetsChange)--总筹码数发生的变化 处理
ReceiveMsg.regProRecMsg(504224, rec_pro_foursshop_ResCancelOnBanker)--返回取消上庄结果 处理
ReceiveMsg.regProRecMsg(504225, rec_pro_foursshop_ResBankerInfo)--庄家信息 处理
ReceiveMsg.regProRecMsg(504226, rec_pro_foursshop_ResBankerList)--申请庄家列表 处理
ReceiveMsg.regProRecMsg(504227, rec_pro_foursshop_ResContinueBet)--续押返回：0成功,1失败 处理
ReceiveMsg.regProRecMsg(504228, rec_pro_foursshop_ResClearBet)--清空下注：0成功,1失败 处理
ReceiveMsg.regProRecMsg(504229, rec_pro_foursshop_ResMosaic)--触发彩金池 处理
ReceiveMsg.regProRecMsg(504230, rec_pro_foursshop_ResRobtCarArea)--机器人下注区域 处理
ReceiveMsg.regProRecMsg(504231, rec_pro_foursshop_ResMosaicGold)--彩金池数量 处理

--传输对象说明
--[[
	BankerRanker = {
		id, --玩家ID
		name, --玩家昵称
		chips, --玩家筹码数
	}
]]
--[[
	FoursIconMultiple = {
		cardId, --图标ID
		rate, --图标倍率
		name, --图标名称
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
	BetsInfo = {
		carId, --图标ID
		bet, --下注筹码数
	}
]]
