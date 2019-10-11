#remark
NetSocket = class("NetSocket")


function NetSocket:create()
	if self.sobj then self.sobj:Close() end
	self.sobj = nil


	self.sobj = IClientSocket()
	local function _update() self.sobj:process() end

	local scheduler = cc.Director:getInstance():getScheduler()
	self.sch_handle = scheduler:scheduleScriptFunc(_update,0.0,false)
end

function NetSocket:destroy()
	self.sobj:Close()
	local scheduler = cc.Director:getInstance():getScheduler()
	scheduler:unscheduleScriptEntry(self.sch_handle)

	self.sobj = nil
end

--[[
	p = {
		ip,
		port,
		t_out,
		s_call,
		t_call,
		e_call,
		r_call,
	}
]]
function NetSocket:connect(p)
	if p and self.sobj then
		self.sobj:Connect(p.ip,p.port,p.t_out,p.s_call,p.t_call,p.e_call,p.r_call)
	end
end

function NetSocket:close()
	if self.sobj then
		self.sobj:Close()
	end
end

function NetSocket:send(s)
	if s then 
		self.sobj:SendStream(s) 
	end
end
