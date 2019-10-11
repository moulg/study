#remark
local input_mark_file_src  = "lobby/resource/general/insert_mark.png"
local default_sellay_color = cc.c4b(0,0,0,100)


local edit_box_tab_index = 1 --tab递增顺序
local cur_input_focus 	 = 0 --当前焦点
local edit_obj_spr 	 = {}--当前注册的输入框

local input_text_mod = {
	input_number 	= 1,
	input_num_abc 	= 2,
	input_asc2 		= 3,
	input_all 		= 4,
	input_cn        = 5,--中文
}

 function is_number(str)
	
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

 function is_number_abc(str)
	
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

 function is_chinese(str)
	
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

local function is_asc2(str)
	-- body
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

local function edit_box_ctrl_xx(kchar)
	for k,v in pairs(edit_obj_spr) do
		v:onCtrlXX(kchar)
	end
end
WindowRegFun.reg_commkey_ctrl_xx(edit_box_ctrl_xx,"edit_box_ctrl_xx")



local function edit_box_tab_pro()
	if #edit_obj_spr > 0 then
		cur_input_focus = cur_input_focus + 1
		
		for i = cur_input_focus,#edit_obj_spr do
			if isVisibleFinal(edit_obj_spr[i]) == false or edit_obj_spr[i]:getEnableInput() == false then
				cur_input_focus = cur_input_focus + 1
			else
				break
			end
		end

		if cur_input_focus > #edit_obj_spr then
			cur_input_focus = 1
		end

		-- printf("current tab index = " .. cur_input_focus)

		for k,v in pairs(edit_obj_spr) do
			v:onTabKeyPro()
		end
	end	
end
WindowRegFun.reg_tab_key_call(edit_box_tab_pro,"edit_box_tab_pro") --注册edit box tab 事件


--[[
	dir : direction for key , 0 -> left ,1 -> right ,2 -> up ,3 -> down
]]
local function edit_box_direction_pro(dir)
	
	local obj = edit_obj_spr[cur_input_focus]
	if obj then
		if dir == 0 then 
			obj:onLeftKeyMove()
		elseif dir == 1 then
			obj:onRightKeyMove()
		end
	end
end
WindowRegFun.reg_direction_key_call(edit_box_direction_pro,"edit_box_direction_pro") --注册方向键事件


--[[
	输入框定义
]]

EditBoxEx = class("EditBoxEx",function ()
	local obj = ccui.TextField:create()
	obj:ignoreContentAdaptWithSize(false)
	obj:setLayoutComponentEnabled(true)
	obj:setCascadeColorEnabled(true)
	obj:setCascadeOpacityEnabled(true)
	obj:setPlaceHolder("")
	obj:setString([[]])
	obj:setAnchorPoint(0.0000, 0.5000)
	obj:setPosition(0,0)
	obj:setColor(cc.c3b(0, 0, 0))
	obj:setFocusEnabled(true)
	return obj
end)


function EditBoxEx.resetTabCtrData()
	cur_input_focus  = 0 --当前焦点
	edit_obj_spr = {} --当前注册的输入框
end

function EditBoxEx.remove_obj_in_tablst(obj)
	if obj then
		local len = #edit_obj_spr
		for i=1,len do
			if obj == edit_obj_spr[i] then
				table.remove(edit_obj_spr,i)
				break
			end
		end

		len = #edit_obj_spr
		for i=1,len do
			edit_obj_spr[i]:reset_box_tab(i)
		end
	end
end

function EditBoxEx.create()
	local obj = EditBoxEx.new()
	if obj then
		table.insert(edit_obj_spr,obj)
		obj:init()
	end

	return obj
end

function EditBoxEx:init()
	self:init_data()
	self:regEnterExit()
	self:regTouch()
	self:regMouseEvent()
	self:regTextEvent()
end

function EditBoxEx:init_data()
	self.tab_mark = #edit_obj_spr

	self.mark_info = {}
	self.cur_insert_focus 	 = 1
	self.front_char_lst 	 = {}
	
	self.show_index_start = 0
	self.show_index_end   = 0


	self.is_left_button_down = false
	self.orgin_left_down_pos = {}
	self.orgin_distance 	 = 0

	self.cur_move_pos = {}
	self.cur_move_distance = 0

	self.select_start_index = 0
	self.select_end_index = 0
	self.change_txt_call = nil
	self.focus_call = nil

	self.is_focus = false

	self.input_mod 	= input_text_mod.input_all
	self.max_number = nil
	self.is_change_cur = false
	self.select_tmp_text = ""
	self.select_way = 0
	self.mark_src = input_mark_file_src
	self.sel_layer_color = default_sellay_color

	self.benable_input = true

	self.max_length = -1
end

function EditBoxEx:reset_box_tab(tab)
	self.tab_mark = tab 
end


function EditBoxEx:init_ui()
	
end


function EditBoxEx:regEnterExit()
	local function __on_enter_exit(event)
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__on_enter_exit)
end

function EditBoxEx:onEnter()
	
end

function EditBoxEx:onExit()
	CTools:setSystemCursor(0)
	edit_obj_spr[self.tab_mark] = nil
end

function EditBoxEx:destroy()
	
	edit_obj_spr[self.tab_mark] = nil
end

function EditBoxEx:regTouch()
    self:onTouch(function (e)
        if e.name == "began" then
            if self:isEnabled() then
                self.editBoxEx_isCanTouch = true
            end
        elseif e.name == "ended" then
            self.editBoxEx_isCanTouch = false
        end
    end)
end

function EditBoxEx:onTouchBegan(x,y)
	return true
end

function EditBoxEx:onTouchMoved(x,y)
	return true
end

function EditBoxEx:onTouchEnded(x,y)
	return true
end

function EditBoxEx:regMouseEvent()
	local function __on_mouse_move(e)
    	self:onMouseMove(e)
    end

    local function __on_mouse_down(e)
    	self:onMouseDown(e)
    end

    local function __on_mous_up(e)
    	self:onMouseUp(e)
    end

    local mouse_listener = cc.EventListenerMouse:create()
	mouse_listener:registerScriptHandler(__on_mouse_move,cc.Handler.EVENT_MOUSE_MOVE)
	mouse_listener:registerScriptHandler(__on_mouse_down,cc.Handler.EVENT_MOUSE_DOWN)
	mouse_listener:registerScriptHandler(__on_mous_up,cc.Handler.EVENT_MOUSE_UP)

	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(mouse_listener,self)
end

function EditBoxEx:onMouseMove(e)

	if self.benable_input == false or (#self.front_char_lst <= 0 and self.is_left_button_down == true) then
		return
	end

	local cur_pos = e:getLocation()
	local pos = cc.Director:getInstance():convertToGL(cur_pos)

	if self.is_left_button_down == true then
		local mov_dis = cur_pos.x - self.orgin_left_down_pos.x
		self.mark_info.layer_sel:setVisible(true)
		self.cur_move_distance = cur_pos.x - self.cur_move_pos.x
		self.cur_move_pos = cur_pos

		self:computeSelTextAreaByMoveDis(mov_dis)
	end

	local is_move_into_box = false
	if self:hitTest(pos) == true and isVisibleFinal(self) == true then
		is_move_into_box = true
	end

	if self.is_change_cur ~= is_move_into_box then
		self.is_change_cur = is_move_into_box
		if is_move_into_box == true then
			CTools:setSystemCursor(1)
		else
			CTools:setSystemCursor(0)
		end
	end
end

function EditBoxEx:computeSelTextAreaByMoveDis(dis)
	local box_size = self:getContentSize()
	local tdis = math.abs(dis)

	local begin_index = self.select_start_index

	if begin_index == 0 then return false end
	if #self.front_char_lst < begin_index - 1 then return false end
	if dis < 0 and begin_index <= 1 then return false end
	if dis > 0 and begin_index >= #self.front_char_lst + 1 then return false end

	local str0 	= ""
	local str1 	= ""
	local fs 	= self:getFontSize()

	if dis < 0 then
		begin_index = begin_index - 1

		local bget_insert = false
		for i=begin_index,1,-1 do
			str0 = self.front_char_lst[i] .. str0
			if i < begin_index then str1 = self.front_char_lst[i + 1] .. str1 end

			local ts = textUtils.getTextPixelSize(str0,fs,self:getFontName())

			if ts.width > tdis then

				bget_insert = true
				self.cur_insert_focus = i
				if self.cur_move_distance > 0 then self.cur_insert_focus = i + 1 end

				break
			end
		end

		if bget_insert == false then self.cur_insert_focus = 1 end

		local txt = str0
		if self.cur_move_distance > 0 then txt = str1 end
		self.select_tmp_text = txt
		self.select_way = -1


		local layer_len = textUtils.getTextPixelSize(txt,fs,self:getFontName()).width
		if layer_len > box_size.width then 
			layer_len = box_size.width
		end

		self.mark_info.layer_sel:changeWidth(-layer_len)


		if layer_len > self.orgin_distance then 
			self.mark_info.layer_sel:setPositionX(layer_len)
		end
	else
		local bget_insert = false
		for i=begin_index,#self.front_char_lst,1 do

			str0 = str0 .. self.front_char_lst[i]
			if i > begin_index then str1 = str1 .. self.front_char_lst[i - 1] end
			local ts = textUtils.getTextPixelSize(str0,fs,self:getFontName())

			if ts.width > tdis then
				self.cur_insert_focus = i + 1
				if self.cur_move_distance < 0 then 
					self.cur_insert_focus = i 
				end

				bget_insert = true

				break
			end
		end

		if bget_insert == false then
			self.cur_insert_focus = #self.front_char_lst + 1
		end


		local txt = str0
		if self.cur_move_distance < 0 then txt = str1 end
		self.select_tmp_text = txt
		self.select_way = 1


		local layer_len = textUtils.getTextPixelSize(txt,fs,self:getFontName()).width

		if layer_len > box_size.width then 
			layer_len = box_size.width 
		end

		self.mark_info.layer_sel:changeWidth(layer_len)

		if layer_len > box_size.width - self.orgin_distance then
			self.mark_info.layer_sel:setPositionX(box_size.width - layer_len)
		end
	end

	--printf(self.select_tmp_text)


	if self:isPasswordEnabled() == false then
		self:showTextByCurFocus()
	else
		self:moveTextMarkByInsertFocus()
	end
	
	--printf("call showTextByCurFocus function in computeSelTextAreaByMoveDis!")
end

function EditBoxEx:computeSelStartEnd(sel_str)
	if sel_str and sel_str ~= "" then

		--printf(sel_str)

		local char_lst = get_char(sel_str)

		if self.select_way == -1 then
			self.select_start_index = self.cur_insert_focus
			self.select_end_index 	= self.select_start_index + #char_lst - 1
		elseif self.select_way == 1 then
			self.select_end_index 	= self.cur_insert_focus - 1
			self.select_start_index = self.cur_insert_focus - #char_lst
		end

		self.select_way = 0

		--printf("select_start_index = " .. self.select_start_index .. ",select_end_index = " .. self.select_end_index)
	end
end

function EditBoxEx:onMouseDown(e)
	-- body
	local btn_type = e:getMouseButton()

	if btn_type == 0 then --left mouse button
		self:onLeftMouseButtonDownPro(e)
	elseif btn_type == 1 then --right mouse button
	elseif btn_type == 2 then --center mouse button
	end
end

function EditBoxEx:selectAll()
	if #self.front_char_lst > 0 then

		self:createNewMarkInfo()
		self.mark_info.spr_mark:setPositionX(0)

		self.show_index_end 	= #self.front_char_lst
		self.cur_insert_focus 	= #self.front_char_lst + 1
		self.mark_info.layer_sel:setVisible(true)

		local fs = self:getFontSize()
		local str0 = ""
		local str1 = ""
		local box_size = self:getContentSize()
		local str0_len = 0
		local str1_len = 0
		local is_fill_full = false

		for i=#self.front_char_lst,1,-1 do --find start index
			str0 = self.front_char_lst[i] .. str0
			if i < #self.front_char_lst then str1 = self.front_char_lst[i] .. str1 end
			local ts = textUtils.getTextPixelSize(str0,fs,self:getFontName())
			str1_len = textUtils.getTextPixelSize(str1,fs,self:getFontName()).width
			str0_len = ts.width
			if ts.width > box_size.width then
				self.show_index_start = i + 1
				is_fill_full = true
				break
			end
		end

		local layer_len = 0
		if is_fill_full == false then
			self.mark_info.layer_sel:setPositionX(str0_len)
			self.mark_info.layer_sel:changeWidth(-str0_len)
		else
			self.mark_info.layer_sel:setPositionX(str1_len)
			self.mark_info.layer_sel:changeWidth(-str1_len)
		end

		--self:showTextByCurFocus()
		--printf("call showTextByCurFocus function in getInputFocus!")
		self.select_start_index = 1
		self.select_end_index 	= #self.front_char_lst
		self.select_tmp_text = self:getStringEx()
	end
end

function EditBoxEx:getInputFocus()
	self:createNewMarkInfo()
	self.mark_info.spr_mark:setPositionX(0)
	if #self.front_char_lst > 0 then

		self.show_index_end 	= #self.front_char_lst
		self.cur_insert_focus 	= #self.front_char_lst + 1
		self.mark_info.layer_sel:setVisible(true)

		local fs = self:getFontSize()
		local str0 = ""
		local str1 = ""
		local box_size = self:getContentSize()
		local str0_len = 0
		local str1_len = 0
		local is_fill_full = false

		for i=#self.front_char_lst,1,-1 do --find start index
			str0 = self.front_char_lst[i] .. str0
			if i < #self.front_char_lst then str1 = self.front_char_lst[i] .. str1 end
			local ts = textUtils.getTextPixelSize(str0,fs,self:getFontName())
			str1_len = textUtils.getTextPixelSize(str1,fs,self:getFontName()).width
			str0_len = ts.width
			if ts.width > box_size.width then
				self.show_index_start = i + 1
				is_fill_full = true
				break
			end
		end

		local layer_len = 0
		if is_fill_full == false then
			self.mark_info.layer_sel:setPositionX(str0_len)
			self.mark_info.layer_sel:changeWidth(-str0_len)
		else
			self.mark_info.layer_sel:setPositionX(str1_len)
			self.mark_info.layer_sel:changeWidth(-str1_len)
		end

		--self:showTextByCurFocus()
		--printf("call showTextByCurFocus function in getInputFocus!")
		self.select_start_index = 1
		self.select_end_index 	= #self.front_char_lst
		self.select_tmp_text = self:getStringEx()
	end

	
	self:attachWithIME()
	self.is_focus = true
	if self.focus_call then 
		local str = self:getStringEx()
		self.focus_call(1, str) 
	end
end

function EditBoxEx:lostFocus()
	self:destroyMarkInfo()
	self:didNotSelectSelf()
	self.select_start_index = 0
	self.select_end_index = 0
	self.select_tmp_text = ""
	if self.focus_call and self.is_focus == true then
		local str = self:getStringEx()
		self.focus_call(0, str) 
	end
	self.is_focus = false
end

function EditBoxEx:onLeftMouseButtonDownPro(e)
	if self.benable_input == false then
		return
	end
	
	local pos = cc.Director:getInstance():convertToGL(e:getLocation())
    
	if self:hitTest(pos) == true and self.editBoxEx_isCanTouch == true then
		self.is_left_button_down = true
		--print("input text get focurs >>>>>>>>>>")
		self:createNewMarkInfo()
		local cpos = self:computeWordPos(self)
		local x_distance = pos.x - cpos.x
		--print("x_distance = " .. x_distance)

		local rx = self:computeTextMarkPositionX(x_distance)
		self.mark_info.spr_mark:setPositionX(rx)
		self.mark_info.layer_sel:setPositionX(rx)
		self.mark_info.layer_sel:changeWidth(2)
		self.mark_info.layer_sel:setVisible(false)

		self.orgin_left_down_pos = self:computeWordPos(self.mark_info.spr_mark)
		self.orgin_distance = rx
		self.select_start_index = self.cur_insert_focus
		self.select_end_index   = self.select_start_index
		self.select_tmp_text = ""
		self.cur_move_pos = self.orgin_left_down_pos
		self.cur_move_distance = 0
		cur_input_focus = self.tab_mark

		--get input focus
		self.is_focus = true
		if self.focus_call then 
			local str = self:getStringEx()
			self.focus_call(1, str) 
		end
	else
		self:lostFocus()
	end
end

function EditBoxEx:onMouseUp(e)
	local btn_type = e:getMouseButton()

	if btn_type == 0 then --left mouse button
		self:onLeftMouseButtonUpPro(e)
	elseif btn_type == 1 then --right mouse button
	elseif btn_type == 2 then --center mouse button
	end
end

function EditBoxEx:onLeftMouseButtonUpPro(e)
	self.is_left_button_down = false
	self:computeSelStartEnd(self.select_tmp_text)
end

function EditBoxEx:regTextEvent()
	local function __on_text_input_mark(e)
		self:onInputEvent(e)
	end
	self:onEvent(__on_text_input_mark)
end

function EditBoxEx:onInputEvent(e)
	if e.name == "ATTACH_WITH_IME" then
	elseif e.name == "DETACH_WITH_IME" then
	elseif e.name == "INSERT_TEXT" then
		self:onInsertText()
	elseif e.name == "DELETE_BACKWARD" then
		self:onDeleteText()
	end
end

function EditBoxEx:computeShowTextArea()

	if #self.front_char_lst == 0 then return "" end
	local box_width = self:getContentSize().width
	local fs = self:getFontSize()

	local s = self.show_index_start
	local m = self.cur_insert_focus - 1
	local e = #self.front_char_lst

	

	if s > e then return "" end

	if s > m then s = m end
	if s == 0 then s = 1 end



	local b_fill_full = false
	local sub_char0 = ""
	local sub_char1 = ""

	--以输入焦点为中心向前取填充字符
	if m > 0 then
		for i=m,s,-1 do
			sub_char0 = self.front_char_lst[i] .. sub_char0
			if i < m then sub_char1 = self.front_char_lst[i+1] .. sub_char1 end
			local ts = textUtils.getTextPixelSize(sub_char0,fs,self:getFontName())
			--local ts = {width = 100,height = 10,}
			if ts.width > box_width then
				b_fill_full = true
				self.show_index_start 	= i + 1
				self.show_index_end 	= m
				break
			end

			self.show_index_start = i
		end

		if b_fill_full == false and self.show_index_start > 0 then
			sub_char1 = self.front_char_lst[self.show_index_start] .. sub_char1
		end
	else
		self.show_index_start = 1
	end


	if b_fill_full == false then

		--以输入焦点为中心向后取填充字符
		for i=m+1,e,1 do 
			sub_char0 = sub_char0 .. self.front_char_lst[i]
			if i > m + 1 then sub_char1 = sub_char1 .. self.front_char_lst[i - 1] end
			local ts = textUtils.getTextPixelSize(sub_char0,fs,self:getFontName())
			--local ts = {width = 100,height = 10,}
			if ts.width > box_width then
				b_fill_full = true
				self.show_index_end = i - 1
				break
			end
		end
	end

	if b_fill_full == false then
		self.show_index_end = #self.front_char_lst
	end

	if b_fill_full == false then
		return sub_char0
	else
		return sub_char1
	end

	return ""
end

function EditBoxEx:insertTextEx(str)
	local char_lst = get_char(str)
	local char_len = #char_lst

	
	local binput = true

	if self.input_mod == input_text_mod.input_number then
		if is_number(str) == false then binput = false end
	end

	if self.input_mod == input_text_mod.input_num_abc then
		if is_number_abc(str) == false then binput = false end
	end

	if self.input_mod == input_text_mod.input_asc2 then
		if is_asc2(str) == false then binput = false end
	end
	
	if self.input_mod == input_text_mod.input_cn then
		if is_chinese(str) == false then binput = false end
	end


	if binput == true then

		if self.select_tmp_text ~= "" then
			local n = self.select_end_index - self.select_start_index + 1
			for i=1,n do table.remove(char_lst,self.select_start_index) end

			self:deleteText()

			--self:resetLayerSel()
			self.select_start_index = 0
			self.select_end_index = 0
			self.select_tmp_text  = ""
		end

		self:resetLayerSel()

		local begin_index = self.show_index_end - self.show_index_start + 1
		if self.show_index_end == self.show_index_start and self.show_index_end == 0 then
			begin_index = 0
		end

		if begin_index > char_len then
			print("input string error >>>>>>>>>>>>>>>")
			return
		end

		--print("current char lst size = " .. char_len .. " ," .. "begin insert char index = " .. begin_index)
		for i = begin_index + 1,#char_lst do
			if self.max_length ~= -1 and self:getTextLen() >= self.max_length then
				break
			end

			table.insert(self.front_char_lst,self.cur_insert_focus,char_lst[i])
			self.cur_insert_focus = self.cur_insert_focus + 1
		end
	end

	

	self:showTextByCurFocus()
	--printf("call showTextByCurFocus function in onInsertText!")

	if self.input_mod == input_text_mod.input_number and self.max_number ~= nil then
		local str = self:getStringEx()
		if str ~= nil then
			local in_number = tonumber(str)
			if in_number > self.max_number then
				local new_str = tostring(self.max_number)
				if new_str then self:setStringEx(new_str) end
			end
		end
	end

	if self.change_txt_call ~= nil then
		local str = self:getStringEx()
		self.change_txt_call(str) 
	end
end

function EditBoxEx:onInsertText()

	if self.benable_input == false then
		self:setStringEx(self:getStringEx())
		return
	end

	local str = self:getString()
	self:insertTextEx(str)
end


function EditBoxEx:delTextByCurInsertText()
	if self.cur_insert_focus - 1 > #self.front_char_lst then
		print("delete data error >>>>>>>")
		return
	end

	if self.cur_insert_focus > 1 then

		self.cur_insert_focus = self.cur_insert_focus - 1
		table.remove(self.front_char_lst,self.cur_insert_focus)

		if self.show_index_start >= self.cur_insert_focus then self.show_index_start = self.show_index_start - 4 end
		if self.show_index_start <= 0 then self.show_index_start = 1 end
		if self.show_index_end > #self.front_char_lst then self.show_index_end = #self.front_char_lst end
	else
		self.cur_insert_focus = 1
		self.show_index_start = 1
		

		if #self.front_char_lst <= 0 then
			self.show_index_end   = 0
			self.show_index_start = 0
		end
	end

	--print("show index start = " .. self.show_index_start .. " ,show index end = " .. self.show_index_end .. " ,insert index = " .. self.cur_insert_focus)


	--
end

--[[
	step : 移动步长, step > 0 表示后移动，step < 0 表示向前移
]]
function EditBoxEx:moveInsertFocus(step)
	-- body
	if #self.front_char_lst <= 0 then
		return
	end 

	self.cur_insert_focus = self.cur_insert_focus + step
	if self.cur_insert_focus > #self.front_char_lst + 1 then
		self.cur_insert_focus = #self.front_char_lst + 1
	end

	if self.cur_insert_focus < 1 then
		self.cur_insert_focus = 1
	end

	self:showTextByCurFocus()
	--printf("call showTextByCurFocus function in moveInsertFocus!")

	self.select_start_index = 0
	self.select_end_index 	= 0
	self.select_tmp_text 	= ""
	if self.mark_info.layer_sel then
		self.mark_info.layer_sel:setVisible(false)
		self.mark_info.layer_sel:changeWidth(2)
		self.mark_info.layer_sel:setPositionX(0)
	end
end

function EditBoxEx:showTextByCurFocus()
	local show_str = self:computeShowTextArea()
	self:setString(show_str)
	self:moveTextMarkByInsertFocus()
end

function EditBoxEx:deleteText()


	if (self.select_start_index ~= 0 and self.select_end_index ~= 0) and self.select_tmp_text ~= "" then
		if self.select_end_index <= #self.front_char_lst then
			self.cur_insert_focus = self.select_end_index + 1
			for i=self.select_end_index,self.select_start_index,-1 do
				self:delTextByCurInsertText()
			end
			self.select_start_index = 0
			self.select_end_index 	= 0
			self.select_tmp_text 	= ""
		end
	else
		self:delTextByCurInsertText()
	end
end


function EditBoxEx:onDeleteText()
	if self.benable_input == false then
		self:setStringEx(self:getStringEx())
		return
	end 

	self:resetLayerSel()
	self:deleteText()

	
	self:showTextByCurFocus()
	--printf("call showTextByCurFocus function in onDeleteText!")

	if self.input_mod == input_text_mod.input_number and self.max_number ~= nil then
		local str = self:getStringEx()
		if str ~= nil and str ~= "" then
			local in_number = str
			if long_compare(in_number, self.max_number) == 1 then
				local new_str = tostring(self.max_number)
				if new_str then self:setStringEx(new_str) end
			end
		end
	end

	if self.change_txt_call ~= nil then
		local str = self:getStringEx()
		self.change_txt_call(str) 
	end
end

function EditBoxEx:moveTextMarkByInsertFocus()
	if self.mark_info.spr_mark then
		if self.cur_insert_focus == 1 then
			self.mark_info.spr_mark:setPositionX(0)
		else
			if #self.front_char_lst <= 0 then
				self.mark_info.spr_mark:setPositionX(0)
				return true
			end

			if self.show_index_start > self.cur_insert_focus then
				--print("compute mark position error >>>>>>>>")
				return
			end

			local str = ""
			for i=self.show_index_start,self.cur_insert_focus - 1 do
				if self.front_char_lst[i] == nil then
					--print("focus data error >>>>>>>>")
					return
				end
				str = str .. self.front_char_lst[i]
			end

			local fs = self:getFontSize()
			local len = textUtils.getTextPixelSize(str,fs,self:getFontName()).width
			local max_len = self:getContentSize().width

			if len > max_len then len = max_len end

			self.mark_info.spr_mark:setPositionX(len)
		end
	end
end

function EditBoxEx:createNewMarkInfo()
	self:destroyMarkInfo()

	local parent_size = self:getContentSize()
	--creat mark img
	self.mark_info.spr_mark = ccui.ImageView:create()
	self.mark_info.spr_mark:loadTexture(self.mark_src)
	local mark_size = self.mark_info.spr_mark:getContentSize()
	local s_y = parent_size.height/mark_size.height
	self.mark_info.spr_mark:setScaleY(s_y)
	self.mark_info.spr_mark:setPosition(0,parent_size.height/2)
	self:addChild(self.mark_info.spr_mark)
	self.mark_info.spr_mark:runAction(cc.RepeatForever:create(cc.Blink:create(1,1)))

	--create select layer
	--print("parent height = " .. parent_size.height)
	self.mark_info.layer_sel = cc.LayerColor:create(self.sel_layer_color, 2, parent_size.height)
	self.mark_info.layer_sel:setPosition(0,0)
	self.mark_info.layer_sel:setVisible(false)
	self:addChild(self.mark_info.layer_sel)



	-- local str = self:getString()
	-- self.front_char_lst = get_char(str)
end

function EditBoxEx:destroyMarkInfo()
	-- body
	if self.mark_info.spr_mark and self.mark_info.layer_sel then
		self.mark_info.spr_mark:stopAllActions()
		self.mark_info.spr_mark:setVisible(false)
		self.mark_info.spr_mark:removeFromParent()

		self.mark_info.layer_sel:setVisible(false)
		self.mark_info.layer_sel:removeFromParent()

		self.mark_info = {}
	end
end

function EditBoxEx:resetLayerSel()
	if self.mark_info.layer_sel and self.mark_info.layer_sel:isVisible() == true then
		self.mark_info.layer_sel:changeWidth(2)
		self.mark_info.layer_sel:setPositionX(0)
		self.mark_info.layer_sel:setVisible(false)
	end
end

function EditBoxEx:computeWordPos(obj)
	if obj then
		local obj_x,obj_y = obj:getPosition()
		local word_obj_pos = obj:convertToWorldSpace({x = obj_x,y = obj_y,})
		--print("word_obj_pos.x = " .. word_obj_pos.x .. " ,word_obj_pos.y = " .. word_obj_pos.y)

		local gl_obj_pos = {x = word_obj_pos.x - obj_x,y = word_obj_pos.y - obj_y}
		--print("gl_obj_pos.x = " .. gl_obj_pos.x .. " ,gl_obj_pos.y = " .. gl_obj_pos.y)

		return {x = gl_obj_pos.x,y = gl_obj_pos.y,}
	end
end

function EditBoxEx:computeTextMarkPositionX(r_x)
	local des_x 	= 0
	local str_txt   = self:getString()
	local char_lst  = get_char(str_txt)

	local tts = self:getAutoRenderSize()
	if r_x >= tts.width then
		des_x = tts.width
		self.cur_insert_focus = self.show_index_start + #char_lst
		if self.cur_insert_focus == 0 then self.cur_insert_focus = 1 end

		--print("show start index = " .. self.show_index_start .. " ,cur insert index = " .. self.cur_insert_focus .. " ,show end index  = " .. self.show_index_end)
		return des_x
	end
	
	if #char_lst > 0 then
		local sub_str  = ""
		local sub_str1 = ""
		local fs = self:getFontSize()
		for i=1,#char_lst do
			sub_str  = sub_str .. char_lst[i]
			if i > 1 then sub_str1 = sub_str1 .. char_lst[i - 1] end
			local ts = textUtils.getTextPixelSize(sub_str,fs,self:getFontName())

			if ts.width > r_x then
				local csz = textUtils.getTextPixelSize(char_lst[i],fs,self:getFontName())
				if ts.width - r_x > csz.width/2 then
					if i == 1 then
						des_x = 0
					else
						des_x = textUtils.getTextPixelSize(sub_str1,fs,self:getFontName()).width
					end
					self.cur_insert_focus = i
				else
					des_x = ts.width
					self.cur_insert_focus = i + 1
				end

				break
			end
		end

		self.cur_insert_focus = self.cur_insert_focus + self.show_index_start - 1

	else
		self.cur_insert_focus = 1
		des_x = 0
	end

	--print("show start index = " .. self.show_index_start .. " ,cur insert index = " .. self.cur_insert_focus .. " ,show end index  = " .. self.show_index_end)


	return des_x
end

function EditBoxEx:onLeftKeyMove()
	--print("edit box left key down")
	self:moveInsertFocus(-1)
end

function EditBoxEx:onRightKeyMove()
	--print("edit box right key down")
	self:moveInsertFocus(1)
end

function EditBoxEx:onTabKeyPro()
	--print("call edit box tab func >>>>>>>>>>>")

	if self.tab_mark == cur_input_focus then
		self:getInputFocus()
	else
		self:lostFocus()
	end
end

function EditBoxEx:getStringEx()
	local str = ""
	for i=1,#self.front_char_lst do
		str = str .. self.front_char_lst[i]
	end

	return str
end

function EditBoxEx:setStringEx(str)
	if str then
		if self.input_mod == input_text_mod.input_number and self.max_number ~= nil then
			if tonumber(str) > self.max_number then
				str = tostring(self.max_number)
			end
		end

		local new_char_lst = self:getTextLenEx(get_char(str),self.max_length)

		self.front_char_lst = new_char_lst
		self.select_start_index = 0
		self.select_end_index 	= 0
		self.select_tmp_text 	= ""

		self.show_index_start = 0
		self.show_index_end 	= #self.front_char_lst
		self.cur_insert_focus 	= #self.front_char_lst + 1

		self:showTextByCurFocus()
		--printf("call showTextByCurFocus function in setStringEx!")
	end
end


--[[
	f = f(txt)
]]
function EditBoxEx:setTextChangeCall(f)
	self.change_txt_call = f
end

--[[
	f = f(mod, txt)
	mod = 1 -> get focus
	mod = 0 -> lose focus
]]
function EditBoxEx:setFocusCall(f)
	self.focus_call = f
end

--[[
	number 		= 1,
	num_abc 	= 2,
	asc2 		= 3,
	all 		= 4,
	cn 			= 5,--中文
]]
function EditBoxEx:setInputTextMod(mod,param)
	if mod then	self.input_mod = mod end
	if mod == input_text_mod.input_number then self.max_number = param end
end

--[[
	set mark texture
]]
function EditBoxEx:setMarkTexture(str_src)
	if str_src then
		self.mark_src = str_src
		if self.mark_info.spr_mark then
			self.mark_info.spr_mark:loadTexture(self.mark_src)
		end
	end
end

--[[
	set select color
]]
function EditBoxEx:setSelectColor(c4bcolor)
	if c4bcolor then
		self.sel_layer_color = c4bcolor
		if self.mark_info.layer_sel then
			local c3bcolor = {r = c4bcolor.r,g = c4bcolor.g,b = c4bcolor.b,}
			self.mark_info.layer_sel:setColor(c3bcolor)
			self.mark_info.layer_sel:setOpacity(c4bcolor.a)
		end
	end
end

function EditBoxEx:setEnableInput(binput)
	self.benable_input = binput
end

function EditBoxEx:getEnableInput()
	return self.benable_input
end

function EditBoxEx:setInputMaxLen(len)
	self.max_length = len
end

function EditBoxEx:getTextLen()
	local len = 0
	for k,v in pairs(self.front_char_lst) do
		if is_asc2(v) == true then
			len = len + 1
		else
			len = len + 2 
		end
	end

	return len
end

function EditBoxEx:getTextLenEx(char_lst,new_len)

	if new_len == -1 then
		return char_lst
	end

	local new_char_lst = {}
	local len = 0
	for i=1,#char_lst do
		if is_asc2(char_lst[i]) == true then
			len = len + 1
		else
			len = len + 2
		end

		if len > new_len then
			break
		else
			table.insert(new_char_lst,char_lst[i])
		end
	end

	return new_char_lst
end

function EditBoxEx:getTabIndex()
	return self.tab_mark
end

function EditBoxEx:onCtrlXX(key)

	if self.is_focus == true then
		if key == "A" then
			self:selectAll()
		elseif key == "C" then
			local str = self.select_tmp_text
			if str ~= "" and str ~= nil then
				WindowModule.setTextFromClipboard(str)
			end
		elseif key == "X" then
			local str = self.select_tmp_text
			if str ~= "" and str ~= nil then
				WindowModule.setTextFromClipboard(str)
				self:onDeleteText()
			end
		elseif key == "V" then
			local str  = WindowModule.getTextFromClipboard()
			local str1 = self:getString() .. str
			if str ~= "" then
				self:insertTextEx(str1)
			end
		end
	end
end
