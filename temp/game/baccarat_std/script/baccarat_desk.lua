--[[

桌子信息
]]

local desk_item_ui = require "game.baccarat_std.script.ui_create.ui_baccarat_desk"

local _contentSize = cc.size(815, 590)

CBaccaratDesk = class("CBaccaratDesk",function()
	-- body
	local  ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:setContentSize(_contentSize)
    ret:setAnchorPoint(0, 0)
	return ret
end)

function CBaccaratDesk.getContentSize()
	return _contentSize
end

function CBaccaratDesk.create()
	-- body
	local layer = CBaccaratDesk.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end

function CBaccaratDesk:regEnterExit()
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

function CBaccaratDesk:onEnter()
	
end

function CBaccaratDesk:onExit()
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.desk_item_ui_list.btn_goin)
end

function CBaccaratDesk:init_ui()
	
	self.desk_item_ui_list = desk_item_ui.create()
	self:addChild(self.desk_item_ui_list.root)
	self.desk_item_ui_list.root:setAnchorPoint(0, 0)
	self.desk_item_ui_list.root:setPosition(self:getContentSize().width / 2,self:getContentSize().height / 2)

	--进入游戏桌子
	local function __on_enter_deskclick( e )
		-- body
		self:onEnterDeskClick(e)
	end
	self.desk_item_ui_list.btn_goin:onTouch(__on_enter_deskclick)

	local mov_obj = cc.Sprite:create("game/baccarat_std/resource/image/desk/jryx2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.desk_item_ui_list.btn_goin,mov_obj,1)

end

function CBaccaratDesk:updateSeatInfo( seat )
	for k,v in pairs(self.desk_info.seats) do
		if v.order == seat.order then
			self.desk_info.seats[k] = seat

			self:setDeskInfo( self.desk_info )			
			return true
		end
	end

	return false
end

function CBaccaratDesk:setDeskInfo( info )
	-- body
	self.desk_info = info
end

function CBaccaratDesk:onEnterDeskClick( e )
	-- body
	if e.name == "ended" then
	    local tableID = self.desk_info.seats[1].tableId
	    local roomID = self.desk_info.roomId
		HallManager:sendEnterTableMsg({roomId = self.desk_info.roomId ,tableId = self.desk_info.seats[1].tableId})
	end
end
