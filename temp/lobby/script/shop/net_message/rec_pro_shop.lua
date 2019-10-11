#remark
--[[
	购买物品结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:钱不够
		名称:item 类型:com.wly.game.backpack.dto.ItemInfo 备注:购买的道具信息
	}
]]
local function rec_pro_shop_ResBuyItem(msg)
	--add your logic code here
	shop_manager:resBuyItem(msg)
end

local function rec_pro_shop_ResGoodsItem(msg)
	--add your logic code here
	HallManager:resGoodsItem(msg)
end

local function rec_pro_shop_ResPay(msg)
	shop_manager:resPay(msg)
end


ReceiveMsg.regProRecMsg(103201, rec_pro_shop_ResBuyItem)--购买物品结果 处理

ReceiveMsg.regProRecMsg(200001, rec_pro_shop_ResPay) --[[支付响应]]

ReceiveMsg.regProRecMsg(200003, rec_pro_shop_ResGoodsItem) --[[元宝列表]]

--传输对象说明
