#remark

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

--[[
	新闻公告
	msg ={
		名称:content 类型:String 备注:内容
		名称:link 类型:String 备注:连接
	}
]]
function rec_parse_notice_ResNewsNotice(sobj)

	if sobj then
		local msg = {}
		msg.content = sobj:readString()
		msg.link = sobj:readString()
		return msg
	end
	return nil
end


--[[
	跑马灯公告
	msg ={
		名称:content 类型:String 备注:内容
		名称:type 类型:int 备注:0:游戏公告,1:官方公告,4:删除消息
		名称:noticeid 类型:int 备注:消息id
	}
]]
function rec_parse_notice_ResMarqueeNotice(sobj)

	if sobj then
		local msg = {}
		msg.content = sobj:readString()
		msg.type = sobj:readInt()
		msg.noticeid = sobj:readInt()

		return msg
	end
	return nil
end


s2c_notice_ResNewsNotice_msg = 109201 --[[新闻公告]]
s2c_notice_ResMarqueeNotice_msg = 109202 --[[跑马灯公告]]

ReceiveMsg.regParseRecMsg(109201, rec_parse_notice_ResNewsNotice)--[[新闻公告]]
ReceiveMsg.regParseRecMsg(109202, rec_parse_notice_ResMarqueeNotice)--[[跑马灯公告]]
