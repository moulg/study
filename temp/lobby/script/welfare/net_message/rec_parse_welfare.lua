#remark
--[[
	WelfareInfo ={
		名称:type 类型:int 备注:类型(1:签到,2:救济金)
		名称:num 类型:int 备注:次数
		名称:params 类型:List<String> 备注:面板显示参数
	}
]]
function read_com_wly_game_welfare_dto_WelfareInfo(sobj)
	local obj = {};
	obj.type = sobj:readInt()
	obj.num = sobj:readInt()
	local paramsSize = sobj:readInt()
	obj.params = {}
	for i=1, paramsSize do  
		obj.params[i] = sobj:readString()
	end 	
	
	return obj		
end



--[[
	福利信息
	msg ={
		名称:welfares 类型:List<WelfareInfo> 备注:福利信息
	}
]]
function rec_parse_welfare_ResWelfareInfo(sobj)

	if sobj then
		local msg = {}
		local welfaresSize = sobj:readInt()
		msg.welfares = {}
		for i=1, welfaresSize do  
			msg.welfares[i] = read_com_wly_game_welfare_dto_WelfareInfo(sobj)
		end 	
		return msg
	end
	return nil
end


--[[
	福利刷新
	msg ={
		名称:welfares 类型:List<WelfareInfo> 备注:福利信息
	}
]]
function rec_parse_welfare_ResRefreshWelfare(sobj)

	if sobj then
		local msg = {}
		local welfaresSize = sobj:readInt()
		msg.welfares = {}
		for i=1, welfaresSize do  
			msg.welfares[i] = read_com_wly_game_welfare_dto_WelfareInfo(sobj)
		end 	
		return msg
	end
	return nil
end


s2c_welfare_ResWelfareInfo_msg = 113201 --[[福利信息]]
s2c_welfare_ResRefreshWelfare_msg = 113202 --[[福利刷新]]

ReceiveMsg.regParseRecMsg(113201, rec_parse_welfare_ResWelfareInfo)--[[福利信息]]
ReceiveMsg.regParseRecMsg(113202, rec_parse_welfare_ResRefreshWelfare)--[[福利刷新]]
