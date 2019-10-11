#remark
--[[
倒计时 方法类

]]

timeUtils = {}
timeUtils.timeDownMap = {}
timeUtils.timeUpMap = {}
timeUtils.downlen = 0
timeUtils.uplen = 0

local scheduler = cc.Director:getInstance():getScheduler()
--倒计时回调函数
local function timeCallBackHandler(dt)
	if timeUtils.downlen > 0 then
		for k,timedata in pairs(timeUtils.timeDownMap) do
			if timedata then
				timedata.time = timedata.time - dt
				timedata.perTimeAcc = timedata.perTimeAcc + dt

				if timedata.time <= -1 then
					if timedata.end_callback then
						timeUtils:remove(timedata.key)
						timedata.end_callback(timedata.args)
					end
				else
					if timedata.per_second_callback and timedata.perTimeAcc >= timedata.per_time then
						timedata.perTimeAcc = 0
						local showtime = math.ceil(timedata.time)
						timedata.per_second_callback(math.abs(showtime))
					end
				end
			end
		end
	end

	if timeUtils.uplen > 0 then
		for k,timedata in pairs(timeUtils.timeUpMap) do
			if timedata then
				timedata.time = timedata.time + dt
				timedata.perTimeAcc = timedata.perTimeAcc + dt

				if timedata.per_second_callback and timedata.perTimeAcc >= timedata.per_time then
					timedata.perTimeAcc = 0
					local showtime = math.ceil(timedata.time)
					timedata.per_second_callback(math.abs(showtime))
				end
			end
		end
	end

end

timeUtils.schedulerEntry = scheduler:scheduleScriptFunc(function (dt) timeCallBackHandler(dt) end, 0.1, false)

--添加倒计时
function timeUtils:addTimeDown(key, time, per_second_callback, end_callback, args, pertime)
	timeUtils:remove(key)
	local data = {key = key, time = time, per_second_callback = per_second_callback, end_callback = end_callback,
	 args = args, per_time = pertime == nil and 1 or pertime, perTimeAcc = 0}
	 table.insert(self.timeDownMap, data)
	self.downlen = self.downlen + 1
end

--添加正计时
function timeUtils:addTimeUp(key, per_second_callback, pertime)
	timeUtils:remove(key)
	local data = {key = key, time = 0, per_second_callback = per_second_callback, per_time = pertime == nil and 1 or pertime, perTimeAcc = 0}
	 table.insert(self.timeUpMap, data)
	self.uplen = self.uplen + 1
end

function timeUtils:remove(key)
	local find = nil

	for k,v in pairs(self.timeDownMap) do
		if v.key == key then
			find = k
			self.downlen = self.downlen - 1
			if self.downlen < 0 then
				self.downlen = 0
			end

			break
		end
	end

	if find then
		table.remove(self.timeDownMap, find)
	end

	find = nil
	for k,v in pairs(self.timeUpMap) do
		if v.key == key then
			find = k
			self.uplen = self.uplen - 1
			if self.uplen < 0 then
				self.uplen = 0
			end

			break
		end
	end

	if find then
		table.remove(self.timeUpMap, find)
	end
end



-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
