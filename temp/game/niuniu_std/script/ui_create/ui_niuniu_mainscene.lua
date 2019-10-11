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

--Create sprSceneBack
local sprSceneBack = cc.Sprite:create("game/niuniu_std/resource/image/Bj.png")
sprSceneBack:setName("sprSceneBack")
sprSceneBack:setTag(88)
sprSceneBack:setCascadeColorEnabled(true)
sprSceneBack:setCascadeOpacityEnabled(true)
sprSceneBack:setAnchorPoint(0.0000, 0.0000)
sprSceneBack:setPosition(0.0000, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprSceneBack)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(1920.0000, 1080.0000))
layout:setLeftMargin(0.0000)
layout:setRightMargin(0.0000)
layout:setTopMargin(0.0000)
layout:setBottomMargin(0.0000)
Scene:addChild(sprSceneBack)

--Create playerNode
local playerNode=cc.Node:create()
playerNode:setName("playerNode")
playerNode:setTag(166)
playerNode:setCascadeColorEnabled(true)
playerNode:setCascadeOpacityEnabled(true)
playerNode:setPosition(0.0000, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(playerNode)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setLeftMargin(0.0000)
layout:setRightMargin(1920.0000)
layout:setTopMargin(1080.0000)
layout:setBottomMargin(0.0000)
Scene:addChild(playerNode)

--Create btn_ready
local btn_ready = ccui.Button:create()
btn_ready:ignoreContentAdaptWithSize(false)
btn_ready:loadTextureNormal("game/niuniu_std/resource/button/Nroom_startbt.png",0)
btn_ready:setTitleFontSize(14)
btn_ready:setTitleColor(cc.c3b(65, 65, 70))
btn_ready:setScale9Enabled(true)
btn_ready:setCapInsets(cc.rect(15,11,229,105))
btn_ready:setLayoutComponentEnabled(true)
btn_ready:setName("btn_ready")
btn_ready:setTag(38)
btn_ready:setCascadeColorEnabled(true)
btn_ready:setCascadeOpacityEnabled(true)
btn_ready:setPosition(452.8520, 413.8621)
layout = ccui.LayoutComponent:bindLayoutComponent(btn_ready)
layout:setPositionPercentX(0.2359)
layout:setPositionPercentY(0.3832)
layout:setPercentWidth(0.1349)
layout:setPercentHeight(0.1176)
layout:setSize(cc.size(302.0000, 112.0000))
layout:setLeftMargin(323.3520)
layout:setRightMargin(1337.6480)
layout:setTopMargin(602.6379)
layout:setBottomMargin(350.3621)
Scene:addChild(btn_ready)

--Create btnNoCallZ
local btnNoCallZ = ccui.Button:create()
btnNoCallZ:ignoreContentAdaptWithSize(false)
btnNoCallZ:loadTextureNormal("game/niuniu_std/resource/button/Nroom_Nocall.png",0)
btnNoCallZ:setTitleFontSize(14)
btnNoCallZ:setTitleColor(cc.c3b(65, 65, 70))
btnNoCallZ:setScale9Enabled(true)
btnNoCallZ:setCapInsets(cc.rect(15,11,229,105))
btnNoCallZ:setLayoutComponentEnabled(true)
btnNoCallZ:setName("btnNoCallZ")
btnNoCallZ:setTag(80)
btnNoCallZ:setCascadeColorEnabled(true)
btnNoCallZ:setCascadeOpacityEnabled(true)
btnNoCallZ:setPosition(1439.2750, 413.8621)
layout = ccui.LayoutComponent:bindLayoutComponent(btnNoCallZ)
layout:setPositionPercentX(0.7496)
layout:setPositionPercentY(0.3832)
layout:setPercentWidth(0.1349)
layout:setPercentHeight(0.1176)
layout:setSize(cc.size(302.0000, 112.0000))
layout:setLeftMargin(1309.7750)
layout:setRightMargin(351.2253)
layout:setTopMargin(602.6379)
layout:setBottomMargin(350.3621)
Scene:addChild(btnNoCallZ)

--Create btnCallZ
local btnCallZ = ccui.Button:create()
btnCallZ:ignoreContentAdaptWithSize(false)
btnCallZ:loadTextureNormal("game/niuniu_std/resource/button/Nroom_bankerbt.png",0)
btnCallZ:setTitleFontSize(20)
btnCallZ:setTitleColor(cc.c3b(65, 65, 70))
btnCallZ:setScale9Enabled(true)
btnCallZ:setCapInsets(cc.rect(15,11,229,105))
btnCallZ:setLayoutComponentEnabled(true)
btnCallZ:setName("btnCallZ")
btnCallZ:setTag(107)
btnCallZ:setCascadeColorEnabled(true)
btnCallZ:setCascadeOpacityEnabled(true)
btnCallZ:setPosition(452.8520, 413.8621)
layout = ccui.LayoutComponent:bindLayoutComponent(btnCallZ)
layout:setPositionPercentX(0.2359)
layout:setPositionPercentY(0.3832)
layout:setPercentWidth(0.1349)
layout:setPercentHeight(0.1176)
layout:setSize(cc.size(302.0000, 112.0000))
layout:setLeftMargin(323.3520)
layout:setRightMargin(1337.6480)
layout:setTopMargin(602.6379)
layout:setBottomMargin(350.3621)
Scene:addChild(btnCallZ)

--Create btnChangeTable
local btnChangeTable = ccui.Button:create()
btnChangeTable:ignoreContentAdaptWithSize(false)
btnChangeTable:loadTextureNormal("game/niuniu_std/resource/button/Change_table.png",0)
btnChangeTable:setTitleFontSize(20)
btnChangeTable:setTitleColor(cc.c3b(65, 65, 70))
btnChangeTable:setScale9Enabled(true)
btnChangeTable:setCapInsets(cc.rect(15,11,229,105))
btnChangeTable:setLayoutComponentEnabled(true)
btnChangeTable:setName("btnChangeTable")
btnChangeTable:setTag(108)
btnChangeTable:setCascadeColorEnabled(true)
btnChangeTable:setCascadeOpacityEnabled(true)
btnChangeTable:setPosition(1439.2750, 413.8621)
layout = ccui.LayoutComponent:bindLayoutComponent(btnChangeTable)
layout:setPositionPercentX(0.7496)
layout:setPositionPercentY(0.3832)
layout:setPercentWidth(0.1349)
layout:setPercentHeight(0.1176)
layout:setSize(cc.size(302.0000, 112.0000))
layout:setLeftMargin(1309.7750)
layout:setRightMargin(351.2253)
layout:setTopMargin(602.6379)
layout:setBottomMargin(350.3621)
Scene:addChild(btnChangeTable)

--Create btnShowDown
local btnShowDown = ccui.Button:create()
btnShowDown:ignoreContentAdaptWithSize(false)
btnShowDown:loadTextureNormal("game/niuniu_std/resource/button/Nroom_showdownbt.png",0)
btnShowDown:setTitleFontSize(20)
btnShowDown:setTitleColor(cc.c3b(65, 65, 70))
btnShowDown:setScale9Enabled(true)
btnShowDown:setCapInsets(cc.rect(15,11,229,105))
btnShowDown:setLayoutComponentEnabled(true)
btnShowDown:setName("btnShowDown")
btnShowDown:setTag(126)
btnShowDown:setCascadeColorEnabled(true)
btnShowDown:setCascadeOpacityEnabled(true)
btnShowDown:setPosition(452.8520, 413.8621)
layout = ccui.LayoutComponent:bindLayoutComponent(btnShowDown)
layout:setPositionPercentX(0.2359)
layout:setPositionPercentY(0.3832)
layout:setPercentWidth(0.1349)
layout:setPercentHeight(0.1176)
layout:setSize(cc.size(302.0000, 112.0000))
layout:setLeftMargin(323.3520)
layout:setRightMargin(1337.6480)
layout:setTopMargin(602.6379)
layout:setBottomMargin(350.3621)
Scene:addChild(btnShowDown)

--Create btnPointOut
local btnPointOut = ccui.Button:create()
btnPointOut:ignoreContentAdaptWithSize(false)
btnPointOut:loadTextureNormal("game/niuniu_std/resource/button/Nroom_promptbt.png",0)
btnPointOut:setTitleFontSize(20)
btnPointOut:setTitleColor(cc.c3b(65, 65, 70))
btnPointOut:setScale9Enabled(true)
btnPointOut:setCapInsets(cc.rect(15,11,229,105))
btnPointOut:setLayoutComponentEnabled(true)
btnPointOut:setName("btnPointOut")
btnPointOut:setTag(127)
btnPointOut:setCascadeColorEnabled(true)
btnPointOut:setCascadeOpacityEnabled(true)
btnPointOut:setPosition(1439.2750, 413.8621)
layout = ccui.LayoutComponent:bindLayoutComponent(btnPointOut)
layout:setPositionPercentX(0.7496)
layout:setPositionPercentY(0.3832)
layout:setPercentWidth(0.1349)
layout:setPercentHeight(0.1176)
layout:setSize(cc.size(302.0000, 112.0000))
layout:setLeftMargin(1309.7750)
layout:setRightMargin(351.2253)
layout:setTopMargin(602.6379)
layout:setBottomMargin(350.3621)
Scene:addChild(btnPointOut)

--Create btnExchange
local btnExchange = ccui.Button:create()
btnExchange:ignoreContentAdaptWithSize(false)
btnExchange:loadTextureNormal("game/niuniu_std/resource/button/Nroom_change.png",0)
btnExchange:setTitleFontSize(14)
btnExchange:setTitleColor(cc.c3b(65, 65, 70))
btnExchange:setScale9Enabled(true)
btnExchange:setCapInsets(cc.rect(15,11,242,250))
btnExchange:setLayoutComponentEnabled(true)
btnExchange:setName("btnExchange")
btnExchange:setTag(66)
btnExchange:setCascadeColorEnabled(true)
btnExchange:setCascadeOpacityEnabled(true)
btnExchange:setPosition(1830.2570, 60.2132)
layout = ccui.LayoutComponent:bindLayoutComponent(btnExchange)
layout:setPositionPercentX(0.9220)
layout:setPositionPercentY(0.1400)
layout:setPercentWidth(0.1417)
layout:setPercentHeight(0.2519)
layout:setSize(cc.size(148.0000, 104.0000))
layout:setLeftMargin(1634.2570)
layout:setRightMargin(13.7434)
layout:setTopMargin(852.7869)
layout:setBottomMargin(15.2132)
Scene:addChild(btnExchange)

--Create btnBack
local btnBack = ccui.Button:create()
btnBack:ignoreContentAdaptWithSize(false)
btnBack:loadTextureNormal("game/niuniu_std/resource/button/return.png",0)
btnBack:setTitleFontSize(14)
btnBack:setTitleColor(cc.c3b(65, 65, 70))
btnBack:setScale9Enabled(true)
btnBack:setCapInsets(cc.rect(15,11,242,250))
btnBack:setLayoutComponentEnabled(true)
btnBack:setName("btnBack")
btnBack:setTag(89)
btnBack:setCascadeColorEnabled(true)
btnBack:setCascadeOpacityEnabled(true)
btnBack:setPosition(1830.2570, 990.2120)
layout = ccui.LayoutComponent:bindLayoutComponent(btnBack)
layout:setPositionPercentX(0.9220)
layout:setPositionPercentY(0.8595)
layout:setPercentWidth(0.1417)
layout:setPercentHeight(0.2519)
layout:setSize(cc.size(112.0000, 104.0000))
layout:setLeftMargin(1634.2570)
layout:setRightMargin(13.7434)
layout:setTopMargin(15.7880)
layout:setBottomMargin(792.2120)
Scene:addChild(btnBack)

--Create sprBankMark
local sprBankMark = cc.Sprite:create("game/niuniu_std/resource/image/Nroom_mark.png")
sprBankMark:setName("sprBankMark")
sprBankMark:setTag(94)
sprBankMark:setCascadeColorEnabled(true)
sprBankMark:setCascadeOpacityEnabled(true)
sprBankMark:setPosition(960.0001, 680.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprBankMark)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.6296)
layout:setSize(cc.size(135.0000, 147.0000))
layout:setLeftMargin(856.0001)
layout:setRightMargin(856.0000)
layout:setTopMargin(302.5000)
layout:setBottomMargin(582.5000)
Scene:addChild(sprBankMark)

--Create sprScore1
local sprScore1 = cc.Sprite:create("game/niuniu_std/resource/image/Nroom_failureibg.png")
sprScore1:setName("sprScore1")
sprScore1:setTag(90)
sprScore1:setCascadeColorEnabled(true)
sprScore1:setCascadeOpacityEnabled(true)
sprScore1:setPosition(957.8770, 805.5763)
layout = ccui.LayoutComponent:bindLayoutComponent(sprScore1)
layout:setPositionPercentX(0.4989)
layout:setPositionPercentY(0.7459)
layout:setPercentWidth(0.1984)
layout:setPercentHeight(0.0750)
layout:setSize(cc.size(381.0000, 81.0000))
layout:setLeftMargin(767.3770)
layout:setRightMargin(771.6230)
layout:setTopMargin(233.9237)
layout:setBottomMargin(765.0763)
Scene:addChild(sprScore1)

--Create fntScore1
--local fntScore1 = ccui.TextBMFont:create()
--fntScore1:setFntFile("game/niuniu_std/resource/number/winNum.fnt")
local fntScore1 = ccui.Text:create()
fntScore1:setFontName("lobby/resource/font/simhei.ttf")
fntScore1:setFontSize(30)
fntScore1:setString([[74575]])
fntScore1:setLayoutComponentEnabled(true)
fntScore1:setName("fntScore1")
fntScore1:setTag(92)
fntScore1:setCascadeColorEnabled(true)
fntScore1:setCascadeOpacityEnabled(true)
fntScore1:setPosition(150.5000, 30.5000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntScore1)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.3675)
layout:setPercentHeight(0.5802)
layout:setSize(cc.size(140.0000, 47.0000))
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(120.5000)
layout:setRightMargin(120.5000)
layout:setTopMargin(17.0000)
layout:setBottomMargin(17.0000)
sprScore1:addChild(fntScore1)

--Create sprScore2
local sprScore2 = cc.Sprite:create("game/niuniu_std/resource/image/Nroom_failureibg.png")
sprScore2:setName("sprScore2")
sprScore2:setTag(91)
sprScore2:setCascadeColorEnabled(true)
sprScore2:setCascadeOpacityEnabled(true)
sprScore2:setPosition(960.0001, 509.9553)
layout = ccui.LayoutComponent:bindLayoutComponent(sprScore2)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.4722)
layout:setPercentWidth(0.1984)
layout:setPercentHeight(0.0750)
layout:setSize(cc.size(381.0000, 81.0000))
layout:setLeftMargin(769.5001)
layout:setRightMargin(769.4999)

layout:setTopMargin(529.5447)
layout:setBottomMargin(469.4553)
Scene:addChild(sprScore2)

--Create fntScore2
--local fntScore2 = ccui.TextBMFont:create()
--fntScore2:setFntFile("game/niuniu_std/resource/number/winNum.fnt")
local fntScore2 = ccui.Text:create()
fntScore2:setFontName("lobby/resource/font/simhei.ttf")
fntScore2:setFontSize(30)
fntScore2:setString([[785785]])
fntScore2:setLayoutComponentEnabled(true)
fntScore2:setName("fntScore2")
fntScore2:setTag(93)
fntScore2:setCascadeColorEnabled(true)
fntScore2:setCascadeOpacityEnabled(true)
fntScore2:setPosition(150.5000, 30.5000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntScore2)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.1496)
layout:setPercentHeight(0.5802)
layout:setSize(cc.size(168.0000, 47.0000))
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(162.0000)
layout:setRightMargin(162.0000)
layout:setTopMargin(17.0000)
layout:setBottomMargin(17.0000)
sprScore2:addChild(fntScore2)

--Create sprBetBack1
local sprBetBack1 = cc.Sprite:create("game/niuniu_std/resource/image/Nroom_betBg.png")
sprBetBack1:setName("sprBetBack1")
sprBetBack1:setTag(96)
sprBetBack1:setCascadeColorEnabled(true)
sprBetBack1:setCascadeOpacityEnabled(true)
sprBetBack1:setPosition(957.8771, 805.5763)
layout = ccui.LayoutComponent:bindLayoutComponent(sprBetBack1)
layout:setPositionPercentX(0.4989)
layout:setPositionPercentY(0.7459)
layout:setPercentWidth(0.1073)
layout:setPercentHeight(0.0685)
layout:setSize(cc.size(206.0000, 74.0000))
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(854.8771)
layout:setRightMargin(859.1229)
layout:setTopMargin(237.4237)
layout:setBottomMargin(768.5763)
Scene:addChild(sprBetBack1)

--Create fntBet1
--local fntBet1 = ccui.TextBMFont:create()
--fntBet1:setFntFile("game/niuniu_std/resource/number/winNum.fnt")
local fntBet1 = ccui.Text:create()
fntBet1:setFontName("lobby/resource/font/simhei.ttf")
fntBet1:setFontSize(30)
fntBet1:setString([[74575]])
fntBet1:setLayoutComponentEnabled(true)
fntBet1:setName("fntBet1")
fntBet1:setTag(97)
fntBet1:setCascadeColorEnabled(true)
fntBet1:setCascadeOpacityEnabled(true)
fntBet1:setPosition(103.0000, 37.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntBet1)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.1496)
layout:setPercentHeight(0.5802)
layout:setSize(cc.size(140.0000, 47.0000))
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(162.0000)
layout:setRightMargin(162.0000)
layout:setTopMargin(17.0000)
layout:setBottomMargin(17.0000)
sprBetBack1:addChild(fntBet1)

--Create sprBetBack2
local sprBetBack2 = cc.Sprite:create("game/niuniu_std/resource/image/Nroom_betBg.png")
sprBetBack2:setName("sprBetBack2")
sprBetBack2:setTag(98)
sprBetBack2:setCascadeColorEnabled(true)
sprBetBack2:setCascadeOpacityEnabled(true)
sprBetBack2:setPosition(960.0001, 509.9553)
layout = ccui.LayoutComponent:bindLayoutComponent(sprBetBack2)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.4722)
layout:setPercentWidth(0.1073)
layout:setPercentHeight(0.0685)
layout:setSize(cc.size(206.0000, 74.0000))
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(857.0001)
layout:setRightMargin(856.9999)
layout:setTopMargin(533.0447)
layout:setBottomMargin(472.9553)
Scene:addChild(sprBetBack2)

--Create fntBet2
--local fntBet2 = ccui.TextBMFont:create()
--fntBet2:setFntFile("game/niuniu_std/resource/number/winNum.fnt")
local fntBet2 = ccui.Text:create()
fntBet2:setFontName("lobby/resource/font/simhei.ttf")
fntBet2:setFontSize(30)
fntBet2:setString([[74575]])
fntBet2:setLayoutComponentEnabled(true)
fntBet2:setName("fntBet2")
fntBet2:setTag(99)
fntBet2:setCascadeColorEnabled(true)
fntBet2:setCascadeOpacityEnabled(true)
fntBet2:setPosition(103.0000, 37.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntBet2)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.1496)
layout:setPercentHeight(0.5802)
layout:setSize(cc.size(140.0000, 47.0000))
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(162.0000)
layout:setRightMargin(162.0000)
layout:setTopMargin(17.0000)
layout:setBottomMargin(17.0000)
sprBetBack2:addChild(fntBet2)

--Create btnCash1
local btnCash1 = ccui.Button:create()
btnCash1:ignoreContentAdaptWithSize(false)
btnCash1:loadTextureNormal("game/niuniu_std/resource/button/Nroom_1multiplebt.png",0)
btnCash1:setTitleFontSize(20)
btnCash1:setTitleColor(cc.c3b(65, 65, 70))
btnCash1:setScale9Enabled(true)
btnCash1:setCapInsets(cc.rect(15,11,225,130))
btnCash1:setLayoutComponentEnabled(true)
btnCash1:setName("btnCash1")
btnCash1:setTag(82)
btnCash1:setCascadeColorEnabled(true)
btnCash1:setCascadeOpacityEnabled(true)
btnCash1:setPosition(452.0433, 413.3708)
layout = ccui.LayoutComponent:bindLayoutComponent(btnCash1)
layout:setPositionPercentX(0.2354)
layout:setPositionPercentY(0.3828)
layout:setPercentWidth(0.1328)
layout:setPercentHeight(0.1407)
layout:setSize(cc.size(220.0000, 112.0000))
layout:setLeftMargin(324.5433)
layout:setRightMargin(1340.4570)
layout:setTopMargin(590.6292)
layout:setBottomMargin(337.3708)
Scene:addChild(btnCash1)

--Create fnt_cash1
--local fnt_cash1 = ccui.TextBMFont:create()
--fnt_cash1:setFntFile("game/niuniu_std/resource/number/betNum.fnt")
--fnt_cash1:setString([[100]])
local fnt_cash1 = ccui.Text:create()
fnt_cash1:setFontName("lobby/resource/font/simhei.ttf")
fnt_cash1:setFontSize(30)
fnt_cash1:setLayoutComponentEnabled(true)
fnt_cash1:setName("fnt_cash1")
fnt_cash1:setTag(96)
fnt_cash1:setCascadeColorEnabled(true)
fnt_cash1:setCascadeOpacityEnabled(true)
fnt_cash1:setPosition(110.5000, 56.1200)
layout = ccui.LayoutComponent:bindLayoutComponent(fnt_cash1)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5600)
layout:setPercentWidth(0.4000)
layout:setPercentHeight(0.3816)
layout:setSize(cc.size(102.0000, 58.0000))
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(76.5000)
layout:setRightMargin(76.5000)
layout:setTopMargin(37.8800)
layout:setBottomMargin(56.1200)
btnCash1:addChild(fnt_cash1)

--Create btnCash2
local btnCash2 = ccui.Button:create()
btnCash2:ignoreContentAdaptWithSize(false)
btnCash2:loadTextureNormal("game/niuniu_std/resource/button/Nroom_1multiplebt.png",0)
btnCash2:setTitleFontSize(20)
btnCash2:setTitleColor(cc.c3b(65, 65, 70))
btnCash2:setScale9Enabled(true)
btnCash2:setCapInsets(cc.rect(15,11,225,130))
btnCash2:setLayoutComponentEnabled(true)
btnCash2:setName("btnCash2")
btnCash2:setTag(89)
btnCash2:setCascadeColorEnabled(true)
btnCash2:setCascadeOpacityEnabled(true)
btnCash2:setPosition(780.7213, 418.0535)
layout = ccui.LayoutComponent:bindLayoutComponent(btnCash2)
layout:setPositionPercentX(0.4066)
layout:setPositionPercentY(0.3871)
layout:setPercentWidth(0.1328)
layout:setPercentHeight(0.1407)
layout:setSize(cc.size(220.0000, 112.0000))
layout:setLeftMargin(653.2213)
layout:setRightMargin(1011.7790)
layout:setTopMargin(585.9465)
layout:setBottomMargin(342.0535)
Scene:addChild(btnCash2)

--Create fnt_cash2
--local fnt_cash2 = ccui.TextBMFont:create()
--fnt_cash2:setFntFile("game/niuniu_std/resource/number/betNum.fnt")
local fnt_cash2 = ccui.Text:create()
fnt_cash2:setFontName("lobby/resource/font/simhei.ttf")
fnt_cash2:setFontSize(30)
fnt_cash2:setString([[1111]])
fnt_cash2:setLayoutComponentEnabled(true)
fnt_cash2:setName("fnt_cash2")
fnt_cash2:setTag(97)
fnt_cash2:setCascadeColorEnabled(true)
fnt_cash2:setCascadeOpacityEnabled(true)
fnt_cash2:setPosition(110.5000, 56.1200)
layout = ccui.LayoutComponent:bindLayoutComponent(fnt_cash2)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5600)
layout:setPercentWidth(0.5333)
layout:setPercentHeight(0.3816)
layout:setSize(cc.size(136.0000, 58.0000))
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(59.5000)
layout:setRightMargin(59.5000)
layout:setTopMargin(37.8800)
layout:setBottomMargin(56.1200)
btnCash2:addChild(fnt_cash2)

--Create btnCash3
local btnCash3 = ccui.Button:create()
btnCash3:ignoreContentAdaptWithSize(false)
btnCash3:loadTextureNormal("game/niuniu_std/resource/button/Nroom_1multiplebt.png",0)
btnCash3:setTitleFontSize(20)
btnCash3:setTitleColor(cc.c3b(65, 65, 70))
btnCash3:setScale9Enabled(true)
btnCash3:setCapInsets(cc.rect(15,11,225,130))
btnCash3:setLayoutComponentEnabled(true)
btnCash3:setName("btnCash3")
btnCash3:setTag(90)
btnCash3:setCascadeColorEnabled(true)
btnCash3:setCascadeOpacityEnabled(true)
btnCash3:setPosition(1109.3980, 418.0535)
layout = ccui.LayoutComponent:bindLayoutComponent(btnCash3)
layout:setPositionPercentX(0.5778)
layout:setPositionPercentY(0.3784)
layout:setPercentWidth(0.1328)
layout:setPercentHeight(0.1407)
layout:setSize(cc.size(220.0000, 112.0000))
layout:setLeftMargin(981.8984)
layout:setRightMargin(683.1016)
layout:setTopMargin(595.3122)
layout:setBottomMargin(332.6878)
Scene:addChild(btnCash3)

--Create fnt_cash3
--local fnt_cash3 = ccui.TextBMFont:create()
--fnt_cash3:setFntFile("game/niuniu_std/resource/number/betNum.fnt")
local fnt_cash3 = ccui.Text:create()
fnt_cash3:setFontName("lobby/resource/font/simhei.ttf")
fnt_cash3:setFontSize(30)
fnt_cash3:setString([[1011]])
fnt_cash3:setLayoutComponentEnabled(true)
fnt_cash3:setName("fnt_cash3")
fnt_cash3:setTag(98)
fnt_cash3:setCascadeColorEnabled(true)
fnt_cash3:setCascadeOpacityEnabled(true)
fnt_cash3:setPosition(110.5000, 56.1200)
layout = ccui.LayoutComponent:bindLayoutComponent(fnt_cash3)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5600)
layout:setPercentWidth(0.5333)
layout:setPercentHeight(0.3816)
layout:setSize(cc.size(136.0000, 58.0000))
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(59.5000)
layout:setRightMargin(59.5000)
layout:setTopMargin(37.8800)
layout:setBottomMargin(56.1200)
btnCash3:addChild(fnt_cash3)

--Create btnCash4
local btnCash4 = ccui.Button:create()
btnCash4:ignoreContentAdaptWithSize(false)
btnCash4:loadTextureNormal("game/niuniu_std/resource/button/Nroom_1multiplebt.png",0)
btnCash4:setTitleFontSize(20)
btnCash4:setTitleColor(cc.c3b(65, 65, 70))
btnCash4:setScale9Enabled(true)
btnCash4:setCapInsets(cc.rect(15,11,225,130))
btnCash4:setLayoutComponentEnabled(true)
btnCash4:setName("btnCash4")
btnCash4:setTag(91)
btnCash4:setCascadeColorEnabled(true)
btnCash4:setCascadeOpacityEnabled(true)
btnCash4:setPosition(1438.0760, 413.3708)
layout = ccui.LayoutComponent:bindLayoutComponent(btnCash4)
layout:setPositionPercentX(0.7490)
layout:setPositionPercentY(0.3828)
layout:setPercentWidth(0.1328)
layout:setPercentHeight(0.1407)
layout:setSize(cc.size(220.0000, 112.0000))
layout:setLeftMargin(1310.5760)
layout:setRightMargin(354.4243)
layout:setTopMargin(590.6292)
layout:setBottomMargin(337.3708)
Scene:addChild(btnCash4)

--Create fnt_cash4
--local fnt_cash4 = ccui.TextBMFont:create()
--fnt_cash4:setFntFile("game/niuniu_std/resource/number/betNum.fnt")
local fnt_cash4 = ccui.Text:create()
fnt_cash4:setFontName("lobby/resource/font/simhei.ttf")
fnt_cash4:setFontSize(30)
fnt_cash4:setString([[1111w]])
fnt_cash4:setLayoutComponentEnabled(true)
fnt_cash4:setName("fnt_cash4")
fnt_cash4:setTag(99)
fnt_cash4:setCascadeColorEnabled(true)
fnt_cash4:setCascadeOpacityEnabled(true)
fnt_cash4:setPosition(110.5000, 56.1200)
layout = ccui.LayoutComponent:bindLayoutComponent(fnt_cash4)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5600)
layout:setPercentWidth(0.5333)
layout:setPercentHeight(0.3816)
layout:setSize(cc.size(170.0000, 58.0000))
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(59.5000)
layout:setRightMargin(59.5000)
layout:setTopMargin(37.8800)
layout:setBottomMargin(56.1200)
btnCash4:addChild(fnt_cash4)

--Create sprCalling
local sprCalling = cc.Sprite:create("game/niuniu_std/resource/word/Nroom_Call in.png")
sprCalling:setName("sprCalling")
sprCalling:setTag(183)
sprCalling:setCascadeColorEnabled(true)
sprCalling:setCascadeOpacityEnabled(true)
sprCalling:setPosition(959.6411, 905.9733)
layout = ccui.LayoutComponent:bindLayoutComponent(sprCalling)
layout:setPositionPercentX(0.4998)
layout:setPositionPercentY(0.8389)
layout:setSize(cc.size(256.0000, 107.0000))
layout:setLeftMargin(831.6411)
layout:setRightMargin(832.3589)
layout:setTopMargin(120.5267)
layout:setBottomMargin(852.4733)
Scene:addChild(sprCalling)

--Create sprBetting
local sprBetting = cc.Sprite:create("game/niuniu_std/resource/word/Nroom_bet.png")
sprBetting:setName("sprBetting")
sprBetting:setTag(185)
sprBetting:setCascadeColorEnabled(true)
sprBetting:setCascadeOpacityEnabled(true)
sprBetting:setPosition(959.1411, 905.9733)
layout = ccui.LayoutComponent:bindLayoutComponent(sprBetting)
layout:setPositionPercentX(0.4996)
layout:setPositionPercentY(0.8389)
layout:setSize(cc.size(255.0000, 107.0000))
layout:setLeftMargin(831.6411)
layout:setRightMargin(833.3589)
layout:setTopMargin(120.5267)
layout:setBottomMargin(852.4733)
Scene:addChild(sprBetting)

--Create sprCardsType1
local sprCardsType1 = cc.Sprite:create("game/niuniu_std/resource/word/NIU_0.png")
sprCardsType1:setName("sprCardsType1")
sprCardsType1:setTag(188)
sprCardsType1:setCascadeColorEnabled(true)
sprCardsType1:setCascadeOpacityEnabled(true)
sprCardsType1:setPosition(1109.2780, 781.8228)
layout = ccui.LayoutComponent:bindLayoutComponent(sprCardsType1)
layout:setPositionPercentX(0.7340)
layout:setPositionPercentY(0.7239)
layout:setSize(cc.size(374.0000, 157.0000))
layout:setLeftMargin(1222.2780)
layout:setRightMargin(323.7223)
layout:setTopMargin(219.6772)
layout:setBottomMargin(703.3228)
Scene:addChild(sprCardsType1)

--Create sprCardsType2
local sprCardsType2 = cc.Sprite:create("game/niuniu_std/resource/word/NIU_0.png")
sprCardsType2:setName("sprCardsType2")
sprCardsType2:setTag(189)
sprCardsType2:setCascadeColorEnabled(true)
sprCardsType2:setCascadeOpacityEnabled(true)
sprCardsType2:setPosition(1109.2780, 246.6870)
layout = ccui.LayoutComponent:bindLayoutComponent(sprCardsType2)
layout:setPositionPercentX(0.7340)
layout:setPositionPercentY(0.5062)
layout:setSize(cc.size(374.0000, 157.0000))
layout:setLeftMargin(1222.2780)
layout:setRightMargin(323.7223)
layout:setTopMargin(454.8130)
layout:setBottomMargin(468.1870)
Scene:addChild(sprCardsType2)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Scene
return result;
end

return Result

