#remark
ReceiveMsg = {
	fun_lst   = {},
	parse_lst = {},
}

local displayArr = {100211, 112201, 112202, 112202, 110204, 109202,520236,520202,520231,521236,521231,521202,521233,}
local function isShow( id )
	for i,v in ipairs(displayArr) do
		if v == id then
			return false
		end
	end

	return true
end


function ReceiveMsg.regProRecMsg(msg_id,func)
	if msg_id and func then
		ReceiveMsg.fun_lst[msg_id] = func
		return true
	end

	return false
end

function ReceiveMsg.receivePro(msg_id,p)
	if msg_id then 
		local func = ReceiveMsg.fun_lst[msg_id]
		if func then
			func(p)
		end
	end
end

function ReceiveMsg.regParseRecMsg(msg_id,func)
	if msg_id and func then
		ReceiveMsg.parse_lst[msg_id] = func
		return true
	end

	return false
end

function ReceiveMsg.parseRecData(msg_id,sobj)
	if msg_id and sobj then
		if is_inner_ver() == true then
			if isShow(msg_id) then
		    	print(msg_id)
        	end
		end
      
		local func = ReceiveMsg.parse_lst[msg_id]
		if func then
			return func(sobj)
		else
			print(msg_id .. " function err")
		end
	end

	return nil
end

