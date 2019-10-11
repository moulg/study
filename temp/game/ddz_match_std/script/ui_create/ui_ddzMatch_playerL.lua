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

--Create sprHead
local sprHead = cc.Sprite:create("common/head_pic/115/1.png")
sprHead:setName("sprHead")
sprHead:setTag(68)
sprHead:setCascadeColorEnabled(true)
sprHead:setCascadeOpacityEnabled(true)
sprHead:setPosition(0.0000, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprHead)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(115.0000, 115.0000))
layout:setLeftMargin(-57.5000)
layout:setRightMargin(-57.5000)
layout:setTopMargin(-57.5000)
layout:setBottomMargin(-57.5000)
Node:addChild(sprHead)

--Create sprMark
local sprMark = cc.Sprite:create("game/ddz_match_std/resource/image/nongmingtoubiao.png")
sprMark:setName("sprMark")
sprMark:setTag(69)
sprMark:setCascadeColorEnabled(true)
sprMark:setCascadeOpacityEnabled(true)
sprMark:setPosition(-28.8859, 27.8552)
layout = ccui.LayoutComponent:bindLayoutComponent(sprMark)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(60.0000, 60.0000))
layout:setLeftMargin(-58.8859)
layout:setRightMargin(-1.1141)
layout:setTopMargin(-57.8552)
layout:setBottomMargin(-2.1448)
Node:addChild(sprMark)

--Create imgClock
local imgClock = cc.Sprite:create("game/ddz_match_std/resource/image/naozhong.png")
imgClock:setName("imgClock")
imgClock:setTag(72)
imgClock:setCascadeColorEnabled(true)
imgClock:setCascadeOpacityEnabled(true)
imgClock:setPosition(-0.7679, 115.3964)
layout = ccui.LayoutComponent:bindLayoutComponent(imgClock)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(60.0000, 71.0000))
layout:setLeftMargin(-30.7679)
layout:setRightMargin(-29.2321)
layout:setTopMargin(-150.8964)
layout:setBottomMargin(79.8964)
Node:addChild(imgClock)

--Create fntTime
local fntTime = ccui.TextBMFont:create()
fntTime:setFntFile("game/ddz_match_std/resource/number/time.fnt")
fntTime:setString([[12]])
fntTime:setLayoutComponentEnabled(true)
fntTime:setName("fntTime")
fntTime:setTag(73)
fntTime:setCascadeColorEnabled(true)
fntTime:setCascadeOpacityEnabled(true)
fntTime:setPosition(30.6152, 34.7357)
layout = ccui.LayoutComponent:bindLayoutComponent(fntTime)
layout:setPositionPercentX(0.5103)
layout:setPositionPercentY(0.4892)
layout:setSize(cc.size(28.0000, 30.0000))
layout:setLeftMargin(16.6152)
layout:setRightMargin(15.3848)
layout:setTopMargin(21.2643)
layout:setBottomMargin(19.7357)
imgClock:addChild(fntTime)

--Create fntScore
local fntScore = ccui.TextBMFont:create()
fntScore:setFntFile("game/ddz_match_std/resource/number/scoreF.fnt")
fntScore:setString([[100]])
fntScore:setLayoutComponentEnabled(true)
fntScore:setName("fntScore")
fntScore:setTag(74)
fntScore:setCascadeColorEnabled(true)
fntScore:setCascadeOpacityEnabled(true)
fntScore:setPosition(-0.2693, -88.8963)
layout = ccui.LayoutComponent:bindLayoutComponent(fntScore)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(66.0000, 44.0000))
layout:setLeftMargin(-33.2693)
layout:setRightMargin(-32.7307)
layout:setTopMargin(66.8963)
layout:setBottomMargin(-110.8963)
Node:addChild(fntScore)

--Create sprSurplusCard
local sprSurplusCard = cc.Sprite:create("game/ddz_match_std/resource/word/shengyu.png")
sprSurplusCard:setName("sprSurplusCard")
sprSurplusCard:setTag(75)
sprSurplusCard:setCascadeColorEnabled(true)
sprSurplusCard:setCascadeOpacityEnabled(true)
sprSurplusCard:setPosition(120.0000, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprSurplusCard)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(95.0000, 33.0000))
layout:setLeftMargin(72.5000)
layout:setRightMargin(-167.5000)
layout:setTopMargin(-16.5000)
layout:setBottomMargin(-16.5000)
Node:addChild(sprSurplusCard)

--Create fntCardNum
local fntCardNum = ccui.TextBMFont:create()
fntCardNum:setFntFile("game/ddz_match_std/resource/number/surplusPuke.fnt")
fntCardNum:setString([[22]])
fntCardNum:setLayoutComponentEnabled(true)
fntCardNum:setName("fntCardNum")
fntCardNum:setTag(76)
fntCardNum:setCascadeColorEnabled(true)
fntCardNum:setCascadeOpacityEnabled(true)
fntCardNum:setPosition(48.6090, 18.4229)
layout = ccui.LayoutComponent:bindLayoutComponent(fntCardNum)
layout:setPositionPercentX(0.5117)
layout:setPositionPercentY(0.5583)
layout:setSize(cc.size(36.0000, 30.0000))
layout:setLeftMargin(30.6090)
layout:setRightMargin(28.3910)
layout:setTopMargin(-0.4229)
layout:setBottomMargin(3.4229)
sprSurplusCard:addChild(fntCardNum)

--Create imgDoubled
local imgDoubled = cc.Sprite:create("game/ddz_match_std/resource/word/jiabei.png")
imgDoubled:setName("imgDoubled")
imgDoubled:setTag(73)
imgDoubled:setCascadeColorEnabled(true)
imgDoubled:setCascadeOpacityEnabled(true)
imgDoubled:setPosition(116.0000, -54.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgDoubled)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(123.0000, 45.0000))
layout:setLeftMargin(54.5000)
layout:setRightMargin(-177.5000)
layout:setTopMargin(31.5000)
layout:setBottomMargin(-76.5000)
Node:addChild(imgDoubled)

--Create talkBg
local talkBg = cc.Sprite:create("game/ddz_match_std/resource/image/talkBgL.png")
talkBg:setName("talkBg")
talkBg:setTag(83)
talkBg:setCascadeColorEnabled(true)
talkBg:setCascadeOpacityEnabled(true)
talkBg:setPosition(214.0000, 100.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(talkBg)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(266.0000, 147.0000))
layout:setLeftMargin(81.0000)
layout:setRightMargin(-347.0000)
layout:setTopMargin(-173.5000)
layout:setBottomMargin(26.5000)
Node:addChild(talkBg)

--Create sprTalkWord
local sprTalkWord = cc.Sprite:create("game/ddz_match_std/resource/word/chaofeng1.png")
sprTalkWord:setName("sprTalkWord")
sprTalkWord:setTag(84)
sprTalkWord:setCascadeColorEnabled(true)
sprTalkWord:setCascadeOpacityEnabled(true)
sprTalkWord:setPosition(134.9708, 89.0817)
layout = ccui.LayoutComponent:bindLayoutComponent(sprTalkWord)
layout:setPositionPercentX(0.5074)
layout:setPositionPercentY(0.6060)
layout:setSize(cc.size(219.0000, 57.0000))
layout:setLeftMargin(25.4708)
layout:setRightMargin(21.5292)
layout:setTopMargin(29.4183)
layout:setBottomMargin(60.5817)
talkBg:addChild(sprTalkWord)

--Create sprOutLine
local sprOutLine = cc.Sprite:create("game/ddz_match_std/resource/word/ydx.png")
sprOutLine:setName("sprOutLine")
sprOutLine:setTag(42)
sprOutLine:setCascadeColorEnabled(true)
sprOutLine:setCascadeOpacityEnabled(true)
sprOutLine:setPosition(0.0000, -143.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprOutLine)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(186.0000, 45.0000))
layout:setLeftMargin(-93.0000)
layout:setRightMargin(-93.0000)
layout:setTopMargin(120.5000)
layout:setBottomMargin(-165.5000)
Node:addChild(sprOutLine)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result
