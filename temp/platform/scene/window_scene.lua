#remark
--窗口场景
local g_window = nil
local game_layer_order 		= 10
local show_dlg_layer_order  = 1000
local show_scroll_text_order = 1010


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。



local show_prop_animation_order = 10000 --道具全局播放效果order,最高

WindowScene = class("WindowScene",function ()
	-- body
	local obj = cc.Layer:create()

	
	return obj
end)

local input_mark_file_src  = "lobby/resource/general/insert_mark.png"
local default_textobj_mark = 0


local function _default_enter_key_call()
	
end


function WindowScene.getInstance()
	-- body
	if g_window == nil then
		g_window = WindowScene.new()
	end

	return g_window
end

local function win_create()
	-- body
	local obj = WindowScene.getInstance()
	if obj ~= nil then
		obj:init()
	end

	return obj
end

function WindowScene.scene()
	-- body
	local scene = cc.Scene:create()
	local obj = win_create()

	scene:addChild(obj)

	return scene
end

function WindowScene:init()
	-- body

	self:init_data()
	self:initWindow()
	self:regEnterExit()
	self:initUserUI()
	--self:registerBkFrCall()
end

function WindowScene:initWindow()
	-- body
	WindowModule.set_window_size(480,320,self.des_size.w,self.des_size.h)
	WindowModule.set_window_mod_no_des(self.cur_win_mod)
	WindowModule.set_virture_title_height(self.title_h)
	WindowModule.center_window()
end

function WindowScene:init_data()
	-- body
	self.cur_win_size = {w = 480,h = 320,}
	self.org_win_size = {w = 480,h = 320,}
	self.des_size = {w = CC_DESIGN_RESOLUTION.width,h = CC_DESIGN_RESOLUTION.height,}
	self.cur_win_mod  = 1
	self.title_h = 30
	self.is_reset_des  = false
	self.org_reset_des = false
	self.cur_mod_name = ""

	self.module_obj_lst = {}

	--文字输入光标
	self.mark_info = {}
	self.input_text_info_lst = {}
	self.cur_insert_focus 	 = 1
	self.front_char_lst 	 = {}

	self.dlg_lst = {}
	self.dlgName_lst = {}


	--鼠标移动事件处理
	self.btn_mouse_move_info_lst = {}

	--check button 组处理
	self.btn_group_info_lst = {}


	self.spr_text_mark_lst = {}
	self.cur_mark_key = 1

	self.old_enter_key_call_lst = {}

	self.open_url_lst = {}--url 列表
	self.open_url_second = 0.05
	self.open_url_second_add = 0
end

function WindowScene:regEnterExit()
	-- body
	local function __on_enter_exit(event)
		-- body
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__on_enter_exit)
end

function WindowScene:onEnter()
	-- body
	self:regUpdate()
	self:regTouch()
	self:setTouchEnabled(true)
	self:regMouseEvent()
end

function WindowScene:onExit()
	-- body
	self:unregUpdate()
end

function WindowScene:initUserUI()
	-- body
	self.game_layer = cc.Layer:create()
	self.game_layer:setLocalZOrder(game_layer_order)
	self:addChild(self.game_layer)

	self.show_dlg_layer = cc.Layer:create()
	self.show_dlg_layer:setLocalZOrder(show_dlg_layer_order)
	self:addChild(self.show_dlg_layer)

	self:createScrollText()
end

function WindowScene:clearDlgLst()
	-- body
	for k,v in pairs(self.dlg_lst) do
		v:removeFromParent()
	end
	self.dlg_lst = {}
	self.dlgName_lst = {}
end

function WindowScene:showHideDlgByName( className, enter_key_call )
	if self:getDlgByName(className) == nil then
		self:showDlgByName(className, enter_key_call)
	else
		self:closeDlgByName(className)
	end
end

function WindowScene:showDlgByName( className, enter_key_call )
	local funcStr = "return "..className..".create()"
	local panelObj = loadstring(funcStr)()
	self:showDlg(panelObj, enter_key_call)
	self.dlgName_lst[className] = panelObj

	local size = WindowModule.get_window_size()
	panelObj:setPosition(size.width/2,size.height/2)

	return panelObj
end

function WindowScene:getDlgByName( className )
	return self.dlgName_lst[className]
end

--dlg_obj 对话框对象 enter_key_call ENTER键的回调
function WindowScene:showDlg(dlg_obj,enter_key_call)
	-- body
	if dlg_obj and self.dlg_lst[dlg_obj] == nil then
		self.show_dlg_layer:addChild(dlg_obj)
		self.dlg_lst[dlg_obj] = dlg_obj

		if enter_key_call then
			self.old_enter_key_call_lst = WindowRegFun.select_enter_new_call(enter_key_call,"def_enter_key_call")
		else
			self.old_enter_key_call_lst = WindowRegFun.select_enter_new_call(_default_enter_key_call,"def_enter_key_call")
		end
	end
end

function WindowScene:closeDlgByName(className)
	self:closeDlg(self.dlgName_lst[className])
	self.dlgName_lst[className] = nil
end

function WindowScene:closeDlg(dlg_obj)
	for k,v in pairs(self.dlgName_lst) do
		if v == dlg_obj then
			self.dlgName_lst[k] = nil
			break
		end
	end


	if dlg_obj and self.dlg_lst[dlg_obj] then
		dlg_obj:removeFromParent()
		self.dlg_lst[dlg_obj] = nil
		WindowRegFun.set_enter_call_lst(self.old_enter_key_call_lst)
	end
end

function WindowScene:isHaveShowDlg()
	local len = 0
	for k,v in pairs(self.dlg_lst) do
		len = len + 1
	end

	if len > 0 then
		return true
	else
		return false
	end
end

function WindowScene:regTouch()
	-- body
	local function __on_touch_began(touch, event)
        local location = touch:getLocation()
        return self:onTouchBegan(location.x,location.y)
    end

    local function __on_touch_moved(touch,event)
        local location = touch:getLocation()
        return self:onTouchMoved(location.x,location.y)
    end

    local function __on_touch_ended(touch, event)
        local location = touch:getLocation()
        return self:onTouchEnded(location.x,location.y)
    end
    
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(__on_touch_began,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(__on_touch_moved,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(__on_touch_ended,cc.Handler.EVENT_TOUCH_ENDED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)
end

function WindowScene:regMouseEvent()
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

function WindowScene:regUpdate()
	-- body
	local function _update(dt) self:update(dt) end
	self:scheduleUpdateWithPriorityLua(_update,0)
end

function WindowScene:unregUpdate()
	-- body
	self:unscheduleUpdate()
end

function WindowScene:onTouchBegan(x,y)
	-- body
	return true
end

function WindowScene:onTouchMoved(x,y)
	-- body
	return true
end

function WindowScene:onTouchEnded(x,y)
	-- body
	return true
end

function WindowScene:update(dt)
	if #self.open_url_lst <= 0 then
		return true
	end

	if self.open_url_second_add >= self.open_url_second then
		if #self.open_url_lst > 0 then
			local url = self.open_url_lst[1]
			cc.Application:getInstance():openURL(url)
			table.remove(self.open_url_lst,1)
		end

		self.open_url_second_add = 0
	else
		self.open_url_second_add = self.open_url_second_add + dt
	end

	return true
end

function WindowScene:getCurModuleName()
	-- body
	return self.cur_mod_name
end

function WindowScene:getCurModuleData()
	return ModuleCfgMgr.get_module_cfg(self.cur_mod_name)
end

function WindowScene:replaceModuleByModuleName(name)
	-- body

	self:clearRegisterEvent()
	self:clearAllModuleObj()
	self:clearDlgLst()
	EditBoxEx.resetTabCtrData()


	cc.AnimationCache:destroyInstance()
	cc.SpriteFrameCache:getInstance():removeUnusedSpriteFrames()
	cc.Director:getInstance():getTextureCache():removeUnusedTextures()

	local mod_cfg = ModuleCfgMgr.get_module_cfg(name)

	if mod_cfg then
		local size = clone(mod_cfg.property.win_size)
		self.is_reset_des  = mod_cfg.property.is_reset_des
		self.org_reset_des = mod_cfg.property.is_reset_des
		self.cur_mod_name  = mod_cfg.property.name

		local new_win_size = WindowModule.adapt_screen(
			{width = size.w,height = size.h},
			mod_cfg.property.win_mod,
			{width = self.des_size.w,height = self.des_size.h,}
		)

		size.w = new_win_size.width
		size.h = new_win_size.height

		if mod_cfg.property.is_reset_des == true then
			print("reset des size >>>>>>>>>>>>>>>>>>>>")
			WindowModule.set_window_size(size.w,size.h,self.des_size.w,self.des_size.h)
		else
			WindowModule.set_window_size_no_des(size.w,size.h)
		end
		WindowModule.set_window_mod_no_des(mod_cfg.property.win_mod)
		WindowModule.center_window()

		if mod_cfg.property.title_h then
			self.title_h = mod_cfg.property.title_h
		end
		WindowModule.set_virture_title_height(self.title_h)

		WindowModule.show_window(enum_win_show_mod.mod_hide)

		self.cur_win_size = clone(size)
		self.cur_win_mod  = mod_cfg.property.win_mod

		self.org_win_size = clone(size)

		local s_x = self.cur_win_size.w/self.des_size.w
		local s_y = self.cur_win_size.h/self.des_size.h

		for k,v in pairs(mod_cfg.member) do
			local class_obj = ModuleObjMgr.get_module_class_by_name(v.class_name)
			if class_obj and class_obj.create then
				local obj = class_obj.create()
				if obj then
					self.module_obj_lst[v.class_name] = obj
					self.game_layer:addChild(obj)

					if v.pos then obj:setPosition(v.pos.x,v.pos.y) end
					if v.z_order then obj:setLocalZOrder(v.z_order) end
					if v.visible ~= nil then obj:setVisible(v.visible) end
					if obj.onSize then obj:onSize(self.cur_win_size.w,self.cur_win_size.h,s_x,s_y) end
				end
			end
		end

		self:updateScrollText() --更新跑马灯状态
		reset_music_config()--重置音频设置

		WindowModule.show_window(enum_win_show_mod.mod_show)
	end
end

function WindowScene:removeModuleObjByClassName(class_name)
	-- body
	if class_name then
		local class_obj = self.module_obj_lst[class_name]
		if class_obj then
			class_obj:setVisible(false)
			class_obj:removeFromParent()
			self.module_obj_lst[class_name] = nil
		end
	end
end

function WindowScene:clearAllModuleObj()
	-- body
	for k,v in pairs(self.module_obj_lst) do
		--v:setVisible(false)
		if v.destoryLoading then
			v:destoryLoading()
		end
		v:removeFromParent()
	end
	self.module_obj_lst = {}
end

function WindowScene:getModuleObjByClassName(class_name)
	-- body
	local obj = nil
	if class_name then
		obj = self.module_obj_lst[class_name]
	end

	return obj
end

function WindowScene:miniWindow()
	-- body
	WindowModule.show_window(enum_win_show_mod.mod_mini)
end

function WindowScene:sizeWindow(w,h)
	-- body
	if self.cur_win_mod == 2 then
		self.cur_win_mod = 1
		WindowModule.set_window_mod_no_des(self.cur_win_mod)
	end

	self.cur_win_size.w = w
	self.cur_win_size.h = h

	if w > self.des_size.w or h > self.des_size.h then
		WindowModule.set_window_size(w,h,self.des_size.w,self.des_size.h)--窗口大于设计分辨率
	else
		WindowModule.set_window_size_no_des(w,h)
	end

	local s_x = self.cur_win_size.w/self.des_size.w
	local s_y = self.cur_win_size.h/self.des_size.h
	
	for k,v in pairs(self.module_obj_lst) do
		if v.onSize then v:onSize(w,h,s_x,s_y) end
	end
end

function WindowScene:fullWindow(is_full)
	if is_full == true then
		if self.cur_win_mod == 2 then return end

		self.cur_win_mod = 2
		local full_h = WindowModule.get_screen_h()
		local full_w = WindowModule.get_screen_w()

		self.cur_win_size.w = full_w
		self.cur_win_size.h = full_h

		if full_w ~= self.des_size.w or full_h ~= self.des_size.h then 
			self.is_reset_des = true
		else
			self.is_reset_des = false
		end

		printf("sx = " .. full_w .. " , sy = " .. full_h)

		WindowModule.set_window_module(self.cur_win_mod,self.des_size.w,self.des_size.h)

		local s_x = full_w/self.des_size.w
		local s_y = full_h/self.des_size.h
		for k,v in pairs(self.module_obj_lst) do
			if v.onSize then v:onSize(full_w,full_h,s_x,s_y) end
		end
	elseif is_full == false then
		if self.cur_win_mod == 1 then return end

		self.cur_win_mod = 1
		WindowModule.set_window_mod_no_des(self.cur_win_mod)
		WindowModule.set_window_size(self.org_win_size.w,self.org_win_size.h,self.des_size.w,self.des_size.h)
		WindowModule.center_window()

		self.cur_win_size.w = self.org_win_size.w
		self.cur_win_size.h = self.org_win_size.h

		local s_x = self.cur_win_size.w/self.des_size.w
		local s_y = self.cur_win_size.h/self.des_size.h

		self.is_reset_des = self.org_reset_des

		for k,v in pairs(self.module_obj_lst) do
			if v.onSize then v:onSize(self.cur_win_size.w,self.cur_win_size.h,s_x,s_y) end
		end
	end
end

function WindowScene:getScaleSize()
	local s_x = self.cur_win_size.w/self.des_size.w
	local s_y = self.cur_win_size.h/self.des_size.h

	if (self.cur_win_mod == 2 and self.is_reset_des == false) or self.is_reset_des == false then
		s_x = 1
		s_y = 1
	end

	return {x = s_x,y = s_y,}
end

function WindowScene:closeWindow()
	WindowModule.close()
end

function WindowScene:getWindowSize()
	return self.cur_win_size
end

function WindowScene:getDesSize()
	return self.des_size
end

function WindowScene:getWindowModule()
	return self.cur_win_mod
end

function WindowScene:clearRegisterEvent()
	-- body
	self.btn_mouse_move_info_lst = {}
	self.btn_group_info_lst = {}

	self.input_text_info_lst = {}
end


--注册按钮鼠标移动效果 align_type = {0 or nil -> 居中，1，底对齐，2顶对齐，3左对齐，4右对齐}
--btn_type 按钮类型: nil or 1 -> button, 2 -> check button
--show_type 点击是否消失 nil->消失,1->不消失
function WindowScene:registerBtnMouseMoveEff(obj,move_eff_obj,btn_type,align_type,show_type,mov_call)
	-- body
	if obj and move_eff_obj then
		local info = {
			parent_obj 	= obj,
			eff_obj 	= move_eff_obj,
			btn_type 	= btn_type,
			align_type  = align_type,
            show_type = show_type,
            mcall = mov_call,
		}  
        --高亮图 水浒传有用
       info.parent_obj._moveOverSpr = move_eff_obj

		info.parent_obj:addChild(info.eff_obj)
		local function __on_mouse_eff_click(e)
			self:onMouseMoveEffClick(e)
		end
		info.parent_obj:onTouch(__on_mouse_eff_click)
		local size = info.parent_obj:getContentSize()
		local x = size.width/2
		local y = size.height/2
		if align_type == 1 then
			local move_size = info.eff_obj:getTextureRect()
			y = -move_size.height/2
		end
		info.eff_obj:setPosition(x,y)
		info.eff_obj:setVisible(false)


		self.btn_mouse_move_info_lst[info.parent_obj] = info
	end
end

function WindowScene:setBtnMoveEffState(btn_obj,bshow)
	if self.btn_mouse_move_info_lst[btn_obj] then
		local eff_obj = self.btn_mouse_move_info_lst[btn_obj].eff_obj
		eff_obj:setVisible(bshow)
	end
end

function WindowScene:getBtnMoveEffState(btn_obj)
	if self.btn_mouse_move_info_lst[btn_obj] then
		local eff_obj = self.btn_mouse_move_info_lst[btn_obj].eff_obj
		return eff_obj:isVisible()
	end

	return false
end

function WindowScene:unregisterBtnMouseMoveEff(obj)
	-- body
	if obj and  self.btn_mouse_move_info_lst[obj] ~= nil then 
		self.btn_mouse_move_info_lst[obj].eff_obj:removeFromParent()
		self.btn_mouse_move_info_lst[obj] = nil  
	end
end

function WindowScene:onMouseMoveEffClick(e)
	-- body
	local info = self.btn_mouse_move_info_lst[e.target]
	if info ~= nil and info.show_type == nil then
		if e.name == "began" then
			info.eff_obj:setVisible(false)
		elseif e.name == "ended" then
			info.eff_obj:setVisible(true)
		end
	end
end

--处理按钮鼠标移动过程
function WindowScene:dealBtnMovePro(e)
	-- body
	local pt = cc.Director:getInstance():convertToGL(e:getLocation())
	for i,v in pairs(self.btn_mouse_move_info_lst) do
        if v == nil or v.parent_obj == nil then
            return
        end
		if (v.parent_obj:hitTest(pt) == true and isVisibleFinal(v.parent_obj) == true) and (v.mcall == nil or (v.mcall ~= nil and v.mcall(e) == true)) then
			v.eff_obj:setVisible(true)
			--print("move selected !>>>>>>>>>>>>>>>>>>>>&&&&&&&&&&&&&")

			if v.btn_type == 2 and v.parent_obj:isSelected() == true then
				v.eff_obj:setVisible(false)
			end

			if v.parent_obj:isEnabled() == false then
				v.eff_obj:setVisible(false)
			end
		else
			v.eff_obj:setVisible(false)
		end
	end 
end


--鼠标移动事件处理
function WindowScene:onMouseMove(e)
	-- body
	self:dealBtnMovePro(e)
	
end

function WindowScene:onMouseDown(e)
	-- body
end

function WindowScene:onMouseUp(e)
	-- body
end

function WindowScene:registerGroupEvent(obj_lst,call_back)
	-- body
	for k,v in pairs(obj_lst) do
		self.btn_group_info_lst[v] = {call = call_back,mutex = obj_lst,}
		local function __on_group_deal_pro(e)
			self:onGroupDealPro(e.target,e.name)
		end
		v:onEvent(__on_group_deal_pro)
	end
end

function WindowScene:unregisterGroupEvent(obj_lst)
	-- body
	for k,v in pairs(obj_lst) do
		self.btn_group_info_lst[v] = nil
	end
end


function WindowScene:onGroupDealPro(sender,name)
	if self.btn_group_info_lst[sender] == nil then
		return
	end

	for k,v in pairs(self.btn_group_info_lst[sender].mutex) do
		if sender ~= v then
			v:setEnabled(true)
			v:setSelected(false)
			v:setBright(true)
		else
			v:setEnabled(false)
			v:setSelected(true)
		end
	end

	--回调函数最后处理
	local func = self.btn_group_info_lst[sender].call
	if func then 
		func(sender,name) 
		return
	end
end



--[[
	滚动文字 功能区
]]
function WindowScene:createScrollText()

	self.scroll_txt_list = {}

	self.scroll_txt_obj = cc.Layer:create()
	self.scroll_txt_obj:setLocalZOrder(show_dlg_layer_order)
    self.scroll_txt_obj:addTo(self)

	local msg = {content = "中华人民共和国万岁",type = 1 , noticeid = 110}

	table.insert(self.scroll_txt_list,msg)

	--Create Notice_Frame
	local Notice_Frame = ccui.Layout:create()
	Notice_Frame:ignoreContentAdaptWithSize(false)
	Notice_Frame:setClippingEnabled(true)
	Notice_Frame:setBackGroundColorOpacity(102)
	Notice_Frame:setLayoutComponentEnabled(true)
	Notice_Frame:setName("Notice_Frame")
	Notice_Frame:setCascadeColorEnabled(true)
	Notice_Frame:setCascadeOpacityEnabled(true)
	Notice_Frame:setPosition(960.0000, 540.0000)
	layout = ccui.LayoutComponent:bindLayoutComponent(Notice_Frame)
	layout:setSize({width = 926.0000, height = 58.0000})
	layout:setRightMargin(-200.0000)
	layout:setTopMargin(-50.0000)
	self.scroll_txt_obj:addChild(Notice_Frame)

	--Create Text_Content
	local Text_Content = ccui.Text:create()
	Text_Content:ignoreContentAdaptWithSize(true)
	Text_Content:setTextAreaSize({width = 0, height = 0})
	Text_Content:setFontSize(30)
	Text_Content:setString("")
	Text_Content:setLayoutComponentEnabled(true)
	Text_Content:setName("Text_Content")
	Text_Content:setTag(0)
	Text_Content:setCascadeColorEnabled(true)
	Text_Content:setCascadeOpacityEnabled(true)
	Text_Content:setAnchorPoint(0.0000, 0.5000)
	Text_Content:setPosition(1.0000, 29.0000)
	Text_Content:setTextColor({r = 255, g = 0, b = 0})
	layout = ccui.LayoutComponent:bindLayoutComponent(Text_Content)
	layout:setPositionPercentXEnabled(true)
	layout:setPositionPercentYEnabled(true)
	layout:setPositionPercentX(0.2000)
	layout:setPositionPercentY(0.5000)
	layout:setPercentWidth(0.5000)
	layout:setPercentHeight(0.4000)
	layout:setSize({width = 100.0000, height = 1.0000})
	layout:setLeftMargin(-10.0000)
	layout:setRightMargin(110.0000)
	layout:setTopMargin(15.0000)
	layout:setBottomMargin(15.0000)
	Notice_Frame:addChild(Text_Content)

	self.scroll_txt_content = Text_Content

	self.scroll_txt_obj:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.01),cc.CallFunc:create(function()

    	local lobby_obj = WindowScene.getInstance():getModuleObjByClassName("CGameLobby") --判断是否在大厅
		if lobby_obj then 

			Notice_Frame:setContentSize(scroll_text_pos_cfg["大厅"].size)
			Notice_Frame:setPosition(scroll_text_pos_cfg["大厅"].pos)
			Notice_Frame:setBackGroundImage(scroll_text_pos_cfg["大厅"].res,0)

			if Text_Content:getTag()==0 then
				 --Notice_Frame:setVisible(scroll_text_pos_cfg["大厅"].overVisible)
			end
		
		else
			Notice_Frame:setContentSize(scroll_text_pos_cfg["游戏"].size)
			Notice_Frame:setPosition(scroll_text_pos_cfg["游戏"].pos)
			Notice_Frame:setBackGroundImage(scroll_text_pos_cfg["游戏"].res,0)

			if Text_Content:getTag()==0 then
				--Notice_Frame:setVisible(scroll_text_pos_cfg["游戏"].overVisible)
		   end

		end

		if Text_Content:getPositionX()<-Text_Content:getContentSize().width then

			Text_Content:setPositionX(Notice_Frame:getContentSize().width+4)
			Text_Content:setPositionY(Notice_Frame:getContentSize().height/2)

            local txtCount = #self.scroll_txt_list
            if txtCount==0 then
				Text_Content:setString("")
				Text_Content:setTag(0)
			else
				local msgget = self.scroll_txt_list[1]
				Text_Content:setString(msgget.content)
                Text_Content:setTag(tonumber(msgget.noticeid))

                table.remove(self.scroll_txt_list,1)
			end
		else
            local pos = Text_Content:getPositionX()
			Text_Content:setPositionX(Text_Content:getPositionX()-2)
		end

	end))))
end

function WindowScene:instertScrollText(info)

	table.insert(self.scroll_txt_list,info)
	if self.scroll_txt_content and 0 == self.scroll_txt_content:getTag() then
		self.scroll_txt_content:setContentSize(1,self.scroll_txt_content:getContentSize().height)
        self.scroll_txt_content:setPositionX(-1)
	end
end

function WindowScene:setScrollTextShow(bshow,bstop)

end

function WindowScene:updateScrollText()

	local login_obj = WindowScene.getInstance():getModuleObjByClassName("CLoginScene") --判断是否在登陆界面
	if login_obj then
		print("clear all scroll text")
        self.scroll_txt_list = {}
		self.scroll_txt_content:setString("")
		return
	end
end



--[[
	道具全局动画播放功能区
]]
function WindowScene:createPropAnimationLayer()

	print("create prop animation player layer >>>>>>>>>>>>>>>>")
	local player_prop_layer = cc.Layer:create()
	player_prop_layer:setPosition(0,0)
	player_prop_layer:setLocalZOrder(show_prop_animation_order)
	self:addChild(player_prop_layer)

	local function _on_prop_layer_began(t,e) return true end
    local function _on_prop_layer_move(t,e) return true end
    local function _on_prop_layer_ended(t,e) return true end
    
    local ls = cc.EventListenerTouchOneByOne:create()
    ls:setSwallowTouches(true)
    ls:registerScriptHandler(_on_prop_layer_began,cc.Handler.EVENT_TOUCH_BEGAN)
    ls:registerScriptHandler(_on_prop_layer_move,cc.Handler.EVENT_TOUCH_MOVED)
    ls:registerScriptHandler(_on_prop_layer_ended,cc.Handler.EVENT_TOUCH_ENDED)
	player_prop_layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(ls,player_prop_layer)

	return player_prop_layer
end


function WindowScene:playPropAni(prop_id, callback)
	if prop_id then
		local data = {}
		local eff_key 	 = item_src_config[prop_id].eff_key
		local eff_cfg_tb = item_effect_config[eff_key]

		local pos = {x = 0,y = 0,}
		local module_tb = ModuleCfgMgr.get_module_cfg(self.cur_mod_name)

		if module_tb then
			pos.x = module_tb.property.win_size.w/2
			pos.y = module_tb.property.win_size.h/2
		end

		if eff_cfg_tb then
			data.file 	= eff_cfg_tb.file
			data.pattern = eff_cfg_tb.pattern
			data.ft 	= eff_cfg_tb.ft
			data.fs 	= eff_cfg_tb.fs
			data.loop 	= eff_cfg_tb.loop
			data.pos 	= pos
			local player_obj = self:createPropAnimationLayer()
			local function end_call()
				player_obj:removeFromParent()
				player_obj = nil

				if callback then
					callback()
				end
			end
			animationUtils.dyanplayAnimation(player_obj,data,end_call)
		end
	end
end




--[[
	游戏下载，更新，加载功能区
]]

--加载游戏
function WindowScene:loadGame(game_index)

	print(string.format("WindowScene:loadGame(%d)",game_index))
	-- print(table_to_str(game_config));
	local game_item = game_config[game_index]

	print(game_item.init_file)

	if is_inner_ver() == true then
		require(game_item.init_file)
		HallManager:reqEnterCurGame(game_index)

		return true
	end

	
	if game_item then
		local bload_success = true
		for k,v in pairs(game_item.pkg_lst) do
			print("*********"..v.dec_fext.."***********")
			local lret = CGamePackge:getInstance():LoadPackge(v.pkg_file,v.dec_fext)
			if lret < 0 then
				bload_success = false
				print("load game packge failed !")
				break
			end
		end
		if bload_success == true then
			require(game_item.init_file)
			HallManager:reqEnterCurGame(game_index)
			GameUpdateStateRec.setUpdateState(game_index,true)
			
			return true
		end 
	end

	return false
end

function WindowScene:openurl(url)
	if url and type(url) == "string" then
		table.insert(self.open_url_lst,url)
	end
end



--[[
	程序前后台处理逻辑
]]

local have_exit_game = false
function WindowScene.bk_fr_call(arg)
	if arg == 1 then --background
		print("game program is background >>>>>>>>>>>>>>>>>>>>")
		local login_obj = WindowScene.getInstance():getModuleObjByClassName("CLoginScene")
		local lobby_obj = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
		if login_obj == nil and lobby_obj == nil and have_exit_game == false then
			HallManager:reqExitCurGameTable()
			HallManager:reqExitCurGameRoom()
			have_exit_game = true
			print("send exit game message >>>>>>>>>>>>>>>>>>>>>>>>>>")
		end
	elseif arg == 2 then --forceground
		print("game program is forceground >>>>>>>>>>>>>>>>>>>>")
		have_exit_game = false
	end
end

function WindowScene:registerBkFrCall()
	CTools:registerMinMaxCallPro(WindowScene.bk_fr_call)
end


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
