--[[
4人牛牛

]]

local SEAT_NUM = 4

local desk_item_ui = require "game.foursniuniu_std.script.ui_create.ui_4p_niuniu_desk"

local _contentSize = cc.size(346, 284)

C4pNiuNiuDesk = class("C4pNiuNiuDesk", function ()
	-- body
	local  ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:setContentSize(_contentSize)
    ret:setAnchorPoint(0, 0)
	return ret
end)

function C4pNiuNiuDesk.getContentSize()
	return _contentSize
end

function C4pNiuNiuDesk.create()
	-- body
	local layer = C4pNiuNiuDesk.new()
	if layer ~= nil then
		layer:init_ui()
		return layer
	end
end

function C4pNiuNiuDesk:init_ui()
	
	self.desk_item_ui_list = desk_item_ui.create()
	self:addChild(self.desk_item_ui_list.root)
	self.desk_item_ui_list.root:setAnchorPoint(0, 0)
	self.desk_item_ui_list.root:setPosition(self:getContentSize().width / 2,self:getContentSize().height / 2)

	--进入游戏桌子
	local function __on_enter_deskclick( e )
		-- body
		self:onEnterDeskClick(e)
	end

    
	for i=0,SEAT_NUM-1 do
        local key = "btnPlayer"..i
		self.desk_item_ui_list[key]:onTouch(__on_enter_deskclick)
	end

end

function C4pNiuNiuDesk:updatePassword(value)
	self.desk_info.hasPwd = value
	self.desk_item_ui_list.imgLock:setVisible(value == 1)
end

function C4pNiuNiuDesk:updateSeatInfo( seat )
	for k,v in pairs(self.desk_info.seats) do
		if v.order == seat.order then
			self.desk_info.seats[k] = seat

			self:setDeskInfo( self.desk_info )			
			return true
		end
	end

	return false
end

function C4pNiuNiuDesk:setDeskInfo( info )
	-- body
	self.desk_info = info
	self.isPlaying = false

	local id = info.id % 10000
	self.desk_item_ui_list.labTableID:setString("- "..id.." -")
	self.desk_item_ui_list.imgLock:setVisible(info.hasPwd == 1)

    local key = ""
	for i,v in ipairs(info.seats) do
        key = "btnPlayer"..v.order
		self.desk_item_ui_list[key].seatData = v

		if long_compare(v.playerId, 0) == 0 then
            key = "labName"..v.order
			self.desk_item_ui_list[key]:setString("")

            key = "btnPlayer"..v.order
			self.desk_item_ui_list[key]:setEnabled(true)
			self.desk_item_ui_list[key]:setBright(true)

            key = "imgRead"..v.order
			self.desk_item_ui_list[key]:setVisible(false)
		else
            key = "labName"..v.order
			self.desk_item_ui_list[key]:setString(textUtils.replaceStr(v.playerName, NAME_BITE_LIMIT, ".."))

            key = "btnPlayer"..v.order
			local res = uiUtils:getHeadResUrl(v.icon, uiUtils.HEAD_SIZE_35)
			self.desk_item_ui_list[key]:loadTextureDisabled(res)
			self.desk_item_ui_list[key]:setEnabled(false)
			self.desk_item_ui_list[key]:setBright(false)

            key = "imgRead"..v.order
			if v.state == 2 then
				self.desk_item_ui_list[key]:setVisible(true)
			else
				self.desk_item_ui_list[key]:setVisible(false)
			end

			if v.state == 3 then
				self.isPlaying = true
			end
		end
	end

	if self.isPlaying == false then
		self.desk_item_ui_list.imgDesk:setTexture("game/foursniuniu_std/resource/image/z1.png")
	else
        for i=0,SEAT_NUM-1 do
            key = "imgRead"..i
			self.desk_item_ui_list[key]:setVisible(false)
		end
		self.desk_item_ui_list.imgDesk:setTexture("game/foursniuniu_std/resource/image/z2.png")
	end

end

function C4pNiuNiuDesk:onEnterDeskClick( e )
	-- body
	if e.name == "ended" then
		if e.target.seatData then
			if self.isPlaying == true then
				TipsManager:showOneButtonTipsPanel(35, {}, true)
				return
			end

			if self.desk_info.hasPwd == 1 then
				TipsManager:showPasswordPanel(function (password)
					--send_texaspoker_ReqEnterTable({tableId = e.target.seatData.tableId, order = e.target.seatData.order, password = password})
					HallManager:sendEnterTableMsg({tableId = e.target.seatData.tableId, order = e.target.seatData.order, password = password})
				end)
			else
				--send_texaspoker_ReqEnterTable({tableId = e.target.seatData.tableId, order = e.target.seatData.order})
				HallManager:sendEnterTableMsg({tableId = e.target.seatData.tableId, order = e.target.seatData.order})
			end
		end
	end
end