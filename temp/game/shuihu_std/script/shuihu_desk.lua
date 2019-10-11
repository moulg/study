--[[
	桌子简要信息
]]

local desk_item_ui = require "game.shuihu_std.script.ui_create.ui_shuihu_desk"

local _contentSize = cc.size(175, 224)

CShuiHu_DeskItem = class("CShuiHu_DeskItem",function()
	-- body
	local  ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:setContentSize(_contentSize)
    ret:setAnchorPoint(0, 0)
	return ret
end)

function CShuiHu_DeskItem.getContentSize()
	return _contentSize
end

function CShuiHu_DeskItem.create()
	-- body
	local layer = CShuiHu_DeskItem.new()
	if layer ~= nil then
		layer:init_ui()
		return layer
	end
end

function CShuiHu_DeskItem:init_ui()
	
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
	self.desk_item_ui_list.btnTable:onTouch(__on_enter_deskclick)
end

function CShuiHu_DeskItem:updateSeatInfo( info )
	for k,v in pairs(self.desk_info.seats) do
		if v.order == info.order then
			self.desk_info.seats[k] = info

			self:setDeskInfo( self.desk_info )			
			return
		end
	end

    table.insert(self.desk_info.seats, info)
    self:setDeskInfo( self.desk_info )
end

function CShuiHu_DeskItem:clearDesk()
	self.desk_item_ui_list.labName:setString("")
	self.desk_item_ui_list.btnPlayer:setEnabled(true)
	self.desk_item_ui_list.btnPlayer:setBright(true)
	self:setWaiting(true)
end

function CShuiHu_DeskItem:setDeskInfo( info )
	-- body
	self.desk_info = info

	local id = info.id % 10000
	self.desk_item_ui_list.labTableID:setString("- "..id.." -")

	self:clearDesk()
	for i,v in ipairs(info.seats) do
		if v.order == 0 then
			if long_compare(v.playerId, 0) == 0 then
				self.desk_item_ui_list.labName:setString("")
				self:setWaiting(true)
			else
				self.desk_item_ui_list.labName:setString(v.playerName)
				local res = uiUtils:getHeadResUrl(v.icon, uiUtils.HEAD_SIZE_35)
				self.desk_item_ui_list.btnPlayer:loadTextureDisabled(res)
				
				self:setWaiting(false)
			end
		end
	end
end

function CShuiHu_DeskItem:setWaiting(value)
	if value then
		self.desk_item_ui_list.btnTable:setEnabled(true)
		self.desk_item_ui_list.btnTable:setBright(true)
		self.desk_item_ui_list.btnPlayer:setEnabled(true)
		self.desk_item_ui_list.btnPlayer:setBright(true)
	else
		self.desk_item_ui_list.btnTable:setEnabled(false)
		self.desk_item_ui_list.btnTable:setBright(false)
		self.desk_item_ui_list.btnPlayer:setEnabled(false)
		self.desk_item_ui_list.btnPlayer:setBright(false)
	end
end

function CShuiHu_DeskItem:onEnterDeskClick( e )
	-- body
	if e.name == "ended" then
		--send_shuihu_ReqEnterTable({tableId = self.desk_info.id})
		HallManager:sendEnterTableMsg({tableId = self.desk_info.id})
	end
end
