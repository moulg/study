--[[
	connect server config
]]

if get_xue_Version() == 1 then
	net_config={
		-- ip = "122.114.71.199",	--正式服务
		-- port = 6004,

		ip = "192.168.8.22",	--测试服务
		port = 6004,
		time_out = 20,

	}  
else 
	net_config={
		ip = "127.168.8.22",	--正式服务
	
		--ip = "192.168.8.89",	--测试服务
		port = 6004,
		time_out = 20,
	
	}  
end
