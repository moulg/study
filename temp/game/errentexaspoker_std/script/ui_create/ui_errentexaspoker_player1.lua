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
local spPlayerBg = cc.Sprite:create("game/errentexaspoker_std/resource/image/Nroom_headbg.png")
spPlayerBg:setName("spPlayerBg")
spPlayerBg:setTag(393)
spPlayerBg:setCascadeColorEnabled(true)
spPlayerBg:setCascadeOpacityEnabled(true)
spPlayerBg:setPosition(800.0000, 109.8435)
layout = ccui.LayoutComponent:bindLayoutComponent(spPlayerBg)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(400.0000, 172.0000))
layout:setLeftMargin(685.0000)
layout:setRightMargin(-915.0000)
layout:setTopMargin(-266.8435)
layout:setBottomMargin(12.8435)
Node:addChild(spPlayerBg)

--Create sprHeadBg
local sprHeadBg =ccui.ImageView:create()
--cc.Sprite:create("game/texaspoker_std/resource/image/Nroom_headbg.png")
sprHeadBg:setName("sprHeadBg")
sprHeadBg:setTag(394)
sprHeadBg:setScale9Enabled(true)
sprHeadBg:setCapInsets({x = 0, y = 0, width = 46, height = 46})
sprHeadBg:setCascadeColorEnabled(true)
sprHeadBg:setCascadeOpacityEnabled(true)
sprHeadBg:setPosition(92.0000, 136.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprHeadBg)
layout:setPositionPercentX(0.6000)
layout:setPositionPercentY(0.6000)
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
local sprHead = cc.Sprite:create("game/errentexaspoker_std/resource/image/Nroom_headbg.png")
sprHead:setName("sprHead")
sprHead:setTag(395)
sprHead:setCascadeColorEnabled(true)
sprHead:setCascadeOpacityEnabled(true)
sprHead:setPosition(200.0000, 86.0000)
sprHead:setScaleX(0.7000)
sprHead:setScaleY(0.7000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprHead)
layout:setPositionPercentX(0.5068)
layout:setPositionPercentY(0.5062)
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
imgHeadBg:loadTexture("game/errentexaspoker_std/resource/image/mingchengkuang1.png",0)
imgHeadBg:setLayoutComponentEnabled(true)
imgHeadBg:setName("imgHeadBg")
imgHeadBg:setTag(396)
imgHeadBg:setCascadeColorEnabled(true)
imgHeadBg:setCascadeOpacityEnabled(true)
imgHeadBg:setPosition(385.4900, 77.4032)
layout = ccui.LayoutComponent:bindLayoutComponent(imgHeadBg)
layout:setPositionPercentX(1.6760)
layout:setPositionPercentY(0.3047)
layout:setPercentWidth(1.1565)
layout:setPercentHeight(0.4094)
layout:setSize(cc.size(266.0000, 104.0000))
layout:setLeftMargin(252.4900)
layout:setRightMargin(-288.4900)
layout:setTopMargin(124.5968)
layout:setBottomMargin(25.4032)
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
labName:setTag(397)
labName:setCascadeColorEnabled(true)
labName:setCascadeOpacityEnabled(true)
labName:setAnchorPoint(0.5000, 0.5000)
labName:setPosition(90.0534, 250.9569)
layout = ccui.LayoutComponent:bindLayoutComponent(labName)
layout:setPositionPercentX(1.1582)
layout:setPositionPercentY(0.3913)
layout:setPercentWidth(0.7870)
layout:setPercentHeight(0.1693)
layout:setSize(cc.size(181.0000, 43.0000))
layout:setLeftMargin(266.3888)
layout:setRightMargin(-217.3888)
layout:setTopMargin(133.1181)
layout:setBottomMargin(77.8819)
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
labOwnChips:setTag(398)
labOwnChips:setCascadeColorEnabled(true)
labOwnChips:setCascadeOpacityEnabled(true)
labOwnChips:setAnchorPoint(0.5000, 0.5000)
labOwnChips:setPosition(90.0534, 25.6138)
layout = ccui.LayoutComponent:bindLayoutComponent(labOwnChips)
layout:setPositionPercentX(1.1582)
layout:setPositionPercentY(0.2009)
layout:setPercentWidth(0.7043)
layout:setPercentHeight(0.1693)
layout:setSize(cc.size(162.0000, 43.0000))
layout:setLeftMargin(266.3888)
layout:setRightMargin(-198.3888)
layout:setTopMargin(181.4618)
layout:setBottomMargin(29.5382)
spPlayerBg:addChild(labOwnChips)

--Create sprCard0
local sprCard0 = cc.Sprite:create("game/errentexaspoker_std/resource/image/paibeimian.png")
sprCard0:setName("sprCard0")
sprCard0:setTag(399)
sprCard0:setCascadeColorEnabled(true)
sprCard0:setCascadeOpacityEnabled(true)
sprCard0:setPosition(396.6344, 207.5660)
layout = ccui.LayoutComponent:bindLayoutComponent(sprCard0)
layout:setPositionPercentX(1.7245)
layout:setPositionPercentY(0.8172)
layout:setSize(cc.size(152.0000, 144.0000))
layout:setLeftMargin(320.6344)
layout:setRightMargin(-242.6344)
layout:setTopMargin(-25.5660)
layout:setBottomMargin(135.5660)
spPlayerBg:addChild(sprCard0)

--Create sprCard1
cc.SpriteFrameCache:getInstance():addSpriteFrames("game/errentexaspoker_std/resource/effect/card_big.plist")
local sprCard1 = cc.Sprite:createWithSpriteFrameName("card_big1_55.png")
sprCard1:setName("sprCard1")
sprCard1:setTag(400)
sprCard1:setCascadeColorEnabled(true)
sprCard1:setCascadeOpacityEnabled(true)
sprCard1:setPosition(352.8885, 232.6564)
layout = ccui.LayoutComponent:bindLayoutComponent(sprCard1)
layout:setPositionPercentX(1.5343)
layout:setPositionPercentY(0.9160)
layout:setPercentWidth(0.2000)
layout:setPercentHeight(0.1811)
layout:setSize(cc.size(147.0000, 189.0000))
layout:setLeftMargin(329.8885)
layout:setRightMargin(-145.8885)
layout:setTopMargin(-1.6564)
layout:setBottomMargin(209.6564)
spPlayerBg:addChild(sprCard1)

--Create imgFrame1
local imgFrame1 = cc.Sprite:create("game/errentexaspoker_std/resource/image/paikuang.png")
imgFrame1:setName("imgFrame1")
imgFrame1:setTag(401)
imgFrame1:setCascadeColorEnabled(true)
imgFrame1:setCascadeOpacityEnabled(true)
imgFrame1:setPosition(73.0061, 94.5334)
layout = ccui.LayoutComponent:bindLayoutComponent(imgFrame1)
layout:setPositionPercentX(0.4966)
layout:setPositionPercentY(0.5002)
layout:setSize(cc.size(145.0000, 187.0000))
layout:setLeftMargin(0.5061)
layout:setRightMargin(1.4939)
layout:setTopMargin(0.9666)
layout:setBottomMargin(1.0334)
sprCard1:addChild(imgFrame1)

--Create sprCard2
cc.SpriteFrameCache:getInstance():addSpriteFrames("game/errentexaspoker_std/resource/effect/card_big.plist")
local sprCard2 = cc.Sprite:createWithSpriteFrameName("card_big1_55.png")
sprCard2:setName("sprCard2")
sprCard2:setTag(402)
sprCard2:setCascadeColorEnabled(true)
sprCard2:setCascadeOpacityEnabled(true)
sprCard2:setPosition(425.2664, 231.8150)
layout = ccui.LayoutComponent:bindLayoutComponent(sprCard2)
layout:setPositionPercentX(1.8490)
layout:setPositionPercentY(0.9127)
layout:setPercentWidth(0.2000)
layout:setPercentHeight(0.1811)
layout:setSize(cc.size(147.0000, 189.0000))
layout:setLeftMargin(402.2664)
layout:setRightMargin(-218.2664)
layout:setTopMargin(-0.8150)
layout:setBottomMargin(208.8150)
spPlayerBg:addChild(sprCard2)

--Create imgFrame2
local imgFrame2 = cc.Sprite:create("game/errentexaspoker_std/resource/image/paikuang.png")
imgFrame2:setName("imgFrame2")
imgFrame2:setTag(403)
imgFrame2:setCascadeColorEnabled(true)
imgFrame2:setCascadeOpacityEnabled(true)
imgFrame2:setPosition(73.4862, 93.4200)
layout = ccui.LayoutComponent:bindLayoutComponent(imgFrame2)
layout:setPositionPercentX(0.4999)
layout:setPositionPercentY(0.4943)
layout:setSize(cc.size(145.0000, 187.0000))
layout:setLeftMargin(0.9862)
layout:setRightMargin(1.0138)
layout:setTopMargin(2.0800)
layout:setBottomMargin(-0.0800)
sprCard2:addChild(imgFrame2)

--Create sprBetType
local sprBetType = cc.Sprite:create("game/errentexaspoker_std/resource/word/dmzhu.png")
sprBetType:setName("sprBetType")
sprBetType:setTag(404)
sprBetType:setCascadeColorEnabled(true)
sprBetType:setCascadeOpacityEnabled(true)
sprBetType:setPosition(-150.0000, 220.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprBetType)
layout:setPositionPercentX(-0.6522)
layout:setPositionPercentY(0.8661)
layout:setSize(cc.size(207.0000, 70.0000))
layout:setLeftMargin(-253.5000)
layout:setRightMargin(276.5000)
layout:setTopMargin(-1.0000)
layout:setBottomMargin(185.0000)
spPlayerBg:addChild(sprBetType)

--Create imgReady
local imgReady = cc.Sprite:create("game/errentexaspoker_std/resource/word/shou.png")
imgReady:setName("imgReady")
imgReady:setTag(405)
imgReady:setCascadeColorEnabled(true)
imgReady:setCascadeOpacityEnabled(true)
imgReady:setPosition(118, 300)
layout = ccui.LayoutComponent:bindLayoutComponent(imgReady)
layout:setPositionPercentX(0.5110)
layout:setPositionPercentY(0.9225)
layout:setSize(cc.size(98.0000, 55.0000))
layout:setLeftMargin(31.5393)
layout:setRightMargin(26.4607)
layout:setTopMargin(-18.3141)
layout:setBottomMargin(196.3142)
spPlayerBg:addChild(imgReady)

--Create sprCardType
local sprCardType = cc.Sprite:create("game/errentexaspoker_std/resource/cardType/one.png")
sprCardType:setName("sprCardType")
sprCardType:setTag(406)
sprCardType:setCascadeColorEnabled(true)
sprCardType:setCascadeOpacityEnabled(true)
sprCardType:setPosition(1071.0740, 243.3199)
layout = ccui.LayoutComponent:bindLayoutComponent(sprCardType)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(149.0000, 66.0000))
layout:setLeftMargin(996.5736)
layout:setRightMargin(-1145.5740)
layout:setTopMargin(-276.3199)
layout:setBottomMargin(210.3199)
Node:addChild(sprCardType)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result

