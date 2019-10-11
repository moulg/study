--[[
二人德州自动游戏
]]

local panel_ui = require "game.errentexaspoker_std.script.ui_create.ui_errentexaspoker_auto"

CErRenTexaspokerAuto = class("CErRenTexaspokerAuto", function ()
	local ret = cc.Node:create()
	return ret
end)

function CErRenTexaspokerAuto.create()
	-- body
	local node = CErRenTexaspokerAuto.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
	
end

function CErRenTexaspokerAuto:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.size = self.panel_ui.bg:getContentSize()
	self.panel_ui.root:setPosition(-self.size.width*0.75,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	self.panel_ui.btnStatistics:onTouch(function (e)
		if e.name == "ended" then
			self:showHidePanel()
		end
	end)
	self.ismoveOut = false

	self.panel_ui.sbtnKeepBet:setSelected(false)
	self.panel_ui.sbtnGiveUp:setSelected(false)
	self.panel_ui.sbtnKeepAny:setSelected(false)
	self.panel_ui.sbtnReady:setSelected(false)

	-- self:registerHandler()
end

function CErRenTexaspokerAuto:registerHandler()
	--自动
	local stateButtoncallback = function (sender, eventType)
		--跟注
		if sender == self.panel_ui.sbtnKeepBet then
			if eventType == "selected" then
				errentexaspoker_manager.autoSelect = errentexaspoker_manager.AUTO_KEEP_BET_ONCE
			else
				errentexaspoker_manager.autoSelect = nil
                self.panel_ui.sbtnKeepBet:setSelected(false)
			end
            self.panel_ui.sbtnKeepBet:setEnabled(true)
			self.panel_ui.sbtnKeepBet:setBright(true)
		--让牌弃牌
		elseif sender == self.panel_ui.sbtnGiveUp then
			if eventType == "selected" then
				errentexaspoker_manager.autoSelect = errentexaspoker_manager.AUTO_PASS_ABANDON
			else
				errentexaspoker_manager.autoSelect = nil
                self.panel_ui.sbtnGiveUp:setSelected(false)
			end
            self.panel_ui.sbtnGiveUp:setEnabled(true)
			self.panel_ui.sbtnGiveUp:setBright(true)
		--跟任何注
		elseif sender == self.panel_ui.sbtnKeepAny then
			if eventType == "selected" then
				errentexaspoker_manager.autoSelect = errentexaspoker_manager.AUTP_KEEP_ANY_BET
			else
				errentexaspoker_manager.autoSelect = nil
                self.panel_ui.sbtnKeepAny:setSelected(false)
			end
            self.panel_ui.sbtnKeepAny:setEnabled(true)
			self.panel_ui.sbtnKeepAny:setBright(true)
		end		   
	end
 		--自动准备
	    local autoReadyClickCallback = function (e)
	        if e.name == "selected" then
	            errentexaspoker_manager.isAutoReady = true
	        elseif e.name == "unselected" then
	            errentexaspoker_manager.isAutoReady = false
	        end
	    end
	    self.panel_ui.sbtnReady:onEvent(autoReadyClickCallback)
	--statebutton 
	local btn_group_lst = {self.panel_ui.sbtnKeepBet,self.panel_ui.sbtnGiveUp,self.panel_ui.sbtnKeepAny,}
	WindowScene.getInstance():registerGroupEvent(btn_group_lst,stateButtoncallback)
end


function CErRenTexaspokerAuto:showHidePanel()
	if self.ismoveOut then
		self:moveOut()
	else
		self:moveIn()
	end
	self.ismoveOut = not self.ismoveOut
end

function CErRenTexaspokerAuto:moveIn()
	local move_action = cc.MoveBy:create(0.3, cc.p(self.size.width*0.75,0))
	self:runAction(move_action)
end

function CErRenTexaspokerAuto:moveOut()
	local move_action = cc.MoveBy:create(0.3, cc.p(-self.size.width*0.75,0))
	self:runAction(move_action)
end
