--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
local function rec_pro_horserace_ResEnterGameHall(msg)
	--add your logic code here
	horserace_manager:resEnterGameHall(msg)
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家ID
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
local function rec_pro_horserace_ResChipsChange(msg)
	--add your logic code here
	horserace_manager:resChipsChange(msg)
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
local function rec_pro_horserace_ResFastEnterTable(msg)
	--add your logic code here
	-- horserace_manager:resFastEnterTable(msg)
	HallManager:resQuickEnterCurGame(msg)
end

--[[
	进入房间结果消息
	msg = {
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
local function rec_pro_horserace_ResEnterRoom(msg)
	--add your logic code here
	horserace_manager:resEnterRoom(msg)
end

--[[
	进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
local function rec_pro_horserace_ResEnterTable(msg)
	--add your logic code here
	horserace_manager:resEnterTable(msg)
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
local function rec_pro_horserace_ResExitRoom(msg)
	--add your logic code here
	horserace_manager:resExitRoom(msg)
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
local function rec_pro_horserace_ResExitTable(msg)
	--add your logic code here
	horserace_manager:resExitTable(msg)
end

--[[
	返回倍率结果消息
	msg = {
		名称:iconMultiple 类型:List<IconMultiple> 备注:本局每个区域的倍率
	}
]]
local function rec_pro_horserace_ResMultiple(msg)
	--add your logic code here
	horserace_manager:resMultiple(msg)
end

--[[
	赛马跑动数据消息
	msg = {
		名称:segement 类型:int 备注:总段数
		名称:horseDetail 类型:List<HorseDetail> 备注:每匹马的数据
	}
]]
local function rec_pro_horserace_ResHorseDetail(msg)
	--add your logic code here
	horserace_manager:resHorseDetail(msg)
end

--[[
	其他人进入桌子消息
	msg = {
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
local function rec_pro_horserace_ResOtherEnterTable(msg)
	--add your logic code here
	horserace_manager:resOtherEnterTable(msg)
end

--[[
	返回下注结果消息
	msg = {
		名称:area 类型:int 备注:下注区域  闲家1-15
		名称:chips 类型:long 备注:对应的筹码
	}
]]
local function rec_pro_horserace_ResBet(msg)
	--add your logic code here
	horserace_manager:resBet(msg)
end

--[[
	桌子筹码变化消息
	msg = {
		名称:betInfo 类型:List<BetInfo> 备注:桌上筹码信息
	}
]]
local function rec_pro_horserace_ResTableBet(msg)
	--add your logic code here
	horserace_manager:resTableBet(msg)
end

--[[
	通知客户端计时消息
	msg = {
		名称:state 类型:int 备注:告知客户端游戏进行到的阶段
		名称:time 类型:int 备注:计时时间(单位秒)
	}
]]
local function rec_pro_horserace_ResTime(msg)
	--add your logic code here
	horserace_manager:resTime(msg)
end

--[[
	历史输赢记录消息
	msg = {
		名称:result 类型:List<int> 备注:闲家对庄家的输赢记录
	}
]]
local function rec_pro_horserace_ResHistory(msg)
	--add your logic code here
	horserace_manager:resHistory(msg)
end

--[[
	返回结算结果消息
	msg = {
		名称:playerChips 类型:long 备注:玩家结算筹码
	}
]]
local function rec_pro_horserace_ResBalance(msg)
	--add your logic code here
	horserace_manager:resBalance(msg)
end

--[[
	场景消息消息
	msg = {
		名称:sceneId 类型:int 备注:场景ID
	}
]]
local function rec_pro_horserace_ResScene(msg)
	--add your logic code here
	horserace_manager:resScene(msg)
end

--[[
	返回开奖结果消息
	msg = {
		名称:areID 类型:int 备注:中奖区域
	}
]]
local function rec_pro_horserace_ResReward(msg)
	--add your logic code here
	horserace_manager:resReward(msg)
end

--[[
	清空下注结果消息
	msg = {
		名称:res 类型:int 备注:结果(0:成功,1:下注阶段不能清除下注)
	}
]]
local function rec_pro_horserace_ResClearBet(msg)
	--add your logic code here
	horserace_manager:resClearBet(msg)
end


ReceiveMsg.regProRecMsg(516201, rec_pro_horserace_ResEnterGameHall)--进入游戏大厅返回房间数据 处理
ReceiveMsg.regProRecMsg(516202, rec_pro_horserace_ResChipsChange)--玩家筹码变化消息 处理
ReceiveMsg.regProRecMsg(516210, rec_pro_horserace_ResFastEnterTable)--玩家请求快速进入房间牌桌结果 处理
ReceiveMsg.regProRecMsg(516211, rec_pro_horserace_ResEnterRoom)--进入房间结果 处理
ReceiveMsg.regProRecMsg(516212, rec_pro_horserace_ResEnterTable)--进入牌桌结果 处理
ReceiveMsg.regProRecMsg(516215, rec_pro_horserace_ResExitRoom)--玩家请求退出房间 处理
ReceiveMsg.regProRecMsg(516216, rec_pro_horserace_ResExitTable)--玩家请求退出房间牌桌结果 处理
ReceiveMsg.regProRecMsg(516217, rec_pro_horserace_ResMultiple)--返回倍率结果 处理
ReceiveMsg.regProRecMsg(516218, rec_pro_horserace_ResHorseDetail)--赛马跑动数据 处理
ReceiveMsg.regProRecMsg(516219, rec_pro_horserace_ResOtherEnterTable)--其他人进入桌子 处理
ReceiveMsg.regProRecMsg(516221, rec_pro_horserace_ResBet)--返回下注结果 处理
ReceiveMsg.regProRecMsg(516222, rec_pro_horserace_ResTableBet)--桌子筹码变化 处理
ReceiveMsg.regProRecMsg(516225, rec_pro_horserace_ResTime)--通知客户端计时 处理
ReceiveMsg.regProRecMsg(516226, rec_pro_horserace_ResHistory)--历史输赢记录 处理
ReceiveMsg.regProRecMsg(516227, rec_pro_horserace_ResBalance)--返回结算结果 处理
ReceiveMsg.regProRecMsg(516228, rec_pro_horserace_ResScene)--场景消息 处理
ReceiveMsg.regProRecMsg(516230, rec_pro_horserace_ResReward)--返回开奖结果 处理
ReceiveMsg.regProRecMsg(516231, rec_pro_horserace_ResClearBet)--清空下注结果 处理

--传输对象说明
--[[
	HorseDetail = {
		horseId, --赛马ID
		totalTime, --总时间
		segement, --总段数
		perTime, --每一段的时间
	}
]]
--[[
	BetInfo = {
		area, --下注区域
		chips, --下注筹码
	}
]]
--[[
	IconMultiple = {
		areId, --区域ID
		rate, --区域对应倍率
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
	BillInfo = {
		order, --座位顺序
		chips, --结算筹码
	}
]]
