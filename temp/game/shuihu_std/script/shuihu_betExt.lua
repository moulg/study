--[[

押注界面
]]

local panel_ui = require "game.shuihu_std.script.ui_create.ui_shuihu_bet"
local MAX_LINE = 9

-- require "game.shuihu_std.script.autoGameSetExt"

CShuiHuBetExt = class("CShuiHuBetExt", function ()
	local ret = cc.Node:create()
	return ret
end)

function CShuiHuBetExt.create()
	-- body
	local node = CShuiHuBetExt.new()
	if node ~= nil then
        node:regEnterExit()
		node:init_ui()
		return node
	end
end

function CShuiHuBetExt:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter();
		elseif event == "exit" then
			self:onExit();
		end
	end

	self:registerScriptHandler(_onEnterOrExit)
end

function CShuiHuBetExt:onEnter()
   EventUtils.addEventListener(EventUtils.GOLD_CHANGE, self, function ()
   		self:setGold()
   end)
end

function CShuiHuBetExt:onExit()
	EventUtils.removeEventListener(EventUtils.GOLD_CHANGE, self)
end

function CShuiHuBetExt:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	self.btnList = {self.panel_ui.btnBet1, self.panel_ui.btnBet2, 
					self.panel_ui.btnBet3, self.panel_ui.btnBet4,
					self.panel_ui.btnReduceLine, self.panel_ui.btnAddLine,
					self.panel_ui.btnFullLine, self.panel_ui.btnClean,}
	self.btnAddBetList = {self.panel_ui.btnBet1, self.panel_ui.btnBet2, 
					self.panel_ui.btnBet3, self.panel_ui.btnBet4,}
	for k,v in pairs(self.btnAddBetList) do
		v:setTag(k)
	end

	-- 头像
	local sex = get_player_info().sex == "男" and 0 or 1
	uiUtils:setPhonePlayerHead(self.panel_ui.imgHead, sex, uiUtils.HEAD_SIZE_223)

	self:registerHandler()

	-- self:addButtonHightLight()

	local pinfo = get_player_info()
	self.panel_ui.labGold:setString(pinfo.gold)

	local name = textUtils.replaceStr(pinfo.name, NAME_BITE_LIMIT, "..")
	self.panel_ui.labName:setString(name)
	self.panel_ui.labID:setString(pinfo.id)
	self:setChips(0)
	self:setLineNum(0)
	self:setSingleBetChips(0)

end

function CShuiHuBetExt:addButtonHightLight()
	local btnArr = {self.panel_ui.btnReduceChips, self.panel_ui.btnAddChips, 
				self.panel_ui.btnReduceLine, self.panel_ui.btnAddLine,
				self.panel_ui.btnReduceBet, self.panel_ui.btnAddBet,
				self.panel_ui.btnFullLine, self.panel_ui.btnMaxBet,
				self.panel_ui.btnStop, self.panel_ui.btnStart,
				self.panel_ui.btnAuto,}

	local resArr = {"reduceBigMoveOver", "addBigMoveOver",
					"reduceMoveOver", "addMoveOver",
					"reduceMoveOver", "addMoveOver",
					"fullLineMoveOver", "maxBetMoveOver",
					"stopMoveOver", "startMoveOver",
					"autoMoveOver",}

	for i,btn in ipairs(btnArr) do
		local mov_obj = cc.Sprite:create(shuihuImageRes_config[resArr[i]].resPath)
		WindowScene.getInstance():registerBtnMouseMoveEff(btn,mov_obj,1)
	end
end

function CShuiHuBetExt:showHideAutoSetPanel()
	if self.autoSetPanel:isVisible() then
		self.autoSetPanel:onHide()
		self.panel_ui.root:setVisible(true)
	else
		self.autoSetPanel:onShow()
		self.panel_ui.root:setVisible(false)
	end
end

--禁用/启用按钮
function CShuiHuBetExt:setButtonsEnable(value)
	for i,v in ipairs(self.btnList) do
		v:setEnabled(value)
		v:setBright(value)
	end

	if value == false then
		self.panel_ui.btnStart:setEnabled(value)
		self.panel_ui.btnStart:setBright(value)
		if shuihu_manager._isAutoPlayGame == false then
			self.panel_ui.btnAuto:setEnabled(value)
			self.panel_ui.btnAuto:setBright(value)
		end
	else
		self:resetStartButtonState()

		-- self.panel_ui.btnStop:setVisible(false)
		self.panel_ui.btnStart:setVisible(true)
	end
end

function CShuiHuBetExt:registerHandler()
	self.panel_ui.btnExchange:onTouch(function (e)
		if e.name == "ended" then
			local playerInfo = get_player_info()
			TipsManager:showExchangePanel(shuihu_manager._ownChips, playerInfo.gold)
			--音效
			audio_manager:playOtherSound(37)
		end
	end)
	--押线增减
	self.panel_ui.btnReduceLine:onTouch(function (e)
		if e.name == "ended" then
			if shuihu_manager._lineNum > 0 then
				self:setLineNum( shuihu_manager._lineNum - 1 )
			end
			--音效
			audio_manager:playOtherSound(37)
		end
	end)
	self.panel_ui.btnAddLine:onTouch(function (e)
		if e.name == "ended" then
			local tmpNum = long_multiply((shuihu_manager._lineNum + 1), shuihu_manager._singleBetChips)
			if shuihu_manager._lineNum < MAX_LINE and long_compare(tmpNum, shuihu_manager._ownChips) <= 0 then
				self:setLineNum( shuihu_manager._lineNum + 1 )
			end
			--音效
			audio_manager:playOtherSound(37)
		end
	end)

	--满线
	self.panel_ui.btnFullLine:onTouch(function (e)
		if e.name == "ended" then
			local tmpNum = long_multiply(MAX_LINE, shuihu_manager._singleBetChips)
			if long_compare(tmpNum, shuihu_manager._ownChips) <= 0 then
				self:setLineNum(MAX_LINE)
			end

			--音效
			audio_manager:playOtherSound(37)
		end
	end)
	
	--开始
	self.panel_ui.btnStart:onTouch(function (e)
		if e.name == "ended" then
			self:quickStartGame()
		end
	end)
	--自动
	self.panel_ui.btnAuto:onEvent(function (e)
		if e.name == "selected" then
			--音效
			audio_manager:playOtherSound(37)
			shuihu_manager._isAutoPlayGame = true
			self:quickStartGame()
		else
			--音效
			audio_manager:playOtherSound(37)
			shuihu_manager._isAutoPlayGame = false
		end
	end)

	--退出
	self.panel_ui.btnExit:onTouch(function (e)
		if e.name == "ended" then
			--音效
			audio_manager:playOtherSound(37)
			if shuihu_manager._isAutoPlayGame == false and shuihu_manager._gameIsGoing == false then
				send_shuihu_ReqExitTable()
			else
				TipsManager:showOneButtonTipsPanel( 78, {}, true)
			end
		end
	end)

	--清空
	self.panel_ui.btnClean:onTouch(function (e)
		if e.name == "ended" then
			--音效
			audio_manager:playOtherSound(37)
			self:setSingleBetChips(0)
		end
	end)

	--单线押注增加
	for k,v in pairs(self.btnAddBetList) do
		v:onTouch(function(e)
			if e.name == "ended" then
				--音效
				audio_manager:playOtherSound(37)
				local tag = e.target:getTag()
                
                print("tag ...", tag)

				local singleBet = long_plus(10 ^ tonumber(tag), shuihu_manager._singleBetChips)

				print("bet ....", singleBet)

				local tmpNum = long_multiply(singleBet, shuihu_manager._lineNum)
				if long_compare(tmpNum, shuihu_manager._ownChips) > 0 or long_compare(singleBet, shuihu_manager._ownChips) > 0 then
					local playerInfo = get_player_info()
					TipsManager:showExchangePanel(shuihu_manager._ownChips, playerInfo.gold)
					self:setSingleBetChips(shuihu_manager._singleBetChips)
					return
				end
				self:setSingleBetChips(singleBet)

			end
		end)
	end
end

function CShuiHuBetExt:setGold()
	local pinfo = get_player_info()
	
	self.panel_ui.labGold:setString(pinfo.gold)
end

--筹码
function CShuiHuBetExt:setChips( value )
	self.panel_ui.fntChips:setString(value)
	shuihu_manager._ownChips = value

	--重新设置按钮状态
    if shuihu_manager._gameIsGoing == false then
	    self:resetStartButtonState()
    end
end

--总押注
function CShuiHuBetExt:setTotalBetChips( value )
	self.panel_ui.fntTotalBet:setString(value)
	shuihu_manager._totalBetChips = value

	--重新设置按钮状态
	self:resetStartButtonState()

	if value == 0 then
		shuihu_manager:showWordTips( 1 )
	else
		shuihu_manager:showWordTips( 2 )
	end
end

--押线
function CShuiHuBetExt:setLineNum( value )
	self.panel_ui.fntLineNum:setString(value)
	shuihu_manager:setBetLineNum(value)

	self:setTotalBetChips( long_multiply(shuihu_manager._singleBetChips, shuihu_manager._lineNum) )
	-- self.autoSetPanel:setLineNum(value)
end

--单线押注
function CShuiHuBetExt:setSingleBetChips( value )
	self.panel_ui.editSingleBet:setString(value)
	shuihu_manager._singleBetChips = value

	self:setTotalBetChips( long_multiply(shuihu_manager._singleBetChips, shuihu_manager._lineNum) )
	-- self.autoSetPanel:setSingleBetChips(value)
end


--重新设置开始按钮状态
function CShuiHuBetExt:resetStartButtonState()
	local isEnable = long_compare(shuihu_manager._totalBetChips, shuihu_manager._ownChips) <= 0 and long_compare(shuihu_manager._totalBetChips, 0) > 0 
	self.panel_ui.btnStart:setEnabled(isEnable)
	self.panel_ui.btnStart:setBright(isEnable)
	self.panel_ui.btnAuto:setEnabled(isEnable)
	self.panel_ui.btnAuto:setBright(isEnable)
end

--开始水浒传游戏
function CShuiHuBetExt:startGame()
	send_shuihu_ReqShuiHuStart({line = shuihu_manager._lineNum, bet = shuihu_manager._singleBetChips})

    shuihu_manager._gameIsGoing = true
	self:setButtonsEnable(false)

	if long_compare(shuihu_manager._totalBetChips, shuihu_manager._ownChips) > 0 then
		shuihu_manager._isAutoPlayGame = false
		self.panel_ui.btnStart:setVisible(false)
	end

	-- if shuihu_manager._autoCount > 0 then
	-- 	self.panel_ui.btnStart:setVisible(false)
	-- 	-- self.panel_ui.btnStop:setVisible(true)

	-- 	shuihu_manager._isAutoPlayGame = true
	-- end
end

--继续水浒传游戏
function CShuiHuBetExt:continueGame()
	if shuihu_manager._isAutoPlayGame then
		self:startGame()
	else
		shuihu_manager._gameIsGoing = false
		self:setButtonsEnable(true)
	end
end

--快捷开始水浒传游戏
function CShuiHuBetExt:quickStartGame()
	if self.panel_ui.btnStart:isEnabled() then
		self:startGame()

		--音效
		audio_manager:playOtherSound(39)
	end
end