#remark
--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码


login_manager = {}

--[[
	玩家信息消息
	msg = {
		名称:playerInfo 类型:PlayerInfo 备注:玩家信息
	}
]]
--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码

function login_manager:loginSuccessMsg(data)
	local pinfo 	= get_player_info()
	pinfo.id 		= data.playerInfo.id
	pinfo.name 		= data.playerInfo.name or ""
	pinfo.level 	= data.playerInfo.level or 0
	pinfo.vipLevel 	= data.playerInfo.vipLevel or 0
	pinfo.gold 		= data.playerInfo.gold or 0
    pinfo.acer 		= data.playerInfo.ingot or 0
    pinfo.safeGold 	= data.playerInfo.safeGold or 0
    pinfo.integral 	= data.playerInfo.cedit or 0
    pinfo.charm 	= data.playerInfo.charm or 0
    pinfo.lottery 	= data.playerInfo.lottery or 0

    pinfo.phone            = data.playerInfo.phone or "" 			--电话
    pinfo.email            = data.playerInfo.email or ""            --邮箱
    pinfo.fullName         = data.playerInfo.fullName or ""			--玩家姓名
    pinfo.sex          	   = data.playerInfo.sex or "女"			--性别
    pinfo.head_id          = data.playerInfo.icon or 1				--头像Id
    pinfo.idCardNo         = data.playerInfo.idCardNo or ""			--玩家身份证号
    pinfo.vipTime      	   = data.playerInfo.vipDuration or 0		--vip时长(秒)
    pinfo.age              = data.playerInfo.age or 18 				--年龄
    pinfo.birthMonth       = data.playerInfo.birthMonth or 1 		--出生月
    pinfo.birthDay         = data.playerInfo.birthDay or 1			--出生日
    pinfo.province         = data.playerInfo.province  or ""		--省
    pinfo.city             = data.playerInfo.city or ""				--市
    pinfo.addr             = data.playerInfo.addr or ""				--地址
    pinfo.signature        = data.playerInfo.signature or ""		--签名
    pinfo.bindingMac       = data.playerInfo.bindingMac or ""		--绑定机器码
    pinfo.havePwdProtect   = data.playerInfo.havePwdProtect	or 0	--是否有密保(0:没有,非0:有)
    pinfo.loginPhoneVerify = data.playerInfo.loginPhoneVerify or 0	--登录是否需要手机验证(0:不需要，非0:需要)
    pinfo.playItemEffect   = data.playerInfo.playItemEffect or 0	--是否需要播放道具使用特效(0:不需要，非0:需要)
    pinfo.welfares         = data.playerInfo.welfares or {}         --福利
    pinfo.is_tourist       = false--data.playerInfo.tourist == 0           --0:不是游客,1:游客
    pinfo.password 	       = data.playerInfo.password or ""
    pinfo.bankCardnumber   = data.playerInfo.bankCardnumber or ""   --银行卡号("":未绑定， 非"":已绑定)

    saveUserNameLst()
end
--注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码 注释代码

function login_manager:enterGame()
    WaitMessageHit.closeWaitMessageHit()
    print("登陆成功！！！！！！！！！！！！！")
    print("login success,goto game lobby")
    local obj = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
    if obj == nil then
        WindowScene.getInstance():replaceModuleByModuleName("game_lobby")
        update_login_state(true)
    else
        print("you have enter game lobby>>>>>>>>>>>>>>>>>")
    end
end
