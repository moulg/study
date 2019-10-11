
--[[
	子弹
]]

local pie_angle = 180
local pie = 3.1415926

local bullet_zorder = 999999

--[[
	side 1->left,2->right,3->top,4->bottom
]]

Bullet = class("Bullet",function ()
	local obj = cc.Sprite:create()
	return obj
end)

--[[
	info = {obj_id,id,}
]]
function Bullet.create(info)
	local obj = Bullet.new()

	if obj then obj:init(info) end

	return obj
end

function Bullet:init(info)
	self:setLocalZOrder(bullet_zorder)
	self.bonding_size = {width = 960,height = 640,}
	self.bult_cfg = bullet_config[info.id]

	self:setSpriteFrame(self.bult_cfg.src_key)

	self:setVisible(false)
	self:setPosition(0,0)
	self:setRotation(0)

	self.cur_pos 		= {x = 0,y = 0,}
	self.front_line_pos = {x = 0,y = 0,}

	self.cur_angle 		= 0
	self.cur_side 		= -1--current send side
	self.move_v 		= self.bult_cfg.act_v
	self.bonding_box 	= self.bult_cfg.bonding_box
	self.data_id		= self.bult_cfg.id
	self.object_id		= info.obj_id
	self.is_alive		= false

	self.user_info = {
		player_id 	= 0, --玩家id
		set_id 		= 0,--坐位id
		is_local 	= true,--是否为本地，区别自己与别人的炮台
		server_id 	= -1,--服务器子弹id标识
	}

	self.cur_lock_fish_id = -1

	self.cur_line_run_t = 0
end

function Bullet:resumeOrgin()
	self:setRotation(0)
	self:setVisible(false)
	self:setPosition(0,0)
	self.user_info = {
		player_id 	= 0,
		set_id 		= 0,
		is_local 	= true,
		server_id 	= -1,
	}
	self.cur_lock_fish_id = -1

	self.cur_line_run_t = 0
	self.front_line_pos = {x = 0,y = 0,}
end

function Bullet:getCurActPos()
	return {x = self.cur_pos.x + self.front_line_pos.x,y = self.cur_pos.y + self.front_line_pos.y}
end

function Bullet:update(dt)
	if self:isBulletOutOfBondingRect() == true then

		local new_angle,new_side = self:getNewAngleAndSide(self.cur_angle,self.cur_side,self:getCurActPos(),self.bonding_size)

		self.cur_line_run_t = 0
		self.cur_pos.x = self.cur_pos.x + self.front_line_pos.x
		self.cur_pos.y = self.cur_pos.y + self.front_line_pos.y
		self.front_line_pos ={x = 0,y = 0,}

		self.cur_side = new_side
		if new_angle ~= nil then self.cur_angle = new_angle end
		self:setRotation(2*pie_angle - self.cur_angle)
	end

	local bat_obj = BatteryManager.getInstance():getBatteryBySetId(self.user_info.set_id)
	if bat_obj then
		if bat_obj:isLockFish() == true and (bat_obj:getLockFishId() == self.cur_lock_fish_id and self.cur_lock_fish_id ~= -1) then
			self.cur_angle = bat_obj:getLockAngle()
		end

		-- local rot_angle = 2*pie_angle - self:getRotation()
		-- if (math.abs(rot_angle - self.cur_angle) > 25 and math.abs(rot_angle - self.cur_angle) < 60) then
		-- 	print("angle wu cha = " .. math.abs(rot_angle - self.cur_angle) )
		-- 	self.cur_angle = rot_angle
		-- end
	end

	-- if self.cur_angle == 90 then
	-- 	self.cur_pos.y = self.cur_pos.y + self.move_v*dt
	-- elseif self.cur_angle == 270 then
	-- 	self.cur_pos.y = self.cur_pos.y - self.move_v*dt
	-- else
	-- 	local ddis = self.move_v*dt
	-- 	local dx = ddis*math.cos((self.cur_angle/pie_angle)*math.pi)
	-- 	local dy = ddis*math.sin((self.cur_angle/pie_angle)*math.pi)

	-- 	self.cur_pos.x = self.cur_pos.x + dx
	-- 	self.cur_pos.y = self.cur_pos.y + dy
	-- end
	-- self:setPosition(self.cur_pos.x,self.cur_pos.y)

	self.cur_line_run_t = self.cur_line_run_t + dt

	local ddis = self.move_v*self.cur_line_run_t
	self.front_line_pos.x = ddis*math.cos((self.cur_angle/pie_angle)*math.pi)
	self.front_line_pos.y = ddis*math.sin((self.cur_angle/pie_angle)*math.pi)

	self:setPosition(self.cur_pos.x + self.front_line_pos.x,self.cur_pos.y + self.front_line_pos.y)	
end

--angle 为逆时针角度，0~360,side为边，1 left,2 right,3 top,4 bottom
function Bullet:setStartPosAndAngle(pos,angle,side,lock_fish_id)

	self.cur_pos 		= pos
	self.cur_angle 		= angle
	self.cur_side 		= side

	self:setPosition(pos.x,pos.y)
	self:setRotation(2*pie_angle - angle)
	self:setVisible(true)
	self.cur_way = self:angleWay(angle)
	self.cur_lock_fish_id = lock_fish_id

	self.cur_line_run_t = 0
	self.front_line_pos = {x = 0,y = 0,}
end

function Bullet:getNextSideByPoint(pos,bsz)
	local side = -1

	if (pos.x < bsz.width/2 and pos.y > bsz.height/2) and (pos.x <= bsz.height - pos.y) then --at left side
		side = 1
	elseif (pos.x < bsz.width/2 and pos.y > bsz.height/2) and (pos.x > bsz.height - pos.y) then --at top side
		side = 3
	elseif (pos.x < bsz.width/2 and pos.y < bsz.height/2) and (pos.x <= pos.y) then --at left side
		side = 1
	elseif (pos.x < bsz.width/2 and pos.y < bsz.height/2) and (pos.x > pos.y) then --at bottom sie
		side = 4
	elseif (pos.x > bsz.width/2 and pos.y > bsz.height/2) and (bsz.width - pos.x <= bsz.height - pos.y) then --at right side
		side = 2
	elseif (pos.x > bsz.width/2 and pos.y > bsz.height/2) and (bsz.width - pos.x > bsz.height - pos.y) then --at top side
		side = 3
	elseif (pos.x > bsz.width/2 and pos.y < bsz.height/2) and (bsz.width - pos.x <= pos.y) then --at right side
		side = 2
	elseif (pos.x > bsz.width/2 and pos.y < bsz.height/2) and (bsz.width - pos.x > pos.y) then --at bottom side
		side = 4
	end

	return side
end

function Bullet:isBulletOutOfBondingRect()
	for k,v in pairs(self.bonding_box) do
		local pos = self:getCurActPos()

		local bonding_item_pos = {x = v.a + pos.x,y = v.b + pos.y,}
		if (bonding_item_pos.x < v.r or self.bonding_size.width - bonding_item_pos.x < v.r)
			or (bonding_item_pos.y < v.r or self.bonding_size.height - bonding_item_pos.y < v.r) then
			return true
		end
	end

	return false
end

function Bullet:angleWay(angle)
	if (angle >= 0 and angle <= 90) or (angle >= 270 and angle <= 360) then
		return 1
	end

	return -1
end

function Bullet:getNewAngleAndSide(angle,side,pos,bsz)
	local next_side = self:getNextSideByPoint(pos,bsz)

	--special angle
	if angle == 90 or angle == 270 then
		return 2*pie_angle - angle,next_side
	elseif angle == 0 or angle == 2*pie_angle then
		return pie_angle,next_side
	elseif angle == pie_angle then
		return 0,next_side
	end

	if side == 4 and next_side == 2 then 	 --bottom -> right
		return pie_angle - angle,next_side
	elseif side == 4 and next_side == 3 then --bottom -> top
		return 2*pie_angle - angle,next_side
	elseif side == 4 and next_side == 1 then --bottom -> left
		return pie_angle - angle,next_side
	elseif side == 3 and next_side == 1 then --top -> left
		return 3*pie_angle - angle,next_side
	elseif side == 3 and next_side == 2 then --top -> right
		return 3*pie_angle - angle,next_side
	elseif side == 3 and next_side == 4 then --top -> bottom
		return 2*pie_angle - angle,next_side 
	elseif side == 1 and next_side == 3 then --left -> top
		return 2*pie_angle - angle,next_side
	elseif side == 1 and next_side == 4 then --left -> bottom
		return 2*pie_angle - angle,next_side
	elseif side == 1 and next_side == 2 then --left -> right
		if angle > 90 then 
			return 3*pie_angle - angle,next_side 
		end
		return pie_angle - angle,next_side
	elseif side == 2 and next_side == 3 then --right -> top
		return 2*pie_angle - angle,next_side
	elseif side == 2 and next_side == 4 then --right -> bottom
		return 2*pie_angle - angle,next_side 
	elseif side == 2 and next_side == 1 then --right -> left
		if angle > pie_angle then
			return 3*pie_angle - angle,next_side
		end
		return pie_angle - angle,next_side
	end

	return nil,next_side
end

function Bullet:shotSomething()
	local info = {}
	info.pos = {x = 0,y = 0}
	info.pos.x,info.pos.y = self:getPosition()

	if self.user_info.is_local == true then
		info.id = self.bult_cfg.my_fnet_id
	else
		info.id = self.bult_cfg.oth_net_id
	end

	FishNetManager.getInstance():play(info)
end

function Bullet:getBondingBox()
	local cur_x,cur_y = self:getPosition()
	local box_lst = {}
	for k,v in pairs(self.bonding_box) do
		local item = {}

		local angle = self.cur_angle
		local new_a = v.a*math.cos((angle/pie_angle)*math.pi) + v.b*math.sin((angle/pie_angle)*math.pi)
		local new_b = v.b*math.cos((angle/pie_angle)*math.pi) - v.a*math.sin((angle/pie_angle)*math.pi)
		
		item.a = new_a + cur_x
		item.b = new_b + cur_y
		item.r = v.r
		table.insert(box_lst,item)
	end

	return box_lst
end

--获取当前子弹位置
function Bullet:getCurrentPos()
	local pos = {x = 0,y = 0,}
	pos.x,pos.y = self:getPosition()

	return pos
end

--获取当前运动信息
function Bullet:getMovementInfo()
	local info = {
		pos = self:getCurActPos(),
		side = self.side,
		angle = self.cur_angle,
	}

	return info
end

function Bullet:setBondingSize(bsz)
	self.bonding_size = bsz
end

function Bullet:getBondingSize()
	return self.bonding_size
end

function Bullet:setUserInfo(info)
	self.user_info = info
end

function Bullet:getUserInfo()
	return self.user_info
end

function Bullet:getDataId()
	return self.data_id
end

function Bullet:getObjectId()
	return self.object_id
end

function Bullet:getUseState()
	return self.is_alive
end

function Bullet:setUseState(balive)
	self.is_alive = balive
end

function Bullet:isMyBullet()
	return self.user_info.is_local
end

function Bullet:getBulletSetId()
	return self.user_info.set_id
end

function Bullet:getBulletPlayerId()
	return self.user_info.player_id
end

function Bullet:getBulletServeId()
	return self.user_info.server_id
end

function Bullet:getCurLockFishId()
	return self.cur_lock_fish_id
end

