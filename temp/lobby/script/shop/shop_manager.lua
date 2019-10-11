#remark
--[[
商城管理类
]]

shop_manager = {}
--[[
	购买物品结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:钱不够
		名称:item 类型:com.wly.game.backpack.dto.ItemInfo 备注:购买的道具信息
	}
]]
function shop_manager:resBuyItem(msg)
	--add your logic code here

	if msg.res == 0 then
		TipsManager:showOneButtonTipsPanel(6, {shop_item_config[msg.item.id].name}, true)
	else
		TipsManager:showOneButtonTipsPanel(4, {}, true)
	end
end

--[[
   支付响应
]]
function shop_manager:resPay(msg) 

	WaitMessageHit.closeWaitMessageHit()
	
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
	if cc.PLATFORM_OS_ANDROID == targetPlatform then
		
	cc.Application:getInstance():openURL(msg.payUrl)
	--shop:showWebView(msg.payUrl)
	--CTools:openAndroidWebView(msg.payUrl)

	elseif cc.PLATFORM_OS_IPHONE == targetPlatform then
		-- ios
		local function iosiapback(error,transactionId,receipt)
			if error == 1 then
				print("===================pay failed")
                local bk_hit_obj = BlackMessageHit.create({txt = "支付失败",color = cc.c3b(255,255,255),})
                WindowScene.getInstance():showDlg(bk_hit_obj)
            else
				send_apple_ReqVerifyItem({ordno = msg.orderNo,receipt = receipt})
				print("===================pay success======"..msg.orderNo.."waiting for server")
            end
        end
        local iosiap = cc.IOSiAP_Bridge:getInstance()
        iosiap:registerScriptHandler(iosiapback)
		iosiap:requestProducts(msg.iosId)
		print("===================IOSiAP_Bridge")

	else
		print("mobile 版本, 不支持PC支付")
    end
end
