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
imgBg:setTag(601)
imgBg:setCascadeColorEnabled(true)
imgBg:setCascadeOpacityEnabled(true)
layout = ccui.LayoutComponent:bindLayoutComponent(imgBg)
layout:setPositionPercentXEnabled(true)
layout:setPositionPercentYEnabled(true)
layout:setSize({width = 1094.0000, height = 528.0000})
layout:setLeftMargin(-547.0000)
layout:setRightMargin(-547.0000)
layout:setTopMargin(-264.0000)
layout:setBottomMargin(-264.0000)
Node:addChild(imgBg)

--Create imgTitle
local imgTitle = ccui.ImageView:create()
imgTitle:ignoreContentAdaptWithSize(false)
imgTitle:loadTexture("lobby/resource/bank/yhmmxg.png",0)
imgTitle:setLayoutComponentEnabled(true)
imgTitle:setName("imgTitle")
imgTitle:setTag(372)
imgTitle:setCascadeColorEnabled(true)
imgTitle:setCascadeOpacityEnabled(true)
imgTitle:setPosition(0.0000, 200.0006)
layout = ccui.LayoutComponent:bindLayoutComponent(imgTitle)
layout:setPositionPercentXEnabled(true)
layout:setSize({width = 275.0000, height = 72.0000})
layout:setLeftMargin(-98.0000)
layout:setRightMargin(-98.0000)
layout:setTopMargin(-220.5006)
layout:setBottomMargin(171.5006)
Node:addChild(imgTitle)

--Create btnClose
local btnClose = ccui.Button:create()
btnClose:ignoreContentAdaptWithSize(false)
btnClose:loadTextureNormal("lobby/resource/button/close.png",0)
btnClose:setTitleFontSize(14)
btnClose:setTitleColor({r = 65, g = 65, b = 70})
btnClose:setScale9Enabled(false)
btnClose:setCapInsets({x = 15, y = 11, width = 70, height = 78})
btnClose:setLayoutComponentEnabled(true)
btnClose:setName("btnClose")
btnClose:setTag(397)
btnClose:setCascadeColorEnabled(true)
btnClose:setCascadeOpacityEnabled(true)
btnClose:setPosition(520.0000, 190.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnClose)
layout:setSize({width = 100.0000, height = 100.0000})
layout:setLeftMargin(470.0000)
layout:setRightMargin(-570.0000)
layout:setTopMargin(-240.0000)
layout:setBottomMargin(140.0000)
Node:addChild(btnClose)

--Create imgOldKey
local imgOldKey = ccui.ImageView:create()
imgOldKey:ignoreContentAdaptWithSize(false)
imgOldKey:loadTexture("lobby/resource/bank/jmm.png",0)
imgOldKey:setLayoutComponentEnabled(true)
imgOldKey:setName("imgOldKey")
imgOldKey:setTag(398)
imgOldKey:setCascadeColorEnabled(true)
imgOldKey:setCascadeOpacityEnabled(true)
imgOldKey:setPosition(-266.5980, 64.9979)
layout = ccui.LayoutComponent:bindLayoutComponent(imgOldKey)
layout:setSize({width = 283.0000, height = 44.0000})
layout:setLeftMargin(-385.5980)
layout:setRightMargin(147.5980)
layout:setTopMargin(-84.9979)
layout:setBottomMargin(44.9979)
Node:addChild(imgOldKey)

--Create imgOldKeyBj
local imgOldKeyBj = ccui.ImageView:create()
imgOldKeyBj:ignoreContentAdaptWithSize(false)
imgOldKeyBj:loadTexture("lobby/resource/bank/srk.png",0)
imgOldKeyBj:setLayoutComponentEnabled(true)
imgOldKeyBj:setName("imgOldKeyBj")
imgOldKeyBj:setTag(399)
imgOldKeyBj:setCascadeColorEnabled(true)
imgOldKeyBj:setCascadeOpacityEnabled(true)
imgOldKeyBj:setPosition(164.7108, 64.9989)
layout = ccui.LayoutComponent:bindLayoutComponent(imgOldKeyBj)
layout:setSize({width = 522.0000, height = 76.0000})
layout:setLeftMargin(-96.2892)
layout:setRightMargin(-425.7108)
layout:setTopMargin(-102.9989)
layout:setBottomMargin(26.9989)
Node:addChild(imgOldKeyBj)

--Create inputOldKey
local inputOldKey = ccui.TextField:create()
inputOldKey:ignoreContentAdaptWithSize(false)
tolua.cast(inputOldKey:getVirtualRenderer(), "cc.Label"):setLineBreakWithoutSpace(true)
--inputOldKey:setFontName("simhei.ttf")
inputOldKey:setFontSize(48)
inputOldKey:setPlaceHolder("旧密码默认8个8")
inputOldKey:setString([[]])
inputOldKey:setMaxLength(10)
inputOldKey:setPasswordEnabled(true)
inputOldKey:setLayoutComponentEnabled(true)
inputOldKey:setName("inputOldKey")
inputOldKey:setTag(400)
inputOldKey:setCascadeColorEnabled(true)
inputOldKey:setCascadeOpacityEnabled(true)
inputOldKey:setPosition(166.7146, 58.8091)
layout = ccui.LayoutComponent:bindLayoutComponent(inputOldKey)
layout:setSize({width = 500.0000, height = 60.0000})
layout:setLeftMargin(-83.2854)
layout:setRightMargin(-416.7146)
layout:setTopMargin(-88.8091)
layout:setBottomMargin(28.8091)
Node:addChild(inputOldKey)

--Create imgNewKey
local imgNewKey = ccui.ImageView:create()
imgNewKey:ignoreContentAdaptWithSize(false)
imgNewKey:loadTexture("lobby/resource/bank/xmm.png",0)
imgNewKey:setLayoutComponentEnabled(true)
imgNewKey:setName("imgNewKey")
imgNewKey:setTag(401)
imgNewKey:setCascadeColorEnabled(true)
imgNewKey:setCascadeOpacityEnabled(true)
imgNewKey:setAnchorPoint(0.4928, 0.4415)
imgNewKey:setPosition(-264.5107, -35.8710)
layout = ccui.LayoutComponent:bindLayoutComponent(imgNewKey)
layout:setSize({width = 283.0000, height = 44.0000})
layout:setLeftMargin(-381.7971)
layout:setRightMargin(143.7971)
layout:setTopMargin(13.5310)
layout:setBottomMargin(-53.5310)
Node:addChild(imgNewKey)

--Create imgNewKeyBj
local imgNewKeyBj = ccui.ImageView:create()
imgNewKeyBj:ignoreContentAdaptWithSize(false)
imgNewKeyBj:loadTexture("lobby/resource/bank/srk.png",0)
imgNewKeyBj:setLayoutComponentEnabled(true)
imgNewKeyBj:setName("imgNewKeyBj")
imgNewKeyBj:setTag(402)
imgNewKeyBj:setCascadeColorEnabled(true)
imgNewKeyBj:setCascadeOpacityEnabled(true)
imgNewKeyBj:setPosition(168.1801, -34.0009)
layout = ccui.LayoutComponent:bindLayoutComponent(imgNewKeyBj)
layout:setSize({width = 522.0000, height = 76.0000})
layout:setLeftMargin(-92.8199)
layout:setRightMargin(-429.1801)
layout:setTopMargin(-3.9991)
layout:setBottomMargin(-72.0009)
Node:addChild(imgNewKeyBj)

--Create inputNewKey
local inputNewKey = ccui.TextField:create()
inputNewKey:ignoreContentAdaptWithSize(false)
tolua.cast(inputNewKey:getVirtualRenderer(), "cc.Label"):setLineBreakWithoutSpace(true)
--inputNewKey:setFontName("simhei.ttf")
inputNewKey:setFontSize(48)
inputNewKey:setPlaceHolder("新密码字母或数字组合")
inputNewKey:setString([[]])
inputNewKey:setMaxLength(10)
inputNewKey:setPasswordEnabled(true)
inputNewKey:setLayoutComponentEnabled(true)
inputNewKey:setName("inputNewKey")
inputNewKey:setTag(403)
inputNewKey:setCascadeColorEnabled(true)
inputNewKey:setCascadeOpacityEnabled(true)
inputNewKey:setPosition(170.1770, -40.3279)
layout = ccui.LayoutComponent:bindLayoutComponent(inputNewKey)
layout:setSize({width = 500.0000, height = 60.0000})
layout:setLeftMargin(-79.8230)
layout:setRightMargin(-420.1770)
layout:setTopMargin(10.3279)
layout:setBottomMargin(-70.3279)
Node:addChild(inputNewKey)

--Create imgHelp
local imgHelp = ccui.ImageView:create()
imgHelp:ignoreContentAdaptWithSize(false)
imgHelp:loadTexture("lobby/resource/bank/wz.png",0)
imgHelp:setLayoutComponentEnabled(true)
imgHelp:setName("imgHelp")
imgHelp:setTag(404)
imgHelp:setCascadeColorEnabled(true)
imgHelp:setCascadeOpacityEnabled(true)
imgHelp:setPosition(3.9999, -106.9747)
layout = ccui.LayoutComponent:bindLayoutComponent(imgHelp)
layout:setSize({width = 575.0000, height = 25.0000})
layout:setLeftMargin(-283.5001)
layout:setRightMargin(-291.4999)
layout:setTopMargin(94.4747)
layout:setBottomMargin(-119.4747)
Node:addChild(imgHelp)

--Create btnCancel
local btnCancel = ccui.Button:create()
btnCancel:ignoreContentAdaptWithSize(false)
btnCancel:loadTextureNormal("lobby/resource/button/qux.png",0)
btnCancel:setTitleFontSize(14)
btnCancel:setTitleColor({r = 65, g = 65, b = 70})
btnCancel:setScale9Enabled(false)
btnCancel:setCapInsets({x = 15, y = 11, width = 224, height = 62})
btnCancel:setLayoutComponentEnabled(true)
btnCancel:setName("btnCancel")
btnCancel:setTag(405)
btnCancel:setCascadeColorEnabled(true)
btnCancel:setCascadeOpacityEnabled(true)
btnCancel:setPosition(-170.0000, -195.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnCancel)
layout:setSize({width = 211.0000, height = 91.0000})
layout:setLeftMargin(-297.0000)
layout:setRightMargin(43.0000)
layout:setTopMargin(153.0000)
layout:setBottomMargin(-237.0000)
Node:addChild(btnCancel)

--Create btnSure
local btnSure = ccui.Button:create()
btnSure:ignoreContentAdaptWithSize(false)
btnSure:loadTextureNormal("lobby/resource/button/qd.png",0)
btnSure:setTitleFontSize(14)
btnSure:setTitleColor({r = 65, g = 65, b = 70})
btnSure:setScale9Enabled(false)
btnSure:setCapInsets({x = 15, y = 11, width = 224, height = 62})
btnSure:setLayoutComponentEnabled(true)
btnSure:setName("btnSure")
btnSure:setTag(428)
btnSure:setCascadeColorEnabled(true)
btnSure:setCascadeOpacityEnabled(true)
btnSure:setPosition(170.0000, -195.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnSure)
layout:setSize({width = 211.0000, height = 91.0000})
layout:setLeftMargin(43.0000)
layout:setRightMargin(-297.0000)
layout:setTopMargin(153.0000)
layout:setBottomMargin(-237.0000)
Node:addChild(btnSure)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result

