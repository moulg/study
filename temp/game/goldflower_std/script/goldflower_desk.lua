--[[
炸金花
]]
local SEAT_NUM = 5

local desk_item_ui = require "game.goldflower_std.script.ui_create.ui_goldflower_desk"

local _contentSize = cc.size(360, 295)

CGoldFlowerDesk = class("CGoldFlowerDesk", function ()
	-- body
	local  ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:setContentSize(_contentSize)
    ret:setAnchorPoint(0, 0)
	return ret
end)

function CGoldFlowerDesk.getContentSize()
	return _contentSize
end

function CGoldFlowerDesk.create()
	-- body
	local layer = CGoldFlowerDesk.new()
	if layer ~= nil then
		layer:init_ui()
		return layer
	end
end

function CGoldFlowerDesk:init_ui()
	
	self.desk_item_ui_list = desk_item_ui.create()
	self:addChild(self.desk_item_ui_list.root)
	self.desk_item_ui_list.root:setAnchorPoint(0, 0)
	self.desk_item_ui_list.root:setPosition(self:getContentSize().width / 2,self:getContentSize().height / 2)

	--进入游戏桌子
	local function __on_enter_deskclick( e )
		-- body
		self:onEnterDeskClick(e)
	end

    
	for i=1,SEAT_NUM do
        local key = "btnPlayer"..i
		self.desk_item_ui_list[key]:onTouch(__on_enter_deskclick)
	end

end

function CGoldFlowerDesk:updatePassword(value)
	self.desk_info.hasPwd = value
	self.desk_item_ui_list.imgLock:setVisible(value == 1)
end

function CGoldFlowerDesk:updateSeatInfo( seat )
	for k,v in pairs(self.desk_info.seats) do
		if v.order == seat.order then
			self.desk_info.seats[k] = seat

			self:setDeskInfo( self.desk_info )			
			return true
		end
	end

	return false
end

function CGoldFlowerDesk:setDeskInfo( info )
	-- dump(info)
	-- body
	self.desk_info = info
	self.isPlaying = false

	local id = info.id % 10000
	self.desk_item_ui_list.labTableID:setString("- "..id.." -")
	self.desk_item_ui_list.imgLock:setVisible(info.hasPwd == 1)

    local key = ""
	for i,v in ipairs(info.seats) do
        key = "btnPlayer"..(v.order + 1)
		self.desk_item_ui_list[key].seatData = v

		if long_compare(v.playerId, 0) == 0 then
            key = "name"..(v.order + 1)
			self.desk_item_ui_list[key]:setString("")

            key = "btnPlayer"..(v.order + 1)
			self.desk_item_ui_list[key]:setEnabled(true)
			self.desk_item_ui_list[key]:setBright(true)

            key = "imgReady"..(v.order + 1)
			self.desk_item_ui_list[key]:setVisible(false)
		else
            key = "name"..(v.order + 1)
			self.desk_item_ui_list[key]:setString(textUtils.replaceStr(v.playerName, NAME_BITE_LIMIT, ".."))

            key = "btnPlayer"..(v.order + 1)
			self.desk_item_ui_list[key]:setEnabled(false)
			self.desk_item_ui_list[key]:setBright(false)
			local res = uiUtils:getHeadResUrl(v.icon, uiUtils.HEAD_SIZE_35)
			self.desk_item_ui_list[key]:loadTextureDisabled(res)

            key = "imgReady"..(v.order + 1)
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
		self.desk_item_ui_list.imgPlaying:setVisible(false)
	else
        for i=1,SEAT_NUM do
            key = "imgReady"..i
			self.desk_item_ui_list[key]:setVisible(false)
		end
		self.desk_item_ui_list.imgPlaying:setVisible(true)
	end

end

function CGoldFlowerDesk:onEnterDeskClick( e )
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
