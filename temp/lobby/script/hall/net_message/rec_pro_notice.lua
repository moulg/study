#remark
--[[
	新闻公告消息
	msg = {
		名称:content 类型:String 备注:内容
		名称:link 类型:String 备注:连接
	}
]]
local function rec_pro_notice_ResNewsNotice(msg)
	--add your logic code here
	
end

--[[
	跑马灯公告消息
	msg = {
		名称:content 类型:String 备注:内容
		名称:type 类型:int 备注:0:游戏公告,1:官方公告,4:删除消息
		名称:noticeid 类型:int 备注:消息id
	}
]]
local function rec_pro_notice_ResMarqueeNotice(msg)
	--add your logic code here
	HallManager:resMarqueeNoticeMsg(msg)
end


ReceiveMsg.regProRecMsg(109201, rec_pro_notice_ResNewsNotice)--新闻公告 处理
ReceiveMsg.regProRecMsg(109202, rec_pro_notice_ResMarqueeNotice)--跑马灯公告 处理

--传输对象说明
