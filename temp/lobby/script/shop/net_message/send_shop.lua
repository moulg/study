#remark
--[[
	购买物品
	ReqBuyItem ={
		名称:itemId 类型:int 备注:物品id
		名称:num 类型:int 备注:物品数量
		名称:moneyType 类型:byte 备注:货币类型(1:元宝,2:金币)
	}
]]
function send_shop_ReqBuyItem(msg)
	local stream = CNetStream()
	stream:writeInt(103101)
	
	if msg.itemId == nil then msg.itemId = 0 end
	stream:writeInt(msg.itemId)
	if msg.num == nil then msg.num = 0 end
	stream:writeInt(msg.num)
	if msg.moneyType == nil then msg.moneyType = 0 end
	stream:writeByte(msg.moneyType)
	GetSocketInstance():send(stream)
end

--[[
  购买元宝(支付)

]]

function send_shop_ReqPay(msg)

    local stream = CNetStream()
	stream:writeInt(200000)
	
	if msg.payid == nil then msg.payid = 0 end
	stream:writeInt(msg.payid)
	if msg.paytype == nil then msg.paytype = 0 end
	stream:writeByte(msg.paytype)
	GetSocketInstance():send(stream)
end


--[[
   获取元宝列表
]]
function send_shop_ReqGoodsItem()
    local stream = CNetStream()
	stream:writeInt(200002)
	GetSocketInstance():send(stream)
end

function send_apple_ReqVerifyItem(msg)
    local stream = CNetStream()
    stream:writeInt(200004)
    if msg.ordno == nil then msg.ordno = "" end
    stream:writeString(msg.ordno)
    if msg.receipt == nil then msg.receipt = "" end
    stream:writeString(msg.receipt)
    GetSocketInstance():send(stream)
end


c2s_shop_ReqBuyItem_msg = 103101 --[[购买物品]]
c2s_shop_ReqPay_msg = 200000 --[[支付]]
c2s_shop_ReqGoodsItem_msg = 200002 --[[获取商品列表]]
