--[[

挂机设置界面
]]

local panel_ui = require "game.shuihu_std.script.ui_create.ui_autoGame_set"
local MAX_LINE = 9


CAutoGameSetExt = class("CAutoGameSetExt", function ()
	local ret = cc.Node:create()
	return ret
end)

function CAutoGameSetExt.create()
	-- body
	local node = CAutoGameSetExt.new()
	if node ~= nil then
		node:init_ui()
		return node
	end
end

function CAutoGameSetExt:regEnterExit()
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

function CAutoGameSetExt:onEnter()
 
end

function CAutoGameSetExt:onExit()

end

function CAutoGameSetExt:onShow()
	self:setVisible(true)
	self:setAutoNum(shuihu_manager._autoCount)
end

function CAutoGameSetExt:onHide()
	self:setVisible(false)
end

function CAutoGameSetExt:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	self:registerHandler()

	self:addButtonHightLight()

	self:setAutoNum(0)
	self:setCompareCount(0)
	self:setSingleWinLimit(0)
	self:setTotalWinLimit(0)

	shuihu_manager._compareType = shuihu_manager.COMPARE_TYPE_HALF
	shuihu_manager._betType = shuihu_manager.BET_TYPE_XIAO
	shuihu_manager._isLimitSingleWin = false
	shuihu_manager._isLimitTotalWin = false
	shuihu_manager._isAutoExchange = false
end

function CAutoGameSetExt:addButtonHightLight()
	local btnArr = {self.panel_ui.btnReduceCount, self.panel_ui.btnAddCount, 
				self.panel_ui.btnReduceCompareCount, self.panel_ui.btnAddCompareCount,
				self.panel_ui.btnReduceSingleLimit, self.panel_ui.btnAddSingleLimit,
				self.panel_ui.btnReduceTotalLimit, self.panel_ui.btnAddTotalLimit,
				self.panel_ui.btnClose, self.panel_ui.btnSave,}

	local resArr = {"reduceMoveOver", "addMoveOver",
					"reduceMoveOver", "addMoveOver",
					"reduceMoveOver", "addMoveOver",
					"reduceMoveOver", "addMoveOver",
					"closeMoveOver", "saveMoveOver",}

	for i,btn in ipairs(btnArr) do
		local mov_obj = cc.Sprite:create(shuihuImageRes_config[resArr[i]].resPath)
		WindowScene.getInstance():registerBtnMouseMoveEff(btn,mov_obj,1)
	end
end

function CAutoGameSetExt:registerHandler()
	--自动次数
	self.panel_ui.btnReduceCount:onTouch(function (e)
		if e.name == "ended" then
			if shuihu_manager._autoCount > 0 then
				self:setAutoNum(shuihu_manager._autoCount - 1)
			end
		end
	end)
	self.panel_ui.btnAddCount:onTouch(function (e)
		if e.name == "ended" then
			self:setAutoNum(shuihu_manager._autoCount + 1)
		end
	end)
	self.panel_ui.editAutoCount:setInputTextMod(1, 9999)
	self.panel_ui.editAutoCount:setMarkTexture("lobby/resource/general/insert_mark2.png")
	self.panel_ui.editAutoCount:setTextChangeCall(function (txt)
		shuihu_manager._autoCount = tonumber(txt) == nil and 0 or tonumber(txt)
		self:setAutoNum(shuihu_manager._autoCount)
	end)


	--比倍次数
	self.panel_ui.btnReduceCompareCount:onTouch(function (e)
		if e.name == "ended" then
			if shuihu_manager._compareCount > 0 then
				self:setCompareCount( shuihu_manager._compareCount - 1 )
			end
		end
	end)
	self.panel_ui.btnAddCompareCount:onTouch(function (e)
		if e.name == "ended" then
			self:setCompareCount( shuihu_manager._compareCount + 1 )
		end
	end)
	self.panel_ui.editCompareCount:setInputTextMod(1, 99)
	self.panel_ui.editCompareCount:setMarkTexture("lobby/resource/general/insert_mark2.png")
	self.panel_ui.editCompareCount:setTextChangeCall(function (txt)
		shuihu_manager._compareCount = tonumber(txt) == nil and 0 or tonumber(txt)
		self:setCompareCount(shuihu_manager._compareCount)
	end)

	--单局赢上限
	self.panel_ui.btnReduceSingleLimit:onTouch(function (e)
		if e.name == "ended" then
			if shuihu_manager._singleWinLimit > 0 then
				self:setSingleWinLimit( shuihu_manager._singleWinLimit - 1 )
			end
		end
	end)
	self.panel_ui.btnAddSingleLimit:onTouch(function (e)
		if e.name == "ended" then
			self:setSingleWinLimit( shuihu_manager._singleWinLimit + 1 )
		end
	end)
	self.panel_ui.editSingleLimit:setInputTextMod(1, 999999999)
	self.panel_ui.editSingleLimit:setMarkTexture("lobby/resource/general/insert_mark2.png")
	self.panel_ui.editSingleLimit:setTextChangeCall(function (txt)
		shuihu_manager._singleWinLimit = tonumber(txt) == nil and 0 or tonumber(txt)
		self:setSingleWinLimit(shuihu_manager._singleWinLimit)
	end)

	--总体赢上限
	self.panel_ui.btnReduceTotalLimit:onTouch(function (e)
		if e.name == "ended" then
			if shuihu_manager._totalWinLimit > 0 then
				self:setTotalWinLimit( shuihu_manager._totalWinLimit - 1 )
			end
		end
	end)
	self.panel_ui.btnAddTotalLimit:onTouch(function (e)
		if e.name == "ended" then
			self:setTotalWinLimit( shuihu_manager._totalWinLimit + 1 )
		end
	end)
	self.panel_ui.editTotalLimit:setInputTextMod(1, 999999999)
	self.panel_ui.editTotalLimit:setMarkTexture("lobby/resource/general/insert_mark2.png")
	self.panel_ui.editTotalLimit:setTextChangeCall(function (txt)
		shuihu_manager._totalWinLimit = tonumber(txt) == nil and 0 or tonumber(txt)
		self:setTotalWinLimit(shuihu_manager._totalWinLimit)
	end)

	--保存
	self.panel_ui.btnSave:onTouch(function (e)
		if e.name == "ended" then
			shuihu_manager:showHideAutoSetPanel()
		end
	end)

	--关闭
	self.panel_ui.btnClose:onTouch(function (e)
		if e.name == "ended" then
			self:setAutoNum(0)
			self:setCompareCount(0)
			self:setSingleWinLimit(0)
			self:setTotalWinLimit(0)

			shuihu_manager:showHideAutoSetPanel()

			--音效
			audio_manager:playOtherSound(38)
		end
	end)

	--比倍类型 选择
	local compareTypecallback = function (sender, eventType)
		if sender == self.panel_ui.sbtnHalf then
			shuihu_manager._compareType = shuihu_manager.COMPARE_TYPE_HALF
		elseif sender == self.panel_ui.sbtnAll then
			shuihu_manager._compareType = shuihu_manager.COMPARE_TYPE_ALL
		elseif sender == self.panel_ui.sbtnDouble then
			shuihu_manager._compareType = shuihu_manager.COMPARE_TYPE_DOUBEL
		end
	end

	local btn_group_lst = {self.panel_ui.sbtnHalf,self.panel_ui.sbtnAll,self.panel_ui.sbtnDouble,}
	WindowScene.getInstance():registerGroupEvent(btn_group_lst,compareTypecallback)

	--押注类型 选择
	local betTypecallback = function (sender, eventType)
		if sender == self.panel_ui.sbtnXiao then
			shuihu_manager._betType = shuihu_manager.BET_TYPE_XIAO
		elseif sender == self.panel_ui.sbtnHe then
			shuihu_manager._betType = shuihu_manager.BET_TYPE_HE
		elseif sender == self.panel_ui.sbtnDa then
			shuihu_manager._betType = shuihu_manager.BET_TYPE_DA
		end
	end

	local btn_group_lst = {self.panel_ui.sbtnXiao,self.panel_ui.sbtnHe,self.panel_ui.sbtnDa,}
	WindowScene.getInstance():registerGroupEvent(btn_group_lst,betTypecallback)

	--是否勾选 单注赢取上限
	self.panel_ui.checkBox_singleLimit:addEventListener(function (sender,eventType)
		if eventType == ccui.CheckBoxEventType.selected then
	     	shuihu_manager._isLimitSingleWin = true  
	    elseif eventType == ccui.CheckBoxEventType.unselected then
	        shuihu_manager._isLimitSingleWin = false
	    end
	end)
	--是否勾选 总体赢取上限
	self.panel_ui.checkBox_totalLimit:addEventListener(function (sender,eventType)
		if eventType == ccui.CheckBoxEventType.selected then
	     	shuihu_manager._isLimitTotalWin = true  
	    elseif eventType == ccui.CheckBoxEventType.unselected then
	        shuihu_manager._isLimitTotalWin = false
	    end
	end)
	--是否自动兑换筹码
	self.panel_ui.checkBox_autoExchange:addEventListener(function (sender,eventType)
		if eventType == ccui.CheckBoxEventType.selected then
	     	shuihu_manager._isAutoExchange = true  
	    elseif eventType == ccui.CheckBoxEventType.unselected then
	        shuihu_manager._isAutoExchange = false
	    end
	end)
end

--自动次数
function CAutoGameSetExt:setAutoNum( value )
	self.panel_ui.editAutoCount:setStringEx(value)
	shuihu_manager._autoCount = value
end

--押线
function CAutoGameSetExt:setLineNum( value )
	self.panel_ui.fntLine:setString(value)
end

--单线押注
function CAutoGameSetExt:setSingleBetChips( value )
	self.panel_ui.fntBetChips:setString(value)
end

--比倍次数
function CAutoGameSetExt:setCompareCount( value )
	self.panel_ui.editCompareCount:setStringEx(value)
	shuihu_manager._compareCount = value
end

--单局赢取上限
function CAutoGameSetExt:setSingleWinLimit( value )
	self.panel_ui.editSingleLimit:setStringEx(value)
	shuihu_manager._singleWinLimit = value
end

--总赢取上限
function CAutoGameSetExt:setTotalWinLimit( value )
	self.panel_ui.editTotalLimit:setStringEx(value)
	shuihu_manager._totalWinLimit = value
end
