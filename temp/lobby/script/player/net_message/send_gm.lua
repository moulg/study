#remark
--[[
	gm消息
	ReqGm ={
		名称:cmd 类型:String 备注:命令
	}
]]
function send_gm_ReqGm(msg)
	local stream = CNetStream()
	stream:writeInt(400101)
	
	if msg.cmd == nil then msg.cmd = "" end
	stream:writeString(msg.cmd)
	GetSocketInstance():send(stream)
end


c2s_gm_ReqGm_msg = 400101 --[[gm消息]]
