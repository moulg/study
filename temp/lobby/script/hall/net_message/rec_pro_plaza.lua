#remark
--[[
	游戏类型消息
	msg = {
		名称:types 类型:List<GameType> 备注:游戏类型
	}
]]
local function rec_pro_plaza_ResGameTypes(msg)
	--add your logic code here
	HallManager:resGameTypesMsg(msg)
end


ReceiveMsg.regProRecMsg(111201, rec_pro_plaza_ResGameTypes)--游戏类型 处理

--传输对象说明
--[[
	GameType = {
		type, --游戏类型(0:我的游戏;1:扑克厅;2:麻将厅;3:街机厅;4:比赛厅;5:休闲厅;6:所有游戏;7:推荐游戏)
		index, --位置索引
		games, --游戏列表
	}
]]
