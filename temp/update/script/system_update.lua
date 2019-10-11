--[[
	系统下载更新
]]

local spine_update_cfg = {
	[1] = {atlasPath = "update/resource/act1/jiaose03.atlas", jsonPath="update/resource/act1/jiaose03.json",actName1 = "jiaose",scale = 0.8},
}

local sys_update_create = require "update.script.ui_create.scene_update"

local platform_mark = 1 --平台标识: 1->android 2->ios




SystemUpdate = class("SystemUpdate",function ()
	local obj = cc.Layer:create()
	return obj
end)



function __game_main()
	DownloadManager.init()

	if is_inner_ver() == true then
		enterGame()
		--_do_test_function()
	else
		init_sys_update()
	end
end

function enterGame()
	loading()
	g_init_game_scene("Login")
end

function loading()
	if is_inner_ver() == false then
		CGamePackge:getInstance():LoadPackge("kernel.pkg",".*")--更新模块
		CGamePackge:getInstance():LoadPackge("data.pkg",".*")--数据配置模块
		CGamePackge:getInstance():LoadPackge("common.pkg",".*")--公共资源
		CGamePackge:getInstance():LoadPackge("globby.pkg",".*")--游戏大厅模块s
	end

	require "platform.__main_init"
	require "platform.test"
end


function init_sys_update()
	local scene = cc.Scene:create()
	scene:addChild(SystemUpdate.create())
	cc.Director:getInstance():replaceScene(scene)
end


function SystemUpdate.create()
	local obj = SystemUpdate.new()
	if obj then
		obj:init()
	end

	return obj
end

function SystemUpdate:init()
	local way = cc.ResolutionPolicy.EXACT_FIT
	local des_size = {width = CC_DESIGN_RESOLUTION.width,height = CC_DESIGN_RESOLUTION.height,}
	local srceen_size = cc.Director:getInstance():getOpenGLView():getFrameSize()

	local des_swh = des_size.width/des_size.height
	local scr_swh = srceen_size.width/srceen_size.height

	if math.abs(des_swh - scr_swh) > 0.22 then
		way = cc.ResolutionPolicy.SHOW_ALL
		print("des cut way = " .. way)
	end
	cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(des_size.width,des_size.height,way)

	self:init_data()
	self:init_ui()
	self:registerEnterExit()
end

function SystemUpdate:init_data()
	--任务下载key
	self.download_key = "SystemUpdate"
	self.is_get_server_version_file = false
	self.update_list = {}
	self.is_main_version_change = false

	self.total_file_len 		= 0
	self.cur_download_file_len 	= 1

	self.download_speed = 0
	self.front_download_size = 0
	self.is_enter_game = false

	VersionManager.init_local_version_data()
end

function SystemUpdate:init_ui()
	self.ui_lst = sys_update_create.create()
	self:addChild(self.ui_lst.root)

	self.ui_lst.LoadingBar_update:setPercent(0)
	self.ui_lst.textLoading:setString("正在检测版本更新...")

	--注册关闭窗口事件
	local targetPlatform = cc.Application:getInstance():getTargetPlatform()

	if targetPlatform == cc.PLATFORM_OS_ANDROID or targetPlatform == cc.PLATFORM_OS_IPHONE then
	
		self.ui_lst.btnExit:setVisible(false)
		self.ui_lst.btnSmall:setVisible(false)
	end
		
		--注册最小化事件
	self.ui_lst.btnSmall:onTouch(function (e) 
		WindowModule.show_window(enum_win_show_mod.mod_mini)
	end)
	self.ui_lst.btnExit:onTouch(function (e)
		cc.Director:getInstance():endToLua()
		
		local targetPlatform = cc.Application:getInstance():getTargetPlatform()
		if cc.PLATFORM_OS_IPHONE == targetPlatform then
			os.exit()
		end
	end)


	-- self.act = sp.SkeletonAnimation:create(spine_update_cfg[1].jsonPath,spine_update_cfg[1].atlasPath,spine_update_cfg[1].scale)
	-- self.act:setPosition(600.0000,180.0000)
	-- self.ui_lst.nodeCard:addChild(self.act)
	
	local sprite = cc.Sprite:create("update/resource/js.png")
	sprite:setPosition(530.0000,465.0000)
	self.ui_lst.nodeCard:addChild(sprite)
	
end

function SystemUpdate:registerEnterExit()
	local function __enter_exit(e)
		if e == "enter" then
			self:onEnter()
		elseif e == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__enter_exit)
end

function SystemUpdate:onEnter()

	local item = {
		key = self.download_key,
		err_call 	= function (code,file,key,fdiscrib) self:onSysUpdateErr(code,file,key,fdiscrib) end,
		pro_call 	= function (tts,dls,file,key,fdiscrib) self:onSysUpdateProcess(tts,dls,file,key,fdiscrib) end,
		dlcmp_call 	= function (file,key,fdiscrib) self:onSysUpdateDlComplete(file,key,fdiscrib) end,
		ftcmp_call 	= function (file,fmt,key,fdiscrib) self:onSysUpdateFtComplete(file,fmt,key,fdiscrib) end,
		tkcmp_call 	= function (file,key,fdiscrib) self:onSysUpdateTkComplete(file,key,fdiscrib) end,
	}
	DownloadManager.registerTaskCall(item)

	local item = VersionManager.get_updatefile_task_item()
	DownloadManager.sumbitTask(item.url,item.name,item.storage,item.type,item.format,self.download_key,item.fdiscrib)

	 if self.act then
	 	self.act:setAnimation(0,spine_update_cfg[1].actName1,true)
	 end
end

function SystemUpdate:onExit()

end

--更新错误处理回调
function SystemUpdate:onSysUpdateErr(code,file,key,fdiscrib)
	----printf("err = %s,file = %s,key = %s",code,file,key)
	--self.ui_lst.textLoading:setString(code)
	--DownloadManager.terminateTask(self.download_key)
	DownloadManager.terminateAll()

	local info = {
		mod = 1 ,
		ok_call  = function () 
			cc.Director:getInstance():endToLua()

			local targetPlatform = cc.Application:getInstance():getTargetPlatform()
			if cc.PLATFORM_OS_IPHONE == targetPlatform then
				os.exit()
			end
		end,
		hit_text = code,
	}
	local obj = ShowDlClient.create(info)
	self:addChild(obj)
	obj:setLocalZOrder(100)
end

--更新进度回调
function SystemUpdate:onSysUpdateProcess(total_size,download_size,file,key,fdiscrib)
	----printf("tts = %d,dls = %d,file = %s,key = %s",total_size,download_size,file,key)
	if self.is_get_server_version_file == false then
		self.ui_lst.textLoading:setString("正在检测版本更新...")
	else
		self.download_speed 	 = (download_size - self.front_download_size)/1024
		self.front_download_size = download_size
		--self.ui_lst.textLoading:setString(string.format("正在下载：%s(%.2fMB/%.2fMB)",fdiscrib,download_size/(1024*1024),total_size/(1024*1024)))
		self.ui_lst.textLoading:setString("正在加载资源，请稍后。。。。。")
		self.ui_lst.LoadingBar_update:setPercent(download_size/total_size*100)
	end
end

--文件下载完成回调
function SystemUpdate:onSysUpdateDlComplete(file,key,fdiscrib)
	----printf("file = %s,key = %s",file,key)
	self.ui_lst.textLoading:setString("正在解压文件......")
end

--文件命令执行完成回调
function SystemUpdate:onSysUpdateFtComplete(file,format,key,fdiscrib)
	----printf("file = %s,format = %s,key = %s",file,format,key)
	self.ui_lst.textLoading:setString("正在完成......")
end

--任务完成回调
function SystemUpdate:onSysUpdateTkComplete(file,key,fdiscrib)
	----printf("file = %s,key = %s",file,key)
	if self.is_get_server_version_file == true then
		self.cur_download_file_len = self.cur_download_file_len + 1
		--self.ui_lst.LoadingBarNow:setPercent(0)
		--self.ui_lst.LoadingBarAll:setPercent(self.cur_download_file_len/self.total_file_len*100)
		--self.ui_lst.loadingNowTest:setString("")
		--self.ui_lst.loadingAllTest:setString(string.format("下载进度：%d个/%d个",self.cur_download_file_len,self.total_file_len))

		self.download_speed 	 = 0
		self.front_download_size = 0
		--printf("download file = %d",self.cur_download_file_len)
	end
	self:checkVersionUpdate()
	if self.is_main_version_change == false then
		self:updateComplete()
	end
end

function SystemUpdate:checkVersionUpdate()
	if self.is_get_server_version_file == false then
		VersionManager.init_update_version_data()

		self.is_get_server_version_file = true
		self.is_main_version_change = VersionManager.is_main_version_change()

		if self.is_main_version_change == true then
			self.main_lst = VersionManager.get_download_task_lst()
			if #self.main_lst > 0 then
				local info = {
					ok_call = function () self:onMainVerUpdateCall() end,
				}
				local obj = ShowDlClient.create(info)
				self:addChild(obj)
				obj:setLocalZOrder(100)
			end
			
			return
		end

		self.update_list = VersionManager.get_download_task_lst()
		if #self.update_list > 0 then
			self.total_file_len = #self.update_list
			self.cur_download_file_len = 0

			local info = {
				ok_call  = function () 
					self:getUpdateCall() 
				end,
				hit_text = string.format("客户端有更新（共%d个资源包），是否更新？",#self.update_list),
			}
			local obj = ShowDlClient.create(info)
			self:addChild(obj)
			obj:setLocalZOrder(100)
		end
	end
end

function SystemUpdate:updateComplete()
	if (self.cur_download_file_len >= self.total_file_len) and self.is_enter_game == false then
		if self.is_main_version_change == false then
			VersionManager.update_local_version_data()
		end
		
		self.is_enter_game = true
		enterGame()
	end
end


function SystemUpdate:onCloseClick(e)
	if e.name == "ended" then
		DownloadManager.terminateAll()
		cc.Director:getInstance():endToLua() 

		local targetPlatform = cc.Application:getInstance():getTargetPlatform()
		if cc.PLATFORM_OS_IPHONE == targetPlatform then
			os.exit()
		end
	end
end

function SystemUpdate:getUpdateCall()
	for i=1,self.total_file_len do
		local item = self.update_list[i]
		DownloadManager.sumbitTask(item.url,item.name,item.storage,item.type,item.format,self.download_key,item.fdiscrib)
	end

	if self.total_file_len <= 0 and self.is_enter_game == false then
		self:updateComplete()
	end
end

function SystemUpdate:onMainVerUpdateCall()
	cc.Application:getInstance():openURL(self.main_lst[1].url)
	cc.Director:getInstance():endToLua()

	local targetPlatform = cc.Application:getInstance():getTargetPlatform()
	if cc.PLATFORM_OS_IPHONE == targetPlatform then
		os.exit()
	end
end
