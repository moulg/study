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

--Create ImgCBg
local ImgCBg = ccui.ImageView:create()
ImgCBg:ignoreContentAdaptWithSize(false)
ImgCBg:loadTexture("game/weishuwu_std/resource/image/bgk.png",0)
ImgCBg:setLayoutComponentEnabled(true)
ImgCBg:setName("ImgCBg")
ImgCBg:setTag(189)
ImgCBg:setCascadeColorEnabled(true)
ImgCBg:setCascadeOpacityEnabled(true)
ImgCBg:setPosition(2025.0000, 540.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(ImgCBg)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(390.0000, 460.0000))
layout:setLeftMargin(1830.0000)
layout:setRightMargin(-2220.0000)
layout:setTopMargin(-770.0000)
layout:setBottomMargin(310.0000)
Node:addChild(ImgCBg)

--Create Btn_caidan
local Btn_caidan = ccui.Button:create()
Btn_caidan:ignoreContentAdaptWithSize(false)
Btn_caidan:loadTextureNormal("game/weishuwu_std/resource/button/sanjiao.png",0)
Btn_caidan:setTitleFontSize(14)
Btn_caidan:setTitleColor(cc.c3b(65, 65, 70))
Btn_caidan:setScale9Enabled(true)
Btn_caidan:setCapInsets(cc.rect(15,11,42,123))
Btn_caidan:setLayoutComponentEnabled(true)
Btn_caidan:setName("Btn_caidan")
Btn_caidan:setTag(190)
Btn_caidan:setCascadeColorEnabled(true)
Btn_caidan:setCascadeOpacityEnabled(true)
Btn_caidan:setPosition(61.0000, 237.7018)
Btn_caidan:setScaleX(0.9000)
Btn_caidan:setScaleY(0.9000)
layout = ccui.LayoutComponent:bindLayoutComponent(Btn_caidan)
layout:setPositionPercentX(0.1564)
layout:setPositionPercentY(0.5167)
layout:setSize(cc.size(72.0000, 145.0000))
layout:setLeftMargin(25.0000)
layout:setRightMargin(293.0000)
layout:setTopMargin(149.7982)
layout:setBottomMargin(165.2018)
ImgCBg:addChild(Btn_caidan)

--Create Btn_shezhi
local Btn_shezhi = ccui.Button:create()
Btn_shezhi:ignoreContentAdaptWithSize(false)
Btn_shezhi:loadTextureNormal("game/weishuwu_std/resource/button/shezhi.png",0)
Btn_shezhi:setTitleFontSize(14)
Btn_shezhi:setTitleColor(cc.c3b(65, 65, 70))
Btn_shezhi:setScale9Enabled(true)
Btn_shezhi:setCapInsets(cc.rect(15,11,241,116))
Btn_shezhi:setLayoutComponentEnabled(true)
Btn_shezhi:setName("Btn_shezhi")
Btn_shezhi:setTag(191)
Btn_shezhi:setCascadeColorEnabled(true)
Btn_shezhi:setCascadeOpacityEnabled(true)
Btn_shezhi:setPosition(242.1698, 373.1435)
layout = ccui.LayoutComponent:bindLayoutComponent(Btn_shezhi)
layout:setPositionPercentX(0.6209)
layout:setPositionPercentY(0.8112)
layout:setSize(cc.size(271.0000, 138.0000))
layout:setLeftMargin(106.6698)
layout:setRightMargin(12.3302)
layout:setTopMargin(17.8565)
layout:setBottomMargin(304.1435)
ImgCBg:addChild(Btn_shezhi)

--Create Btn_lvdan
local Btn_lvdan = ccui.Button:create()
Btn_lvdan:ignoreContentAdaptWithSize(false)
Btn_lvdan:loadTextureNormal("game/weishuwu_std/resource/button/ludan.png",0)
Btn_lvdan:setTitleFontSize(14)
Btn_lvdan:setTitleColor(cc.c3b(65, 65, 70))
Btn_lvdan:setScale9Enabled(true)
Btn_lvdan:setCapInsets(cc.rect(15,11,241,116))
Btn_lvdan:setLayoutComponentEnabled(true)
Btn_lvdan:setName("Btn_lvdan")
Btn_lvdan:setTag(192)
Btn_lvdan:setCascadeColorEnabled(true)
Btn_lvdan:setCascadeOpacityEnabled(true)
Btn_lvdan:setPosition(242.1698, 235.2876)
layout = ccui.LayoutComponent:bindLayoutComponent(Btn_lvdan)
layout:setPositionPercentX(0.6209)
layout:setPositionPercentY(0.5115)
layout:setSize(cc.size(271.0000, 138.0000))
layout:setLeftMargin(106.6698)
layout:setRightMargin(12.3302)
layout:setTopMargin(155.7124)
layout:setBottomMargin(166.2876)
ImgCBg:addChild(Btn_lvdan)

--Create Btn_tuichu
local Btn_tuichu = ccui.Button:create()
Btn_tuichu:ignoreContentAdaptWithSize(false)
Btn_tuichu:loadTextureNormal("game/weishuwu_std/resource/button/tuichu.png",0)
Btn_tuichu:setTitleFontSize(14)
Btn_tuichu:setTitleColor(cc.c3b(65, 65, 70))
Btn_tuichu:setScale9Enabled(true)
Btn_tuichu:setCapInsets(cc.rect(15,11,241,116))
Btn_tuichu:setLayoutComponentEnabled(true)
Btn_tuichu:setName("Btn_tuichu")
Btn_tuichu:setTag(193)
Btn_tuichu:setCascadeColorEnabled(true)
Btn_tuichu:setCascadeOpacityEnabled(true)
Btn_tuichu:setPosition(242.1698, 97.3639)
layout = ccui.LayoutComponent:bindLayoutComponent(Btn_tuichu)
layout:setPositionPercentX(0.6209)
layout:setPositionPercentY(0.2117)
layout:setSize(cc.size(271.0000, 138.0000))
layout:setLeftMargin(106.6698)
layout:setRightMargin(12.3302)
layout:setTopMargin(293.6361)
layout:setBottomMargin(28.3639)
ImgCBg:addChild(Btn_tuichu)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result

