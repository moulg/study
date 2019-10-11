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
local imgBg = ccui.ImageView:create()
imgBg:ignoreContentAdaptWithSize(false)
imgBg:loadTexture("update/resource/bj_.png",0)
imgBg:setLayoutComponentEnabled(true)
imgBg:setName("imgBg")
imgBg:setTag(602)
imgBg:setCascadeColorEnabled(true)
imgBg:setCascadeOpacityEnabled(true)
imgBg:setScaleX(0.8000)
imgBg:setScaleY(0.8000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgBg)
layout:setPositionPercentXEnabled(true)
layout:setPositionPercentYEnabled(true)
layout:setSize({width = 1237.0000, height = 723.0000})
layout:setLeftMargin(-547.0000)
layout:setRightMargin(-547.0000)
layout:setTopMargin(-264.0000)
layout:setBottomMargin(-264.0000)
Node:addChild(imgBg)

--Create imgTitle
local imgTitle = ccui.ImageView:create()
imgTitle:ignoreContentAdaptWithSize(false)
imgTitle:loadTexture("update/resource/ts.png",0)
imgTitle:setLayoutComponentEnabled(true)
imgTitle:setName("imgTitle")
imgTitle:setTag(470)
imgTitle:setCascadeColorEnabled(true)
imgTitle:setCascadeOpacityEnabled(true)
imgTitle:setPosition(0.0000, 230.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgTitle)
layout:setPositionPercentXEnabled(true)
layout:setSize({width = 173.0000, height = 71.0000})
layout:setLeftMargin(-48.5000)
layout:setRightMargin(-48.5000)
layout:setTopMargin(-198.9991)
layout:setBottomMargin(148.9991)
Node:addChild(imgTitle)

--Create textMessage
local textMessage = ccui.Text:create()
textMessage:ignoreContentAdaptWithSize(false)
textMessage:setFontName("simhei.ttf")
textMessage:setFontSize(34)
textMessage:setString([[您当前的游戏版本过低，请前往官网下载最新版本大厅。是否立即前往？（友情提示：请在wifi环境下下载）]])
textMessage:setLayoutComponentEnabled(true)
textMessage:setName("textMessage")
textMessage:setTag(471)
textMessage:setCascadeColorEnabled(true)
textMessage:setCascadeOpacityEnabled(true)
textMessage:setPosition(-0.0010, 1.5006)
layout = ccui.LayoutComponent:bindLayoutComponent(textMessage)
layout:setSize({width = 800.0000, height = 160.0000})
layout:setLeftMargin(-400.0010)
layout:setRightMargin(-399.9990)
layout:setTopMargin(-81.5006)
layout:setBottomMargin(-78.4994)
Node:addChild(textMessage)

--Create btnSure
local btnSure = ccui.Button:create()
btnSure:ignoreContentAdaptWithSize(false)
btnSure:loadTextureNormal("update/resource/qd.png",0)
btnSure:setTitleFontSize(14)
btnSure:setTitleColor({r = 65, g = 65, b = 70})
btnSure:setLayoutComponentEnabled(true)
btnSure:setName("btnSure")
btnSure:setTag(496)
btnSure:setCascadeColorEnabled(true)
btnSure:setCascadeOpacityEnabled(true)
btnSure:setPosition(-150.0000, -155.0020)
layout = ccui.LayoutComponent:bindLayoutComponent(btnSure)
layout:setSize({width = 211.0000, height = 91.0000})
layout:setLeftMargin(-277.0000)
layout:setRightMargin(23.0000)
layout:setTopMargin(113.0020)
layout:setBottomMargin(-197.0020)
Node:addChild(btnSure)

--Create btnClose
local btnClose = ccui.Button:create()
btnClose:ignoreContentAdaptWithSize(false)
btnClose:loadTextureNormal("update/resource/close.png",0)
btnClose:setTitleFontSize(14)
btnClose:setTitleColor({r = 65, g = 65, b = 70})
btnClose:setLayoutComponentEnabled(true)
btnClose:setName("btnClose")
btnClose:setTag(508)
btnClose:setCascadeColorEnabled(true)
btnClose:setCascadeOpacityEnabled(true)
btnClose:setPosition(480.0000, 220.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnClose)
layout:setSize({width = 80.0000, height = 80.0000})
layout:setLeftMargin(365.0000)
layout:setRightMargin(-465.0000)
layout:setTopMargin(-205.0001)
layout:setBottomMargin(105.0001)
Node:addChild(btnClose)

--Create btnNoSure
local btnNoSure = ccui.Button:create()
btnNoSure:ignoreContentAdaptWithSize(false)
btnNoSure:loadTextureNormal("update/resource/qux.png",0)
btnNoSure:setTitleFontSize(14)
btnNoSure:setTitleColor({r = 65, g = 65, b = 70})
btnNoSure:setLayoutComponentEnabled(true)
btnNoSure:setName("btnNoSure")
btnNoSure:setTag(77)
btnNoSure:setCascadeColorEnabled(true)
btnNoSure:setCascadeOpacityEnabled(true)
btnNoSure:setPosition(150.0000, -155.0018)
layout = ccui.LayoutComponent:bindLayoutComponent(btnNoSure)
layout:setSize({width = 211.0000, height = 91.0000})
layout:setLeftMargin(23.0000)
layout:setRightMargin(-277.0000)
layout:setTopMargin(113.0018)
layout:setBottomMargin(-197.0018)
Node:addChild(btnNoSure)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result

