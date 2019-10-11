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
imgBg:loadTexture("lobby/resource/hall_res/phb.png",0)
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
imgTitle:loadTexture("lobby/resource/gameUpdate/xz.png",0)
imgTitle:setLayoutComponentEnabled(true)
imgTitle:setName("imgTitle")
imgTitle:setTag(470)
imgTitle:setCascadeColorEnabled(true)
imgTitle:setCascadeOpacityEnabled(true)
imgTitle:setPosition(0.0000, 230.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgTitle)
layout:setPositionPercentXEnabled(true)
layout:setSize({width = 344.0000, height = 72.0000})
layout:setLeftMargin(-123.0000)
layout:setRightMargin(-123.0000)
layout:setTopMargin(-198.4990)
layout:setBottomMargin(149.4990)
Node:addChild(imgTitle)

--Create Text_Speed
local Text_Speed = ccui.Text:create()
Text_Speed:ignoreContentAdaptWithSize(false)
Text_Speed:setFontName("simhei.ttf")
Text_Speed:setFontSize(30)
Text_Speed:setString([[正在下载{1}MB({1}MB/S)]])
Text_Speed:setTextHorizontalAlignment(1)
Text_Speed:setLayoutComponentEnabled(true)
Text_Speed:setName("Text_Speed")
Text_Speed:setTag(471)
Text_Speed:setCascadeColorEnabled(true)
Text_Speed:setCascadeOpacityEnabled(true)
Text_Speed:setPosition(0.0000, 42.5001)
layout = ccui.LayoutComponent:bindLayoutComponent(Text_Speed)
layout:setPositionPercentXEnabled(true)
layout:setSize({width = 800.0000, height = 41.0000})
layout:setLeftMargin(-400.0000)
layout:setRightMargin(-400.0000)
layout:setTopMargin(-63.0001)
layout:setBottomMargin(22.0001)
Node:addChild(Text_Speed)

--Create btnSure
local btnSure = ccui.Button:create()
btnSure:ignoreContentAdaptWithSize(false)
btnSure:loadTextureNormal("lobby/resource/button/qd.png",0)
btnSure:setTitleFontSize(14)
btnSure:setTitleColor({r = 65, g = 65, b = 70})
btnSure:setTouchEnabled(false);
btnSure:setLayoutComponentEnabled(true)
btnSure:setName("btnSure")
btnSure:setTag(496)
btnSure:setCascadeColorEnabled(true)
btnSure:setCascadeOpacityEnabled(true)
btnSure:setVisible(false)
btnSure:setPosition(-130.0000, -118.0003)
btnSure:setScaleX(0.6000)
btnSure:setScaleY(0.6000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnSure)
layout:setSize({width = 211.0000, height = 91.0000})
layout:setLeftMargin(-257.0000)
layout:setRightMargin(3.0000)
layout:setTopMargin(76.0003)
layout:setBottomMargin(-160.0003)
Node:addChild(btnSure)

--Create btnClose
local btnClose = ccui.Button:create()
btnClose:ignoreContentAdaptWithSize(false)
btnClose:loadTextureNormal("lobby/resource/button/close.png",0)
btnClose:setTitleFontSize(14)
btnClose:setTitleColor({r = 65, g = 65, b = 70})
btnClose:setLayoutComponentEnabled(true)
btnClose:setName("btnClose")
btnClose:setTag(508)
btnClose:setCascadeColorEnabled(true)
btnClose:setCascadeOpacityEnabled(true)
btnClose:setPosition(460.0000, 210.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnClose)
layout:setSize({width = 80.0000, height = 80.0000})
layout:setLeftMargin(370.2426)
layout:setRightMargin(-470.2426)
layout:setTopMargin(-205.9954)
layout:setBottomMargin(105.9954)
Node:addChild(btnClose)

--Create btnNo
local btnNo = ccui.Button:create()
btnNo:ignoreContentAdaptWithSize(false)
btnNo:loadTextureNormal("lobby/resource/button/qux.png",0)
btnNo:setTitleFontSize(14)
btnNo:setTitleColor({r = 65, g = 65, b = 70})
btnNo:setTouchEnabled(false);
btnNo:setLayoutComponentEnabled(true)
btnNo:setName("btnNo")
btnNo:setTag(77)
btnNo:setCascadeColorEnabled(true)
btnNo:setCascadeOpacityEnabled(true)
btnNo:setVisible(false)
btnNo:setPosition(130.0000, -118.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnNo)
layout:setSize({width = 211.0000, height = 91.0000})
layout:setLeftMargin(3.0000)
layout:setRightMargin(-257.0000)
layout:setTopMargin(76.0000)
layout:setBottomMargin(-160.0000)
Node:addChild(btnNo)

--Create ImgLoadingBj
local ImgLoadingBj = ccui.ImageView:create()
ImgLoadingBj:ignoreContentAdaptWithSize(false)
ImgLoadingBj:loadTexture("lobby/resource/gameUpdate/lbg.png",0)
ImgLoadingBj:setLayoutComponentEnabled(true)
ImgLoadingBj:setName("ImgLoadingBj")
ImgLoadingBj:setTag(115)
ImgLoadingBj:setCascadeColorEnabled(true)
ImgLoadingBj:setCascadeOpacityEnabled(true)
ImgLoadingBj:setPosition(0.0000, -25.0005)
ImgLoadingBj:setScale(0.8)
layout = ccui.LayoutComponent:bindLayoutComponent(ImgLoadingBj)
layout:setPositionPercentXEnabled(true)
layout:setSize({width = 957.0000, height = 30.0000})
layout:setLeftMargin(-275.0000)
layout:setRightMargin(-275.0000)
layout:setTopMargin(13.0005)
layout:setBottomMargin(-37.0005)
Node:addChild(ImgLoadingBj)

--Create LoadingBar_Schedule
local LoadingBar_Schedule = ccui.LoadingBar:create()
LoadingBar_Schedule:loadTexture("lobby/resource/gameUpdate/hdt.png",0)
LoadingBar_Schedule:ignoreContentAdaptWithSize(false)
LoadingBar_Schedule:setPercent(20)
LoadingBar_Schedule:setLayoutComponentEnabled(true)
LoadingBar_Schedule:setName("LoadingBar_Schedule")
LoadingBar_Schedule:setTag(116)
LoadingBar_Schedule:setCascadeColorEnabled(true)
LoadingBar_Schedule:setCascadeOpacityEnabled(true)
LoadingBar_Schedule:setPosition(0.0000, -25.9951)
LoadingBar_Schedule:setScale(0.8)
layout = ccui.LayoutComponent:bindLayoutComponent(LoadingBar_Schedule)
layout:setPositionPercentXEnabled(true)
layout:setSize({width = 957.0000, height = 30.0000})
layout:setLeftMargin(-274.5000)
layout:setRightMargin(-274.5000)
layout:setTopMargin(13.9951)
layout:setBottomMargin(-37.9951)
Node:addChild(LoadingBar_Schedule)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result
