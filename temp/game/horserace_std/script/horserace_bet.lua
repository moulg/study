--[[

下注
]]

local panel_ui = require "game.horserace_std.script.ui_create.ui_horserace_yazhu"

CHorseRaceBet = class("CHorseRaceBet", function ()
	local ret = cc.Node:create()
	return ret
end)

function CHorseRaceBet.create()
	-- body
	local node = CHorseRaceBet.new()
	if node ~= nil then
		node:init_ui()
		node:registerHandler()
		return node
	end
end
function CHorseRaceBet:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.panel_ui.root:setPosition(0,0)
	-- 下注区域按钮
	self.btnSelectedList = {self.panel_ui.btnSelect1,self.panel_ui.btnSelect2,self.panel_ui.btnSelect3,
							self.panel_ui.btnSelect4,self.panel_ui.btnSelect5,self.panel_ui.btnSelect6,
							self.panel_ui.btnSelect7,self.panel_ui.btnSelect8,self.panel_ui.btnSelect9,
							self.panel_ui.btnSelect10,self.panel_ui.btnSelect11,self.panel_ui.btnSelect12,
							self.panel_ui.btnSelect13,self.panel_ui.btnSelect14,self.panel_ui.btnSelect15,
						}
	for i,v in pairs(self.btnSelectedList ) do
		v:setTag(i)
	end
	--所有玩家下注
	self.fntTotalBetChipsList = {self.panel_ui.fntTotalBet1,self.panel_ui.fntTotalBet2,self.panel_ui.fntTotalBet3,
								self.panel_ui.fntTotalBet4,self.panel_ui.fntTotalBet5,self.panel_ui.fntTotalBet6,
								self.panel_ui.fntTotalBet7,self.panel_ui.fntTotalBet8,self.panel_ui.fntTotalBet9,
								self.panel_ui.fntTotalBet10,self.panel_ui.fntTotalBet11,self.panel_ui.fntTotalBet12,
								self.panel_ui.fntTotalBet13,self.panel_ui.fntTotalBet14,self.panel_ui.fntTotalBet15,
							}
	--当前玩家下注
	self.fntCurBetChipsList = {self.panel_ui.fntCurBet1,self.panel_ui.fntCurBet2,self.panel_ui.fntCurBet3,
							self.panel_ui.fntCurBet4,self.panel_ui.fntCurBet5,self.panel_ui.fntCurBet6,
							self.panel_ui.fntCurBet7,self.panel_ui.fntCurBet8,self.panel_ui.fntCurBet9,
							self.panel_ui.fntCurBet10,self.panel_ui.fntCurBet11,self.panel_ui.fntCurBet12,
							self.panel_ui.fntCurBet13,self.panel_ui.fntCurBet14,self.panel_ui.fntCurBet15,
						}
	--倍数
	self.fntMultipleList = {self.panel_ui.fntMultiple1,self.panel_ui.fntMultiple2,self.panel_ui.fntMultiple3,
							self.panel_ui.fntMultiple4,self.panel_ui.fntMultiple5,self.panel_ui.fntMultiple6,
							self.panel_ui.fntMultiple7,self.panel_ui.fntMultiple8,self.panel_ui.fntMultiple9,
							self.panel_ui.fntMultiple10,self.panel_ui.fntMultiple11,self.panel_ui.fntMultiple12,
							self.panel_ui.fntMultiple13,self.panel_ui.fntMultiple14,self.panel_ui.fntMultiple15,
						}
	self:resetBetNum()

	--check button 组处理
	self.btn_group_info_lst = {}
	--筹码按钮
	self.btnBetList = {self.panel_ui.btnBet1,self.panel_ui.btnBet2,self.panel_ui.btnBet3, self.panel_ui.btnBet4,
					self.panel_ui.btnBet5,self.panel_ui.btnBet6,self.panel_ui.btnBet7,self.panel_ui.btnBet8,
					self.panel_ui.btnBet9,self.panel_ui.btnBet10,self.panel_ui.btnBet11,self.panel_ui.btnBet12,
					self.panel_ui.btnBet13,self.panel_ui.btnBet14,self.panel_ui.btnBet15,}
	self:registerGroupEvent(self.btnBetList,function (s,e) self:betButtonHandler(s,e) end)

	--添加下注特效的节点列表
	self.nodeBetEffectList = {self.panel_ui.nodeSelectEffect1,self.panel_ui.nodeSelectEffect2,self.panel_ui.nodeSelectEffect3,self.panel_ui.nodeSelectEffect4,
							self.panel_ui.nodeSelectEffect5,self.panel_ui.nodeSelectEffect6,self.panel_ui.nodeSelectEffect7,self.panel_ui.nodeSelectEffect8,
							self.panel_ui.nodeSelectEffect9,self.panel_ui.nodeSelectEffect10,self.panel_ui.nodeSelectEffect11,self.panel_ui.nodeSelectEffect12,
							self.panel_ui.nodeSelectEffect13,self.panel_ui.nodeSelectEffect14,self.panel_ui.nodeSelectEffect15,}
	
	-- self.ismoveOut = true
	-- self.betPanelIsShow = false

end
--[[
	function CHorseRaceBet:showHidePanel()
		if self.ismoveOut then
			self:moveOut()
		else
			self:moveIn()
		end
		self.ismoveOut = not self.ismoveOut
	end
	function CHorseRaceBet:moveIn()
		local move_action = cc.MoveBy:create(0.3, cc.p(self.size.width,0))
		self:runAction(move_action)
	end
	function CHorseRaceBet:moveOut()
		local move_action = cc.MoveBy:create(0.3, cc.p(-self.size.width,0))
		self:runAction(move_action)
	end
]]

function CHorseRaceBet:registerHandler()
	--续押
	self.panel_ui.btnBetContinue:onTouch(function (e)
		if e.name == "ended" then
			print("续押")
			audio_manager:playOtherSound(1, false)
			self:continueBetHandler()
		end
	end)
	--清空
	self.panel_ui.btnClean:onTouch(function (e)
		if e.name == "ended" then
			audio_manager:playOtherSound(1, false)
			local curTotalBetChips = self:getTotalBetChips()
			print("curTotalBetChips == " ..curTotalBetChips)
			-- dump(horserace_manager.curBetChipsMap)
			if long_compare(curTotalBetChips,0) > 0 then
				send_horserace_ReqClearBet() 
			end
		end
	end)
	--下注
	for k,v in pairs(self.btnSelectedList) do
		v:onTouch(function (e)

			if e.name == "ended" then
				if horserace_manager._selectChipsType ~= nil then
					local tag = e.target:getTag()
					local requireChips = horserace_manager._chipsValueList[horserace_manager._selectChipsType]
					--判断当前筹码是否够下注
					if long_compare(horserace_manager._ownChips, requireChips) >= 0 then
						send_horserace_ReqBet({area = tag, chips = requireChips})
						-- horserace_manager._bCanBet = false
					else
						print("筹码不足!!!!!!!!!!!!")
						TipsManager:showOneButtonTipsPanel(76, {}, true)
					end 
				end
			end
		end)
	end
end

--设置禁用或启用筹码按钮
function CHorseRaceBet:setBtnBetEnable(value)
	if value then
		for i,v in pairs(self.btnBetList) do
			v:setSelected(false)
			-- local requireChips = long_multiply(long_plus(self:getTotalBetChips(),10^(8-i)),8)
			if (long_compare(horserace_manager._ownChips, 10^(8-i)) >= 0) then
				v:setEnabled(true)
				v:setBright(true)
			else
				v:setEnabled(false)
				v:setBright(false)
			end
		end
	else
		for k,v in pairs(self.btnBetList) do
			v:setSelected(false)
			v:setEnabled(value)
			v:setBright(value)
		end
	end
end

--根据当前筹码更新筹码按钮状态
function CHorseRaceBet:updateBtnChipsState()
	if horserace_manager._state == 2 then
		for i,v in pairs(self.btnBetList) do
			-- local requireChips = long_multiply(long_plus(self:getTotalBetChips(),10^(8-i)),8)
			if (long_compare(horserace_manager._ownChips, 10^(8-i)) >= 0) then
				v:setEnabled(true)
				v:setBright(true)
			else
				v:setSelected(false)
				v:setEnabled(false)
				v:setBright(false)
			end
		end
	end
	self:calculateContinue()
end

--设置禁用或启用下注按纽
function CHorseRaceBet:setBtnSelectEnable(value)
	for k,v in pairs(self.btnSelectedList) do
		v:setEnabled(value)
		v:setBright(value)
	end
end
--重置显示下注的数字
function CHorseRaceBet:resetBetNum()
	for i=1,15 do
		self.fntTotalBetChipsList[i]:setString("")
		self.fntCurBetChipsList[i]:setString("")
		self.fntTotalBetChipsList[i]:setVisible(false)
		self.fntCurBetChipsList[i]:setVisible(false)
	end
end

--判断当前筹码是否可以续押
function CHorseRaceBet:calculateContinue()
	if horserace_manager._state == 2 then
		if (horserace_manager._continueChips ~= nil) and (table.nums(horserace_manager._continueChips) > 0) then
			local totalContinueChips = self:getContinueBetRequireChips()
			-- local requireChips = long_multiply(long_plus(totalContinueChips,self:getTotalBetChips()),8)	
			if long_compare(horserace_manager._ownChips, totalContinueChips) >= 0 then 
				self.panel_ui.btnBetContinue:setEnabled(true)
				self.panel_ui.btnBetContinue:setBright(true)
			else
				self.panel_ui.btnBetContinue:setEnabled(false)
				self.panel_ui.btnBetContinue:setBright(false)
			end	
		else
			self.panel_ui.btnBetContinue:setEnabled(false)
			self.panel_ui.btnBetContinue:setBright(false)
		end
	else
		self.panel_ui.btnBetContinue:setEnabled(false)
		self.panel_ui.btnBetContinue:setBright(false)
	end
end

--获取续押的筹码总数
function CHorseRaceBet:getContinueBetRequireChips()
	local continueRequireChips = 0
	if horserace_manager._continueChips then
		for k,v in pairs(horserace_manager._continueChips) do
			continueRequireChips = long_plus(continueRequireChips,v)
		end
	end
	return continueRequireChips
end

--续押
function CHorseRaceBet:continueBetHandler()
	if horserace_manager._continueChips then
		local totalContinueChips = self:getContinueBetRequireChips()
		-- local requireChips = long_multiply(long_plus(totalContinueChips,self:getTotalBetChips()),8)
		--判断当前筹码是否够
		if long_compare(horserace_manager._ownChips, totalContinueChips) >= 0 then
			for k,v in pairs(horserace_manager._continueChips) do
				send_horserace_ReqBet({area = k, chips = v})
			end
		else
			TipsManager:showOneButtonTipsPanel(76, {}, true)
		end 
	end
end
--更新总的下注数
function CHorseRaceBet:updateTotalBetChips()
	-- dump(horserace_manager.totalBetChipsMap)
	for area=1,15 do
		if horserace_manager.totalBetChipsMap[area] ~= nil then
			if long_compare(horserace_manager.totalBetChipsMap[area], 0) > 0 then
				self.fntTotalBetChipsList[area]:setString(horserace_manager.totalBetChipsMap[area])
				self.fntTotalBetChipsList[area]:setVisible(true)
			else
				self.fntTotalBetChipsList[area]:setVisible(false)
			end
		else
			self.fntTotalBetChipsList[area]:setVisible(false)
		end
	end
end

--更新当前玩家的下注数
function CHorseRaceBet:updatePlayerBetChips()
	for area=1,15 do
		if horserace_manager.curBetChipsMap[area] ~= nil then
			if long_compare(horserace_manager.curBetChipsMap[area], 0) > 0 then
				self.fntCurBetChipsList[area]:setString(horserace_manager.curBetChipsMap[area])
				self.fntCurBetChipsList[area]:setVisible(true)
			else
				self.fntCurBetChipsList[area]:setVisible(false)
			end
		else
			self.fntCurBetChipsList[area]:setVisible(false)
		end
	end
end
--获取当前玩家当前下注的总筹码数
function CHorseRaceBet:getTotalBetChips()
	local totalBetChips = 0
	for i,v in pairs(horserace_manager.curBetChipsMap) do
		totalBetChips = long_plus(totalBetChips,v)
	end
	return totalBetChips
end

function CHorseRaceBet:betButtonHandler(sender,event)
	for k,v in pairs(self.btnBetList) do
		if sender == v then
			horserace_manager._selectChipsType = k
			break
		end
	end
end

function CHorseRaceBet:registerGroupEvent(obj_lst,call_back)
	-- body
	for k,v in pairs(obj_lst) do
		self.btn_group_info_lst[v] = {call = call_back,mutex = obj_lst,}
		local function __on_group_deal_pro(sender,event_type)
			self:onGroupDealPro(sender,event_type)
		end
		v:addEventListener(__on_group_deal_pro)
	end
end


function CHorseRaceBet:onGroupDealPro(sender,event_type)
	for k,v in pairs(self.btn_group_info_lst[sender].mutex) do
		if sender ~= v then
			-- v:setEnabled(true)
			v:setSelected(false)
			-- v:setBright(true)
		else
			-- v:setEnabled(false)
			v:setSelected(true)
			audio_manager:playOtherSound(1, false)
		end
	end

	--回调函数最后处理
	local func = self.btn_group_info_lst[sender].call
	if func then 
		func(sender,event_type) 
		return
	end
end
--设置倍数
function CHorseRaceBet:setMultiple()
	if horserace_manager._listMultiple then
		for i,v in pairs(horserace_manager._listMultiple) do
			self.fntMultipleList[v.areId]:setString("x" ..v.rate)
			local aimBlink = cc.Blink:create(1,2)
			local function audioCallBack()
				audio_manager:playOtherSound(10, false)
			end
			local call_action = cc.CallFunc:create(audioCallBack)
			local seq_arr = {}
			table.insert(seq_arr,call_action)
			table.insert(seq_arr,aimBlink)
			local seq = cc.Sequence:create(seq_arr)
			self.fntMultipleList[v.areId]:runAction(cc.RepeatForever:create (seq))
		end

		local function callBack()
			for i,v in pairs(horserace_manager._listMultiple) do
				self.fntMultipleList[v.areId]:stopAllActions()
				self.fntMultipleList[v.areId]:setVisible(true)
			end
		end

		performWithDelay(self, callBack, 2)
	end
end
--添加下注特效
function CHorseRaceBet:addBetEffect(areaId)
	local effectData = horserace_effect_config["tx"]
	animationUtils.createAndPlayAnimation(self.nodeBetEffectList[areaId],effectData,nil)
end
