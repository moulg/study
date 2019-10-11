#remark
--[[
飞行动作

]]


CFlyAction = {}

--飞行效果  筹码抛出
CFlyAction.FLY_TYPE_CHIPS = 1
--飞行效果  筹码返回
CFlyAction.FLY_TYPE_CHIPS_BACK = 2
--飞行效果  匀速飞行
CFlyAction.FLY_TYPE_NORMAL = 3

--携带数据
CFlyAction.data = nil
--飞行结束回调
CFlyAction.flyEndCallback = nil
--飞行结束的坐标
CFlyAction.endPos_x = 0
CFlyAction.endPos_y = 0

--flyObj  飞行对象
--time  飞行时间
--params:
	--endPos_x
	--endPos_y
	--flyendCallback

function CFlyAction:Fly(flyObj, time, params, flytype)
	self.endPos_x = params.endPos_x
	self.endPos_y = params.endPos_y
	self.flyEndCallback = params.flyendCallback

	local move_action

	if flytype == CFlyAction.FLY_TYPE_CHIPS then
		move_action = cc.EaseExponentialOut:create( cc.MoveTo:create(time, cc.p(self.endPos_x, self.endPos_y)) )
	elseif flytype == CFlyAction.FLY_TYPE_CHIPS_BACK then
		move_action = cc.EaseExponentialIn:create( cc.MoveTo:create(time, cc.p(self.endPos_x, self.endPos_y)) )
	elseif flytype == CFlyAction.FLY_TYPE_NORMAL then
		move_action = cc.MoveTo:create(time, cc.p(self.endPos_x, self.endPos_y))
	end

	local seqArr = {}
	table.insert(seqArr, move_action)
	if self.flyEndCallback then
		local call_action = cc.CallFunc:create(self.flyEndCallback)
		table.insert(seqArr, call_action)
	end
	local seq = cc.Sequence:create(seqArr)
	flyObj:runAction(seq)
end