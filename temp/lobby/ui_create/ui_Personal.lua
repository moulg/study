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

--Create imgBack
local imgBack = ccui.ImageView:create()
imgBack:ignoreContentAdaptWithSize(false)
imgBack:loadTexture("lobby/resource/hall_res/phb.png",0)
imgBack:setLayoutComponentEnabled(true)
imgBack:setName("imgBack")
imgBack:setTag(61)
imgBack:setCascadeColorEnabled(true)
imgBack:setCascadeOpacityEnabled(true)
layout = ccui.LayoutComponent:bindLayoutComponent(imgBack)
layout:setPositionPercentXEnabled(true)
layout:setPositionPercentYEnabled(true)
layout:setSize({width = 1237.0000, height = 723.0000})
layout:setLeftMargin(-546.5000)
layout:setRightMargin(-546.5000)
layout:setTopMargin(-318.5000)
layout:setBottomMargin(-318.5000)
Node:addChild(imgBack)

--Create imgBack
local imgBackT = ccui.ImageView:create()
imgBackT:ignoreContentAdaptWithSize(false)
imgBackT:loadTexture("lobby/resource/PersonalCenter/Personalcenter.png",0)
imgBackT:setLayoutComponentEnabled(true)
imgBackT:setName("imgBackT")
imgBackT:setTag(61)
imgBackT:setCascadeColorEnabled(true)
imgBackT:setCascadeOpacityEnabled(true)
imgBackT:setPosition(0.0000, 290.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgBackT)
layout:setPositionPercentXEnabled(true)
layout:setPositionPercentYEnabled(true)
layout:setSize({width = 274.0000, height = 72.0000})
layout:setLeftMargin(-546.5000)
layout:setRightMargin(-546.5000)
layout:setTopMargin(-318.5000)
layout:setBottomMargin(-318.5000)
Node:addChild(imgBackT)

--Create imgHeadBj
local imgHeadBj = ccui.ImageView:create()
imgHeadBj:ignoreContentAdaptWithSize(false)
imgHeadBj:loadTexture("lobby/resource/PersonalCenter/xxbg.png",0)
imgHeadBj:setLayoutComponentEnabled(true)
imgHeadBj:setName("imgHeadBj")
imgHeadBj:setTag(62)
imgHeadBj:setCascadeColorEnabled(true)
imgHeadBj:setCascadeOpacityEnabled(true)
imgHeadBj:setPosition(-380.0000, 70.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgHeadBj)
layout:setSize({width = 165.0000, height = 165.0000})
layout:setLeftMargin(-464.5000)
layout:setRightMargin(295.5000)
layout:setTopMargin(-154.5000)
layout:setBottomMargin(-14.5000)
Node:addChild(imgHeadBj)

--Create imgName
local imgName = ccui.ImageView:create()
imgName:ignoreContentAdaptWithSize(false)
imgName:loadTexture("lobby/resource/PersonalCenter/zh.png",0)
imgName:setLayoutComponentEnabled(true)
imgName:setName("imgName")
imgName:setTag(63)
imgName:setCascadeColorEnabled(true)
imgName:setCascadeOpacityEnabled(true)
imgName:setAnchorPoint(0.5000, 0.5762)
imgName:setPosition(-170.0000, 140.0000)
imgName:setScaleX(0.8500)
imgName:setScaleY(0.8500)
layout = ccui.LayoutComponent:bindLayoutComponent(imgName)
layout:setSize({width = 131.0000, height = 45.0000})
layout:setLeftMargin(-221.0000)
layout:setRightMargin(119.0000)
layout:setTopMargin(-156.1044)
layout:setBottomMargin(118.1044)
Node:addChild(imgName)

--Create imgPetname
local imgPetname = ccui.ImageView:create()
imgPetname:ignoreContentAdaptWithSize(false)
imgPetname:loadTexture("lobby/resource/PersonalCenter/nc.png",0)
imgPetname:setLayoutComponentEnabled(true)
imgPetname:setName("imgPetname")
imgPetname:setTag(64)
imgPetname:setCascadeColorEnabled(true)
imgPetname:setCascadeOpacityEnabled(true)
imgPetname:setPosition(-170.0000, 70.0000)
imgPetname:setScaleX(0.8500)
imgPetname:setScaleY(0.8500)
layout = ccui.LayoutComponent:bindLayoutComponent(imgPetname)
layout:setSize({width = 131.0000, height = 45.0000})
layout:setLeftMargin(-221.0000)
layout:setRightMargin(119.0000)
layout:setTopMargin(-89.0000)
layout:setBottomMargin(51.0000)
Node:addChild(imgPetname)

--Create imgSex
local imgSex = ccui.ImageView:create()
imgSex:ignoreContentAdaptWithSize(false)
imgSex:loadTexture("lobby/resource/PersonalCenter/xb.png",0)
imgSex:setLayoutComponentEnabled(true)
imgSex:setName("imgSex")
imgSex:setTag(65)
imgSex:setCascadeColorEnabled(true)
imgSex:setCascadeOpacityEnabled(true)
imgSex:setPosition(-170.0000, 0.0000)
imgSex:setScaleX(0.8500)
imgSex:setScaleY(0.8500)
layout = ccui.LayoutComponent:bindLayoutComponent(imgSex)
layout:setSize({width = 131.0000, height = 45.0000})
layout:setLeftMargin(-221.0000)
layout:setRightMargin(119.0000)
layout:setTopMargin(-19.0000)
layout:setBottomMargin(-19.0000)
Node:addChild(imgSex)

--Create imgCard
local imgCard = ccui.ImageView:create()
imgCard:ignoreContentAdaptWithSize(false)
imgCard:loadTexture("lobby/resource/PersonalCenter/Identityauthentication.png",0)
imgCard:setLayoutComponentEnabled(true)
imgCard:setName("imgCard")
imgCard:setTag(66)
imgCard:setCascadeColorEnabled(true)
imgCard:setCascadeOpacityEnabled(true)
imgCard:setPosition(-279.9983, -117.9984-50)
layout = ccui.LayoutComponent:bindLayoutComponent(imgCard)
layout:setSize({width = 155.0000, height = 39.0000})
layout:setLeftMargin(-357.4983)
layout:setRightMargin(202.4983)
layout:setTopMargin(98.4984)
layout:setBottomMargin(-137.4984)
Node:addChild(imgCard)

--Create imgPhone
local imgPhone = ccui.ImageView:create()
imgPhone:ignoreContentAdaptWithSize(false)
imgPhone:loadTexture("lobby/resource/PersonalCenter/sjbd.png",0)
imgPhone:setLayoutComponentEnabled(true)
imgPhone:setName("imgPhone")
imgPhone:setTag(67)
imgPhone:setCascadeColorEnabled(true)
imgPhone:setCascadeOpacityEnabled(true)
imgPhone:setPosition(-279.9969, -205.9984)
imgPhone:setVisible(false)
layout = ccui.LayoutComponent:bindLayoutComponent(imgPhone)
layout:setSize({width = 159.0000, height = 39.0000})
layout:setLeftMargin(-359.4969)
layout:setRightMargin(200.4969)
layout:setTopMargin(186.4984)
layout:setBottomMargin(-225.4984)
Node:addChild(imgPhone)

--Create btnCardNo
local btnCardNo = ccui.Button:create()
btnCardNo:ignoreContentAdaptWithSize(false)
btnCardNo:loadTextureNormal("lobby/resource/PersonalCenter/Tothecertification.png",0)
btnCardNo:loadTextureDisabled("lobby/resource/PersonalCenter/Certified.png",0)
btnCardNo:setTitleFontSize(14)
btnCardNo:setTitleColor({r = 65, g = 65, b = 70})
btnCardNo:setName("btnCardNo")
btnCardNo:setCascadeColorEnabled(true)
btnCardNo:setCascadeOpacityEnabled(true)
btnCardNo:setPosition(280.0002, -117.9992-50)
layout = ccui.LayoutComponent:bindLayoutComponent(btnCardNo)
layout:setSize({width = 191.0000, height = 65.0000})
layout:setLeftMargin(162.0002)
layout:setRightMargin(-398.0002)
layout:setTopMargin(76.9992)
layout:setBottomMargin(-158.9992)
Node:addChild(btnCardNo)

--Create btnBind
local btnBind = ccui.Button:create()
btnBind:ignoreContentAdaptWithSize(false)
btnBind:loadTextureNormal("lobby/resource/PersonalCenter/qxbd.png",0)
btnBind:setTitleFontSize(14)
btnBind:setTitleColor({r = 65, g = 65, b = 70})
btnBind:setScale9Enabled(true)
btnBind:setCapInsets({x = 15, y = 11, width = 206, height = 60})
btnBind:setLayoutComponentEnabled(true)
btnBind:setName("btnBind")
btnBind:setTag(69)
btnBind:setCascadeColorEnabled(true)
btnBind:setCascadeOpacityEnabled(true)
btnBind:setPosition(280.0002, -205.9976)
btnBind:setVisible(false)
layout = ccui.LayoutComponent:bindLayoutComponent(btnBind)
layout:setSize({width = 236.0000, height = 82.0000})
layout:setLeftMargin(162.0002)
layout:setRightMargin(-398.0002)
layout:setTopMargin(164.9976)
layout:setBottomMargin(-246.9976)
Node:addChild(btnBind)

--Create testPetname
local testPetname = ccui.Text:create()
testPetname:ignoreContentAdaptWithSize(false)
testPetname:setFontName("simhei.ttf")
testPetname:setFontSize(24)
testPetname:setString([[]])
testPetname:setTextVerticalAlignment(1)
testPetname:setLayoutComponentEnabled(true)
testPetname:setName("testPetname")
testPetname:setTag(71)
testPetname:setCascadeColorEnabled(true)
testPetname:setCascadeOpacityEnabled(true)
testPetname:setAnchorPoint(0.0000, 0.5000)
testPetname:setPosition(-92.9980, 65.1131)
layout = ccui.LayoutComponent:bindLayoutComponent(testPetname)
layout:setSize({width = 300.0000, height = 27.0000})
layout:setLeftMargin(-92.9980)
layout:setRightMargin(-207.0020)
layout:setTopMargin(-78.6131)
layout:setBottomMargin(51.6131)
Node:addChild(testPetname)

--Create testName
local testName = ccui.Text:create()
testName:ignoreContentAdaptWithSize(false)
testName:setFontName("simhei.ttf")
testName:setFontSize(24)
testName:setString([[]])
testName:setTextVerticalAlignment(1)
testName:setLayoutComponentEnabled(true)
testName:setName("testName")
testName:setTag(73)
testName:setCascadeColorEnabled(true)
testName:setCascadeOpacityEnabled(true)
testName:setAnchorPoint(0.0000, 0.5000)
testName:setPosition(-92.9980, 132.7406)
layout = ccui.LayoutComponent:bindLayoutComponent(testName)
layout:setSize({width = 300.0000, height = 27.0000})
layout:setLeftMargin(-92.9980)
layout:setRightMargin(-207.0020)
layout:setTopMargin(-146.2406)
layout:setBottomMargin(119.2406)
Node:addChild(testName)

--Create node_copyID
local node_copyID=cc.Node:create()
node_copyID:setName("node_copyID")
node_copyID:setCascadeColorEnabled(true)
node_copyID:setCascadeOpacityEnabled(true)
node_copyID:setPosition(30.0000, 135.0000)
Node:addChild(node_copyID)

--Create imgMan
local imgMan = ccui.ImageView:create()
imgMan:ignoreContentAdaptWithSize(false)
imgMan:loadTexture("lobby/resource/PersonalCenter/nan.png",0)
imgMan:setLayoutComponentEnabled(true)
imgMan:setName("imgMan")
imgMan:setTag(74)
imgMan:setCascadeColorEnabled(true)
imgMan:setCascadeOpacityEnabled(true)
imgMan:setPosition(-2.4993+10, 0.0001)
layout = ccui.LayoutComponent:bindLayoutComponent(imgMan)
layout:setSize({width = 61.0000, height = 68.0000})
layout:setLeftMargin(-27.4993)
layout:setRightMargin(-22.5007)
layout:setTopMargin(-29.5001)
layout:setBottomMargin(-29.4999)
Node:addChild(imgMan)

--Create imgWoman
local imgWoman = ccui.ImageView:create()
imgWoman:ignoreContentAdaptWithSize(false)
imgWoman:loadTexture("lobby/resource/PersonalCenter/nv.png",0)
imgWoman:setLayoutComponentEnabled(true)
imgWoman:setName("imgWoman")
imgWoman:setTag(75)
imgWoman:setCascadeColorEnabled(true)
imgWoman:setCascadeOpacityEnabled(true)
imgWoman:setPosition(192.3985+10, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgWoman)
layout:setSize({width = 61.0000, height = 68.0000})
layout:setLeftMargin(167.3985)
layout:setRightMargin(-217.3985)
layout:setTopMargin(-29.5000)
layout:setBottomMargin(-29.5000)
Node:addChild(imgWoman)

--Create CheckBox_Man
local CheckBox_Man = ccui.CheckBox:create()
CheckBox_Man:ignoreContentAdaptWithSize(false)
CheckBox_Man:loadTextureBackGround("lobby/resource/PersonalCenter/QUAN.png",0)
CheckBox_Man:loadTextureFrontCross("lobby/resource/PersonalCenter/QUAN_.png",0)
CheckBox_Man:setSelected(true)
CheckBox_Man:setLayoutComponentEnabled(true)
CheckBox_Man:setName("CheckBox_Man")
CheckBox_Man:setTag(76)
CheckBox_Man:setCascadeColorEnabled(true)
CheckBox_Man:setCascadeOpacityEnabled(true)
CheckBox_Man:setPosition(-61.6284, 0.0005)
layout = ccui.LayoutComponent:bindLayoutComponent(CheckBox_Man)
layout:setSize({width = 47.0000, height = 46.0000})
layout:setLeftMargin(-89.1284)
layout:setRightMargin(34.1284)
layout:setTopMargin(-27.5005)
layout:setBottomMargin(-27.4995)
Node:addChild(CheckBox_Man)

--Create CheckBox_Woman
local CheckBox_Woman = ccui.CheckBox:create()
CheckBox_Woman:ignoreContentAdaptWithSize(false)
CheckBox_Woman:loadTextureBackGround("lobby/resource/PersonalCenter/QUAN.png",0)
CheckBox_Woman:loadTextureFrontCross("lobby/resource/PersonalCenter/QUAN_.png",0)
CheckBox_Woman:setSelected(true)
CheckBox_Woman:setLayoutComponentEnabled(true)
CheckBox_Woman:setName("CheckBox_Woman")
CheckBox_Woman:setTag(77)
CheckBox_Woman:setCascadeColorEnabled(true)
CheckBox_Woman:setCascadeOpacityEnabled(true)
CheckBox_Woman:setPosition(142.0349, 0.0004)
layout = ccui.LayoutComponent:bindLayoutComponent(CheckBox_Woman)
layout:setSize({width = 47.0000, height = 46.0000})
layout:setLeftMargin(114.5349)
layout:setRightMargin(-169.5349)
layout:setTopMargin(-27.5004)
layout:setBottomMargin(-27.4996)
Node:addChild(CheckBox_Woman)

--Create imgHead
local imgHead = ccui.ImageView:create()
imgHead:ignoreContentAdaptWithSize(false)
imgHead:loadTexture("Default/ImageFile.png",0)
imgHead:setLayoutComponentEnabled(true)
imgHead:setName("imgHead")
imgHead:setTag(78)
imgHead:setCascadeColorEnabled(true)
imgHead:setCascadeOpacityEnabled(true)
imgHead:setPosition(-379.7384, 70.5681)
layout = ccui.LayoutComponent:bindLayoutComponent(imgHead)
layout:setSize({width = 150.0000, height = 150.0000})
layout:setLeftMargin(-454.7384)
layout:setRightMargin(304.7384)
layout:setTopMargin(-145.5681)
layout:setBottomMargin(-4.4319)
Node:addChild(imgHead)

--Create btnClose
local btnClose = ccui.Button:create()
btnClose:ignoreContentAdaptWithSize(false)
btnClose:loadTextureNormal("lobby/resource/button/close.png",0)
btnClose:setTitleFontSize(14)
btnClose:setTitleColor({r = 65, g = 65, b = 70})
btnClose:setLayoutComponentEnabled(true)
btnClose:setName("btnClose")
btnClose:setTag(79)
btnClose:setCascadeColorEnabled(true)
btnClose:setCascadeOpacityEnabled(true)
btnClose:setPosition(600.0000, 300.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnClose)
layout:setSize({width = 80.0000, height = 80.0000})
layout:setLeftMargin(465.0000)
layout:setRightMargin(-565.0000)
layout:setTopMargin(-295.0000)
layout:setBottomMargin(195.0000)
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

