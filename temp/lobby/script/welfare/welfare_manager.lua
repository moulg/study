#remark
--[[
福利管理类
]]

welfare_manager = {}
--[[
	福利信息消息
	msg = {
		名称:welfares 类型:List<WelfareInfo> 备注:福利信息
	}
]]
function welfare_manager:resWelfareInfo(msg)
	--add your logic code here
	local playerInfo = get_player_info()
	playerInfo.welfares = msg.welfares


end
--[[
	福利刷新消息
	msg = {
		名称:welfares 类型:List<WelfareInfo> 备注:福利信息
	}
]]
function welfare_manager:resRefreshWelfare(msg)
	--add your logic code here
	local playerInfo = get_player_info()
	playerInfo.welfares = msg.welfares

end