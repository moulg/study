--[[
	玩家存金币
	ReqDepositeGold ={
		名称:gold 类型:long 备注:金币
	}
]]
function send_bank_ReqDepositeGold(msg)
	local stream = CNetStream()
	stream:writeInt(107101)
	
	if msg.gold == nil then msg.gold = 0 end
	stream:writeLong(msg.gold)
	GetSocketInstance():send(stream)
end


--[[
	玩家取金币
	ReqWithdrawGold ={
		名称:bankPwd 类型:String 备注:银行密码
		名称:gold 类型:long 备注:金币
	}
]]
function send_bank_ReqWithdrawGold(msg)
	local stream = CNetStream()
	stream:writeInt(107102)
	
	if msg.bankPwd == nil then msg.bankPwd = "" end
	stream:writeString(msg.bankPwd)
	if msg.gold == nil then msg.gold = 0 end
	stream:writeLong(msg.gold)
	GetSocketInstance():send(stream)
end


--[[
	玩家转账
	ReqTransferGold ={
		名称:bankPwd 类型:String 备注:银行密码
		名称:gold 类型:long 备注:金币
		名称:target 类型:long 备注:转账目标玩家
	}
]]
function send_bank_ReqTransferGold(msg)
	local stream = CNetStream()
	stream:writeInt(107103)
	
	if msg.bankPwd == nil then msg.bankPwd = "" end
	stream:writeString(msg.bankPwd)
	if msg.gold == nil then msg.gold = 0 end
	stream:writeLong(msg.gold)
	if msg.target == nil then msg.target = 0 end
	stream:writeLong(msg.target)
	GetSocketInstance():send(stream)
end

--[[
	银行卡绑定
	ReqBankBandding ={
		名称:bcnumber 类型:String 备注:银行卡号
		名称:bcholdername 类型:String 备注:持卡人姓名
		名称:bcbank 类型:String 备注:开户行
		名称:contacts 类型:String 备注:联系方式
		名称:bcbankprovince 类型:String 备注:开户行省份
		名称:bankbranch 类型:String 备注:开户行支行
	}
]]
function send_bank_ReqBankBandding(msg)
	local stream = CNetStream()
	stream:writeInt(107106)
	
	if msg.bcnumber == nil then msg.bcnumber = "" end
	stream:writeString(msg.bcnumber)
	if msg.bcholdername == nil then msg.bcholdername = "" end
	stream:writeString(msg.bcholdername)
	if msg.bcbank == nil then msg.bcbank = "" end
	stream:writeString(msg.bcbank)
	if msg.contacts == nil then msg.contacts = "" end
	stream:writeString(msg.contacts)
	if msg.bcbankprovince == nil then msg.bcbankprovince = "" end
	stream:writeString(msg.bcbankprovince)
	if msg.bankbranch == nil then msg.bankbranch = "" end
	stream:writeString(msg.bankbranch)
	GetSocketInstance():send(stream)
end

--[[
	银行卡体现
	msg ={
		名称:money 类型:String 备注:体现金额
	}
]]
function send_bank_ReqBankReflect(msg)
	local stream = CNetStream()
	stream:writeInt(107107)
	
	if msg.money == nil then msg.money = "" end
	stream:writeString(msg.money)
	GetSocketInstance():send(stream)
end

--[[
	转账记录
	msg ={
	}
]]
function send_bank_ReqGaveRecord(msg)
	local stream = CNetStream()
	stream:writeInt(107108)
	--stream:
	GetSocketInstance():send(stream)
end

c2s_bank_ReqDepositeGold_msg = 107101 --[[玩家存金币]]
c2s_bank_ReqWithdrawGold_msg = 107102 --[[玩家取金币]]
c2s_bank_ReqTransferGold_msg = 107103 --[[玩家转账]]
c2s_bank_ReqBankBandding_msg = 107106 --[[银行卡绑定]]
c2s_bank_ReqBankReflect_msg  = 107107 --[[银行卡体现]]
c2s_bank_ReqGaveRecord_msg   = 107108 --[[转账记录]]
