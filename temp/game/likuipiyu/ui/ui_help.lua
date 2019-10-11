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

--Create imgHelp
local imgHelp = ccui.ImageView:create()
imgHelp:ignoreContentAdaptWithSize(false)
imgHelp:loadTexture("game/likuipiyu/resource/other/beishu.png",0)
imgHelp:setLayoutComponentEnabled(true)
imgHelp:setName("imgHelp")
imgHelp:setTag(11)
imgHelp:setCascadeColorEnabled(true)
imgHelp:setCascadeOpacityEnabled(true)
imgHelp:setPosition(0.0000, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgHelp)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(1440.0000, 870.0000))
layout:setLeftMargin(-720.0000)
layout:setRightMargin(-720.0000)
layout:setTopMargin(-435.0000)
layout:setBottomMargin(-435.0000)
Node:addChild(imgHelp)

--Create btnClose
local btnClose = ccui.Button:create()
btnClose:ignoreContentAdaptWithSize(false)
btnClose:loadTextureNormal("game/likuipiyu/resource/other/close.png",0)
btnClose:setTitleFontSize(14)
btnClose:setTitleColor(cc.c3b(65, 65, 70))
btnClose:setScale9Enabled(true)
btnClose:setCapInsets(cc.rect(15,11,48,50))
btnClose:setLayoutComponentEnabled(true)
btnClose:setName("btnClose")
btnClose:setTag(37)
btnClose:setCascadeColorEnabled(true)
btnClose:setCascadeOpacityEnabled(true)
btnClose:setPosition(680.0000, 400.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnClose)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(78.0000, 72.0000))
layout:setLeftMargin(641.0000)
layout:setRightMargin(-719.0000)
layout:setTopMargin(-436.0000)
layout:setBottomMargin(364.0000)
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
