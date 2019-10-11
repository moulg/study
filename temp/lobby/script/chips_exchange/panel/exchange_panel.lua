#remark
local panel_ui

--上下分固定数
local EXCHANGE_NUM = 1000 * 100

CExchangePanelExt = class("CExchangePanelExt", function ()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
    return ret
end)


function CExchangePanelExt.create()
	local layer = CExchangePanelExt.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end

function CExchangePanelExt:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter();
		elseif event == "exit" then
			self:onExit();
		end
	end

	self:registerScriptHandler(_onEnterOrExit);
end

function CExchangePanelExt:onEnter()
	self:setTouchEnabled(true)
end

function CExchangePanelExt:onExit()

end

function CExchangePanelExt:init_ui()
	local gameId = get_player_info().curGameID
	panel_ui = require(exchange_class_config[gameId].className).create()
	self:addChild(panel_ui.root)
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	panel_ui.root:setPosition(size.width/2, size.height/2)

	self:registerHandler()
end

function CExchangePanelExt:setInfo( chips, gold, callback )
	self.ownchips = chips
	self.callback = callback
	
	local playerinfo = get_player_info()
	local room = playerinfo:get_cur_roomInfo()

	--减去已经兑换的
	local tmpNum = long_divide(chips, room.proportionChips)
	tmpNum = long_multiply(tmpNum, room.proportionGold)
	self.ownGold = long_minus(gold, tmpNum)

	if long_compare(self.ownGold, 0) < 0 then
		self.ownGold = 0 
	end
	
end

function CExchangePanelExt:registerHandler()
	panel_ui.btnClose:onTouch(function (e)
		if e.name == "ended" then
			global_music_ctrl.play_btn_one()
			WindowScene.getInstance():closeDlg(self)
		end
	end)

	--上分
	panel_ui.btnAddChips:onTouch(function (e)
		if e.name == "ended" then
			global_music_ctrl.play_btn_one()
			self:exchangeChips(EXCHANGE_NUM)
			WindowScene.getInstance():closeDlg(self)
		end
	end)

	--下分
	panel_ui.btnReduceChips:onTouch(function (e)
		if e.name == "ended" then
			global_music_ctrl.play_btn_one()
			self:exchangeGold(self.ownchips)
			WindowScene.getInstance():closeDlg(self)
		end
	end)

	--兑换全部
	panel_ui.btnExchangeAll:onTouch(function (e)
		if e.name == "ended" then
			global_music_ctrl.play_btn_one()
			self:exchangeChips(self.ownGold)
			WindowScene.getInstance():closeDlg(self)
		end
	end)
end

function CExchangePanelExt:exchangeChips( gold )
	local playerinfo = get_player_info()
	local room = playerinfo:get_cur_roomInfo()

	if long_compare(gold, 0) == 0 then
		return
	end

	if long_compare(gold, self.ownGold) <= 0 then

		--非比例数量
		local tmp_num 	 = long_divide(gold,room.proportionGold)
		local final_gold = long_multiply(tmp_num,room.proportionGold)
		HallManager:reqExchangeChips(final_gold)

		if self.callback then
			self.callback()
		end
	else
		self:exchangeChips(self.ownGold)
	end
end

function CExchangePanelExt:exchangeGold( chips )
	local playerinfo = get_player_info()
	local room = playerinfo:get_cur_roomInfo()

	if long_compare(chips, 0) == 0 then
		return
	end

	if long_compare(chips, self.ownchips) <= 0 then
		local tmp_num 		= long_divide(chips,room.proportionChips)
		local final_chips 	= long_multiply(tmp_num, room.proportionChips)
		HallManager:reqExchangeGold(final_chips)

		if self.callback then
			self.callback()
		end
	else
		self:exchangeGold(self.ownchips)
	end
end

