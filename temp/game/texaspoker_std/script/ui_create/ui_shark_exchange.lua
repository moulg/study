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

--Create sprBack
local sprBack = ccui.ImageView:create()
sprBack:ignoreContentAdaptWithSize(false)
sprBack:loadTexture("game/texaspoker_std/resource/image/dhk.png",0)
sprBack:setLayoutComponentEnabled(true)
sprBack:setName("sprBack")
sprBack:setTag(538)
sprBack:setCascadeColorEnabled(true)
sprBack:setCascadeOpacityEnabled(true)
sprBack:setPosition(0.0000, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprBack)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(608.0000, 964.0000))
layout:setLeftMargin(-304.0000)
layout:setRightMargin(-304.0000)
layout:setTopMargin(-482.0000)
layout:setBottomMargin(-482.0000)
Node:addChild(sprBack)

--Create btnAddChips
local btnAddChips = ccui.Button:create()
btnAddChips:ignoreContentAdaptWithSize(false)
btnAddChips:loadTextureNormal("game/texaspoker_std/resource/button/sf.png",0)
btnAddChips:setTitleFontSize(14)
btnAddChips:setTitleColor(cc.c3b(65, 65, 70))
btnAddChips:setScale9Enabled(true)
btnAddChips:setCapInsets(cc.rect(15,11,393,224))
btnAddChips:setLayoutComponentEnabled(true)
btnAddChips:setName("btnAddChips")
btnAddChips:setTag(539)
btnAddChips:setCascadeColorEnabled(true)
btnAddChips:setCascadeOpacityEnabled(true)
btnAddChips:setPosition(0.0000, 166.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnAddChips)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(423.0000, 246.0000))
layout:setLeftMargin(-211.5000)
layout:setRightMargin(-211.5000)
layout:setTopMargin(-289.0000)
layout:setBottomMargin(43.0000)
Node:addChild(btnAddChips)

--Create btnReduceChips
local btnReduceChips = ccui.Button:create()
btnReduceChips:ignoreContentAdaptWithSize(false)
btnReduceChips:loadTextureNormal("game/texaspoker_std/resource/button/xf.png",0)
btnReduceChips:setTitleFontSize(14)
btnReduceChips:setTitleColor(cc.c3b(65, 65, 70))
btnReduceChips:setScale9Enabled(true)
btnReduceChips:setCapInsets(cc.rect(15,11,393,224))
btnReduceChips:setLayoutComponentEnabled(true)
btnReduceChips:setName("btnReduceChips")
btnReduceChips:setTag(540)
btnReduceChips:setCascadeColorEnabled(true)
btnReduceChips:setCascadeOpacityEnabled(true)
btnReduceChips:setPosition(0.0000, -88.5000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnReduceChips)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(423.0000, 246.0000))
layout:setLeftMargin(-211.5000)
layout:setRightMargin(-211.5000)
layout:setTopMargin(-34.5000)
layout:setBottomMargin(-211.5000)
Node:addChild(btnReduceChips)

--Create btnExchangeAll
local btnExchangeAll = ccui.Button:create()
btnExchangeAll:ignoreContentAdaptWithSize(false)
btnExchangeAll:loadTextureNormal("game/texaspoker_std/resource/button/dhqb.png",0)
btnExchangeAll:setTitleFontSize(14)
btnExchangeAll:setTitleColor(cc.c3b(65, 65, 70))
btnExchangeAll:setScale9Enabled(true)
btnExchangeAll:setCapInsets(cc.rect(15,11,393,224))
btnExchangeAll:setLayoutComponentEnabled(true)
btnExchangeAll:setName("btnExchangeAll")
btnExchangeAll:setTag(541)
btnExchangeAll:setCascadeColorEnabled(true)
btnExchangeAll:setCascadeOpacityEnabled(true)
btnExchangeAll:setPosition(-0.0001, -343.0003)
layout = ccui.LayoutComponent:bindLayoutComponent(btnExchangeAll)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(423.0000, 246.0000))
layout:setLeftMargin(-211.5001)
layout:setRightMargin(-211.4999)
layout:setTopMargin(220.0003)
layout:setBottomMargin(-466.0003)
Node:addChild(btnExchangeAll)

--Create imgchips
local imgchips = ccui.ImageView:create()
imgchips:ignoreContentAdaptWithSize(false)
imgchips:loadTexture("game/texaspoker_std/resource/word/choumaduihuan.png",0)
imgchips:setLayoutComponentEnabled(true)
imgchips:setName("imgchips")
imgchips:setTag(48)
imgchips:setCascadeColorEnabled(true)
imgchips:setCascadeOpacityEnabled(true)
imgchips:setPosition(-122.4431, 418.9243)
layout = ccui.LayoutComponent:bindLayoutComponent(imgchips)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(335.0000, 96.0000))
layout:setLeftMargin(-289.9431)
layout:setRightMargin(-45.0569)
layout:setTopMargin(-466.9243)
layout:setBottomMargin(370.9243)
Node:addChild(imgchips)

--Create btnClose
local btnClose = ccui.Button:create()
btnClose:ignoreContentAdaptWithSize(false)
btnClose:loadTextureNormal("game/texaspoker_std/resource/button/guanbi.png",0)
btnClose:setTitleFontSize(14)
btnClose:setTitleColor(cc.c3b(65, 65, 70))
btnClose:setScale9Enabled(true)
btnClose:setCapInsets(cc.rect(15,11,114,122))
btnClose:setLayoutComponentEnabled(true)
btnClose:setName("btnClose")
btnClose:setTag(47)
btnClose:setCascadeColorEnabled(true)
btnClose:setCascadeOpacityEnabled(true)
btnClose:setAnchorPoint(0.6081, 0.4577)
btnClose:setPosition(233.6486, 390.6532)
layout = ccui.LayoutComponent:bindLayoutComponent(btnClose)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(144.0000, 144.0000))
layout:setLeftMargin(146.0846)
layout:setRightMargin(-290.0846)
layout:setTopMargin(-468.7502)
layout:setBottomMargin(324.7502)
Node:addChild(btnClose)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result

