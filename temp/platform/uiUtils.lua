#remark
uiUtils = {}

uiUtils.ITEM_SIZE_70 = 70
uiUtils.ITEM_SIZE_35 = 35

uiUtils.HEAD_SIZE_35 = 35
uiUtils.HEAD_SIZE_50 = 50
uiUtils.HEAD_SIZE_115 = 115
uiUtils.HEAD_SIZE_223 = 223

--设置物品icon
function uiUtils:setItemIcon(imgSpr, id, size)
	local sourceType = tolua.type(imgSpr)
	local res = item_src_config[id].icon
	if sourceType == "ccui.ImageView" then
		imgSpr:loadTexture(res)
	elseif sourceType == "cc.Sprite" then	
		imgSpr:setTexture(res)
	end
	imgSpr:setScale(size/uiUtils.ITEM_SIZE_70)
end

--获得头像资源
function uiUtils:getHeadResUrl(iconId, size)
	if iconId == nil then
		iconId = 1
	end
	return "common/head_pic/"..size.."/"..iconId..".png"
end

--设置头像
function uiUtils:setPlayerHead(img, iconId, size)
	local sourceType = tolua.type(img)
	if sourceType == "ccui.ImageView" then
		img:loadTexture(uiUtils:getHeadResUrl(iconId, size))
	elseif sourceType == "cc.Sprite" then
		img:setTexture(uiUtils:getHeadResUrl(iconId, size))
	end
end

--获得手机版头像资源 男：0  女：1
function uiUtils:getPhoneHeadResUrl(sex, size)
	if sex == nil then
		sex = 1
	end
	return "common/head_pic/"..size.."/"..sex..".png"
end

--手机版设置头像，只有性别区别
function uiUtils:setPhonePlayerHead(img, sex, size)
	local sourceType = tolua.type(img)
	if sourceType == "ccui.ImageView" then
		img:loadTexture(uiUtils:getPhoneHeadResUrl(sex, size))
	elseif sourceType == "cc.Sprite" then
		img:setTexture(uiUtils:getPhoneHeadResUrl(sex, size))
	end
end

--[[
	create a ccui.Button object
]]
function uiUtils.createBtn(pos,size,src_nor,src_down,src_dis)
	local btn_item = ccui.Button:create()
	btn_item:ignoreContentAdaptWithSize(false)
	btn_item:loadTextureNormal(src_nor,0)
	btn_item:loadTexturePressed(src_down,0)
	btn_item:loadTextureDisabled(src_dis,0)
	btn_item:setLayoutComponentEnabled(true)
	btn_item:setCascadeColorEnabled(true)
	btn_item:setCascadeOpacityEnabled(true)
	btn_item:setAnchorPoint(0.0000,0.0000)
	btn_item:setPosition(pos.x,pos.y)
	layout = ccui.LayoutComponent:bindLayoutComponent(btn_item)
	layout:setPositionPercentX(0.0000)
	layout:setPositionPercentY(0.0000)
	layout:setSize(size)
	layout:setLeftMargin(0.0000)
	layout:setRightMargin(-size.width)
	layout:setTopMargin(-size.height)
	layout:setBottomMargin(0.0000)
	
	return btn_item
end

--[[
创建遮罩  demoRes  遮罩模版图
]]
function uiUtils.createMask( demoRes )
	--遮罩
	local layer = cc.ClippingNode:create()
	layer:setPosition(0, 0)

	layer:setInverted(false)
	layer:setAlphaThreshold(1)

	local stencilNode = cc.Node:create()
	local maskDemo = cc.Sprite:create(demoRes)
	maskDemo:setPosition(0,0)
	maskDemo:setScale(0,0)

	stencilNode:addChild(maskDemo)
	stencilNode:setPosition(0, 0)
	layer:setStencil(stencilNode)

	return layer, maskDemo
end


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
