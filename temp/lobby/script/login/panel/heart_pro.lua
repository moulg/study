--[[
	心跳处理
]]
--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码
local bsend_heart_msg 	   = false
local bstart_heart_msg_pro = false

local heart_invalid_time 	 = 9999999
local heart_invalid_time_add = 0


HeartPro = {}


function HeartPro.init_heart_pro()
	bsend_heart_msg = true
	heart_invalid_time_add = 0

	if bstart_heart_msg_pro == false then
		scheduler  = cc.Director:getInstance():getScheduler()
		HeartPro.sch_handle = scheduler:scheduleScriptFunc(HeartPro._update,2,false)
		bstart_heart_msg_pro = true
	end
end

function HeartPro.uninit_heart_pro()
	bsend_heart_msg 	 = false
	bstart_heart_msg_pro = false
	heart_invalid_time_add = 0

	if HeartPro.sch_handle then
		local scheduler = cc.Director:getInstance():getScheduler()
		scheduler:unscheduleScriptEntry(HeartPro.sch_handle)
	end
end

function HeartPro._update(dt)
	if bsend_heart_msg == true then
		--printf("send heart message to server!")
		send_login_ReqHeartbeat({})
		heart_invalid_time_add = heart_invalid_time_add + dt
		if heart_invalid_time_add >= heart_invalid_time then
			printf("socket is invalid, close it")
			--g_CloseSocket()
			bsend_heart_msg = false
		end
	end
end
--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码
function HeartPro.pause_send_hmsg()
	printf("pause to send heart message to server!")
	bsend_heart_msg = false
end

function HeartPro.resume_heart_msg()
	printf("resume to send heart message to server!")
	bsend_heart_msg = true
end

function HeartPro.pro_heart_msg(msg)
	--printf("get server heart message, the socket handle is valid!")
	heart_invalid_time_add = 0
end

