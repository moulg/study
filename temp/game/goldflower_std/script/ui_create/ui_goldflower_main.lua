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

--Create imgBg
local imgBg = cc.Sprite:create("game/goldflower_std/resource/image/bj.jpg")
imgBg:setName("imgBg")
imgBg:setTag(172)
imgBg:setCascadeColorEnabled(true)
imgBg:setCascadeOpacityEnabled(true)
imgBg:setPosition(960.0000, 540.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgBg)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(1.0000)
layout:setSize({width = 1920.0000, height = 1080.0000})
imgBg:setBlendFunc({src = 1, dst = 771})
Scene:addChild(imgBg)

local imgBg1 = cc.Sprite:create("game/goldflower_std/resource/image/heguan1.png")
imgBg1:setName("imgBg1")
imgBg1:setTag(172)
imgBg1:setCascadeColorEnabled(true)
imgBg1:setCascadeOpacityEnabled(true)
imgBg1:setPosition(953.0000, 900.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgBg1)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(1.0000)
layout:setSize({width = 223.0000, height = 238.0000})
imgBg1:setBlendFunc({src = 1, dst = 771})
Scene:addChild(imgBg1)

--Create nodeChips
local nodeChips=cc.Node:create()
nodeChips:setName("nodeChips")
nodeChips:setTag(173)
nodeChips:setCascadeColorEnabled(true)
nodeChips:setCascadeOpacityEnabled(true)
layout = ccui.LayoutComponent:bindLayoutComponent(nodeChips)
layout:setRightMargin(1920.0000)
layout:setTopMargin(1080.0000)
imgBg:addChild(nodeChips)

--Create nodePlayer
local nodePlayer=cc.Node:create()
nodePlayer:setName("nodePlayer")
nodePlayer:setTag(179)
nodePlayer:setCascadeColorEnabled(true)
nodePlayer:setCascadeOpacityEnabled(true)
layout = ccui.LayoutComponent:bindLayoutComponent(nodePlayer)
layout:setRightMargin(1920.0000)
layout:setTopMargin(1080.0000)
imgBg:addChild(nodePlayer)

--Create imgCappingBg
local imgCappingBg = ccui.ImageView:create()
imgCappingBg:ignoreContentAdaptWithSize(false)
imgCappingBg:loadTexture("game/goldflower_std/resource/image/dz.png",0)
imgCappingBg:setLayoutComponentEnabled(true)
imgCappingBg:setName("imgCappingBg")
imgCappingBg:setTag(175)
imgCappingBg:setCascadeColorEnabled(true)
imgCappingBg:setCascadeOpacityEnabled(true)
imgCappingBg:setPosition(675.0000, 1030.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgCappingBg)
layout:setSize({width = 289.0000, height = 104.0000})
layout:setLeftMargin(530.5000)
layout:setRightMargin(-819.5000)
layout:setTopMargin(-1082.0000)
layout:setBottomMargin(978.0000)
nodePlayer:addChild(imgCappingBg)

--Create fntCapping2
local fntCapping2 = ccui.Text:create()
fntCapping2:setFontName("lobby/resource/font/simhei.ttf")
fntCapping2:setFontSize(30)
fntCapping2:setString([[]])
fntCapping2:setLayoutComponentEnabled(true)
fntCapping2:setName("fntCapping2")
fntCapping2:setTag(178)
fntCapping2:setCascadeColorEnabled(true)
fntCapping2:setCascadeOpacityEnabled(true)
fntCapping2:setAnchorPoint(0.0000, 0.5000)
fntCapping2:setPosition(675.0000, 1010.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntCapping2)
layout:setLeftMargin(675.0000)
layout:setRightMargin(-675.0000)
layout:setTopMargin(-1010.0000)
layout:setBottomMargin(1010.0000)
nodePlayer:addChild(fntCapping2)

--Create fntCapping1
local fntCapping1 = ccui.Text:create()
fntCapping1:setFontName("lobby/resource/font/simhei.ttf")
fntCapping1:setFontSize(30)
fntCapping1:setString([[]])
fntCapping1:setLayoutComponentEnabled(true)
fntCapping1:setName("fntCapping1")
fntCapping1:setTag(177)
fntCapping1:setCascadeColorEnabled(true)
fntCapping1:setCascadeOpacityEnabled(true)
fntCapping1:setAnchorPoint(0.0000, 0.5000)
fntCapping1:setPosition(675.0000, 1050.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntCapping1)
layout:setLeftMargin(675.0000)
layout:setRightMargin(-675.0000)
layout:setTopMargin(-1050.0000)
layout:setBottomMargin(1050.0000)
nodePlayer:addChild(fntCapping1)

--Create imgAntebg
local imgAntebg = ccui.ImageView:create()
imgAntebg:ignoreContentAdaptWithSize(false)
imgAntebg:loadTexture("game/baccarat_std/resource/image/xiazhu/3.png",0)
imgAntebg:setLayoutComponentEnabled(true)
imgAntebg:setName("imgAntebg")
imgAntebg:setTag(180)
imgAntebg:setCascadeColorEnabled(true)
imgAntebg:setCascadeOpacityEnabled(true)
imgAntebg:setPosition(957.1341, 444.1152)
layout = ccui.LayoutComponent:bindLayoutComponent(imgAntebg)
layout:setPositionPercentX(0.4985)
layout:setPositionPercentY(0.4112)
layout:setPercentWidth(0.2365)
layout:setPercentHeight(0.0806)
layout:setSize({width = 454.0000, height = 87.0000})
layout:setLeftMargin(730.1341)
layout:setRightMargin(735.8660)
layout:setTopMargin(592.3848)
layout:setBottomMargin(400.6152)
Scene:addChild(imgAntebg)

--Create fntAnte
local fntAnte = ccui.Text:create()
fntAnte:setFontName("lobby/resource/font/simhei.ttf")
fntAnte:setFontSize(30)
fntAnte:setString([[]])
fntAnte:setLayoutComponentEnabled(true)
fntAnte:setName("fntAnte")
fntAnte:setTag(181)
fntAnte:setCascadeColorEnabled(true)
fntAnte:setCascadeOpacityEnabled(true)
fntAnte:setPosition(227.0000, 44.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntAnte)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5057)
layout:setLeftMargin(227.0000)
layout:setRightMargin(227.0000)
layout:setTopMargin(43.0000)
layout:setBottomMargin(44.0000)
imgAntebg:addChild(fntAnte)

--Create btnReady
local btnReady = ccui.Button:create()
btnReady:ignoreContentAdaptWithSize(false)
btnReady:loadTextureNormal("game/goldflower_std/resource/button/zb.png",0)
btnReady:loadTexturePressed("game/goldflower_std/resource/button/zb.png",0)
btnReady:loadTextureDisabled("Default/Button_Disable.png",0)
btnReady:setTitleFontSize(14)
btnReady:setTitleColor({r = 65, g = 65, b = 70})
btnReady:setScale9Enabled(true)
btnReady:setCapInsets({x = 15, y = 11, width = 225, height = 75})
btnReady:setLayoutComponentEnabled(true)
btnReady:setName("btnReady")
btnReady:setTag(182)
btnReady:setCascadeColorEnabled(true)
btnReady:setCascadeOpacityEnabled(true)
btnReady:setPosition(760.0000, 450.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnReady)
layout:setPositionPercentX(0.3958)
layout:setPositionPercentY(0.4167)
layout:setPercentWidth(0.1328)
layout:setPercentHeight(0.0898)
layout:setSize({width = 255.0000, height = 97.0000})
layout:setLeftMargin(632.5000)
layout:setRightMargin(1032.5000)
layout:setTopMargin(581.5000)
layout:setBottomMargin(401.5000)
Scene:addChild(btnReady)

--Create btnChangeTable
local btnChangeTable = ccui.Button:create()
btnChangeTable:ignoreContentAdaptWithSize(false)
btnChangeTable:loadTextureNormal("game/goldflower_std/resource/button/hz.png",0)
btnChangeTable:loadTexturePressed("game/goldflower_std/resource/button/hz.png",0)
btnChangeTable:loadTextureDisabled("Default/Button_Disable.png",0)
btnChangeTable:setTitleFontSize(14)
btnChangeTable:setTitleColor({r = 65, g = 65, b = 70})
btnChangeTable:setScale9Enabled(true)
btnChangeTable:setCapInsets({x = 15, y = 11, width = 225, height = 75})
btnChangeTable:setLayoutComponentEnabled(true)
btnChangeTable:setName("btnChangeTable")
btnChangeTable:setTag(183)
btnChangeTable:setCascadeColorEnabled(true)
btnChangeTable:setCascadeOpacityEnabled(true)
btnChangeTable:setPosition(1160.0000, 450.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnChangeTable)
layout:setPositionPercentX(0.6042)
layout:setPositionPercentY(0.4167)
layout:setPercentWidth(0.1328)
layout:setPercentHeight(0.0898)
layout:setSize({width = 255.0000, height = 97.0000})
layout:setLeftMargin(1032.5000)
layout:setRightMargin(632.5000)
layout:setTopMargin(581.5000)
layout:setBottomMargin(401.5000)
Scene:addChild(btnChangeTable)

--Create btnKanpai
local btnKanpai = ccui.Button:create()
btnKanpai:ignoreContentAdaptWithSize(false)
btnKanpai:loadTextureNormal("game/goldflower_std/resource/button/kpan.png",0)
btnKanpai:loadTexturePressed("game/goldflower_std/resource/button/kpan.png",0)
btnKanpai:loadTextureDisabled("game/goldflower_std/resource/button/ankp.png",0)
btnKanpai:setTitleFontSize(14)
btnKanpai:setTitleColor({r = 65, g = 65, b = 70})
btnKanpai:setScale9Enabled(true)
btnKanpai:setCapInsets({x = 15, y = 11, width = 94, height = 104})
btnKanpai:setLayoutComponentEnabled(true)
btnKanpai:setName("btnKanpai")
btnKanpai:setTag(184)
btnKanpai:setCascadeColorEnabled(true)
btnKanpai:setCascadeOpacityEnabled(true)
btnKanpai:setPosition(1165.7790, 191.1384)
layout = ccui.LayoutComponent:bindLayoutComponent(btnKanpai)
layout:setPositionPercentX(0.6072)
layout:setPositionPercentY(0.1770)
layout:setPercentWidth(0.0646)
layout:setPercentHeight(0.1167)
layout:setSize({width = 124.0000, height = 126.0000})
layout:setLeftMargin(1103.7790)
layout:setRightMargin(692.2206)
layout:setTopMargin(825.8616)
layout:setBottomMargin(128.1384)
Scene:addChild(btnKanpai)

--Create btnGenzhu
local btnGenzhu = ccui.Button:create()
btnGenzhu:ignoreContentAdaptWithSize(false)
btnGenzhu:loadTextureNormal("game/goldflower_std/resource/button/gz.png",0)
btnGenzhu:loadTexturePressed("game/goldflower_std/resource/button/gz.png",0)
btnGenzhu:loadTextureDisabled("game/goldflower_std/resource/button/gzan.png",0)
btnGenzhu:setTitleFontSize(14)
btnGenzhu:setTitleColor({r = 65, g = 65, b = 70})
btnGenzhu:setScale9Enabled(true)
btnGenzhu:setCapInsets({x = 15, y = 11, width = 94, height = 104})
btnGenzhu:setLayoutComponentEnabled(true)
btnGenzhu:setName("btnGenzhu")
btnGenzhu:setTag(185)
btnGenzhu:setCascadeColorEnabled(true)
btnGenzhu:setCascadeOpacityEnabled(true)
btnGenzhu:setPosition(1415.7800, 191.1384)
layout = ccui.LayoutComponent:bindLayoutComponent(btnGenzhu)
layout:setPositionPercentX(0.7374)
layout:setPositionPercentY(0.1770)
layout:setPercentWidth(0.0646)
layout:setPercentHeight(0.1167)
layout:setSize({width = 124.0000, height = 126.0000})
layout:setLeftMargin(1353.7800)
layout:setRightMargin(442.2196)
layout:setTopMargin(825.8616)
layout:setBottomMargin(128.1384)
Scene:addChild(btnGenzhu)

--Create btnJiazhu
local btnJiazhu = ccui.Button:create()
btnJiazhu:ignoreContentAdaptWithSize(false)
btnJiazhu:loadTextureNormal("game/goldflower_std/resource/button/jz.png",0)
btnJiazhu:loadTexturePressed("game/goldflower_std/resource/button/jz.png",0)
btnJiazhu:loadTextureDisabled("game/goldflower_std/resource/button/jzan.png",0)
btnJiazhu:setTitleFontSize(14)
btnJiazhu:setTitleColor({r = 65, g = 65, b = 70})
btnJiazhu:setScale9Enabled(true)
btnJiazhu:setCapInsets({x = 15, y = 11, width = 94, height = 104})
btnJiazhu:setLayoutComponentEnabled(true)
btnJiazhu:setName("btnJiazhu")
btnJiazhu:setTag(186)
btnJiazhu:setCascadeColorEnabled(true)
btnJiazhu:setCascadeOpacityEnabled(true)
btnJiazhu:setPosition(1295.7790, 191.1384)
layout = ccui.LayoutComponent:bindLayoutComponent(btnJiazhu)
layout:setPositionPercentX(0.6749)
layout:setPositionPercentY(0.1770)
layout:setPercentWidth(0.0646)
layout:setPercentHeight(0.1167)
layout:setSize({width = 124.0000, height = 126.0000})
layout:setLeftMargin(1233.7790)
layout:setRightMargin(562.2209)
layout:setTopMargin(825.8616)
layout:setBottomMargin(128.1384)
Scene:addChild(btnJiazhu)

--Create btnCancel
local btnCancel = ccui.Button:create()
btnCancel:ignoreContentAdaptWithSize(false)
btnCancel:loadTextureNormal("game/goldflower_std/resource/button/qx.png",0)
btnCancel:loadTexturePressed("game/goldflower_std/resource/button/qx.png",0)
btnCancel:loadTextureDisabled("game/goldflower_std/resource/button/qxan.png",0)
btnCancel:setTitleFontSize(14)
btnCancel:setTitleColor({r = 65, g = 65, b = 70})
btnCancel:setScale9Enabled(true)
btnCancel:setCapInsets({x = 15, y = 11, width = 94, height = 104})
btnCancel:setLayoutComponentEnabled(true)
btnCancel:setName("btnCancel")
btnCancel:setTag(187)
btnCancel:setCascadeColorEnabled(true)
btnCancel:setCascadeOpacityEnabled(true)
btnCancel:setPosition(1535.7750, 191.1384)
layout = ccui.LayoutComponent:bindLayoutComponent(btnCancel)
layout:setPositionPercentX(0.7999)
layout:setPositionPercentY(0.1770)
layout:setPercentWidth(0.0646)
layout:setPercentHeight(0.1167)
layout:setSize({width = 124.0000, height = 126.0000})
layout:setLeftMargin(1473.7750)
layout:setRightMargin(322.2255)
layout:setTopMargin(825.8616)
layout:setBottomMargin(128.1384)
Scene:addChild(btnCancel)

--Create btnBipai
local btnBipai = ccui.Button:create()
btnBipai:ignoreContentAdaptWithSize(false)
btnBipai:loadTextureNormal("game/goldflower_std/resource/button/bp.png",0)
btnBipai:loadTexturePressed("game/goldflower_std/resource/button/bp.png",0)
btnBipai:loadTextureDisabled("game/goldflower_std/resource/button/bp1.png",0)
btnBipai:setTitleFontSize(14)
btnBipai:setTitleColor({r = 65, g = 65, b = 70})
btnBipai:setScale9Enabled(true)
btnBipai:setCapInsets({x = 15, y = 11, width = 94, height = 104})
btnBipai:setLayoutComponentEnabled(true)
btnBipai:setName("btnBipai")
btnBipai:setTag(188)
btnBipai:setCascadeColorEnabled(true)
btnBipai:setCascadeOpacityEnabled(true)
btnBipai:setPosition(1535.7690, 191.1385)
btnBipai:setRotationSkewX(0.5036)
btnBipai:setRotationSkewY(0.5018)
layout = ccui.LayoutComponent:bindLayoutComponent(btnBipai)
layout:setPositionPercentX(0.7999)
layout:setPositionPercentY(0.1770)
layout:setPercentWidth(0.0646)
layout:setPercentHeight(0.1167)
layout:setSize({width = 124.0000, height = 126.0000})
layout:setLeftMargin(1473.7690)
layout:setRightMargin(322.2311)
layout:setTopMargin(825.8615)
layout:setBottomMargin(128.1385)
Scene:addChild(btnBipai)

--Create btnQipai
local btnQipai = ccui.Button:create()
btnQipai:ignoreContentAdaptWithSize(false)
btnQipai:loadTextureNormal("game/goldflower_std/resource/button/qp1.png",0)
btnQipai:loadTexturePressed("game/goldflower_std/resource/button/qp1.png",0)
btnQipai:loadTextureDisabled("game/goldflower_std/resource/button/qpan.png",0)
btnQipai:setTitleFontSize(14)
btnQipai:setTitleColor({r = 65, g = 65, b = 70})
btnQipai:setScale9Enabled(true)
btnQipai:setCapInsets({x = 15, y = 11, width = 94, height = 104})
btnQipai:setLayoutComponentEnabled(true)
btnQipai:setName("btnQipai")
btnQipai:setTag(189)
btnQipai:setCascadeColorEnabled(true)
btnQipai:setCascadeOpacityEnabled(true)
btnQipai:setPosition(1655.7710, 191.1384)
layout = ccui.LayoutComponent:bindLayoutComponent(btnQipai)
layout:setPositionPercentX(0.8624)
layout:setPositionPercentY(0.1770)
layout:setPercentWidth(0.0646)
layout:setPercentHeight(0.1167)
layout:setSize({width = 124.0000, height = 126.0000})
layout:setLeftMargin(1593.7710)
layout:setRightMargin(202.2290)
layout:setTopMargin(825.8616)
layout:setBottomMargin(128.1384)
Scene:addChild(btnQipai)

--Create imgJiazhubg
local imgJiazhubg = ccui.ImageView:create()
imgJiazhubg:ignoreContentAdaptWithSize(false)
imgJiazhubg:loadTexture("game/goldflower_std/resource/image/cmk.png",0)
imgJiazhubg:setLayoutComponentEnabled(true)
imgJiazhubg:setName("imgJiazhubg")
imgJiazhubg:setTag(190)
imgJiazhubg:setCascadeColorEnabled(true)
imgJiazhubg:setCascadeOpacityEnabled(true)
imgJiazhubg:setPosition(1625.5920, 355.1788)
layout = ccui.LayoutComponent:bindLayoutComponent(imgJiazhubg)
layout:setPositionPercentX(0.8467)
layout:setPositionPercentY(0.3289)
layout:setPercentWidth(0.2510)
layout:setPercentHeight(0.1574)
layout:setSize({width = 482.0000, height = 170.0000})
layout:setLeftMargin(1384.5920)
layout:setRightMargin(53.4081)
layout:setTopMargin(639.8212)
layout:setBottomMargin(270.1788)
Scene:addChild(imgJiazhubg)

--Create btnExitAddPanel
local btnExitAddPanel = ccui.Button:create()
btnExitAddPanel:ignoreContentAdaptWithSize(false)
btnExitAddPanel:loadTextureNormal("game/goldflower_std/resource/button/ch.png",0)
btnExitAddPanel:loadTexturePressed("game/goldflower_std/resource/button/ch.png",0)
btnExitAddPanel:loadTextureDisabled("game/goldflower_std/resource/button/ch.png",0)
btnExitAddPanel:setTitleFontSize(14)
btnExitAddPanel:setTitleColor({r = 65, g = 65, b = 70})
btnExitAddPanel:setScale9Enabled(true)
btnExitAddPanel:setCapInsets({x = 15, y = 11, width = 78, height = 86})
btnExitAddPanel:setLayoutComponentEnabled(true)
btnExitAddPanel:setName("btnExitAddPanel")
btnExitAddPanel:setTag(191)
btnExitAddPanel:setCascadeColorEnabled(true)
btnExitAddPanel:setCascadeOpacityEnabled(true)
btnExitAddPanel:setPosition(454.2095, 151.6427)
layout = ccui.LayoutComponent:bindLayoutComponent(btnExitAddPanel)
layout:setPositionPercentX(0.9423)
layout:setPositionPercentY(0.8920)
layout:setPercentWidth(0.2241)
layout:setPercentHeight(0.6353)
layout:setSize({width = 108.0000, height = 108.0000})
layout:setLeftMargin(400.2095)
layout:setRightMargin(-26.2095)
layout:setTopMargin(-35.6427)
layout:setBottomMargin(97.6427)
imgJiazhubg:addChild(btnExitAddPanel)

--Create btnAddChip1
local btnAddChip1 = ccui.Button:create()
btnAddChip1:ignoreContentAdaptWithSize(false)
btnAddChip1:loadTextureNormal("game/goldflower_std/resource/button/cm1.png",0)
btnAddChip1:loadTexturePressed("game/goldflower_std/resource/button/cm1.png",0)
btnAddChip1:loadTextureDisabled("game/goldflower_std/resource/button/cm1.png",0)
btnAddChip1:setTitleFontSize(14)
btnAddChip1:setTitleColor({r = 65, g = 65, b = 70})
btnAddChip1:setScale9Enabled(true)
btnAddChip1:setCapInsets({x = 15, y = 11, width = 90, height = 92})
btnAddChip1:setLayoutComponentEnabled(true)
btnAddChip1:setName("btnAddChip1")
btnAddChip1:setTag(192)
btnAddChip1:setCascadeColorEnabled(true)
btnAddChip1:setCascadeOpacityEnabled(true)
btnAddChip1:setPosition(90.0000, 85.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnAddChip1)
layout:setPositionPercentX(0.1867)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.2490)
layout:setPercentHeight(0.6706)
layout:setSize({width = 120.0000, height = 114.0000})
layout:setLeftMargin(30.0000)
layout:setRightMargin(332.0000)
layout:setTopMargin(28.0000)
layout:setBottomMargin(28.0000)
imgJiazhubg:addChild(btnAddChip1)

--Create btnAddChip2
local btnAddChip2 = ccui.Button:create()
btnAddChip2:ignoreContentAdaptWithSize(false)
btnAddChip2:loadTextureNormal("game/goldflower_std/resource/button/cm5.png",0)
btnAddChip2:loadTexturePressed("game/goldflower_std/resource/button/cm5.png",0)
btnAddChip2:loadTextureDisabled("game/goldflower_std/resource/button/cm5.png",0)
btnAddChip2:setTitleFontSize(14)
btnAddChip2:setTitleColor({r = 65, g = 65, b = 70})
btnAddChip2:setScale9Enabled(true)
btnAddChip2:setCapInsets({x = 15, y = 11, width = 90, height = 92})
btnAddChip2:setLayoutComponentEnabled(true)
btnAddChip2:setName("btnAddChip2")
btnAddChip2:setTag(193)
btnAddChip2:setCascadeColorEnabled(true)
btnAddChip2:setCascadeOpacityEnabled(true)
btnAddChip2:setPosition(208.9655, 84.9999)
layout = ccui.LayoutComponent:bindLayoutComponent(btnAddChip2)
layout:setPositionPercentX(0.4335)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.2490)
layout:setPercentHeight(0.6706)
layout:setSize({width = 120.0000, height = 114.0000})
layout:setLeftMargin(148.9655)
layout:setRightMargin(213.0345)
layout:setTopMargin(28.0001)
layout:setBottomMargin(27.9999)
imgJiazhubg:addChild(btnAddChip2)

--Create btnAddChip3
local btnAddChip3 = ccui.Button:create()
btnAddChip3:ignoreContentAdaptWithSize(false)
btnAddChip3:loadTextureNormal("game/goldflower_std/resource/button/cm2.png",0)
btnAddChip3:loadTexturePressed("game/goldflower_std/resource/button/cm2.png",0)
btnAddChip3:loadTextureDisabled("game/goldflower_std/resource/button/cm2.png",0)
btnAddChip3:setTitleFontSize(14)
btnAddChip3:setTitleColor({r = 65, g = 65, b = 70})
btnAddChip3:setScale9Enabled(true)
btnAddChip3:setCapInsets({x = 15, y = 11, width = 90, height = 92})
btnAddChip3:setLayoutComponentEnabled(true)
btnAddChip3:setName("btnAddChip3")
btnAddChip3:setTag(194)
btnAddChip3:setCascadeColorEnabled(true)
btnAddChip3:setCascadeOpacityEnabled(true)
btnAddChip3:setPosition(330.0000, 85.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnAddChip3)
layout:setPositionPercentX(0.6846)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.2490)
layout:setPercentHeight(0.6706)
layout:setSize({width = 120.0000, height = 114.0000})
layout:setLeftMargin(270.0000)
layout:setRightMargin(92.0000)
layout:setTopMargin(28.0000)
layout:setBottomMargin(28.0000)
imgJiazhubg:addChild(btnAddChip3)

--Create fntAddChip1
local fntAddChip1 = ccui.Text:create()
fntAddChip1:setFontName("lobby/resource/font/simhei.ttf")
fntAddChip1:setFontSize(30)
fntAddChip1:setString([[]])
fntAddChip1:setLayoutComponentEnabled(true)
fntAddChip1:setName("fntAddChip1")
fntAddChip1:setTag(195)
fntAddChip1:setCascadeColorEnabled(true)
fntAddChip1:setCascadeOpacityEnabled(true)
fntAddChip1:setPosition(90.0000, 90.0000)
fntAddChip1:setScaleX(1.5000)
fntAddChip1:setScaleY(1.5000)
fntAddChip1:setColor({r = 0, g = 0, b = 0})
layout = ccui.LayoutComponent:bindLayoutComponent(fntAddChip1)
layout:setPositionPercentX(0.1867)
layout:setPositionPercentY(0.5294)
layout:setLeftMargin(90.0000)
layout:setRightMargin(392.0000)
layout:setTopMargin(80.0000)
layout:setBottomMargin(90.0000)
imgJiazhubg:addChild(fntAddChip1)

--Create fntAddChip2
local fntAddChip2 = ccui.Text:create()
fntAddChip2:setFontName("lobby/resource/font/simhei.ttf")
fntAddChip2:setFontSize(30)
fntAddChip2:setString([[]])
fntAddChip2:setLayoutComponentEnabled(true)
fntAddChip2:setName("fntAddChip2")
fntAddChip2:setTag(196)
fntAddChip2:setCascadeColorEnabled(true)
fntAddChip2:setCascadeOpacityEnabled(true)
fntAddChip2:setPosition(210.0000, 90.0000)
fntAddChip2:setScaleX(1.5000)
fntAddChip2:setScaleY(1.5000)
fntAddChip2:setColor({r = 0, g = 0, b = 0})
layout = ccui.LayoutComponent:bindLayoutComponent(fntAddChip2)
layout:setPositionPercentX(0.4357)
layout:setPositionPercentY(0.5294)
layout:setLeftMargin(210.0000)
layout:setRightMargin(272.0000)
layout:setTopMargin(80.0000)
layout:setBottomMargin(90.0000)
imgJiazhubg:addChild(fntAddChip2)

--Create fntAddChip3
local fntAddChip3 = ccui.Text:create()
fntAddChip3:setFontName("lobby/resource/font/simhei.ttf")
fntAddChip3:setFontSize(30)
fntAddChip3:setString([[]])
fntAddChip3:setLayoutComponentEnabled(true)
fntAddChip3:setName("fntAddChip3")
fntAddChip3:setTag(197)
fntAddChip3:setCascadeColorEnabled(true)
fntAddChip3:setCascadeOpacityEnabled(true)
fntAddChip3:setPosition(330.0000, 90.0000)
fntAddChip3:setScaleX(1.5000)
fntAddChip3:setScaleY(1.5000)
fntAddChip3:setColor({r = 0, g = 0, b = 0})
layout = ccui.LayoutComponent:bindLayoutComponent(fntAddChip3)
layout:setPositionPercentX(0.6846)
layout:setPositionPercentY(0.5294)
layout:setLeftMargin(330.0000)
layout:setRightMargin(152.0000)
layout:setTopMargin(80.0000)
layout:setBottomMargin(90.0000)
imgJiazhubg:addChild(fntAddChip3)

--Create btnSet
local btnSet = ccui.Button:create()
btnSet:ignoreContentAdaptWithSize(false)
btnSet:loadTextureNormal("game/goldflower_std/resource/button/sz.png",0)
btnSet:loadTexturePressed("game/goldflower_std/resource/button/sz.png",0)
btnSet:loadTextureDisabled("Default/Button_Disable.png",0)
btnSet:setTitleFontSize(14)
btnSet:setTitleColor({r = 65, g = 65, b = 70})
btnSet:setScale9Enabled(true)
btnSet:setCapInsets({x = 15, y = 11, width = 48, height = 56})
btnSet:setLayoutComponentEnabled(true)
btnSet:setName("btnSet")
btnSet:setTag(198)
btnSet:setCascadeColorEnabled(true)
btnSet:setCascadeOpacityEnabled(true)
btnSet:setPosition(1850.0000, 1010.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnSet)
layout:setPositionPercentX(0.9635)
layout:setPositionPercentY(0.9352)
layout:setPercentWidth(0.0406)
layout:setPercentHeight(0.0722)
layout:setSize({width = 78.0000, height = 78.0000})
layout:setLeftMargin(1811.0000)
layout:setRightMargin(31.0000)
layout:setTopMargin(31.0000)
layout:setBottomMargin(971.0000)
Scene:addChild(btnSet)

--Create btnExit
local btnExit = ccui.Button:create()
btnExit:ignoreContentAdaptWithSize(false)
btnExit:loadTextureNormal("game/goldflower_std/resource/button/tc.png",0)
btnExit:loadTexturePressed("game/goldflower_std/resource/button/tc.png",0)
btnExit:loadTextureDisabled("Default/Button_Disable.png",0)
btnExit:setTitleFontSize(14)
btnExit:setTitleColor({r = 65, g = 65, b = 70})
btnExit:setScale9Enabled(true)
btnExit:setCapInsets({x = 15, y = 11, width = 48, height = 56})
btnExit:setLayoutComponentEnabled(true)
btnExit:setName("btnExit")
btnExit:setTag(199)
btnExit:setCascadeColorEnabled(true)
btnExit:setCascadeOpacityEnabled(true)
btnExit:setPosition(50.0000, 1010.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnExit)
layout:setPositionPercentX(0.0260)
layout:setPositionPercentY(0.9352)
layout:setPercentWidth(0.0406)
layout:setPercentHeight(0.0722)
layout:setSize({width = 78.0000, height = 78.0000})
layout:setLeftMargin(11.0000)
layout:setRightMargin(1831.0000)
layout:setTopMargin(31.0000)
layout:setBottomMargin(971.0000)
Scene:addChild(btnExit)

--Create btnCardPatterns
local btnCardPatterns = ccui.Button:create()
btnCardPatterns:ignoreContentAdaptWithSize(false)
btnCardPatterns:loadTextureNormal("game/goldflower_std/resource/button/px1.png",0)
btnCardPatterns:loadTexturePressed("game/goldflower_std/resource/button/px1.png",0)
btnCardPatterns:loadTextureDisabled("Default/Button_Disable.png",0)
btnCardPatterns:setTitleFontSize(14)
btnCardPatterns:setTitleColor({r = 65, g = 65, b = 70})
btnCardPatterns:setScale9Enabled(true)
btnCardPatterns:setCapInsets({x = 15, y = 11, width = 150, height = 98})
btnCardPatterns:setLayoutComponentEnabled(true)
btnCardPatterns:setName("btnCardPatterns")
btnCardPatterns:setTag(200)
btnCardPatterns:setCascadeColorEnabled(true)
btnCardPatterns:setCascadeOpacityEnabled(true)
btnCardPatterns:setPosition(300.0000, 85.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnCardPatterns)
layout:setPositionPercentX(0.1563)
layout:setPositionPercentY(0.0787)
layout:setPercentWidth(0.0938)
layout:setPercentHeight(0.1111)
layout:setSize({width = 180.0000, height = 120.0000})
layout:setLeftMargin(210.0000)
layout:setRightMargin(1530.0000)
layout:setTopMargin(935.0000)
layout:setBottomMargin(25.0000)
Scene:addChild(btnCardPatterns)

--Create btnExchange
local btnExchange = ccui.Button:create()
btnExchange:ignoreContentAdaptWithSize(false)
btnExchange:loadTextureNormal("game/goldflower_std/resource/button/dh.png",0)
btnExchange:loadTexturePressed("game/goldflower_std/resource/button/dh.png",0)
btnExchange:loadTextureDisabled("Default/Button_Disable.png",0)
btnExchange:setTitleFontSize(14)
btnExchange:setTitleColor({r = 65, g = 65, b = 70})
btnExchange:setScale9Enabled(true)
btnExchange:setCapInsets({x = 15, y = 11, width = 150, height = 98})
btnExchange:setLayoutComponentEnabled(true)
btnExchange:setName("btnExchange")
btnExchange:setTag(201)
btnExchange:setCascadeColorEnabled(true)
btnExchange:setCascadeOpacityEnabled(true)
btnExchange:setPosition(120.0000, 85.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnExchange)
layout:setPositionPercentX(0.0625)
layout:setPositionPercentY(0.0787)
layout:setPercentWidth(0.0938)
layout:setPercentHeight(0.1111)
layout:setSize({width = 180.0000, height = 120.0000})
layout:setLeftMargin(30.0000)
layout:setRightMargin(1710.0000)
layout:setTopMargin(935.0000)
layout:setBottomMargin(25.0000)
Scene:addChild(btnExchange)

--Create imgCardbg
local imgCardbg = ccui.ImageView:create()
imgCardbg:ignoreContentAdaptWithSize(false)
imgCardbg:loadTexture("game/goldflower_std/resource/image/px.png",0)
imgCardbg:setLayoutComponentEnabled(true)
imgCardbg:setName("imgCardbg")
imgCardbg:setTag(202)
imgCardbg:setCascadeColorEnabled(true)
imgCardbg:setCascadeOpacityEnabled(true)
imgCardbg:setPosition(240.8800, 593.7716)
layout = ccui.LayoutComponent:bindLayoutComponent(imgCardbg)
layout:setPositionPercentX(0.1255)
layout:setPositionPercentY(0.5498)
layout:setPercentWidth(0.2552)
layout:setPercentHeight(0.7944)
layout:setSize({width = 490.0000, height = 858.0000})
layout:setLeftMargin(-4.1200)
layout:setRightMargin(1434.1200)
layout:setTopMargin(57.2284)
layout:setBottomMargin(164.7716)
Scene:addChild(imgCardbg)

--Create nodeEffect
local nodeEffect=cc.Node:create()
nodeEffect:setName("nodeEffect")
nodeEffect:setTag(203)
nodeEffect:setCascadeColorEnabled(true)
nodeEffect:setCascadeOpacityEnabled(true)
nodeEffect:setPosition(960.0000, 650.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(nodeEffect)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.6019)
layout:setLeftMargin(960.0000)
layout:setRightMargin(960.0000)
layout:setTopMargin(430.0000)
layout:setBottomMargin(650.0000)
Scene:addChild(nodeEffect)

--Create sbtnAutoReady
local sbtnAutoReady = ccui.CheckBox:create()
sbtnAutoReady:ignoreContentAdaptWithSize(false)
sbtnAutoReady:loadTextureBackGround("game/goldflower_std/resource/button/dh3.png",0)
sbtnAutoReady:loadTextureBackGroundSelected("game/goldflower_std/resource/button/dh3.png",0)
sbtnAutoReady:loadTextureBackGroundDisabled("game/goldflower_std/resource/button/dh3.png",0)
sbtnAutoReady:loadTextureFrontCross("game/goldflower_std/resource/button/dh2.png",0)
sbtnAutoReady:loadTextureFrontCrossDisabled("game/goldflower_std/resource/button/dh2.png",0)
sbtnAutoReady:setLayoutComponentEnabled(true)
sbtnAutoReady:setName("sbtnAutoReady")
sbtnAutoReady:setTag(204)
sbtnAutoReady:setCascadeColorEnabled(true)
sbtnAutoReady:setCascadeOpacityEnabled(true)
sbtnAutoReady:setPosition(1420.0000, 50.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sbtnAutoReady)
layout:setPositionPercentX(0.7396)
layout:setPositionPercentY(0.0463)
layout:setPercentWidth(0.0333)
layout:setPercentHeight(0.0593)
layout:setSize({width = 64.0000, height = 64.0000})
layout:setLeftMargin(1388.0000)
layout:setRightMargin(468.0000)
layout:setTopMargin(998.0000)
layout:setBottomMargin(18.0000)
Scene:addChild(sbtnAutoReady)

--Create imgAutoReady
local imgAutoReady = ccui.ImageView:create()
imgAutoReady:ignoreContentAdaptWithSize(false)
imgAutoReady:loadTexture("game/goldflower_std/resource/button/zdzb.png",0)
imgAutoReady:setLayoutComponentEnabled(true)
imgAutoReady:setName("imgAutoReady")
imgAutoReady:setTag(205)
imgAutoReady:setCascadeColorEnabled(true)
imgAutoReady:setCascadeOpacityEnabled(true)
imgAutoReady:setPosition(1540.0000, 50.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgAutoReady)
layout:setPositionPercentX(0.8021)
layout:setPositionPercentY(0.0463)
layout:setPercentWidth(0.0938)
layout:setPercentHeight(0.1111)
layout:setSize({width = 180.0000, height = 120.0000})
layout:setLeftMargin(1450.0000)
layout:setRightMargin(290.0000)
layout:setTopMargin(970.0000)
layout:setBottomMargin(-10.0000)
Scene:addChild(imgAutoReady)

--Create sbtnKeepAny
local sbtnKeepAny = ccui.CheckBox:create()
sbtnKeepAny:ignoreContentAdaptWithSize(false)
sbtnKeepAny:loadTextureBackGround("game/goldflower_std/resource/button/dh3.png",0)
sbtnKeepAny:loadTextureBackGroundSelected("game/goldflower_std/resource/button/dh3.png",0)
sbtnKeepAny:loadTextureBackGroundDisabled("game/goldflower_std/resource/button/dh3.png",0)
sbtnKeepAny:loadTextureFrontCross("game/goldflower_std/resource/button/dh2.png",0)
sbtnKeepAny:loadTextureFrontCrossDisabled("game/goldflower_std/resource/button/dh2.png",0)
sbtnKeepAny:setLayoutComponentEnabled(true)
sbtnKeepAny:setName("sbtnKeepAny")
sbtnKeepAny:setTag(206)
sbtnKeepAny:setCascadeColorEnabled(true)
sbtnKeepAny:setCascadeOpacityEnabled(true)
sbtnKeepAny:setPosition(1650.0000, 50.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sbtnKeepAny)
layout:setPositionPercentX(0.8594)
layout:setPositionPercentY(0.0463)
layout:setPercentWidth(0.0333)
layout:setPercentHeight(0.0593)
layout:setSize({width = 64.0000, height = 64.0000})
layout:setLeftMargin(1618.0000)
layout:setRightMargin(238.0000)
layout:setTopMargin(998.0000)
layout:setBottomMargin(18.0000)
Scene:addChild(sbtnKeepAny)

--Create imgKeepAny
local imgKeepAny = ccui.ImageView:create()
imgKeepAny:ignoreContentAdaptWithSize(false)
imgKeepAny:loadTexture("game/goldflower_std/resource/button/zdgz.png",0)
imgKeepAny:setLayoutComponentEnabled(true)
imgKeepAny:setName("imgKeepAny")
imgKeepAny:setTag(207)
imgKeepAny:setCascadeColorEnabled(true)
imgKeepAny:setCascadeOpacityEnabled(true)
imgKeepAny:setAnchorPoint(0.4942, 0.4655)
imgKeepAny:setPosition(1760.0000, 50.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgKeepAny)
layout:setPositionPercentX(0.9167)
layout:setPositionPercentY(0.0463)
layout:setPercentWidth(0.0938)
layout:setPercentHeight(0.1111)
layout:setSize({width = 180.0000, height = 120.0000})
layout:setLeftMargin(1671.0440)
layout:setRightMargin(68.9561)
layout:setTopMargin(965.8600)
layout:setBottomMargin(-5.8600)
Scene:addChild(imgKeepAny)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Scene
return result;
end

return Result
