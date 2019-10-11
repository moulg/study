--[[
	版本管理
]]
--默认配置信息
local default_version = require "config.sys_default_ver"

--本地版本信息
local version_storage_path  = "config/"
local version_file 		    = "sys_version.lua"
local version_full_name 	= version_storage_path .. version_file

--服务器版本信息
local download_version_storage_path = "download/"
local update_version_file  			= "update_sys_version.lua"
local update_version_full_name 		= download_version_storage_path .. update_version_file

--[[
	主系统版本管理
]]
local file_type_lst = {["zip"] = 0,["pkg"] = 1,["exe"] = 2,["apk"] = 3,["ipa"] = 4,["other"] = 100,}


local local_sys_version  = {} --本地版本信息
local update_sys_version = {} --服务器版本信息


--版本管理
VersionManager = {}

function VersionManager.init_local_version_data()
	local abs_path = get_root_dir() .. version_full_name
	if cc.FileUtils:getInstance():isFileExist(abs_path) == false then --不存在，第一次启动
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
	else --存在
		local_sys_version    = require(version_full_name)
		local local_ver_num  = VersionManager.getLocalVersionNumber(1)
		local def_ver_num	 = VersionManager.getDeaultVersinoNumber(1)

		if local_ver_num ~= def_ver_num then--与主版本与安装文件版本不一致，统一用安装版本信息，安装时数据可能不会覆盖的问题
			local content = "local versions = " .. table_to_str(default_version) .. "\n"
			content = content .. "\nreturn versions"

			local path = cc.FileUtils:getInstance():getSuitableFOpen(get_root_dir() .. version_full_name)
			io.writefile(path,content,"w+b")
		end

		local_sys_version = {}
		unload_module(version_full_name)
	end

	local_sys_version = require(version_full_name)
end

function VersionManager.get_local_version_data()
	return local_sys_version
end

function VersionManager.update_local_version_data()
	local updir 	= cc.FileUtils:getInstance():getSuitableFOpen(get_root_dir() .. update_version_full_name)
	
	local content 	= io.readfile(updir) or ""
	local save_dir 	= cc.FileUtils:getInstance():getSuitableFOpen(get_root_dir() .. version_full_name)
	io.writefile(save_dir,content,"w+b")
end

function VersionManager.init_update_version_data()
	update_sys_version = require(update_version_full_name)
end

function VersionManager.get_update_version_data()
	return update_sys_version
end

--[[
	return lst = {
		[x] = {
			type,format,url,name,storage,
		},
	}
]]
function VersionManager.get_download_task_lst()
	local tb = {}

	if VersionManager.is_change_version(1) == true then
		local update_len = #update_sys_version.main_version_update

		for i=1,update_len do
			local item 		= {}
			item.type 		= file_type_lst[update_sys_version.main_version_update[i].local_file_ext]
			item.format 	= update_sys_version.main_version_update[i].format_str
			item.url 		= update_sys_version.main_url .. update_sys_version.main_update_path .. update_sys_version.main_version_update[i].download_url
			item.name  		= update_sys_version.main_version_update[i].local_file_name
			item.storage 	= update_sys_version.main_version_update[i].storage_path
			item.fdiscrib	= update_sys_version.main_version_update[i].file_discrib

			table.insert(tb,item)
		end
	else
		if VersionManager.is_change_version(2) == true then
			local update_len = #update_sys_version.minor_version_update

			for i=1,update_len do
				local item 		= {}
				item.type 		= file_type_lst[update_sys_version.minor_version_update[i].local_file_ext]
				item.format 	= update_sys_version.minor_version_update[i].format_str
				item.url 		= update_sys_version.main_url .. update_sys_version.minor_update_path .. update_sys_version.minor_version_update[i].download_url
				item.name   	= update_sys_version.minor_version_update[i].local_file_name
				item.storage 	= update_sys_version.minor_version_update[i].storage_path
				item.fdiscrib	= update_sys_version.minor_version_update[i].file_discrib

				table.insert(tb,item)
			end
		end

		if VersionManager.getServerVersionNumber(3) ~= 0 and VersionManager.compareVersion(3) ~= 0 then
			local update_len = #update_sys_version.amend_version_update

			for i=1,update_len do
				local item 		= {}
				item.type 		= file_type_lst[update_sys_version.amend_version_update[i].local_file_ext]
				item.format 	= update_sys_version.amend_version_update[i].format_str
				item.url 		= update_sys_version.main_url .. update_sys_version.amend_update_path .. update_sys_version.amend_version_update[i].download_url
				item.name   	= update_sys_version.amend_version_update[i].local_file_name
				item.storage 	= update_sys_version.amend_version_update[i].storage_path
				item.fdiscrib	= update_sys_version.amend_version_update[i].file_discrib

				local bexit = false
				local index = -1
				for k,v in pairs(tb) do
					if v.name == item.name then
						bexit = true
						index = k
						break
					end
				end

				if bexit == false then
					table.insert(tb,item)
				elseif bexit == true and index ~= -1 then
					tb[index] = item
				end
			end
		end
	end

	return tb
end

function VersionManager.is_change_version(index)
	local local_ver  = get_version_info(local_sys_version.version)
	local update_ver = get_version_info(update_sys_version.version)
	if math.floor(tonumber(local_ver[index])) < math.floor(tonumber(update_ver[index])) then
		return true
	end

	return false
end

function VersionManager.getServerVersionNumber(index)
	local update_ver = get_version_info(update_sys_version.version)
	local number = math.floor(tonumber(update_ver[index]))

	return number
end

function VersionManager.getLocalVersionNumber(index)
	local local_ver = get_version_info(local_sys_version.version)
	local number = math.floor(tonumber(local_ver[index]))

	return number
end

function VersionManager.getDeaultVersinoNumber(index)
	local def_ver = get_version_info(default_version.version)
	local number = math.floor(tonumber(def_ver[index]))

	return number
end

function VersionManager.compareVersion(index)
	local local_number = VersionManager.getLocalVersionNumber(index)
	local servr_number = VersionManager.getServerVersionNumber(index)

	if local_number > servr_number then
		return -1
	elseif local_number < servr_number then
		return 1
	end

	return 0
end

function VersionManager.is_main_version_change()
	return VersionManager.is_change_version(1)
end

function VersionManager.get_updatefile_task_item()
	local item 		= {}
	item.type 		= file_type_lst["other"]
	item.format 	= ""
	item.url 		= local_sys_version.update_url
	item.name 		= update_version_file
	item.storage 	= download_version_storage_path
	item.fdiscrib 	= local_sys_version.file_discrib

	return item
end