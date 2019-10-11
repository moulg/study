#remark
local panel_ui

CRealNameRequest = class("CRealNameRequest", function ()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
	return ret	
end)


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。


function CRealNameRequest.create()
	local layer = CRealNameRequest.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end

function CRealNameRequest:regEnterExit()
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

function CRealNameRequest:onEnter()
    self:setTouchEnabled(true)
end

function CRealNameRequest:onExit()

end

function CRealNameRequest:init_ui()
	panel_ui = require("lobby.ui_create.ui_realName").create()
	self:addChild(panel_ui.root)
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	panel_ui.root:setPosition(size.width/2, size.height/2)

	self:registerHandler()

end



function CRealNameRequest:registerHandler()
	local function closeHandler(e)
		if e.name == "ended" then
			self:setVisible(false)
			global_music_ctrl.play_btn_one()
		end
	end
	panel_ui.btnClose:onTouch(closeHandler)

	panel_ui.btnSure:onTouch(function (e)
		if e.name == "ended" then
			global_music_ctrl.play_btn_one()
			local msg = {
				name = panel_ui.inputTName:getString(),
				idNo = panel_ui.inputIDCard:getString()
			}
			send_personalcenter_ReqRealNameAuthenticate(msg)
		end
	end)
end