--------------------------------------------------------------
-- This file was automatically generated by Cocos Studio.
-- Do not make changes to this file.
-- All changes will be lost.
--------------------------------------------------------------


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
local imgBack = cc.Sprite:create("game/errentexaspoker_std/resource/image/zz1.png")
imgBack:setName("imgBack")
imgBack:setTag(679)
imgBack:setCascadeColorEnabled(true)
imgBack:setCascadeOpacityEnabled(true)
imgBack:setPosition(0.0000, 13.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgBack)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(218.0000, 139.0000))
layout:setLeftMargin(-117.5000)
layout:setRightMargin(-117.5000)
layout:setTopMargin(-65.0000)
layout:setBottomMargin(-39.0000)
Node:addChild(imgBack)

--Create imgPlaying
local imgPlaying = cc.Sprite:create("game/errentexaspoker_std/resource/image/zz2.png")
imgPlaying:setName("imgPlaying")
imgPlaying:setTag(680)
imgPlaying:setCascadeColorEnabled(true)
imgPlaying:setCascadeOpacityEnabled(true)
imgPlaying:setPosition(0.4398, 13.4398)
layout = ccui.LayoutComponent:bindLayoutComponent(imgPlaying)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(218.0000, 139.0000))
layout:setLeftMargin(-108.5602)
layout:setRightMargin(-109.4398)
layout:setTopMargin(-82.9398)
layout:setBottomMargin(-56.0602)
Node:addChild(imgPlaying)

--Create btnPlayer1
local btnPlayer1 = ccui.Button:create()
btnPlayer1:ignoreContentAdaptWithSize(false)
btnPlayer1:loadTextureNormal("game/errentexaspoker_std/resource/image/npc_2.png",0)
btnPlayer1:loadTextureDisabled("game/errentexaspoker_std/resource/image/npc_1.png",0)
btnPlayer1:setTitleFontSize(14)
btnPlayer1:setTitleColor(cc.c3b(65, 65, 70))
btnPlayer1:setScale9Enabled(true)
btnPlayer1:setCapInsets(cc.rect(0,0,35,35))
btnPlayer1:setLayoutComponentEnabled(true)
btnPlayer1:setName("btnPlayer1")
btnPlayer1:setTag(681)
btnPlayer1:setCascadeColorEnabled(true)
btnPlayer1:setCascadeOpacityEnabled(true)
btnPlayer1:setPosition(0.8011, 103.6745)
layout = ccui.LayoutComponent:bindLayoutComponent(btnPlayer1)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(35.0000, 35.0000))
layout:setLeftMargin(-16.6989)
layout:setRightMargin(-18.3011)
layout:setTopMargin(-121.1745)
layout:setBottomMargin(86.1745)
Node:addChild(btnPlayer1)

--Create name1
local name1 = ccui.Text:create()
name1:ignoreContentAdaptWithSize(true)
name1:setTextAreaSize(cc.size(0, 0))
name1:setFontName("lobby/resource/font/simhei.ttf")
name1:setFontSize(16)
name1:setString([[name]])
name1:setLayoutComponentEnabled(true)
name1:setName("name1")
name1:setTag(682)
name1:setCascadeColorEnabled(true)
name1:setCascadeOpacityEnabled(true)
name1:setPosition(20.0000, 51.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(name1)
layout:setPositionPercentX(0.5714)
layout:setPositionPercentY(1.4571)
layout:setPercentWidth(0.9143)
layout:setPercentHeight(0.5143)
layout:setSize(cc.size(32.0000, 18.0000))
layout:setLeftMargin(4.0000)
layout:setRightMargin(-1.0000)
layout:setTopMargin(-25.0000)
layout:setBottomMargin(42.0000)
btnPlayer1:addChild(name1)

--Create btnPlayer2
local btnPlayer2 = ccui.Button:create()
btnPlayer2:ignoreContentAdaptWithSize(false)
btnPlayer2:loadTextureNormal("game/errentexaspoker_std/resource/image/npc_2.png",0)
btnPlayer2:loadTextureDisabled("game/errentexaspoker_std/resource/image/npc_1.png",0)
btnPlayer2:setTitleFontSize(14)
btnPlayer2:setTitleColor(cc.c3b(65, 65, 70))
btnPlayer2:setScale9Enabled(true)
btnPlayer2:setCapInsets(cc.rect(0,0,35,35))
btnPlayer2:setLayoutComponentEnabled(true)
btnPlayer2:setName("btnPlayer2")
btnPlayer2:setTag(683)
btnPlayer2:setCascadeColorEnabled(true)
btnPlayer2:setCascadeOpacityEnabled(true)
btnPlayer2:setPosition(-1.4130, -71.4915)
layout = ccui.LayoutComponent:bindLayoutComponent(btnPlayer2)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(35.0000, 35.0000))
layout:setLeftMargin(-18.9130)
layout:setRightMargin(-16.0870)
layout:setTopMargin(53.9915)
layout:setBottomMargin(-88.9915)
Node:addChild(btnPlayer2)

--Create name2
local name2 = ccui.Text:create()
name2:ignoreContentAdaptWithSize(true)
name2:setTextAreaSize(cc.size(0, 0))
name2:setFontName("lobby/resource/font/simhei.ttf")
name2:setFontSize(16)
name2:setString([[name]])
name2:setLayoutComponentEnabled(true)
name2:setName("name2")
name2:setTag(684)
name2:setCascadeColorEnabled(true)
name2:setCascadeOpacityEnabled(true)
name2:setPosition(16.7331, -7.1494)
layout = ccui.LayoutComponent:bindLayoutComponent(name2)
layout:setPositionPercentX(0.4781)
layout:setPositionPercentY(-0.2043)
layout:setPercentWidth(0.9143)
layout:setPercentHeight(0.5143)
layout:setSize(cc.size(32.0000, 18.0000))
layout:setLeftMargin(0.7331)
layout:setRightMargin(2.2669)
layout:setTopMargin(33.1494)
layout:setBottomMargin(-16.1494)
btnPlayer2:addChild(name2)

--Create imgRead1
local imgRead1 = cc.Sprite:create("game/errentexaspoker_std/resource/image/zb.png")
imgRead1:setName("imgRead1")
imgRead1:setTag(697)
imgRead1:setCascadeColorEnabled(true)
imgRead1:setCascadeOpacityEnabled(true)
imgRead1:setPosition(-2.0533, 65.5615)
layout = ccui.LayoutComponent:bindLayoutComponent(imgRead1)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(12.0000, 14.0000))
layout:setLeftMargin(-8.0533)
layout:setRightMargin(-3.9467)
layout:setTopMargin(-72.5615)
layout:setBottomMargin(58.5615)
Node:addChild(imgRead1)

--Create imgRead2
local imgRead2 = cc.Sprite:create("game/errentexaspoker_std/resource/image/zb.png")
imgRead2:setName("imgRead2")
imgRead2:setTag(698)
imgRead2:setCascadeColorEnabled(true)
imgRead2:setCascadeOpacityEnabled(true)
imgRead2:setPosition(-1.0349, -29.9998)
layout = ccui.LayoutComponent:bindLayoutComponent(imgRead2)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(12.0000, 14.0000))
layout:setLeftMargin(-7.0349)
layout:setRightMargin(-4.9651)
layout:setTopMargin(22.9998)
layout:setBottomMargin(-36.9998)
Node:addChild(imgRead2)

--Create imgLock
local imgLock = cc.Sprite:create("game/errentexaspoker_std/resource/image/suo.png")
imgLock:setName("imgLock")
imgLock:setTag(705)
imgLock:setCascadeColorEnabled(true)
imgLock:setCascadeOpacityEnabled(true)
imgLock:setPosition(-41.0000, -116.5602)
layout = ccui.LayoutComponent:bindLayoutComponent(imgLock)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(10.0000, 14.0000))
layout:setLeftMargin(-46.0000)
layout:setRightMargin(36.0000)
layout:setTopMargin(109.5602)
layout:setBottomMargin(-123.5602)
Node:addChild(imgLock)

--Create labTableID
local labTableID = ccui.Text:create()
labTableID:ignoreContentAdaptWithSize(true)
labTableID:setTextAreaSize(cc.size(0, 0))
labTableID:setFontName("lobby/resource/font/simhei.ttf")
labTableID:setFontSize(20)
labTableID:setString([[- 8 -]])
labTableID:setLayoutComponentEnabled(true)
labTableID:setName("labTableID")
labTableID:setTag(706)
labTableID:setCascadeColorEnabled(true)
labTableID:setCascadeOpacityEnabled(true)
labTableID:setPosition(0.0000, -117.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(labTableID)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(50.0000, 23.0000))
layout:setLeftMargin(-25.0000)
layout:setRightMargin(-25.0000)
layout:setTopMargin(105.5000)
layout:setBottomMargin(-128.5000)
Node:addChild(labTableID)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result
