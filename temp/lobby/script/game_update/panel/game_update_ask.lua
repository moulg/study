#remark
local ui_create = require "lobby.ui_create.ui_gameUpdate1"


GameUpdateAsk = class("GameUpdateAsk",function ()
	local obj = cc.Layer:create()
	return obj
end)


function GameUpdateAsk.create()
	local obj = GameUpdateAsk.new()
	if obj then
		obj:init()
	end

	return obj
end

function GameUpdateAsk:init_data()
	self.close_time  = 30
	self.game_key 	 = nil
	self.show_mod 	 = 0
	self.ok_click_call = nil
end

function GameUpdateAsk:init()
	self:init_data()
	self:init_ui()
	self:registerEE()
	self:registerTouchEvent()
	self:registerUpdate()
end

function GameUpdateAsk:init_ui()
	self.ui_lst = ui_create.create()

    --local size = WindowScene.getInstance():getWindowSize()
    local size = WindowModule.get_window_size()
    local dlg_size = self:getWinSize()

    print(size.width, size.height, dlg_size.width, dlg_size.height)

	local pos = {x = dlg_size.width/2,
	   	y = dlg_size.height/2,
    }
    self.ui_lst.root:setPosition(pos)

	self:addChild(self.ui_lst.root)

	self.ui_lst.btnSure:onTouch(function (e)
		if e.name == "ended" then
			self:onOKClick()
			global_music_ctrl.play_btn_one()
		end
	end)

	self.ui_lst.btnNo:onTouch(function (e)
		if e.name ==  "ended" then
			self:onCancel()
			global_music_ctrl.play_btn_one()
		end
	end)

	self.ui_lst.btnClose:onTouch(function (e)
		if e.name == "ended" then
			self:onCancel()
			global_music_ctrl.play_btn_one()
		end
	end)

	--self.ui_lst.rechargeTime:setString(tostring(self.close_time))
end

function GameUpdateAsk:registerTouchEvent()
	local function _on_touch_began(touch, event) return true end
    local function _on_touch_move(touch, event) return true end
    local function _on_touch_end(touch, event) return true end
    
    local listener = cc.EventListenerTouchOneByOne:create()

    listener:setSwallowTouches(true)
    listener:registerScriptHandler(_on_touch_began,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(_on_touch_move,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(_on_touch_end,cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener,self)
end

function GameUpdateAsk:registerEE()
	local function __enter_exit(e)
		if e == "enter" then
			self:onEnter()
		elseif e == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__enter_exit)
end

function GameUpdateAsk:onEnter()
	
end

function GameUpdateAsk:onExit()
	--WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_lst.btnItem)
	self:unregisterUpdate()
end

function GameUpdateAsk:registerUpdate()
	-- local scheduler = cc.Director:getInstance():getScheduler()
	-- self.schedule_handler = scheduler:scheduleScriptFunc(function (dt) return self:update(dt) end,0.0,false)
end

function GameUpdateAsk:unregisterUpdate()
	-- body
	-- local scheduler = cc.Director:getInstance():getScheduler()
	-- scheduler:unscheduleScriptEntry(self.schedule_handler)
end

function GameUpdateAsk:update(dt)

	-- if self.close_time <= 0.017 then
	-- 	self:close()
	-- else
	-- 	self.close_time = self.close_time - dt
	-- 	self.ui_lst.rechargeTime:setString(math.floor(self.close_time))
	-- end
end

function GameUpdateAsk:doModule(pos)
	self:setPosition(pos.x,pos.y)
	WindowScene.getInstance():showDlg(self)
end

function GameUpdateAsk:close()
	WindowScene.getInstance():closeDlg(self)
end

function GameUpdateAsk:onOKClick()
	if self.show_mod == 0 or self.show_mod == 1 then
		self:showDownloadDlg()
	elseif self.show_mod == 2 then
		self:showReselect()
	end
end

function GameUpdateAsk:showReselect()
	if self.ok_click_call then
		self.ok_click_call()
	end

	self:close()
end

function GameUpdateAsk:showDownloadDlg()
	--local size = WindowScene.getInstance():getWindowSize()
	local size = cc.Director:getInstance():getVisibleSize()

	local info = {
		game_key = self.game_key,
		need_check_version = false,
	}

	if self.show_mod == 0 then
		info.need_check_version = true
	end

	 local dlg  = GameUpdateDownload.create(info)
	 local dlg_size = dlg:getWinSize()

	  local pos = { x = size.width/2,
	  	y = size.height/2,
	  }

	 dlg:doModule(pos)

	self:close()
end

function GameUpdateAsk:onCancel()
	self:close()
end

function GameUpdateAsk:getWinSize()
	return self.ui_lst.imgBg:getContentSize()
end

function GameUpdateAsk:setHitMessage(str_msg)
	if str_msg then
		self.ui_lst.TextSure:setString(str_msg)
	end
end

function GameUpdateAsk:setGameKey(key)
	self.game_key = key
end

--code == 0 have no install,1 have update,2 check update err
function GameUpdateAsk:setShowModule(code)
	self.show_mod = code
end

function GameUpdateAsk:setOkClickCall(call)
	self.ok_click_call = call
end
