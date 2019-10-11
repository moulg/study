--------------------------------------------------------------
-- This file was automatically generated by Cocos Studio.
-- Do not make changes to this file.
-- All changes will be lost.
--------------------------------------------------------------

local luaExtend = require "LuaExtend"

-- using for layout to decrease count of local variables
local layout = nil
local localLuaFile = nil
local innerCSD = nil
local innerProject = nil
local localFrame = nil

local Result = {}
------------------------------------------------------------
-- function call description
-- create function caller should provide a function to 
-- get a callback function in creating scene process.
-- the returned callback function will be registered to 
-- the callback event of the control.
-- the function provider is as below :
-- Callback callBackProvider(luaFileName, node, callbackName)
-- parameter description:
-- luaFileName  : a string, lua file name
-- node         : a Node, event source
-- callbackName : a string, callback function name
-- the return value is a callback function
------------------------------------------------------------
function Result.create(callBackProvider)

local result={}
setmetatable(result, luaExtend)

--Create Scene
local Scene=cc.Node:create()
Scene:setName("Scene")

--Create ImgBg
local ImgBg = ccui.ImageView:create()
ImgBg:ignoreContentAdaptWithSize(false)
ImgBg:loadTexture("lobby/resource/hall_res/bj.png",0)
ImgBg:setLayoutComponentEnabled(true)
ImgBg:setName("ImgBg")
ImgBg:setTag(40)
ImgBg:setCascadeColorEnabled(true)
ImgBg:setCascadeOpacityEnabled(true)
ImgBg:setPosition(961.1304, 538.1869)
layout = ccui.LayoutComponent:bindLayoutComponent(ImgBg)
layout:setPositionPercentXEnabled(true)
layout:setPositionPercentYEnabled(true)
layout:setPositionPercentX(0.5006)
layout:setPositionPercentY(0.4983)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(1.0000)
layout:setSize({width = 1920.0000, height = 1080.0000})
layout:setLeftMargin(1.1304)
layout:setRightMargin(-1.1304)
layout:setTopMargin(1.8131)
layout:setBottomMargin(-1.8131)
Scene:addChild(ImgBg)

--Create ImgBg1
local ImgBg1 = ccui.ImageView:create()
ImgBg1:loadTexture("lobby/resource/hall_res/Notice.png",0)
ImgBg1:setName("ImgBg1")
ImgBg1:setTag(40)
ImgBg1:setPosition(960.0000, 915.0000)
Scene:addChild(ImgBg1)

--Create imgTop
local imgTop = ccui.ImageView:create()
imgTop:ignoreContentAdaptWithSize(false)
imgTop:loadTexture("lobby/resource/hall_res/top.png",0)
imgTop:setLayoutComponentEnabled(true)
imgTop:setName("imgTop")
imgTop:setTag(41)
imgTop:setCascadeColorEnabled(true)
imgTop:setCascadeOpacityEnabled(true)
imgTop:setPosition(960.0000, 990.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgTop)
layout:setPositionPercentXEnabled(true)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.9417)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(0.1167)
layout:setSize({width = 1920.0000, height = 192.0000})
layout:setBottomMargin(954.0000)
Scene:addChild(imgTop)

--Create btnClose
local btnClose = ccui.Button:create()
btnClose:ignoreContentAdaptWithSize(false)
btnClose:loadTextureNormal("lobby/resource/hall_res/Backbutton.PNG",0)
btnClose:setTitleFontSize(14)
btnClose:setTitleColor({r = 65, g = 65, b = 70})
btnClose:setScale9Enabled(true)
btnClose:setCapInsets({x = 15, y = 11, width = 58, height = 69})
btnClose:setLayoutComponentEnabled(true)
btnClose:setName("btnClose")
btnClose:setTag(51)
btnClose:setCascadeColorEnabled(true)
btnClose:setCascadeOpacityEnabled(true)
btnClose:setPosition(1750.0000, 105.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnClose)
layout:setPositionPercentX(0.0396)
layout:setPositionPercentY(0.5079)
layout:setPercentWidth(0.0458)
layout:setPercentHeight(0.7222)
layout:setSize({width = 165.0000, height = 177.0000})
layout:setLeftMargin(32.0000)
layout:setRightMargin(1800.0000)
layout:setTopMargin(16.4996)
layout:setBottomMargin(18.5004)
imgTop:addChild(btnClose)

--Create btnClose
local btnExit = ccui.Button:create()
btnExit:ignoreContentAdaptWithSize(false)
btnExit:loadTextureNormal("lobby/resource/button/btnClose1.png",0)
btnExit:loadTexturePressed("lobby/resource/button/btnClose3.png",0)
btnExit:setTitleFontSize(14)
btnExit:setTitleColor({r = 65, g = 65, b = 70})
btnExit:setLayoutComponentEnabled(true)
btnExit:setName("btnExit")
btnExit:setTag(163)
btnExit:setCascadeColorEnabled(true)
btnExit:setCascadeOpacityEnabled(true)
btnExit:setPosition(1899.0000, 1064.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnExit)
layout:setPositionPercentX(0.0339)
layout:setPositionPercentY(0.9444)
layout:setPercentWidth(0.0458)
layout:setPercentHeight(0.0852)
layout:setSize({width = 42.0000, height = 32.0000})
layout:setLeftMargin(21.0002)
layout:setRightMargin(1811.0000)
layout:setTopMargin(13.9990)
layout:setBottomMargin(974.0009)
Scene:addChild(btnExit)

--Create btnClose
local btnSmall = ccui.Button:create()
btnSmall:ignoreContentAdaptWithSize(false)
btnSmall:loadTextureNormal("lobby/resource/button/btnSmall1.png",0)
btnSmall:loadTexturePressed("lobby/resource/button/btnSmall3.png",0)
btnSmall:setTitleFontSize(14)
btnSmall:setTitleColor({r = 65, g = 65, b = 70})
btnSmall:setLayoutComponentEnabled(true)
btnSmall:setName("btnSmall")
btnSmall:setTag(163)
btnSmall:setCascadeColorEnabled(true)
btnSmall:setCascadeOpacityEnabled(true)
btnSmall:setPosition(1857.0000, 1064.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnSmall)
layout:setPositionPercentX(0.0339)
layout:setPositionPercentY(0.9444)
layout:setPercentWidth(0.0458)
layout:setPercentHeight(0.0852)
layout:setSize({width = 42.0000, height = 32.0000})
layout:setLeftMargin(21.0002)
layout:setRightMargin(1811.0000)
layout:setTopMargin(13.9990)
layout:setBottomMargin(974.0009)
Scene:addChild(btnSmall)

--Create imgHead
local imgHead = ccui.ImageView:create()
imgHead:ignoreContentAdaptWithSize(false)
imgHead:loadTexture("Default/ImageFile.png",0)
imgHead:setLayoutComponentEnabled(true)
imgHead:setName("imgHead")
imgHead:setTag(53)
imgHead:setCascadeColorEnabled(true)
imgHead:setCascadeOpacityEnabled(true)
imgHead:setPosition(180.0000, 80.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgHead)
layout:setPositionPercentX(0.1422)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.2688)
layout:setPercentHeight(0.9348)
layout:setSize({width = 150.0000, height = 150.0000})
layout:setLeftMargin(2.5000)
layout:setRightMargin(231.5000)
layout:setTopMargin(2.9996)
layout:setBottomMargin(3.0004)
imgTop:addChild(imgHead)

--Create imgHeadBg
local imgHeadBg = ccui.ImageView:create()
imgHeadBg:ignoreContentAdaptWithSize(true)
imgHeadBg:loadTexture("lobby/resource/hall_res/Pictureframe.png",0)
imgHeadBg:setLayoutComponentEnabled(true)
imgHeadBg:setName("imgHeadBg")
imgHeadBg:setTag(52)
imgHeadBg:setCascadeColorEnabled(true)
imgHeadBg:setCascadeOpacityEnabled(true)
imgHeadBg:setPosition(180.0000, 80.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgHeadBg)
layout:setPositionPercentX(0.1587)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.1667)
layout:setPercentHeight(0.7302)
layout:setSize({width = 243.0000, height = 243.0000})
layout:setLeftMargin(144.6620)
layout:setRightMargin(1455.3380)
layout:setTopMargin(17.0000)
layout:setBottomMargin(17.0000)
imgTop:addChild(imgHeadBg)

--Create tvName
local tvName = ccui.Text:create()
tvName:ignoreContentAdaptWithSize(true)
tvName:setTextAreaSize({width = 0, height = 0})
tvName:setFontSize(24)
tvName:setString([[游客123422222244]])
tvName:setTextVerticalAlignment(1)
tvName:setLayoutComponentEnabled(true)
tvName:setName("tvName")
tvName:setTag(54)
tvName:setCascadeColorEnabled(true)
tvName:setCascadeOpacityEnabled(true)
tvName:setAnchorPoint(0.0000, 0.5000)
tvName:setPosition(240.0002, 121.5000)
layout = ccui.LayoutComponent:bindLayoutComponent(tvName)
layout:setPositionPercentX(0.3375)
layout:setPositionPercentY(0.4783)
layout:setPercentWidth(0.6000)
layout:setPercentHeight(0.2609)
layout:setSize({width = 192.0000, height = 24.0000})
layout:setLeftMargin(108.0002)
layout:setRightMargin(19.9998)
layout:setTopMargin(35.9990)
layout:setBottomMargin(32.0010)
imgHeadBg:addChild(tvName)

--Create imgGoldBg
local imgGoldBg = ccui.ImageView:create()
imgGoldBg:ignoreContentAdaptWithSize(false)
imgGoldBg:loadTexture("lobby/resource/hall_res/szk.png",0)
imgGoldBg:setLayoutComponentEnabled(true)
imgGoldBg:setName("imgGoldBg")
imgGoldBg:setTag(55)
imgGoldBg:setCascadeColorEnabled(true)
imgGoldBg:setCascadeOpacityEnabled(true)
imgGoldBg:setPosition(720.0000, 125.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgGoldBg)
layout:setPositionPercentX(0.3253)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.1505)
layout:setPercentHeight(0.5556)
layout:setSize({width = 335.0000, height = 76.0000})
layout:setLeftMargin(480.0101)
layout:setRightMargin(1150.9900)
layout:setTopMargin(28.0000)
layout:setBottomMargin(28.0000)
imgTop:addChild(imgGoldBg)

--Create xj
local xj = ccui.ImageView:create()
xj:ignoreContentAdaptWithSize(false)
xj:loadTexture("lobby/resource/hall_res/jb.png",0)
xj:setLayoutComponentEnabled(true)
xj:setName("xj")
xj:setTag(57)
xj:setCascadeColorEnabled(true)
xj:setCascadeOpacityEnabled(true)
xj:setPosition(30.0000, 40.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(xj)
layout:setPositionPercentX(0.1142)
layout:setPositionPercentY(0.4857)
layout:setPercentWidth(0.2595)
layout:setPercentHeight(1.0571)
layout:setSize({width = 95.0000, height = 87.0000})
layout:setLeftMargin(-4.4999)
layout:setRightMargin(218.4999)
layout:setTopMargin(-1.0002)
layout:setBottomMargin(-2.9998)
imgGoldBg:addChild(xj)

--Create tvGold
local tvGold = ccui.Text:create()
tvGold:ignoreContentAdaptWithSize(true)
tvGold:setTextAreaSize({width = 0, height = 0})
tvGold:setFontName("simhei.ttf")
tvGold:setFontSize(32)
tvGold:setString([[1111111111]])
tvGold:setTextHorizontalAlignment(1)
tvGold:setTextVerticalAlignment(1)
tvGold:setLayoutComponentEnabled(true)
tvGold:setName("tvGold")
tvGold:setTag(61)
tvGold:setCascadeColorEnabled(true)
tvGold:setCascadeOpacityEnabled(true)
tvGold:setAnchorPoint(0,0.5)
tvGold:setPosition(75.0000, 35.0000)
tvGold:setTextColor({r = 255, g = 178, b = 29})
layout = ccui.LayoutComponent:bindLayoutComponent(tvGold)
layout:setPositionPercentX(0.4862)
layout:setPositionPercentY(0.4571)
layout:setPercentWidth(0.4775)
layout:setPercentHeight(0.4571)
layout:setSize({width = 138.0000, height = 32.0000})
layout:setLeftMargin(71.5002)
layout:setRightMargin(79.4998)
layout:setTopMargin(21.9999)
layout:setBottomMargin(16.0001)
imgGoldBg:addChild(tvGold)

--Create btnGoldAdd
local btnGoldAdd = ccui.Button:create()
btnGoldAdd:ignoreContentAdaptWithSize(false)
btnGoldAdd:loadTextureNormal("lobby/resource/hall_res/cz.png",0)
btnGoldAdd:setTitleFontSize(14)
btnGoldAdd:setTitleColor({r = 65, g = 65, b = 70})
btnGoldAdd:setScale9Enabled(true)
btnGoldAdd:setCapInsets({x = 15, y = 11, width = 37, height = 47})
btnGoldAdd:setLayoutComponentEnabled(true)
btnGoldAdd:setName("btnGoldAdd")
btnGoldAdd:setTag(59)
btnGoldAdd:setCascadeColorEnabled(true)
btnGoldAdd:setCascadeOpacityEnabled(true)
btnGoldAdd:setPosition(300.0000, 38.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnGoldAdd)
layout:setPositionPercentX(0.8824)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.2318)
layout:setPercentHeight(0.9857)
layout:setSize({width = 79.0000, height = 74.0000})
layout:setLeftMargin(221.5000)
layout:setRightMargin(0.5000)
layout:setTopMargin(0.5000)
layout:setBottomMargin(0.5000)
imgGoldBg:addChild(btnGoldAdd)

--Create imgYbBg
local imgYbBg = ccui.ImageView:create()
imgYbBg:ignoreContentAdaptWithSize(false)
imgYbBg:loadTexture("lobby/resource/hall_res/szk.png",0)
imgYbBg:setLayoutComponentEnabled(true)
imgYbBg:setName("imgYbBg")
imgYbBg:setTag(56)
imgYbBg:setCascadeColorEnabled(true)
imgYbBg:setCascadeOpacityEnabled(true)
imgYbBg:setPosition(1200.0000, 125.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgYbBg)
layout:setPositionPercentX(0.4922)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.1505)
layout:setPercentHeight(0.5556)
layout:setSize({width = 335.0000, height = 76.0000})
layout:setLeftMargin(800.5000)
layout:setRightMargin(830.5000)
layout:setTopMargin(28.0000)
layout:setBottomMargin(28.0000)
imgTop:addChild(imgYbBg)

--Create yb
local yb = ccui.ImageView:create()
yb:ignoreContentAdaptWithSize(false)
yb:loadTexture("lobby/resource/hall_res/yb.png",0)
yb:setLayoutComponentEnabled(true)
yb:setName("yb")
yb:setTag(58)
yb:setCascadeColorEnabled(true)
yb:setCascadeOpacityEnabled(true)
yb:setPosition(10.0000, 38.0000)
yb:setScale(1.7)
layout = ccui.LayoutComponent:bindLayoutComponent(yb)
layout:setPositionPercentX(0.1107)
layout:setPositionPercentY(0.4714)
layout:setPercentWidth(0.2595)
layout:setPercentHeight(1.0857)
layout:setSize({width = 75.0000, height = 76.0000})
layout:setLeftMargin(-5.4993)
layout:setRightMargin(219.4993)
layout:setTopMargin(-1.0009)
layout:setBottomMargin(-4.9991)
imgYbBg:addChild(yb)

--Create tvYB
local tvYB = ccui.Text:create()
tvYB:ignoreContentAdaptWithSize(true)
tvYB:setTextAreaSize({width = 0, height = 0})
tvYB:setFontName("simhei.ttf")
tvYB:setFontSize(28)
tvYB:setString([[11111111111]])
tvYB:setTextHorizontalAlignment(1)
tvYB:setTextVerticalAlignment(1)
tvYB:setLayoutComponentEnabled(true)
tvYB:setName("tvYB")
tvYB:setTag(62)
tvYB:setCascadeColorEnabled(true)
tvYB:setCascadeOpacityEnabled(true)
tvYB:setPosition(110.0000, 32.0000)
tvYB:setTextColor({r = 255, g = 178, b = 29})
layout = ccui.LayoutComponent:bindLayoutComponent(tvYB)
layout:setPositionPercentX(0.4896)
layout:setPositionPercentY(0.4571)
layout:setPercentWidth(0.5260)
layout:setPercentHeight(0.4571)
layout:setSize({width = 152.0000, height = 32.0000})
layout:setLeftMargin(65.4999)
layout:setRightMargin(71.5001)
layout:setTopMargin(21.9997)
layout:setBottomMargin(16.0003)
imgYbBg:addChild(tvYB)

--Create btnYbAdd
local btnYbAdd = ccui.Button:create()
btnYbAdd:ignoreContentAdaptWithSize(false)
btnYbAdd:loadTextureNormal("lobby/resource/hall_res/cz.png",0)
btnYbAdd:setTitleFontSize(14)
btnYbAdd:setTitleColor({r = 65, g = 65, b = 70})
btnYbAdd:setScale9Enabled(true)
btnYbAdd:setCapInsets({x = 15, y = 11, width = 37, height = 47})
btnYbAdd:setLayoutComponentEnabled(true)
btnYbAdd:setName("btnYbAdd")
btnYbAdd:setTag(60)
btnYbAdd:setCascadeColorEnabled(true)
btnYbAdd:setCascadeOpacityEnabled(true)
btnYbAdd:setPosition(300.0000, 38.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnYbAdd)
layout:setPositionPercentX(0.8789)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.2318)
layout:setPercentHeight(0.9857)
layout:setSize({width = 79.0000, height = 74.0000})
layout:setLeftMargin(220.5000)
layout:setRightMargin(1.5000)
layout:setTopMargin(0.4999)
layout:setBottomMargin(0.5001)
imgYbBg:addChild(btnYbAdd)

--Create btnHistory
local btnHistory = ccui.Button:create()
btnHistory:ignoreContentAdaptWithSize(false)
btnHistory:loadTextureNormal("lobby/resource/hall_res/wdzj.png",0)
btnHistory:setTitleFontSize(14)
btnHistory:setTitleColor({r = 65, g = 65, b = 70})
btnHistory:setScale9Enabled(true)
btnHistory:setCapInsets({x = 15, y = 11, width = 180, height = 48})
btnHistory:setLayoutComponentEnabled(true)
btnHistory:setName("btnHistory")
btnHistory:setTag(47)
btnHistory:setCascadeColorEnabled(true)
btnHistory:setCascadeOpacityEnabled(true)
btnHistory:setPosition(1293.0000, 62.9999)
btnHistory:setVisible(false)
layout = ccui.LayoutComponent:bindLayoutComponent(btnHistory)
layout:setPositionPercentX(0.6734)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.1094)
layout:setPercentHeight(0.5556)
layout:setSize({width = 210.0000, height = 70.0000})
layout:setLeftMargin(1188.0000)
layout:setRightMargin(522.0000)
layout:setTopMargin(28.0001)
layout:setBottomMargin(27.9999)
imgTop:addChild(btnHistory)

--Create btnAll
local btnAll = ccui.Button:create()
btnAll:ignoreContentAdaptWithSize(false)
btnAll:loadTextureNormal("lobby/resource/hall_res/syyx.png",0)
btnAll:setTitleFontSize(14)
btnAll:setTitleColor({r = 65, g = 65, b = 70})
btnAll:setScale9Enabled(true)
btnAll:setCapInsets({x = 15, y = 11, width = 180, height = 48})
btnAll:setLayoutComponentEnabled(true)
btnAll:setName("btnAll")
btnAll:setTag(48)
btnAll:setCascadeColorEnabled(true)
btnAll:setCascadeOpacityEnabled(true)
btnAll:setPosition(1518.0000, 62.9999)
btnAll:setVisible(false)
layout = ccui.LayoutComponent:bindLayoutComponent(btnAll)
layout:setPositionPercentX(0.7906)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.1094)
layout:setPercentHeight(0.5556)
layout:setSize({width = 210.0000, height = 70.0000})
layout:setLeftMargin(1413.0000)
layout:setRightMargin(297.0000)
layout:setTopMargin(28.0001)
layout:setBottomMargin(27.9999)
imgTop:addChild(btnAll)

-- --Create btnSet
-- local btnSet = ccui.Button:create()
-- btnSet:ignoreContentAdaptWithSize(false)
-- btnSet:loadTextureNormal("lobby/resource/hall_res/sz.png",0)
-- btnSet:setTitleFontSize(14)
-- btnSet:setTitleColor({r = 65, g = 65, b = 70})
-- btnSet:setScale9Enabled(true)
-- btnSet:setCapInsets({x = 15, y = 11, width = 31, height = 67})
-- btnSet:setLayoutComponentEnabled(true)
-- btnSet:setName("btnSet")
-- btnSet:setTag(50)
-- btnSet:setCascadeColorEnabled(true)
-- btnSet:setCascadeOpacityEnabled(true)
-- btnSet:setPosition(1550.0000,35.0000)
-- layout = ccui.LayoutComponent:bindLayoutComponent(btnSet)
-- layout:setPositionPercentX(0.9448)
-- layout:setPositionPercentY(0.5000)
-- layout:setPercentWidth(0.0318)
-- layout:setPercentHeight(0.7063)
-- layout:setSize({width = 165.0000, height = 177.0000})
-- layout:setLeftMargin(1783.4980)
-- layout:setRightMargin(75.5018)
-- layout:setTopMargin(18.5000)
-- layout:setBottomMargin(18.5000)
-- imgTop:addChild(btnSet)

--Create imgBottom
local imgBottom = ccui.ImageView:create()
imgBottom:ignoreContentAdaptWithSize(false)
imgBottom:loadTexture("lobby/resource/hall_res/bottom.png",0)
imgBottom:setLayoutComponentEnabled(true)
imgBottom:setName("imgBottom")
imgBottom:setTag(43)
imgBottom:setCascadeColorEnabled(true)
imgBottom:setCascadeOpacityEnabled(true)
imgBottom:setPosition(960.0000, 69.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgBottom)
layout:setPositionPercentXEnabled(true)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.0213)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(0.0426)
layout:setSize({width = 1920.0000, height = 138.0000})
layout:setTopMargin(1034.0000)
Scene:addChild(imgBottom,100)

--Create btnService
local btnService = ccui.Button:create()
btnService:ignoreContentAdaptWithSize(false)
btnService:loadTextureNormal("lobby/resource/hall_res/kf.png",0)
btnService:setTitleFontSize(14)
btnService:setTitleColor({r = 65, g = 65, b = 70})
btnService:setScale9Enabled(true)
btnService:setCapInsets({x = 15, y = 11, width = 90, height = 98})
btnService:setLayoutComponentEnabled(true)
btnService:setName("btnService")
btnService:setTag(65)
btnService:setCascadeColorEnabled(true)
btnService:setCascadeOpacityEnabled(true)
btnService:setPosition(1728, 66.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnService)
layout:setPositionPercentX(0.0385)
layout:setPositionPercentY(19.4846)
layout:setPercentWidth(0.0625)
layout:setPercentHeight(2.6087)
layout:setSize({width = 389.0000, height = 132.0000})
layout:setLeftMargin(13.8318)
layout:setRightMargin(1786.1680)
layout:setTopMargin(-910.2932)
layout:setBottomMargin(836.2932)
imgBottom:addChild(btnService)

--Create btnUpLeve
local btnUpLeve = ccui.Button:create()
btnUpLeve:ignoreContentAdaptWithSize(false)
btnUpLeve:loadTextureNormal("lobby/resource/hall_res/zhsj.png",0)
btnUpLeve:setTitleFontSize(14)
btnUpLeve:setTitleColor({r = 65, g = 65, b = 70})
btnUpLeve:setScale9Enabled(true)
btnUpLeve:setCapInsets({x = 15, y = 11, width = 205, height = 53})
btnUpLeve:setLayoutComponentEnabled(true)
btnUpLeve:setName("btnUpLeve")
btnUpLeve:setTag(44)
btnUpLeve:setCascadeColorEnabled(true)
btnUpLeve:setCascadeOpacityEnabled(true)
btnUpLeve:setPosition(143.5000, 200.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnUpLeve)
layout:setPositionPercentX(0.0698)
layout:setPositionPercentY(1.1957)
layout:setPercentWidth(0.1224)
layout:setPercentHeight(1.6304)
layout:setSize({width = 287.0000, height = 102.0000})
layout:setLeftMargin(16.5000)
layout:setRightMargin(1668.5000)
layout:setTopMargin(-46.5000)
layout:setBottomMargin(17.5000)
imgBottom:addChild(btnUpLeve)

--Create btnBank
local btnBank = ccui.Button:create()
btnBank:ignoreContentAdaptWithSize(false)
btnBank:loadTextureNormal("lobby/resource/hall_res/wdyh.png",0)
btnBank:setTitleFontSize(14)
btnBank:setTitleColor({r = 65, g = 65, b = 70})
btnBank:setScale9Enabled(true)
btnBank:setCapInsets({x = 15, y = 11, width = 205, height = 53})
btnBank:setLayoutComponentEnabled(true)
btnBank:setName("btnBank")
btnBank:setTag(45)
btnBank:setCascadeColorEnabled(true)
btnBank:setCascadeOpacityEnabled(true)
btnBank:setPosition(615.0000, 59.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnBank)
layout:setPositionPercentX(0.0698)
layout:setPositionPercentY(1.1956)
layout:setPercentWidth(0.1224)
layout:setPercentHeight(1.6304)
layout:setSize({width = 435.0000, height = 119.0000})
layout:setLeftMargin(16.4997)
layout:setRightMargin(1668.5000)
layout:setTopMargin(-46.4999)
layout:setBottomMargin(17.4999)
imgBottom:addChild(btnBank)

--Create btnRank
local btnRank = ccui.Button:create()
btnRank:ignoreContentAdaptWithSize(false)
btnRank:loadTextureNormal("lobby/resource/hall_res/ph.png",0)
btnRank:setTitleFontSize(14)
btnRank:setTitleColor({r = 65, g = 65, b = 70})
btnRank:setScale9Enabled(true)
btnRank:setCapInsets({x = 15, y = 11, width = 31, height = 67})
btnRank:setLayoutComponentEnabled(true)
btnRank:setName("btnRank")
btnRank:setTag(49)
btnRank:setCascadeColorEnabled(true)
btnRank:setCascadeOpacityEnabled(true)
btnRank:setPosition(1310.0000, 59.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnRank)
layout:setPositionPercentX(0.8818)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.0318)
layout:setPercentHeight(0.7063)
layout:setSize({width = 435.0000, height = 119.0000})
layout:setLeftMargin(1662.4980)
layout:setRightMargin(196.5018)
layout:setTopMargin(18.5000)
layout:setBottomMargin(18.5000)
imgBottom:addChild(btnRank)

--Create btnShop
local btnShop = ccui.Button:create()
btnShop:ignoreContentAdaptWithSize(false)
btnShop:loadTextureNormal("lobby/resource/hall_res/sc.png",0)
btnShop:setTitleFontSize(14)
btnShop:setTitleColor({r = 65, g = 65, b = 70}) 
btnShop:setScale9Enabled(true)
btnShop:setCapInsets({x = 15, y = 11, width = 192, height = 95})
btnShop:setLayoutComponentEnabled(true)
btnShop:setName("btnShop")
btnShop:setTag(46)
btnShop:setCascadeColorEnabled(true)
btnShop:setCascadeOpacityEnabled(true)
btnShop:setPosition(960.0000, 91.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnShop)
layout:setPositionPercentX(0.9234)
layout:setPositionPercentY(1.3043)
layout:setPercentWidth(0.1156)
layout:setPercentHeight(2.5435)
layout:setSize({width = 423.0000, height = 182.0000})
layout:setLeftMargin(1662.0000)
layout:setRightMargin(36.0000)
layout:setTopMargin(-72.5000)
layout:setBottomMargin(1.5000)
imgBottom:addChild(btnShop)

--Create btnGongGao
local btnGongGao = ccui.Button:create()
btnGongGao:ignoreContentAdaptWithSize(false)
btnGongGao:loadTextureNormal("lobby/resource/hall_res/Announcementbutton.png",0)
btnGongGao:setTitleFontSize(14)
btnGongGao:setTitleColor({r = 65, g = 65, b = 70}) 
btnGongGao:setScale9Enabled(true)
btnGongGao:setCapInsets({x = 15, y = 11, width = 192, height = 95})
btnGongGao:setLayoutComponentEnabled(true)
btnGongGao:setName("btnSet")
btnGongGao:setTag(46)
btnGongGao:setCascadeColorEnabled(true)
btnGongGao:setCascadeOpacityEnabled(true)
btnGongGao:setPosition(195.0000, 66.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnGongGao)
layout:setPositionPercentX(0.9234)
layout:setPositionPercentY(1.3043)
layout:setPercentWidth(0.1156)
layout:setPercentHeight(2.5435)
layout:setSize({width = 389.0000, height = 132.0000})
layout:setLeftMargin(1662.0000)
layout:setRightMargin(36.0000)
layout:setTopMargin(-72.5000)
layout:setBottomMargin(1.5000)
imgBottom:addChild(btnGongGao)

--Create imgGameName
local imgGameName = ccui.ImageView:create()
imgGameName:ignoreContentAdaptWithSize(false)
imgGameName:loadTexture("Default/ImageFile.png",0)
imgGameName:setLayoutComponentEnabled(true)
imgGameName:setName("imgGameName")
imgGameName:setTag(32)
imgGameName:setCascadeColorEnabled(true)
imgGameName:setCascadeOpacityEnabled(true)
imgGameName:setPosition(1600.0000, 855.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgGameName)
layout:setPositionPercentX(0.8333)
layout:setPositionPercentY(0.7917)
layout:setPercentWidth(0.2823)
layout:setPercentHeight(0.1676)
layout:setSize({width = 542.0000, height = 181.0000})
layout:setLeftMargin(1329.0000)
layout:setRightMargin(49.0000)
layout:setTopMargin(134.5000)
layout:setBottomMargin(764.5000)
Scene:addChild(imgGameName)

--Create GameContainer
local GameContainer = ccui.Layout:create()
GameContainer:ignoreContentAdaptWithSize(false)
GameContainer:setClippingEnabled(false)
GameContainer:setBackGroundColorType(1)
GameContainer:setBackGroundColor({r = 150, g = 200, b = 255})
GameContainer:setBackGroundColorOpacity(0)
GameContainer:setTouchEnabled(true);
GameContainer:setLayoutComponentEnabled(true)
GameContainer:setName("GameContainer")
GameContainer:setTag(33)
GameContainer:setCascadeColorEnabled(true)
GameContainer:setCascadeOpacityEnabled(true)
GameContainer:setAnchorPoint(0.5000, 0.5000)
GameContainer:setPosition(960.0002, 477.9985)
layout = ccui.LayoutComponent:bindLayoutComponent(GameContainer)
layout:setPositionPercentXEnabled(true)
layout:setPositionPercentYEnabled(true)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.4426)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(0.6944)
layout:setSize({width = 1920.0000, height = 750.0000})
layout:setLeftMargin(0.0002)
layout:setRightMargin(-0.0002)
layout:setTopMargin(227.0015)
layout:setBottomMargin(102.9985)
Scene:addChild(GameContainer)

--Create btnGame
local btnGame = ccui.Button:create()
btnGame:ignoreContentAdaptWithSize(false)
btnGame:loadTextureNormal("lobby/resource/icon/big/big_dzpk.png",0)
btnGame:setTitleFontSize(14)
btnGame:setTitleColor({r = 65, g = 65, b = 70})
btnGame:setScale9Enabled(true)
btnGame:setCapInsets({x = 15, y = 11, width = 570, height = 728})
btnGame:setLayoutComponentEnabled(true)
btnGame:setName("btnGame")
btnGame:setTag(64)
btnGame:setCascadeColorEnabled(true)
btnGame:setCascadeOpacityEnabled(true)
btnGame:setPosition(360.0000, 450.0000)
btnGame:setScale(0.9)
layout = ccui.LayoutComponent:bindLayoutComponent(btnGame)
layout:setPositionPercentYEnabled(true)
layout:setPositionPercentX(0.1875)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.3125)
layout:setPercentHeight(1.0000)
layout:setSize({width = 600.0000, height = 750.0000})
layout:setLeftMargin(60.0011)
layout:setRightMargin(1259.9990)
GameContainer:addChild(btnGame)

--Create svGame
local svGame = ccui.ScrollView:create()
svGame:setBounceEnabled(true)
svGame:setDirection(2)
svGame:setInnerContainerSize({width = 1110, height = 720})
svGame:ignoreContentAdaptWithSize(false)
svGame:setClippingEnabled(true)
svGame:setBackGroundColorType(1)
svGame:setBackGroundColor({r = 255, g = 150, b = 100})
svGame:setBackGroundColorOpacity(0)
svGame:setLayoutComponentEnabled(true)
svGame:setName("svGame")
svGame:setTag(66)
svGame:setCascadeColorEnabled(true)
svGame:setCascadeOpacityEnabled(true)
svGame:setPosition(650.0000, 100.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(svGame)
layout:setPositionPercentX(0.3578)
layout:setPositionPercentY(0.0467)
layout:setPercentWidth(0.5781)
layout:setPercentHeight(0.9600)
layout:setSize({width = 1110.0000, height = 720.0000})
layout:setLeftMargin(687.0000)
layout:setRightMargin(123.0000)
layout:setTopMargin(-5.0000)
layout:setBottomMargin(35.0000)
GameContainer:addChild(svGame)

--Create PageViewGameRoom
local PageViewGameRoom = ccui.ListView:create()
PageViewGameRoom:setDirection(2)
PageViewGameRoom:setGravity(5)
PageViewGameRoom:ignoreContentAdaptWithSize(false)
PageViewGameRoom:setClippingEnabled(false)
PageViewGameRoom:setBackGroundColorType(1)
PageViewGameRoom:setBackGroundColor({r = 150, g = 150, b = 255})
PageViewGameRoom:setBackGroundColorOpacity(0)
PageViewGameRoom:setLayoutComponentEnabled(true)
PageViewGameRoom:setName("PageViewGameRoom")
PageViewGameRoom:setTag(34)
PageViewGameRoom:setCascadeColorEnabled(true)
PageViewGameRoom:setCascadeOpacityEnabled(true)
PageViewGameRoom:setAnchorPoint(0.5000, 0.5000)
PageViewGameRoom:setPosition(960.0002, 467.9998)
layout = ccui.LayoutComponent:bindLayoutComponent(PageViewGameRoom)
layout:setPositionPercentXEnabled(true)
layout:setPositionPercentYEnabled(true)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.4333)
layout:setPercentWidth(0.8333)
layout:setPercentHeight(0.4630)
layout:setSize({width = 1600.0000, height = 500.0000})
layout:setLeftMargin(160.0002)
layout:setRightMargin(159.9998)
layout:setTopMargin(362.0002)
layout:setBottomMargin(217.9998)
Scene:addChild(PageViewGameRoom)

--Create PageViewGameItem
local PageViewGameItem = ccui.ListView:create()
PageViewGameItem:setDirection(2)
PageViewGameItem:setGravity(4)
PageViewGameItem:ignoreContentAdaptWithSize(false)
PageViewGameItem:setClippingEnabled(true)
PageViewGameItem:setItemsMargin(0)
PageViewGameItem:setBackGroundColorType(1)
PageViewGameItem:setBackGroundColor({r = 255, g = 255, b = 255})
PageViewGameItem:setBackGroundColorOpacity(0)
PageViewGameItem:setLayoutComponentEnabled(true)
PageViewGameItem:setName("PageViewGameItem")
PageViewGameItem:setTag(197)
PageViewGameItem:setCascadeColorEnabled(true)
PageViewGameItem:setCascadeOpacityEnabled(true)
PageViewGameItem:setAnchorPoint(0.5000, 0.5000)
PageViewGameItem:setPosition(960.0000, 540.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(PageViewGameItem)
layout:setPositionPercentXEnabled(true)
layout:setPositionPercentYEnabled(true)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.0)
layout:setPercentHeight(0.3704)
layout:setSize({width = 1920.0000, height = 450.0000})
layout:setLeftMargin(80.0000)
layout:setRightMargin(80.0000)
layout:setTopMargin(365.0000)
layout:setBottomMargin(365.0000)
Scene:addChild(PageViewGameItem)


-- --Create btnLeft
-- local btnLeft = ccui.Button:create()
-- btnLeft:loadTextureNormal("lobby/resource/hall_res/sc.png",0)
-- btnLeft:setName("btnLeft")
-- btnLeft:setPosition(60.0000, 540.0000)
-- Scene:addChild(btnLeft,1000)

-- --Create btnLeft
-- local btnRight = ccui.Button:create()
-- btnRight:loadTextureNormal("lobby/resource/hall_res/sc.png",0)
-- btnRight:setName("btnRight")
-- btnRight:setPosition(1860.0000, 540.0000)
-- Scene:addChild(btnRight,1000)

--Create PageViewGameType
local PageViewGameType = ccui.ListView:create()
PageViewGameType:setDirection(2)
PageViewGameType:setGravity(5)
PageViewGameType:ignoreContentAdaptWithSize(false)
PageViewGameType:setClippingEnabled(false)
PageViewGameType:setBackGroundColorType(1)
PageViewGameType:setBackGroundColor({r = 255, g = 255, b = 255})
PageViewGameType:setBackGroundColorOpacity(0)
PageViewGameType:setLayoutComponentEnabled(true)
PageViewGameType:setName("PageViewGameType")
PageViewGameType:setTag(38)
PageViewGameType:setCascadeColorEnabled(true)
PageViewGameType:setCascadeOpacityEnabled(true)
PageViewGameType:setAnchorPoint(0.5000, 0.5000)
PageViewGameType:setPosition(960.0000, 580.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(PageViewGameType)
layout:setPositionPercentXEnabled(true)
layout:setPositionPercentYEnabled(true)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.8729)
layout:setPercentHeight(0.4815)
layout:setSize({width = 1720.0000, height = 520.0000})
layout:setLeftMargin(100.0000)
layout:setRightMargin(100.0000)
layout:setTopMargin(280.0000)
layout:setBottomMargin(280.0000)
Scene:addChild(PageViewGameType)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Scene
return result;
end

return Result
