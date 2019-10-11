#remark
WindowModule = {
	cur_mouse_x = 0,
	cur_mouse_y = 0,
}

enum_win_mod = {
	window = 1,
	full_screen = 2,
}

enum_win_show_mod = {
	mod_show = 1,
	mod_hide = 2,
	mod_mini = 3,
	mod_restore = 4,
	mod_max = 5,
}

function WindowModule.refresh_mouse_position(x,y)
	WindowModule.cur_mouse_x = x
	WindowModule.cur_mouse_y = y
end

function WindowModule.get_mouse_position()
	local pos = {x = WindowModule.cur_mouse_x,y = WindowModule.cur_mouse_y,}
	return pos
end

function WindowModule.selectDesCutWay()

	local way = cc.ResolutionPolicy.EXACT_FIT
	local des_size = {width = CC_DESIGN_RESOLUTION.width,height = CC_DESIGN_RESOLUTION.height,}
	local srceen_size = cc.Director:getInstance():getOpenGLView():getFrameSize()

	local des_swh = des_size.width/des_size.height
	local scr_swh = srceen_size.width/srceen_size.height

	if math.abs(des_swh - scr_swh) > 0.22 then
		way = cc.ResolutionPolicy.SHOW_ALL
		print("des cut way = " .. way)
	end

	return way
end


function WindowModule.set_window_module(mod,des_w,des_h)
	if mod == 1 then
		WindModule:getInstance():setWndModule(1)
		cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(des_w,des_h,WindowModule.selectDesCutWay())
	elseif mod == 2 then
		WindModule:getInstance():setWndModule(2)
		cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(des_w,des_h,WindowModule.selectDesCutWay())
	end
end

function WindowModule.get_window_module()
	return WindModule:getInstance():getWndModule()
end

--[[
 	p : (0 -> add window title ,1 -> delete window title)
]]
function WindowModule.delete_window_title(p,des_w,des_h)
	WindModule:getInstance():delTitle(p)
	cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(des_w,des_h,WindowModule.selectDesCutWay())
end

function WindowModule.is_have_title()
	return WindModule:getInstance():isTitle()
end

function WindowModule.set_window_pos(z_mod,x,y,w,h,op,des_w,des_h)
	WindModule:getInstance():setWndPos(z_mod,x,y,w,h,op)
	cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(des_w,des_h,WindowModule.selectDesCutWay())
end

function WindowModule.set_window_size(x,y,des_w,des_h)
	WindModule:getInstance():size(x,y)
	cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(des_w,des_h,WindowModule.selectDesCutWay())
end

function WindowModule.set_window_size_no_des(x,y)
	WindModule:getInstance():size(x,y)
end

function WindowModule.set_window_mod_no_des(mod)
	if mod == 1 then
		WindModule:getInstance():setWndModule(1)
	elseif mod == 2 then
		WindModule:getInstance():setWndModule(2)
	end
end

function WindowModule.get_window_size()
	return cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
end

function WindowModule.set_window_position(x,y)
	WindModule:getInstance():position(x,y)
end

function WindowModule.center_window()
	WindModule:getInstance():centerWnd()
end

function WindowModule.set_virture_title_height(h)
	WindModule:getInstance():setVitureTitleH(h)
end

function WindowModule.get_virture_height()
	return WindModule:getInstance():getVitureTitleH()
end

function WindowModule.register_window_pro(f)
	WindModule:getInstance():regWndPro(f)
end

function WindowModule.get_high_word(p)
	return WindModule:getInstance():highWord(p)
end

function WindowModule.get_low_word(p)
	return WindModule:getInstance():lowerWord(p)
end

--获取消息码高字节
function WindowModule.get_high_byte(p)
	return WindModule:getInstance():highByte(p)
end

--获取消息码低字节
function WindowModule.get_low_byte(p)
	return WindModule:getInstance():lowerByte(p)
end

--获取屏幕高
function WindowModule.get_screen_h()
	return WindModule:getInstance():getScreenH()
end

--获取屏幕宽
function WindowModule.get_screen_w()
	return WindModule:getInstance():getScreenW()
end

--关闭窗口
function WindowModule.close()
	g_CloseSocket()
	HeartPro.uninit_heart_pro()
	cc.Director:getInstance():endToLua()

	local targetPlatform = cc.Application:getInstance():getTargetPlatform()
	if cc.PLATFORM_OS_IPHONE == targetPlatform then
		os.exit()
	end
end

--显示窗口
function WindowModule.show_window(mod)
	WindModule:getInstance():showWindow(mod)
end

--向窗口发送windows消息
function WindowModule.send_message(win_msg,w,p)
	WindModule:getInstance():sendWindowMessage(win_msg,w,p)
end

--通知任务栏闪烁
function WindowModule.flashWindow(time)
	WindModule:getInstance():flashWindow(time)
end

--判断窗口是否最小化
function WindowModule.isWindowMinix()
	return WindModule:getInstance():isWindowMinix()
end

function WindowModule.getTextFromClipboard()
	return WindModule:getInstance():getTextFromClipboard()
end

function WindowModule.setTextFromClipboard(str)
	return WindModule:getInstance():setTextFromClipboard(str)
end

function WindowModule.getKeyState(vk)
	return WindModule:getInstance():getKeyState(vk)
end

function WindowModule.isCtrlDown(w,l)
	return WindModule:getInstance():isCtrlDown(w,l)
end

--分辨率适配
function WindowModule.adapt_screen(win_size,mod,des_size)
	local screen_w = WindowModule.get_screen_w()
	local screen_h = WindowModule.get_screen_h()

	local new_win_size = {width = win_size.width,height = win_size.height,}

	if mod == enum_win_mod.window then
		local bwidth_max = false
		if win_size.width > screen_w then bwidth_max = true end

		local bheight_max = false
		if win_size.height > screen_h then bheight_max = true end

		if bwidth_max == true and bheight_max == false then
			new_win_size.width  = screen_w*0.93
			new_win_size.height = new_win_size.width*(des_size.height/des_size.width)
		elseif bwidth_max == true and bheight_max == true then

			if screen_w*0.93*(des_size.height/des_size.width) > screen_h then--按高计算
				new_win_size.height = screen_h*0.93
				new_win_size.width  = new_win_size.height*(des_size.width/des_size.height)
			else --按宽计算
				new_win_size.width = screen_w*0.93
				new_win_size.height = new_win_size.width*(des_size.height/des_size.width)
			end
		elseif bwidth_max == false and bheight_max == false then
			new_win_size.width = win_size.width
			new_win_size.height = win_size.height
		elseif bwidth_max == false and bheight_max == true then
			new_win_size.height = screen_h*0.93
			new_win_size.width  = new_win_size.height*(des_size.width/des_size.height)
		end
	elseif mod == enum_win_mod.full_screen then
		new_win_size.width  = screen_w
		new_win_size.height = screen_h
	end

	printf("new win size = (" .. new_win_size.width .. "," .. new_win_size.height .. ")")


	return new_win_size
end




-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
