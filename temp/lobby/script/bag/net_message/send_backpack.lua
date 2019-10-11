#remark
--[[
	ItemInfo ={
		名称:id 类型:int 备注:物品id
		名称:num 类型:int 备注:物品数量
	}
]]
local function write_ItemInfo(stream,bean)
	if bean.id == nil then bean.id = 0 end
	stream:writeInt(bean.id)
	if bean.num == nil then bean.num = 0 end
	stream:writeInt(bean.num)
end



--[[
	玩家使用道具
	ReqUseItem ={
		名称:itemId 类型:int 备注:物品id
		名称:num 类型:int 备注:物品数量
		名称:target 类型:long 备注:目标玩家
		名称:remark 类型:String 备注:备注
	}
]]
function send_backpack_ReqUseItem(msg)
	local stream = CNetStream()
	stream:writeInt(104101)
	
	if msg.itemId == nil then msg.itemId = 0 end
	stream:writeInt(msg.itemId)
	if msg.num == nil then msg.num = 0 end
	stream:writeInt(msg.num)
	if msg.target == nil then msg.target = 0 end
	stream:writeLong(msg.target)
	if msg.remark == nil then msg.remark = "" end
	stream:writeString(msg.remark)
	GetSocketInstance():send(stream)
end


--[[
	玩家抛弃道具
	ReqAbandonItem ={
		名称:itemId 类型:int 备注:物品id
	}
]]
function send_backpack_ReqAbandonItem(msg)
	local stream = CNetStream()
	stream:writeInt(104102)
	
	if msg.itemId == nil then msg.itemId = 0 end
	stream:writeInt(msg.itemId)
	GetSocketInstance():send(stream)
end


c2s_backpack_ReqUseItem_msg = 104101 --[[玩家使用道具]]
c2s_backpack_ReqAbandonItem_msg = 104102 --[[玩家抛弃道具]]
