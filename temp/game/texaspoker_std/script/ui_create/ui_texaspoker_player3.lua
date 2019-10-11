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

--Create Node
local Node=cc.Node:create()
Node:setName("Node")

--Create spPlayerBg
local spPlayerBg = cc.Sprite:create("game/texaspoker_std/resource/image/Nroom_headbg.png")
spPlayerBg:setName("spPlayerBg")
spPlayerBg:setTag(283)
spPlayerBg:setCascadeColorEnabled(true)
spPlayerBg:setCascadeOpacityEnabled(true)
spPlayerBg:setPosition(1800.0000, 634.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(spPlayerBg)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(182.0000, 275.0000))
layout:setLeftMargin(1685.0000)
layout:setRightMargin(-1915.0000)
layout:setTopMargin(-761.0000)
layout:setBottomMargin(507.0000)
Node:addChild(spPlayerBg)

--Create sprHeadBg
local sprHeadBg =ccui.ImageView:create()
--cc.Sprite:create("game/texaspoker_std/resource/image/Nroom_headbg.png")
sprHeadBg:setName("sprHeadBg")
sprHeadBg:setTag(245)
sprHeadBg:setScale9Enabled(true)
sprHeadBg:setCapInsets({x = 0, y = 0, width = 46, height = 46})
sprHeadBg:setCascadeColorEnabled(true)
sprHeadBg:setCascadeOpacityEnabled(true)
sprHeadBg:setPosition(92.0000, 136.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprHeadBg)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(1.0000)
layout:setSize(cc.size(400.0000, 172.0000))
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(0.0000)
layout:setRightMargin(0.0000)
layout:setTopMargin(0.0000)
layout:setBottomMargin(0.0000)
spPlayerBg:addChild(sprHeadBg)

--Create sprHead
local sprHead = cc.Sprite:create("game/texaspoker_std/resource/image/Nroom_headbg.png")
sprHead:setName("sprHead")
sprHead:setTag(246)
sprHead:setCascadeColorEnabled(true)
sprHead:setCascadeOpacityEnabled(true)
sprHead:setPosition(200.0000, 86.0000)
sprHead:setScaleX(0.7000)
sprHead:setScaleY(0.7000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprHead)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setSize(cc.size(230.0000, 254.0000))
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(0.0000)
layout:setRightMargin(0.0000)
layout:setTopMargin(0.0000)
layout:setBottomMargin(0.0000)
sprHeadBg:addChild(sprHead)

--Create imgHeadBg
local imgHeadBg = ccui.ImageView:create()
imgHeadBg:ignoreContentAdaptWithSize(false)
imgHeadBg:loadTexture("game/texaspoker_std/resource/image/mingchengkuang1.png",0)
imgHeadBg:setLayoutComponentEnabled(true)
imgHeadBg:setName("imgHeadBg")
imgHeadBg:setTag(286)
imgHeadBg:setCascadeColorEnabled(true)
imgHeadBg:setCascadeOpacityEnabled(true)
imgHeadBg:setPosition(120.4990, -37.0019)
layout = ccui.LayoutComponent:bindLayoutComponent(imgHeadBg)
layout:setPositionPercentX(0.5239)
layout:setPositionPercentY(-0.1457)
layout:setSize(cc.size(224.0000, 104.0000))
layout:setLeftMargin(8.4990)
layout:setRightMargin(-2.4990)
layout:setTopMargin(239.0019)
layout:setBottomMargin(-89.0019)
spPlayerBg:addChild(imgHeadBg)

--Create labName
local labName = ccui.Text:create()
labName:ignoreContentAdaptWithSize(true)
labName:setTextAreaSize(cc.size(0, 0))
labName:setFontName("simhei.ttf")
labName:setFontSize(24)
labName:setString([[yang123456]])
labName:enableOutline(cc.c4b(255, 255, 255, 255), 1)
labName:setLayoutComponentEnabled(true)
labName:setName("labName")
labName:setTag(287)
labName:setCascadeColorEnabled(true)
labName:setCascadeOpacityEnabled(true)
labName:setAnchorPoint(0.5000, 0.5000)
labName:setPosition(90.0534, 250.9569)
layout = ccui.LayoutComponent:bindLayoutComponent(labName)
layout:setPositionPercentX(0.1409)
layout:setPositionPercentY(-0.0595)
layout:setSize(cc.size(181.0000, 43.0000))
layout:setLeftMargin(32.4023)
layout:setRightMargin(16.5977)
layout:setTopMargin(247.6152)
layout:setBottomMargin(-36.6152)
spPlayerBg:addChild(labName)

--Create labOwnChips
local labOwnChips = ccui.Text:create()
labOwnChips:ignoreContentAdaptWithSize(true)
labOwnChips:setTextAreaSize(cc.size(0, 0))
labOwnChips:setFontName("simhei.ttf")
labOwnChips:setFontSize(24)
labOwnChips:setString([[123456789]])
labOwnChips:setTextVerticalAlignment(1)
labOwnChips:enableOutline(cc.c4b(255, 255, 255, 255), 1)
labOwnChips:setLayoutComponentEnabled(true)
labOwnChips:setName("labOwnChips")
labOwnChips:setTag(288)
labOwnChips:setCascadeColorEnabled(true)
labOwnChips:setCascadeOpacityEnabled(true)
labOwnChips:setAnchorPoint(0.5000, 0.5000)
labOwnChips:setPosition(90.0534, 25.6138)
layout = ccui.LayoutComponent:bindLayoutComponent(labOwnChips)
layout:setPositionPercentX(0.1409)
layout:setPositionPercentY(-0.2498)
layout:setSize(cc.size(162.0000, 43.0000))
layout:setLeftMargin(32.4023)
layout:setRightMargin(35.5977)
layout:setTopMargin(295.9584)
layout:setBottomMargin(-84.9585)
spPlayerBg:addChild(labOwnChips)

--Create sprCard0
local sprCard0 = cc.Sprite:create("game/texaspoker_std/resource/image/paibeimian.png")
sprCard0:setName("sprCard0")
sprCard0:setTag(291)
sprCard0:setCascadeColorEnabled(true)
sprCard0:setCascadeOpacityEnabled(true)
sprCard0:setPosition(-1.2879, 198.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprCard0)
layout:setPositionPercentX(-0.0056)
layout:setPositionPercentY(0.7795)
layout:setSize(cc.size(152.0000, 144.0000))
layout:setLeftMargin(-77.2879)
layout:setRightMargin(155.2879)
layout:setTopMargin(-16.0000)
layout:setBottomMargin(126.0000)
spPlayerBg:addChild(sprCard0)

--Create sprCard1
cc.SpriteFrameCache:getInstance():addSpriteFrames("game/texaspoker_std/resource/effect/card_big.plist")
local sprCard1 = cc.Sprite:createWithSpriteFrameName("card_big1_55.png")
sprCard1:setName("sprCard1")
sprCard1:setTag(292)
sprCard1:setCascadeColorEnabled(true)
sprCard1:setCascadeOpacityEnabled(true)
sprCard1:setPosition(-52.2717, 166.2681)
layout = ccui.LayoutComponent:bindLayoutComponent(sprCard1)
layout:setPositionPercentX(-0.2273)
layout:setPositionPercentY(0.6546)
layout:setPercentWidth(0.6304)
layout:setPercentHeight(0.7362)
layout:setSize(cc.size(145.0000, 187.0000))
layout:setLeftMargin(-124.7717)
layout:setRightMargin(209.7717)
layout:setTopMargin(-5.7681)
layout:setBottomMargin(72.7681)
spPlayerBg:addChild(sprCard1)

--Create imgFrame1
local imgFrame1 = cc.Sprite:create("game/texaspoker_std/resource/image/paikuang.png")
imgFrame1:setName("imgFrame1")
imgFrame1:setTag(293)
imgFrame1:setCascadeColorEnabled(true)
imgFrame1:setCascadeOpacityEnabled(true)
imgFrame1:setPosition(73.0061, 94.5334)
layout = ccui.LayoutComponent:bindLayoutComponent(imgFrame1)
layout:setPositionPercentX(0.5035)
layout:setPositionPercentY(0.5055)
layout:setSize(cc.size(145.0000, 187.0000))
layout:setLeftMargin(0.5061)
layout:setRightMargin(-0.5061)
layout:setTopMargin(-1.0334)
layout:setBottomMargin(1.0334)
sprCard1:addChild(imgFrame1)

--Create sprCard2
cc.SpriteFrameCache:getInstance():addSpriteFrames("game/texaspoker_std/resource/effect/card_big.plist")
local sprCard2 = cc.Sprite:createWithSpriteFrameName("card_big1_55.png")
sprCard2:setName("sprCard2")
sprCard2:setTag(294)
sprCard2:setCascadeColorEnabled(true)
sprCard2:setCascadeOpacityEnabled(true)
sprCard2:setPosition(20.1064, 166.8583)
layout = ccui.LayoutComponent:bindLayoutComponent(sprCard2)
layout:setPositionPercentX(0.0874)
layout:setPositionPercentY(0.6569)
layout:setPercentWidth(0.6304)
layout:setPercentHeight(0.7362)
layout:setSize(cc.size(145.0000, 187.0000))
layout:setLeftMargin(-52.3936)
layout:setRightMargin(137.3936)
layout:setTopMargin(-6.3583)
layout:setBottomMargin(73.3583)
spPlayerBg:addChild(sprCard2)

--Create imgFrame2
local imgFrame2 = cc.Sprite:create("game/texaspoker_std/resource/image/paikuang.png")
imgFrame2:setName("imgFrame2")
imgFrame2:setTag(295)
imgFrame2:setCascadeColorEnabled(true)
imgFrame2:setCascadeOpacityEnabled(true)
imgFrame2:setPosition(73.4862, 93.4200)
layout = ccui.LayoutComponent:bindLayoutComponent(imgFrame2)
layout:setPositionPercentX(0.5068)
layout:setPositionPercentY(0.4996)
layout:setSize(cc.size(145.0000, 187.0000))
layout:setLeftMargin(0.9862)
layout:setRightMargin(-0.9862)
layout:setTopMargin(0.0800)
layout:setBottomMargin(-0.0800)
sprCard2:addChild(imgFrame2)

--Create sprBetType
local sprBetType = cc.Sprite:create("game/texaspoker_std/resource/word/dmzhu.png")
sprBetType:setName("sprBetType")
sprBetType:setTag(296)
sprBetType:setCascadeColorEnabled(true)
sprBetType:setCascadeOpacityEnabled(true)
sprBetType:setPosition(-88.1206, 56.9998)
layout = ccui.LayoutComponent:bindLayoutComponent(sprBetType)
layout:setPositionPercentX(-0.3831)
layout:setPositionPercentY(0.2244)
layout:setSize(cc.size(207.0000, 70.0000))
layout:setLeftMargin(-191.6206)
layout:setRightMargin(214.6206)
layout:setTopMargin(162.0002)
layout:setBottomMargin(21.9998)
spPlayerBg:addChild(sprBetType)

--Create imgReady
local imgReady = cc.Sprite:create("game/texaspoker_std/resource/image/shou.png")
imgReady:setName("imgReady")
imgReady:setTag(289)
imgReady:setCascadeColorEnabled(true)
imgReady:setCascadeOpacityEnabled(true)
imgReady:setPosition(-67.0011, 190.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgReady)
layout:setPositionPercentX(-0.2913)
layout:setPositionPercentY(0.7480)
layout:setSize(cc.size(172.0000, 76.0000))
layout:setLeftMargin(-153.0011)
layout:setRightMargin(211.0011)
layout:setTopMargin(26.0000)
layout:setBottomMargin(152.0000)
spPlayerBg:addChild(imgReady)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result

