#remark
--[[
	窗口过程函数
]]
function window_pro(msg,w,l)
	if msg == WM_MOUSEMOVE then
	elseif msg == WM_LBUTTONDOWN then
		--WindowRegFun.call_lb_button_down(w,l)
	elseif msg == WM_LBUTTONUP then
		--print("left button up")
	elseif msg == WM_RBUTTONDOWN then
		--print("right button click down")
	elseif msg == WM_RBUTTONUP then
		--print("right button click up")
	elseif msg == WM_LBUTTONDBLCLK then
		--print("left button double click >>>>>>>>")
	elseif msg == WM_RBUTTONDBLCLK then
		--print("right button double click >>>>>>>>>>>>>>")
	elseif msg == WM_CLOSE then
		--print("window close")
	elseif msg == WM_SIZE then
		--print("window size change")
	elseif msg == WM_KEYDOWN then
		WindowRegFun.call_key_down_func(w,l)
		default_wm_key_down(w,l)
	elseif msg == WM_KEYUP then
		WindowRegFun.call_key_up_func(w,l)
		default_wm_key_up(w,l)
	elseif msg == WM_CHAR then
		WindowRegFun.call_key_char_func(w,l)
		default_key_char(w,l)
	end
end

function default_wm_key_down(w,l)
	if w == VK_TAB then
		WindowRegFun.call_tab_key_func()
	elseif w == VK_RETURN then
		WindowRegFun.call_enter_key_func()
	elseif w == VK_LEFT or w == VK_UP or w == VK_RIGHT or w == VK_DOWN then
		local dir = -1

		if w == VK_LEFT then --left
			dir = 0
		elseif w == VK_RIGHT then -- right
			dir = 1
		elseif w == VK_UP then --up
			dir = 2
		elseif w == VK_DOWN then --down
			dir = 3
		end

		WindowRegFun.call_direction_key_func(dir)
	end

	if w ~= VK_CONTROL then
		if WindowModule.isCtrlDown(w,l) == 1 then
			WindowRegFun.call_commkey_ctrl_xx(w,l)
		end
	end
end

function default_wm_key_up(w,l)
	
end

function default_key_char(w,l)
	
end


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
