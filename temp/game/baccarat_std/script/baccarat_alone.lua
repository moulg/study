--[[
百家乐路单
]]


local panel_ui = require "game.baccarat_std.script.ui_create.ui_baccarat_alone"
local baccartPos = {x=188,y=930}
local smallStrongbaccartRes = {"game/baccarat_std/resource/image/alone/xiehongtiao.png",
		"game/baccarat_std/resource/image/alone/xielantiao.png",
	}
local smallStrongDragonRes = {"game/baccarat_std/resource/image/alone/xiehongtiao.png",
		"game/baccarat_std/resource/image/alone/juhongtiao.png",
	}
local smallbaccartRes = {"game/baccarat_std/resource/image/alone/hqs.png",
		"game/baccarat_std/resource/image/alone/lqs.png",
	}
local smallDragonRes = {"game/baccarat_std/resource/image/alone/hqs.png",
		"game/baccarat_std/resource/image/alone/jqs.png",
	}

CBaccaratAlone = class("CBaccaratAlone", function ()
	local ret = cc.Node:create()
	return ret
end)


function CBaccaratAlone.create()
	local node = CBaccaratAlone.new()
	if node ~= nil then
		node:initData()
		node:init_ui()
		return node
	end
end

function CBaccaratAlone:initData()
	--check button 组处理
	self.btn_group_info_lst = {}
	self.mainItemList = {}
	self.bigItemList = {}
	self.m_max_list = {}
	self.bigEyeItemList = {}
	self.smallItemList = {}
	self.smallStrongItemList = {}
end

function CBaccaratAlone:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0.5,0)
	self.ismoveOut = true

	
	self.pnlBaccaratOrLongHu = {self.panel_ui.Panel_Baccarat,self.panel_ui.Panel_Longhu,}
	self.btnSelectBaccaratOrLongHu = {self.panel_ui.sbtn_baccarat,self.panel_ui.sbtn_longhu,}
	self.btnSelectZhuangOrBigSmall = {self.panel_ui.sbtn_zhuangxian,self.panel_ui.sbtn_bigsmall,}

	self.panel_ui.Panel_Longhu:setVisible(false)
	self.panel_ui.Panel_Baccarat:setVisible(true)
	self.panel_ui.sbtn_baccarat:setSelected(true)
	self.panel_ui.sbtn_longhu:setSelected(false)
	self.panel_ui.sbtn_zhuangxian:setSelected(true)
	self.panel_ui.sbtn_bigsmall:setSelected(false)

	self.panel_ui.fntTimes2:setString("")
	self.panel_ui.fntLong:setString("")
	self.panel_ui.fntHu:setString("")
	self.panel_ui.fntHe2:setString("")
	self.panel_ui.fntTimes:setString("")
	self.panel_ui.fntZhuangs:setString("")
	self.panel_ui.fntXians:setString("")
	self.panel_ui.fntHe:setString("")
	self.panel_ui.fntZhuangTwo:setString("")
	self.panel_ui.fntXianTwo:setString("")

	self:registerGroupEvent(self.btnSelectBaccaratOrLongHu,function (s,e) self:selectBaccaratOrLongHuHandler(s,e) end)
	self:registerGroupEvent(self.btnSelectZhuangOrBigSmall,function (s,e) self:selectZhuangOrBigSmallHandler(s,e) end)
	
	self:registerHandler()

	self:updateStatistics()
end

function CBaccaratAlone:registerHandler()
	--庄问路
	self.panel_ui.btnZhuangAskRoad:onTouch(function (e)
		if e.name == "ended" then
			print("庄问路")
			local data = clone(self:exchangeBaccaratBigItemData(baccarat_manager.alone.hisWaybill))
			table.insert(data, 1)
			self.bigItemData = {}
			self.bigItemData = self:getBigItemData(data,true)
			
			self:showBigItem(1,self.bigItemData)
			
			local bigEyeData = self:getItemDataByK(1,self.bigItemData)
			local smallData = self:getItemDataByK(2,self.bigItemData)
			local smallStrongData = self:getItemDataByK(3,self.bigItemData)
			--大眼路
			self:showBigEyeItem(1,bigEyeData)
			self:showSmallItem(1,smallData)
			self:showSmallStrongItem(1,smallStrongData)
		end
	end)
	--闲问路
	self.panel_ui.btnXianAskRoad:onTouch(function (e)
		if e.name == "ended" then
			print("闲问路")
			local data = clone(self:exchangeBaccaratBigItemData(baccarat_manager.alone.hisWaybill)) 
			table.insert(data, 3)
			self.bigItemData = {}
			self.bigItemData = self:getBigItemData(data,true)
			self:showBigItem(1,self.bigItemData)
			local bigEyeData = self:getItemDataByK(1,self.bigItemData)
			local smallData = self:getItemDataByK(2,self.bigItemData)
			local smallStrongData = self:getItemDataByK(3,self.bigItemData)
			--大眼路
			self:showBigEyeItem(1,bigEyeData)
			self:showSmallItem(1,smallData)
			self:showSmallStrongItem(1,smallStrongData)
		end
	end)
	--龙问路
	self.panel_ui.btnLongAskRoad:onTouch(function (e)
		if e.name == "ended" then
			print("龙问路")
			local data = clone(baccarat_manager.alone.hisDragon)
			table.insert(data,1)
			self.bigItemData = {}
			self.bigItemData = self:getBigItemData(data,true)
			self:showBigItem(2,self.bigItemData)
			local bigEyeData = self:getItemDataByK(1,self.bigItemData)
			local smallData = self:getItemDataByK(2,self.bigItemData)
			local smallStrongData = self:getItemDataByK(3,self.bigItemData)
			--大眼路
			self:showBigEyeItem(2,bigEyeData)
			self:showSmallItem(2,smallData)
			self:showSmallStrongItem(2,smallStrongData)
		end
	end)
	--虎问路
	self.panel_ui.btnHuAskRoad:onTouch(function (e)
		if e.name == "ended" then
			print("虎问路")
			local data = clone(baccarat_manager.alone.hisDragon)
			table.insert(data,3)
			self.bigItemData = {}
			self.bigItemData = self:getBigItemData(data,true)
			self:showBigItem(2,self.bigItemData)
			local bigEyeData = self:getItemDataByK(1,self.bigItemData)
			local smallData = self:getItemDataByK(2,self.bigItemData)
			local smallStrongData = self:getItemDataByK(3,self.bigItemData)
			--大眼路
			self:showBigEyeItem(2,bigEyeData)
			self:showSmallItem(2,smallData)
			self:showSmallStrongItem(2,smallStrongData)
		end
	end)
end

function CBaccaratAlone:selectBaccaratOrLongHuHandler(sender,event)
	for k,v in pairs(self.btnSelectBaccaratOrLongHu) do
		self.pnlBaccaratOrLongHu[k]:setVisible(v == sender)
		self:showCurSelect()
	end
end

function CBaccaratAlone:selectZhuangOrBigSmallHandler(sender,event)
	if sender == self.panel_ui.sbtn_zhuangxian then
		self:showMainItem(1,baccarat_manager.alone.hisWaybill)
	elseif sender == self.panel_ui.sbtn_bigsmall then
		self:showMainItem(2,baccarat_manager.alone.hisBigSmall)
	end
end

--显示主路单
function CBaccaratAlone:showMainItem(type,dataList)
	for k,v in pairs(self.mainItemList) do
		v:setVisible(false)
	end
	local firstPos = {x = 353,y = 948}
	if type == 3 then 
		firstPos = {x = 243,y = 951}
	end
	if dataList then
		for k,v in pairs(dataList) do
			if self.mainItemList[k] == nil then
				local item = CBaccaratAloneMainItem.create()
				self:addChild(item)
				self.mainItemList[k] = item
			end
			local n = math.fmod(k, 12)
			local m = math.ceil(k/12)
			if n == 0 then n = 12 end
			self.mainItemList[k]:setInfo(type,v)
			self.mainItemList[k]:setPosition(firstPos.x+(m-1)*55.5, firstPos.y-(n-1)*55.5)
			self.mainItemList[k]:setVisible(true)
		end
	end
end

--转化百家乐大路单数据
function CBaccaratAlone:exchangeBaccaratBigItemData(dataList)
	local data = {}
	for k,v in pairs(dataList) do 
		table.insert(data,math.floor(v/4)+1 )
	end
	return data
end

--获取大路单数据
function CBaccaratAlone:getBigItemData(dataList,bShowEffect)
	-- dump(dataList)
	local bigItemData = {}
	local m = 1
	local n = 1
	self.m_max = 1
	if dataList then
		for k,v in pairs(dataList) do
			if v ~= 2 then
				if bigItemData[#bigItemData] then
					if v == bigItemData[#bigItemData].result then
						n = n + 1
					else
						m = m + 1
						n = 1
						self.m_max = m
					end
				end

				local index = #bigItemData+1
				if bShowEffect and (k == #dataList) then
					bigItemData[index] = {result = v,drawNum = 0,m = m,n = n,bShowEffect = true}
				else
					bigItemData[index] = {result = v,drawNum = 0,m = m,n = n}
				end
				
			else
				if bigItemData[#bigItemData] then
					local temp = bigItemData[#bigItemData]
					temp.drawNum = temp.drawNum + 1
				end
			end
		end
	end
	return bigItemData
end

--显示大路单
function CBaccaratAlone:showBigItem(type,dataList)
	-- dump(dataList)
	if table.nums(self.bigItemList) > 0 then
		for k,v in pairs(self.bigItemList) do
			v:stopAllActions()
			v:removeFromParent()
		end
		self.bigItemList = {}
	end
	local firstPos = {x = 772,y = 816}
	if dataList then
		local data = clone(dataList)
		for k,v in pairs(data) do
			if v.n <= 8 then
				if self.m_max > 24 then
					local dif_m = self.m_max-24
					v.m = v.m-dif_m
				end
				if v.m -1 >= 0 then
					local item = CBaccaratAloneBigItem.create()
					if type == 1 then
						self.panel_ui.Panel_Baccarat:addChild(item)
					else
						self.panel_ui.Panel_Longhu:addChild(item)
					end
					item:setInfo(type,v.result,v.drawNum)
					item:setPosition(firstPos.x+(v.m-1)*32.5, firstPos.y-(v.n-1)*32.5)
					if v.bShowEffect then
						item:runAction(cc.RepeatForever:create(cc.Blink:create(1,2)))
					end
					table.insert(self.bigItemList,item)
				end
			end
		end
	end
end

--获取某列具有图标数P
function CBaccaratAlone:getPByK(m,data)
	local p = 0
	for k,v in pairs(data) do
		if v.m == m then
			p = p + 1
		end
	end
	return p
end

--获取路单数据
function CBaccaratAlone:getItemDataByK(key,dataList)
	-- dump(dataList)
	local m = 1
	local n = 1
	self.m_max_list[key] = 1
	local data = {}
	for k,v in pairs(dataList) do
		local result = self:getResult(dataList,v,key)
		if result then
			if data[#data] then
				if data[#data].result == result then
					n = n + 1
				else
					n = 1
					m = m + 1
					self.m_max_list[key] = m
				end
			end 
			local index = #data+1
			if v.bShowEffect and (k == #dataList) then
				data[index] = {result = result,m = m,n = n,bShowEffect = true}
			else
				data[index] = {result = result,m = m,n = n}
			end
		end
	end
	
	return data
end

--
function CBaccaratAlone:getResult(dataList,data,key)
	local result = nil
	if data.m and data.n then
		if data.n > 1 then
			if data.m > key then
				result = ((self:getPByK(data.m-key,dataList) + 1) == data.n) and 2 or 1
			end
		else
			if data.m > key then
				result = ((self:getPByK(data.m-key,dataList) + 1) == data.n) and 1 or 2
			end
		end
	end
	return result
end

--显示大眼路单
function CBaccaratAlone:showBigEyeItem(type,dataList)
	-- dump(dataList)
	if table.nums(self.bigEyeItemList) > 0 then
		for k,v in pairs(self.bigEyeItemList) do
			v:stopAllActions()
			v:removeFromParent()
		end
		self.bigEyeItemList = {}
	end
	local firstPos = {x = 945,y = 683}
	if dataList then
		for k,v in pairs(dataList) do
			if v.n <= 8 then
				if self.m_max_list[1] > 24 then
					local dif_m = self.m_max_list[1]-24
					v.m = v.m-dif_m
				end
				if v.m -1 >= 0 then
					local item = CBaccaratAloneBigEyeItem.create()
					self:addChild(item)
					item:setInfo(type,v.result)
					item:setPosition(firstPos.x+(v.m-1)*32.5, firstPos.y-(v.n-1)*32.5)
					if v.bShowEffect then
						item:runAction(cc.RepeatForever:create(cc.Blink:create(1,2)))
					end
					table.insert(self.bigEyeItemList,item)
				end
			end
		end
	end
end

--显示小路单
function CBaccaratAlone:showSmallItem(type,dataList)
	if table.nums(self.smallItemList) > 0 then
		for k,v in pairs(self.smallItemList) do
			v:stopAllActions()
			v:removeFromParent()
		end
		self.smallItemList = {}
	end
	local firstPos = {x = 945,y = 415}
	if dataList then
		for k,v in pairs(dataList) do
			if v.n <= 8 then
				if self.m_max_list[2] > 12 then
					local dif_m = self.m_max_list[2]-12
					v.m = v.m-dif_m
				end
				if v.m -1 >= 0 then
					local item = CBaccaratAloneSmallItem.create()
					self:addChild(item)
					item:setInfo(type,v.result)
					item:setPosition(firstPos.x+(v.m-1)*32.5, firstPos.y-(v.n-1)*32.5)
					if v.bShowEffect then
						item:runAction(cc.RepeatForever:create(cc.Blink:create(1,2)))
					end
					table.insert(self.smallItemList,item)
				end
			end
		end
	end
end

--显示小强路单
function CBaccaratAlone:showSmallStrongItem(type,dataList)
	if table.nums(self.smallStrongItemList) > 0 then
		for k,v in pairs(self.smallStrongItemList) do
			v:stopAllActions()
			v:removeFromParent()
		end
		self.smallStrongItemList = {}
	end
	local firstPos = {x = 1332,y = 390}
	if dataList then
		for k,v in pairs(dataList) do
			if v.n <= 8 then
				if self.m_max_list[3] > 12 then
					local dif_m = self.m_max_list[3]-12
					v.m = v.m-dif_m
				end
				if v.m -1 >= 0 then
					local item = CBaccaratAloneSmallStrongItem.create()
					self:addChild(item)
					item:setInfo(type,v.result)
					item:setPosition(firstPos.x+(v.m-1)*32.5, firstPos.y-(v.n-1)*32.5)
					if v.bShowEffect then
						item:runAction(cc.RepeatForever:create(cc.Blink:create(1,2)))
					end
					table.insert(self.smallStrongItemList,item)
				end
			end
		end
	end
end

--显示交换图标
function CBaccaratAlone:showExChangeImg(dataList)
	if dataList then
		local _bankerDataList = clone(dataList)
		local _playerDataList = clone(dataList)
		table.insert(_bankerDataList,1)
		table.insert(_playerDataList,3)
		local bankerBigItemData = self:getBigItemData(_bankerDataList)
		local playerBigItemData = self:getBigItemData(_playerDataList)
		
		local bankerData = bankerBigItemData[#bankerBigItemData]
		local playerData = playerBigItemData[#playerBigItemData]
		if bankerData then
			self.panel_ui.imgSmallIconZhuang:loadTexture((self:getResult(bankerBigItemData,bankerData,2) == 2) and smallbaccartRes[2] or smallbaccartRes[1])
			self.panel_ui.imgXQIconZhuang:loadTexture((self:getResult(bankerBigItemData,bankerData,3) == 2) and smallStrongbaccartRes[2] or smallStrongbaccartRes[1])
			self.panel_ui.imgSmallIconLong:loadTexture((self:getResult(bankerBigItemData,bankerData,2) == 2) and smallDragonRes[2] or smallDragonRes[1])
			self.panel_ui.imgXQIconLong:loadTexture((self:getResult(bankerBigItemData,bankerData,3) == 2) and smallStrongDragonRes[2] or smallStrongDragonRes[1])
		end
		if playerData then
			self.panel_ui.imgSmallIconZhuang_0:loadTexture((self:getResult(playerBigItemData,playerData,2) == 1) and smallbaccartRes[1] or smallbaccartRes[2])
			self.panel_ui.imgXQIconZhuang_0:loadTexture((self:getResult(playerBigItemData,playerData,3) == 1) and smallStrongbaccartRes[1] or smallStrongbaccartRes[2])
			self.panel_ui.imgSmallIconHu:loadTexture((self:getResult(playerBigItemData,playerData,2) == 1) and smallDragonRes[1] or smallDragonRes[2])
			self.panel_ui.imgXQIconHu:loadTexture((self:getResult(playerBigItemData,playerData,3) == 1) and smallStrongDragonRes[1] or smallStrongDragonRes[2])
		end
	end
end

--显示当前选择
function CBaccaratAlone:showCurSelect()
	if self.panel_ui.sbtn_baccarat:isSelected() then
		self.panel_ui.Panel_Baccarat:setVisible(true)
		self.panel_ui.Panel_Longhu:setVisible(false)
		--主路
		if self.panel_ui.sbtn_zhuangxian:isSelected() then
			self:showMainItem(1,baccarat_manager.alone.hisWaybill)
		else
			self:showMainItem(2,baccarat_manager.alone.hisBigSmall)
		end
		--大路
		local data = self:exchangeBaccaratBigItemData(baccarat_manager.alone.hisWaybill)
		--图标
		self:showExChangeImg(data)

		self.bigItemData = {}
		self.bigItemData = self:getBigItemData(data)
		self:showBigItem(1,self.bigItemData)
		
		local bigEyeData = self:getItemDataByK(1,self.bigItemData)
		local smallData = self:getItemDataByK(2,self.bigItemData)
		local smallStrongData = self:getItemDataByK(3,self.bigItemData)
		--大眼路
		self:showBigEyeItem(1,bigEyeData)
		--小路
		self:showSmallItem(1,smallData)
		--小强路
		self:showSmallStrongItem(1,smallStrongData)
		
		
	else
		self.panel_ui.Panel_Baccarat:setVisible(false)
		self.panel_ui.Panel_Longhu:setVisible(true)
		self:showMainItem(3,baccarat_manager.alone.hisDragon)
		self.bigItemData = {}
		self.bigItemData = self:getBigItemData(baccarat_manager.alone.hisDragon)
		
		self:showBigItem(2,self.bigItemData)
		
		local bigEyeData = self:getItemDataByK(1,self.bigItemData)
		local smallData = self:getItemDataByK(2,self.bigItemData)
		local smallStrongData = self:getItemDataByK(3,self.bigItemData)
		--大眼路
		self:showBigEyeItem(2,bigEyeData)
		--小路
		self:showSmallItem(2,smallData)
		--小强路
		self:showSmallStrongItem(2,smallStrongData)
		--图标
		self:showExChangeImg(baccarat_manager.alone.hisDragon)
	end
end

--更新统计数据
function CBaccaratAlone:updateStatistics()
	if baccarat_manager.statisticsData then
		self.panel_ui.fntTimes2:setString(baccarat_manager.statisticsData.score)
		self.panel_ui.fntLong:setString(baccarat_manager.statisticsData.dragon)
		self.panel_ui.fntHu:setString(baccarat_manager.statisticsData.tiger)
		self.panel_ui.fntHe2:setString(baccarat_manager.statisticsData.dragonTigerTie)
		self.panel_ui.fntTimes:setString(baccarat_manager.statisticsData.score)
		self.panel_ui.fntZhuangs:setString(baccarat_manager.statisticsData.bankerWin)
		self.panel_ui.fntXians:setString(baccarat_manager.statisticsData.playerWin)
		self.panel_ui.fntHe:setString(baccarat_manager.statisticsData.tie)
		self.panel_ui.fntZhuangTwo:setString(baccarat_manager.statisticsData.bankerPaire)
		self.panel_ui.fntXianTwo:setString(baccarat_manager.statisticsData.playerPaire)
	end
end

function CBaccaratAlone:showHidePanel()
	if self.ismoveOut then
		self:moveOut()
	else
		self:moveIn()
	end
	self.ismoveOut = not self.ismoveOut
end

function CBaccaratAlone:moveIn()
	local size = self.panel_ui.ImgBj:getContentSize()

	local move_action = cc.MoveBy:create(0.3, cc.p(0,size.height))
	self:runAction(move_action)
end

function CBaccaratAlone:moveOut()
	local size = self.panel_ui.ImgBj:getContentSize()

	local move_action = cc.MoveBy:create(0.3, cc.p(0,-size.height))
	self:runAction(move_action)

	self:showCurSelect()
end

function CBaccaratAlone:registerGroupEvent(obj_lst,call_back)
	-- body
	for k,v in pairs(obj_lst) do
		self.btn_group_info_lst[v] = {call = call_back,mutex = obj_lst,}
		local function __on_group_deal_pro(sender,event_type)
			self:onGroupDealPro(sender,event_type)
		end
		v:addEventListener(__on_group_deal_pro)
	end
end


function CBaccaratAlone:onGroupDealPro(sender,event_type)
	for k,v in pairs(self.btn_group_info_lst[sender].mutex) do
		if sender ~= v then
			v:setEnabled(true)
			v:setSelected(false)
			v:setBright(true)
		else
			v:setEnabled(false)
			v:setSelected(true)
		end
	end

	--回调函数最后处理
	local func = self.btn_group_info_lst[sender].call
	if func then 
		func(sender,event_type) 
		return
	end
end