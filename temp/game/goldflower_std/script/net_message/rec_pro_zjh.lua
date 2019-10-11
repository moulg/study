--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
local function rec_pro_zjh_ResEnterGameHall(msg)
	--add your logic code here
	goldflower_manager:resEnterGameHall(msg)
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
local function rec_pro_zjh_ResChipsChange(msg)
	--add your logic code here
	goldflower_manager:resChipsChange(msg)
end

--[[
	玩家准备消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:准备的玩家id
		名称:res 类型:int 备注:0:成功,1:重复准备
	}
]]
local function rec_pro_zjh_ResReady(msg)
	--add your logic code here
	goldflower_manager:resReady(msg)
end

--[[
	请求交换桌子消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:已经准备不能交换桌子,2:当前房间没有空位置
	}
]]
local function rec_pro_zjh_ResExchangeTable(msg)
	--add your logic code here
	goldflower_manager:resExchangeTable(msg)
end

--[[
	请求下注结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:筹码不合法
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:准备的玩家id
		名称:chips 类型:long 备注:筹码
		名称:type 类型:int 备注:0:暗注,非0:明注
		名称:nextOptOrder 类型:int 备注:下一个操作玩家order
		名称:nextOptPlayerId 类型:long 备注:下一个操作玩家id
	}
]]
local function rec_pro_zjh_ResBet(msg)
	--add your logic code here
	goldflower_manager:resBet(msg)
end

--[[
	玩家请求快速进入房间牌桌结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
local function rec_pro_zjh_ResFastEnterTable(msg)
	--add your logic code here
	goldflower_manager:resFastEnterTable(msg)
end

--[[
	进入房间结果消息
	msg = {
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
local function rec_pro_zjh_ResEnterRoom(msg)
	--add your logic code here
	goldflower_manager:resEnterRoom(msg)
end

--[[
	进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
local function rec_pro_zjh_ResEnterTable(msg)
	--add your logic code here
	goldflower_manager:resEnterTable(msg)
end

--[[
	玩家请求退出房间消息
	msg = {
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
local function rec_pro_zjh_ResExitRoom(msg)
	--add your logic code here
	goldflower_manager:resExitRoom(msg)
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
local function rec_pro_zjh_ResExitTable(msg)
	--add your logic code here
	goldflower_manager:resExitTable(msg)
end

--[[
	其他人进入桌子消息
	msg = {
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
local function rec_pro_zjh_ResOtherEnterTable(msg)
	--add your logic code here
	goldflower_manager:resOtherEnterTable(msg)
end

--[[
	所有玩家准备，准备结束消息
	msg = {
		名称:nextOptOrder 类型:int 备注:下一个操作玩家order
		名称:nextOptPlayerId 类型:long 备注:下一个操作玩家id
	}
]]
local function rec_pro_zjh_ResReadyOver(msg)
	--add your logic code here
	goldflower_manager:resReadyOver(msg)
end

--[[
	游戏结束消息
	msg = {
		名称:billInfos 类型:List<BillInfo> 备注:结算信息
	}
]]
local function rec_pro_zjh_ResGameOver(msg)
	--add your logic code here
	goldflower_manager:resGameOver(msg)
end

--[[
	看牌结果消息
	msg = {
		名称:cardsType 类型:int 备注:牌型(0:235,1:单张,2:对子,3:顺子,4:金华,5:顺金,6:豹子)
		名称:cards 类型:List<int> 备注:牌
	}
]]
local function rec_pro_zjh_ResSeeCard(msg)
	--add your logic code here
	goldflower_manager:resSeeCard(msg)
end

--[[
	玩家看过牌消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
	}
]]
local function rec_pro_zjh_ResSawCard(msg)
	--add your logic code here
	goldflower_manager:resSawCard(msg)
end

--[[
	弃牌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:退桌玩家id
		名称:nextOptOrder 类型:int 备注:下一个操作玩家order(-1表示没有)
		名称:nextOptPlayerId 类型:long 备注:下一个操作玩家id(0表示没有)
	}
]]
local function rec_pro_zjh_ResDiscard(msg)
	--add your logic code here
	goldflower_manager:resDiscard(msg)
end

--[[
	比牌结果消息
	msg = {
		名称:win 类型:int 备注:0:输,非0:赢
		名称:playerId 类型:long 备注:主动比牌玩家id
		名称:vsPlayerId 类型:long 备注:被比牌玩家id
		名称:nextOptOrder 类型:int 备注:下一个操作玩家order(-1表示没有)
		名称:nextOptPlayerId 类型:long 备注:下一个操作玩家id(0表示没有)
	}
]]
local function rec_pro_zjh_ResVersus(msg)
	--add your logic code here
	 goldflower_manager:resVersus(msg)
end
--[[
	看牌结果消息
	msg = {
		名称:win 类型:int 备注:0:输,非0:赢
		名称:cardsType 类型:int 备注:牌型(0:235,1:单张,2:对子,3:顺子,4:金华,5:顺金,6:豹子)
		名称:cards 类型:List<int> 备注:牌
	}
]]
local function rec_pro_zjh_ResRobotSeeCard(msg)
	--add your logic code here
	
end


ReceiveMsg.regProRecMsg(510201, rec_pro_zjh_ResEnterGameHall)--进入游戏大厅返回房间数据 处理
ReceiveMsg.regProRecMsg(510202, rec_pro_zjh_ResChipsChange)--玩家筹码变化消息 处理
ReceiveMsg.regProRecMsg(510204, rec_pro_zjh_ResReady)--玩家准备 处理
ReceiveMsg.regProRecMsg(510205, rec_pro_zjh_ResExchangeTable)--请求交换桌子 处理
ReceiveMsg.regProRecMsg(510208, rec_pro_zjh_ResBet)--请求下注结果 处理
ReceiveMsg.regProRecMsg(510210, rec_pro_zjh_ResFastEnterTable)--玩家请求快速进入房间牌桌结果 处理
ReceiveMsg.regProRecMsg(510211, rec_pro_zjh_ResEnterRoom)--进入房间结果 处理
ReceiveMsg.regProRecMsg(510212, rec_pro_zjh_ResEnterTable)--进入牌桌结果 处理
ReceiveMsg.regProRecMsg(510215, rec_pro_zjh_ResExitRoom)--玩家请求退出房间 处理
ReceiveMsg.regProRecMsg(510216, rec_pro_zjh_ResExitTable)--玩家请求退出房间牌桌结果 处理
ReceiveMsg.regProRecMsg(510219, rec_pro_zjh_ResOtherEnterTable)--其他人进入桌子 处理
ReceiveMsg.regProRecMsg(510220, rec_pro_zjh_ResReadyOver)--所有玩家准备，准备结束 处理
ReceiveMsg.regProRecMsg(510230, rec_pro_zjh_ResGameOver)--游戏结束 处理
ReceiveMsg.regProRecMsg(510231, rec_pro_zjh_ResSeeCard)--看牌结果 处理
ReceiveMsg.regProRecMsg(510232, rec_pro_zjh_ResSawCard)--玩家看过牌 处理
ReceiveMsg.regProRecMsg(510233, rec_pro_zjh_ResDiscard)--弃牌结果 处理
ReceiveMsg.regProRecMsg(510234, rec_pro_zjh_ResVersus)--比牌结果 处理
ReceiveMsg.regProRecMsg(510235, rec_pro_zjh_ResRobotSeeCard)--看牌结果 处理

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
		base, --底注
		top, --封顶
		chip1, --筹码1
		chip2, --筹码2
		chip3, --筹码3
		status, --状态(空闲,普通,拥挤,爆满)
		displayNames, --展示的属性名称
		placeHolder, --展示的属性名称占位符
	}
]]
--[[
	BillInfo = {
		order, --座位顺序
		playerName, --玩家昵称
		chips, --结算筹码(包含喜钱)
		luck, --喜钱
		cardsType, --牌型(0:235,1:单张,2:对子,3:顺子,4:金华,5:顺金,6:豹子)
		cards, --牌
	}
]]
