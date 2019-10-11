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
local sprBack = cc.Sprite:create("game/niuniu_std/resource/image/changeBj.png")
sprBack:setName("sprBack")
sprBack:setTag(122)
sprBack:setCascadeColorEnabled(true)
sprBack:setCascadeOpacityEnabled(true)
sprBack:setPosition(0.0000, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sprBack)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(408.0000, 541.0000))
layout:setLeftMargin(-204.0000)
layout:setRightMargin(-204.0000)
layout:setTopMargin(-270.0000)
layout:setBottomMargin(-270.0000)
Node:addChild(sprBack)

--Create btnAddChips
local btnAddChips = ccui.Button:create()
btnAddChips:ignoreContentAdaptWithSize(false)
btnAddChips:loadTextureNormal("game/niuniu_std/resource/button/change_chips.png",0)
btnAddChips:setTitleFontSize(14)
btnAddChips:setTitleColor(cc.c3b(65, 65, 70))
btnAddChips:setScale9Enabled(true)
btnAddChips:setCapInsets(cc.rect(15,11,421,175))
btnAddChips:setLayoutComponentEnabled(true)
btnAddChips:setName("btnAddChips")
btnAddChips:setTag(123)
btnAddChips:setCascadeColorEnabled(true)
btnAddChips:setCascadeOpacityEnabled(true)
btnAddChips:setPosition(-4.9762, 90.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnAddChips)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(302.0000, 111.0000))
layout:setLeftMargin(-115.4762)
layout:setRightMargin(-110.5238)
layout:setTopMargin(-370.7095)
layout:setBottomMargin(173.7095)
Node:addChild(btnAddChips)

--Create btnReduceChips
local btnReduceChips = ccui.Button:create()
btnReduceChips:ignoreContentAdaptWithSize(false)
btnReduceChips:loadTextureNormal("game/niuniu_std/resource/button/change_gold.png",0)
btnReduceChips:setTitleFontSize(14)
btnReduceChips:setTitleColor(cc.c3b(65, 65, 70))
btnReduceChips:setScale9Enabled(true)
btnReduceChips:setCapInsets(cc.rect(15,11,421,175))
btnReduceChips:setLayoutComponentEnabled(true)
btnReduceChips:setName("btnReduceChips")
btnReduceChips:setTag(124)
btnReduceChips:setCascadeColorEnabled(true)
btnReduceChips:setCascadeOpacityEnabled(true)
btnReduceChips:setPosition(-4.9762, -50.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnReduceChips)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(302.0000, 111.0000))
layout:setLeftMargin(-230.4762)
layout:setRightMargin(-220.5238)
layout:setTopMargin(-47.3276)
layout:setBottomMargin(-149.6724)
Node:addChild(btnReduceChips)

--Create btnExchangeAll
local btnExchangeAll = ccui.Button:create()
btnExchangeAll:ignoreContentAdaptWithSize(false)
btnExchangeAll:loadTextureNormal("game/niuniu_std/resource/button/change_all.png",0)
btnExchangeAll:setTitleFontSize(14)
btnExchangeAll:setTitleColor(cc.c3b(65, 65, 70))
btnExchangeAll:setScale9Enabled(true)
btnExchangeAll:setCapInsets(cc.rect(15,11,421,175))
btnExchangeAll:setLayoutComponentEnabled(true)
btnExchangeAll:setName("btnExchangeAll")
btnExchangeAll:setTag(125)
btnExchangeAll:setCascadeColorEnabled(true)
btnExchangeAll:setCascadeOpacityEnabled(true)
btnExchangeAll:setPosition(-4.9762, -184.5541)
layout = ccui.LayoutComponent:bindLayoutComponent(btnExchangeAll)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(302.0000, 111.0000))
layout:setLeftMargin(-230.4762)
layout:setRightMargin(-220.5238)
layout:setTopMargin(176.0541)
layout:setBottomMargin(-373.0541)
Node:addChild(btnExchangeAll)

--Create btnClose
local btnClose = ccui.Button:create()
btnClose:ignoreContentAdaptWithSize(false)
btnClose:loadTextureNormal("game/niuniu_std/resource/button/btnClose.png",0)
btnClose:setTitleFontSize(14)
btnClose:setTitleColor(cc.c3b(65, 65, 70))
btnClose:setScale9Enabled(true)
btnClose:setCapInsets(cc.rect(15,11,141,148))
btnClose:setLayoutComponentEnabled(true)
btnClose:setName("btnClose")
btnClose:setTag(126)
btnClose:setCascadeColorEnabled(true)
btnClose:setCascadeOpacityEnabled(true)
btnClose:setPosition(200.1169, 266.9323)
layout = ccui.LayoutComponent:bindLayoutComponent(btnClose)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(93.0000, 95.0000))
layout:setLeftMargin(161.6169)
layout:setRightMargin(-332.6169)
layout:setTopMargin(-431.9323)
layout:setBottomMargin(261.9323)
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

