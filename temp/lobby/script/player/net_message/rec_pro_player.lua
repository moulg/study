#remark
--[[
	玩家属性改变消息消息
	msg = {
		名称:type 类型:int 备注:属性类型(1:元宝，2:金币,3:保险箱金币,4:积分,5:奖券,6:玩家等级,7:vip等级,8:vip时长)
		名称:val 类型:long 备注:属性值
	}
]]
local function rec_pro_player_ResPlayerAttrChange(msg)
	--add your logic code here
	player_manager:resPlayerAttrChangeMsg(msg)
end


ReceiveMsg.regProRecMsg(102201, rec_pro_player_ResPlayerAttrChange)--玩家属性改变消息 处理

--传输对象说明
