--------------------------------------------------------------
-- This file was automatically generated by Cocos Studio.
-- Do not make changes to this file.
-- All changes will be lost.
--------------------------------------------------------------


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

--Create Node
local Node=cc.Node:create()
Node:setName("Node")

--Create imgPlayerBg
local imgPlayerBg = cc.Sprite:create("game/joyfive_std/resource/image/xxbj.png")
imgPlayerBg:setName("imgPlayerBg")
imgPlayerBg:setTag(290)
imgPlayerBg:setCascadeColorEnabled(true)
imgPlayerBg:setCascadeOpacityEnabled(true)
imgPlayerBg:setPosition(805.0000, 956.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgPlayerBg)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(346.0000, 172.0000))
layout:setLeftMargin(632.0000)
layout:setRightMargin(-978.0000)
layout:setTopMargin(-1042.0000)
layout:setBottomMargin(870.0000)
Node:addChild(imgPlayerBg)

--Create imgHead
local imgHead = cc.Sprite:create("game/joyfive_std/resource/head/1.png")
imgHead:setName("imgHead")
imgHead:setTag(291)
imgHead:setCascadeColorEnabled(true)
imgHead:setCascadeOpacityEnabled(true)
imgHead:setPosition(715.5944, 956.4498)
layout = ccui.LayoutComponent:bindLayoutComponent(imgHead)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(115.0000, 115.0000))
layout:setLeftMargin(658.0944)
layout:setRightMargin(-773.0944)
layout:setTopMargin(-1013.9500)
layout:setBottomMargin(898.9498)
Node:addChild(imgHead)

--Create labName
local labName = ccui.Text:create()
labName:ignoreContentAdaptWithSize(true)
labName:setTextAreaSize(cc.size(0, 0))
labName:setFontSize(16)
labName:setString([[让往事随风随风随风]])
labName:setLayoutComponentEnabled(true)
labName:setName("labName")
labName:setTag(292)
labName:setCascadeColorEnabled(true)
labName:setCascadeOpacityEnabled(true)
labName:setPosition(860.0000, 996.7775)
labName:setColor(cc.c3b(157, 149, 160))
layout = ccui.LayoutComponent:bindLayoutComponent(labName)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setPercentWidth(0.0521)
layout:setPercentHeight(0.0213)
layout:setSize(cc.size(144.0000, 16.0000))
layout:setLeftMargin(788.0000)
layout:setRightMargin(-932.0000)
layout:setTopMargin(-1004.7780)
layout:setBottomMargin(988.7775)
Node:addChild(labName)

--Create fntChips
local fntChips = ccui.TextAtlas:create([[012345678]],
													"game/joyfive_std/resource/number/number1.png",
													12,
													20,
													"0")
fntChips:setLayoutComponentEnabled(true)
fntChips:setName("fntChips")
fntChips:setTag(293)
fntChips:setCascadeColorEnabled(true)
fntChips:setCascadeOpacityEnabled(true)
fntChips:setAnchorPoint(0.0000, 0.5000)
fntChips:setPosition(824.0000, 932.1042)
layout = ccui.LayoutComponent:bindLayoutComponent(fntChips)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setPercentWidth(0.0661)
layout:setPercentHeight(0.0167)
layout:setSize(cc.size(108.0000, 20.0000))
layout:setLeftMargin(824.0000)
layout:setRightMargin(-932.0000)
layout:setTopMargin(-942.1042)
layout:setBottomMargin(922.1042)
Node:addChild(fntChips)

--Create imCardBg
local imCardBg = cc.Sprite:create("game/joyfive_std/resource/image/pbg.png")
imCardBg:setName("imCardBg")
imCardBg:setTag(294)
imCardBg:setCascadeColorEnabled(true)
imCardBg:setCascadeOpacityEnabled(true)
imCardBg:setPosition(1102.6270, 968.1686)
layout = ccui.LayoutComponent:bindLayoutComponent(imCardBg)
layout:setPositionPercentX(0.5743)
layout:setPositionPercentY(0.8965)
layout:setSize(cc.size(290.0000, 152.0000))
layout:setLeftMargin(957.6272)
layout:setRightMargin(672.3728)
layout:setTopMargin(35.8314)
layout:setBottomMargin(892.1686)
Node:addChild(imCardBg)

--Create imgCard1
local imgCard1 = ccui.ImageView:create()
imgCard1:ignoreContentAdaptWithSize(false)
cc.SpriteFrameCache:getInstance():addSpriteFrames("game/joyfive_std/resource/effect/dapuke.plist")
imgCard1:loadTexture("BM.png",1)
imgCard1:setLayoutComponentEnabled(true)
imgCard1:setName("imgCard1")
imgCard1:setTag(354)
imgCard1:setCascadeColorEnabled(true)
imgCard1:setCascadeOpacityEnabled(true)
imgCard1:setPosition(1018.2600, 964.4200)
layout = ccui.LayoutComponent:bindLayoutComponent(imgCard1)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(92.0000, 122.0000))
layout:setLeftMargin(972.2600)
layout:setRightMargin(-1064.2600)
layout:setTopMargin(-1025.4200)
layout:setBottomMargin(903.4200)
Node:addChild(imgCard1)

--Create imgCard2
cc.SpriteFrameCache:getInstance():addSpriteFrames("game/joyfive_std/resource/effect/dapuke.plist")
local imgCard2 = cc.Sprite:createWithSpriteFrameName("FK_1.png")
imgCard2:setName("imgCard2")
imgCard2:setTag(296)
imgCard2:setCascadeColorEnabled(true)
imgCard2:setCascadeOpacityEnabled(true)
imgCard2:setPosition(1063.5640, 964.4146)
layout = ccui.LayoutComponent:bindLayoutComponent(imgCard2)
layout:setPositionPercentX(0.5539)
layout:setPositionPercentY(0.8930)
layout:setSize(cc.size(92.0000, 122.0000))
layout:setLeftMargin(1017.5640)
layout:setRightMargin(810.4360)
layout:setTopMargin(54.5854)
layout:setBottomMargin(903.4146)
Node:addChild(imgCard2)

--Create imgCard3
cc.SpriteFrameCache:getInstance():addSpriteFrames("game/joyfive_std/resource/effect/dapuke.plist")
local imgCard3 = cc.Sprite:createWithSpriteFrameName("FK_3.png")
imgCard3:setName("imgCard3")
imgCard3:setTag(297)
imgCard3:setCascadeColorEnabled(true)
imgCard3:setCascadeOpacityEnabled(true)
imgCard3:setPosition(1103.2430, 964.4146)
layout = ccui.LayoutComponent:bindLayoutComponent(imgCard3)
layout:setPositionPercentX(0.5746)
layout:setPositionPercentY(0.8930)
layout:setSize(cc.size(92.0000, 122.0000))
layout:setLeftMargin(1057.2430)
layout:setRightMargin(770.7571)
layout:setTopMargin(54.5854)
layout:setBottomMargin(903.4146)
Node:addChild(imgCard3)

--Create imgCard4
cc.SpriteFrameCache:getInstance():addSpriteFrames("game/joyfive_std/resource/effect/dapuke.plist")
local imgCard4 = cc.Sprite:createWithSpriteFrameName("FK_4.png")
imgCard4:setName("imgCard4")
imgCard4:setTag(298)
imgCard4:setCascadeColorEnabled(true)
imgCard4:setCascadeOpacityEnabled(true)
imgCard4:setPosition(1142.9160, 964.4146)
layout = ccui.LayoutComponent:bindLayoutComponent(imgCard4)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(92.0000, 122.0000))
layout:setLeftMargin(1096.9160)
layout:setRightMargin(-1188.9160)
layout:setTopMargin(-1025.4150)
layout:setBottomMargin(903.4146)
Node:addChild(imgCard4)

--Create imgCard5
cc.SpriteFrameCache:getInstance():addSpriteFrames("game/joyfive_std/resource/effect/dapuke.plist")
local imgCard5 = cc.Sprite:createWithSpriteFrameName("FK_5.png")
imgCard5:setName("imgCard5")
imgCard5:setTag(299)
imgCard5:setCascadeColorEnabled(true)
imgCard5:setCascadeOpacityEnabled(true)
imgCard5:setPosition(1185.7250, 964.4146)
layout = ccui.LayoutComponent:bindLayoutComponent(imgCard5)
layout:setPositionPercentX(0.6176)
layout:setPositionPercentY(0.8930)
layout:setSize(cc.size(92.0000, 122.0000))
layout:setLeftMargin(1139.7250)
layout:setRightMargin(688.2750)
layout:setTopMargin(54.5854)
layout:setBottomMargin(903.4146)
Node:addChild(imgCard5)

--Create imgSettleAccountsWin
local imgSettleAccountsWin = cc.Sprite:create("game/joyfive_std/resource/image/jsbg.png")
imgSettleAccountsWin:setName("imgSettleAccountsWin")
imgSettleAccountsWin:setTag(300)
imgSettleAccountsWin:setCascadeColorEnabled(true)
imgSettleAccountsWin:setCascadeOpacityEnabled(true)
imgSettleAccountsWin:setPosition(805.0000, 705.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgSettleAccountsWin)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(279.0000, 90.0000))
layout:setLeftMargin(665.5000)
layout:setRightMargin(-944.5000)
layout:setTopMargin(-750.0000)
layout:setBottomMargin(660.0000)
Node:addChild(imgSettleAccountsWin)

--Create fntSettleAccountsWin
local fntSettleAccountsWin = ccui.TextBMFont:create()
fntSettleAccountsWin:setFntFile("game/joyfive_std/resource/number/joyfivechips.fnt")
fntSettleAccountsWin:setString([[+0123456789]])
fntSettleAccountsWin:setLayoutComponentEnabled(true)
fntSettleAccountsWin:setName("fntSettleAccountsWin")
fntSettleAccountsWin:setTag(301)
fntSettleAccountsWin:setCascadeColorEnabled(true)
fntSettleAccountsWin:setCascadeOpacityEnabled(true)
fntSettleAccountsWin:setPosition(805.0000, 714.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntSettleAccountsWin)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setPercentWidth(0.0224)
layout:setPercentHeight(0.0269)
layout:setSize(cc.size(224.0000, 29.0000))
layout:setLeftMargin(693.0000)
layout:setRightMargin(-917.0000)
layout:setTopMargin(-728.5000)
layout:setBottomMargin(699.5000)
Node:addChild(fntSettleAccountsWin)

--Create imgSettleAccountsLose
local imgSettleAccountsLose = cc.Sprite:create("game/joyfive_std/resource/image/jsbg1.png")
imgSettleAccountsLose:setName("imgSettleAccountsLose")
imgSettleAccountsLose:setTag(614)
imgSettleAccountsLose:setCascadeColorEnabled(true)
imgSettleAccountsLose:setCascadeOpacityEnabled(true)
imgSettleAccountsLose:setPosition(804.9998, 705.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgSettleAccountsLose)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(279.0000, 90.0000))
layout:setLeftMargin(665.4998)
layout:setRightMargin(-944.4998)
layout:setTopMargin(-750.0000)
layout:setBottomMargin(660.0000)
Node:addChild(imgSettleAccountsLose)

--Create fntSettleAccountsLose
local fntSettleAccountsLose = ccui.TextBMFont:create()
fntSettleAccountsLose:setFntFile("game/joyfive_std/resource/number/lose.fnt")
fntSettleAccountsLose:setString([[-0123456789]])
fntSettleAccountsLose:setLayoutComponentEnabled(true)
fntSettleAccountsLose:setName("fntSettleAccountsLose")
fntSettleAccountsLose:setTag(615)
fntSettleAccountsLose:setCascadeColorEnabled(true)
fntSettleAccountsLose:setCascadeOpacityEnabled(true)
fntSettleAccountsLose:setPosition(804.9999, 714.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntSettleAccountsLose)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(223.0000, 29.0000))
layout:setLeftMargin(693.4999)
layout:setRightMargin(-916.4999)
layout:setTopMargin(-728.5000)
layout:setBottomMargin(699.5000)
Node:addChild(fntSettleAccountsLose)

--Create spBetType
local spBetType = cc.Sprite:create("game/joyfive_std/resource/word/gz.png")
spBetType:setName("spBetType")
spBetType:setTag(302)
spBetType:setCascadeColorEnabled(true)
spBetType:setCascadeOpacityEnabled(true)
spBetType:setPosition(1100.0000, 865.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(spBetType)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(78.0000, 26.0000))
layout:setLeftMargin(1061.0000)
layout:setRightMargin(-1139.0000)
layout:setTopMargin(-878.0000)
layout:setBottomMargin(852.0000)
Node:addChild(spBetType)

--Create imgReady
local imgReady = cc.Sprite:create("game/joyfive_std/resource/word/zb.png")
imgReady:setName("imgReady")
imgReady:setTag(303)
imgReady:setCascadeColorEnabled(true)
imgReady:setCascadeOpacityEnabled(true)
imgReady:setPosition(804.9999, 820.6478)
layout = ccui.LayoutComponent:bindLayoutComponent(imgReady)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(162.0000, 105.0000))
layout:setLeftMargin(723.9999)
layout:setRightMargin(-885.9999)
layout:setTopMargin(-873.1478)
layout:setBottomMargin(768.1478)
Node:addChild(imgReady)

--Create imgClockBg
local imgClockBg = cc.Sprite:create("game/joyfive_std/resource/image/clock.png")
imgClockBg:setName("imgClockBg")
imgClockBg:setTag(304)
imgClockBg:setCascadeColorEnabled(true)
imgClockBg:setCascadeOpacityEnabled(true)
imgClockBg:setPosition(805.9998, 822.8339)
layout = ccui.LayoutComponent:bindLayoutComponent(imgClockBg)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(110.0000, 131.0000))
layout:setLeftMargin(750.9998)
layout:setRightMargin(-860.9998)
layout:setTopMargin(-888.3339)
layout:setBottomMargin(757.3339)
Node:addChild(imgClockBg)

--Create fntClock
local fntClock = ccui.TextAtlas:create([[60]],
													"game/joyfive_std/resource/number/clocksz.png",
													25,
													40,
													"0")
fntClock:setLayoutComponentEnabled(true)
fntClock:setName("fntClock")
fntClock:setTag(305)
fntClock:setCascadeColorEnabled(true)
fntClock:setCascadeOpacityEnabled(true)
fntClock:setPosition(804.9998, 825.4165)
layout = ccui.LayoutComponent:bindLayoutComponent(fntClock)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setPercentWidth(0.0875)
layout:setPercentHeight(0.0167)
layout:setSize(cc.size(50.0000, 40.0000))
layout:setLeftMargin(779.9998)
layout:setRightMargin(-829.9998)
layout:setTopMargin(-845.4165)
layout:setBottomMargin(805.4165)
Node:addChild(fntClock)

--Create ndEffect
local ndEffect=cc.Node:create()
ndEffect:setName("ndEffect")
ndEffect:setTag(306)
ndEffect:setCascadeColorEnabled(true)
ndEffect:setCascadeOpacityEnabled(true)
ndEffect:setPosition(1312.8700, 962.2430)
layout = ccui.LayoutComponent:bindLayoutComponent(ndEffect)
layout:setPositionPercentX(0.6838)
layout:setPositionPercentY(0.8910)
layout:setLeftMargin(1312.8700)
layout:setRightMargin(607.1296)
layout:setTopMargin(117.7570)
layout:setBottomMargin(962.2430)
Node:addChild(ndEffect)

--Create checkCardCon
local checkCardCon=cc.Node:create()
checkCardCon:setName("checkCardCon")
checkCardCon:setTag(624)
checkCardCon:setCascadeColorEnabled(true)
checkCardCon:setCascadeOpacityEnabled(true)
checkCardCon:setPosition(823.9997, 1051.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(checkCardCon)
layout:setPositionPercentX(0.4292)
layout:setPositionPercentY(0.9731)
layout:setLeftMargin(823.9997)
layout:setRightMargin(1096.0000)
layout:setTopMargin(29.0000)
layout:setBottomMargin(1051.0000)
Node:addChild(checkCardCon)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result
