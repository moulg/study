#remark
-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。


CSystemMessage = class("CSystemMessage", function ()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
    return ret
end)

CSystemMessage.Channel_ID_ALL = 0
CSystemMessage.Channel_ID_Bugle = 2
CSystemMessage.Channel_ID_System = 3

local MAX_NUM = 30
local panel_ui
local _channelMsgList = {}

function CSystemMessage.create()
	local layer = CSystemMessage.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end

function CSystemMessage:regEnterExit()
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

function CSystemMessage:onEnter()
	self:setTouchEnabled(true)
end

function CSystemMessage:onExit()
	self._messagePanel:clearAll()
end

function CSystemMessage:init_ui()
	panel_ui = require("lobby.ui_create.ui_system_msg").create()
	self:addChild(panel_ui.root)
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	panel_ui.root:setPosition(size.width/2, size.height/2)

	local config = scroll_panel_config["系统消息"]
	self._messagePanel = ChatUIExt.create()
	self._messagePanel:initChatUI( config.size, talk_font_config.hall_config, sliderRes_config["系统消息"])
	self._messagePanel:setPosition(config.pos)
	panel_ui.imgBj:addChild(self._messagePanel)

	self._curChannel = CSystemMessage.Channel_ID_ALL
	self:switchChannel( self._curChannel )

	self:registerHandler()
end

function CSystemMessage:registerHandler()
	local function stateButtonCallBack(target, type)
		if target == panel_ui.CheckBox_all then
			self._curChannel = CSystemMessage.Channel_ID_ALL
			self:switchChannel(self._curChannel)
		elseif target == panel_ui.CheckBox_sys then
			self._curChannel = CSystemMessage.Channel_ID_System
			self:switchChannel(self._curChannel)
		elseif target == panel_ui.CheckBox_horm then
			self._curChannel = CSystemMessage.Channel_ID_Bugle
			self:switchChannel(self._curChannel)
		end
	end

	WindowScene.getInstance():registerGroupEvent({panel_ui.CheckBox_all, panel_ui.CheckBox_sys, panel_ui.CheckBox_horm}, stateButtonCallBack)

	self:onTouch(function ( e )
		if e.name == "ended" then
			WindowScene.getInstance():closeDlg(self)
		end
	end)
	panel_ui.imgBj:setTouchEnabled(true)

	panel_ui.btnHorm:onTouch(function ( e )
		if e.name == "ended" then
			local itemInfo = back_pack_manager:getItemInfo( 151 )
			if itemInfo.num > 0 then
				WindowScene.getInstance():showDlgByName("CSendHorm")
			else
				TipsManager:showOneButtonTipsPanel(84, {}, true)
			end
		end
	end)
end


function CSystemMessage:ccTouchBegan(x,y)
	if panel_ui.imgBj:hitTest(cc.p(x, y)) then
		return false
	end

	return true
end

function CSystemMessage:ccTouchMoved(x,y)


end

function CSystemMessage:ccTouchEnded(x,y)

	if panel_ui.imgBj:hitTest(cc.p(x, y)) then
		WindowScene.getInstance():closeDlg(self)
	end
end

--频道切换
function CSystemMessage:switchChannel( channel )
	self._messagePanel:clearAll()
	for i,msgData in ipairs(_channelMsgList) do
		if channel == CSystemMessage.Channel_ID_ALL or msgData.channel == channel then
			self:insertMsg(msgData.channel, msgData.roleName, msgData.chatmsg)
		end
	end
end

--[[

	msg_type :消息类型 1为喇叭 2为聊天框消息
]]
function CSystemMessage.addChatMsg(channel, roleName, chatmsg,msg_type)
	local str = chatmsg
	if msg_type == 1 then
		local obj_cont = json.decode(chatmsg)
		str = obj_cont.text
	end

	table.insert(_channelMsgList, {channel = channel, roleName = roleName, chatmsg = str})

	if #_channelMsgList > MAX_NUM then
		table.remove(_channelMsgList, 1)
	end

	local panel = WindowScene.getInstance():getDlgByName("CSystemMessage")
	if panel then
		panel:insertMsg(channel, roleName, str)
	end
end

function CSystemMessage:insertMsg( channel, roleName, chatmsg )
	local ChannelNameSwitch = 
	{
	    [CSystemMessage.Channel_ID_Bugle] = "【喇叭】"..roleName.."：",
	    [CSystemMessage.Channel_ID_System] = "【系统公告】："
	}

	if self._curChannel == CSystemMessage.Channel_ID_ALL or self._curChannel == channel then
		self._messagePanel:addChatMsg(channel, ChannelNameSwitch[channel], chatmsg)
	end
end