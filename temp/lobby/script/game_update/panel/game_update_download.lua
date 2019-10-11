local ui_create = require "lobby.ui_create.ui_gameUpdate2"


GameUpdateDownload = class("GameUpdateDownload",function ()
	local obj = cc.Layer:create()
	return obj
end)

--[[
	info = {
		game_key,
		need_check_version,
	}
]]
function GameUpdateDownload.create(info)
	local obj = GameUpdateDownload.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function GameUpdateDownload:init(info)
	
	self:init_data(info)
	self:init_ui()
	self:registerEE()
	self:registerTouchEvent()
end

function GameUpdateDownload:init_data(info)
	self.game_key = info.game_key
	self.download_key = "GameUpdateDownload"
	self.is_download = false

	self.is_get_version_file = false
	self.is_enter_game = false
	self.net_err = false

	self.download_file_index = 0
	self.total_download_file = 0
	self.is_need_check_version = true
	self.front_download_size   = 0

	if info.need_check_version ~= nil then
		self.is_need_check_version = info.need_check_version
	end

	if self.is_need_check_version == true then
		GameVersionMgr.reloadGameVersion()
	end
end

function GameUpdateDownload:init_ui()
	self.ui_lst = ui_create.create()
	self:addChild(self.ui_lst.root)

	self.ui_lst.btnClose:onTouch(function (e)
		if e.name == "ended" then
			self:onClose()
			global_music_ctrl.play_btn_one()
		end
	end)

	self.ui_lst.Text_Speed:setString("")
	--self.ui_lst.Text_Speed_0:setString("")
	-- local gii = game_icon_config[self.game_key]
	-- if gii then
	-- 	self.ui_lst.Image_game:loadTexture(gii.big_icon.src)
	-- end
end

function GameUpdateDownload:registerTouchEvent()
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

function GameUpdateDownload:registerEE()
	local function __enter_exit(e)
		if e == "enter" then
			self:onEnter()
		elseif e == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__enter_exit)
end

function GameUpdateDownload:onEnter()
	local item = {
		key = self.download_key,
		err_call 	= function (code,file,key,err_id,fdiscrib) self:onGameDownloadErr(code,file,key,err_id,fdiscrib) end,
		pro_call 	= function (tts,dls,file,key,fdiscrib) self:onGameDownloadProcess(tts,dls,file,key,fdiscrib) end,
		dlcmp_call 	= function (file,key,fdiscrib) self:onGameDownloadDlComplete(file,key,fdiscrib) end,
		ftcmp_call 	= function (file,fmt,key,fdiscrib) self:onDownloadFtComplete(file,fmt,key,fdiscrib) end,
		tkcmp_call 	= function (file,key,fdiscrib) self:onDownloadTkComplete(file,key,fdiscrib) end,
	}
	DownloadManager.registerTaskCall(item)

	if self.is_need_check_version == true then
		local item = GameVersionMgr.get_game_updatefile_item()
		DownloadManager.sumbitTask(item.url,item.name,item.storage,item.type,item.format,self.download_key,item.fdiscrib)
	else
		self.is_get_version_file = true
		self:sumbitTask()
	end
end

function GameUpdateDownload:onExit()
	--WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_lst.btnItem)
	DownloadManager.unregisterTaskCall(self.game_key)
end

function GameUpdateDownload:doModule(pos)
	self:setPosition(pos.x,pos.y)
	WindowScene.getInstance():showDlg(self)
end

function GameUpdateDownload:close()
	WindowScene.getInstance():closeDlg(self)
end

function GameUpdateDownload:setGameKey(key)
	self.game_key = key
end

function GameUpdateDownload:getWinSize()
	return self.ui_lst.imgBg:getContentSize()
end

function GameUpdateDownload:checkVersion()
	if self.is_get_version_file == false then
		self.is_get_version_file = true
		GameVersionMgr.reloadGameVersionUpdate()

		self:sumbitTask()
	end
end

function GameUpdateDownload:sumbitTask()
	-- body
	local update_task = GameVersionMgr.get_download_task(self.game_key)
	self.total_download_file = #update_task
	self.download_file_index = 0

	for i=1,self.total_download_file do
		local item = update_task[i]
		DownloadManager.sumbitTask(item.url,item.name,item.storage,item.type,item.format,self.download_key,item.fdiscrib)
	end

	if self.total_download_file > 0 then
		self.ui_lst.Text_Speed:setString("正在下载：" .. update_task[1].fdiscrib)
		self.ui_lst.LoadingBar_Schedule:setPercent(0)
		self.is_download = true
	end
end

function GameUpdateDownload:updateComplete()
	if self.download_file_index >= self.total_download_file and self.is_enter_game == false then
		self.is_enter_game = true
		GameVersionMgr.update_game_version_info(self.game_key,true)
		--add enter game call function
		local game_id = self.game_key
		self:close()

		WindowScene.getInstance():loadGame(game_id)
	end
end

--[[
	下载逻辑
]]
function GameUpdateDownload:onGameDownloadErr(code,file,key,err_id,fdiscrib)
	self.ui_lst.Text_Speed:setString("错误代码：".. code)
	if err_id ~= 0 or err_id ~= 6 then self.net_err = true end
	if err_id == 6 then self:close() end
end

function GameUpdateDownload:onGameDownloadProcess(tts,dls,file,key,fdiscrib)
	if self.is_get_version_file == false then
		self.ui_lst.Text_Speed:setString("正在检测版本更新...")
	else
		local speed = dls - self.front_download_size
		self.front_download_size = dls
		self.ui_lst.Text_Speed:setString(string.format("正在下载：%s(%.2fMB/%.2fMB)",fdiscrib,dls/(1024*1024),tts/(1024*1024)))
		--self.ui_lst.Text_Speed_0:setString(string.format("%.2f%%",dls/tts*100))
		self.ui_lst.LoadingBar_Schedule:setPercent(dls/tts*100)
	end
end

function GameUpdateDownload:onGameDownloadDlComplete(file,key,fdiscrib)
	self.ui_lst.Text_Speed:setString("正在解压文件...")
end

function GameUpdateDownload:onDownloadFtComplete(file,fmt,key,fdiscrib)
	self.ui_lst.Text_Speed:setString("正在完成...")
end

function GameUpdateDownload:onDownloadTkComplete(file,key,fdiscrib)
	if self.is_get_version_file == true then
		self.download_file_index = self.download_file_index + 1
		self.ui_lst.LoadingBar_Schedule:setPercent(0)
		--self.ui_lst.Text_Speed:setString("下载完成：" .. fdiscrib)
		--self.ui_lst.Text_Speed_0:setString("100%%")
		self.front_download_size = 0
	end

	if self.is_need_check_version == true then self:checkVersion() end
	self:updateComplete()
end

function GameUpdateDownload:onClose()
	if self.is_download == true then
		if self.net_err == true then self:close() end
		DownloadManager.terminateTask(self.download_key)
	else
		self:close()
	end
end

