
local default_version = {
	file_discrib 	= "none",
	update_file_url = "none",
	main_url 		= "none",
	data 			= {},
}


if get_xue_Version() == 1 then
	if get_platform_code() == 1 then --android
		default_version.update_file_url = "http://game388n.oss-cn-shanghai.aliyuncs.com/Android/game_version_update.lua"
		default_version.main_url 		= "http://game388n.oss-cn-shanghai.aliyuncs.com/Android/Game/"
	elseif get_platform_code() == 2 then --ios
		default_version.update_file_url = "http://game388n.oss-cn-shanghai.aliyuncs.com/IOS/game_version_update.lua"
		default_version.main_url 		= "http://game388n.oss-cn-shanghai.aliyuncs.com/IOS/Game/"
	elseif get_platform_code() == 3 then --Window
		default_version.update_file_url = "http://game388n.oss-cn-shanghai.aliyuncs.com/Window/game_version_update.lua"
		default_version.main_url 		= "http://game388n.oss-cn-shanghai.aliyuncs.com/Window/Game/"
	end
else
	if get_platform_code() == 1 then --android
		default_version.update_file_url = "http://game388.oss-cn-beijing.aliyuncs.com/Android/game_version_update.lua"
		default_version.main_url 		= "http://game388.oss-cn-beijing.aliyuncs.com/Android/Game/"
	elseif get_platform_code() == 2 then --ios
		default_version.update_file_url = "http://game388.oss-cn-beijing.aliyuncs.com/IOS/game_version_update.lua"
		default_version.main_url 		= "http://game388.oss-cn-beijing.aliyuncs.com/IOS/Game/"
	elseif get_platform_code() == 3 then --Window
		default_version.update_file_url = "http://game388.oss-cn-beijing.aliyuncs.com/Window/game_version_update.lua"
		default_version.main_url 		= "http://game388.oss-cn-beijing.aliyuncs.com/Window/Game/"
	end
end

return default_version
