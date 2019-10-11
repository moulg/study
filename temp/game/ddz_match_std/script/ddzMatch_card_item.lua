--[[
卡牌对象
]]
local MOVE_DIF = 30

CDdzMatchCardItem = class("CDdzMatchCardItem", function ()
	local ret = ccui.ImageView:create()
	return ret
end)

function CDdzMatchCardItem.create(id)
	local node =  CDdzMatchCardItem.new()
	if node then
		node:init(id)
		return node
	end
end

function CDdzMatchCardItem:init(id)
	local imageFileName = ddzMatch_card_data[id].card_big
	self:loadTexture(imageFileName,1)
	self.id = id
	self._isSelect = false
end

function CDdzMatchCardItem:clickHandler()
	if self._isSelect then
		self:hideSelectState()
	else
		self:showSelectState()
	end
end

function CDdzMatchCardItem:showSelectState()
	self:setPositionY(MOVE_DIF)
	self._isSelect = true

	table.insert(ddz_match_manager._selectCards, self.id)
end

function CDdzMatchCardItem:hideSelectState()
	self:setPositionY(0)
	self._isSelect = false

	for i,v in ipairs(ddz_match_manager._selectCards) do
		if v == self.id then
			table.remove(ddz_match_manager._selectCards, i)
			return
		end
	end
end

function CDdzMatchCardItem:showShader()
	self:setColor(cc.c3b(127, 127, 127))
end

function CDdzMatchCardItem:hideShader()
	self:setColor(cc.c3b(255, 255, 255))
end