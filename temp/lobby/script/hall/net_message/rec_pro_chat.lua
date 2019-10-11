#remark
--[[
	房间聊天消息结果消息
	msg = {
		名称:content 类型:String 备注:内容
		名称:playerName 类型:String 备注:聊天的玩家
	}
]]
local function rec_pro_chat_ResRoomChat(msg)
	--add your logic code here
	HallManager:resRoomChatMsg(msg)
end

--[[
	桌子聊天消息结果消息
	msg = {
		名称:content 类型:String 备注:内容
		名称:playerName 类型:String 备注:聊天的玩家
	}
]]
local function rec_pro_chat_ResTableChat(msg)
	--add your logic code here
	HallManager:resTableChatMsg(msg)
end

--[[
	喇叭消息消息
	msg = {
		名称:playerName 类型:String 备注:玩家昵称
		名称:content 类型:String 备注:内容
	}
]]
local function rec_pro_chat_ResHorn(msg)
	--add your logic code here
	HallManager:resHornMsg(msg)
end

--[[
	聊天框系统公告消息消息
	msg = {
		名称:content 类型:String 备注:内容
	}
]]
local function rec_pro_chat_ResSysNotice(msg)
	--add your logic code here
	HallManager:resSysNoticeMsg(msg)
end


ReceiveMsg.regProRecMsg(110201, rec_pro_chat_ResRoomChat)--房间聊天消息结果 处理
ReceiveMsg.regProRecMsg(110202, rec_pro_chat_ResTableChat)--桌子聊天消息结果 处理
ReceiveMsg.regProRecMsg(110203, rec_pro_chat_ResHorn)--喇叭消息 处理
ReceiveMsg.regProRecMsg(110204, rec_pro_chat_ResSysNotice)--聊天框系统公告消息 处理

--传输对象说明
