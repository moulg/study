--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
local function rec_pro_baccarat_ResEnterGameHall(msg)
	--add your logic code here
	baccarat_manager:resEnterGameHall(msg)
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家ID
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
local function rec_pro_baccarat_ResChipsChange(msg)
	--add your logic code here
	baccarat_manager:resChipsChange(msg)
end

--[[
	玩家准备消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
local function rec_pro_baccarat_ResReady(msg)
	--add your logic code here
	baccarat_manager:resReady(msg)
end

--[[
	请求交换桌子消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:已经准备不能交换桌子,2:当前房间没有空位置
	}
]]
local function rec_pro_baccarat_ResExchangeTable(msg)
	--add your logic code here
	baccarat_manager:resExchangeTable(msg)
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
local function rec_pro_baccarat_ResFastEnterTable(msg)
	--add your logic code here
	baccarat_manager:resFastEnterTable(msg)
end

--[[
	进入房间结果消息
	msg = {
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
local function rec_pro_baccarat_ResEnterRoom(msg)
	--add your logic code here
	baccarat_manager:resEnterRoom(msg)
end

--[[
	进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
local function rec_pro_baccarat_ResEnterTable(msg)
	--add your logic code here
	baccarat_manager:resEnterTable(msg)
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
local function rec_pro_baccarat_ResExitRoom(msg)
	--add your logic code here
	baccarat_manager:resExitRoom(msg)
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
local function rec_pro_baccarat_ResExitTable(msg)
	--add your logic code here
	baccarat_manager:resExitTable(msg)
end

--[[
	返回倍率结果消息
	msg = {
		名称:iconMulti 类型:List<IconMultiple> 备注:本局所开出的倍率
	}
]]
local function rec_pro_baccarat_ResMultiple(msg)
	--add your logic code here
	baccarat_manager:resMultiple(msg)
end

--[[
	发牌消息
	msg = {
		名称:cardsInfo 类型:List<CardsInfo> 备注:牌信息
		名称:cardIndex 类型:int 备注:牌序(发到第多少张牌了)
		名称:leftNum 类型:int 备注:上一局剩余多少牌 (总共六张,发剩余了多少)
		名称:yellowCard 类型:int 备注:是否发到了黄牌(1是0否)
	}
]]
local function rec_pro_baccarat_ResDealCards(msg)
	--add your logic code here
	baccarat_manager:resDealCards(msg)
end

--[[
	其他人进入桌子消息
	msg = {
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
local function rec_pro_baccarat_ResOtherEnterTable(msg)
	--add your logic code here
	baccarat_manager:resOtherEnterTable(msg)
end

--[[
	返回下注结果消息
	msg = {
		名称:area 类型:int 备注:下注区域  闲家1-11
		名称:chips 类型:long 备注:对应的筹码
	}
]]
local function rec_pro_baccarat_ResBet(msg)
	--add your logic code here
	baccarat_manager:resBet(msg)
end

--[[
	桌子筹码变化消息
	msg = {
		名称:betInfo 类型:List<BetInfo> 备注:桌上筹码信息
	}
]]
local function rec_pro_baccarat_ResTableBet(msg)
	--add your logic code here
	baccarat_manager:resTableBet(msg)
end

--[[
	结果统计信息消息
	msg = {
		名称:bankerWin 类型:int 备注:庄赢
		名称:playerWin 类型:int 备注:闲赢
		名称:tie 类型:int 备注:和
		名称:bankerPaire 类型:int 备注:庄对
		名称:playerPaire 类型:int 备注:闲对
		名称:dragon 类型:int 备注:龙
		名称:tiger 类型:int 备注:虎
		名称:dragonTigerTie 类型:int 备注:龙虎和
		名称:score 类型:int 备注:总局数
	}
]]
local function rec_pro_baccarat_ResBankerInfo(msg)
	--add your logic code here
	baccarat_manager:resBankerInfo(msg)
end

--[[
	通知客户端计时消息
	msg = {
		名称:state 类型:int 备注:告知客户端游戏进行到的阶段
		名称:time 类型:int 备注:计时时间(单位秒)
	}
]]
local function rec_pro_baccarat_ResTime(msg)
	--add your logic code here
	baccarat_manager:resTime(msg)
end

--[[
	历史路单记录消息
	msg = {
		名称:hisWaybill 类型:List<int> 备注:历史路单记录
		名称:hisDragon 类型:List<int> 备注:历史龙虎记录
		名称:hisBigSmall 类型:List<int> 备注:历史大小记录
	}
]]
local function rec_pro_baccarat_ResHistory(msg)
	--add your logic code here
	baccarat_manager:resHistory(msg)
end

--[[
	返回结算结果消息
	msg = {
		名称:bankerChips 类型:long 备注:庄家结算筹码
		名称:playerChips 类型:long 备注:玩家结算筹码
	}
]]
local function rec_pro_baccarat_ResBalance(msg)
	--add your logic code here
	baccarat_manager:resBalance(msg)
end

--[[
	开出的结果消息
	msg = {
		名称:result 类型:List<int> 备注:开出结果列表
	}
]]
local function rec_pro_baccarat_ResResult(msg)
	--add your logic code here
	baccarat_manager:resResult(msg)
end

--[[
	清空下注结果消息
	msg = {
		名称:res 类型:int 备注:结果(0:成功,1:下注阶段不能清除下注)
	}
]]
local function rec_pro_baccarat_ResClearBet(msg)
	--add your logic code here
	baccarat_manager:resClearBet(msg)
end

--[[
	切牌信息(切出来的12张牌)消息
	msg = {
		名称:cardsInfo 类型:List<int> 备注:牌信息
	}
]]
local function rec_pro_baccarat_ResCutCards(msg)
	--add your logic code here
	baccarat_manager:resCutCards(msg)
end


ReceiveMsg.regProRecMsg(518201, rec_pro_baccarat_ResEnterGameHall)--进入游戏大厅返回房间数据 处理
ReceiveMsg.regProRecMsg(518202, rec_pro_baccarat_ResChipsChange)--玩家筹码变化消息 处理
ReceiveMsg.regProRecMsg(518204, rec_pro_baccarat_ResReady)--玩家准备 处理
ReceiveMsg.regProRecMsg(518205, rec_pro_baccarat_ResExchangeTable)--请求交换桌子 处理
ReceiveMsg.regProRecMsg(518210, rec_pro_baccarat_ResFastEnterTable)--玩家请求快速进入房间牌桌结果 处理
ReceiveMsg.regProRecMsg(518211, rec_pro_baccarat_ResEnterRoom)--进入房间结果 处理
ReceiveMsg.regProRecMsg(518212, rec_pro_baccarat_ResEnterTable)--进入牌桌结果 处理
ReceiveMsg.regProRecMsg(518215, rec_pro_baccarat_ResExitRoom)--玩家请求退出房间 处理
ReceiveMsg.regProRecMsg(518216, rec_pro_baccarat_ResExitTable)--玩家请求退出房间牌桌结果 处理
ReceiveMsg.regProRecMsg(518217, rec_pro_baccarat_ResMultiple)--返回倍率结果 处理
ReceiveMsg.regProRecMsg(518218, rec_pro_baccarat_ResDealCards)--发牌 处理
ReceiveMsg.regProRecMsg(518219, rec_pro_baccarat_ResOtherEnterTable)--其他人进入桌子 处理
ReceiveMsg.regProRecMsg(518221, rec_pro_baccarat_ResBet)--返回下注结果 处理
ReceiveMsg.regProRecMsg(518222, rec_pro_baccarat_ResTableBet)--桌子筹码变化 处理
ReceiveMsg.regProRecMsg(518224, rec_pro_baccarat_ResBankerInfo)--结果统计信息 处理
ReceiveMsg.regProRecMsg(518225, rec_pro_baccarat_ResTime)--通知客户端计时 处理
ReceiveMsg.regProRecMsg(518226, rec_pro_baccarat_ResHistory)--历史路单记录 处理
ReceiveMsg.regProRecMsg(518227, rec_pro_baccarat_ResBalance)--返回结算结果 处理
ReceiveMsg.regProRecMsg(518228, rec_pro_baccarat_ResResult)--开出的结果 处理
ReceiveMsg.regProRecMsg(518231, rec_pro_baccarat_ResClearBet)--清空下注结果 处理
ReceiveMsg.regProRecMsg(518232, rec_pro_baccarat_ResCutCards)--切牌信息(切出来的12张牌) 处理

--传输对象说明
--[[
	BetInfo = {
		area, --下注区域
		chips, --下注筹码
	}
]]
--[[
	IconMultiple = {
		areaId, --图标ID
		rate, --图标倍率(客户端缩小100倍后显示)
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
--[[
	CardsInfo = {
		cards, --庄家闲家牌
		id, --0庄家，1闲家
		cardsType, --牌型
		point, --点数
	}
]]
