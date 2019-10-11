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

--Create bg
local bg = ccui.ImageView:create()
bg:ignoreContentAdaptWithSize(false)
bg:loadTexture("game/shuihu_std/resource/image/loading/BG_3.PNG",0)
bg:setLayoutComponentEnabled(true)
bg:setName("bg")
bg:setTag(4)
bg:setCascadeColorEnabled(true)
bg:setCascadeOpacityEnabled(true)
bg:setPosition(0.0000, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(bg)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(1920.0000, 1080.0000))
layout:setLeftMargin(-960.0000)
layout:setRightMargin(-960.0000)
layout:setTopMargin(-540.0000)
layout:setBottomMargin(-540.0000)
Node:addChild(bg)

--Create bg_loading
local bg_loading = ccui.ImageView:create()
bg_loading:ignoreContentAdaptWithSize(false)
bg_loading:loadTexture("game/shuihu_std/resource/image/loading/loadingbg.png",0)
bg_loading:setLayoutComponentEnabled(true)
bg_loading:setName("bg_loading")
bg_loading:setTag(8)
bg_loading:setCascadeColorEnabled(true)
bg_loading:setCascadeOpacityEnabled(true)
bg_loading:setPosition(0.0000, -400.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(bg_loading)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(1168.0000, 62.0000))
layout:setLeftMargin(-584.0000)
layout:setRightMargin(-584.0000)
layout:setTopMargin(369.0000)
layout:setBottomMargin(-431.0000)
Node:addChild(bg_loading)

--Create LoadingBar_1
local LoadingBar_1 = ccui.LoadingBar:create()
LoadingBar_1:loadTexture("game/shuihu_std/resource/image/loading/loading.png",0)
LoadingBar_1:ignoreContentAdaptWithSize(false)
LoadingBar_1:setLayoutComponentEnabled(true)
LoadingBar_1:setName("LoadingBar_1")
LoadingBar_1:setTag(9)
LoadingBar_1:setCascadeColorEnabled(true)
LoadingBar_1:setCascadeOpacityEnabled(true)
LoadingBar_1:setPosition(584.0000, 32.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(LoadingBar_1)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5161)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(1.0000)
layout:setSize(cc.size(1168.0000, 62.0000))
layout:setLeftMargin(0.0000)
layout:setRightMargin(0.0000)
layout:setTopMargin(-1.0000)
layout:setBottomMargin(1.0000)
bg_loading:addChild(LoadingBar_1)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result
