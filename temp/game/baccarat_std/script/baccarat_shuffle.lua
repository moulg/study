--[[
百家乐洗牌界面
]]

local panel_ui = require "game.baccarat_std.script.ui_create.ui_baccarat_shuffle"

CBaccaratShuffle = class("CBaccaratShuffle", function ()
	local ret = cc.Node:create()
	return ret
end)


function CBaccaratShuffle.create()
	local node = CBaccaratShuffle.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end

function CBaccaratShuffle:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	-- self.panel_ui.root:setPosition(0,0)
	-- self.panel_ui.root:setAnchorPoint(0,0)	
end

--洗牌 
function CBaccaratShuffle:shuffleCards()
	self.upCont = 100
	self.downCont = 0
	self.panel_ui.CardXipai:setPosition(1190, 463)
	self.panel_ui.imgCardBjDown:setPosition(664.65, 298.97) 
	self.panel_ui.CardXipai:setVisible(true)
	self.panel_ui.LoadingBar_Xipai_down:setVisible(true)
	self.panel_ui.LoadingBar_Xipai_up:setVisible(true)
 	self.panel_ui.imgCardBjUp:setVisible(true)
 	self.panel_ui.imgCardBjDown:setVisible(true)
	self.schedulHandler = scheduler:scheduleScriptFunc(handler(self,self.updateCard),0.01,false)
end

function CBaccaratShuffle:updateCard(dt)
    self.upCont = self.upCont - 1 
    self.downCont = self.downCont + 1
    if self.upCont < 0 then
     	self.upCont = 0
     	self.panel_ui.LoadingBar_Xipai_up:setVisible(false)
     	self.panel_ui.imgCardBjUp:setVisible(false)
     	self:setShuffleFlag()
     	if self.schedulHandler ~=nil then
			scheduler:unscheduleScriptEntry(self.schedulHandler)
			self.schedulHandler = nil
		end
    end
    if self.downCont > 100 then
	    self.downCont = 100
	end
    self.panel_ui.LoadingBar_Xipai_up:setPercent(self.upCont)
    self.panel_ui.LoadingBar_Xipai_down:setPercent(self.downCont)
    -- self.panel_ui.imgCardBjUp:setPositionY(545+(416*(self.upCont/100)))
    self.panel_ui.imgCardBjDown:setPositionY(297+(416*(self.downCont/100)))
end 

function CBaccaratShuffle:setShuffleFlag()
	local moveTo_act = cc.MoveTo:create(0.3, cc.p(665.65,math.random(300,350)))
	local function hideCallBck()
		self.panel_ui.CardXipai:setVisible(false)
	end
	local function cleanCallBack()
		self.schedulClean = scheduler:scheduleScriptFunc(handler(self,self.clean),0.01,false)
	end
	self.panel_ui.CardXipai:runAction(cc.Sequence:create(moveTo_act,cc.CallFunc:create(hideCallBck),cc.CallFunc:create(cleanCallBack)))
end

function CBaccaratShuffle:clean(dt)
	self.downCont = self.downCont - 1
	if self.downCont < 0 then
	    self.downCont = 0
	    self.panel_ui.LoadingBar_Xipai_down:setVisible(false)
	    local moveTo_act = cc.MoveTo:create(0.3, cc.p(1800,987))
	    local function call_back()
	    	self.panel_ui.imgCardBjDown:setVisible(false)
	    	local game_baccarat = WindowScene.getInstance():getModuleObjByClassName("CBaccaratMainScene")
			if game_baccarat then
				game_baccarat:sendCutCard()
			end
	    end
	    self.panel_ui.imgCardBjDown:runAction(cc.Sequence:create(moveTo_act,cc.CallFunc:create(call_back)))
	    
	    if self.schedulClean ~= nil then
			scheduler:unscheduleScriptEntry(self.schedulClean)
			self.schedulClean = nil
		end
	end
	self.panel_ui.LoadingBar_Xipai_down:setPercent(self.downCont)
    self.panel_ui.imgCardBjDown:setPositionY(297+(416*(self.downCont/100)))
end
