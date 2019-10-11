#remark
--[[
	WelfareInfo ={
		名称:type 类型:int 备注:类型(1:签到,2:救济金)
		名称:num 类型:int 备注:次数
		名称:params 类型:List<String> 备注:面板显示参数
	}
]]
local function write_WelfareInfo(stream,bean)
	if bean.type == nil then bean.type = 0 end
	stream:writeInt(bean.type)
	if bean.num == nil then bean.num = 0 end
	stream:writeInt(bean.num)
	if bean.params == nil then bean.params = {} end
	stream:writeInt(#(bean.params))
	for i=1, #(bean.params) do  
		stream:writeString(bean.params[i])
	end 	
end



--[[
	玩家签到
	ReqSignIn ={
	}
]]
function send_welfare_ReqSignIn(msg)
	local stream = CNetStream()
	stream:writeInt(113101)
	
	GetSocketInstance():send(stream)
end


--[[
	玩家领取救济金
	ReqReceiveBenefits ={
	}
]]
function send_welfare_ReqReceiveBenefits(msg)
	local stream = CNetStream()
	stream:writeInt(113102)
	
	GetSocketInstance():send(stream)
end


c2s_welfare_ReqSignIn_msg = 113101 --[[玩家签到]]
c2s_welfare_ReqReceiveBenefits_msg = 113102 --[[玩家领取救济金]]
