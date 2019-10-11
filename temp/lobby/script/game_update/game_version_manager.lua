#remark
--游戏默认更新列表
local default_version = require "config.game_default_ver"

--本地版本信息
local version_storage_path = "config/"
local version_file 		   = "game_version.lua"
local version_full_name    = version_storage_path .. version_file

--服务器版本信息
local download_version_storage_path = "download/"
local update_version_file  			= "game_version_update.lua"
local update_version_full_name 		= download_version_storage_path .. update_version_file



local file_type_lst = {["zip"] = 0,["pkg"] = 1,["exe"] = 2,["apk"] = 3,["ipa"] = 4,["other"] = 100,}


local local_game_version_data  = {} --local version data
local server_game_version_data = {} --server version data


--[[
	game version manager
]]
GameVersionMgr = {}

--服务器信息同步到本地信息，可以选择是否写入本地文件
function GameVersionMgr.update_game_version_info(game_index,bflush)
	if local_game_version_data.data and server_game_version_data.data then
		if server_game_version_data.data[game_index] ~= nil then

			local_game_version_data.data[game_index] 	= clone(server_game_version_data.data[game_index])
			local_game_version_data.update_file_url 	= server_game_version_data.update_file_url
			local_game_version_data.main_url 			= server_game_version_data.main_url
			
			if bflush == true then
				local content = "local versions = " .. table_to_str(local_game_version_data) .. "\n"
				content = content .. "\nreturn versions"
				local path = cc.FileUtils:getInstance():getSuitableFOpen(get_root_dir() .. version_full_name)
				io.writefile(path,content,"w+b")
			end
		end
	end
end
--从本地配置文件载入到本地配置信息，如果本地配置文件空，从安装文件拷贝先
function GameVersionMgr.reloadGameVersion()
	print("GameVersionMgr.reloadGameVersion()\n")

	local abs_path = get_root_dir() .. version_full_name
	if cc.FileUtils:getInstance():isFileExist(abs_path) == false then
		local new_file = CFileTools()
		if new_file:open(version_full_name,true) == 1 then
			print("create file ok")
		end
		new_file:close()
		new_file = nil

		local content = "local versions = " .. table_to_str(default_version) .. "\n"
		content = content .. "\nreturn versions"

		local path = cc.FileUtils:getInstance():getSuitableFOpen(get_root_dir() .. version_full_name)
		io.writefile(path,content,"w+b")
	end
	
	package.loaded[version_full_name] = nil
    local_game_version_data = require(version_full_name)

    print("local_game_version_data:\n")
    print(local_game_version_data)
end

--从服务器配置文件重新读入服务器配置信息
function GameVersionMgr.reloadGameVersionUpdate()
	print("GameVersionMgr.reloadGameVersionUpdate():")
	print("update_version_full_name = "..update_version_full_name)

	package.loaded[update_version_full_name] = nil
	server_game_version_data = nil
    server_game_version_data = require(update_version_full_name)
end

--获取游戏更新列表
function GameVersionMgr.get_download_task(game_index)

	local tb = {}
	--if GameVersionMgr.is_version_change(game_index) == true then
		local update_item 	= server_game_version_data.data[game_index]
		local main_url 		= server_game_version_data.main_url
		local ver_url 		= update_item.ver_path

		if update_item ~= nil then
			for k,v in pairs(update_item.dl_lst) do
				local item 		= {}
				item.type 		= file_type_lst[v.ext]
				item.format 	= v.fmt
				item.url 		= main_url .. ver_url .. v.url
				item.name   	= v.name
				item.storage 	= v.storage_path
				item.fdiscrib	= v.file_discrib

				table.insert(tb,item)
			end
		end
	--end
	

	return tb
end

--返回用于请求服务器游戏版本配置文件的参数item
function GameVersionMgr.get_game_updatefile_item()
	local item 	= {}
	item.type 		= file_type_lst["other"]
	item.format 	= ""
	item.url 		= local_game_version_data.update_file_url
	item.name 		= update_version_file
	item.storage  	= download_version_storage_path
	item.fdiscrib 	= local_game_version_data.file_discrib

	print("item.url="..item.url)
	print("item.name="..item.name)
	print("item.storage="..item.storage)
	print("item.type="..item.type)
	print("itme.format="..item.format)
	print("itme.fdiscrib="..item.fdiscrib)

	return item 
end

--本地版本相对于服务器是否有更新
function GameVersionMgr.is_version_change(game_index)
	local lver_data = local_game_version_data.data[game_index]
	local sver_data = server_game_version_data.data[game_index]

	if lver_data == nil then
		return true
	end

	local lver_ls = get_version_info(lver_data.version)
	local sver_ls = get_version_info(sver_data.version)

	for i=1,#lver_ls do
		if tonumber(lver_ls[i]) < tonumber(sver_ls[i]) then
			return true
		end
	end

	return false
end


--[[
	检查版本更新
]]

local check_result_call = nil
local cur_game_index 		= -1

local function __on_check_err(code,file,key)
	if check_result_call then check_result_call(-1) end

	check_result_call = nil
	cur_game_index = -1

	DownloadManager.unregisterTaskCall("CheckGameVersion")
--重新开始版本检测

--退出app重新进入
	local info = {
		ok_call  = function () self:getUpdateCall() end,
		hit_text = string.format("客户端有更新（共%d个资源包），是否更新？",#self.update_list),
	}
	local obj = ShowDlClient.create(info)
	self:addChild(obj)
	obj:setLocalZOrder(100)
end

local function __on_complete(file,key)

	print("__on_complete: ".." file: "..file..", key:"..key)

	-- 调试打印
	GameVersionMgr.print_local_game_version_file();
	GameVersionMgr.print_update_game_version_file();


	--读取服务器配置文件
	GameVersionMgr.reloadGameVersionUpdate()

	if cur_game_index ~= -1 and check_result_call ~= nil then
		local bupdate = GameVersionMgr.is_version_change(cur_game_index)
		local change_code = 0
		if bupdate == true then change_code = 1 end

		check_result_call(change_code)

		--GameVersionMgr.update_game_version_info(cur_game_index,true)
	end


	check_result_call = nil
	cur_game_index = -1

	DownloadManager.unregisterTaskCall("CheckGameVersion")
end

--[[
	gi : game index
	result_call = function (code); code = -1 : check version err, 0 : have no update version, 1 -> have update version
]]
function GameVersionMgr.check_game_version_update(gi,result_call)
	check_result_call 	= result_call
	cur_game_index 		= gi

	local item = {
		key 		= "CheckGameVersion",
		err_call 	= __on_check_err,
		tkcmp_call 	= __on_complete,
	}
	DownloadManager.registerTaskCall(item)

	GameVersionMgr.reloadGameVersion()

	local item = GameVersionMgr.get_game_updatefile_item()

	DownloadManager.sumbitTask(item.url,item.name,item.storage,item.type,item.format,"CheckGameVersion",item.fdiscrib)
end


-- 打印服务器下载的版本配置文件
function GameVersionMgr.print_update_game_version_file()

	local path = cc.FileUtils:getInstance():getSuitableFOpen(get_root_dir() .. update_version_full_name)
	local content 	= io.readfile(path) or ""

	print("server version file:"..path)
	print("content:")
	print(content)

end

-- 打印本地保存的版本配置文件
function GameVersionMgr.print_local_game_version_file()

	local path = cc.FileUtils:getInstance():getSuitableFOpen(get_root_dir() .. version_full_name)
	local content 	= io.readfile(path) or ""

	print("local version file:"..path)
	print("content:")
	print(content)

end