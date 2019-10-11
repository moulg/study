#remark
--[[
背包管理类
]]

back_pack_manager = {}

--[[
获得道具信息
]]
function back_pack_manager:getItemInfo( id )
	local pinfo = get_player_info()
	for i,v in ipairs(pinfo.backpack_list) do
		if v.id == id then
			return v
		end
	end

	return {id = id, num = 0}
end


--[[
	道具列表信息消息
	msg = {
		名称:items 类型:List<ItemInfo> 备注:物品信息
	}
]]
function back_pack_manager:resItemInfos(msg)
	if msg.items ~= nil then
		local pinfo = get_player_info()
		pinfo.backpack_list = msg.items
	end
end

--[[
	单个道具信息消息
	msg = {
		名称:item 类型:ItemInfo 备注:物品信息
	}
]]
function back_pack_manager:resItemInfo(msg)
	if msg.item then
		local pinfo = get_player_info()
		local bIsHave = false
		for i,v in ipairs(pinfo.backpack_list) do
			if v.id == msg.item.id then
				v.num = msg.item.num
				bIsHave = true
				break
			end
		end
		if bIsHave == false then
			table.insert(pinfo.backpack_list, msg.item)
		end

	end
end

--[[
	玩家被其他玩家使用道具消息
	msg = {
		名称:playerId 类型:long 备注:使用道具的玩家
		名称:itemId 类型:int 备注:物品id
		名称:num 类型:int 备注:物品数量
	}
]]
function back_pack_manager:resUsedItem(msg)
	if item_src_config[msg.itemId].eff_type == 2 then
		WindowScene.getInstance():playPropAni(msg.itemId)
	end
end
