--[[
操作界面
]]

local panel_ui = require "game.texaspoker_std.script.ui_create.ui_texaspoker_bet"

CTexasPokerBetExt = class("CTexasPokerBetExt", function ()
	local ret = cc.Node:create()
	return ret
end)


function CTexasPokerBetExt.create()
	local node = CTexasPokerBetExt.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end

function CTexasPokerBetExt:init_ui()
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
	
	self:showHideMingBtn(false)

	texaspoker_manager.isAutoReady = false
	texaspoker_manager.autoSelect = nil
end

function CTexasPokerBetExt:registerHandler()
	--加注
	self.panel_ui.btnAddBet:onTouch(function (e)
		if e.name == "ended" then
			local _playerInfo = get_player_info()
			local mySeat = texaspoker_manager._seatsMap[texaspoker_manager._mySeatOrder]

			if long_compare(self._addBetChips, texaspoker_manager._ownChips) > 0 then
				TipsManager:showOneButtonTipsPanel( 76, {}, true)
				return
			end

			send_texaspoker_ReqBetDecision({type = 2, bet = self._addBetChips, 
				roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
		end
	end)
	--跟注
	self.panel_ui.btnKeepBet:onTouch(function (e)
		if e.name == "ended" then
			local _playerInfo = get_player_info()
			local mySeat = texaspoker_manager._seatsMap[texaspoker_manager._mySeatOrder]

            print("~~~~我要跟注：", self._keepBetChips)
			if long_compare(self._keepBetChips, 0) > 0 then
				send_texaspoker_ReqBetDecision({type = 0, bet = self._keepBetChips, 
					roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
			elseif long_compare(self._keepBetChips, texaspoker_manager._ownChips) > 0 then
				TipsManager:showOneButtonTipsPanel( 76, {}, true)
			else
				send_texaspoker_ReqBetDecision({type = 4, bet = 0, 
					roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
			end
		end
	end)
	
	--弃牌
	self.panel_ui.btnGiveUp:onTouch(function (e)
		if e.name == "ended" then
			local _playerInfo = get_player_info()
			local mySeat = texaspoker_manager._seatsMap[texaspoker_manager._mySeatOrder]

			send_texaspoker_ReqBetDecision({type = 1, bet = 0, 
				roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
		end
	end)
	--梭哈
	self.panel_ui.btnBetAll:onTouch(function (e)
		if e.name == "ended" then
			local _playerInfo = get_player_info()
			local mySeat = texaspoker_manager._seatsMap[texaspoker_manager._mySeatOrder]

			send_texaspoker_ReqBetDecision({type = 3, bet = texaspoker_manager._ownChips, 
				roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
		end
	end)

	--滑动条
	self.panel_ui.slider:setPercent(0)
	self.panel_ui.slider:onEvent(function ( e )
		if e.name == "ON_PERCENTAGE_CHANGED" then
			local tmpNum = long_divide(texaspoker_manager._ownChips, 100)
			local num = long_multiply(tmpNum, self.panel_ui.slider:getPercent())
			if long_compare(num, self._addBottomLimit) < 0 then
				self._addBetChips = self._addBottomLimit
			else
				self._addBetChips = num
			end
			self.panel_ui.editAddBet:setString(self._addBetChips)
		end
	end)

end

--显示/隐藏  下注按钮
function CTexasPokerBetExt:showHideBetButtons(value)
	self.panel_ui.btnAddBet:setVisible(value)
	self.panel_ui.btnKeepBet:setVisible(value)
	self.panel_ui.btnGiveUp:setVisible(value)
	self.panel_ui.btnBetAll:setVisible(value)
	self.panel_ui.ImgInputBj:setVisible(value)
	self.panel_ui.editAddBet:setVisible(value)
	self.panel_ui.slider:setVisible(value)

	if texaspoker_manager.autoSelect == nil then
		self.panel_ui.bg:setVisible(value)
		self.panel_ui.bg:setTouchEnabled(value)
	end

	-- self.panel_ui.editAddBet:setEnabled(value)
end

--显示明牌按钮
function CTexasPokerBetExt:showHideMingBtn(value)
	-- self.panel_ui.btnShowCard:setVisible(value)
end

--设置加注下限
function CTexasPokerBetExt:setRaiseBetLimit(value)
	self._addBottomLimit = value
	self._addBetChips = value

	if long_compare(value, 0) == 0 then
		self.panel_ui.editAddBet:setString(5)
		self._addBetChips = 5		
	else
		self.panel_ui.editAddBet:setString(value)
	end
	local tmpNum = long_multiply(value, 100)
    if long_compare(texaspoker_manager._ownChips, 0) == 0 then
        self.panel_ui.slider:setPercent(0)
    else
        tmpNum = long_divide(tmpNum, texaspoker_manager._ownChips)
	    self.panel_ui.slider:setPercent(tonumber(tmpNum))
    end

    if long_compare(texaspoker_manager._ownChips, self._addBottomLimit) < 0 then
    	self.panel_ui.btnAddBet:setEnabled(false)	
		self.panel_ui.btnAddBet:setBright(false)
	else
		self.panel_ui.btnAddBet:setEnabled(true)	
		self.panel_ui.btnAddBet:setBright(true)	
    end
end

--设置跟注
function CTexasPokerBetExt:setKeepBet(value)
	if long_compare(self._keepBetChips, value) ~= 0 then
		local game_texaspoker = WindowScene.getInstance():getModuleObjByClassName("CTexasPokerMainScene")
		game_texaspoker.panel_ui.sbtnKeepBet:setSelected(false)
		if texaspoker_manager.autoSelect == texaspoker_manager.AUTO_KEEP_BET_ONCE then
			texaspoker_manager.autoSelect = nil
		end
	end
	self._keepBetChips = value
	local game_texaspoker = WindowScene.getInstance():getModuleObjByClassName("CTexasPokerMainScene")
	game_texaspoker.panel_ui.labKeepBet:setString(value)
	-- self.panel_ui.fntKeepBet:setString(value)

	if long_compare(texaspoker_manager._ownChips, self._keepBetChips) < 0 then
    	self.panel_ui.btnKeepBet:setEnabled(false)
    	self.panel_ui.btnKeepBet:setBright(false)
    else
    	self.panel_ui.btnKeepBet:setEnabled(true)
    	self.panel_ui.btnKeepBet:setBright(true)
    end
end


--自动游戏
function CTexasPokerBetExt:autoPlayGame()
	if texaspoker_manager.autoSelect == texaspoker_manager.AUTO_KEEP_BET_ONCE then
		local game_texaspoker = WindowScene.getInstance():getModuleObjByClassName("CTexasPokerMainScene")
		game_texaspoker.panel_ui.sbtnKeepBet:setSelected(false)
		texaspoker_manager.autoSelect = nil
		self:keepBetHandler()
	elseif texaspoker_manager.autoSelect == texaspoker_manager.AUTO_PASS_ABANDON then
		self:passOrAbandonHandler()
	elseif texaspoker_manager.autoSelect == texaspoker_manager.AUTP_KEEP_ANY_BET then
		self:keepBetHandler()
	end
end

--跟注
function CTexasPokerBetExt:keepBetHandler()
	local _playerInfo = get_player_info()
	local mySeat = texaspoker_manager._seatsMap[texaspoker_manager._mySeatOrder]

	if long_compare(self._keepBetChips, 0) > 0 and long_compare(self._keepBetChips, mySeat.chips) <= 0 then
		send_texaspoker_ReqBetDecision({type = 0, bet = self._keepBetChips, 
			roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
	elseif long_compare(self._keepBetChips, mySeat.chips) > 0 then
		send_texaspoker_ReqBetDecision({type = 3, bet = mySeat.chips, 
			roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
	else
		send_texaspoker_ReqBetDecision({type = 4, bet = 0, 
			roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
	end
end

--弃牌让牌
function CTexasPokerBetExt:passOrAbandonHandler()
	local _playerInfo = get_player_info()
	local mySeat = texaspoker_manager._seatsMap[texaspoker_manager._mySeatOrder]

	if long_compare(self._keepBetChips, 0) > 0 then
		send_texaspoker_ReqBetDecision({type = 1, bet = 0, 
			roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
	else
		send_texaspoker_ReqBetDecision({type = 4, bet = 0, 
			roomId = _playerInfo.myDesksInfo[1].roomId, tableId = mySeat.tableId})
	end
end
