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

--Create sprHeadBack
local sprHeadBack = cc.Sprite:create("game/foursniuniu_std/resource/image/Nroom_headbg_D.png")
sprHeadBack:setName("sprHeadBack")
sprHeadBack:setTag(176)
sprHeadBack:setCascadeColorEnabled(true)
sprHeadBack:setCascadeOpacityEnabled(true)
sprHeadBack:setPosition(130.3262, 540.5092)
layout = ccui.LayoutComponent:bindLayoutComponent(sprHeadBack)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(178.0000, 285.0000))
layout:setLeftMargin(50.3262)
layout:setRightMargin(-280.3262)
layout:setTopMargin(-684.5092)
layout:setBottomMargin(430.5092)
Node:addChild(sprHeadBack)

--Create sprHead
local sprHead = cc.Sprite:create("game/foursniuniu_std/resource/image/Nroom_headbg_D.png")
sprHead:setName("sprHead")
sprHead:setTag(177)
sprHead:setCascadeColorEnabled(true)
sprHead:setCascadeOpacityEnabled(true)
sprHead:setPosition(80.0000, 140.0000)
sprHead:setScaleX(0.6000)
sprHead:setScaleY(0.6000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprHead)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setSize(cc.size(230.0000, 254.0000))
layout:setLeftMargin(0.0000)
layout:setRightMargin(0.0000)
layout:setTopMargin(0.0000)
layout:setBottomMargin(0.0000)
sprHeadBack:addChild(sprHead)

--Create labName
local labName = ccui.Text:create()
labName:ignoreContentAdaptWithSize(true)
labName:setTextAreaSize(cc.size(0, 0))
labName:setFontName("simhei.ttf")
labName:setFontSize(24)
labName:setString([[Text Label]])
labName:setLayoutComponentEnabled(true)
labName:setName("labName")
labName:setTag(178)
labName:setCascadeColorEnabled(true)
labName:setCascadeOpacityEnabled(true)
labName:setPosition(90.7695, 250.5070)
layout = ccui.LayoutComponent:bindLayoutComponent(labName)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(180.0000, 41.0000))
layout:setLeftMargin(76.7695)
layout:setRightMargin(-256.7695)
layout:setTopMargin(-430.0070)
layout:setBottomMargin(389.0070)
sprHeadBack:addChild(labName)

--Create labChips
local labChips = ccui.Text:create()
labChips:ignoreContentAdaptWithSize(true)
labChips:setTextAreaSize(cc.size(0, 0))
labChips:setFontName("simhei.ttf")
labChips:setFontSize(24)
labChips:setString([[9999999999]])
labChips:setLayoutComponentEnabled(true)
labChips:setName("labChips")
labChips:setTag(179)
labChips:setCascadeColorEnabled(true)
labChips:setCascadeOpacityEnabled(true)
labChips:setPosition(90.7695, 40.5041)
layout = ccui.LayoutComponent:bindLayoutComponent(labChips)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(162.0000, 41.0000))
layout:setLeftMargin(76.7695)
layout:setRightMargin(-256.7695)
layout:setTopMargin(-385.0041)
layout:setBottomMargin(344.0041)
sprHeadBack:addChild(labChips)

--Create nodeCard
local nodeCard=cc.Node:create()
nodeCard:setName("nodeCard")
nodeCard:setTag(180)
nodeCard:setCascadeColorEnabled(true)
nodeCard:setCascadeOpacityEnabled(true)
nodeCard:setPosition(480.0000, 520.0000)
nodeCard:setScaleY(1.1000)
layout = ccui.LayoutComponent:bindLayoutComponent(nodeCard)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setLeftMargin(480.0000)
layout:setRightMargin(-480.0000)
layout:setTopMargin(-520.0000)
layout:setBottomMargin(520.0000)
Node:addChild(nodeCard)

--Create sprReady
local sprReady = cc.Sprite:create("game/foursniuniu_std/resource/word/reday.png")
sprReady:setName("sprReady")
sprReady:setTag(181)
sprReady:setCascadeColorEnabled(true)
sprReady:setCascadeOpacityEnabled(true)
sprReady:setPosition(446.7617, 480.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprReady)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(345.0000, 93.0000))
layout:setLeftMargin(274.2617)
layout:setRightMargin(-619.2617)
layout:setTopMargin(-526.5000)
layout:setBottomMargin(433.5000)
Node:addChild(sprReady)

--Create sprScore
local sprScore = cc.Sprite:create("game/foursniuniu_std/resource/image/Nroom_failureibg.png")
sprScore:setName("sprScore")
sprScore:setTag(293)
sprScore:setCascadeColorEnabled(true)
sprScore:setCascadeOpacityEnabled(true)
sprScore:setPosition(689.9999, 559.9998)
layout = ccui.LayoutComponent:bindLayoutComponent(sprScore)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(381.0000, 81.0000))
layout:setLeftMargin(499.4999)
layout:setRightMargin(-880.4999)
layout:setTopMargin(-600.4998)
layout:setBottomMargin(519.4998)
Node:addChild(sprScore)

--Create fntScore
--local fntScore = ccui.TextBMFont:create()
--fntScore:setFntFile("game/foursniuniu_std/resource/number/winNum.fnt")
local fntScore = ccui.Text:create()
fntScore:setFontName("lobby/resource/font/simhei.ttf")
fntScore:setFontSize(30)
fntScore:setString([[74575]])
fntScore:setLayoutComponentEnabled(true)
fntScore:setName("fntScore")
fntScore:setTag(294)
fntScore:setCascadeColorEnabled(true)
fntScore:setCascadeOpacityEnabled(true)
fntScore:setPosition(150.5000, 30.5000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntScore)
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
sprScore:addChild(fntScore)

--Create sprNumBack
local sprNumBack = cc.Sprite:create("game/foursniuniu_std/resource/image/Nroom_betBg.png")
sprNumBack:setName("sprNumBack")
sprNumBack:setTag(87)
sprNumBack:setCascadeColorEnabled(true)
sprNumBack:setCascadeOpacityEnabled(true)
sprNumBack:setPosition(690.0002, 559.9987)
layout = ccui.LayoutComponent:bindLayoutComponent(sprNumBack)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(206.0000, 74.0000))
layout:setLeftMargin(587.0002)
layout:setRightMargin(-793.0002)
layout:setTopMargin(-596.9987)
layout:setBottomMargin(522.9987)
Node:addChild(sprNumBack)

--Create fntBetChips
--local fntBetChips = ccui.TextBMFont:create()
--fntBetChips:setFntFile("game/foursniuniu_std/resource/number/winNum.fnt")
local fntBetChips = ccui.Text:create()
fntBetChips:setFontName("lobby/resource/font/simhei.ttf")
fntBetChips:setFontSize(30)
fntBetChips:setString([[1233213]])
fntBetChips:setLayoutComponentEnabled(true)
fntBetChips:setName("fntBetChips")
fntBetChips:setTag(88)
fntBetChips:setCascadeColorEnabled(true)
fntBetChips:setCascadeOpacityEnabled(true)
fntBetChips:setPosition(103.2593, 37.7775)
layout = ccui.LayoutComponent:bindLayoutComponent(fntBetChips)
layout:setPositionPercentX(0.5013)
layout:setPositionPercentY(0.5105)
layout:setPercentWidth(0.2767)
layout:setPercentHeight(0.6351)
layout:setSize(cc.size(196.0000, 47.0000))
layout:setLeftMargin(74.7593)
layout:setRightMargin(74.2407)
layout:setTopMargin(12.7225)
layout:setBottomMargin(14.2775)
sprNumBack:addChild(fntBetChips)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result
