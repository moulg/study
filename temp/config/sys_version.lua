local versions = 
{
	["version"] = "1.1.0",
	["file_discrib"] = "更新列表",
	["main_url"] = "http://game388.oss-cn-beijing.aliyuncs.com/IOS/",	
	["update_url"] = "http://game388.oss-cn-beijing.aliyuncs.com/IOS/update_sys_version.lua",
	["main_update_path"] = "apk/v1",
	["amend_update_path"] = "Lobby/amend/v0",
	["minor_update_path"] = "Lobby/minor/v5",

	["main_version_update"] = {
		[1] = {
			["storage_path"] = "install/",
			["file_discrib"] = "游戏更新程序",
			["download_url"] = "/kg_game.apk",
			["local_file_name"] = "kg_game.apk",
			["local_file_ext"] = "apk",
			["format_str"] = "apk|shd",
		},
	},

	["minor_version_update"] = {
		[1] = {
			["storage_path"] = "",
			["file_discrib"] = "游戏平台文件",
			["local_file_name"] = "kernel.pkg",
			["download_url"] = "/kernel.pkg",
			["local_file_ext"] = "pkg",
			["format_str"] = "ucp",
		},
		[2] = {
			["storage_path"] = "",
			["file_discrib"] = "游戏数据资源包",
			["local_file_name"] = "data.pkg",
			["download_url"] = "/data.pkg",
			["local_file_ext"] = "pkg",
			["format_str"] = "ucp",
		},
		[3] = {
			["storage_path"] = "",
			["file_discrib"] = "公共资源包",
			["local_file_name"] = "common.pkg",
			["download_url"] = "/common.pkg",
			["local_file_ext"] = "pkg",
			["format_str"] = "ucp",
		},
		[4] = {
			["storage_path"] = "",
			["file_discrib"] = "大厅资源包",
			["local_file_name"] = "globby.pkg",
			["download_url"] = "/globby.pkg",
			["local_file_ext"] = "pkg",
			["format_str"] = "ucp",
		},
	},
	["amend_version_update"] = {
	},
}

return versions