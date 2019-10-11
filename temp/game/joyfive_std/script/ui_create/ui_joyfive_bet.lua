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

--Create imgBetBg
local imgBetBg = cc.Sprite:create("game/joyfive_std/resource/image/bgx.png")
imgBetBg:setName("imgBetBg")
imgBetBg:setTag(238)
imgBetBg:setCascadeColorEnabled(true)
imgBetBg:setCascadeOpacityEnabled(true)
imgBetBg:setPosition(1302.4070, 283.5912)
layout = ccui.LayoutComponent:bindLayoutComponent(imgBetBg)
layout:setPositionPercentX(0.6783)
layout:setPositionPercentY(0.2626)
layout:setSize(cc.size(332.0000, 148.0000))
layout:setLeftMargin(1136.4070)
layout:setRightMargin(451.5933)
layout:setTopMargin(722.4088)
layout:setBottomMargin(209.5912)
Node:addChild(imgBetBg)

--Create btnGiveUp
local btnGiveUp = ccui.Button:create()
btnGiveUp:ignoreContentAdaptWithSize(false)
btnGiveUp:loadTextureNormal("game/joyfive_std/resource/button/fq1.png",0)
btnGiveUp:loadTexturePressed("game/joyfive_std/resource/button/fq3.png",0)
btnGiveUp:loadTextureDisabled("game/joyfive_std/resource/button/fq1.png",0)
btnGiveUp:setTitleFontSize(14)
btnGiveUp:setTitleColor(cc.c3b(65, 65, 70))
btnGiveUp:setScale9Enabled(true)
btnGiveUp:setCapInsets(cc.rect(15,11,66,22))
btnGiveUp:setLayoutComponentEnabled(true)
btnGiveUp:setName("btnGiveUp")
btnGiveUp:setTag(239)
btnGiveUp:setCascadeColorEnabled(true)
btnGiveUp:setCascadeOpacityEnabled(true)
btnGiveUp:setPosition(1406.5710, 306.0437)
layout = ccui.LayoutComponent:bindLayoutComponent(btnGiveUp)
layout:setPositionPercentX(0.7326)
layout:setPositionPercentY(0.2834)
layout:setPercentWidth(0.0500)
layout:setPercentHeight(0.0407)
layout:setSize(cc.size(96.0000, 44.0000))
layout:setLeftMargin(1358.5710)
layout:setRightMargin(465.4287)
layout:setTopMargin(751.9563)
layout:setBottomMargin(284.0437)
Node:addChild(btnGiveUp)

--Create btnBetAll
local btnBetAll = ccui.Button:create()
btnBetAll:ignoreContentAdaptWithSize(false)
btnBetAll:loadTextureNormal("game/joyfive_std/resource/button/qy1.png",0)
btnBetAll:loadTexturePressed("game/joyfive_std/resource/button/qy3.png",0)
btnBetAll:loadTextureDisabled("game/joyfive_std/resource/button/qy4.png",0)
btnBetAll:setTitleFontSize(14)
btnBetAll:setTitleColor(cc.c3b(65, 65, 70))
btnBetAll:setScale9Enabled(true)
btnBetAll:setCapInsets(cc.rect(15,11,66,22))
btnBetAll:setLayoutComponentEnabled(true)
btnBetAll:setName("btnBetAll")
btnBetAll:setTag(240)
btnBetAll:setCascadeColorEnabled(true)
btnBetAll:setCascadeOpacityEnabled(true)
btnBetAll:setPosition(1305.0700, 306.0437)
layout = ccui.LayoutComponent:bindLayoutComponent(btnBetAll)
layout:setPositionPercentX(0.6797)
layout:setPositionPercentY(0.2834)
layout:setPercentWidth(0.0500)
layout:setPercentHeight(0.0407)
layout:setSize(cc.size(96.0000, 44.0000))
layout:setLeftMargin(1257.0700)
layout:setRightMargin(566.9296)
layout:setTopMargin(751.9563)
layout:setBottomMargin(284.0437)
Node:addChild(btnBetAll)

--Create btnKeepBet
local btnKeepBet = ccui.Button:create()
btnKeepBet:ignoreContentAdaptWithSize(false)
btnKeepBet:loadTextureNormal("game/joyfive_std/resource/button/gl1.png",0)
btnKeepBet:loadTexturePressed("game/joyfive_std/resource/button/gl3.png",0)
btnKeepBet:loadTextureDisabled("game/joyfive_std/resource/button/gl4.png",0)
btnKeepBet:setTitleFontSize(14)
btnKeepBet:setTitleColor(cc.c3b(65, 65, 70))
btnKeepBet:setScale9Enabled(true)
btnKeepBet:setCapInsets(cc.rect(15,11,66,22))
btnKeepBet:setLayoutComponentEnabled(true)
btnKeepBet:setName("btnKeepBet")
btnKeepBet:setTag(241)
btnKeepBet:setCascadeColorEnabled(true)
btnKeepBet:setCascadeOpacityEnabled(true)
btnKeepBet:setPosition(1203.5700, 306.0437)
layout = ccui.LayoutComponent:bindLayoutComponent(btnKeepBet)
layout:setPositionPercentX(0.6269)
layout:setPositionPercentY(0.2834)
layout:setPercentWidth(0.0500)
layout:setPercentHeight(0.0407)
layout:setSize(cc.size(96.0000, 44.0000))
layout:setLeftMargin(1155.5700)
layout:setRightMargin(668.4304)
layout:setTopMargin(751.9563)
layout:setBottomMargin(284.0437)
Node:addChild(btnKeepBet)

--Create btnAddBet1
local btnAddBet1 = ccui.Button:create()
btnAddBet1:ignoreContentAdaptWithSize(false)
btnAddBet1:loadTextureNormal("game/joyfive_std/resource/button/lv1.png",0)
btnAddBet1:loadTexturePressed("game/joyfive_std/resource/button/lv3.png",0)
btnAddBet1:loadTextureDisabled("game/joyfive_std/resource/button/lv4.png",0)
btnAddBet1:setTitleFontSize(14)
btnAddBet1:setTitleColor(cc.c3b(65, 65, 70))
btnAddBet1:setScale9Enabled(true)
btnAddBet1:setCapInsets(cc.rect(15,11,66,22))
btnAddBet1:setLayoutComponentEnabled(true)
btnAddBet1:setName("btnAddBet1")
btnAddBet1:setTag(242)
btnAddBet1:setCascadeColorEnabled(true)
btnAddBet1:setCascadeOpacityEnabled(true)
btnAddBet1:setPosition(1202.4230, 249.1832)
layout = ccui.LayoutComponent:bindLayoutComponent(btnAddBet1)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(96.0000, 44.0000))
layout:setLeftMargin(1154.4230)
layout:setRightMargin(-1250.4230)
layout:setTopMargin(-271.1832)
layout:setBottomMargin(227.1832)
Node:addChild(btnAddBet1)

--Create fntAddBet1_gray
local fntAddBet1_gray = ccui.TextAtlas:create([[100]],
													"game/joyfive_std/resource/number/huinumber.png",
													17,
													24,
													"0")
fntAddBet1_gray:setLayoutComponentEnabled(true)
fntAddBet1_gray:setName("fntAddBet1_gray")
fntAddBet1_gray:setTag(108)
fntAddBet1_gray:setCascadeColorEnabled(true)
fntAddBet1_gray:setCascadeOpacityEnabled(true)
fntAddBet1_gray:setPosition(46.0000, 26.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntAddBet1_gray)
layout:setPositionPercentX(0.4792)
layout:setPositionPercentY(0.5909)
layout:setPercentWidth(0.5313)
layout:setPercentHeight(0.5455)
layout:setSize(cc.size(51.0000, 24.0000))
layout:setLeftMargin(20.5000)
layout:setRightMargin(24.5000)
layout:setTopMargin(6.0000)
layout:setBottomMargin(14.0000)
btnAddBet1:addChild(fntAddBet1_gray)

--Create fntAddBet1_green
local fntAddBet1_green = ccui.TextAtlas:create([[100]],
													"game/joyfive_std/resource/number/number2.png",
													17,
													24,
													"0")
fntAddBet1_green:setLayoutComponentEnabled(true)
fntAddBet1_green:setName("fntAddBet1_green")
fntAddBet1_green:setTag(243)
fntAddBet1_green:setCascadeColorEnabled(true)
fntAddBet1_green:setCascadeOpacityEnabled(true)
fntAddBet1_green:setPosition(46.0000, 26.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntAddBet1_green)
layout:setPositionPercentX(0.4792)
layout:setPositionPercentY(0.5909)
layout:setPercentWidth(0.0875)
layout:setPercentHeight(0.0167)
layout:setSize(cc.size(51.0000, 24.0000))
layout:setLeftMargin(20.5000)
layout:setRightMargin(24.5000)
layout:setTopMargin(6.0000)
layout:setBottomMargin(14.0000)
btnAddBet1:addChild(fntAddBet1_green)

--Create btnAddBet2
local btnAddBet2 = ccui.Button:create()
btnAddBet2:ignoreContentAdaptWithSize(false)
btnAddBet2:loadTextureNormal("game/joyfive_std/resource/button/lv1.png",0)
btnAddBet2:loadTexturePressed("game/joyfive_std/resource/button/lv3.png",0)
btnAddBet2:loadTextureDisabled("game/joyfive_std/resource/button/lv4.png",0)
btnAddBet2:setTitleFontSize(14)
btnAddBet2:setTitleColor(cc.c3b(65, 65, 70))
btnAddBet2:setScale9Enabled(true)
btnAddBet2:setCapInsets(cc.rect(15,11,66,22))
btnAddBet2:setLayoutComponentEnabled(true)
btnAddBet2:setName("btnAddBet2")
btnAddBet2:setTag(244)
btnAddBet2:setCascadeColorEnabled(true)
btnAddBet2:setCascadeOpacityEnabled(true)
btnAddBet2:setPosition(1305.0570, 249.1832)
layout = ccui.LayoutComponent:bindLayoutComponent(btnAddBet2)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(96.0000, 44.0000))
layout:setLeftMargin(1257.0570)
layout:setRightMargin(-1353.0570)
layout:setTopMargin(-271.1832)
layout:setBottomMargin(227.1832)
Node:addChild(btnAddBet2)

--Create fntAddBet2_gray
local fntAddBet2_gray = ccui.TextAtlas:create([[100]],
													"game/joyfive_std/resource/number/huinumber.png",
													17,
													24,
													"0")
fntAddBet2_gray:setLayoutComponentEnabled(true)
fntAddBet2_gray:setName("fntAddBet2_gray")
fntAddBet2_gray:setTag(109)
fntAddBet2_gray:setCascadeColorEnabled(true)
fntAddBet2_gray:setCascadeOpacityEnabled(true)
fntAddBet2_gray:setPosition(46.0000, 26.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntAddBet2_gray)
layout:setPositionPercentX(0.4792)
layout:setPositionPercentY(0.5909)
layout:setPercentWidth(0.5313)
layout:setPercentHeight(0.5455)
layout:setSize(cc.size(51.0000, 24.0000))
layout:setLeftMargin(20.5000)
layout:setRightMargin(24.5000)
layout:setTopMargin(6.0000)
layout:setBottomMargin(14.0000)
btnAddBet2:addChild(fntAddBet2_gray)

--Create fntAddBet2_green
local fntAddBet2_green = ccui.TextAtlas:create([[100]],
													"game/joyfive_std/resource/number/number2.png",
													17,
													24,
													"0")
fntAddBet2_green:setLayoutComponentEnabled(true)
fntAddBet2_green:setName("fntAddBet2_green")
fntAddBet2_green:setTag(245)
fntAddBet2_green:setCascadeColorEnabled(true)
fntAddBet2_green:setCascadeOpacityEnabled(true)
fntAddBet2_green:setPosition(46.0000, 26.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntAddBet2_green)
layout:setPositionPercentX(0.4792)
layout:setPositionPercentY(0.5909)
layout:setPercentWidth(0.0875)
layout:setPercentHeight(0.0167)
layout:setSize(cc.size(51.0000, 24.0000))
layout:setLeftMargin(20.5000)
layout:setRightMargin(24.5000)
layout:setTopMargin(6.0000)
layout:setBottomMargin(14.0000)
btnAddBet2:addChild(fntAddBet2_green)

--Create btnAddBet3
local btnAddBet3 = ccui.Button:create()
btnAddBet3:ignoreContentAdaptWithSize(false)
btnAddBet3:loadTextureNormal("game/joyfive_std/resource/button/lv1.png",0)
btnAddBet3:loadTexturePressed("game/joyfive_std/resource/button/lv3.png",0)
btnAddBet3:loadTextureDisabled("game/joyfive_std/resource/button/lv4.png",0)
btnAddBet3:setTitleFontSize(14)
btnAddBet3:setTitleColor(cc.c3b(65, 65, 70))
btnAddBet3:setScale9Enabled(true)
btnAddBet3:setCapInsets(cc.rect(15,11,66,22))
btnAddBet3:setLayoutComponentEnabled(true)
btnAddBet3:setName("btnAddBet3")
btnAddBet3:setTag(246)
btnAddBet3:setCascadeColorEnabled(true)
btnAddBet3:setCascadeOpacityEnabled(true)
btnAddBet3:setPosition(1407.6910, 249.1832)
layout = ccui.LayoutComponent:bindLayoutComponent(btnAddBet3)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(96.0000, 44.0000))
layout:setLeftMargin(1359.6910)
layout:setRightMargin(-1455.6910)
layout:setTopMargin(-271.1832)
layout:setBottomMargin(227.1832)
Node:addChild(btnAddBet3)

--Create fntAddBet3_gray
local fntAddBet3_gray = ccui.TextAtlas:create([[100]],
													"game/joyfive_std/resource/number/huinumber.png",
													17,
													24,
													"0")
fntAddBet3_gray:setLayoutComponentEnabled(true)
fntAddBet3_gray:setName("fntAddBet3_gray")
fntAddBet3_gray:setTag(110)
fntAddBet3_gray:setCascadeColorEnabled(true)
fntAddBet3_gray:setCascadeOpacityEnabled(true)
fntAddBet3_gray:setPosition(46.0000, 26.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntAddBet3_gray)
layout:setPositionPercentX(0.4792)
layout:setPositionPercentY(0.5909)
layout:setPercentWidth(0.5313)
layout:setPercentHeight(0.5455)
layout:setSize(cc.size(51.0000, 24.0000))
layout:setLeftMargin(20.5000)
layout:setRightMargin(24.5000)
layout:setTopMargin(6.0000)
layout:setBottomMargin(14.0000)
btnAddBet3:addChild(fntAddBet3_gray)

--Create fntAddBet3_green
local fntAddBet3_green = ccui.TextAtlas:create([[100]],
													"game/joyfive_std/resource/number/number2.png",
													17,
													24,
													"0")
fntAddBet3_green:setLayoutComponentEnabled(true)
fntAddBet3_green:setName("fntAddBet3_green")
fntAddBet3_green:setTag(247)
fntAddBet3_green:setCascadeColorEnabled(true)
fntAddBet3_green:setCascadeOpacityEnabled(true)
fntAddBet3_green:setPosition(46.0000, 26.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(fntAddBet3_green)
layout:setPositionPercentX(0.4792)
layout:setPositionPercentY(0.5909)
layout:setPercentWidth(0.0875)
layout:setPercentHeight(0.0167)
layout:setSize(cc.size(51.0000, 24.0000))
layout:setLeftMargin(20.5000)
layout:setRightMargin(24.5000)
layout:setTopMargin(6.0000)
layout:setBottomMargin(14.0000)
btnAddBet3:addChild(fntAddBet3_green)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result

