#remark
--[[
转动的奖励列表
]]



CRewardListCircle = class("CRewardListCircle",function()
	-- body
	local  ret = cc.Node:create()
	return ret
end)

--/**转动类型*/
CRewardListCircle.ORDER_ROLL = 1		--顺序转动
CRewardListCircle.RANDOM_ROLL = 2	--随机转动

--间隔 n 开始减速
local DOWN_INTERAL = 10
--转动圈数
local CIRCLE_COUNT = 3


function CRewardListCircle.create()
	-- body
	local layer = CRewardListCircle.new()
	if layer ~= nil then
		layer:init()
		return layer
	end
end

function CRewardListCircle:init()
	--/**转动速度相关*/
	self.accelearation = 0.3	--加速度
	self.maxSpeed = 20		---最大速度
	self.minSpeed = 1			--最小速度

	---/**物品列表*/
	self._rewards = nil
	--/**当前状态 0停止 1开始滚动，2减速*/
	self._state = 0
	--/**是否自动停止*/
	self.isAutoStop = false
	--/**转动速度*/
	self._scrollSpeed = 0
	--/**最终奖励*/
	self._finalRewardId = nil
	---/**开始转动时间*/
	self._beginTime = 0
	--/**转动持续时间*/
	self._rollTime = 0
	--时间间隔记录
	self._recodTimeInterval = 0
	--当前转到的目标索引
	self._curShowIndex = 1

	--停止方式  0  时间停止   1 圈数停止
	self._stopKind = 0


	--/**事件*/
	self.REWARD_CIRCLE_STOP = nil
end

function CRewardListCircle:setStartIndex(index)
	self._curShowIndex = index
end

--[[
初始化奖励滚动信息  

rewardList      --物品列表
state      --转动类型
stopKind   --停止方式
]]
function CRewardListCircle:initRewards(rewardList, state, stopKind)
	
	self._rollState = state

	self._stopKind = stopKind == nil and 0 or 1

	--物品列表
	self._rewards = rewardList

	for i = 1, #rewardList do
		local obj = self._rewards[i]
		obj:setAnchorPoint(0.5,0.5)
		self:addChild( obj )
	end
end

--开始转动  time 持续时间
function CRewardListCircle:startScroll( time, initSpeed )
	self._rollTime = time
	self._state = 1
	self._beginTime = 0
	self._scrollSpeed = initSpeed == nil and 1 or initSpeed

	self._rotationCount = 0
	self._scrollGridNum = 0

	self:rollToReward(self._curShowIndex)

	self:scheduleUpdateWithPriorityLua (function (t)
		if self._stopKind == 0 then
			self:timeDownOnFrame(t)
		elseif self._stopKind == 1 then
			self:circleDownOnFrame(t)
		end
		end, 0)
end

function CRewardListCircle:rollToReward(index)
	self._curShowIndex = index
	for i,v in ipairs(self._rewards) do
		v:setDisplay(index)
	end
end

--按时间停止
function CRewardListCircle:timeDownOnFrame( t )
	--如果转动时间到  则结束
	if self._state ~= 2 and self._state ~= 0 and self._beginTime >= self._rollTime and self._rollTime ~= -1 then
		self._state = 2
	end

	if self._state == 1 then

		if self._recodTimeInterval >= 1/self._scrollSpeed then
            self._scrollSpeed = self._scrollSpeed + self.accelearation
			if self._scrollSpeed > self.maxSpeed then

				self._scrollSpeed = self.maxSpeed
				--如果设置了自动停止标记，则达到最高速度之后开始减速
				if self.isAutoStop then
					self._state = 2
				end
			end

			self._recodTimeInterval = 0

			if self._rollState == CRewardListCircle.ORDER_ROLL then
				self._curShowIndex = self._curShowIndex + 1 > #self._rewards and 1 or self._curShowIndex + 1
				self:rollToReward(self._curShowIndex)
			else
				self._curShowIndex = self:getRandomIndex()
				self:rollToReward(self._curShowIndex)
			end
		end
	elseif self._state == 2 then
		if self._recodTimeInterval >= 1/self._scrollSpeed then
            self._scrollSpeed = self._scrollSpeed - self.accelearation
			if self._scrollSpeed < self.minSpeed then
				self._scrollSpeed = self.minSpeed

				-- 如果当前奖励就是最终奖励，停止
	            if self:isFinalItem() then
			        self:stopRightNow()
			        EventUtils.dispathEvents( self.REWARD_CIRCLE_STOP )
			        return
	            end
			end

			self._recodTimeInterval = 0

			if self._rollState == CRewardListCircle.ORDER_ROLL then
				self._curShowIndex = self._curShowIndex + 1 > #self._rewards and 1 or self._curShowIndex + 1
				self:rollToReward(self._curShowIndex)
			else
				self._curShowIndex = self:getRandomIndex()
				self:rollToReward(self._curShowIndex)
			end
		end
	end

	self._beginTime = self._beginTime + t
	self._recodTimeInterval = self._recodTimeInterval + t
end

--按圈数停止
function CRewardListCircle:circleDownOnFrame( t )
	if self._state == 1 then

		if self._recodTimeInterval >= 1/self._scrollSpeed then
            self._scrollSpeed = self._scrollSpeed + self.accelearation
			if self._scrollSpeed > self.maxSpeed then

				self._scrollSpeed = self.maxSpeed
				--如果设置了自动停止标记，则达到最高速度之后开始减速
				if self.isAutoStop then
					self._state = 2
				end
			end

			self._recodTimeInterval = 0

			if self._rollState == CRewardListCircle.ORDER_ROLL then
				self._curShowIndex = self._curShowIndex + 1 > #self._rewards and 1 or self._curShowIndex + 1
				self:rollToReward(self._curShowIndex)

				if self._rotationCount ~= CIRCLE_COUNT then
					self._scrollGridNum = self._scrollGridNum + 1

					if self._scrollGridNum == #self._rewards then
						self._rotationCount = self._rotationCount + 1
						self._scrollGridNum = 0
					end
				end

				if self._rotationCount == CIRCLE_COUNT then
					if self:getFinalRewardIndex() - self._curShowIndex == DOWN_INTERAL or self:getFinalRewardIndex() + (#self._rewards - 1) - self._curShowIndex == DOWN_INTERAL then
						self._state = 2
					end
				end
			else
				self._curShowIndex = self:getRandomIndex()
				self:rollToReward(self._curShowIndex)
			end
		end
	elseif self._state == 2 then
		if self._recodTimeInterval >= 1/self._scrollSpeed then
            self._scrollSpeed = self._scrollSpeed - self.accelearation
			if self._scrollSpeed < self.minSpeed then
				self._scrollSpeed = self.minSpeed
			end

			-- 如果当前奖励就是最终奖励，停止
            if self:isFinalItem() then
		        self:stopRightNow()
		        EventUtils.dispathEvents( self.REWARD_CIRCLE_STOP )
		        return
            end

			self._recodTimeInterval = 0

			if self._rollState == CRewardListCircle.ORDER_ROLL then
				self._curShowIndex = self._curShowIndex + 1 > #self._rewards and 1 or self._curShowIndex + 1
				self:rollToReward(self._curShowIndex)
			else
				self._curShowIndex = self:getRandomIndex()
				self:rollToReward(self._curShowIndex)
			end
		end
	end

	self._beginTime = self._beginTime + t
	self._recodTimeInterval = self._recodTimeInterval + t
end

function CRewardListCircle:getRandomIndex()
	local index = math.random(1, #self._rewards)
	if index == self._curShowIndex then
		return self:getRandomIndex()
	else
		return index
	end
end


function CRewardListCircle:isFinalItem()
	return self._rewards[self._curShowIndex].id == self._finalRewardId
end

--/**停止转动*/
function stopScroll()
	if self._state == 0 and self._scrollSpeed == 0 then
		return
	end
	--状态变为减速移动
	_state = 2
end

--只是中断滚动的行为，终止事件就不发了 
function CRewardListCircle:stopRightNow()
	self:unscheduleUpdate()
	self._scrollSpeed = 0
	self._state = 0
end

function CRewardListCircle:setFinalReward( id )
	
	self._finalRewardId = id
end

function CRewardListCircle:getFinalRewardItem()
	for i,v in ipairs(self._rewards) do
		if v.id == self._finalRewardId then
			return v
		end
	end
end

function CRewardListCircle:getFinalRewardIndex()
	for i,v in ipairs(self._rewards) do
		if v.id == self._finalRewardId then
			return i
		end
	end
end