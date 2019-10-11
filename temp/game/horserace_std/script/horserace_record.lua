--[[

开奖记录界面
]]

local panel_ui = require "game.horserace_std.script.ui_create.ui_horserace_record"

CHorseRaceRecord = class("CHorseRaceRecord", function ()
	local ret = cc.Node:create()
	return ret
end)

function CHorseRaceRecord.create()
	-- body
	local node = CHorseRaceRecord.new()
	if node ~= nil then
		node:init_ui()
        node:registerHandler()
        node:registerBtnMouseMoveEff()
		return node
	end
end
function CHorseRaceRecord:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.root:setPosition(0,0)
	self.fntRecordList = {self.panel_ui.fntRecord1,self.panel_ui.fntRecord2,self.panel_ui.fntRecord3,self.panel_ui.fntRecord4,
						self.panel_ui.fntRecord5,self.panel_ui.fntRecord6,self.panel_ui.fntRecord7,self.panel_ui.fntRecord8,
						self.panel_ui.fntRecord9,self.panel_ui.fntRecord10,self.panel_ui.fntRecord11,self.panel_ui.fntRecord12,
						self.panel_ui.fntRecord13,}
	for k,v in pairs(self.fntRecordList) do
		v:setVisible(false)
	end
end

--注册按钮高亮
function CHorseRaceRecord:registerBtnMouseMoveEff()
	local mov_obj = cc.Sprite:create("game/horserace_std/resource/button/BetDown_Award_Record_Left_2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.btnLeft,mov_obj)
	local mov_obj = cc.Sprite:create("game/horserace_std/resource/button/BetDown_Award_Record_Right_2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.btnRight,mov_obj)
end
--取消高亮
function CHorseRaceRecord:unregisterBtnMouseMoveEff()
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.btnLeft)
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.btnRight)
end
function CHorseRaceRecord:registerHandler()
	--向左
	self.panel_ui.btnLeft:onTouch(function (e)
		if e.name == "ended" then
			horserace_manager._curRecord = horserace_manager._curRecord + 1
			self:updateRecordUi()
		end
	end)
	--向右
	self.panel_ui.btnRight:onTouch(function (e)
		if e.name == "ended" then
			horserace_manager._curRecord = horserace_manager._curRecord - 1
			self:updateRecordUi()
		end
	end)
end
function CHorseRaceRecord:updateRecordUi()
	local ListRecordData = {}
	for i=1,13 do
        if horserace_manager._recordData[horserace_manager._curRecord + i -1] ~= nil then
            ListRecordData[i] = horserace_manager._recordData[horserace_manager._curRecord + i -1]
        end
	end
	for i,v in ipairs(ListRecordData) do
		if v ~= nil then
			self.fntRecordList[i]:setString(horserace_manager._areaData[v])
			self.fntRecordList[i]:setVisible(true)
		end
	end
	self.panel_ui.btnLeft:setEnabled((horserace_manager._recordData[horserace_manager._curRecord + 13] ~= nil)and true or false)
	self.panel_ui.btnLeft:setBright((horserace_manager._recordData[horserace_manager._curRecord + 13] ~= nil)and true or false)
	self.panel_ui.btnRight:setEnabled((horserace_manager._curRecord > 1) and true or false)
	self.panel_ui.btnRight:setBright((horserace_manager._curRecord > 1) and true or false)
	
end
