--[[
	德州扑克大厅数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
local function rec_pro_errentexaspoker_ResGameHall(msg)
	errentexaspoker_manager:resEnterGameHallMsg(msg)
	
end

--[[
	返回请求进入房间结果消息
	msg = {
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
local function rec_pro_errentexaspoker_ResEnterRoom(msg)
	HallManager:resEnterRoomMsg(msg)
	
end

--[[
	返回请求进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
local function rec_pro_errentexaspoker_ResEnterTable(msg)
	errentexaspoker_manager.resEnterTableMsg(msg)
	
end

--[[
	玩家准备消息
	msg = {
		名称:order 类型:int 备注:准备的玩家
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
local function rec_pro_errentexaspoker_ResReady(msg)
	errentexaspoker_manager:resReadyMsg(msg)
	
end

--[[
	底牌消息
	msg = {
		名称:cards 类型:List<int> 备注:底牌
		名称:isNeedInfo 类型:int 备注:是否需要返回告知发牌结束 0:是，1：不是
	}
]]
local function rec_pro_errentexaspoker_ResHiddenCards(msg)
	errentexaspoker_manager:resHiddenCardsMsg(msg)
	
end

--[[
	发牌消息
	msg = {
		名称:landlordOrder 类型:int 备注:庄家座位号
		名称:smallBind 类型:int 备注:小盲注座位号
		名称:binBind 类型:int 备注:大盲注座位号
		名称:cards 类型:List<int> 备注:玩家的牌
	}
]]
local function rec_pro_errentexaspoker_ResDealCards(msg)
	errentexaspoker_manager:resDealCardsMsg(msg)
	
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
local function rec_pro_errentexaspoker_ResExitRoom(msg)
	
	
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:seatInfo 类型:com.wly.game.gamehall.dto.SeatInfo 备注:退桌子信息
	}
]]
local function rec_pro_errentexaspoker_ResExitTable(msg)
	errentexaspoker_manager:resExitTableMsg(msg)
	
end

--[[
	德州扑克房间人数消息
	msg = {
		名称:roomId 类型:int 备注:房间
		名称:type 类型:int 备注:房间类型
		名称:num 类型:int 备注:房间人数
	}
]]
local function rec_pro_errentexaspoker_ResRoomPlayerNum(msg)
	--add your logic code here
	
end

--[[
	通知客户端该轮结束消息
	msg = {
		名称:state 类型:int 备注:当前第几轮
	}
]]
local function rec_pro_errentexaspoker_ResTurnOver(msg)
	errentexaspoker_manager:resTurnOverMsg(msg)
	
end

--[[
	返回下注结果给其他玩家消息
	msg = {
		名称:bet 类型:long 备注:下注数量
		名称:order 类型:int 备注:玩家座位号
		名称:betType 类型:int 备注:下注类型
	}
]]
local function rec_pro_errentexaspoker_ResBet(msg)
	errentexaspoker_manager:resBetResultMsg(msg)
	
end

--[[
	通知下一个玩家下注消息
	msg = {
		名称:order 类型:int 备注:下一个玩家的座位号
		名称:raisetBet 类型:long 备注:当前的加注额度
		名称:curMaxBet 类型:long 备注:当前轮次最大下注数
	}
]]
local function rec_pro_errentexaspoker_ResNextSeat(msg)
	errentexaspoker_manager:resNextSeatMsg(msg)
	
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:order 类型:int 备注:玩家id
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
local function rec_pro_errentexaspoker_ResChipsChange(msg)
	errentexaspoker_manager:resChipsChangeMsg(msg)
	
end

--[[
	玩家请求结算结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有可结算筹码
	}
]]
local function rec_pro_errentexaspoker_ResBill(msg)
	-- errentexaspoker_manager:resBanlanceMsg(msg)
	
end

--[[
	通知其他玩家我进入房间的消息消息
	msg = {
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
local function rec_pro_errentexaspoker_ResOtherPlayer(msg)
	errentexaspoker_manager:resOtherPlayerEnterTableMgs(msg)
	
end

--[[
	游戏结束结算结果消息
	msg = {
		名称:billInfo 类型:List<PlayerBillInfo> 备注:结算信息
		名称:cards 类型:List<PlayerCards> 备注:玩家手上的牌
		名称:type 类型:int 备注:0：正常结算，1：弃牌结算
	}
]]
local function rec_pro_errentexaspoker_ResBanlance(msg)
	errentexaspoker_manager:resBanlanceMsg(msg)
	
end

--[[
	返回亮牌牌信息消息
	msg = {
		名称:cards 类型:List<int> 备注:亮牌牌ID
		名称:order 类型:int 备注:亮牌玩家位置号
	}
]]
local function rec_pro_errentexaspoker_ResLightCard(msg)
	errentexaspoker_manager:resLightCardMsg(msg)
	
end

--[[
	告知机器谁会获胜消息
	msg = {
		名称:order 类型:int 备注:座位号
	}
]]
local function rec_pro_errentexaspoker_ResWin(msg)
	--add your logic code here
	
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
local function rec_pro_errentexaspoker_ResFastEnterTable(msg)
	--add your logic code here
	HallManager:resQuickEnterCurGame(msg)
end


ReceiveMsg.regProRecMsg(515201, rec_pro_errentexaspoker_ResGameHall)--德州扑克大厅数据 处理
ReceiveMsg.regProRecMsg(515202, rec_pro_errentexaspoker_ResEnterRoom)--返回请求进入房间结果 处理
ReceiveMsg.regProRecMsg(515203, rec_pro_errentexaspoker_ResEnterTable)--返回请求进入牌桌结果 处理
ReceiveMsg.regProRecMsg(515204, rec_pro_errentexaspoker_ResReady)--玩家准备 处理
ReceiveMsg.regProRecMsg(515206, rec_pro_errentexaspoker_ResHiddenCards)--底牌 处理
ReceiveMsg.regProRecMsg(515207, rec_pro_errentexaspoker_ResDealCards)--发牌 处理
ReceiveMsg.regProRecMsg(515210, rec_pro_errentexaspoker_ResExitRoom)--玩家请求退出房间 处理
ReceiveMsg.regProRecMsg(515213, rec_pro_errentexaspoker_ResExitTable)--玩家请求退出房间牌桌结果 处理
ReceiveMsg.regProRecMsg(515216, rec_pro_errentexaspoker_ResRoomPlayerNum)--德州扑克房间人数 处理
ReceiveMsg.regProRecMsg(515217, rec_pro_errentexaspoker_ResTurnOver)--通知客户端该轮结束 处理
ReceiveMsg.regProRecMsg(515219, rec_pro_errentexaspoker_ResBet)--返回下注结果给其他玩家 处理
ReceiveMsg.regProRecMsg(515220, rec_pro_errentexaspoker_ResNextSeat)--通知下一个玩家下注 处理
ReceiveMsg.regProRecMsg(515221, rec_pro_errentexaspoker_ResChipsChange)--玩家筹码变化消息 处理
ReceiveMsg.regProRecMsg(515222, rec_pro_errentexaspoker_ResBill)--玩家请求结算结果 处理
ReceiveMsg.regProRecMsg(515223, rec_pro_errentexaspoker_ResOtherPlayer)--通知其他玩家我进入房间的消息 处理
ReceiveMsg.regProRecMsg(515224, rec_pro_errentexaspoker_ResBanlance)--游戏结束结算结果 处理
ReceiveMsg.regProRecMsg(515225, rec_pro_errentexaspoker_ResLightCard)--返回亮牌牌信息 处理
ReceiveMsg.regProRecMsg(515226, rec_pro_errentexaspoker_ResWin)--告知机器谁会获胜 处理
ReceiveMsg.regProRecMsg(515227, rec_pro_errentexaspoker_ResFastEnterTable)--玩家请求快速进入房间牌桌结果 处理

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
	CardInfo = {
		suit, --花色
		number, --牌号
	}
]]
--[[
	PlayerCards = {
		order, --玩家作为号
		cards, --玩家手上的牌
	}
]]
--[[
	PlayerBillInfo = {
		order, --玩家座位号
		bet, --结算的筹码
	}
]]
