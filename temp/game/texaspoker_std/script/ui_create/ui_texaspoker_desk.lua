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
local imgBack = cc.Sprite:create("game/texaspoker_std/resource/image/zuoziNo.png")
imgBack:setName("imgBack")
imgBack:setTag(23)
imgBack:setCascadeColorEnabled(true)
imgBack:setCascadeOpacityEnabled(true)
imgBack:setPosition(0.0000, 13.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgBack)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(235.0000, 104.0000))
layout:setLeftMargin(-117.5000)
layout:setRightMargin(-117.5000)
layout:setTopMargin(-65.0000)
layout:setBottomMargin(-39.0000)
Node:addChild(imgBack)

--Create imgPlaying
local imgPlaying = cc.Sprite:create("game/texaspoker_std/resource/image/zuozi3.png")
imgPlaying:setName("imgPlaying")
imgPlaying:setTag(24)
imgPlaying:setCascadeColorEnabled(true)
imgPlaying:setCascadeOpacityEnabled(true)
imgPlaying:setPosition(0.0000, 13.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgPlaying)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(136.0000, 38.0000))
layout:setLeftMargin(-68.0000)
layout:setRightMargin(-68.0000)
layout:setTopMargin(-32.0000)
layout:setBottomMargin(-6.0000)
Node:addChild(imgPlaying)

--Create btnPlayer1
local btnPlayer1 = ccui.Button:create()
btnPlayer1:ignoreContentAdaptWithSize(false)
btnPlayer1:loadTextureNormal("game/texaspoker_std/resource/image/npc_2.png",0)
btnPlayer1:loadTextureDisabled("game/texaspoker_std/resource/image/npc_1.png",0)
btnPlayer1:setTitleFontSize(14)
btnPlayer1:setTitleColor(cc.c3b(65, 65, 70))
btnPlayer1:setScale9Enabled(true)
btnPlayer1:setCapInsets(cc.rect(0,0,35,35))
btnPlayer1:setLayoutComponentEnabled(true)
btnPlayer1:setName("btnPlayer1")
btnPlayer1:setTag(35)
btnPlayer1:setCascadeColorEnabled(true)
btnPlayer1:setCascadeOpacityEnabled(true)
btnPlayer1:setPosition(-52.7724, 84.0745)
layout = ccui.LayoutComponent:bindLayoutComponent(btnPlayer1)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(35.0000, 35.0000))
layout:setLeftMargin(-70.2724)
layout:setRightMargin(35.2724)
layout:setTopMargin(-101.5745)
layout:setBottomMargin(66.5745)
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
name1:setTag(36)
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
btnPlayer2:loadTextureNormal("game/texaspoker_std/resource/image/npc_2.png",0)
btnPlayer2:loadTextureDisabled("game/texaspoker_std/resource/image/npc_1.png",0)
btnPlayer2:setTitleFontSize(14)
btnPlayer2:setTitleColor(cc.c3b(65, 65, 70))
btnPlayer2:setScale9Enabled(true)
btnPlayer2:setCapInsets(cc.rect(0,0,35,35))
btnPlayer2:setLayoutComponentEnabled(true)
btnPlayer2:setName("btnPlayer2")
btnPlayer2:setTag(20)
btnPlayer2:setCascadeColorEnabled(true)
btnPlayer2:setCascadeOpacityEnabled(true)
btnPlayer2:setPosition(-130.7721, 48.0745)
layout = ccui.LayoutComponent:bindLayoutComponent(btnPlayer2)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(35.0000, 35.0000))
layout:setLeftMargin(-148.2721)
layout:setRightMargin(113.2721)
layout:setTopMargin(-65.5745)
layout:setBottomMargin(30.5745)
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
name2:setTag(19)
name2:setCascadeColorEnabled(true)
name2:setCascadeOpacityEnabled(true)
name2:setPosition(20.0000, 51.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(name2)
layout:setPositionPercentX(0.5714)
layout:setPositionPercentY(1.4571)
layout:setPercentWidth(0.9143)
layout:setPercentHeight(0.5143)
layout:setSize(cc.size(32.0000, 18.0000))
layout:setLeftMargin(4.0000)
layout:setRightMargin(-1.0000)
layout:setTopMargin(-25.0000)
layout:setBottomMargin(42.0000)
btnPlayer2:addChild(name2)

--Create btnPlayer3
local btnPlayer3 = ccui.Button:create()
btnPlayer3:ignoreContentAdaptWithSize(false)
btnPlayer3:loadTextureNormal("game/texaspoker_std/resource/image/npc_2.png",0)
btnPlayer3:loadTextureDisabled("game/texaspoker_std/resource/image/npc_1.png",0)
btnPlayer3:setTitleFontSize(14)
btnPlayer3:setTitleColor(cc.c3b(65, 65, 70))
btnPlayer3:setScale9Enabled(true)
btnPlayer3:setCapInsets(cc.rect(0,0,35,35))
btnPlayer3:setLayoutComponentEnabled(true)
btnPlayer3:setName("btnPlayer3")
btnPlayer3:setTag(41)
btnPlayer3:setCascadeColorEnabled(true)
btnPlayer3:setCascadeOpacityEnabled(true)
btnPlayer3:setPosition(-130.7723, -17.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnPlayer3)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(35.0000, 35.0000))
layout:setLeftMargin(-148.2723)
layout:setRightMargin(113.2723)
layout:setTopMargin(-0.5000)
layout:setBottomMargin(-34.5000)
Node:addChild(btnPlayer3)

--Create name3
local name3 = ccui.Text:create()
name3:ignoreContentAdaptWithSize(true)
name3:setTextAreaSize(cc.size(0, 0))
name3:setFontName("lobby/resource/font/simhei.ttf")
name3:setFontSize(16)
name3:setString([[name]])
name3:setLayoutComponentEnabled(true)
name3:setName("name3")
name3:setTag(42)
name3:setCascadeColorEnabled(true)
name3:setCascadeOpacityEnabled(true)
name3:setPosition(18.0000, -11.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(name3)
layout:setPositionPercentX(0.5143)
layout:setPositionPercentY(-0.3143)
layout:setPercentWidth(0.9143)
layout:setPercentHeight(0.5143)
layout:setSize(cc.size(32.0000, 18.0000))
layout:setLeftMargin(2.0000)
layout:setRightMargin(1.0000)
layout:setTopMargin(37.0000)
layout:setBottomMargin(-20.0000)
btnPlayer3:addChild(name3)

--Create btnPlayer4
local btnPlayer4 = ccui.Button:create()
btnPlayer4:ignoreContentAdaptWithSize(false)
btnPlayer4:loadTextureNormal("game/texaspoker_std/resource/image/npc_2.png",0)
btnPlayer4:loadTextureDisabled("game/texaspoker_std/resource/image/npc_1.png",0)
btnPlayer4:setTitleFontSize(14)
btnPlayer4:setTitleColor(cc.c3b(65, 65, 70))
btnPlayer4:setScale9Enabled(true)
btnPlayer4:setCapInsets(cc.rect(0,0,35,35))
btnPlayer4:setLayoutComponentEnabled(true)
btnPlayer4:setName("btnPlayer4")
btnPlayer4:setTag(43)
btnPlayer4:setCascadeColorEnabled(true)
btnPlayer4:setCascadeOpacityEnabled(true)
btnPlayer4:setPosition(-54.0000, -57.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnPlayer4)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(35.0000, 35.0000))
layout:setLeftMargin(-71.5000)
layout:setRightMargin(36.5000)
layout:setTopMargin(39.5000)
layout:setBottomMargin(-74.5000)
Node:addChild(btnPlayer4)

--Create name4
local name4 = ccui.Text:create()
name4:ignoreContentAdaptWithSize(true)
name4:setTextAreaSize(cc.size(0, 0))
name4:setFontName("lobby/resource/font/simhei.ttf")
name4:setFontSize(16)
name4:setString([[name]])
name4:setLayoutComponentEnabled(true)
name4:setName("name4")
name4:setTag(44)
name4:setCascadeColorEnabled(true)
name4:setCascadeOpacityEnabled(true)
name4:setPosition(17.0000, -11.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(name4)
layout:setPositionPercentX(0.4857)
layout:setPositionPercentY(-0.3143)
layout:setPercentWidth(0.9143)
layout:setPercentHeight(0.5143)
layout:setSize(cc.size(32.0000, 18.0000))
layout:setLeftMargin(1.0000)
layout:setRightMargin(2.0000)
layout:setTopMargin(37.0000)
layout:setBottomMargin(-20.0000)
btnPlayer4:addChild(name4)

--Create btnPlayer5
local btnPlayer5 = ccui.Button:create()
btnPlayer5:ignoreContentAdaptWithSize(false)
btnPlayer5:loadTextureNormal("game/texaspoker_std/resource/image/npc_2.png",0)
btnPlayer5:loadTextureDisabled("game/texaspoker_std/resource/image/npc_1.png",0)
btnPlayer5:setTitleFontSize(14)
btnPlayer5:setTitleColor(cc.c3b(65, 65, 70))
btnPlayer5:setScale9Enabled(true)
btnPlayer5:setCapInsets(cc.rect(0,0,35,35))
btnPlayer5:setLayoutComponentEnabled(true)
btnPlayer5:setName("btnPlayer5")
btnPlayer5:setTag(45)
btnPlayer5:setCascadeColorEnabled(true)
btnPlayer5:setCascadeOpacityEnabled(true)
btnPlayer5:setPosition(43.0001, -57.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnPlayer5)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(35.0000, 35.0000))
layout:setLeftMargin(25.5001)
layout:setRightMargin(-60.5001)
layout:setTopMargin(39.5000)
layout:setBottomMargin(-74.5000)
Node:addChild(btnPlayer5)

--Create name5
local name5 = ccui.Text:create()
name5:ignoreContentAdaptWithSize(true)
name5:setTextAreaSize(cc.size(0, 0))
name5:setFontName("lobby/resource/font/simhei.ttf")
name5:setFontSize(16)
name5:setString([[name]])
name5:setLayoutComponentEnabled(true)
name5:setName("name5")
name5:setTag(46)
name5:setCascadeColorEnabled(true)
name5:setCascadeOpacityEnabled(true)
name5:setPosition(17.0000, -11.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(name5)
layout:setPositionPercentX(0.4857)
layout:setPositionPercentY(-0.3143)
layout:setPercentWidth(0.9143)
layout:setPercentHeight(0.5143)
layout:setSize(cc.size(32.0000, 18.0000))
layout:setLeftMargin(1.0000)
layout:setRightMargin(2.0000)
layout:setTopMargin(37.0000)
layout:setBottomMargin(-20.0000)
btnPlayer5:addChild(name5)

--Create btnPlayer6
local btnPlayer6 = ccui.Button:create()
btnPlayer6:ignoreContentAdaptWithSize(false)
btnPlayer6:loadTextureNormal("game/texaspoker_std/resource/image/npc_2.png",0)
btnPlayer6:loadTextureDisabled("game/texaspoker_std/resource/image/npc_1.png",0)
btnPlayer6:setTitleFontSize(14)
btnPlayer6:setTitleColor(cc.c3b(65, 65, 70))
btnPlayer6:setScale9Enabled(true)
btnPlayer6:setCapInsets(cc.rect(0,0,35,35))
btnPlayer6:setLayoutComponentEnabled(true)
btnPlayer6:setName("btnPlayer6")
btnPlayer6:setTag(47)
btnPlayer6:setCascadeColorEnabled(true)
btnPlayer6:setCascadeOpacityEnabled(true)
btnPlayer6:setPosition(129.2276, -17.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btnPlayer6)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(35.0000, 35.0000))
layout:setLeftMargin(111.7276)
layout:setRightMargin(-146.7276)
layout:setTopMargin(-0.5000)
layout:setBottomMargin(-34.5000)
Node:addChild(btnPlayer6)

--Create name6
local name6 = ccui.Text:create()
name6:ignoreContentAdaptWithSize(true)
name6:setTextAreaSize(cc.size(0, 0))
name6:setFontName("lobby/resource/font/simhei.ttf")
name6:setFontSize(16)
name6:setString([[name]])
name6:setLayoutComponentEnabled(true)
name6:setName("name6")
name6:setTag(48)
name6:setCascadeColorEnabled(true)
name6:setCascadeOpacityEnabled(true)
name6:setPosition(17.0000, -11.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(name6)
layout:setPositionPercentX(0.4857)
layout:setPositionPercentY(-0.3143)
layout:setPercentWidth(0.9143)
layout:setPercentHeight(0.5143)
layout:setSize(cc.size(32.0000, 18.0000))
layout:setLeftMargin(1.0000)
layout:setRightMargin(2.0000)
layout:setTopMargin(37.0000)
layout:setBottomMargin(-20.0000)
btnPlayer6:addChild(name6)

--Create btnPlayer7
local btnPlayer7 = ccui.Button:create()
btnPlayer7:ignoreContentAdaptWithSize(false)
btnPlayer7:loadTextureNormal("game/texaspoker_std/resource/image/npc_2.png",0)
btnPlayer7:loadTextureDisabled("game/texaspoker_std/resource/image/npc_1.png",0)
btnPlayer7:setTitleFontSize(14)
btnPlayer7:setTitleColor(cc.c3b(65, 65, 70))
btnPlayer7:setScale9Enabled(true)
btnPlayer7:setCapInsets(cc.rect(0,0,35,35))
btnPlayer7:setLayoutComponentEnabled(true)
btnPlayer7:setName("btnPlayer7")
btnPlayer7:setTag(39)
btnPlayer7:setCascadeColorEnabled(true)
btnPlayer7:setCascadeOpacityEnabled(true)
btnPlayer7:setPosition(129.2278, 48.0745)
layout = ccui.LayoutComponent:bindLayoutComponent(btnPlayer7)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(35.0000, 35.0000))
layout:setLeftMargin(111.7278)
layout:setRightMargin(-146.7278)
layout:setTopMargin(-65.5745)
layout:setBottomMargin(30.5745)
Node:addChild(btnPlayer7)

--Create name7
local name7 = ccui.Text:create()
name7:ignoreContentAdaptWithSize(true)
name7:setTextAreaSize(cc.size(0, 0))
name7:setFontName("lobby/resource/font/simhei.ttf")
name7:setFontSize(16)
name7:setString([[name]])
name7:setLayoutComponentEnabled(true)
name7:setName("name7")
name7:setTag(40)
name7:setCascadeColorEnabled(true)
name7:setCascadeOpacityEnabled(true)
name7:setPosition(20.0000, 51.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(name7)
layout:setPositionPercentX(0.5714)
layout:setPositionPercentY(1.4571)
layout:setPercentWidth(0.9143)
layout:setPercentHeight(0.5143)
layout:setSize(cc.size(32.0000, 18.0000))
layout:setLeftMargin(4.0000)
layout:setRightMargin(-1.0000)
layout:setTopMargin(-25.0000)
layout:setBottomMargin(42.0000)
btnPlayer7:addChild(name7)

--Create btnPlayer8
local btnPlayer8 = ccui.Button:create()
btnPlayer8:ignoreContentAdaptWithSize(false)
btnPlayer8:loadTextureNormal("game/texaspoker_std/resource/image/npc_2.png",0)
btnPlayer8:loadTextureDisabled("game/texaspoker_std/resource/image/npc_1.png",0)
btnPlayer8:setTitleFontSize(14)
btnPlayer8:setTitleColor(cc.c3b(65, 65, 70))
btnPlayer8:setScale9Enabled(true)
btnPlayer8:setCapInsets(cc.rect(0,0,35,35))
btnPlayer8:setLayoutComponentEnabled(true)
btnPlayer8:setName("btnPlayer8")
btnPlayer8:setTag(37)
btnPlayer8:setCascadeColorEnabled(true)
btnPlayer8:setCascadeOpacityEnabled(true)
btnPlayer8:setPosition(41.2276, 84.0745)
layout = ccui.LayoutComponent:bindLayoutComponent(btnPlayer8)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(35.0000, 35.0000))
layout:setLeftMargin(23.7276)
layout:setRightMargin(-58.7276)
layout:setTopMargin(-101.5745)
layout:setBottomMargin(66.5745)
Node:addChild(btnPlayer8)

--Create name8
local name8 = ccui.Text:create()
name8:ignoreContentAdaptWithSize(true)
name8:setTextAreaSize(cc.size(0, 0))
name8:setFontName("lobby/resource/font/simhei.ttf")
name8:setFontSize(16)
name8:setString([[name]])
name8:setLayoutComponentEnabled(true)
name8:setName("name8")
name8:setTag(38)
name8:setCascadeColorEnabled(true)
name8:setCascadeOpacityEnabled(true)
name8:setPosition(20.0000, 51.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(name8)
layout:setPositionPercentX(0.5714)
layout:setPositionPercentY(1.4571)
layout:setPercentWidth(0.9143)
layout:setPercentHeight(0.5143)
layout:setSize(cc.size(32.0000, 18.0000))
layout:setLeftMargin(4.0000)
layout:setRightMargin(-1.0000)
layout:setTopMargin(-25.0000)
layout:setBottomMargin(42.0000)
btnPlayer8:addChild(name8)

--Create imgRead1
local imgRead1 = cc.Sprite:create("game/texaspoker_std/resource/image/zb.png")
imgRead1:setName("imgRead1")
imgRead1:setTag(80)
imgRead1:setCascadeColorEnabled(true)
imgRead1:setCascadeOpacityEnabled(true)
imgRead1:setPosition(-54.0528, 46.5613)
layout = ccui.LayoutComponent:bindLayoutComponent(imgRead1)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(12.0000, 14.0000))
layout:setLeftMargin(-60.0528)
layout:setRightMargin(48.0528)
layout:setTopMargin(-53.5613)
layout:setBottomMargin(39.5613)
Node:addChild(imgRead1)

--Create imgRead2
local imgRead2 = cc.Sprite:create("game/texaspoker_std/resource/image/zb.png")
imgRead2:setName("imgRead2")
imgRead2:setTag(79)
imgRead2:setCascadeColorEnabled(true)
imgRead2:setCascadeOpacityEnabled(true)
imgRead2:setPosition(-91.0338, 33.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgRead2)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(12.0000, 14.0000))
layout:setLeftMargin(-97.0338)
layout:setRightMargin(85.0338)
layout:setTopMargin(-40.0000)
layout:setBottomMargin(26.0000)
Node:addChild(imgRead2)

--Create imgRead8
local imgRead8 = cc.Sprite:create("game/texaspoker_std/resource/image/zb.png")
imgRead8:setName("imgRead8")
imgRead8:setTag(81)
imgRead8:setCascadeColorEnabled(true)
imgRead8:setCascadeOpacityEnabled(true)
imgRead8:setPosition(41.6835, 48.6491)
layout = ccui.LayoutComponent:bindLayoutComponent(imgRead8)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(12.0000, 14.0000))
layout:setLeftMargin(35.6835)
layout:setRightMargin(-47.6835)
layout:setTopMargin(-55.6491)
layout:setBottomMargin(41.6491)
Node:addChild(imgRead8)

--Create imgRead7
local imgRead7 = cc.Sprite:create("game/texaspoker_std/resource/image/zb.png")
imgRead7:setName("imgRead7")
imgRead7:setTag(82)
imgRead7:setCascadeColorEnabled(true)
imgRead7:setCascadeOpacityEnabled(true)
imgRead7:setPosition(90.2973, 33.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgRead7)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(12.0000, 14.0000))
layout:setLeftMargin(84.2973)
layout:setRightMargin(-96.2973)
layout:setTopMargin(-40.0000)
layout:setBottomMargin(26.0000)
Node:addChild(imgRead7)

--Create imgRead6
local imgRead6 = cc.Sprite:create("game/texaspoker_std/resource/image/zb.png")
imgRead6:setName("imgRead6")
imgRead6:setTag(83)
imgRead6:setCascadeColorEnabled(true)
imgRead6:setCascadeOpacityEnabled(true)
imgRead6:setPosition(90.2973, -2.6481)
layout = ccui.LayoutComponent:bindLayoutComponent(imgRead6)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(12.0000, 14.0000))
layout:setLeftMargin(84.2973)
layout:setRightMargin(-96.2973)
layout:setTopMargin(-4.3519)
layout:setBottomMargin(-9.6481)
Node:addChild(imgRead6)

--Create imgRead5
local imgRead5 = cc.Sprite:create("game/texaspoker_std/resource/image/zb.png")
imgRead5:setName("imgRead5")
imgRead5:setTag(84)
imgRead5:setCascadeColorEnabled(true)
imgRead5:setCascadeOpacityEnabled(true)
imgRead5:setPosition(41.6835, -16.3672)
layout = ccui.LayoutComponent:bindLayoutComponent(imgRead5)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(12.0000, 14.0000))
layout:setLeftMargin(35.6835)
layout:setRightMargin(-47.6835)
layout:setTopMargin(9.3672)
layout:setBottomMargin(-23.3672)
Node:addChild(imgRead5)

--Create imgRead4
local imgRead4 = cc.Sprite:create("game/texaspoker_std/resource/image/zb.png")
imgRead4:setName("imgRead4")
imgRead4:setTag(85)
imgRead4:setCascadeColorEnabled(true)
imgRead4:setCascadeOpacityEnabled(true)
imgRead4:setPosition(-54.0528, -16.0686)
layout = ccui.LayoutComponent:bindLayoutComponent(imgRead4)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(12.0000, 14.0000))
layout:setLeftMargin(-60.0528)
layout:setRightMargin(48.0528)
layout:setTopMargin(9.0686)
layout:setBottomMargin(-23.0686)
Node:addChild(imgRead4)

--Create imgRead3
local imgRead3 = cc.Sprite:create("game/texaspoker_std/resource/image/zb.png")
imgRead3:setName("imgRead3")
imgRead3:setTag(86)
imgRead3:setCascadeColorEnabled(true)
imgRead3:setCascadeOpacityEnabled(true)
imgRead3:setPosition(-91.0338, -2.6481)
layout = ccui.LayoutComponent:bindLayoutComponent(imgRead3)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(12.0000, 14.0000))
layout:setLeftMargin(-97.0338)
layout:setRightMargin(85.0338)
layout:setTopMargin(-4.3519)
layout:setBottomMargin(-9.6481)
Node:addChild(imgRead3)

--Create imgLock
local imgLock = cc.Sprite:create("game/texaspoker_std/resource/image/suo.png")
imgLock:setName("imgLock")
imgLock:setTag(64)
imgLock:setCascadeColorEnabled(true)
imgLock:setCascadeOpacityEnabled(true)
imgLock:setPosition(-41.0000, -117.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(imgLock)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(10.0000, 14.0000))
layout:setLeftMargin(-46.0000)
layout:setRightMargin(36.0000)
layout:setTopMargin(110.0000)
layout:setBottomMargin(-124.0000)
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
labTableID:setTag(65)
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

