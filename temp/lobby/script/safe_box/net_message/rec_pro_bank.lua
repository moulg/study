--[[
	玩家转账消息消息
	msg = {
		名称:target 类型:long 备注:转账目标玩家
		名称:gold 类型:long 备注:金币
	}
]]
local function rec_pro_bank_ResTransferGoldSuccess(msg)
	--add your logic code here

	local CBankExt = WindowScene.getInstance():getModuleObjByClassName("CBankExt")
	if CBankExt then
		CBankExt:setData()
	end
	
    --转账凭证
    local reset_obj = CTransferEvidence.create()
    reset_obj:displayInfo(msg)
	WindowScene.getInstance():showDlg(reset_obj)

	TipsManager:showOneButtonTipsPanel(22, {msg.target}, true)
end

--[[
	银行卡体现消息
	msg ={
		名称:result 类型:int 备注:0成功  1失败
		名称:msg 类型:String 备注:结果消息
		
	}
]]
local function rec_pro_bank_ResBankReflectSuccess(msg)
	--add your logic code here

	local CBankExt = WindowScene.getInstance():getDlgByName("CBankExt")

	if CBankExt then
		local text = ""
		if 0==msg.result then
			text =  "提交成功"
		else
			text =  "提交失败"
		end
		local bk_hit_obj = BlackMessageHit.create({txt = text,color = cc.c3b(255,255,255),})
		WindowScene.getInstance():showDlg(bk_hit_obj)
	end
end

--[[
	绑定银行卡消息
	msg ={
		名称:result 类型:int 备注:0成功  1失败 
		名称:msg 类型:String 备注:结果消息
		名称:bcnumber 类型:String 备注:卡号
	}
]]
local function rec_pro_bank_ResBankBangdingSuccess(msg)
	--add your logic code here

	local pinfo = get_player_info()
	pinfo.bankCardnumber = msg.bcnumber

	local CBankExt = WindowScene.getInstance():getDlgByName("CBankExt")
	local CBangding = WindowScene.getInstance():getDlgByName("CBangding")
	if CBankExt and CBangding then

		local text = ""
		if 0==msg.result then
			text =  "提交成功"

			CBankExt:setData()
			WindowScene.getInstance():closeDlg(CBangding)
		else
			text =  "提交失败"
		end

		local bk_hit_obj = BlackMessageHit.create({txt = text,color = cc.c3b(255,255,255),})
		WindowScene.getInstance():showDlg(bk_hit_obj)

	end
end

--[[
	转账记录消息
	msg ={
		名称:strjson 类型:String 备注:
	}
]]
local function rec_pro_bank_ResGaveRecordSuccess(msg)
	--add your logic code here
	local CBankExt = WindowScene.getInstance():getDlgByName("CBankExt")

	if CBankExt then
		local output = json.decode(msg.strjson,1)
        CBankExt:refreshRecord(output)
	end
end

ReceiveMsg.regProRecMsg(107201, rec_pro_bank_ResTransferGoldSuccess)--玩家转账消息 处理
ReceiveMsg.regProRecMsg(107202, rec_pro_bank_ResBankBangdingSuccess)--绑定银行卡消息 处理
ReceiveMsg.regProRecMsg(107203, rec_pro_bank_ResBankReflectSuccess)--银行卡体现消息 处理
ReceiveMsg.regProRecMsg(107204, rec_pro_bank_ResGaveRecordSuccess)--转账记录消息 处理

--传输对象说明
