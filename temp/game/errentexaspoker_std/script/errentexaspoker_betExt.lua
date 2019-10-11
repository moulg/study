--[[
操作界面
]]

local panel_ui = require "game.errentexaspoker_std.script.ui_create.ui_errentexaspoker_bet"

CErRenTexasPokerBetExt = class("CErRenTexasPokerBetExt", function ()
	local ret = cc.Node:create()
	return ret
end)


function CErRenTexasPokerBetExt.create()
	local node = CErRenTexasPokerBetExt.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end

function CErRenTexasPokerBetExt:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	--加注
	self._addBetChips = 0
	--加注下限
	self._addBottomLimit = 0

	--跟注
	self._keepBetChips = 0

	self:registerHandler()
	-- self:addButtonHightLight()
	-- self:showHideMingBtn(false)

	errentexaspoker_manager.isAutoReady = false
	errentexaspoker_manager.autoSelect = nil
end

function CErRenTexasPokerBetExt:registerHandler()
	-- 加注
	self.panel_ui.btnAddBet:onTouch(function (e)
		if e.name == "ended" then
			local _playerInfo = get_player_info()
			local mySeat = errentexaspoker_manager._seatsMap[errentexaspoker_manager._mySeatOrder]

			if long_compare(self._addBetChips, errentexaspoker_manager._ownChips) > 0 then
				TipsManager:showOneButtonTipsPanel( 76, {}, true)
				return
			else
				if errentexaspoker_manager._bCanBet == true then
					errentexaspoker_manager._bCanBet = false
					send_errentexaspoker_ReqBetDecision({type = 2, bet = self._addBetChips, 
						roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
				end
			end

		end
	end)
	--跟注
	self.panel_ui.btnKeepBet:onTouch(function (e)
		if e.name == "ended" then
			local _playerInfo = get_player_info()
			local mySeat = errentexaspoker_manager._seatsMap[errentexaspoker_manager._mySeatOrder]

            print("~~~~我要跟注：", self._keepBetChips)
			if long_compare(self._keepBetChips, 0) > 0 then
				if errentexaspoker_manager._bCanBet == true then
					errentexaspoker_manager._bCanBet = false
					send_errentexaspoker_ReqBetDecision({type = 0, bet = self._keepBetChips, 
						roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
				end
			elseif long_compare(self._keepBetChips, errentexaspoker_manager._ownChips) > 0 then
				TipsManager:showOneButtonTipsPanel( 76, {}, true)
			else
				if errentexaspoker_manager._bCanBet == true then
					errentexaspoker_manager._bCanBet = false
					send_errentexaspoker_ReqBetDecision({type = 4, bet = 0, 
						roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
				end
			end
		end
	end)

	--弃牌
	self.panel_ui.btnGiveUp:onTouch(function (e)
		if e.name == "ended" then
			local _playerInfo = get_player_info()
			local mySeat = errentexaspoker_manager._seatsMap[errentexaspoker_manager._mySeatOrder]
			if errentexaspoker_manager._bCanBet == true then
				errentexaspoker_manager._bCanBet = false
				send_errentexaspoker_ReqBetDecision({type = 1, bet = 0, 
					roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
			end
		end
	end)
	--梭哈
	self.panel_ui.btnBetAll:onTouch(function (e)
		if e.name == "ended" then
			local _playerInfo = get_player_info()
			local mySeat = errentexaspoker_manager._seatsMap[errentexaspoker_manager._mySeatOrder]
			if errentexaspoker_manager._bCanBet == true then
				errentexaspoker_manager._bCanBet = false
				send_errentexaspoker_ReqBetDecision({type = 3, bet = errentexaspoker_manager._ownChips, 
					roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
			end
		end
	end)


	--滑动条
	self.panel_ui.slider:setPercent(0)
	self.panel_ui.slider:onEvent(function ( e )
		if e.name == "ON_PERCENTAGE_CHANGED" then
			local value = self.panel_ui.slider:getPercent()
			local tmpNum = long_multiply(errentexaspoker_manager._ownChips, value)
			local num = long_divide(tmpNum, 100)
			if self.panel_ui.slider:getPercent() == 100 then
				num = errentexaspoker_manager._ownChips
			end
			if long_compare(num, self._addBottomLimit) < 0 then
				self._addBetChips = self._addBottomLimit
			else
				self._addBetChips = num
			end
			-- self.panel_ui.editAddBet:setString(self._addBetChips)
			self.panel_ui.editAddBet:setStringEx(self._addBetChips)
		end
	end)

	--输入框
	self.panel_ui.editAddBet:setInputTextMod(1)
	-- self.panel_ui.editAddBet:setSelectColor(cc.c4b(255,0,0,255))
	self.panel_ui.editAddBet:setTextChangeCall(function (txt)
		print("txt == " ..txt)
		local num = txt
		if num == nil or num == "" then
			return
		end

		if long_compare(num, errentexaspoker_manager._ownChips) > 0 then
			num = errentexaspoker_manager._ownChips
			self.panel_ui.editAddBet:setStringEx(num)
		end

		if long_compare(num, self._addBottomLimit) < 0 then
			self.panel_ui.btnAddBet:setEnabled(false)	
			self.panel_ui.btnAddBet:setBright(false)
		else
			self.panel_ui.btnAddBet:setEnabled(true)	
			self.panel_ui.btnAddBet:setBright(true)
		end

		self._addBetChips = num
		local tmpNum = long_multiply(num, 100)
        if long_compare(errentexaspoker_manager._ownChips, 0) == 0 then
            self.panel_ui.slider:setPercent(0)
        else
            tmpNum = long_divide(tmpNum, errentexaspoker_manager._ownChips)
	        self.panel_ui.slider:setPercent(tonumber(tmpNum))
        end
	end)

end

--按钮高亮
function CErRenTexasPokerBetExt:addButtonHightLight()
	local btnArr = {self.panel_ui.btnAddChips,self.panel_ui.btnAddBet, 
					self.panel_ui.btnKeepBet,self.panel_ui.btnGiveUp,
					self.panel_ui.btnBetAll}

	local resArr = {"上分高亮","加注高亮", 
					"跟注高亮", "弃牌高亮",
					"梭哈高亮",}
	for i,btn in ipairs(btnArr) do
		local mov_obj = cc.Sprite:create(errentexaspoker_imageRes_config[resArr[i]].resPath)
		WindowScene.getInstance():registerBtnMouseMoveEff(btn,mov_obj,1)
	end
end


--显示操作界面
function CErRenTexasPokerBetExt:showHideBetButtons(value)

	-- print("显示操作界面")
	-- print(value)

	self.panel_ui.bg:setVisible(value)
	self.panel_ui.btnAddBet:setVisible(value)
	self.panel_ui.btnKeepBet:setVisible(value)
	self.panel_ui.btnGiveUp:setVisible(value)
	self.panel_ui.btnBetAll:setVisible(value)
	self.panel_ui.editAddBet:setVisible(value)
	self.panel_ui.slider:setVisible(value)
	-- if errentexaspoker_manager.autoSelect == nil then
	-- 	self.panel_ui.bg:setVisible(value)
	-- 	self.panel_ui.bg:setTouchEnabled(value)
	-- end	
end


--设置加注下限
function CErRenTexasPokerBetExt:setRaiseBetLimit(value)
	self._addBottomLimit = value
	self._addBetChips = value

	if long_compare(value, 0) == 0 then
		self.panel_ui.editAddBet:setString(5)
		self._addBetChips = 5		
	else
		self.panel_ui.editAddBet:setString(value)
	end
	local tmpNum = long_multiply(self._addBetChips, 100)
    if long_compare(errentexaspoker_manager._ownChips, 0) == 0 then
        self.panel_ui.slider:setPercent(0)
    else
        tmpNum = long_divide(tmpNum, errentexaspoker_manager._ownChips)
	    self.panel_ui.slider:setPercent(tonumber(tmpNum))
	    --设置滑动条最小允许滑动值 
	    -- local bottomLimitNum = long_divide(long_multiply(self._addBottomLimit, 100), errentexaspoker_manager._ownChips)
	    -- self.panel_ui.slider:setMinimumAllowedValue(bottomLimitNum)
    end
    if long_compare(errentexaspoker_manager._ownChips, self._addBottomLimit) < 0 then
    	self.panel_ui.btnAddBet:setEnabled(false)	
		self.panel_ui.btnAddBet:setBright(false)
	else
		self.panel_ui.btnAddBet:setEnabled(true)	
		self.panel_ui.btnAddBet:setBright(true)	
    end
end

--设置跟注
function CErRenTexasPokerBetExt:setKeepBet(value)
	if long_compare(self._keepBetChips, value) ~= 0 then
		local cObject = WindowScene.getInstance():getModuleObjByClassName("CErRenTexasPokerMainScene")
		cObject.auto_ui.panel_ui.sbtnKeepBet:setSelected(false)

		if errentexaspoker_manager.autoSelect == errentexaspoker_manager.AUTO_KEEP_BET_ONCE then
			errentexaspoker_manager.autoSelect = nil
		end
	end
	self._keepBetChips = value
	-- self.panel_ui.fntKeepBet:setString(value)

	if long_compare(errentexaspoker_manager._ownChips, self._keepBetChips) < 0 then
    	self.panel_ui.btnKeepBet:setEnabled(false)
    	self.panel_ui.btnKeepBet:setBright(false)
    else
    	self.panel_ui.btnKeepBet:setEnabled(true)
    	self.panel_ui.btnKeepBet:setBright(true)
    end
end


--自动游戏
function CErRenTexasPokerBetExt:autoPlayGame()
	if errentexaspoker_manager.autoSelect == errentexaspoker_manager.AUTO_KEEP_BET_ONCE then
		local cObject = WindowScene.getInstance():getModuleObjByClassName("CErRenTexasPokerMainScene")
		cObject.auto_ui.panel_ui.sbtnKeepBet:setSelected(false)
		errentexaspoker_manager.autoSelect = nil
		self:keepBetHandler()
	elseif errentexaspoker_manager.autoSelect == errentexaspoker_manager.AUTO_PASS_ABANDON then
		self:passOrAbandonHandler()
	elseif errentexaspoker_manager.autoSelect == errentexaspoker_manager.AUTP_KEEP_ANY_BET then
		self:keepBetHandler()
	end
end

--跟注
function CErRenTexasPokerBetExt:keepBetHandler()
	local _playerInfo = get_player_info()
	local mySeat = errentexaspoker_manager._seatsMap[errentexaspoker_manager._mySeatOrder]

	if long_compare(self._keepBetChips, 0) > 0 and long_compare(self._keepBetChips, mySeat.chips) <= 0 then
		send_errentexaspoker_ReqBetDecision({type = 0, bet = self._keepBetChips, 
			roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
	elseif long_compare(self._keepBetChips, mySeat.chips) > 0 then
		send_errentexaspoker_ReqBetDecision({type = 3, bet = mySeat.chips, 
			roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
	else
		send_errentexaspoker_ReqBetDecision({type = 4, bet = 0, 
			roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
	end
end

--弃牌让牌
function CErRenTexasPokerBetExt:passOrAbandonHandler()
	local _playerInfo = get_player_info()
	local mySeat = errentexaspoker_manager._seatsMap[errentexaspoker_manager._mySeatOrder]

	if long_compare(self._keepBetChips, 0) > 0 then
		send_errentexaspoker_ReqBetDecision({type = 1, bet = 0, 
			roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
	else
		send_errentexaspoker_ReqBetDecision({type = 4, bet = 0, 
			roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
	end
end
