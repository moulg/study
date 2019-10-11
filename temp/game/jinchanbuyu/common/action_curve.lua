--[[
	运动曲线
]]

local dt = 0.001
local pi = 3.1415926
local pi_angle = 180

ActionCurve = class("ActionCurve",function ()
	local obj = {
		curve_lst = {},
	}

	return obj
end)


--[[
	info = {
		spos = {x,y},
		ratio
	}
]]
function ActionCurve.create(info)
	local obj = ActionCurve.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function ActionCurve:init(info)
	self.start_pos = {x = 0,y = 0,}
	if info.spos then --start pos
		self.start_pos = info.spos
	end

	self.ratio = 1920/100
	if info.ratio then --pixel ratio
		self.ratio = info.ratio
	end


	if self.ratio == nil then
		self.ratio = 1
	end

	if self.ratio <= 0 then
		self.ratio = 1
	end

	self.cur_def_way = 1 --运动方向，右为正方向，左为负方向
	self.cur_action_t = 0
	self.breserve 		= false--是否反向
	self.rotation_angle = 0--正为顺时针方向 0 ~ 360 负为逆时针方向 -360 ~ 0
end


--[[
	cveinfo = {
		t,
		x1,
		x2,
		ftype,
		fparam = {a,b,c,way,r,k},
	}
]]
function ActionCurve:addCurve(cveinfo)
	if cveinfo then
		local fitem 	= {}
		fitem.time 		= cveinfo.t
		fitem.s 		= (cveinfo.x2 - cveinfo.x1)
		fitem.v 		= fitem.s/fitem.time
		fitem.ftype		= cveinfo.ftype
		fitem.fparam 	= clone(cveinfo.fparam)
		fitem.x1 		= cveinfo.x1
		fitem.x2 		= cveinfo.x2

		if self.breserve == true then
			fitem.s = cveinfo.x1 - cveinfo.x2
			fitem.v = fitem.s/fitem.time
			fitem.x1 = cveinfo.x2
			fitem.x2 = cveinfo.x1
		end

		local lst_len = #self.curve_lst

		if lst_len <= 0 then
			fitem.t1 = 0
			fitem.t2 = fitem.t1 + fitem.time
			table.insert(self.curve_lst,fitem)
			return true
		else
			local last_item = self.curve_lst[lst_len]
			if last_item.x2 == fitem.x1 then
				fitem.t1 = last_item.t2
				fitem.t2 = fitem.t1 + fitem.time
				table.insert(self.curve_lst,fitem)
				return true
			end
		end
	end

	return false
end

function ActionCurve:getAllTime()
	local time = 0
	for k,v in pairs(self.curve_lst) do
		time = time + v.time
	end

	return time
end

function ActionCurve:setStartPos(pos)
	self.start_pos = pos
end

function ActionCurve:setRatio(ratio)
	self.ratio = ratio
	if self.ratio == nil then self.ratio = 1 end
	if self.ratio <= 0 then self.ratio = 1 end
end

--通过时间判断当前计算规则函数
function ActionCurve:getFunctionRuleByTime(t)
	local index = 0
	local len = #self.curve_lst

	if len <= 0 then return nil end

	local last_item = self.curve_lst[len]
	if t > last_item.t2 then
		return last_item
	end


	for i=1,#self.curve_lst do
		local item  = self.curve_lst[i]
		if t >= item.t1 and t < item.t2 then
			index = i
			break
		end
	end

	return self.curve_lst[index]
end

--通过时间计算当前绝对坐标
function ActionCurve:getPostionByTime(t)
	local index = 0
	local s_pos = {x = 0,y = 0,}--相对坐标值

	local len = #self.curve_lst
	if len <= 0 then return s_pos end

	local last_item = self.curve_lst[len]
	if t > last_item.t2 then
		local param   = {a=last_item.fparam.a,b=last_item.fparam.b,c=last_item.fparam.c,way=last_item.fparam.way,r=last_item.fparam.r,k=last_item.fparam.k,x=last_item.v*last_item.t2,}
		local tmp_pos = frule.getpos(last_item.ftype,param)

		s_pos.x = s_pos.x + tmp_pos.x
		s_pos.y = s_pos.y + tmp_pos.y

		if last_item.x1 > last_item.x2 then
			self.cur_def_way = -1
		else
			self.cur_def_way = 1
		end
	else
		for i=1,#self.curve_lst do
			local item  = self.curve_lst[i]
			if t >= item.t1 and t < item.t2 then
				index = i
				local param   = {a=item.fparam.a,b=item.fparam.b,c=item.fparam.c,way=item.fparam.way,r=item.fparam.r,k=item.fparam.k,x=item.v*(t-item.t1),}
				local tmp_pos = frule.getpos(item.ftype,param)

				s_pos.x = s_pos.x + tmp_pos.x
				s_pos.y = s_pos.y + tmp_pos.y

				if item.x1 > item.x2 then
					self.cur_def_way = -1
				else
					self.cur_def_way = 1
				end

				break
			else
				--计算上一函数的终点，做为下一函数的起点
				local param   = {a=item.fparam.a,b=item.fparam.b,c=item.fparam.c,way=item.fparam.way,r=item.fparam.r,k=item.fparam.k,x=item.v*item.time,}
				local tmp_pos = frule.getpos(item.ftype,param)

				s_pos.x = s_pos.x + tmp_pos.x
				s_pos.y = s_pos.y + tmp_pos.y
			end
		end
	end
	

	if self.rotation_angle ~= nil and self.rotation_angle ~= 0 then
		local new_x = s_pos.x*math.cos((self.rotation_angle/180)*math.pi) + s_pos.y*math.sin((self.rotation_angle/180)*math.pi)
		local new_y = s_pos.y*math.cos((self.rotation_angle/180)*math.pi) - s_pos.x*math.sin((self.rotation_angle/180)*math.pi)

		s_pos.x = new_x
		s_pos.y = new_y
	end 


	s_pos.x = s_pos.x*self.ratio
	s_pos.y = s_pos.y*self.ratio

	local pos = {
		x = self.start_pos.x + s_pos.x,
		y = self.start_pos.y + s_pos.y,
	}

	return pos
end


--通过时间计算当前坐标和斜率k
function ActionCurve:getPosAndSlopeByTime(t)
	self.cur_action_t = t
	local pos0 = self:getPostionByTime(t)
	local pos1 = self:getPostionByTime(t + dt)

	if self.rotation_angle ~= nil and self.rotation_angle ~= 0 then
		if pos0.x >=  pos1.x then
			self.cur_def_way = -1
		else
			self.cur_def_way = 1
		end
	end 

	local dx = pos1.x - pos0.x
	local dy = pos1.y - pos0.y
	if math.abs(dx) <= 0.000001 then
		if self.rotation_angle ~= nil and self.rotation_angle ~= 0 then
			if pos0.y >= pos1.y then
				self.cur_def_way = -1
			else
				self.cur_def_way = 1
			end
		end 
		return pos0,nil
	end

	

	return pos0,dy/dx
end


--通过时间计算当前坐标和偏转角度
function ActionCurve:getPosAndAngleByTime(t)
	self.cur_action_t = t
	local pos,k = self:getPosAndSlopeByTime(t)

	local angle = 0


	if k == nil then
		if self.cur_def_way == -1 then
			angle = 90
		else
			angle = 270
		end
	else
		if self.cur_def_way == 1 then
			angle = (360 - math.atan(k)*pi_angle/math.pi)
		else
			angle = (180 - math.atan(k)*pi_angle/math.pi)
		end
	end

	return pos,angle
end

function ActionCurve:isCurveEnd()
	local is_end = true
	local last_item = self.curve_lst[#self.curve_lst]
	if last_item then
		if last_item.t2 > self.cur_action_t then
			is_end = false
		end
	end

	return is_end
end

function ActionCurve:resetInfo()
	self.cur_action_t = 0
end

function ActionCurve:getActionWay()
	return self.cur_def_way
end

function ActionCurve:setActionReserve(bres)
	if bres ~= nil then	
		self.breserve = bres
		if self.breserve == true then
			for m,n in pairs(self.curve_lst) do
				n.x1,n.x2 = n.x2,n.x1
				n.s = (n.x2 - n.x1)
				n.v = n.s/n.time
			end
		end
	end
end

function ActionCurve:setActionRotation(angle)
	if angle ~= nil and (angle >= 0 and angle <= 360) then
		self.rotation_angle = angle
	end
end

function ActionCurve:clearAllCurve()
	self.curve_lst = {}
end

function ActionCurve:setCurveRatio(ratio)
	if ratio then
		self.ratio = ratio
	end
end


