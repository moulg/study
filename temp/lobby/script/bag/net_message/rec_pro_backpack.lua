#remark
--[[
	道具列表信息消息
	msg = {
		名称:items 类型:List<ItemInfo> 备注:物品信息
	}
]]
local function rec_pro_backpack_ResItemInfos(msg)
	back_pack_manager:resItemInfos(msg)
end

--[[
	单个道具信息消息
	msg = {
		名称:item 类型:ItemInfo 备注:物品信息
	}
]]
local function rec_pro_backpack_ResItemInfo(msg)
	back_pack_manager:resItemInfo(msg)
end

--[[
	玩家被其他玩家使用道具消息
	msg = {
		名称:playerId 类型:long 备注:使用道具的玩家
		名称:itemId 类型:int 备注:物品id
		名称:num 类型:int 备注:物品数量
	}
]]
local function rec_pro_backpack_ResUsedItem(msg)
	back_pack_manager:resUsedItem(msg)
end


ReceiveMsg.regProRecMsg(104201, rec_pro_backpack_ResItemInfos)--道具列表信息 处理
ReceiveMsg.regProRecMsg(104202, rec_pro_backpack_ResItemInfo)--单个道具信息 处理
ReceiveMsg.regProRecMsg(104203, rec_pro_backpack_ResUsedItem)--玩家被其他玩家使用道具 处理

--传输对象说明
--[[
	ItemInfo = {
		id, --物品id
		num, --物品数量
	}
]]
