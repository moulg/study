#remark

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

function rec_parse_rank_ResRank(sobj)

	if sobj then
		local msg = {}
		local itemSize = sobj:readInt()
		msg.size = itemSize
		for i=1, itemSize do  
			msg[i]={}
			msg[i].id = sobj:readInt()               
			msg[i].nickname = sobj:readString() 
			msg[i].gold = sobj:readLong()     
			msg[i].index = i             
		end 	
		return msg
	end
	return nil
end


s2c_rank_ResRank_msg = 999999 --[[排行榜结果]]

ReceiveMsg.regParseRecMsg(999999, rec_parse_rank_ResRank)--房间聊天消息结果 处理
