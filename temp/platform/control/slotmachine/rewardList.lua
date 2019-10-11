#remark
--[[
转动的奖励列表
]]



CRewardList = class("CRewardList",function()
	-- body
	local  ret = ccui.ImageView:create()
	return ret
end)

--/**转动类型*/
CRewardList.ROLL_UP_DOWN = 1		--上下转动
CRewardList.ROLL_LEFT_RIGHT = 2	--左右转动

--/**停止方式*/
CRewardList.ACCEL_SPEED_STOP = 1	--加速度停止
CRewardList.IMMEDIATELY_STOP = 2	--立刻停止

function CRewardList.create()
	-- body
	local layer = CRewardList.new()
	if layer ~= nil then
		layer:init()
		return layer
	end
end

function CRewardList:init()
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
	self._finalReward = nil
	--/**方向*/
	self._direction = 0
	--超时时间，如果设置了。不管现在是何种滚动状态，只要超时就停止
	self._delay = 0
	---/**开始转动时间*/
	self._beginTime = 0
	--/**转动持续时间*/
	self._rollTime = 0
	--/**偏移*/
	self._offset = 0
	--/**横竖类型*/
	self._rollState = 0

	--/**事件*/
	self.REWARDlISTSTOP = nil

	--是否可以停下来
	self.isCanStop = false
end

--[[
初始化奖励滚动信息  

rewardList        --物品列表
scrolldata  = {   --滚动信息
	offset  --icon间隔
	state  	--滚动类型
	dir 	--滚动方向
	stopType --速度类型
}
]]
function CRewardList:initRewards(rewardList, scrolldata)
	--间隔距离
	self._offset = scrolldata.offset
	--转动类型 上下 还是左右
	self._rollState = scrolldata.state
	--转动方向  像坐标轴正负方向移动  1 向上滚  -1 向下滚
	self._direction = scrolldata.dir
	self._stopType = scrolldata.stopType

	--物品列表
	self._rewards = rewardList

	-- self:setContentSize(rewardList[1]:getContentSize())
	
	self:setMask()
	--上下转动
	if self._rollState == CRewardList.ROLL_UP_DOWN then
		local offY = 0
		for i = 1, #rewardList do
			local obj = self._rewards[i]
			obj:setAnchorPoint(0,0)
			obj:setPosition(0, offY)
			offY = offY - (obj:getContentSize().height + self._offset)*self._direction
			self.clippingNode:addChild( obj )
		end
	--左右转动
	else
		local offX = 0
		for i = 1, #rewardList do
			local obj = self._rewards[i]
			obj:setAnchorPoint(0,0)
			obj:setPosition(offX, 0)
			offX = offX - (obj:getContentSize().width + self._offset)* self._direction
			self.clippingNode:addChild( obj )
		end
	end

end

--添加遮罩
function CRewardList:setMask()
	self.clippingNode = cc.ClippingNode:create()
	self:addChild(self.clippingNode)
	self.clippingNode:setPosition(0, 0)

	self.clippingNode:setInverted(false)
	self.clippingNode:setAlphaThreshold(1)

	self.stencilNode = cc.Node:create()
	local demo = self._rewards[1]:createMask()
	demo:setAnchorPoint(0,0)
	demo:setPosition(0,0)

	self.stencilNode:addChild(demo)
	self.stencilNode:setAnchorPoint(0,0)
	self.stencilNode:setPosition(0, 0)
	self.clippingNode:setStencil(self.stencilNode)
end

--开始转动  time 持续时间
function CRewardList:startScroll( time )
	self._rollTime = time
	self._state = 1
	self._beginTime = 0

	self:scheduleUpdateWithPriorityLua (function (t)
		self:onFrame(t)
		end, 0)
end


function CRewardList:onFrame( t )
	--如果转动时间到  则结束
	if self._state ~= 2 and self._state ~= 0 and self._beginTime >= self._rollTime and self._rollTime ~= -1 then
		self._state = 2

		--如果是立即停止模式  时间一到 立刻回调
		if self._stopType == self.IMMEDIATELY_STOP then
			self:stopRightNow()
			EventUtils.dispathEvents( self.REWARDlISTSTOP )
			return
		end
	end

	if self._state == 1 then
		self._scrollSpeed = self._scrollSpeed + self.accelearation
		if math.abs(self._scrollSpeed) > self.maxSpeed then
			self._scrollSpeed = self.maxSpeed
			--如果设置了自动停止标记，则达到最高速度之后开始减速
			if self.isAutoStop then
				self._state = 2
			end
		end
	elseif self._state == 2 then
		if math.abs(self._scrollSpeed) > self.minSpeed then
			self._scrollSpeed = self._scrollSpeed - self.accelearation
		else
			self._scrollSpeed = self.minSpeed

            -- 如果第二个奖励就是最终奖励，并且还没到位置，则设置奖励位置并停止
            if self._rollState == CRewardList.ROLL_UP_DOWN and self:isFinalItem(self._rewards[1]) then
                if math.floor( math.abs(self._rewards[1]:getPositionY()) ) <= math.max( self._offset, self.minSpeed ) then
			        self:stopRightNow()
			        EventUtils.dispathEvents( self.REWARDlISTSTOP )
			        return
                end
            else
                if self:isFinalItem(self._rewards[1]) and math.abs(self._rewards[1]:getPositionX()) <= math.max( self._offset, self.minSpeed ) then
				    self:stopRightNow()
				    EventUtils.dispathEvents( self.REWARDlISTSTOP );
				    return
			    end
            end
		end
	end

    for k,obj in pairs(self._rewards) do
		if self._rollState == CRewardList.ROLL_UP_DOWN then
			local obj_y = obj:getPositionY() + self._scrollSpeed * self._direction;
			obj:setPositionY(obj_y)
		else
			local obj_x = obj:getPositionX() + self._scrollSpeed * self._direction;
			obj:setPositionX(obj_x)
		end
	end

    --把转出去的第一个添加到列表屁股上去
	if self._rollState == CRewardList.ROLL_UP_DOWN then
		while ( self._direction == 1 and self._rewards[1]:getPositionY() >= (self._rewards[1]:getContentSize().height + self._offset) ) or
			( self._direction == -1 and self._rewards[1]:getPositionY() <= -(self._rewards[1]:getContentSize().height + self._offset) ) do
			local firstReward = self._rewards[1]
			local lastReward = self._rewards[#self._rewards]
			table.remove(self._rewards, 1)
			table.insert(self._rewards, firstReward)

			local pos_y = lastReward:getPositionY() - ( lastReward:getContentSize().height + self._offset ) * self._direction
			firstReward:setPositionY( pos_y ) 
		end
	else
		while ( self._direction == 1 and self._rewards[1]:getPositionX() >= (self._rewards[1]:getContentSize().width + self._offset) ) or
			( self._direction == -1 and self._rewards[1]:getPositionX() <= -(self._rewards[1]:getContentSize().width + self._offset) ) do
			local firstReward = self._rewards[1]
			local lastReward = self._rewards[#_rewards]
			table.remove(self._rewards, 1)
			table.insert(self._rewards, firstReward)

			local pos_x = lastReward:getPositionX() - ( lastReward:getContentSize().width + self._offset ) * self._direction
			firstReward:setPositionY( pos_x ) 
		end
	end

	self._beginTime = self._beginTime + t

end


function CRewardList:isFinalItem(reward)
	if self._finalReward ~= nil then
		return self._finalReward.id == reward.id and self.isCanStop
	end

	return true
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
function CRewardList:stopRightNow()
	self:unscheduleUpdate()
	self._scrollSpeed = 0
	self._state = 0

	for k,v in pairs(self._rewards) do
		if self._rollState == CRewardList.ROLL_UP_DOWN then
			v:setPositionY( (k - 1 ) * (v:getContentSize().height + self._offset) * (-self._direction) )
		else
			v:setPositionX( (k - 1) * (v:getContentSize().width + self._offset) * (-self._direction) )
		end
	end
end

function CRewardList:setFinalReward( id )
	for k,v in pairs(self._rewards) do
		if v.id == id then
			self._finalReward = v
			break
		end
	end
end