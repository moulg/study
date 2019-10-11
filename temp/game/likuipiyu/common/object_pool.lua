
--[[
	对象池
]]

--对象类型
ObjectClassType = {
	type_fish 		= 1,--鱼
	type_bullet 	= 2,--子弹
	type_fish_net 	= 3,--鱼网
	type_fish_gold  = 4,--金币
	type_fish_fnt	= 5,--鱼字体
}

ObjectPool = class("ObjectPool",function ()
	local obj = {}
	return obj
end)

local __object_pool_object = nil
local __default_new_object = 5

function ObjectPool.getInstance()
	if __object_pool_object == nil then
		__object_pool_object = ObjectPool.new()
	end

	return __object_pool_object
end

function ObjectPool.destroyInstance()
	__object_pool_object = nil
end

function ObjectPool:init(parent)
	self.object_class_lst = {}
	self.parent = parent

	for k,v in pairs(ObjectClassType) do
		self.object_class_lst[v] = {
			object_id 	= 0,
			creater 	= nil,
			object_lst 	= {},
		}	
	end
end

function ObjectPool:registerObjectCreater(class_type,creater)
	local class_item = self.object_class_lst[class_type]
	if class_item then	class_item.creater = creater end
end

function ObjectPool:newSomeObject(class_type,data_id,number)
	local class_item = self.object_class_lst[class_type]

	if class_item and class_item.creater then
		--print("new object number = " .. number .. ",class type = " .. class_type)
		
		for i=1,number do
			class_item.object_id = class_item.object_id + 1
			local create_info = {obj_id = class_item.object_id,id = data_id,}

			local creater = class_item.creater
			local new_obj = creater.create(create_info)
			self.parent:addChild(new_obj)

			new_obj:setPosition(0,0)
			class_item.object_lst[class_item.object_id] = new_obj
		end
	end
end

function ObjectPool:getObject(class_type,data_id)
	local obj = nil
	local class_item = self.object_class_lst[class_type]
	
	-- if class_type == 4 then
	-- 	print("object class type : " .. class_type .. ",leng = " .. #class_item.object_lst)
	-- end

	if class_item then
		for k,v in pairs(class_item.object_lst) do
			local buse = v:getUseState()
			local daid = v:getDataId()

			if buse == false and daid == data_id then
				obj = v
				break
			end 
		end
	end

	if obj == nil then
		self:newSomeObject(class_type,data_id,__default_new_object)
		class_item = self.object_class_lst[class_type]
		obj = class_item.object_lst[class_item.object_id]
	end

	return obj
end

