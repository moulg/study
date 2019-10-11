#remark
--[[
	ItemInfo ={
		名称:id 类型:int 备注:物品id
		名称:num 类型:int 备注:物品数量
	}
]]
function read_com_wly_game_backpack_dto_ItemInfo(sobj)
	local obj = {};
	obj.id = sobj:readInt()
	obj.num = sobj:readInt()
	
	return obj		
end



--[[
	道具列表信息
	msg ={
		名称:items 类型:List<ItemInfo> 备注:物品信息
	}
]]
function rec_parse_backpack_ResItemInfos(sobj)

	if sobj then
		local msg = {}
		local itemsSize = sobj:readInt()
		msg.items = {}
		for i=1, itemsSize do  
			msg.items[i] = read_com_wly_game_backpack_dto_ItemInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	单个道具信息
	msg ={
		名称:item 类型:ItemInfo 备注:物品信息
	}
]]
function rec_parse_backpack_ResItemInfo(sobj)

	if sobj then
		local msg = {}
		msg.item = read_com_wly_game_backpack_dto_ItemInfo(sobj)
		return msg
	end
	return nil
end


--[[
	玩家被其他玩家使用道具
	msg ={
		名称:playerId 类型:long 备注:使用道具的玩家
		名称:itemId 类型:int 备注:物品id
		名称:num 类型:int 备注:物品数量
	}
]]
function rec_parse_backpack_ResUsedItem(sobj)

	if sobj then
		local msg = {}
		msg.playerId = sobj:readLong()
		msg.itemId = sobj:readInt()
		msg.num = sobj:readInt()
		return msg
	end
	return nil
end


s2c_backpack_ResItemInfos_msg = 104201 --[[道具列表信息]]
s2c_backpack_ResItemInfo_msg = 104202 --[[单个道具信息]]
s2c_backpack_ResUsedItem_msg = 104203 --[[玩家被其他玩家使用道具]]

ReceiveMsg.regParseRecMsg(104201, rec_parse_backpack_ResItemInfos)--[[道具列表信息]]
ReceiveMsg.regParseRecMsg(104202, rec_parse_backpack_ResItemInfo)--[[单个道具信息]]
ReceiveMsg.regParseRecMsg(104203, rec_parse_backpack_ResUsedItem)--[[玩家被其他玩家使用道具]]
