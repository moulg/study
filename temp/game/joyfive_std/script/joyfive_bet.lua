--[[
欢乐五张操作界面
]]

local panel_ui = require "game.joyfive_std.script.ui_create.ui_joyfive_bet"

CJoyFiveBet = class("CJoyFiveBet", function ()
	local ret = cc.Node:create()
	return ret
end)


function CJoyFiveBet.create()
	local node = CJoyFiveBet.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end

function CJoyFiveBet:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)
	self.addBetList = {self.panel_ui.btnAddBet1,self.panel_ui.btnAddBet2,self.panel_ui.btnAddBet3,}
	self.fntGrayList = {self.panel_ui.fntAddBet1_gray,self.panel_ui.fntAddBet2_gray,self.panel_ui.fntAddBet3_gray,}
	self.fntGreenList = {self.panel_ui.fntAddBet1_green,self.panel_ui.fntAddBet2_green,self.panel_ui.fntAddBet3_green,}
	self.btnList = {self.panel_ui.btnKeepBet,self.panel_ui.btnBetAll,self.panel_ui.btnGiveUp,
					self.panel_ui.btnAddBet1,self.panel_ui.btnAddBet2,self.panel_ui.btnAddBet3,}
	self:registerHander()
	--跟注
	self.keepBetChips = "0"	
end
function CJoyFiveBet:updateBetUi()
	local roominfo = get_player_info():get_cur_roomInfo()
	print("minOne == " ..roominfo.minOne)
	self.panel_ui.fntAddBet1_gray:setString(roominfo.minOne)
	self.panel_ui.fntAddBet2_gray:setString(long_multiply(roominfo.minOne, 2))
	self.panel_ui.fntAddBet3_gray:setString(long_multiply(roominfo.minOne, 3))
	self.panel_ui.fntAddBet1_green:setString(roominfo.minOne)
	self.panel_ui.fntAddBet2_green:setString(long_multiply(roominfo.minOne, 2))
	self.panel_ui.fntAddBet3_green:setString(long_multiply(roominfo.minOne, 3))
	--梭哈
	self.panel_ui.btnBetAll:setEnabled((joyfive_manager._sendCardsCount > 1) and true or false)
	self.panel_ui.btnBetAll:setBright((joyfive_manager._sendCardsCount > 1) and true or false)
	--加注
	if (joyfive_manager._AddBet == false) and (joyfive_manager._keepBet == false) and (joyfive_manager._BetAll == false) then
		self:setAddBetBtnEnabled(true)
	else
		self:setAddBetBtnEnabled(false)
	end
	--跟注
	self.panel_ui.btnKeepBet:setEnabled((joyfive_manager._BetAll == false) and true or false)
	self.panel_ui.btnKeepBet:setBright((joyfive_manager._BetAll == false) and true or false)
	self:updateKeepBetBtn()
	self:updateAddBetBtn()
	--self:updateBetAllBtn()
end
--启用、禁用所有按钮
function CJoyFiveBet:setBtnEnabled(isable)
	for i,v in ipairs(self.btnList) do
		v:setEnabled(isable)
		v:setBright(isable)
	end
end
--启用、禁用加注按钮
function CJoyFiveBet:setAddBetBtnEnabled(isable)
	for i=1,3 do
		self:setAddBetBtnByIndex(i,isable)
	end
end
function CJoyFiveBet:setAddBetBtnByIndex(index,isable)
	self.addBetList[index]:setEnabled(isable)
	self.addBetList[index]:setBright(isable)
	self.fntGreenList[index]:setVisible(isable)
	self.fntGrayList[index]:setVisible(isable == false)

end
--设置跟注
function CJoyFiveBet:setKeepBet(value)
	self.keepBetChips = value
	self:updateKeepBetBtn()
end
--设置当前轮次最大下注数
function CJoyFiveBet:setMaxBet(value)
	self.maxBetChips = value
	--判断筹码是否足够
	local roominfo = get_player_info():get_cur_roomInfo()
	self.addBet1 = long_plus(roominfo.minOne,value)
	self.addBet2 = long_plus(long_multiply(roominfo.minOne, 2),value)
	self.addBet3 = long_plus(long_multiply(roominfo.minOne, 3),value)
	self:updateAddBetBtn()
end
--设置当前轮次梭哈数
function CJoyFiveBet:setAllInBet(value)
	self.allInBet = value
end
--跟注
function CJoyFiveBet:updateKeepBetBtn()
	if long_compare(joyfive_manager._ownChips, self.keepBetChips) < 0 then
    	self.panel_ui.btnKeepBet:setEnabled(false)
    	self.panel_ui.btnKeepBet:setBright(false)
    end
end
--加注
function CJoyFiveBet:updateAddBetBtn()
	if (long_compare(joyfive_manager._ownChips, self.addBet1) <= 0) or (long_compare(self.allInBet, self.addBet1) <= 0) then
		self:setAddBetBtnEnabled(false)
	elseif (long_compare(joyfive_manager._ownChips, self.addBet2) <= 0) or (long_compare(self.allInBet, self.addBet2) <= 0) then
		self:setAddBetBtnByIndex(2,false)
		self:setAddBetBtnByIndex(3,false)
	elseif (long_compare(joyfive_manager._ownChips, self.addBet3) <= 0) or (long_compare(self.allInBet, self.addBet3) <= 0) then
		self:setAddBetBtnByIndex(3,false)
	end
end
--梭哈
function CJoyFiveBet:updateBetAllBtn()
	if long_compare(joyfive_manager._ownChips, self.allInBet) < 0 then
		self.panel_ui.btnBetAll:setEnabled(false)
		self.panel_ui.btnBetAll:setBright(false)
	end
end
function CJoyFiveBet:registerHander()
	--跟注
	self.panel_ui.btnKeepBet:onTouch(function (e)
		if e.name == "ended" then
			print("跟注")
			local roominfo = get_player_info():get_cur_roomInfo()
			local mySeat = joyfive_manager._seatsMap[joyfive_manager._mySeatOrder]
			send_happyfive_ReqBetDecision({type = 0,bet = self.keepBetChips ,roomId = roominfo.roomId,tableId = mySeat.tableId})
		end
	end)
	--加注1
	self.panel_ui.btnAddBet1:onTouch(function (e)
		if e.name == "ended" then
			print("加注1")
			local roominfo = get_player_info():get_cur_roomInfo()
			local mySeat = joyfive_manager._seatsMap[joyfive_manager._mySeatOrder]
			send_happyfive_ReqBetDecision({type = 1,bet = self.addBet1 ,roomId = roominfo.roomId,tableId = mySeat.tableId})
		end
	end)
	--加注2
	self.panel_ui.btnAddBet2:onTouch(function (e)
		if e.name == "ended" then
			print("加注2")
			local roominfo = get_player_info():get_cur_roomInfo()
			local mySeat = joyfive_manager._seatsMap[joyfive_manager._mySeatOrder]
			send_happyfive_ReqBetDecision({type = 2,bet = self.addBet2  ,roomId = roominfo.roomId,tableId = mySeat.tableId})
		end
	end)
	--加注3
	self.panel_ui.btnAddBet3:onTouch(function (e)
		if e.name == "ended" then
			print("加注3")
			local roominfo = get_player_info():get_cur_roomInfo()
			local mySeat = joyfive_manager._seatsMap[joyfive_manager._mySeatOrder]
			send_happyfive_ReqBetDecision({type = 3,bet = self.addBet3 ,roomId = roominfo.roomId,tableId = mySeat.tableId})
		end
	end)
	--梭哈
	self.panel_ui.btnBetAll:onTouch(function (e)
		if e.name == "ended" then
			print("梭哈")
			local roominfo = get_player_info():get_cur_roomInfo()
			local mySeat = joyfive_manager._seatsMap[joyfive_manager._mySeatOrder]
			local bet = self.allInBet
			print("bet ====== " ..bet)
			send_happyfive_ReqBetDecision({type = 4,bet = bet ,roomId = roominfo.roomId,tableId = mySeat.tableId})
		end
	end)
	--弃牌
	self.panel_ui.btnGiveUp:onTouch(function (e)
		if e.name == "ended" then
			print("弃牌")
			local roominfo = get_player_info():get_cur_roomInfo()
			local mySeat = joyfive_manager._seatsMap[joyfive_manager._mySeatOrder]
			send_happyfive_ReqBetDecision({type = 5,roomId = roominfo.roomId,tableId = mySeat.tableId})
		end
	end)
end