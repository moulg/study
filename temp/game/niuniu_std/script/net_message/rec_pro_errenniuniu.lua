--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
local function rec_pro_errenniuniu_ResEnterGameHall(msg)
	niuniu_manager:resEnterGameHallMsg(msg)
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
local function rec_pro_errenniuniu_ResChipsChange(msg)
	niuniu_manager:resChipsChangeMsg(msg)
end


--[[
	玩家准备消息
	msg = {
		名称:playerId 类型:long 备注:准备的玩家
		名称:callPlayerId 类型:long 备注:叫庄的玩家,0代表不需要叫庄
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
local function rec_pro_errenniuniu_ResReady(msg)
	niuniu_manager:resReadyMsg(msg)
end

--[[
	请求交换桌子消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:已经准备不能交换桌子,2:当前房间没有空位置
	}
]]
local function rec_pro_errenniuniu_ResExchangeTable(msg)
	--add your logic code here
	dump(msg)
	if msg.res == 2 then
		TipsManager:showOneButtonTipsPanel( 100014, {}, true )
	end
end

--[[
	请求叫庄家结果消息
	msg = {
		名称:playerId 类型:long 备注:叫庄的玩家
		名称:order 类型:int 备注:位置
		名称:callType 类型:int 备注:0:不叫,非0:叫
		名称:dealer 类型:long 备注:庄家id(0:庄家还未确定)
		名称:nextCallPlayer 类型:long 备注:下一个叫庄的玩家id)
	}
]]
local function rec_pro_errenniuniu_ResCallDealer(msg)
	niuniu_manager:resCallDealerMsg(msg)
end


--[[
	请求下注结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:筹码不合法
		名称:chips 类型:long 备注:筹码
	}
]]
local function rec_pro_errenniuniu_ResBet(msg)
	niuniu_manager:resBetMsg(msg)
end

--[[
	摊牌结果消息
	msg = {
		名称:playerId 类型:long 备注:摊牌的玩家
		名称:cardsType 类型:int 备注:牌型(0:没牛，1-10:牛1到牛牛,四花:11,四炸:12,五花:13,五小:14)
		名称:bestCards 类型:List<int> 备注:最优牌组合(如果有牛展示为3+2)
	}
]]
local function rec_pro_errenniuniu_ResShowdown(msg)
	niuniu_manager:resShowdownMsg(msg)
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
local function rec_pro_errenniuniu_ResFastEnterTable(msg)
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
local function rec_pro_errenniuniu_ResEnterRoom(msg)
	--add your logic code here
	HallManager:resEnterRoomMsg(msg)
end

--[[
	进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
local function rec_pro_errenniuniu_ResEnterTable(msg)
	--add your logic code here
	dump(msg)
	niuniu_manager.resEnterTableMsg(msg)
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
local function rec_pro_errenniuniu_ResExitRoom(msg)
	dump(msg)
	-- HallManager:resExitRoomMsg()
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:playerId 类型:long 备注:退出桌子的玩家
	}
]]
local function rec_pro_errenniuniu_ResExitTable(msg)
	dump(msg)
	niuniu_manager:resExitTableMsg(msg)
end

--[[
	发牌消息
	msg = {
		名称:cards 类型:List<int> 备注:玩家的牌
		名称:tipCards 类型:List<int> 备注:提示的牌(3+2)
		名称:cardsType 类型:int 备注:牌型(0:没牛，1-10:牛1到牛牛,四花:11,四炸:12,五花:13,五小:14)
		名称:chips 类型:long 备注:输赢的筹码(正:赢,负:输)
	}
]]
local function rec_pro_errenniuniu_ResDealCards(msg)
	--add your logic code here
	niuniu_manager:resDealCardsMsg(msg)
end

--[[
	其他人进入桌子消息
	msg = {
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
local function rec_pro_errenniuniu_ResOtherEnterTable(msg)
	--add your logic code here
	niuniu_manager:resOtherPlayerEnterTableMgs(msg)
end

--[[
	游戏结束消息
	msg = {
	}
]]
local function rec_pro_errenniuniu_ResGameOver(msg)
	niuniu_manager:resGameOverMsg(msg)
end


ReceiveMsg.regProRecMsg(502201, rec_pro_errenniuniu_ResEnterGameHall)--进入游戏大厅返回房间数据 处理
ReceiveMsg.regProRecMsg(502202, rec_pro_errenniuniu_ResChipsChange)--玩家筹码变化消息 处理
ReceiveMsg.regProRecMsg(502204, rec_pro_errenniuniu_ResReady)--玩家准备 处理
ReceiveMsg.regProRecMsg(502205, rec_pro_errenniuniu_ResExchangeTable)--请求交换桌子 处理
ReceiveMsg.regProRecMsg(502206, rec_pro_errenniuniu_ResCallDealer)--请求叫庄家结果 处理
ReceiveMsg.regProRecMsg(502208, rec_pro_errenniuniu_ResBet)--请求下注结果 处理
ReceiveMsg.regProRecMsg(502209, rec_pro_errenniuniu_ResShowdown)--摊牌结果 处理
ReceiveMsg.regProRecMsg(502210, rec_pro_errenniuniu_ResFastEnterTable)--玩家请求快速进入房间牌桌结果 处理
ReceiveMsg.regProRecMsg(502211, rec_pro_errenniuniu_ResEnterRoom)--进入房间结果 处理
ReceiveMsg.regProRecMsg(502212, rec_pro_errenniuniu_ResEnterTable)--进入牌桌结果 处理
ReceiveMsg.regProRecMsg(502215, rec_pro_errenniuniu_ResExitRoom)--玩家请求退出房间 处理
ReceiveMsg.regProRecMsg(502216, rec_pro_errenniuniu_ResExitTable)--玩家请求退出房间牌桌结果 处理
ReceiveMsg.regProRecMsg(502218, rec_pro_errenniuniu_ResDealCards)--发牌 处理
ReceiveMsg.regProRecMsg(502219, rec_pro_errenniuniu_ResOtherEnterTable)--其他人进入桌子 处理
ReceiveMsg.regProRecMsg(502230, rec_pro_errenniuniu_ResGameOver)--游戏结束 处理

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
