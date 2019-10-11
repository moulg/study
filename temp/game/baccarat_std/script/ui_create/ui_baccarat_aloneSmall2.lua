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

--Create imgIcon
local imgIcon = ccui.ImageView:create()
imgIcon:ignoreContentAdaptWithSize(false)
imgIcon:loadTexture("game/baccarat_std/resource/image/alone/hqs.png",0)
imgIcon:setLayoutComponentEnabled(true)
imgIcon:setName("imgIcon")
imgIcon:setTag(259)
imgIcon:setCascadeColorEnabled(true)
imgIcon:setCascadeOpacityEnabled(true)
imgIcon:setPosition(0.0000, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgIcon)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(31.0000, 31.0000))
layout:setLeftMargin(-15.5000)
layout:setRightMargin(-15.5000)
layout:setTopMargin(-15.5000)
layout:setBottomMargin(-15.5000)
Node:addChild(imgIcon)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result

