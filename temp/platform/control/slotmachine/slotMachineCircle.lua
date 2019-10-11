#remark
--[[
转圈老虎机管理类
]]

CSlotMachineConCirCle = class("CSlotMachineConCirCle",function()
	-- body
	local  ret = cc.Node:create()
	return ret
end)

function CSlotMachineConCirCle.create(type)
	-- body
	local layer = CSlotMachineConCirCle.new()
	if layer ~= nil then
		layer:init(type)
		return layer
	end
end

--所有一起开始转动
CSlotMachineConCirCle.NORMAL_ALL = 0
--一个一个的转动
CSlotMachineConCirCle.ONE_BY_ONE = 1


function CSlotMachineConCirCle:init(type)
	--滚动类型
	self.scrollType = type == nil and 0 or type

	--/**转动对象列表*/
	self._rewardListVec = {}
	--/**已经停止的奖励队列计数*/
	self.stopListCount = 0
	--/**转动时间**/
	self._rollTime = 0
	--/**保存值*/
	self._bindData = nil

	--/**所有转动结束事件相关*/
	self.ALL_CIRCLE_STOP = {}
	self.REWARD_CIRCLE_STOP = {}
end

--/**增加一列奖励列表 */	
function CSlotMachineConCirCle:addRewardList( rewardList )
	table.insert(self._rewardListVec, rewardList)
	EventUtils.addEventListener( self.REWARD_CIRCLE_STOP, rewardList, function ()
    self:rewardListStopHandler()
end)
	self:addChild( rewardList )
	rewardList:setPosition(0,0)
end

--/**转动结束事件检测*/
function CSlotMachineConCirCle:rewardListStopHandler()
	if #self._rewardListVec == 0 then
		return
	end

	self.stopListCount = self.stopListCount + 1
	if self.stopListCount == #self._rewardListVec then
		EventUtils.dispathEvents( self.ALL_CIRCLE_STOP )
		self.stopListCount = 0
		return
	end

	if self.scrollType == CSlotMachineConCirCle.ONE_BY_ONE then
		local rewardList = self._rewardListVec[#self._rewardListVec - self.stopListCount]
		rewardList:startScroll( _rollTime )
	end
end

--开始转动
function CSlotMachineConCirCle:startRoll( rollTime, initSpeed )
	self._rollTime = rollTime

	if self.scrollType == CSlotMachineConCirCle.NORMAL_ALL then
		for k,v in pairs(self._rewardListVec) do
			v:startScroll(rollTime,initSpeed)
		end
	elseif self.scrollType == CSlotMachineConCirCle.ONE_BY_ONE then
		if #self._rewardListVec > 0 then
			self._rewardListVec[#self._rewardListVec]:startScroll(rollTime,initSpeed)
		end
	end

end

--停止所有转动
function CSlotMachineConCirCle:stopRoll()
	for k,v in pairs(self._rewardListVec) do
		v:stopScroll()
	end
end


--/**停止在对的位置 不会广播结束事件 只是停止而已*/
function CSlotMachineConCirCle:stopRollRightNow()
	for k,v in pairs( self._rewardListVec ) do
		v:stopRightNow()
	end
end


--[[
 * 设置某一图片 列的加速度与速度信息
 * @param index			图片列列号，从1开始，自左往右依次增加
 * @param acceleration	加速度，默认值为0，即不设置
 * @param maxSpeed		最大速度，默认值为0，即不设置
 * @param minSpeed 		最小速度，默认值为0，即不设置
 */	]]	
function CSlotMachineConCirCle:setRewardListSpeed( index, acceleration, maxSpeed, minSpeed)
	if index < 1 or index > #self._rewardListVec then
		return
	end
	
	self._rewardListVec[index].REWARD_CIRCLE_STOP = self.REWARD_CIRCLE_STOP
	self._rewardListVec[index].accelearation = acceleration == nil and 0 or acceleration
	self._rewardListVec[index].maxSpeed = maxSpeed == nil and 0 or maxSpeed
	self._rewardListVec[index].minSpeed = minSpeed == nil and 0 or minSpeed
end


--[[
设置莫一列的最终奖励
]]
function CSlotMachineConCirCle:setReward(index, rewardID)
	if index < 0 or index > #self._rewardListVec then
		return
	end

	self._rewardListVec[index]:setFinalReward( rewardID )
end

--[[
清空奖励列表
]]
function CSlotMachineConCirCle:clearRewardList()
	for k,v in pairs(self._rewardListVec) do
		EventUtils.removeEventListener( self.REWARD_CIRCLE_STOP, v )
		v:stopRightNow()
	end
	self:removeAllChildren()

	self._rewardListVec = {}
	self.stopListCount = 0
end


function CSlotMachineConCirCle:autoStop()
	for k,v in pairs(self._rewardListVec) do
		v.isAutoStop = true
	end
end

function CSlotMachineConCirCle:isRunning()
	for k,v in pairs(self._rewardListVec) do
		if v._state ~= 0 then
			return true
		end
	end

	return false
end

