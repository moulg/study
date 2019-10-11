--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
local function rec_pro_shark_ResEnterGameHall(msg)
	--add your logic code here
	shark_manager:resEnterGameHallMsg(msg)
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
local function rec_pro_shark_ResChipsChange(msg)
	--add your logic code here
	shark_manager:resChipsChangeMsg(msg)
end

--[[
	休息阶段消息消息
	msg = {
		名称:time 类型:int 备注:时间(秒)
		名称:iconRateInfos 类型:List<IconRateInfo> 备注:图标倍率信息
	}
]]
local function rec_pro_shark_ResRestStage(msg)
	--add your logic code here
	shark_manager:resRestStage(msg)
end

--[[
	下注阶段消息消息
	msg = {
		名称:time 类型:int 备注:时间(秒)
		名称:iconRateInfos 类型:List<IconRateInfo> 备注:图标倍率信息
	}
]]
local function rec_pro_shark_ResBetStage(msg)
	--add your logic code here
	shark_manager:resBetStage(msg)
end

--[[
	游戏阶段消息消息
	msg = {
		名称:firstIconIndex 类型:int 备注:第一次中奖图标位置(如果中的是金沙或者银沙会有第二次转动)，如果是中途进入游戏则是0
		名称:secondIconIndex 类型:int 备注:第二次中奖图标位置
		名称:firstTime 类型:int 备注:第一次中奖游戏时间
		名称:secondTime 类型:int 备注:第二次中奖游戏时间
		名称:playerBillChips 类型:long 备注:玩家的收益
		名称:bankerBillChips 类型:long 备注:庄家收益
	}
]]
local function rec_pro_shark_ResGameStage(msg)
	--add your logic code here
	shark_manager:resGameStage(msg)
end

--[[
	玩家申请庄家列表消息
	msg = {
		名称:applicants 类型:List<long> 备注:申请人
	}
]]
local function rec_pro_shark_ResApplyBankers(msg)
	--add your logic code here
	shark_manager:setApplyBankers( msg )
end

--[[
	庄家信息消息
	msg = {
		名称:playerId 类型:long 备注:庄家id
		名称:name 类型:String 备注:昵称
		名称:chips 类型:long 备注:筹码
		名称:num 类型:int 备注:局数
		名称:score 类型:long 备注:成绩
		名称:sex 类型:int 备注:性别
	}
]]
local function rec_pro_shark_ResBankerInfo(msg)
	--add your logic code here
	shark_manager:setBankerInfo( msg )
end

--[[
	进入房间结果消息
	msg = {
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
local function rec_pro_shark_ResEnterRoom(msg)
	--add your logic code here
	HallManager:resEnterRoomMsg(msg)
end

--[[
	进入牌桌结果消息
	msg = {
		名称:historyRewardIcons 类型:List<int> 备注:历史中奖图标
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
local function rec_pro_shark_ResEnterTable(msg)
	--add your logic code here
	shark_manager.resEnterTableMsg(msg)
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
local function rec_pro_shark_ResExitRoom(msg)
	--add your logic code here
	-- HallManager:resExitRoomMsg()
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
local function rec_pro_shark_ResExitTable(msg)
	--add your logic code here
	shark_manager:resExitTableMsg(msg)
end

--[[
	桌子下注信息消息
	msg = {
		名称:betInfos 类型:List<BetInfo> 备注:下注信息
	}
]]
local function rec_pro_shark_ResTableBetInfos(msg)
	--add your logic code here
	shark_manager:setAllPlayerBetInfo( msg )	
end

--[[
	玩家下注成功消息
	msg = {
		名称:betInfo 类型:BetInfo 备注:下注信息
	}
]]
local function rec_pro_shark_ResBet(msg)
	--add your logic code here
	shark_manager:setMainPlayerBetInfo( msg )	
end

--[[
	清空下注结果消息
	msg = {
		名称:res 类型:int 备注:结果(0:成功,1:下注阶段不能清除下注)
	}
]]
local function rec_pro_shark_ResClearBet(msg)
	--add your logic code here
	shark_manager:resClearBet(msg)	
end

--[[
	请求游戏阶段结果消息
	msg = {
	}
]]
local function rec_pro_shark_ResStage(msg)
	--add your logic code here
	shark_manager:resStage(msg)
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
local function rec_pro_shark_ResFastEnterTable(msg)
	--add your logic code here
	HallManager:resQuickEnterCurGame(msg)
end


ReceiveMsg.regProRecMsg(509201, rec_pro_shark_ResEnterGameHall)--进入游戏大厅返回房间数据 处理
ReceiveMsg.regProRecMsg(509202, rec_pro_shark_ResChipsChange)--玩家筹码变化消息 处理
ReceiveMsg.regProRecMsg(509203, rec_pro_shark_ResRestStage)--休息阶段消息 处理
ReceiveMsg.regProRecMsg(509204, rec_pro_shark_ResBetStage)--下注阶段消息 处理
ReceiveMsg.regProRecMsg(509205, rec_pro_shark_ResGameStage)--游戏阶段消息 处理
ReceiveMsg.regProRecMsg(509206, rec_pro_shark_ResApplyBankers)--玩家申请庄家列表 处理
ReceiveMsg.regProRecMsg(509207, rec_pro_shark_ResBankerInfo)--庄家信息 处理
ReceiveMsg.regProRecMsg(509209, rec_pro_shark_ResEnterRoom)--进入房间结果 处理
ReceiveMsg.regProRecMsg(509210, rec_pro_shark_ResEnterTable)--进入牌桌结果 处理
ReceiveMsg.regProRecMsg(509211, rec_pro_shark_ResExitRoom)--玩家请求退出房间 处理
ReceiveMsg.regProRecMsg(509212, rec_pro_shark_ResExitTable)--玩家请求退出房间牌桌结果 处理
ReceiveMsg.regProRecMsg(509213, rec_pro_shark_ResTableBetInfos)--桌子下注信息 处理
ReceiveMsg.regProRecMsg(509214, rec_pro_shark_ResBet)--玩家下注成功 处理
ReceiveMsg.regProRecMsg(509215, rec_pro_shark_ResClearBet)--清空下注结果 处理
ReceiveMsg.regProRecMsg(509216, rec_pro_shark_ResStage)--请求游戏阶段结果 处理
ReceiveMsg.regProRecMsg(509227, rec_pro_shark_ResFastEnterTable)--玩家请求快速进入房间牌桌结果 处理

--传输对象说明
--[[
	BetInfo = {
		icon, --图标
		bet, --下注筹码
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
		maxOne, --单局上限（筹码）
		minOne, --单局下限（筹码）
		afee, --单局台费
		inType, --进入类型（0点击入座，1自动分配）
		playerNum, --玩家人数
		status, --状态(空闲,普通,拥挤,爆满)
		displayNames, --展示的属性名称
		placeHolder, --展示的属性名称占位符
	}
]]
--[[
	IconRateInfo = {
		icon, --图标
		rate, --图标倍率
	}
]]
