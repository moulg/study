#remark
--[[
	define global function
]]

--游戏名字限制字符
NAME_BITE_LIMIT = 8

--聊天输入框限制字符
TALK_BITE_LIMIT = 50

--游戏请求消息表
gameReqFunMap = {}

function g_GetDesignSize()
	-- body
	local des_size = {}
	des_size.w = CC_DESIGN_RESOLUTION.width
	des_size.h = CC_DESIGN_RESOLUTION.height

	return des_size
end


local g_socket = nil
function g_CreateSocket()
	-- body
	g_socket = NetSocket.new()
	g_socket:create()
	local cp = {
		ip 	   = net_config.ip,
		port   = net_config.port,
		t_out  = net_config.time_out,
		s_call = netConnectSuccess,
		t_call = netConnectTimeout,
		e_call = netConnectError,
		r_call = netReceivePkg,
	}
	g_socket:connect(cp)
end

function GetSocketInstance()
	-- body
	return g_socket
end

function g_ReConnect()
	-- body
	local cp = {
		ip 	   = net_config.ip,
		port   = net_config.port,
		t_out  = net_config.time_out,
		s_call = netConnectSuccess,
		t_call = netConnectTimeout,
		e_call = netConnectError,
		r_call = netReceivePkg,
	}
	if g_socket then g_socket:connect(cp) end
end

function g_CloseSocket()
	if g_socket then g_socket:close() end
end


function is_point_in_rect(rect,pos)
	if rect and pos then
		if (pos.x >= rect.x and pos.x <= rect.x + rect.width) and (pos.y >= rect.y and pos.y <= rect.height + rect.y) then
			return true
		else
			return false
		end
	end

	return false
end

function g_init_game_scene(mod_name)
	g_CreateSocket()
	--cc.Director:getInstance():setProjection(kCCDirectorProjection2D)
	
	local scene = WindowScene.scene()
	cc.Director:getInstance():replaceScene(scene)
	WindowScene.getInstance():replaceModuleByModuleName(mod_name)
	--WindowModule.register_window_pro(window_pro)
end



function get_char(str)
	-- body
	local len = string.len(str)
	local i = 1
	local new_index = 1

	local char_list = {}

	while i <= len do
		local c = string.sub(str,i,i)
		local n = string.byte(c)

		if n > 128 then
			char_list[new_index] = string.sub(str,i,i+2)
			i = i + 3
			new_index = new_index + 1
		else
			char_list[new_index] = c
			i = i + 1
			new_index = new_index + 1
		end
	end

	return char_list
end

function ansy_string(str)
	local len = string.len(str)
	local i = 1
	local new_index = 1

	local lst = {
		str_len = len,
		has_char_type = 0,
		ch_lst = {
			--[[
				str,ch_type,str_len,byte_len,wide_len,
			]]
		},
	}

	--ch_type : 1->number,2->abc,3->except number and abc,4->not asic2
	--str_len : char length
	--byte_len : byte length
	-- wide_len : show bit width

	local is_type_have = {false,false,false,false,}

	while i <= len do
		local c = string.sub(str,i,i)
		local n = string.byte(c)

		local ch_obj = {}
		if n >= 128 then --非asic2字符
			ch_obj.str 		= string.sub(str,i,i+2)
			ch_obj.ch_type  = 4
			ch_obj.str_len  = string.len(ch_obj.str)
			ch_obj.byte_len = 3
			ch_obj.wide_len = 2

			if is_type_have[4] == false then
				lst.has_char_type = lst.has_char_type + 1
				is_type_have[4] = true
			end

			i = i + 3
		else
			ch_obj.str 		= c
			ch_obj.str_len  = 1
			ch_obj.byte_len = 1
			ch_obj.wide_len = 1

			if n >= 48 and n <= 57 then
				ch_obj.ch_type = 1
				if is_type_have[1] == false then
					lst.has_char_type = lst.has_char_type + 1
					is_type_have[1] = true
				end
			elseif (n >= 65 and n <= 90) or (n >= 97 and n <= 122) then
				ch_obj.ch_type = 2
				if is_type_have[2] == false then
					lst.has_char_type = lst.has_char_type + 1
					is_type_have[2] = true
				end
			else
				ch_obj.ch_type = 3
				if is_type_have[3] == false then
					lst.has_char_type = lst.has_char_type + 1
					is_type_have[3] = true
				end
			end

			i = i + 1
		end

		lst.ch_lst[new_index] = ch_obj
		new_index = new_index + 1
	end

	return lst
end

function isVisibleFinal(obj)

	if obj then
		if obj:isVisible() == false then
			return false
		end

		local par = obj:getParent()
		if par then
			if isVisibleFinal(par) == false then
				return false
			end
		end
	else
		return false
	end

	return true
end

--s1合理的缩放到s2中
function get_scale_with_size(s1,s2)
	
	local scale = 1.0

	local sx = s2.width/s1.width
	if sx > 1.0 then sx = 1.0 end

	local sy = s2.height/s1.height
	if sy > 1.0 then sy = 1.0 end

	if sx > sy then 
		scale = sy
	else
		scale = sx
	end

	return scale
end

--载入本地json文件并解析为lua对象
function load_json_file(jpath)
	local data = cc.FileUtils:getInstance():getStringFromFile(jpath)
	return json.decode(data)
end

--[[是否为数字]]
function is_number_str(str)
	
	local len = string.len(str)
	local i = 1

	local bnum = false

	while i <= len do
		local c = string.sub(str,i,i)
		local n = string.byte(c)

		if (n >= 48 and n <= 57) then
			bnum = true
		else
			bnum = false
		end

		if bnum == false then return bnum end

		i = i + 1
	end

	return bnum
end

--是否为字母+数字
function is_number_abc_str(str)
	
	local len = string.len(str)
	local i = 1

	local bnum_abc = false

	while i <= len do
		local c = string.sub(str,i,i)
		local n = string.byte(c)

		if (n >= 48 and n <= 57) or (n >= 65 and n <= 90) or (n >= 97 and n <= 122) then
			bnum_abc = true
		else
			bnum_abc = false
		end

		if bnum_abc == false then return bnum_abc end

		i = i + 1
	end

	return bnum_abc
end

--是否为中文
function is_chinese_str(str)
	
	local len = string.len(str)
	local i = 1

	local bChinese = false

	while i <= len do
		local c = string.sub(str,i,i)
		local n = string.byte(c)

		if (n > 127) then
			bChinese = true
		else
			bChinese = false
		end

		if bChinese == false then return bChinese end

		i = i + 1
	end

	return bChinese
end

function is_asc2(str)

	local len = string.len(str)
	local i = 1

	local basc2 = false
	while i <= len do
		local c = string.sub(str,i,i)
		local n = string.byte(c)

		if n < 0 or n > 127  then
			return false
		end
		i = i + 1

		basc2 = true
	end

	return basc2
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
