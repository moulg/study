--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
local function rec_pro_bairenniuniu_ResEnterGameHall(msg)
	bairenniuniu_manager:resEnterGameHallMsg(msg)
	
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家ID
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
local function rec_pro_bairenniuniu_ResChipsChange(msg)
	bairenniuniu_manager:resChipsChangeMsg(msg)
	
end


--[[
	请求交换桌子消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:已经准备不能交换桌子,2:当前房间没有空位置
	}
]]
local function rec_pro_bairenniuniu_ResExchangeTable(msg)
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
local function rec_pro_bairenniuniu_ResShowdown(msg)
	
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
local function rec_pro_bairenniuniu_ResFastEnterTable(msg)
	--add your logic code here
	
end

--[[
	进入房间结果消息
	msg = {
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
local function rec_pro_bairenniuniu_ResEnterRoom(msg)
	HallManager:resEnterRoomMsg(msg)
	
end

--[[
	进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
local function rec_pro_bairenniuniu_ResEnterTable(msg)
	bairenniuniu_manager.resEnterTableMsg(msg)
	
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
local function rec_pro_bairenniuniu_ResExitRoom(msg)
	--add your logic code here
	
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
local function rec_pro_bairenniuniu_ResExitTable(msg)
	bairenniuniu_manager:resExitTableMsg(msg)
	
end

--[[
	发牌消息
	msg = {
		名称:cardsInfo 类型:List<CardsInfo> 备注:牌信息
	}
]]
local function rec_pro_bairenniuniu_ResDealCards(msg)
	bairenniuniu_manager:resDealCardsMsg(msg)
	
end

--[[
	其他人进入桌子消息
	msg = {
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
local function rec_pro_bairenniuniu_ResOtherEnterTable(msg)
	bairenniuniu_manager:resOtherPlayerEnterTableMgs(msg)
	
end

--[[
	返回下注结果消息
	msg = {
		名称:area 类型:int 备注:下注区域  闲家1-4
		名称:chips 类型:long 备注:对应的筹码
	}
]]
local function rec_pro_bairenniuniu_ResBet(msg)
	bairenniuniu_manager:resBet(msg)

end

--[[
	桌子筹码变化消息
	msg = {
		名称:betInfo 类型:List<BetInfo> 备注:桌上筹码信息
	}
]]
local function rec_pro_bairenniuniu_ResTableBet(msg)
	bairenniuniu_manager:resTableBet(msg)
	
end

--[[
	玩家申请庄家列表消息
	msg = {
		名称:applicants 类型:List<long> 备注:申请人
	}
]]
local function rec_pro_bairenniuniu_ResApplyBankers(msg)
	bairenniuniu_manager:resApplyBankers(msg)
	
end

--[[
	庄家信息消息
	msg = {
		名称:playerId 类型:long 备注:庄家id
		名称:name 类型:String 备注:昵称
		名称:sex 类型:int 备注:性别 0男1女3系统
		名称:chips 类型:long 备注:筹码
		名称:num 类型:int 备注:局数
		名称:score 类型:long 备注:成绩
	}
]]
local function rec_pro_bairenniuniu_ResBankerInfo(msg)
	bairenniuniu_manager:resBankerInfo(msg)
	
end

--[[
	通知客户端计时消息
	msg = {
		名称:state 类型:int 备注:告知客户端游戏进行到的阶段
		名称:time 类型:int 备注:计时时间(单位秒)
	}
]]
local function rec_pro_bairenniuniu_ResTime(msg)
	bairenniuniu_manager:resTime(msg)
	
end
--[[
	历史输赢记录消息
	msg = {
		名称:result 类型:List<int> 备注:闲家对庄家的输赢记录
	}
]]
local function rec_pro_bairenniuniu_ResHistory(msg)
	bairenniuniu_manager:resHistory(msg)
	
end

--[[
	返回结算结果消息
	msg = {
		名称:bankerChips 类型:long 备注:庄家结算筹码
		名称:playerChips 类型:long 备注:玩家结算筹码
	}
]]
local function rec_pro_bairenniuniu_ResBalance(msg)
	bairenniuniu_manager:resBalance(msg)
	
end

--[[
	清空下注结果消息
	msg = {
		名称:res 类型:int 备注:结果(0:成功,1:下注阶段不能清除下注)
	}
]]
local function rec_pro_bairenniuniu_ResClearBet(msg)
	bairenniuniu_manager:resClearBet(msg)
	
end


ReceiveMsg.regProRecMsg(508201, rec_pro_bairenniuniu_ResEnterGameHall)--进入游戏大厅返回房间数据 处理
ReceiveMsg.regProRecMsg(508202, rec_pro_bairenniuniu_ResChipsChange)--玩家筹码变化消息 处理
ReceiveMsg.regProRecMsg(508204, rec_pro_bairenniuniu_ResReady)--玩家准备 处理
ReceiveMsg.regProRecMsg(508205, rec_pro_bairenniuniu_ResExchangeTable)--请求交换桌子 处理
ReceiveMsg.regProRecMsg(508209, rec_pro_bairenniuniu_ResShowdown)--摊牌结果 处理
ReceiveMsg.regProRecMsg(508210, rec_pro_bairenniuniu_ResFastEnterTable)--玩家请求快速进入房间牌桌结果 处理
ReceiveMsg.regProRecMsg(508211, rec_pro_bairenniuniu_ResEnterRoom)--进入房间结果 处理
ReceiveMsg.regProRecMsg(508212, rec_pro_bairenniuniu_ResEnterTable)--进入牌桌结果 处理
ReceiveMsg.regProRecMsg(508215, rec_pro_bairenniuniu_ResExitRoom)--玩家请求退出房间 处理
ReceiveMsg.regProRecMsg(508216, rec_pro_bairenniuniu_ResExitTable)--玩家请求退出房间牌桌结果 处理
ReceiveMsg.regProRecMsg(508218, rec_pro_bairenniuniu_ResDealCards)--发牌 处理
ReceiveMsg.regProRecMsg(508219, rec_pro_bairenniuniu_ResOtherEnterTable)--其他人进入桌子 处理
ReceiveMsg.regProRecMsg(508221, rec_pro_bairenniuniu_ResBet)--返回下注结果 处理
ReceiveMsg.regProRecMsg(508222, rec_pro_bairenniuniu_ResTableBet)--桌子筹码变化 处理
ReceiveMsg.regProRecMsg(508223, rec_pro_bairenniuniu_ResApplyBankers)--玩家申请庄家列表 处理
ReceiveMsg.regProRecMsg(508224, rec_pro_bairenniuniu_ResBankerInfo)--庄家信息 处理
ReceiveMsg.regProRecMsg(508225, rec_pro_bairenniuniu_ResTime)--通知客户端计时 处理
ReceiveMsg.regProRecMsg(508226, rec_pro_bairenniuniu_ResHistory)--历史输赢记录 处理
ReceiveMsg.regProRecMsg(508227, rec_pro_bairenniuniu_ResBalance)--返回结算结果 处理
ReceiveMsg.regProRecMsg(508231, rec_pro_bairenniuniu_ResClearBet)--清空下注结果 处理

--传输对象说明
--[[
	BetInfo = {
		area, --下注区域
		chips, --下注筹码
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
		cards, --玩家的牌，已经是最优牌型(3+2)
		id, --0-4 :0庄家的牌，1:闲家1，2:闲家2，3:闲家3，4:闲家4
		cardsType, --牌型(0:没牛，1-10:牛1到牛牛,四花:11,四炸:12,五花:13,五小:14)
	}
]]
