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

--Create ImgBg
local ImgBg = ccui.ImageView:create()
ImgBg:ignoreContentAdaptWithSize(false)
ImgBg:loadTexture("game/weishuwu_std/resource/image/jiesuan.png",0)
ImgBg:setLayoutComponentEnabled(true)
ImgBg:setName("ImgBg")
ImgBg:setTag(83)
ImgBg:setCascadeColorEnabled(true)
ImgBg:setCascadeOpacityEnabled(true)
ImgBg:setPosition(0.0000, 0.0000)
ImgBg:setScaleX(0.8000)
ImgBg:setScaleY(0.8000)
layout = ccui.LayoutComponent:bindLayoutComponent(ImgBg)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(1368.0000, 1050.0000))
layout:setLeftMargin(-684.0000)
layout:setRightMargin(-684.0000)
layout:setTopMargin(-525.0000)
layout:setBottomMargin(-525.0000)
Node:addChild(ImgBg)

--Create FtnMy1
-- local FtnMy1 = ccui.TextBMFont:create()
-- FtnMy1:setFntFile("game/weishuwu_std/resource/number/numb1.fnt")
local FtnMy1 = ccui.Text:create()
FtnMy1:setFontName("lobby/resource/font/simhei.ttf")
FtnMy1:setFontSize(30)
FtnMy1:setString([[+0123456789]])
FtnMy1:setLayoutComponentEnabled(true)
FtnMy1:setName("FtnMy1")
FtnMy1:setTag(84)
FtnMy1:setCascadeColorEnabled(true)
FtnMy1:setCascadeOpacityEnabled(true)
FtnMy1:setPosition(228.0011, 602.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(FtnMy1)
layout:setPositionPercentX(0.1667)
layout:setPositionPercentY(0.5733)
layout:setSize(cc.size(300.0000, 39.0000))
layout:setLeftMargin(78.0011)
layout:setRightMargin(989.9989)
layout:setTopMargin(428.5000)
layout:setBottomMargin(582.5000)
ImgBg:addChild(FtnMy1)

--Create FtnMy2
-- local FtnMy2 = ccui.TextBMFont:create()
-- FtnMy2:setFntFile("game/weishuwu_std/resource/number/numb1.fnt")
local FtnMy2 = ccui.Text:create()
FtnMy2:setFontName("lobby/resource/font/simhei.ttf")
FtnMy2:setFontSize(30)
FtnMy2:setString([[-0123456789]])
FtnMy2:setLayoutComponentEnabled(true)
FtnMy2:setName("FtnMy2")
FtnMy2:setTag(85)
FtnMy2:setCascadeColorEnabled(true)
FtnMy2:setCascadeOpacityEnabled(true)
FtnMy2:setPosition(1139.0000, 602.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(FtnMy2)
layout:setPositionPercentX(0.8326)
layout:setPositionPercentY(0.5733)
layout:setSize(cc.size(301.0000, 39.0000))
layout:setLeftMargin(988.5000)
layout:setRightMargin(78.5000)
layout:setTopMargin(428.5000)
layout:setBottomMargin(582.5000)
ImgBg:addChild(FtnMy2)

--Create FtnMy3
-- local FtnMy3 = ccui.TextBMFont:create()
-- FtnMy3:setFntFile("game/weishuwu_std/resource/number/numb1.fnt")
local FtnMy3 = ccui.Text:create()
FtnMy3:setFontName("lobby/resource/font/simhei.ttf")
FtnMy3:setFontSize(30)
FtnMy3:setString([[0]])
FtnMy3:setLayoutComponentEnabled(true)
FtnMy3:setName("FtnMy3")
FtnMy3:setTag(86)
FtnMy3:setCascadeColorEnabled(true)
FtnMy3:setCascadeOpacityEnabled(true)
FtnMy3:setPosition(228.0000, 410.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(FtnMy3)
layout:setPositionPercentX(0.1667)
layout:setPositionPercentY(0.3905)
layout:setSize(cc.size(27.0000, 39.0000))
layout:setLeftMargin(214.5000)
layout:setRightMargin(1126.5000)
layout:setTopMargin(620.5000)
layout:setBottomMargin(390.5000)
ImgBg:addChild(FtnMy3)

--Create FtnMy4
-- local FtnMy4 = ccui.TextBMFont:create()
-- FtnMy4:setFntFile("game/weishuwu_std/resource/number/numb1.fnt")
local FtnMy4 = ccui.Text:create()
FtnMy4:setFontName("lobby/resource/font/simhei.ttf")
FtnMy4:setFontSize(30)
FtnMy4:setString([[-0123456789]])
FtnMy4:setLayoutComponentEnabled(true)
FtnMy4:setName("FtnMy4")
FtnMy4:setTag(87)
FtnMy4:setCascadeColorEnabled(true)
FtnMy4:setCascadeOpacityEnabled(true)
FtnMy4:setPosition(663.0000, 410.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(FtnMy4)
layout:setPositionPercentX(0.4846)
layout:setPositionPercentY(0.3905)
layout:setSize(cc.size(301.0000, 39.0000))
layout:setLeftMargin(512.5000)
layout:setRightMargin(554.5000)
layout:setTopMargin(620.5000)
layout:setBottomMargin(390.5000)
ImgBg:addChild(FtnMy4)

--Create FtnMy5
-- local FtnMy5 = ccui.TextBMFont:create()
-- FtnMy5:setFntFile("game/weishuwu_std/resource/number/numb1.fnt")
local FtnMy5 = ccui.Text:create()
FtnMy5:setFontName("lobby/resource/font/simhei.ttf")
FtnMy5:setFontSize(30)
FtnMy5:setString([[0]])
FtnMy5:setLayoutComponentEnabled(true)
FtnMy5:setName("FtnMy5")
FtnMy5:setTag(88)
FtnMy5:setCascadeColorEnabled(true)
FtnMy5:setCascadeOpacityEnabled(true)
FtnMy5:setPosition(1139.0000, 410.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(FtnMy5)
layout:setPositionPercentX(0.8326)
layout:setPositionPercentY(0.3905)
layout:setSize(cc.size(27.0000, 39.0000))
layout:setLeftMargin(1125.5000)
layout:setRightMargin(215.5000)
layout:setTopMargin(620.5000)
layout:setBottomMargin(390.5000)
ImgBg:addChild(FtnMy5)

--Create FtnMy6
-- local FtnMy6 = ccui.TextBMFont:create()
-- FtnMy6:setFntFile("game/weishuwu_std/resource/number/numb1.fnt")
local FtnMy6 = ccui.Text:create()
FtnMy6:setFontName("lobby/resource/font/simhei.ttf")
FtnMy6:setFontSize(30)
FtnMy6:setString([[0]])
FtnMy6:setLayoutComponentEnabled(true)
FtnMy6:setName("FtnMy6")
FtnMy6:setTag(89)
FtnMy6:setCascadeColorEnabled(true)
FtnMy6:setCascadeOpacityEnabled(true)
FtnMy6:setPosition(228.0000, 212.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(FtnMy6)
layout:setPositionPercentX(0.1667)
layout:setPositionPercentY(0.2019)
layout:setSize(cc.size(27.0000, 39.0000))
layout:setLeftMargin(214.5000)
layout:setRightMargin(1126.5000)
layout:setTopMargin(818.5000)
layout:setBottomMargin(192.5000)
ImgBg:addChild(FtnMy6)

--Create FtnMy7
-- local FtnMy7 = ccui.TextBMFont:create()
-- FtnMy7:setFntFile("game/weishuwu_std/resource/number/numb1.fnt")
local FtnMy7 = ccui.Text:create()
FtnMy7:setFontName("lobby/resource/font/simhei.ttf")
FtnMy7:setFontSize(30)
FtnMy7:setString([[0]])
FtnMy7:setLayoutComponentEnabled(true)
FtnMy7:setName("FtnMy7")
FtnMy7:setTag(90)
FtnMy7:setCascadeColorEnabled(true)
FtnMy7:setCascadeOpacityEnabled(true)
FtnMy7:setPosition(530.0168, 212.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(FtnMy7)
layout:setPositionPercentX(0.3874)
layout:setPositionPercentY(0.2019)
layout:setSize(cc.size(27.0000, 39.0000))
layout:setLeftMargin(516.5168)
layout:setRightMargin(824.4832)
layout:setTopMargin(818.5000)
layout:setBottomMargin(192.5000)
ImgBg:addChild(FtnMy7)

--Create FtnMy8
-- local FtnMy8 = ccui.TextBMFont:create()
-- FtnMy8:setFntFile("game/weishuwu_std/resource/number/numb1.fnt")
local FtnMy8 = ccui.Text:create()
FtnMy8:setFontName("lobby/resource/font/simhei.ttf")
FtnMy8:setFontSize(30)
FtnMy8:setString([[0]])
FtnMy8:setLayoutComponentEnabled(true)
FtnMy8:setName("FtnMy8")
FtnMy8:setTag(91)
FtnMy8:setCascadeColorEnabled(true)
FtnMy8:setCascadeOpacityEnabled(true)
FtnMy8:setPosition(832.0000, 212.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(FtnMy8)
layout:setPositionPercentX(0.6082)
layout:setPositionPercentY(0.2019)
layout:setSize(cc.size(27.0000, 39.0000))
layout:setLeftMargin(818.5000)
layout:setRightMargin(522.5000)
layout:setTopMargin(818.5000)
layout:setBottomMargin(192.5000)
ImgBg:addChild(FtnMy8)

--Create FtnMy9
-- local FtnMy9 = ccui.TextBMFont:create()
-- FtnMy9:setFntFile("game/weishuwu_std/resource/number/numb1.fnt")
local FtnMy9 = ccui.Text:create()
FtnMy9:setFontName("lobby/resource/font/simhei.ttf")
FtnMy9:setFontSize(30)
FtnMy9:setString([[0]])
FtnMy9:setLayoutComponentEnabled(true)
FtnMy9:setName("FtnMy9")
FtnMy9:setTag(92)
FtnMy9:setCascadeColorEnabled(true)
FtnMy9:setCascadeOpacityEnabled(true)
FtnMy9:setPosition(1139.0000, 212.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(FtnMy9)
layout:setPositionPercentX(0.8326)
layout:setPositionPercentY(0.2019)
layout:setSize(cc.size(27.0000, 39.0000))
layout:setLeftMargin(1125.5000)
layout:setRightMargin(215.5000)
layout:setTopMargin(818.5000)
layout:setBottomMargin(192.5000)
ImgBg:addChild(FtnMy9)

--Create FntTotal
-- local FntTotal = ccui.TextBMFont:create()
-- FntTotal:setFntFile("game/weishuwu_std/resource/number/jiesuan1.fnt")
local FntTotal = ccui.Text:create()
FntTotal:setFontName("lobby/resource/font/simhei.ttf")
FntTotal:setFontSize(30)
FntTotal:setString([[+0123456789]])
FntTotal:setLayoutComponentEnabled(true)
FntTotal:setName("FntTotal")
FntTotal:setTag(93)
FntTotal:setCascadeColorEnabled(true)
FntTotal:setCascadeOpacityEnabled(true)
FntTotal:setPosition(474.3616, 68.9039)
layout = ccui.LayoutComponent:bindLayoutComponent(FntTotal)
layout:setPositionPercentX(0.3468)
layout:setPositionPercentY(0.0656)
layout:setSize(cc.size(440.0000, 56.0000))
layout:setLeftMargin(254.3616)
layout:setRightMargin(673.6384)
layout:setTopMargin(953.0961)
layout:setBottomMargin(40.9039)
ImgBg:addChild(FntTotal)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result

