#remark
--[[
	购买物品结果
	msg ={
		名称:res 类型:int 备注:0:成功,1:钱不够
		名称:item 类型:com.wly.game.backpack.dto.ItemInfo 备注:购买的道具信息
	}
]]
function rec_parse_shop_ResBuyItem(sobj)

	if sobj then
		local msg = {}
		msg.res = sobj:readInt()
		msg.item = read_com_wly_game_backpack_dto_ItemInfo(sobj)
		return msg
	end
	return nil
end

--[[
   元宝列表
   {
	  id    -- 商品id
	  price -- 商品价格
	  name  -- 商品名称
	  give  -- 赠送金币
   }
]]
function rec_parse_shop_ResGoodsItem(sobj)
	if sobj then
		local msg = {}
		local itemSize = sobj:readInt()
		msg.size = itemSize
		msg.items = {}
		for i=1, itemSize do  
			msg.items[i]={}
			msg.items[i].payid = sobj:readInt()               -- id
			msg.items[i].price = sobj:readInt()            -- 价格
			msg.items[i].name = sobj:readInt().."元宝"     -- 元宝数
			msg.items[i].give = sobj:readInt()             -- 赠送的金币
			msg.items[i].currency = 1
			msg.items[i].type = 1
			msg.items[i].id = 10 + i
		end 	
		return msg
	end
	return nil
end

--[[
   支付响应
]]
function rec_parse_shop_ResPay(sobj)
	if sobj then
		local msg = {}
		msg.money = sobj:readLong()
		msg.payUrl = sobj:readString()
		msg.orderNo = sobj:readString()
		msg.iosId = sobj:readString()
		return msg
	end
	return nil
end


s2c_shop_ResBuyItem_msg = 103201 --[[购买物品结果]]
s2c_shop_ResGoodsItem_msg = 200003 --[[支付响应]]
s2c_shop_ResPay_msg = 200001 --[[元宝列表]]

ReceiveMsg.regParseRecMsg(103201, rec_parse_shop_ResBuyItem)--[[购买物品结果]]
ReceiveMsg.regParseRecMsg(200003, rec_parse_shop_ResGoodsItem)--[[元宝列表]]
ReceiveMsg.regParseRecMsg(200001, rec_parse_shop_ResPay)--[[支付响应]]
