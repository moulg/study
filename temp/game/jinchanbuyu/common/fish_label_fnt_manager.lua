--[[
	金钱字体对象管理
]]


FishLabelFntManager = class("FishLabelFntManager",function ()
	local obj = {}
	return obj	
end)

local __fish_label_fnt_manager_obj = nil

function FishLabelFntManager.getInstance()
	if __fish_label_fnt_manager_obj == nil then
		__fish_label_fnt_manager_obj = FishLabelFntManager.new()
	end

	return __fish_label_fnt_manager_obj
end

function FishLabelFntManager.destroyInstance()
	__fish_label_fnt_manager_obj = nil
end

function FishLabelFntManager:init()
	self.alive_object_lst = {}
end


function FishLabelFntManager:play(spos,number)
	local id = jc_system_config.gold_fnt_index
	local fnt_obj = ObjectPool.getInstance():getObject(ObjectClassType.type_fish_fnt,id)
	if fnt_obj then
		fnt_obj:setUseState(true)
		local function __on_fish_label_manager_endcall(obj)	self:onEndCall(obj) end
		fnt_obj:setEndCallback(__on_fish_label_manager_endcall)
		fnt_obj:play(spos,number) 
	end
end

function FishLabelFntManager:onEndCall(obj)
	if obj then
		obj:setUseState(false)
		obj:resumeOrgin()
	end
end




