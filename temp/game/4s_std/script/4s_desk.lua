--[[

桌子信息
]]

local desk_item_ui = require "game.4s_std.script.ui_create.ui_4s_desk"

local _contentSize = cc.size(815, 590)

CFSDeskItem = class("CFSDeskItem",function()
	-- body
	local  ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:setContentSize(_contentSize)
    ret:setAnchorPoint(0, 0)
	return ret
end)

function CFSDeskItem.getContentSize()
	return _contentSize
end

function CFSDeskItem.create()
	-- body
	local layer = CFSDeskItem.new()
	if layer ~= nil then
		layer:init_ui()
		return layer
	end
end

function CFSDeskItem:init_ui()
	
	self.desk_item_ui_list = desk_item_ui.create()
	self:addChild(self.desk_item_ui_list.root)
	self.desk_item_ui_list.root:setAnchorPoint(0, 0)
	self.desk_item_ui_list.root:setPosition(self:getContentSize().width / 2,self:getContentSize().height / 2)

	--进入游戏桌子
	local function __on_enter_deskclick( e )
		-- body
		self:onEnterDeskClick(e)
	end
	self.desk_item_ui_list.btnPlayer:onTouch(__on_enter_deskclick)

end

function CFSDeskItem:updateSeatInfo( seat )
	for k,v in pairs(self.desk_info.seats) do
		if v.order == seat.order then
			self.desk_info.seats[k] = seat

			self:setDeskInfo( self.desk_info )			
			return true
		end
	end

	return false
end

function CFSDeskItem:setDeskInfo( info )
	-- body
	self.desk_info = info
end

function CFSDeskItem:onEnterDeskClick( e )
	-- body
	if e.name == "ended" then
	    local tableID = self.desk_info.seats[1].tableId
	    local roomID = self.desk_info.roomId
		HallManager:sendEnterTableMsg({roomId = self.desk_info.roomId ,tableId = self.desk_info.seats[1].tableId})
	end
end
