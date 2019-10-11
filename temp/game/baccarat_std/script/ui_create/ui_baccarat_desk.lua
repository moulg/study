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

--Create imgBj
local imgBj = ccui.ImageView:create()
imgBj:ignoreContentAdaptWithSize(false)
imgBj:loadTexture("game/baccarat_std/resource/image/dat.jpg",0)
imgBj:setLayoutComponentEnabled(true)
imgBj:setName("imgBj")
imgBj:setTag(217)
imgBj:setCascadeColorEnabled(true)
imgBj:setCascadeOpacityEnabled(true)
imgBj:setPosition(0.0000, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgBj)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(825.0000, 590.0000))
layout:setLeftMargin(-412.5000)
layout:setRightMargin(-412.5000)
layout:setTopMargin(-295.0000)
layout:setBottomMargin(-295.0000)
Node:addChild(imgBj)

--Create btn_goin
local btn_goin = ccui.Button:create()
btn_goin:ignoreContentAdaptWithSize(false)
btn_goin:loadTextureNormal("game/baccarat_std/resource/button/jryx1.png",0)
btn_goin:loadTexturePressed("game/baccarat_std/resource/button/jryx3.png",0)
btn_goin:setTitleFontSize(14)
btn_goin:setTitleColor(cc.c3b(65, 65, 70))
btn_goin:setScale9Enabled(true)
btn_goin:setCapInsets(cc.rect(15,11,277,67))
btn_goin:setLayoutComponentEnabled(true)
btn_goin:setName("btn_goin")
btn_goin:setTag(218)
btn_goin:setCascadeColorEnabled(true)
btn_goin:setCascadeOpacityEnabled(true)
btn_goin:setPosition(-64.0001, -114.0003)
layout = ccui.LayoutComponent:bindLayoutComponent(btn_goin)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(307.0000, 89.0000))
layout:setLeftMargin(-217.5001)
layout:setRightMargin(-89.4999)
layout:setTopMargin(69.5003)
layout:setBottomMargin(-158.5003)
Node:addChild(btn_goin)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result

