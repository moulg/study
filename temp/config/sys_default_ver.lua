local default_version = {
	version 				= "1.1.0",
	file_discrib 			= "none",
	update_url 				= "none",
	main_url				= "none",
	main_update_path 		= "none",
	minor_update_path 		= "none",
	amend_update_path 		= "none",
	main_version_update 	= {},
	minor_version_update 	= {},
	amend_version_update 	= {},
}

if get_xue_Version() == 1 then
	if get_platform_code() == 1 then --android
		default_version.update_url = "http://game388n.oss-cn-shanghai.aliyuncs.com/Android/update_sys_version.lua"
		default_version.main_url   = "http://game388n.oss-cn-shanghai.aliyuncs.com/Android/"
	elseif get_platform_code() == 2 then --ios
		default_version.update_url = "http://game388n.oss-cn-shanghai.aliyuncs.com/IOS/update_sys_version.lua"
		default_version.main_url   = "http://game388n.oss-cn-shanghai.aliyuncs.com/IOS/"
	elseif get_platform_code() == 3 then --Window
		default_version.update_url = "http://game388n.oss-cn-shanghai.aliyuncs.com/Window/update_sys_version.lua"
		default_version.main_url   = "http://game388n.oss-cn-shanghai.aliyuncs.com/Window/"
	end
else
	if get_platform_code() == 1 then --android
		default_version.update_url = "http://game388.oss-cn-beijing.aliyuncs.com/Android/update_sys_version.lua"
		default_version.main_url   = "http://game388.oss-cn-beijing.aliyuncs.com/Android/"
	elseif get_platform_code() == 2 then --ios
		default_version.update_url = "http://game388.oss-cn-beijing.aliyuncs.com/IOS/update_sys_version.lua"
		default_version.main_url   = "http://game388.oss-cn-beijing.aliyuncs.com/IOS/"
	elseif get_platform_code() == 3 then --Window
		default_version.update_url = "http://game388.oss-cn-beijing.aliyuncs.com/Window/update_sys_version.lua"
		default_version.main_url   = "http://game388.oss-cn-beijing.aliyuncs.com/Window/"
	end
end

return default_version
