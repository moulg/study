

--[[
	金币柱行为控制
]]

GoldColumnAction = class("GoldColumnAction",function ()
	local obj = {}
	return obj
end)


--[[
	info = {
		parent,
		spos,
		number,
		col_way,
		max_val,
	}
]]
function GoldColumnAction.create(info)
	local obj = GoldColumnAction.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function GoldColumnAction:init(info)
	self:initData(info)
	self:initUI()
end

function GoldColumnAction:initData(info)
	self.parent = info.parent
	self.spos = clone(info.spos)
	self.max_obj = info.number
	self.max_val = info.max_val
	self.col_way = info.col_way

	self.object_lst = {}
	self.updata_obj_lst = {}

	self.cur_val = 0
	self.item_index = 1
end

function GoldColumnAction:initUI()
	if self.max_obj <= 0 then return end
	local function __on_hide_call(obj)
		self:onHideCall(obj)
	end
	

	for i=1,self.max_obj do
		local obj = GoldColumn.create()
		self.parent:addChild(obj)
		obj:setPosition(self.spos.x,self.spos.y)
		obj:setMaxValue(self.max_val)

		obj:setHideCall(__on_hide_call)
		table.insert(self.object_lst,obj)
	end

	self.column_size = self.object_lst[self.item_index]:getGoldSize()
end

function GoldColumnAction:setVal(val)

	if self.max_obj <= 0 then
		print("have no gold column show!")
		return
	end

	self.cur_val = val

	if #self.updata_obj_lst >= self.max_obj then
		self.object_lst[self.item_index]:forceHide()
		table.remove(self.updata_obj_lst,1)

		local dis = self.column_size.height*self.col_way

		for i=1,#self.updata_obj_lst do
			local move_obj = cc.MoveBy:create(0.02,{x = -dis,y = 0,})

			if i < #self.updata_obj_lst then
				self.updata_obj_lst[i]:runAction(move_obj)
			else
				local function __end_call_move()
					local index = #self.updata_obj_lst
					self.updata_obj_lst[index]:setVal(self.cur_val)
					local cur_x = self.column_size.height*self.col_way*(#self.updata_obj_lst - 1)
					self.updata_obj_lst[index]:setPositionX(self.spos.x + cur_x)
				end

				local call_obj = cc.CallFunc:create(__end_call_move)
				local seq_lst  = {}

				table.insert(seq_lst,move_obj)
				table.insert(seq_lst,call_obj)

				self.updata_obj_lst[i]:runAction(cc.Sequence:create(seq_lst))
			end
		end
	else
		self.object_lst[self.item_index]:setVal(self.cur_val)
		local cur_x = self.column_size.height*self.col_way*(#self.updata_obj_lst)
		self.object_lst[self.item_index]:setPositionX(self.spos.x + cur_x)
	end

	table.insert(self.updata_obj_lst,self.object_lst[self.item_index])

	self.item_index = self.item_index + 1
	if self.item_index >self.max_obj then self.item_index = 1 end
end

function GoldColumnAction:update(dt)
	for k,v in pairs(self.updata_obj_lst) do
		v:update(dt)
	end
end

function GoldColumnAction:onHideCall(obj)
	local k = 1
	while k <= #self.updata_obj_lst do
		if self.updata_obj_lst[k]:isHide() == true then
			table.remove(self.updata_obj_lst,k)
		else
			local dis = self.column_size.height*self.col_way
			local move_obj = cc.MoveBy:create(0.02,{x = -dis,y = 0,})
			self.updata_obj_lst[k]:runAction(move_obj)
			k = k + 1
		end
	end
end

