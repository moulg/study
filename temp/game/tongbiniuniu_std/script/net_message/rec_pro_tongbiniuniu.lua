--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
local function rec_pro_tongbiniuniu_ResEnterGameHall(msg)
	tongbiniuniu_manager:resEnterGameHallMsg(msg)
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
local function rec_pro_tongbiniuniu_ResChipsChange(msg)
	tongbiniuniu_manager:resChipsChangeMsg(msg)
end

--[[
	玩家准备消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
local function rec_pro_tongbiniuniu_ResReady(msg)
	if msg.res == 0 then
		tongbiniuniu_manager:resReadyMsg(msg)
	end
end

--[[
	请求交换桌子消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:已经准备不能交换桌子,2:当前房间没有空位置
	}
]]
local function rec_pro_tongbiniuniu_ResExchangeTable(msg)
	--add your logic code here
	
end

--[[
	摊牌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:cardsType 类型:int 备注:牌型(0:没牛，1-10:牛1到牛牛,四花:11,四炸:12,五花:13,五小:14)
		名称:bestCards 类型:List<int> 备注:最优牌组合(如果有牛展示为3+2)
	}
]]
local function rec_pro_tongbiniuniu_ResShowdown(msg)
	tongbiniuniu_manager:resShowdownMsg(msg)
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
local function rec_pro_tongbiniuniu_ResFastEnterTable(msg)
	--add your logic code here
	
end

--[[
	进入房间结果消息
	msg = {
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
local function rec_pro_tongbiniuniu_ResEnterRoom(msg)
	HallManager:resEnterRoomMsg(msg)
	
end

--[[
	进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
local function rec_pro_tongbiniuniu_ResEnterTable(msg)
	tongbiniuniu_manager.resEnterTableMsg(msg)
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
local function rec_pro_tongbiniuniu_ResExitRoom(msg)
	--add your logic code here
	
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
local function rec_pro_tongbiniuniu_ResExitTable(msg)
	tongbiniuniu_manager:resExitTableMsg(msg)
end

--[[
	发牌消息
	msg = {
		名称:cards 类型:List<int> 备注:玩家的牌，已经是最优牌型(3+2)
		名称:cardsType 类型:int 备注:牌型(0:没牛，1-10:牛1到牛牛,四花:11,四炸:12,五花:13,五小:14)
	}
]]
local function rec_pro_tongbiniuniu_ResDealCards(msg)
	tongbiniuniu_manager:resDealCardsMsg(msg)
end

--[[
	其他人进入桌子消息
	msg = {
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
local function rec_pro_tongbiniuniu_ResOtherEnterTable(msg)
	tongbiniuniu_manager:resOtherPlayerEnterTableMgs(msg)
end

--[[
	所有玩家准备，准备结束消息
	msg = {
	}
]]
local function rec_pro_tongbiniuniu_ResReadyOver(msg)
	tongbiniuniu_manager:resReadyOverMsg(msg)
end

--[[
	游戏结束消息
	msg = {
		名称:billInfos 类型:List<BillInfo> 备注:结算信息
	}
]]
local function rec_pro_tongbiniuniu_ResGameOver(msg)
	tongbiniuniu_manager:resGameOverMsg(msg)
end


ReceiveMsg.regProRecMsg(514201, rec_pro_tongbiniuniu_ResEnterGameHall)--进入游戏大厅返回房间数据 处理
ReceiveMsg.regProRecMsg(514202, rec_pro_tongbiniuniu_ResChipsChange)--玩家筹码变化消息 处理
ReceiveMsg.regProRecMsg(514204, rec_pro_tongbiniuniu_ResReady)--玩家准备 处理
ReceiveMsg.regProRecMsg(514205, rec_pro_tongbiniuniu_ResExchangeTable)--请求交换桌子 处理
ReceiveMsg.regProRecMsg(514209, rec_pro_tongbiniuniu_ResShowdown)--摊牌结果 处理
ReceiveMsg.regProRecMsg(514210, rec_pro_tongbiniuniu_ResFastEnterTable)--玩家请求快速进入房间牌桌结果 处理
ReceiveMsg.regProRecMsg(514211, rec_pro_tongbiniuniu_ResEnterRoom)--进入房间结果 处理
ReceiveMsg.regProRecMsg(514212, rec_pro_tongbiniuniu_ResEnterTable)--进入牌桌结果 处理
ReceiveMsg.regProRecMsg(514215, rec_pro_tongbiniuniu_ResExitRoom)--玩家请求退出房间 处理
ReceiveMsg.regProRecMsg(514216, rec_pro_tongbiniuniu_ResExitTable)--玩家请求退出房间牌桌结果 处理
ReceiveMsg.regProRecMsg(514218, rec_pro_tongbiniuniu_ResDealCards)--发牌 处理
ReceiveMsg.regProRecMsg(514219, rec_pro_tongbiniuniu_ResOtherEnterTable)--其他人进入桌子 处理
ReceiveMsg.regProRecMsg(514220, rec_pro_tongbiniuniu_ResReadyOver)--所有玩家准备，准备结束 处理
ReceiveMsg.regProRecMsg(514230, rec_pro_tongbiniuniu_ResGameOver)--游戏结束 处理

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
--[[
	BillInfo = {
		order, --座位顺序
		chips, --结算筹码
	}
]]
