--[[
	RoomTypeDetailInfo ={
		名称:type 类型:int 备注:房间类型id
		名称:typeName 类型:String 备注:房间类型名称
		名称:rooms 类型:List<RoomInfo> 备注:房间
	}
]]
function read_com_wly_game_games_shuihu_dto_RoomTypeDetailInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.typeName = sobj:readString()
	local roomsSize = sobj:readInt()
	obj.rooms = {}
	for i=1, roomsSize do  
		obj.rooms[i] = read_com_wly_game_games_shuihu_dto_RoomInfo(sobj)
	end 	
	
	return obj		
end

--[[
	RoomInfo ={
		名称:roomId 类型:int 备注:房间id
		名称:name 类型:String 备注:房间名称
		名称:type 类型:int 备注:房间类型
		名称:maxNum 类型:int 备注:房间最大人数
		名称:free 类型:int 备注:空闲状态人数
		名称:general 类型:int 备注:普通状态人数
		名称:crowded 类型:int 备注:拥挤状态人数
		名称:full 类型:int 备注:爆满人数
		名称:lower 类型:int 备注:进入下限
		名称:upper 类型:int 备注:进入上限
		名称:proportionGold 类型:int 备注:金币比例
		名称:proportionChips 类型:int 备注:筹码比例
		名称:tabble 类型:int 备注:每桌椅子数
		名称:afee 类型:int 备注:单局台费
		名称:inType 类型:int 备注:进入类型（0点击入座，1自动分配）
		名称:playerNum 类型:int 备注:玩家人数
		名称:status 类型:String 备注:状态(空闲,普通,拥挤,爆满)
		名称:displayNames 类型:String 备注:展示的属性名称
		名称:placeHolder 类型:String 备注:展示的属性名称占位符
	}
]]
function read_com_wly_game_games_shuihu_dto_RoomInfo(sobj)
	local obj = {};
	obj.roomId = sobj:readInt()
	obj.name = sobj:readString()
	obj.type = sobj:readInt()
	obj.maxNum = sobj:readInt()
	obj.free = sobj:readInt()
	obj.general = sobj:readInt()
	obj.crowded = sobj:readInt()
	obj.full = sobj:readInt()
	obj.lower = sobj:readInt()
	obj.upper = sobj:readInt()
	obj.proportionGold = sobj:readInt()
	obj.proportionChips = sobj:readInt()
	obj.tabble = sobj:readInt()
	obj.afee = sobj:readInt()
	obj.inType = sobj:readInt()
	obj.playerNum = sobj:readInt()
	obj.status = sobj:readString()
	obj.displayNames = sobj:readString()
	obj.placeHolder = sobj:readString()
	
	return obj		
end

--[[
	LineRewardIcons ={
		名称:line 类型:int 备注:中奖线路(从1开始)
		名称:icon 类型:int 备注:中奖图标
		名称:indexs 类型:List<int> 备注:中奖图标索引(从1开始)
	}
]]
function read_com_wly_game_games_shuihu_dto_LineRewardIcons(sobj)
	local obj = {};
	obj.line = sobj:readInt()
	obj.icon = sobj:readInt()
	local indexsSize = sobj:readInt()
	obj.indexs = {}
	for i=1, indexsSize do  
		obj.indexs[i] = sobj:readInt()
	end 	
	
	return obj		
end



--[[
	进入游戏大厅返回房间数据
	msg ={
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function rec_parse_shuihu_ResEnterGameHall(sobj)

	if sobj then
		local msg = {}
		local roomTypesSize = sobj:readInt()
		msg.roomTypes = {}
		for i=1, roomTypesSize do  
			msg.roomTypes[i] = read_com_wly_game_games_shuihu_dto_RoomTypeDetailInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	玩家筹码变化消息
	msg ={
		名称:playerId 类型:long 备注:玩家id
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
function rec_parse_shuihu_ResChipsChange(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.chips = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	玩家请求快速进入房间牌桌结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:没有空位置
	}
]]
function rec_parse_shuihu_ResFastEnterTable(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求进入房间结果
	msg ={
		名称:tables 类型:List<com.wly.game.gamehall.dto.TableInfo> 备注:牌桌信息
		名称:members 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:房间座位信息
	}
]]
function rec_parse_shuihu_ResEnterRoom(sobj)

	if sobj then
		local msg = {}
		local tablesSize = sobj:readInt()
		msg.tables = {}
		for i=1, tablesSize do  
			msg.tables[i] = read_com_wly_game_gamehall_dto_TableInfo(sobj)
		end 	
		local membersSize = sobj:readInt()
		msg.members = {}
		for i=1, membersSize do  
			msg.members[i] = read_com_wly_game_gamehall_dto_MemInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	请求进入牌桌
	msg ={
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
function rec_parse_shuihu_ResEnterTable(sobj)

	if sobj then
		local msg = {}
		local memsSize = sobj:readInt()
		msg.mems = {}
		for i=1, memsSize do  
			msg.mems[i] = read_com_wly_game_gamehall_dto_MemInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	玩家请求退出房间
	msg ={
		名称:res 类型:int 备注:0:退出成功,1:在牌桌中退出失败
	}
]]
function rec_parse_shuihu_ResExitRoom(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	玩家请求退出房间牌桌结果
	msg ={
	}
]]
function rec_parse_shuihu_ResExitTable(sobj)

	if sobj then
		local msg = {}
		return msg
	end
	return nil
end


--[[
	水浒传游戏开始结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:筹码不足
		名称:type 类型:int 备注:类型(0:普通连线奖励 ,全盘奖励[1:铁斧,2:银枪,3:金刀,4:鲁智深,5:林冲,6:宋江,7:替天行道,8:忠义堂,9:水浒传,10:人物,11:武器]
		名称:bonus 类型:int 备注:bonus次数
		名称:icons 类型:List<int> 备注:图标(固定15个,按行取,每行5个)
		名称:lineRewards 类型:List<LineRewardIcons> 备注:线路中奖图标信息
		名称:totalWin 类型:long 备注:合计赢的筹码(0:没有赢)
	}
]]
function rec_parse_shuihu_ResShuiHuStart(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		msg.type = sobj:readInt()
		msg.bonus = sobj:readInt()
		local iconsSize = sobj:readInt()
		msg.icons = {}
		for i=1, iconsSize do  
			msg.icons[i] = sobj:readInt()
		end 	
		local lineRewardsSize = sobj:readInt()
		msg.lineRewards = {}
		for i=1, lineRewardsSize do  
			msg.lineRewards[i] = read_com_wly_game_games_shuihu_dto_LineRewardIcons(sobj)
		end 	
		msg.totalWin = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	骰子游戏开始结果
	msg ={
		名称:res 类型:int 备注:0:开始成功,1:双比筹码不足
		名称:win 类型:long 备注:0:输,非0:本局赢得的筹码
		名称:point1 类型:int 备注:骰子1点数
		名称:point2 类型:int 备注:骰子2点数
		名称:totalWin 类型:long 备注:合计赢的筹码(0:没有赢)
	}
]]
function rec_parse_shuihu_ResDiceGameStart(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		msg.win = sobj:readLong()
		msg.point1 = sobj:readInt()
		msg.point2 = sobj:readInt()
		msg.totalWin = sobj:readLong()
		return msg
	end
	return nil
end


--[[
	小玛丽开始
	msg ={
		名称:insideIcons 类型:List<int> 备注:内部图标
		名称:outsideIcon 类型:int 备注:外部图标
		名称:win 类型:long 备注:当前赢的筹码(0:没有赢)
		名称:totalWin 类型:long 备注:合计赢的筹码(0:没有赢)
		名称:over 类型:int 备注:是否结束(0:没有结束,非0:结束)
	}
]]
function rec_parse_shuihu_ResXiaoMaLiStart(sobj)

	if sobj then
		local msg = {}
		local insideIconsSize = sobj:readInt()
		msg.insideIcons = {}
		for i=1, insideIconsSize do  
			msg.insideIcons[i] = sobj:readInt()
		end 	
		msg.outsideIcon = sobj:readInt()
		msg.win = sobj:readLong()
		msg.totalWin = sobj:readLong()
		msg.over = sobj:readInt()
		return msg
	end
	return nil
end


--[[
	请求结算结果
	msg ={
	}
]]
function rec_parse_shuihu_ResBill(sobj)

	if sobj then
		local msg = {}
		return msg
	end
	return nil
end


--[[
	请求兑换筹码结果
	msg ={
		名称:chips 类型:long 备注:兑换后的筹码
	}
]]
function rec_parse_shuihu_ResExchangeChips(sobj)

	if sobj then
		local msg = {}
		msg.chips = sobj:readLong()
		return msg
	end
	return nil
end


s2c_shuihu_ResEnterGameHall_msg = 503201 --[[进入游戏大厅返回房间数据]]
s2c_shuihu_ResChipsChange_msg = 503202 --[[玩家筹码变化消息]]
s2c_shuihu_ResFastEnterTable_msg = 503206 --[[玩家请求快速进入房间牌桌结果]]
s2c_shuihu_ResEnterRoom_msg = 503207 --[[请求进入房间结果]]
s2c_shuihu_ResEnterTable_msg = 503208 --[[请求进入牌桌]]
s2c_shuihu_ResExitRoom_msg = 503210 --[[玩家请求退出房间]]
s2c_shuihu_ResExitTable_msg = 503211 --[[玩家请求退出房间牌桌结果]]
s2c_shuihu_ResShuiHuStart_msg = 503212 --[[水浒传游戏开始结果]]
s2c_shuihu_ResDiceGameStart_msg = 503213 --[[骰子游戏开始结果]]
s2c_shuihu_ResXiaoMaLiStart_msg = 503214 --[[小玛丽开始]]
s2c_shuihu_ResBill_msg = 503215 --[[请求结算结果]]
s2c_shuihu_ResExchangeChips_msg = 503216 --[[请求兑换筹码结果]]

ReceiveMsg.regParseRecMsg(503201, rec_parse_shuihu_ResEnterGameHall)--[[进入游戏大厅返回房间数据]]
ReceiveMsg.regParseRecMsg(503202, rec_parse_shuihu_ResChipsChange)--[[玩家筹码变化消息]]
ReceiveMsg.regParseRecMsg(503206, rec_parse_shuihu_ResFastEnterTable)--[[玩家请求快速进入房间牌桌结果]]
ReceiveMsg.regParseRecMsg(503207, rec_parse_shuihu_ResEnterRoom)--[[请求进入房间结果]]
ReceiveMsg.regParseRecMsg(503208, rec_parse_shuihu_ResEnterTable)--[[请求进入牌桌]]
ReceiveMsg.regParseRecMsg(503210, rec_parse_shuihu_ResExitRoom)--[[玩家请求退出房间]]
ReceiveMsg.regParseRecMsg(503211, rec_parse_shuihu_ResExitTable)--[[玩家请求退出房间牌桌结果]]
ReceiveMsg.regParseRecMsg(503212, rec_parse_shuihu_ResShuiHuStart)--[[水浒传游戏开始结果]]
ReceiveMsg.regParseRecMsg(503213, rec_parse_shuihu_ResDiceGameStart)--[[骰子游戏开始结果]]
ReceiveMsg.regParseRecMsg(503214, rec_parse_shuihu_ResXiaoMaLiStart)--[[小玛丽开始]]
ReceiveMsg.regParseRecMsg(503215, rec_parse_shuihu_ResBill)--[[请求结算结果]]
ReceiveMsg.regParseRecMsg(503216, rec_parse_shuihu_ResExchangeChips)--[[请求兑换筹码结果]]
