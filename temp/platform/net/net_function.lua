#remark
function netConnectSuccess()
	print("connect success!")
	NetErrPro.connect_success_pro()
end

function netConnectTimeout()
	print("time out!")
	GameUpdateStateRec.resetGameUpdateState()
	NetErrPro.connect_timeout_pro()
end

function netConnectError()
	print("connect err!")
	GameUpdateStateRec.resetGameUpdateState()
	NetErrPro.connect_error_pro()
end

function netReceivePkg(stream)
	--print("get net stream >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	if stream then
		local sobj = CNetStream:GetObjByPointer(stream)
		if sobj then
			local msg_id = sobj:readInt()
			if msg_id then
				local data = ReceiveMsg.parseRecData(msg_id,sobj)
				if data then ReceiveMsg.receivePro(msg_id,data) end
			end
		end
	end
end
