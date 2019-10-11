#remark
--[[
老虎机管理类
]]

CSlotMachineCon = class("CSlotMachineCon",function()
	-- body
	local  ret = cc.Node:create()
	return ret
end)

function CSlotMachineCon.create(type)
	-- body
	local layer = CSlotMachineCon.new()
	if layer ~= nil then
		layer:init(type)
		return layer
	end
end

--所有一起开始转动
CSlotMachineCon.NORMAL_ALL = 0
--一个一个的转动
CSlotMachineCon.RIGHT_TO_LEFT = 1


function CSlotMachineCon:init(type)
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
	self.ALLLISTSTOP = {}
	self.REWARDlISTSTOP = {}
end

--/**增加一列奖励列表 */	
function CSlotMachineCon:addRewardList( rewardList )
	table.insert(self._rewardListVec, rewardList)
	EventUtils.addEventListener( self.REWARDlISTSTOP, rewardList, function ()
    self:rewardListStopHandler()
end, true )
	self:addChild( rewardList )
end

--/**转动结束事件检测*/
function CSlotMachineCon:rewardListStopHandler()
	if #self._rewardListVec == 0 then
		return
	end

	self.stopListCount = self.stopListCount + 1
	if self.stopListCount == #self._rewardListVec then
		EventUtils.dispathEvents( self.ALLLISTSTOP )
		self.stopListCount = 0
		return
	end

	if self.scrollType == CSlotMachineCon.RIGHT_TO_LEFT then
		local rewardList = self._rewardListVec[#self._rewardListVec - self.stopListCount]
		rewardList:startScroll( _rollTime )
	elseif self.scrollType == CSlotMachineCon.NORMAL_ALL then
		local rewardList = self._rewardListVec[self.stopListCount + 1]
		rewardList.isCanStop = true
	end
end

--开始转动
function CSlotMachineCon:startRoll( rollTime )
	self._rollTime = rollTime

	if self.scrollType == CSlotMachineCon.NORMAL_ALL then
		for k,v in pairs(self._rewardListVec) do
			v:startScroll(rollTime)
			if k == 1 then
				v.isCanStop = true
			end
		end
	elseif self.scrollType == CSlotMachineCon.RIGHT_TO_LEFT then
		if #self._rewardListVec > 0 then
			self._rewardListVec[#self._rewardListVec]:startScroll(rollTime)
		end
	end

end

--停止所有转动
function CSlotMachineCon:stopRoll()
	for k,v in pairs(self._rewardListVec) do
		v:stopScroll()
	end
end


--/**停止在对的位置 不会广播结束事件 只是停止而已*/
function CSlotMachineCon:stopRollRightNow()
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
function CSlotMachineCon:setRewardListSpeed( index, acceleration, maxSpeed, minSpeed)
	if index < 1 or index > #self._rewardListVec then
		return
	end
	
	self._rewardListVec[index].REWARDlISTSTOP = self.REWARDlISTSTOP
	self._rewardListVec[index].accelearation = acceleration == nil and 0 or acceleration
	self._rewardListVec[index].maxSpeed = maxSpeed == nil and 0 or maxSpeed
	self._rewardListVec[index].minSpeed = minSpeed == nil and 0 or minSpeed
end


--[[
设置莫一列的最终奖励
]]
function CSlotMachineCon:setReward(index, rewardID)
	if index < 0 or index > #self._rewardListVec then
		return
	end

	self._rewardListVec[index]:setFinalReward( rewardID )
end

--[[
清空奖励列表
]]
function CSlotMachineCon:clearRewardList()
	for k,v in pairs(self._rewardListVec) do
		EventUtils.removeEventListener( self.REWARD_CIRCLE_STOP, v )
		v:stopRightNow()
	end
	self:removeAllChildren()

	self._rewardListVec = {}
	self.stopListCount = 0
end


function CSlotMachineCon:autoStop()
	for k,v in pairs(self._rewardListVec) do
		v.isAutoStop = true
	end
end

function CSlotMachineCon:isRunning()
	for k,v in pairs(self._rewardListVec) do
		if v._state ~= 0 then
			return true
		end
	end

	return false
end

