#remark
WindowRegFun = {
	lb_down_call_lst 		= {},
	tab_key_call_lst 		= {},
	direction_key_call_lst 	= {},
	enter_key_call_lst 		= {},

	key_down_call_lst 		= {},
	key_up_call_lst 		= {},
	key_char_call_lst 		= {},
	commkey_ctrlxx_call_lst = {},
}




--mouse left button call lst
function WindowRegFun.reg_LB_BUTTON_DOWN(f,k)
	if f and k then WindowRegFun.lb_down_call_lst[k] = f end
end

function WindowRegFun.unreg_LB_BUTTON_DOWN(k)
	WindowRegFun.lb_down_call_lst[k] = nil
end

function WindowRegFun.call_lb_button_down(w,l)
	local gx = WindowModule.get_high_word(l)
	local gy = WindowModule.get_low_word(l)

	for k,v in pairs(WindowRegFun.lb_down_call_lst) do
		v(gx,gy)
	end
end




--tab key call lst
function WindowRegFun.reg_tab_key_call(f,k)
	if f and k then WindowRegFun.tab_key_call_lst[k] = f end
end

function WindowRegFun.unreg_tab_key_call(k)
	WindowRegFun.tab_key_call_lst[k] = nil
end

function WindowRegFun.select_tab_new_call(f,k)
	local old_call_lst = clone(WindowRegFun.tab_key_call_lst)

	local new_tab_key_call_lst = {}
	new_tab_key_call_lst[k] = f
	WindowRegFun.tab_key_call_lst = new_tab_key_call_lst

	return old_call_lst
end

function WindowRegFun.set_tab_key_call_lst(handle)
	WindowRegFun.tab_key_call_lst = handle
end

function WindowRegFun.call_tab_key_func()
	for k,v in pairs(WindowRegFun.tab_key_call_lst) do
		v()
	end
end




--direction key call lst
function WindowRegFun.reg_direction_key_call(f,k)
	-- body
	if f and k then WindowRegFun.direction_key_call_lst[k] = f end
end

function WindowRegFun.unreg_direction_key_call(k)
	-- body
	WindowRegFun.direction_key_call_lst[k] = nil
end

--[[
	dir : direction for key , 0 -> left ,1 -> right ,2 -> up ,3 -> down
]]
function WindowRegFun.call_direction_key_func(dir)
	-- body
	for k,v in pairs(WindowRegFun.direction_key_call_lst) do
		v(dir)
	end
end




--enter key call lst
function WindowRegFun.reg_enter_key_call(f,k)
	if f and k then WindowRegFun.enter_key_call_lst[k] = f end
end

function WindowRegFun.unreg_enter_key_call(k)
	-- body
	WindowRegFun.enter_key_call_lst[k] = nil
end

function WindowRegFun.select_enter_new_call(f,k)
	local old_call_lst = clone(WindowRegFun.enter_key_call_lst)

	local new_enter_key_call_lst = {}
	new_enter_key_call_lst[k] = f
	WindowRegFun.enter_key_call_lst = new_enter_key_call_lst

	return old_call_lst
end

function WindowRegFun.set_enter_call_lst(handle)
	WindowRegFun.enter_key_call_lst = handle
end


function WindowRegFun.call_enter_key_func()
	for k,v in pairs(WindowRegFun.enter_key_call_lst) do
		v()
	end
end




--key down call lst
function WindowRegFun.reg_key_down_call(f,k)
	if f and k then WindowRegFun.key_down_call_lst[k] = f end
end

function WindowRegFun.unreg_key_down_call(k)
	WindowRegFun.key_down_call_lst[k] = nil
end

function WindowRegFun.call_key_down_func(w,l)
	local s = getCharByWparam(w)
	for k,v in pairs(WindowRegFun.key_down_call_lst) do
		v(s)
	end
end




--key up call lst
function WindowRegFun.reg_key_up_call(f,k)
	if f and k then WindowRegFun.key_up_call_lst[k] = f end
end

function WindowRegFun.unreg_key_up_call(k)
	WindowRegFun.key_up_call_lst[k] = nil
end

function WindowRegFun.call_key_up_func(w,l)
	local s = getCharByWparam(w)
	for k,v in pairs(WindowRegFun.key_up_call_lst) do
		v(s)
	end
end





--key char call lst
function WindowRegFun.reg_key_char_call(f,k)
	if f and k then WindowRegFun.key_char_call_lst[k] = f end
end

function WindowRegFun.unreg_key_char_call(k)
	WindowRegFun.key_char_call_lst[k] = nil
end

function WindowRegFun.call_key_char_func(w,l)
	local s = getCharByWparam(w)
	for k,v in pairs(WindowRegFun.key_char_call_lst) do
		v(s)
	end
end


--register ctrl + xx call function
function WindowRegFun.reg_commkey_ctrl_xx(f,k)
	if f and k then WindowRegFun.commkey_ctrlxx_call_lst[k] = f end
end

function WindowRegFun.unreg_commkey_ctrl_xx(k)
	if k then WindowRegFun.commkey_ctrlxx_call_lst[k] = nil end
end

function WindowRegFun.call_commkey_ctrl_xx(w,l)
	local s = getCharByWparam(w)
	for k,v in pairs(WindowRegFun.commkey_ctrlxx_call_lst) do
		v(s)
	end
end
