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
local sprHeadBack = cc.Sprite:create("game/niuniu_std/resource/image/Nroom_headbg.png")
sprHeadBack:setName("sprHeadBack")
sprHeadBack:setTag(92)
sprHeadBack:setCascadeColorEnabled(true)
sprHeadBack:setCascadeOpacityEnabled(true)
sprHeadBack:setPosition(464.6188, 100.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprHeadBack)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(400.0000, 172.0000))
layout:setLeftMargin(249.6188)
layout:setRightMargin(-479.6188)
layout:setTopMargin(-301.0757)
layout:setBottomMargin(47.0757)
Node:addChild(sprHeadBack)

--Create sprHead
local sprHead = cc.Sprite:create("game/niuniu_std/resource/image/Nroom_headbg.png")
sprHead:setName("sprHead")
sprHead:setTag(114)
sprHead:setCascadeColorEnabled(true)
sprHead:setCascadeOpacityEnabled(true)
sprHead:setPosition(90.0021, 85.9998)
sprHead:setScaleX(0.6000)
sprHead:setScaleY(0.6000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprHead)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.4606)
layout:setSize(cc.size(230.0000, 254.0000))
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(0.0021)
layout:setRightMargin(-0.0021)
layout:setTopMargin(10.0002)
layout:setBottomMargin(-10.0002)
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
labName:setTag(93)
labName:setCascadeColorEnabled(true)
labName:setCascadeOpacityEnabled(true)
labName:setAnchorPoint(0.0000, 0.5000)
labName:setPosition(438.6837, 131.3992)
layout = ccui.LayoutComponent:bindLayoutComponent(labName)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(180.0000, 41.0000))
layout:setLeftMargin(438.6837)
layout:setRightMargin(-667.6837)
layout:setTopMargin(-151.8992)
layout:setBottomMargin(110.8992)
Node:addChild(labName)

--Create labChips
local labChips = ccui.Text:create()
labChips:ignoreContentAdaptWithSize(true)
labChips:setTextAreaSize(cc.size(0, 0))
labChips:setFontName("simhei.ttf")
labChips:setFontSize(24)
labChips:setString([[9999999999]])
labChips:setLayoutComponentEnabled(true)
labChips:setName("labChips")
labChips:setTag(51)
labChips:setCascadeColorEnabled(true)
labChips:setCascadeOpacityEnabled(true)
labChips:setAnchorPoint(0.0000, 0.5000)
labChips:setPosition(438.9253, 91.7889)
layout = ccui.LayoutComponent:bindLayoutComponent(labChips)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(180.0000, 41.0000))
layout:setLeftMargin(438.9253)
layout:setRightMargin(-668.9253)
layout:setTopMargin(-112.2889)
layout:setBottomMargin(71.2889)
Node:addChild(labChips)

--Create nodeCard
local nodeCard=cc.Node:create()
nodeCard:setName("nodeCard")
nodeCard:setTag(168)
nodeCard:setCascadeColorEnabled(true)
nodeCard:setCascadeOpacityEnabled(true)
nodeCard:setPosition(960.0000, 249.6175)
layout = ccui.LayoutComponent:bindLayoutComponent(nodeCard)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setLeftMargin(960.0000)
layout:setRightMargin(-960.0000)
layout:setTopMargin(-249.6175)
layout:setBottomMargin(249.6175)
Node:addChild(nodeCard)

--Create sprReady
local sprReady = cc.Sprite:create("game/niuniu_std/resource/word/ready.png")
sprReady:setName("sprReady")
sprReady:setTag(186)
sprReady:setCascadeColorEnabled(true)
sprReady:setCascadeOpacityEnabled(true)
sprReady:setPosition(960.0000, 248.1445)
layout = ccui.LayoutComponent:bindLayoutComponent(sprReady)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(345.0000, 93.0000))
layout:setLeftMargin(787.5000)
layout:setRightMargin(-1132.5000)
layout:setTopMargin(-294.6445)
layout:setBottomMargin(201.6445)
Node:addChild(sprReady)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result

