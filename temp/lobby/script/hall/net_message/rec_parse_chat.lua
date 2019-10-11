#remark
--[[
	房间聊天消息结果
	msg ={
		名称:content 类型:String 备注:内容
		名称:playerName 类型:String 备注:聊天的玩家
	}
]]
function rec_parse_chat_ResRoomChat(sobj)

	if sobj then
		local msg = {}
		msg.content = sobj:readString()
		msg.playerName = sobj:readString()
		return msg
	end
	return nil
end


--[[
	桌子聊天消息结果
	msg ={
		名称:content 类型:String 备注:内容
		名称:playerName 类型:String 备注:聊天的玩家
	}
]]
function rec_parse_chat_ResTableChat(sobj)

	if sobj then
		local msg = {}
		msg.content = sobj:readString()
		msg.playerName = sobj:readString()
		return msg
	end
	return nil
end


--[[
	喇叭消息
	msg ={
		名称:playerName 类型:String 备注:玩家昵称
		名称:content 类型:String 备注:内容
	}
]]
function rec_parse_chat_ResHorn(sobj)

	if sobj then
		local msg = {}
		msg.playerName = sobj:readString()
		msg.content = sobj:readString()
		return msg
	end
	return nil
end


--[[
	聊天框系统公告消息
	msg ={
		名称:content 类型:String 备注:内容
	}
]]
function rec_parse_chat_ResSysNotice(sobj)

	if sobj then
		local msg = {}
		msg.content = sobj:readString()
		return msg
	end
	return nil
end


s2c_chat_ResRoomChat_msg = 110201 --[[房间聊天消息结果]]
s2c_chat_ResTableChat_msg = 110202 --[[桌子聊天消息结果]]
s2c_chat_ResHorn_msg = 110203 --[[喇叭消息]]
s2c_chat_ResSysNotice_msg = 110204 --[[聊天框系统公告消息]]

ReceiveMsg.regParseRecMsg(110201, rec_parse_chat_ResRoomChat)--[[房间聊天消息结果]]
ReceiveMsg.regParseRecMsg(110202, rec_parse_chat_ResTableChat)--[[桌子聊天消息结果]]
ReceiveMsg.regParseRecMsg(110203, rec_parse_chat_ResHorn)--[[喇叭消息]]
ReceiveMsg.regParseRecMsg(110204, rec_parse_chat_ResSysNotice)--[[聊天框系统公告消息]]

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
