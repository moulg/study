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

--Create imgBg
local imgBg = cc.Sprite:create("game/bairenniuniu_std/resource/image/JieSuanBg.png")
imgBg:setName("imgBg")
imgBg:setTag(89)
imgBg:setCascadeColorEnabled(true)
imgBg:setCascadeOpacityEnabled(true)
imgBg:setPosition(960.0000, 540.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgBg)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.9865)
layout:setPercentHeight(0.4037)
layout:setSize({width = 1894.0000, height = 436.0000})
layout:setLeftMargin(13.0000)
layout:setRightMargin(13.0000)
layout:setTopMargin(322.0000)
layout:setBottomMargin(322.0000)
imgBg:setBlendFunc({src = 1, dst = 771})
Node:addChild(imgBg)

--Create jiesuanZ
local jiesuanZ = cc.Sprite:create("game/bairenniuniu_std/resource/image/zj.png")
jiesuanZ:setName("jiesuanZ")
jiesuanZ:setTag(92)
jiesuanZ:setCascadeColorEnabled(true)
jiesuanZ:setCascadeOpacityEnabled(true)
jiesuanZ:setPosition(600.0000, 70.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(jiesuanZ)
layout:setPositionPercentX(0.3168)
layout:setPositionPercentY(0.1606)
layout:setPercentWidth(0.0364)
layout:setPercentHeight(0.0665)
layout:setSize({width = 69.0000, height = 29.0000})
layout:setLeftMargin(565.5000)
layout:setRightMargin(1259.5000)
layout:setTopMargin(351.5000)
layout:setBottomMargin(55.5000)
jiesuanZ:setBlendFunc({src = 1, dst = 771})
imgBg:addChild(jiesuanZ)

--Create jiesuanW
local jiesuanW = cc.Sprite:create("game/bairenniuniu_std/resource/image/w.png")
jiesuanW:setName("jiesuanW")
jiesuanW:setTag(93)
jiesuanW:setCascadeColorEnabled(true)
jiesuanW:setCascadeOpacityEnabled(true)
jiesuanW:setPosition(1000.0000, 70.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(jiesuanW)
layout:setPositionPercentX(0.5280)
layout:setPositionPercentY(0.1606)
layout:setPercentWidth(0.0195)
layout:setPercentHeight(0.0665)
layout:setSize({width = 37.0000, height = 29.0000})
layout:setLeftMargin(981.5000)
layout:setRightMargin(875.5000)
layout:setTopMargin(351.5000)
layout:setBottomMargin(55.5000)
jiesuanW:setBlendFunc({src = 1, dst = 771})
imgBg:addChild(jiesuanW)


--Create fntBanker
--local fntBanker = ccui.TextBMFont:create()
--fntBanker:setFntFile("game/bairenniuniu_std/resource/number/jiesuanNum.fnt")
local fntBanker = ccui.Text:create()
fntBanker:setFontName("lobby/resource/font/simhei.ttf")
fntBanker:setFontSize(30)
fntBanker:setString([[+-123456789]])
fntBanker:setLayoutComponentEnabled(true)
fntBanker:setName("fntBanker")
fntBanker:setTag(194)
fntBanker:setCascadeColorEnabled(true)
fntBanker:setCascadeOpacityEnabled(true)
fntBanker:setAnchorPoint(0,0.5)
fntBanker:setPosition(660.0000, 70.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntBanker)
layout:setPositionPercentX(0.3960)
layout:setPositionPercentY(0.1606)
layout:setPercentWidth(0.0950)
layout:setPercentHeight(0.0826)
layout:setSize({width = 180.0000, height = 36.0000})
layout:setLeftMargin(660.0000)
layout:setRightMargin(1054.0000)
layout:setTopMargin(348.0000)
layout:setBottomMargin(52.0000)
imgBg:addChild(fntBanker)

--Create fntPlayer
--local fntPlayer = ccui.TextBMFont:create()
--fntPlayer:setFntFile("game/bairenniuniu_std/resource/number/jiesuanNum.fnt")
local fntPlayer = ccui.Text:create()
fntPlayer:setFontName("lobby/resource/font/simhei.ttf")
fntPlayer:setFontSize(30)
fntPlayer:setString([[+-123456789]])
fntPlayer:setLayoutComponentEnabled(true)
fntPlayer:setName("fntPlayer")
fntPlayer:setTag(195)
fntPlayer:setCascadeColorEnabled(true)
fntPlayer:setCascadeOpacityEnabled(true)
fntPlayer:setAnchorPoint(0,0.5)
fntPlayer:setPosition(1060.0000, 70.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntPlayer)
layout:setPositionPercentX(0.6072)
layout:setPositionPercentY(0.1606)
layout:setPercentWidth(0.0950)
layout:setPercentHeight(0.0826)
layout:setSize({width = 180.0000, height = 36.0000})
layout:setLeftMargin(1060.0000)
layout:setRightMargin(654.0000)
layout:setTopMargin(348.0000)
layout:setBottomMargin(52.0000)
imgBg:addChild(fntPlayer)

--Create JieSuanEffect
local JieSuanEffect=cc.Node:create()
JieSuanEffect:setName("JieSuanEffect")
JieSuanEffect:setTag(14)
JieSuanEffect:setCascadeColorEnabled(true)
JieSuanEffect:setCascadeOpacityEnabled(true)
JieSuanEffect:setPosition(522.9712, 242.8711)
layout = ccui.LayoutComponent:bindLayoutComponent(JieSuanEffect)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setLeftMargin(522.9712)
layout:setRightMargin(-522.9712)
layout:setTopMargin(-242.8711)
layout:setBottomMargin(242.8711)
Node:addChild(JieSuanEffect)

--Create Broken_starsEffect1
local Broken_starsEffect1=cc.Node:create()
Broken_starsEffect1:setName("Broken_starsEffect1")
Broken_starsEffect1:setTag(15)
Broken_starsEffect1:setCascadeColorEnabled(true)
Broken_starsEffect1:setCascadeOpacityEnabled(true)
Broken_starsEffect1:setPosition(1032.2740, 845.8934)
layout = ccui.LayoutComponent:bindLayoutComponent(Broken_starsEffect1)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setLeftMargin(1032.2740)
layout:setRightMargin(-1032.2740)
layout:setTopMargin(-845.8934)
layout:setBottomMargin(845.8934)
Node:addChild(Broken_starsEffect1)

--Create Broken_starsEffect2
local Broken_starsEffect2=cc.Node:create()
Broken_starsEffect2:setName("Broken_starsEffect2")
Broken_starsEffect2:setTag(16)
Broken_starsEffect2:setCascadeColorEnabled(true)
Broken_starsEffect2:setCascadeOpacityEnabled(true)
Broken_starsEffect2:setPosition(1311.4820, 624.0953)
layout = ccui.LayoutComponent:bindLayoutComponent(Broken_starsEffect2)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setLeftMargin(1311.4820)
layout:setRightMargin(-1311.4820)
layout:setTopMargin(-624.0953)
layout:setBottomMargin(624.0953)
Node:addChild(Broken_starsEffect2)

--Create Broken_starsEffect3
local Broken_starsEffect3=cc.Node:create()
Broken_starsEffect3:setName("Broken_starsEffect3")
Broken_starsEffect3:setTag(17)
Broken_starsEffect3:setCascadeColorEnabled(true)
Broken_starsEffect3:setCascadeOpacityEnabled(true)
Broken_starsEffect3:setPosition(687.3871, 808.9806)
layout = ccui.LayoutComponent:bindLayoutComponent(Broken_starsEffect3)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setLeftMargin(687.3871)
layout:setRightMargin(-687.3871)
layout:setTopMargin(-808.9806)
layout:setBottomMargin(808.9806)
Node:addChild(Broken_starsEffect3)

--Create Broken_starsEffect4
local Broken_starsEffect4=cc.Node:create()
Broken_starsEffect4:setName("Broken_starsEffect4")
Broken_starsEffect4:setTag(18)
Broken_starsEffect4:setCascadeColorEnabled(true)
Broken_starsEffect4:setCascadeOpacityEnabled(true)
Broken_starsEffect4:setPosition(584.1050, 569.7787)
layout = ccui.LayoutComponent:bindLayoutComponent(Broken_starsEffect4)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setLeftMargin(584.1050)
layout:setRightMargin(-584.1050)
layout:setTopMargin(-569.7787)
layout:setBottomMargin(569.7787)
Node:addChild(Broken_starsEffect4)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result

