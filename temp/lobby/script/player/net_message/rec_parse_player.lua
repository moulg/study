
--#remark
--[[
	玩家属性改变消息
	msg ={
		名称:type 类型:int 备注:属性类型(1:元宝，2:金币,3:保险箱金币,4:积分,5:奖券,6:玩家等级,7:vip等级,8:vip时长)
		名称:val 类型:long 备注:属性值
	}
]]
function rec_parse_player_ResPlayerAttrChange(sobj)

	if sobj then
		local msg = {}
		msg.type = sobj:readInt()
		msg.val = sobj:readLong()
		return msg
	end
	return nil
end


s2c_player_ResPlayerAttrChange_msg = 102201 --[[玩家属性改变消息]]

ReceiveMsg.regParseRecMsg(102201, rec_parse_player_ResPlayerAttrChange)--[[玩家属性改变消息]]
