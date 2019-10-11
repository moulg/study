#remark
--[[
	房间聊天消息
	ReqRoomChat ={
		名称:content 类型:String 备注:内容
	}
]]
function send_chat_ReqRoomChat(msg)
	local stream = CNetStream()
	stream:writeInt(110101)
	
	if msg.content == nil then msg.content = "" end
	stream:writeString(msg.content)
	GetSocketInstance():send(stream)
end


--[[
	桌子聊天消息
	ReqTableChat ={
		名称:content 类型:String 备注:内容
	}
]]
function send_chat_ReqTableChat(msg)
	local stream = CNetStream()
	stream:writeInt(110102)
	
	if msg.content == nil then msg.content = "" end
	stream:writeString(msg.content)
	GetSocketInstance():send(stream)
end


c2s_chat_ReqRoomChat_msg = 110101 --[[房间聊天消息]]
c2s_chat_ReqTableChat_msg = 110102 --[[桌子聊天消息]]

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
