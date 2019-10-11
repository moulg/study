#remark
CHallSet = class("CHallSet", function ()
	local ret = ccui.ImageView:create()
	ret:loadTexture("lobby/resource/general/heidi.png")
	ret:setScale9Enabled(true)
	return ret
end)
-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。


function CHallSet.create()
	-- body
	local layer = CHallSet.new()
	if layer ~= nil then
		layer:regEnterExit()
		layer:init_ui()
		return layer
	end
end

function CHallSet:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(_onEnterOrExit);
end

function CHallSet:onEnter()
	--防止穿透
	self:setTouchEnabled(true)
end

function CHallSet:onExit()

end

function CHallSet:init_ui()
	open_user_config()

	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))

	self.panel_ui = require("lobby/ui_create/ui_setup").create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(size.width/2,size.height/2)

	self:registerHandler()
	self:setData("volume")
end

function CHallSet:setData(key)
	self.set_key = key
    local userConfig = get_user_config()
	self.gameSetData = userConfig[key]
	if self.gameSetData == nil then
		self.gameSetData = {}
		self.gameSetData.musicCheck = 1
		self.gameSetData.soundCheck = 1
		self.gameSetData.musicVol = 100
		self.gameSetData.soundVol = 100
	end

	--声音设置
	if self.gameSetData.musicCheck == 1 then
		self.panel_ui.CheckBox_musicOpen:setSelected(true)
		self.gameSetData.musicVol = 100
	else
		self.panel_ui.CheckBox_musicOpen:setSelected(false)
		self.gameSetData.musicVol = 0
	end

	--音效设置
	if self.gameSetData.soundCheck == 1 then
		self.panel_ui.CheckBox_voiceOpen:setSelected(true)
		self.gameSetData.soundVol = 100
	else
		self.panel_ui.CheckBox_voiceOpen:setSelected(false)
		self.gameSetData.soundVol = 0
	end
end

function CHallSet:registerHandler()
	self.panel_ui.btnClose:onTouch(function (e)
		if e.name == "ended" then
			WindowScene.getInstance():closeDlg(self)
			global_music_ctrl.play_btn_one()
		end
	end)

	--音乐
	self.panel_ui.CheckBox_musicOpen:onEvent(function (e)
		if self.panel_ui.CheckBox_musicOpen:isSelected() then
			self.gameSetData.musicCheck = 1
		else
			self.gameSetData.musicCheck = 0
		end

		self:saveSetting()
		global_music_ctrl.play_btn_one()
	end)

	--音效
	self.panel_ui.CheckBox_voiceOpen:onEvent(function (e)

		if self.panel_ui.CheckBox_voiceOpen:isSelected() then
			self.gameSetData.soundCheck = 1
		else
			self.gameSetData.soundCheck = 0
		end

		self:saveSetting()
		global_music_ctrl.play_btn_one()
	end)	
end

function CHallSet:saveSetting()
	if self.gameSetData then
		if self.gameSetData.musicCheck == 1 then
			self.gameSetData.musicVol = 100
		else
			self.gameSetData.musicVol = 0
		end
		if self.gameSetData.soundCheck == 1 then
			self.gameSetData.soundVol = 100
		else
			self.gameSetData.soundVol = 0
		end
	else
		self.panel_ui.CheckBoxSound:setSelected(true)
		self.panel_ui.CheckBoxMusic:setSelected(true)

		self.gameSetData = {}
		self.gameSetData.musicCheck = 1
		self.gameSetData.soundCheck = 1
		self.gameSetData.musicVol = 100
		self.gameSetData.soundVol = 100
	end

	audio_manager:setMusicVolume(self.gameSetData.musicVol)
	audio_manager:setSoundVolmue(self.gameSetData.soundVol)

	get_user_config()[self.set_key] = self.gameSetData
	save_uer_config()
end

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
