#remark
--[[
	商店面板
]]

local shopitem_ui = require "lobby.ui_create.ui_shopItem"

CShopItem = class("CShopItem",function()
	-- body
	local  ret = ccui.Layout:create()
	ret:setContentSize(cc.size(392, 433))
	ret:setAnchorPoint(0.5,0.5)
	return ret
end)

function CShopItem.create()
	-- body
	local layer = CShopItem.new()
	if layer ~= nil then
		layer:regEnterExit()
		layer:init_ui()
		return layer
	end
end


function CShopItem:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(_onEnterOrExit);
end

function CShopItem:onEnter()

end

function CShopItem:onExit()

end


function CShopItem:init_ui()
	self.shopitem_ui = shopitem_ui.create()
	self:addChild(self.shopitem_ui.root)

	self.shopitem_ui.btnBj:onTouch(function (e)
		self:onClickBuy(e)
	end)
end


function CShopItem:setItemInfo( itemdata )
	self.itemdata = itemdata

	--名字
	self.shopitem_ui.textName:setString(tostring(itemdata.name))
	self.shopitem_ui.textName:setPositionY(self.shopitem_ui.textName:getPositionY()-15)
	
	--价格
	local str = ""
	if get_xue_Version()==2 then
		str = tostring(itemdata.price)
	else
		str = string.format("%.2f",itemdata.price)
	end
	self.shopitem_ui.text_price:setString(str)

	--
	self.shopitem_ui.text_give:setString("")

	-- if itemdata.type ==2 then
	-- --赠送

	-- local str = string.format("%.2f", itemdata.give) 
	-- self.shopitem_ui.text_give:setString("赠送："..str.."金币")
	-- else
	-- --赠送
	-- self.shopitem_ui.text_give:setString("赠送："..itemdata.give.."金币")
	-- end

	--元宝
	self.shopitem_ui.imgAcer:setVisible(self.itemdata.currency == 2)
	--人民币
	self.shopitem_ui.imgRMB:setVisible(self.itemdata.currency == 1)

	self.shopitem_ui.imgItem:loadTexture(string.format("lobby/resource/shopItem/%d.png",itemdata.id))
	
    --uiUtils:setItemIcon(self.shopitem_ui.imgItem, itemdata.id, uiUtils.ITEM_SIZE_70)
end

function CShopItem:onClickBuy( e )
	
	if e.name == "ended" then
		--货币类型
		if self.itemdata.currency == 2 then--判断元宝
			TipsManager:showOneButtonTipsPanel(2,{self.itemdata.name,self.itemdata.price},true,function ()
					self:buyItemSure()
				end)
		elseif self.itemdata.currency == 1 then--人民币
			
			
			-- local shop = WindowScene:getInstance():getDlgByName("CShopPanel")
			-- if shop then
			-- 	shop:setActVisible(true)
			-- end

			local targetPlatform = cc.Application:getInstance():getTargetPlatform()

			if cc.PLATFORM_OS_ANDROID == targetPlatform then
				
				WaitMessageHit.showWaitMessageHit(2)

				print("android .....")
				--send_shop_ReqPay({payid = self.itemdata.payid, paytype = 0})  -- android
				--send_shop_ReqPay({payid = self.itemdata.payid, paytype = 2,})  -- android
				send_shop_ReqPay({payid = self.itemdata.payid, paytype = 3,})  -- android
			elseif cc.PLATFORM_OS_IPHONE == targetPlatform then

				WaitMessageHit.showWaitMessageHit(2)

				print("ios .....")
			    send_shop_ReqPay({payid = self.itemdata.payid, paytype = 1})  -- ios
			else
				print("mobile 版本, 不支持PC支付")
            end
		end
		global_music_ctrl.play_btn_one()
	end
	
end

function CShopItem:buyItemSure()
	-- body
	local pinfo = get_player_info()

	if self.itemdata.currency == 2 then --判断元宝
		if long_compare(pinfo.acer, self.itemdata.price) == -1 then --判断元宝是否够
			TipsManager:showOneButtonTipsPanel(4, {},true)
		else
			send_shop_ReqBuyItem({itemId = self.itemdata.id, num = 1, moneyType = 1})
		end
	elseif self.itemdata.currency == 1 then--人民币

	end
end
