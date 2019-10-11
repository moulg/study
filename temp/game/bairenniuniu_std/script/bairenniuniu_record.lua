--[[
历史记录
]]

local panel_ui = require "game.bairenniuniu_std.script.ui_create.ui_bairenniuniu_recordItem"
local recordResPathlist = {"game/bairenniuniu_std/resource/image/xx.png","game/bairenniuniu_std/resource/image/gg.png",}
CBaiRenNiuNiuRecord = class("CBaiRenNiuNiuRecord", function ()
	local ret = cc.Node:create()
	return ret
end)

function CBaiRenNiuNiuRecord.create()
	-- body
	local node = CBaiRenNiuNiuRecord.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end
function CBaiRenNiuNiuRecord:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.size = self.panel_ui.LabRecord:getContentSize()
	self.panel_ui.root:setVisible(false);
	--self.panel_ui.root:setAnchorPoint(0,0)
	--self.panel_ui.root:setPosition(0,0)
	self.panel_ui.MaskBg:setVisible(false);
	self.panel_ui.MaskBg:setTouchEnabled(false);
	self.panel_ui.MaskBg:onTouch(function (e)
		if e.name == "ended" then
			self:HidePanel()
		end
	end)
	self.ismoveOut = false
	self.recordList = {
		{self.panel_ui.imgRecordFK1,self.panel_ui.imgRecordMH1,self.panel_ui.imgRecordHT1,self.panel_ui.imgRecordRT1,},
		{self.panel_ui.imgRecordFK2,self.panel_ui.imgRecordMH2,self.panel_ui.imgRecordHT2,self.panel_ui.imgRecordRT2,},
		{self.panel_ui.imgRecordFK3,self.panel_ui.imgRecordMH3,self.panel_ui.imgRecordHT3,self.panel_ui.imgRecordRT3,},
		{self.panel_ui.imgRecordFK4,self.panel_ui.imgRecordMH4,self.panel_ui.imgRecordHT4,self.panel_ui.imgRecordRT4,},
		{self.panel_ui.imgRecordFK5,self.panel_ui.imgRecordMH5,self.panel_ui.imgRecordHT5,self.panel_ui.imgRecordRT5,},
		{self.panel_ui.imgRecordFK6,self.panel_ui.imgRecordMH6,self.panel_ui.imgRecordHT6,self.panel_ui.imgRecordRT6,},
		{self.panel_ui.imgRecordFK7,self.panel_ui.imgRecordMH7,self.panel_ui.imgRecordHT7,self.panel_ui.imgRecordRT7,},
		{self.panel_ui.imgRecordFK8,self.panel_ui.imgRecordMH8,self.panel_ui.imgRecordHT8,self.panel_ui.imgRecordRT8,},
		{self.panel_ui.imgRecordFK9,self.panel_ui.imgRecordMH9,self.panel_ui.imgRecordHT9,self.panel_ui.imgRecordRT9,},
		{self.panel_ui.imgRecordFK10,self.panel_ui.imgRecordMH10,self.panel_ui.imgRecordHT10,self.panel_ui.imgRecordRT10,},
		{self.panel_ui.imgRecordFK11,self.panel_ui.imgRecordMH11,self.panel_ui.imgRecordHT11,self.panel_ui.imgRecordRT11,},
	}
	for k,v in pairs(self.recordList) do
		for _,r in pairs(v) do
			r:setVisible(false)
		end
	end
end

function CBaiRenNiuNiuRecord:HidePanel()
	self:moveOut()
	self.ismoveOut = false
end

function CBaiRenNiuNiuRecord:showHidePanel()
	if self.ismoveOut then
		self:moveOut()
	else
		self:moveIn()
	end
	self.ismoveOut = not self.ismoveOut
end

function CBaiRenNiuNiuRecord:moveIn()
	self.panel_ui.root:setVisible(true);
	self.panel_ui.MaskBg:setVisible(true);
	self.panel_ui.MaskBg:setTouchEnabled(true);
	--local move_action = cc.MoveBy:create(0.3, cc.p(0,-self.size.height))
	--self:runAction(move_action)
end

function CBaiRenNiuNiuRecord:moveOut()
	self.panel_ui.root:setVisible(false);
	self.panel_ui.MaskBg:setVisible(false);
	self.panel_ui.MaskBg:setTouchEnabled(false);
	--local move_action = cc.MoveBy:create(0.3, cc.p(0,self.size.height))
	--self:runAction(move_action)
end
--更新记录
function CBaiRenNiuNiuRecord:updateRecord(recordList)
	
	if recordList then
		-- local PosX,PosY = self.panel_ui.pnlRecordItem:getPosition() 
		-- print("PosX = " ..PosX,"PosY = " ..PosY)
		local function move_callbck()
			local moveAction = cc.MoveBy:create(0.5, cc.p(-50,0))
			self.panel_ui.pnlRecordItem:runAction(moveAction)
		end
		local function update_callback()
			for k,record in pairs(recordList) do
				local list = bairenniuniu_manager:convertToBinTable(record)
				if k < 12 then
					for i,v in pairs(list) do
						-- dump(v)
						self.recordList[k][i]:setTexture(recordResPathlist[v+1])
						self.recordList[k][i]:setVisible(true)
					end
				end
			end
			local moveAction = cc.MoveBy:create(0.01, cc.p(50,0))
			self.panel_ui.pnlRecordItem:runAction(moveAction)
			-- self.panel_ui.pnlRecordItem:setPosition(cc.p(PosX, PosY))
		end
		
		local move_call_action = cc.CallFunc:create(move_callbck)
    	local update_call_action = cc.CallFunc:create(update_callback)
    	local seq_arr = {}
    	table.insert(seq_arr,move_call_action)
    	table.insert(seq_arr,cc.DelayTime:create(0.5))
		table.insert(seq_arr,update_call_action)
		local seq = cc.Sequence:create(seq_arr)
		self:runAction(seq)
	end
end