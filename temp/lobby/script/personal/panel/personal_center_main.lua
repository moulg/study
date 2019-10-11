#remark
local panel_ui

CPersonalCenterMain = class("CPersonalCenterMain", function ()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
    return ret
end)


function CPersonalCenterMain.create()
	local layer = CPersonalCenterMain.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end

function CPersonalCenterMain:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter();
		elseif event == "exit" then
			self:onExit();
		end
	end

	self:registerScriptHandler(_onEnterOrExit);
end

function CPersonalCenterMain:onEnter()
	self:setTouchEnabled(true)
end

function CPersonalCenterMain:onExit()

end

function CPersonalCenterMain:init_ui()
	panel_ui = require("lobby.ui_create.ui_Personal").create()
	self:addChild(panel_ui.root)
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	panel_ui.root:setPosition(size.width/2, size.height/2)

	self:registerHandler()

	self:setInfo()

	local info = {
		parent = self,
		pos = {
			x = size.width/2,
			y = size.height/2,
		},
	}
	self.phoneBandingPanel = CPhoneBandingExt.create(info)
	self.phoneBandingPanel:setVisible(false)

	self.realNamePanel = CRealNameRequest.create()
	self.realNamePanel:setPosition(size.width/2, size.height/2)
	self:addChild(self.realNamePanel)
	self.realNamePanel:setVisible(false)

	local targetPlatform = cc.Application:getInstance():getTargetPlatform()
	if cc.PLATFORM_OS_WINDOWS == targetPlatform then


        local Button_1 = ccui.Button:create()
        Button_1:ignoreContentAdaptWithSize(false)
        Button_1:setTitleFontSize(28)
        Button_1:setTitleText("复制ID")
        Button_1:setTitleColor({r = 0, g = 250, b = 0})
        Button_1:setScale9Enabled(true)
        Button_1:setCapInsets({x = 15, y = 4, width = 12, height = 6})
        Button_1:setLayoutComponentEnabled(true)
        Button_1:setName("Button_1")
        Button_1:setTag(4)
        Button_1:setCascadeColorEnabled(true)
        Button_1:setCascadeOpacityEnabled(true)
        layout = ccui.LayoutComponent:bindLayoutComponent(Button_1)
        layout:setPositionPercentX(0.4778)
        layout:setPositionPercentY(0.3839)
        layout:setPercentWidth(0.0365)
        layout:setPercentHeight(0.0278)
        layout:setSize({width = 70.0000, height = 30.0000})
        layout:setLeftMargin(882.4413)
        layout:setRightMargin(967.5587)
        layout:setTopMargin(650.4380)
        layout:setBottomMargin(399.5620)
        panel_ui.node_copyID:addChild(Button_1)
		Button_1:onTouch(function(e)
            if e.name == "ended" then
			    local selfInfo = get_player_info()
			    WindowModule.setTextFromClipboard(tostring(selfInfo.id))
            end
		end)
	end
end

function CPersonalCenterMain:setInfo()
	local pinfo = get_player_info()
	panel_ui.CheckBox_Man:setSelected(pinfo.sex == "男")
	panel_ui.CheckBox_Woman:setSelected(pinfo.sex == "女")

	--头像
	local sex = pinfo.sex == "男" and 0 or 1
	uiUtils:setPhonePlayerHead(panel_ui.imgHead, sex, uiUtils.HEAD_SIZE_223)

	panel_ui.testName:setString(pinfo.id)
	panel_ui.testPetname:setString(pinfo.name)

	if pinfo.idCardNo == "" then
		panel_ui.btnCardNo:setEnabled(true)
		panel_ui.btnCardNo:setBright(true)
	else
		panel_ui.btnCardNo:setEnabled(false)
		panel_ui.btnCardNo:setBright(false)
	end

	if pinfo.phone == "" then
		panel_ui.btnBind:loadTextureNormal("lobby/resource/PersonalCenter/qxbd.png",0)
	else
		panel_ui.btnBind:loadTextureNormal("lobby/resource/PersonalCenter/qwjb.png",0)
	end
end

function CPersonalCenterMain:registerHandler()
	--认证
	panel_ui.btnCardNo:onTouch(function (e)
		if e.name == "ended" then
			self.realNamePanel:setVisible(true)
			global_music_ctrl.play_btn_one()
		end
	end)


	panel_ui.btnBind:onTouch(function (e)
		if e.name == "ended" then
			self.phoneBandingPanel:setVisible(true)
			global_music_ctrl.play_btn_one()
		end
	end)

	local function stateButtonCallBack( e )
		if e.target == panel_ui.CheckBox_Man and e.name == "selected" then
			personal_manager:reqModifyBaseInfoMsg("男")
		elseif e.target == panel_ui.CheckBox_Woman and e.name == "selected" then
			personal_manager:reqModifyBaseInfoMsg("女")
		end
		global_music_ctrl.play_btn_one()
	end

	panel_ui.CheckBox_Man:onEvent(stateButtonCallBack)
	panel_ui.CheckBox_Woman:onEvent(stateButtonCallBack)

	WindowScene.getInstance():registerGroupEvent({panel_ui.CheckBox_Man, panel_ui.CheckBox_Woman})

	panel_ui.btnClose:onTouch(function (e)
		if e.name == "ended" then
			WindowScene.getInstance():closeDlg(self)
			global_music_ctrl.play_btn_one()
		end
	end)
end

--实名认证成功
function CPersonalCenterMain:realNameRequestSuccess(idCardNo)
	get_player_info().idCardNo = idCardNo
	self.realNamePanel:setVisible(false)
	panel_ui.btnCardNo:setEnabled(false)
	panel_ui.btnCardNo:setBright(false)
end

--绑定手机更新
function CPersonalCenterMain:updatePhoneBindUI()
	self.phoneBandingPanel:updateUi()
end

--重置获取手机验证码计时器
function CPersonalCenterMain:resetTime(t)
	self.phoneBandingPanel:resetTime()
end
