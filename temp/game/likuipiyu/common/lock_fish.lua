
--[[
	锁定功能
]]

LockFish = class("LockFish",function ()
	local obj  = {}
	return obj
end)

--[[
	info = {
		parent,
		side,
		set_id,
		is_local,
		lkey,
		offset_pos,
	}
]]
function LockFish.create(info)
	local obj  = LockFish.new()
	if obj then
		obj:init(info)
	end
	return obj
end

function LockFish:init(info)
	self.spos   = {x = 0,y = 0,}
	self.parent = info.parent
	self.side   = info.side
	self.set_id = info.set_id
	self.is_local = info.is_local
	self.off_pos = info.offset_pos
	self.lkey = info.lkey
	

	self.spr_lock_line   = {}
	self.block  		 = false
	self.is_lock_success = false


	self.lock_fish_lst   = {}
	self.cur_lock_index  = 0
	self.cur_lock_obj_id = -1
	
	
	self.lock_spr_dis = 30

	self.cur_lock_angle = 0

	self.lock_call = nil

	self.is_lock_change = false

	self.is_force_lock = false
	self.front_force_lock_obj_id = -1

	self.hand_lock = false

	local frame_name = info.lkey .. string.format("_%d.png",1)
	local test_spr   = cc.Sprite:createWithSpriteFrameName(frame_name)
	local test_size  = test_spr:getContentSize()

	self.line_r = 0
	if test_size.width <= test_size.height then
		self.line_r = test_size.width/2
	else
		self.line_r = test_size.height/2
	end

	local last_frame_name = info.lkey .. ".png"
	self.last_spr = cc.Sprite:createWithSpriteFrameName(last_frame_name)
	self.parent:addChild(self.last_spr)
	self.last_spr:setVisible(false)
	self.last_spr:setPosition(0,0)

	local last_spr_size = self.last_spr:getContentSize()

	self.last_spr_r = 0
	if last_spr_size.width <= last_spr_size.height then
		self.last_spr_r = last_spr_size.width/2
	else
		self.last_spr_r = last_spr_size.height/2
	end	
end

function LockFish:lock()
	self.block = true
	self.is_lock_change = false
	self.is_force_lock  = false
	self.front_force_lock_obj_id = -1

	if #self.lock_fish_lst > 0 then

		self.cur_lock_index = self.cur_lock_index + 1

		if self.cur_lock_index > #self.lock_fish_lst then self.cur_lock_index = 1 end

		--self.cur_lock_obj_id = -1

		local cur_fsh_obj = self.lock_fish_lst[self.cur_lock_index]
		if cur_fsh_obj then
			self.cur_lock_obj_id = cur_fsh_obj:getObjectId()
			--print("begin lock fish>>>>>>>>>>>>>>>>")
			self.is_lock_change  = true
			self.is_lock_success = true

			if self.lock_call then
				self.lock_call(self.cur_lock_obj_id)
			end
		end

		--self:selectLockFish()
	end
end

function LockFish:setLockFish(fsh_id)
	--print("get lock msg set id = " .. self.set_id)
	if self.is_local == false then self.block = true end

	if self.block == true and fsh_id ~= -1 then
		self.is_lock_success = true
		self.cur_lock_obj_id = fsh_id

		--print("current lock fish = " .. self.cur_lock_obj_id .. ",set id = " .. self.set_id)
		-- for k,v in pairs(self.lock_fish_lst) do
		-- 	if v:getObjectId() == self.cur_lock_obj_id then
		-- 		self.cur_lock_index = k
		-- 		return
		-- 	end
		-- end
		-- self.cur_lock_index = 0
	end
end

function LockFish:forceToLockFish(fsh_id)
	if self.is_local == true and (fsh_id and fsh_id ~= -1) and true == self.hand_lock then
		self.block = true
		self.is_force_lock 	 = true
		self.front_force_lock_obj_id = self.cur_lock_obj_id
		self.cur_lock_obj_id = fsh_id
		self.is_lock_success = true
	end
end

function LockFish:resetLockLst(lst)
	self.lock_fish_lst   = lst
end

function LockFish:unlock()
	self.cur_lock_index  = 0
	self.cur_lock_obj_id = -1
	self.is_force_lock = false
	self.front_force_lock_obj_id = -1

	self.block = false
	self.is_lock_success = false
	self.last_spr:setVisible(false)
	self.cur_lock_angle = 0

	--print("get unlock msg set id = " .. self.set_id)

	for k,v in pairs(self.spr_lock_line) do v:setVisible(false) end
end


function LockFish:selectLockFish()

	if self.is_force_lock == true and self.is_local == true then
		local fsh_obj = FishManager.getInstance():getFishObjById(self.cur_lock_obj_id)
		if self:isFishCanLock(fsh_obj) == true then
			self.is_lock_success = true
			if self.lock_call then
				if self.front_force_lock_obj_id ~= self.cur_lock_obj_id and self.cur_lock_obj_id ~= -1 then
					self.front_force_lock_obj_id = self.cur_lock_obj_id
					self.is_lock_change = true
					print("force to lock fish >>>>>>>>>>>")
					self.lock_call(self.cur_lock_obj_id)
				end
			end
			return fsh_obj
		end

		return nil
	end

	if self.is_local == false then
		local fsh_obj = FishManager.getInstance():getFishObjById(self.cur_lock_obj_id)
		if self:isFishCanLock(fsh_obj) == true then
			self.is_lock_success = true
			self.is_lock_change  = true
			return fsh_obj
		end

		return nil
	end

	local new_index = -1
	for k,v in pairs(self.lock_fish_lst) do
		if self.cur_lock_obj_id == v:getObjectId() and self:isFishCanLock(v) == true then
			self.is_lock_change  = false
			return v
		end

		if self:isFishCanLock(v) == true and new_index == -1 then
			new_index = k
		end
	end

	if new_index == -1 then
		self.cur_lock_index  = 0
		self.cur_lock_obj_id = -1
		self.is_lock_success = false
		self.is_lock_change  = true
	else
		self.cur_lock_index  = new_index
		self.cur_lock_obj_id = self.lock_fish_lst[self.cur_lock_index]:getObjectId()
		if self.lock_call then
			self.lock_call(self.cur_lock_obj_id)
		end

		self.is_lock_success = true
		self.is_lock_change  = true
	end


	return self.lock_fish_lst[self.cur_lock_index]
end

function LockFish:isFishCanLock(fsh_obj)
	if fsh_obj then
		local fpos = fsh_obj:getCurrentPos()
		local battery_obj = BatteryManager.getInstance():getBatteryBySetId(self.set_id)
		local bpos = battery_obj:getSendBulletPos()
		local rect = {x = 0,y = 0,width = lk_system_config.bonding_size.width,height = lk_system_config.bonding_size.height,}
		if is_point_in_rect(rect,fpos) == true and self:isPosValid(self.side,bpos,fpos) then
			return true
		end
	end

	return false
end

function LockFish:isPosValid(side,spos,epos)
	local angle = self:getRotationAngle(spos,epos,side)

	local angle_valide = false
	
	if (side == 1) and ( (angle >= 0 and angle <= 90 ) or (angle >= 270 and angle <= 360 ) ) and spos.x < epos.x then
		angle_valide = true
	elseif ( side == 2 ) and ( angle >= 90 and angle <= 270 and spos.x > epos.x ) then
		angle_valide = true
	elseif ( side == 3 ) and ( angle >= 180 and angle <= 360 and epos.y < spos.y ) then
		angle_valide = true
	elseif (side == 4) and ( angle >= 0 and angle <= 180 and epos.y > spos.y) then
		angle_valide = true
	end


	return angle_valide
end

function LockFish:update(dt)
	if self.block == true then
		local fsh_obj = self:selectLockFish()

		if fsh_obj and self.is_lock_success == true then

			local battery_obj = BatteryManager.getInstance():getBatteryBySetId(self.set_id)

			if battery_obj then
				self.spos = clone(battery_obj:getSendBulletPos())
			end


			local end_pos = clone(fsh_obj:getCurrentPos())

			self.spos.x = self.spos.x - self.off_pos.x
			self.spos.y = self.spos.y - self.off_pos.y

			end_pos.x = end_pos.x - self.off_pos.x
			end_pos.y = end_pos.y - self.off_pos.y

			self:resetLockLineByPos(self.spos,end_pos)
		else
			for k,v in pairs(self.spr_lock_line) do
				v:setVisible(false)
			end
			self.last_spr:setVisible(false)
			if self.is_force_lock == true or self.is_local == false then
				self.is_force_lock = false
				self.block = false
				self.is_lock_success = false
			end
		end
	end
end

function LockFish:resetLockLineByPos(pos1,pos2)
	local angle = self:getRotationAngle(pos1,pos2,self.side)

	local distance = math.sqrt( math.pow(pos1.x - pos2.x,2) + math.pow(pos1.y - pos2.y,2) )

	distance = distance - (self.line_r + self.last_spr_r)
	
	local show_index = 1
	local dist_add   = 0

	local lst_len = #self.spr_lock_line

	for i=1,lst_len do
		dist_add = (i-1)*(self.line_r*2 + self.lock_spr_dis)
		if dist_add > distance then
			show_index = i
			break
		end

		local cal_dis = (i - 1)*(self.line_r*2 + self.lock_spr_dis)
		local pos = self:getPosByDistanceAndAngle(cal_dis,angle)
		self.spr_lock_line[i]:setPosition(pos.x,pos.y)
		self.spr_lock_line[i]:setVisible(true)
	end


	local frame_name = self.lkey .. string.format("_%d.png",1)

	while dist_add < distance do
		local obj = cc.Sprite:createWithSpriteFrameName(frame_name)

		self.parent:addChild(obj)

		table.insert(self.spr_lock_line,obj)

		local pos = self:getPosByDistanceAndAngle(dist_add,angle)

		obj:setPosition(pos.x,pos.y)
		obj:setVisible(true)

		dist_add = dist_add + (self.line_r*2 + self.lock_spr_dis)
		show_index = show_index + 1
	end

	self.last_spr:setVisible(true)
	self.last_spr:setPosition(pos2.x,pos2.y)

	for i=show_index,#self.spr_lock_line do
		self.spr_lock_line[i]:setVisible(false)
	end

	self.cur_lock_angle = angle
end

function LockFish:getPosByDistanceAndAngle(dis,angle)
	local sx = dis*math.cos((angle/180)*math.pi)
	local sy = dis*math.sin((angle/180)*math.pi)

	return {x = self.spos.x + sx,y = self.spos.y + sy,}
end

function LockFish:getRotationAngle(pos1,pos2,side)
	local angle = 0

	if pos1.x == pos2.x then
		if side == 1 and pos1.y >= pos2.y then
			angle = 90
		elseif side == 1 and pos1.y < pos2.y then
			angle = 270
		elseif side == 2 and pos1.y >= pos2.y then
			angle = 90
		elseif side == 2 and pos1.y < pos2.y then
			angle = 270
		elseif side == 3 then
			angle = 270
		elseif side == 4 then
			angle = 90
		end
	else
		local k = (pos1.y - pos2.y)/(pos1.x - pos2.x)
		angle = math.atan(k)*180/math.pi


		if side == 1 and angle <= 0 then
			angle = 2*180 + angle
		elseif side == 2 then
			angle = 180 + angle
		elseif side == 3 and angle > 0 then
			angle = 180 + angle
		elseif side == 3 and angle <= 0 then
			angle = 2*180 + angle
		elseif side == 4 and angle <= 0 then
			angle = 180 + angle
		end
	end

	return angle
end

function LockFish:getLockState()
	if self.block == true and self.is_lock_success == true then
		return true
	end

	return false
end

function LockFish:getCurrentLockFishId()
	if self.is_lock_success == true and self.block == true then
		return self.cur_lock_obj_id
	end

	return -1
end

function LockFish:getCurrentLockAngle()
	return self.cur_lock_angle
end

function LockFish:setLockCall(call)
	self.lock_call = call
end

function LockFish:isLockObjChange()
	return self.is_lock_change
end


