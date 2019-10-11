#remark
--[[
	用户系统设置数据保存
]]
local user_config ={
	--[key] = {musicVol = 100,musicCheck = 1,soundVol = 100,soundCheck = 1,graphic_level = 3,},
}
local user_config_file = "config/user_set_data.cfg"

--[[主键说明
1	 斗地主游戏设置
2	 牛牛游戏设置
3	 水浒传游戏设置
4	 4s店游戏设置
5	 德州扑克游戏设置
]]


function get_user_config()
	return user_config
end

function save_uer_config()
	local str = "{"

	for k,v in pairs(user_config) do
		str = str .."[\"".. k .. "\"] = {"
		for m,n in pairs(v) do
			str = str .. m .. " = " .. n .. ","
		end
		str = str .. "},"
	end

	str = str .. "}"

	local file_obj = CFileTools()
	file_obj:open(user_config_file,true)
	file_obj:writeString(str)
	file_obj:close()
	file_obj = nil
end

function open_user_config()
	local file_obj = CFileTools()
	file_obj:open(user_config_file,false)
	local str = file_obj:readString()
	file_obj:close()
	file_obj = nil

    if str == "" then
        user_config = {}
    else
    	str = "return " .. str
		user_config = loadstring(str)()
    end
end

function reset_music_config()
	open_user_config()
	local set_data = get_user_config()
	if set_data["volume"] then
		print("reset music set " .. set_data["volume"].musicVol .. " " .. set_data["volume"].soundVol )
		AudioEngine.setMusicVolume(set_data["volume"].musicVol/100)
		AudioEngine.setEffectsVolume(set_data["volume"].soundVol/100)
	end
end


--[[
	用户名密码储存
]]

local login_user_info_lst = {
	--[1] = {id = 1,user_name = "cc",user_code = "cc",b_rember_code = false,login_type = 1,},
}
local user_info_file_name = "config/userinfo.des"  --记录用户信息

function getLoginUserInfo()
	return login_user_info_lst
end


-- login_type
-- 0  游客登录
-- 1  账号登录
-- 2  微信登录
-- 3  手机登录
function saveUserNameLst()

	for type=1,3 do
		local id = login_user_info_lst[type].id or 1
		cc.UserDefault:getInstance():setIntegerForKey("id"..type,id)

		local user_name = login_user_info_lst[type].user_name or ""
		cc.UserDefault:getInstance():setStringForKey("user_name"..type,user_name)

		local user_code = login_user_info_lst[type].user_code or ""
		cc.UserDefault:getInstance():setStringForKey("user_code"..type,user_code)

		local b_rember_code = login_user_info_lst[type].b_rember_code or true
		cc.UserDefault:getInstance():setBoolForKey("b_rember_code"..type,b_rember_code)

		local login_type = login_user_info_lst[type].login_type or 1
		cc.UserDefault:getInstance():setIntegerForKey("login_type"..type,login_type)
	end

	cc.UserDefault:getInstance():flush()

	-- local file_obj = CFileTools()

	-- file_obj:open(user_info_file_name,true)

	-- local len = #login_user_info_lst
	-- file_obj:writeInt(len)

	-- for i=1,len do
	-- 	--print("saveuser", login_user_info_lst[i].id, login_user_info_lst[i].user_name, login_user_info_lst[i].user_code, login_user_info_lst[i].login_type)
	-- 	local id = login_user_info_lst[i].id or 1
	-- 	file_obj:writeInt(id)
	-- 	file_obj:writeString(login_user_info_lst[i].user_name)
	-- 	file_obj:writeString(login_user_info_lst[i].user_code)
	-- 	local type = login_user_info_lst[i].login_type or 0
	-- 	file_obj:writeInt(type)
	-- 	local val = 0
	-- 	if login_user_info_lst[i].b_rember_code == true then val = 1 end
	-- 	file_obj:writeInt(val)
	-- end

	-- file_obj:close()
	-- file_obj = nil
end

function readUserNameLst()

	login_user_info_lst = {}

	for type=1,3 do

		local item = {}
		item.id = cc.UserDefault:getInstance():getIntegerForKey("id")
		item.user_name = cc.UserDefault:getInstance():getStringForKey("user_name"..type)
		item.user_code = cc.UserDefault:getInstance():getStringForKey("user_code"..type)
		item.b_rember_code = cc.UserDefault:getInstance():getBoolForKey("b_rember_code"..type)
		item.login_type = cc.UserDefault:getInstance():getIntegerForKey("login_type"..type)
	
		table.insert(login_user_info_lst,item) 
	end

	-- login_user_info_lst = {}
	-- local file_obj = CFileTools()

	-- file_obj:open(user_info_file_name,false)
	-- local len = file_obj:readInt()

	-- for i=1,len do
	-- 	local item = {}
	-- 	item.id = file_obj:readInt()
	-- 	item.user_name = file_obj:readString()
	-- 	item.user_code = file_obj:readString()
	-- 	item.login_type = file_obj:readInt()

	-- 	--print("readuser", item.id, item.user_name, item.user_code, item.login_type)
        
	-- 	local val = file_obj:readInt()
	-- 	if val == 0 then item.b_rember_code = false end
	-- 	if val == 1 then item.b_rember_code = true end

	-- 	login_user_info_lst[i] = item
	-- end

	-- file_obj:close()
	-- file_obj = nil
end



-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
