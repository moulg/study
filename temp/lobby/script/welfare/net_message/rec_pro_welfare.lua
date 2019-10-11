#remark
--[[
	福利信息消息
	msg = {
		名称:welfares 类型:List<WelfareInfo> 备注:福利信息
	}
]]
local function rec_pro_welfare_ResWelfareInfo(msg)
	--add your logic code here
	welfare_manager:resWelfareInfo(msg)
end

--[[
	福利刷新消息
	msg = {
		名称:welfares 类型:List<WelfareInfo> 备注:福利信息
	}
]]
local function rec_pro_welfare_ResRefreshWelfare(msg)
	--add your logic code here
	welfare_manager:resRefreshWelfare(msg)
end


ReceiveMsg.regProRecMsg(113201, rec_pro_welfare_ResWelfareInfo)--福利信息 处理
ReceiveMsg.regProRecMsg(113202, rec_pro_welfare_ResRefreshWelfare)--福利刷新 处理

--传输对象说明
--[[
	WelfareInfo = {
		type, --类型(1:签到,2:救济金)
		num, --次数
		params, --面板显示参数
	}
]]
