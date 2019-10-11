#remark
GameBtnItem = class("GameBtnItem",function ()
	local  obj = ccui.Button:create()
	return obj
end)


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。


function GameBtnItem.create(gameid)
	local obj = GameBtnItem.new()
	if obj ~= nil then
		obj:init_ui()
		obj:init_data(gameid)
		obj:registerEE()
	end

	return obj
end

function GameBtnItem:init_data(gameid)
	self.game_cfg_item  = game_config[gameid]
	self.game_icon_info = game_icon_config[gameid]

	self:loadTextures(self.game_icon_info.big_icon.src,"")
	--self:setContentSize(self.game_icon_info.big_icon.w,self.game_icon_info.big_icon.h)
end

function GameBtnItem:init_ui()
	self:onTouch(function ( e )
		self:onItemClick(e)
	end)
end

function GameBtnItem:registerEE()
	local function __on_enter_exit(event)
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__on_enter_exit)
end

function GameBtnItem:onEnter()
	
end

function GameBtnItem:onExit()
	--self:removeFrameCache()	
end

function GameBtnItem:onItemClick(e)
	if e.name == "ended" then
		global_music_ctrl.play_btn_one()
		if self.game_cfg_item.play_state == 0 then
			TipsManager:showOneButtonTipsPanel(902,{},true)
			return
		end

		if is_inner_ver() == true then
			WindowScene.getInstance():loadGame(self.game_cfg_item.id)
			return
		end
		
		if self.game_cfg_item then
			if self:isGameDownload() == false then --check game is exist
				self:showHitDlg(" 没有安装，是否安装？",true,0)			
			else --check game update version
				local is_update = GameUpdateStateRec.isUpdate(self.game_cfg_item.id)
				if is_update == false then
					print("this game need to check update on server!")
					self:checkUpdate()
				else
					print("the game is update in this playing gamestate !")
					WindowScene.getInstance():loadGame(self.game_cfg_item.id)
				end
			end
		end
	end
end

function GameBtnItem:showHitDlg(msg,blink,code)
	--local win_size = WindowScene.getInstance():getWindowSize()
	local win_size = cc.Director:getInstance():getVisibleSize()
	local dlg  = GameUpdateAsk.create()
	if msg == nil then msg = "" end
	local str = msg
	if blink == true then str = self.game_cfg_item.name .. str end

	dlg:setHitMessage(str)
	dlg:setGameKey(self.game_cfg_item.id)
	dlg:setShowModule(code)

	local function __on_ok_click_call() self:checkUpdate() end
	dlg:setOkClickCall(__on_ok_click_call)

	local dlg_size = dlg:getWinSize()
	local pos = {x = win_size.width/2 - dlg_size.width/2,
		y = win_size.height/2 - dlg_size.height/2,
	}

	dlg:doModule(pos)
end

function GameBtnItem:checkUpdate()
	local function __on_update_game_call(code) self:isUpdateCall(code) end
	GameVersionMgr.check_game_version_update(self.game_cfg_item.id,__on_update_game_call)
end

function GameBtnItem:isGameDownload(game_id)
	if self.game_cfg_item then
		for k,v in pairs(self.game_cfg_item.pkg_lst) do
			local path_name = v.pkg_file
			if cc.FileUtils:getInstance():isFileExist(path_name) == false then
				return false
			end
		end

		return true
	end

	return false
end

function GameBtnItem:isUpdateCall(code)
	if code == -1 then
		self:showHitDlg("检查更新失败，是否重试？",false,2)
	elseif code == 0 then
		WindowScene.getInstance():loadGame(self.game_cfg_item.id)
	elseif code == 1 then
		self:showHitDlg(" 有更新，是否更新？",true,1)
	end
end

--------------- 动画


