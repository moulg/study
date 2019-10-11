
--[[
	金钱显示字体
]]

local fish_label_fnt_zorder = 2500000

FishLabelFnt = class("FishLabelFnt",function ()
	local obj = ccui.TextAtlas:create()
	return obj
end)

--[[
	info = {
		obj_id,
		id,
	}
]]
function FishLabelFnt.create(info)
	local obj = FishLabelFnt.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function FishLabelFnt:init(info)
	self.object_id = info.obj_id
	self.item_config = fish_label_fnt_config[info.id]
	self.is_alive = false
	self.end_call = nil

	self:setProperty("0",self.item_config.src,self.item_config.size.x,self.item_config.size.y,'0')

	if item_config.scale then 
        self:setScale(item_config.scale)
    end

	self:setVisible(false)
	self:setPosition(0,0)

	self:setLocalZOrder(fish_label_fnt_zorder)
	fish_label_fnt_zorder = fish_label_fnt_zorder + 1
end

function FishLabelFnt:play(spos,number)
	self:setString(tostring(number))
	self:setPosition(spos.x,spos.y)
	self:setVisible(true)

	local __fish_label_fnt_endcall = function ()
		if self.end_call then self.end_call(self) end
	end

	ActionEffectPlayer.getInstance():play(self,__fish_label_fnt_endcall,self.item_config.act_id) 
end


function FishLabelFnt:getDataId()
	return self.item_config.id
end

function FishLabelFnt:getObjectId()
	return self.object_id
end

function FishLabelFnt:setUseState(buse)
	self.is_alive = buse
end

function FishLabelFnt:getUseState()
	return self.is_alive
end

function FishLabelFnt:setEndCallback(call)
	self.end_call = call
end

function FishLabelFnt:resumeOrgin()
	self:setVisible(false)
	self:setPosition(0,0)
	self.end_call = nil
end

