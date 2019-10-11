#remark
local item_ui
-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

CRankItem = class("CRankItem", function()
	local obj = ccui.ImageView:create()
	obj:setScale9Enabled(true)
	obj:setCapInsets({x = 15, y = 11, width = 90, height = 98})
	obj:setLayoutComponentEnabled(true)
	obj:setContentSize(1185.0000,104.0000)
	obj:loadTexture("lobby/resource/rank/alpha.png")
	return obj
end)

function CRankItem.create(info) 
	local obj = CRankItem.new()
	if obj ~= nil then obj:init(info) end
	return obj
end

function CRankItem:init(info)
	item_ui = require("lobby.ui_create.ui_rankingItem").create()
	if info.index <= 3 then 
		item_ui.imgIndex:setVisible(true)
    	item_ui.tvIndex:setVisible(false)
	    item_ui.imgIndex:loadTexture("lobby/resource/rank/"..info.index..".png",0)
    else
    	item_ui.imgIndex:setVisible(false)
    	item_ui.tvIndex:setVisible(true)
		item_ui.tvIndex:setString(info.index)
		item_ui.tvIndex:setScale(1.4)
    end
	item_ui.tvNick:setString(info.nickname)
	item_ui.tvGold:setString(info.gold)
	local sex = math.random(2) - 1
	uiUtils:setPhonePlayerHead(item_ui.imgHead, sex, uiUtils.HEAD_SIZE_223)
    --local des_size = WindowScene.getInstance():getDesSize()
	item_ui.root:setPosition(self:getContentSize().width/2, self:getContentSize().height/2)
	self:addChild(item_ui.root)
end

return CRankItem