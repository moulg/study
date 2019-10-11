--[[
魏蜀吴历史记录
]]


local panel_ui = require "game.weishuwu_std.script.ui_create.ui_weishuwu_record"

CWeishuwuRecord = class("CWeishuwuRecord", function ()
	local ret = cc.Node:create()
	return ret
end)


function CWeishuwuRecord.create()
	local node = CWeishuwuRecord.new()
	if node ~= nil then
		-- node:initData()
		node:init_ui()
		return node
	end
end
function CWeishuwuRecord:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.ImgBg:setVisible(false)
	self.panel_ui.ImgBg:setTouchEnabled(true)
	--历史记录
	self.record = {}
	--历史记录图片
	self.recordItemList = {}
end

--历史记录
function CWeishuwuRecord:updateRecord(recordList)
	print("更新历史记录>>>>>>>>")
	-- dump(weishuwu_manager.chipsChange)
	-- dump(table.nums(recordList))
	if long_compare(table.nums(self.record),0) <= 0 then
		for k,v in pairs(recordList) do
			local temp = {winId = v,res = 1 }
			table.insert(self.record, temp)
		end
	else
		print("添加表尾元素>>>>>>>>")
		local playerTotalChips = 0
		for area = 0,8 do	
			if weishuwu_manager.curBetChipsMap[area] ~= nil then		
				playerTotalChips = playerTotalChips + weishuwu_manager.curBetChipsMap[area]
			end
		end	
		dump(playerTotalChips)

		if long_compare(weishuwu_manager.chipsChange, playerTotalChips) > 0 then
			print("赢>>>>>>>>>")
			local temp = {winId = recordList[table.nums(recordList)],res = 2,}
			table.insert(self.record, temp)
			if table.nums(self.record) > 20 then
				table.remove(self.record,1)
			end			
		elseif long_compare(weishuwu_manager.chipsChange, playerTotalChips) < 0 then
			print("输>>>>>>>>>")
			local temp = {winId = recordList[table.nums(recordList)],res = 3,}
			table.insert(self.record, temp)
			if table.nums(self.record) > 20 then
				table.remove(self.record,1)
			end
		else
			local temp = {winId = recordList[table.nums(recordList)],res = 1,}
			table.insert(self.record, temp)
			if table.nums(self.record) > 20 then
				table.remove(self.record,1)
			end
		end
	end
	for k,v in pairs(self.recordItemList) do
		if v ~= nil then
			v:setVisible(false)
			v=nil
		end
	end
	-- dump(self.record)
	if long_compare(table.nums(self.record),0) > 0 then
		print("添加历史记录item>>>>>>>>")
		local listLen = table.nums(self.record)
		local function move_callbck()
			if listLen > 9 then
				local moveAction = cc.MoveBy:create(0.5, cc.p(-46,0))
				self.panel_ui.pnlRecordItem:runAction(moveAction)
			end
		end
		local function update_callback()

			for k,v in pairs(self.record) do
				local num = listLen-9
				local n = k
				if num > 0 then
					n = k-num
				end 			
				if n > 0 and n < 10 then			
					-- dump(v)
					local item = weishuwuRecordItem.create()
					local m = v.winId
					if m == 3 then m = 1 end
					if m == 4 then m = 3 end
					self.recordItemList[n] = item
					self.recordItemList[n]:setPosition(33+66*(n-1),27+59*(m-1))
					self.recordItemList[n]:setInfo(v.res)
					self.panel_ui.pnlRecordItem:addChild(item)
				end
			end
			if listLen > 9 then
				local moveAction = cc.MoveBy:create(0.01, cc.p(46,0))
				self.panel_ui.pnlRecordItem:runAction(moveAction)
			end
		end
		
		local move_call_action = cc.CallFunc:create(move_callbck)
    	local update_call_action = cc.CallFunc:create(update_callback)
    	local seq_arr = {}
    	table.insert(seq_arr,move_call_action)
    	table.insert(seq_arr,cc.DelayTime:create(0.2))
		table.insert(seq_arr,update_call_action)
		local seq = cc.Sequence:create(seq_arr)
		self:runAction(seq)
	end
end
