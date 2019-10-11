#remark
--[[
	排行榜数据
	table = {
		order
		gold
		nickname
		avatar
	}
]]
local function rec_pro_rank_ResRankList(msg)
	HallManager:resRankListMsg(msg)
end


ReceiveMsg.regProRecMsg(999999, rec_pro_rank_ResRankList) -- 排行榜
