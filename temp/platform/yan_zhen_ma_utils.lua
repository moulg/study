#remark
--[[
	获取验证码
]]


function get_yan_zhen_ma_str(yan_zhen_cfg,str_len)
	-- body
	math.newrandomseed()
	local t_len = #yan_zhen_cfg
	if t_len <= 0 then return "" end

	local str_yz = ""
	for i=1,str_len do
		local index = math.floor(math.random(1,t_len))
		str_yz = str_yz .. yan_zhen_cfg[index].str
	end
	
	return str_yz
end


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
