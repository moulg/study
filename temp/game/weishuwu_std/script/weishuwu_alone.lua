--[[
魏蜀吴路单
]]


local panel_ui = require "game.weishuwu_std.script.ui_create.ui_weishuwu_ludan"

CWeishuwuAlone = class("CWeishuwuAlone", function ()
	local ret = cc.Node:create()
	return ret
end)


function CWeishuwuAlone.create()
	local node = CWeishuwuAlone.new()
	if node ~= nil then
		-- node:initData()
		node:init_ui()
		return node
	end
end
function CWeishuwuAlone:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(960,580)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.Img_BG:setVisible(false)
	self.panel_ui.Img_BG:setTouchEnabled(true)

	--关闭
	self.panel_ui.BtnExit:onTouch(function(e)
		if e.name == "ended" then
			self.panel_ui.Img_BG:setVisible(false)
			weishuwu_manager.alonePanel = false
		end
	end)

	self.panel_ui.FntNum1:setVisible(false)
	self.panel_ui.FntNum2:setVisible(false)
	self.panel_ui.FntNum3:setVisible(false)
	self.panel_ui.FntNum4:setVisible(false)


	self.bigEyeItemList = {}
	self.zhuPanItemList = {}
	self.heroList = {}
	self.aloneList = {}
	self.waybillList = {}
	self.bigEyeInfoList = {}
	self.chaItemList = {}
	self.m_max = 0
end

function CWeishuwuAlone:updateAlone(aloneInfo)
	print("更新路单>>>")
	-- dump(aloneInfo.win)
	if long_compare(table.nums(self.aloneList),0) <= 0 then
		for k,v in pairs(aloneInfo.win) do
			-- local temp = {winId = v,res = 1 }
			table.insert(self.aloneList, v)
			table.insert(self.bigEyeInfoList, v)
			-- table.insert()			
		end 
		for k,v in pairs(aloneInfo.waybill) do
			table.insert(self.waybillList,v)
		end
	else		
		local temp = aloneInfo.win[table.nums(aloneInfo.win)]
		local temp2 = aloneInfo.waybill[table.nums(aloneInfo.waybill)]
		table.insert(self.aloneList, temp)
		table.insert(self.waybillList,temp2)
		table.insert(self.bigEyeInfoList, temp)
		if table.nums(self.bigEyeInfoList) > 174 then
			print("控制大眼路表长度")
			table.remove(self.bigEyeInfoList,1) 
		end
	end
	--朱盘路
	-- dump(self.aloneList)
	-- dump(self.waybillList)
	if self.aloneList then
		local function move_callbck()
			if table.nums(self.aloneList) > 78 then
				local moveAction = cc.MoveBy:create(0.2, cc.p(-99,0))
				self.panel_ui.pnlZhupanItem:runAction(moveAction)
				for i=1,6 do
					table.remove(self.aloneList,1)	
					table.remove(self.waybillList,1)		
				end
				local moveAction = cc.MoveBy:create(0.01, cc.p(99,0))
				self.panel_ui.pnlZhupanItem:runAction(moveAction)
			end
		end
		local function update_callback()			
			for k,v in pairs(self.zhuPanItemList) do
				v:setVisible(false)
				v=nil
			end
			local shuDuiNum = 0
			local wuDuiNum = 0
			-- dump(self.waybillList)
			for k,v in pairs(self.aloneList) do
				local item = CWeishuwuZhupanItem.create()
				self.zhuPanItemList[k] = item
				self.zhuPanItemList[k]:setInfo(self.waybillList,k,v-1)
				local n = k % 6
				local m = math.ceil(k/6)
				if n == 0 then n = 6 end
				self.zhuPanItemList[k]:setPosition(53.5+99*(m-1),514-92*(n-1))
				self.panel_ui.pnlZhupanItem:addChild(item)

				--记录对子数
				local shuduiList = {2,3,6,7,10,11}
				local wuduiList = {1,3,5,7,9,11}
				for _,t in pairs(shuduiList) do
					if long_compare(t,self.waybillList[k]) == 0 then
						shuDuiNum = shuDuiNum + 1
					end
				end
				for _,t in pairs(wuduiList) do
					if long_compare(t,self.waybillList[k]) == 0 then
						wuDuiNum = wuDuiNum + 1
					end
				end
				self.panel_ui.FntNum1:setString(shuDuiNum)
				self.panel_ui.FntNum2:setString(wuDuiNum)
				self.panel_ui.FntNum1:setVisible(true)
				self.panel_ui.FntNum2:setVisible(true)
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

	--大眼路
	-- dump(self.bigEyeInfoList)
	if self.bigEyeInfoList then
		local data = {}
		local function move_callbck()
			local m = 1
			local n = 1			
			-- local line = {}
			
			local index = 0
			for i = 1,#self.bigEyeInfoList do
				local key = #data + 1
				local v = self.bigEyeInfoList[i]
				if i > 1 then					
					if v ~= self.bigEyeInfoList[i-1] and v ~= 3 and self.bigEyeInfoList[i-1] ~= 3 then
						--换行
						n = 1
						m = m + 1
						index = index-1						
					else
						n = n + 1
						if n > 6 then
							n = 6
							m = m + 1
							index = index + 1
							data[key] = {result = 5 , m = m, n = 1,}
						end
					end
					local key = #data + 1
					self.m_max = m
					data[key] = {result = v,m = m ,n = n}
				else
					data[key] = {result = v,m = m ,n = n}
				end			
			end
			if self.m_max > 29 then
				local moveAction = cc.MoveBy:create(0.5, cc.p(-44.5,0))
				self.panel_ui.pnlBigEyeItem:runAction(moveAction)									
			end
		end
		
		local function update_callback()
			for k,v in pairs(self.bigEyeItemList) do
				v:setVisible(false)
				v=nil
			end

			for k,v in pairs(data) do
				-- dump(v.result)
				if self.m_max > 29 then					
					local dif_m = self.m_max-29
					v.m =v.m - dif_m
				end
				if v.m >= 1 then
					local item = CWeishuwuAloneBigEyeItem.create()
					self.bigEyeItemList[k] = item
					self.bigEyeItemList[k]:setInfo(v.result-1)
					self.panel_ui.pnlBigEyeItem:addChild(item)
					self.bigEyeItemList[k]:setPosition(28+44.5*(v.m-1),250-45*(v.n-1))
				end
			end
			if self.m_max > 29 then					
				local moveAction = cc.MoveBy:create(0.01, cc.p(44.5,0))
				self.panel_ui.pnlBigEyeItem:runAction(moveAction)
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

function CWeishuwuAlone:updateHero(aloneInfo)
	-- print("更新虎将都督")
	if long_compare(table.nums(self.heroList),0) <= 0 then
		for k,v in pairs(aloneInfo.hero) do
			table.insert(self.heroList, v)
		end
	else		
		local temp = aloneInfo.hero[table.nums(aloneInfo.hero)]
		table.insert(self.heroList, temp)	
	end
	if self.heroList then
		local wuDuNum = 0
		local shuHuNum = 0
		for k,v in pairs(self.heroList) do
			if v == 2 then
				wuDuNum = wuDuNum + 1
			elseif v==1 then
				shuHuNum = shuHuNum + 1
			end
		end
		self.panel_ui.FntNum3:setString(shuHuNum)
		self.panel_ui.FntNum4:setString(wuDuNum)
		self.panel_ui.FntNum3:setVisible(true)
		self.panel_ui.FntNum4:setVisible(true)
	end
end
