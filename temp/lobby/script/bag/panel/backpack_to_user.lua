#remark
--[[
	道具使用对话框
]]

local ui_create = require "lobby.ui_create.ui_bag_user"

BackpackToUser = class("BackpackToUser",function ()
	local obj = cc.Layer:create()
	return obj
end)


--[[
	info = {
		use_call,
		use_call_param,
		close_call,
	}
]]
function BackpackToUser.create(info)
	local obj = BackpackToUser.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function BackpackToUser:init(info)
	self.create_info = info
	self:init_ui()
	self:registerEE()
	self:registerTouchEvent()
	self.num = 1
end

function BackpackToUser:init_ui()
	self.ui_lst = ui_create.create()
	self:addChild(self.ui_lst.root)
	self.ui_lst.IDInput:setInputTextMod(1)
	self.ui_lst.NumInput:setInputTextMod(1)
	self.ui_lst.IDInput:setInputMaxLen(8)
	self.ui_lst.NumInput:setInputMaxLen(3)
	self.ui_lst.NumInput:setString(1)
	self.ui_lst.NumInput:setTextChangeCall(function (txt)
		self:_on_Input_Text(txt)
	end)

	self.ui_lst.Button_19:onTouch(function (e) self:onUseClick(e) end)
	self.ui_lst.btnClose:onTouch(function (e) self:onCloseClick(e) end)
	self.ui_lst.btnUseMyself:onTouch(function (e) self:onUseMyself(e) end)
	self.ui_lst.btnUnAdd:onTouch(function (e) self:onSubtractNum(e) end)
	self.ui_lst.btnAdd:onTouch(function (e) self:onAddNum(e) end)

	--注册按钮高亮
	local mov_obj = cc.Sprite:create("lobby/resource/bag/sgzj2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.ui_lst.btnUseMyself,mov_obj,1)
	local mov_obj = cc.Sprite:create("lobby/resource/exchange/Reduction_2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.ui_lst.btnUnAdd,mov_obj,1)
	local mov_obj = cc.Sprite:create("lobby/resource/exchange/plus_2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.ui_lst.btnAdd,mov_obj,1)
	local mov_obj = cc.Sprite:create("lobby/resource/bag/shiyong2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.ui_lst.Button_19,mov_obj,1)
	local mov_obj = cc.Sprite:create("lobby/resource/button/gb2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.ui_lst.btnClose,mov_obj,1)
end

function BackpackToUser:registerEE()
	local function __enter_exit(e)
		if e == "enter" then
			self:onEnter()
		elseif e == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__enter_exit)
end

function BackpackToUser:onEnter()
	
end

function BackpackToUser:onExit()
	--WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_list.btnItem)
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_lst.btnUseMyself)
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_lst.btnUnAdd)
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_lst.btnAdd)
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_lst.Button_19)
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.ui_lst.btnClose)
end

function BackpackToUser:registerTouchEvent()
	local function _on_touch_began(touch, event) return true end
    local function _on_touch_move(touch, event) return true end
    local function _on_touch_end(touch, event) return true end
    
    local listener = cc.EventListenerTouchOneByOne:create()

    listener:setSwallowTouches(true)
    listener:registerScriptHandler(_on_touch_began,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(_on_touch_move,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(_on_touch_end,cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener,self)
end

function BackpackToUser:doModule(pos)
	self:setPosition(pos.x,pos.y)
	WindowScene.getInstance():showDlg(self)
end

function BackpackToUser:close()
	if self.create_info.close_call then
		self.create_info.close_call()
	end
	WindowScene.getInstance():closeDlg(self)
end

function BackpackToUser:onUseClick(e)
	if e.name == "ended" then
		global_music_ctrl.play_btn_one()
		if self.create_info.use_call then
			local user_id = string.trim(self.ui_lst.IDInput:getString())
			local use_num = string.trim(self.ui_lst.NumInput:getString())
			if user_id ~= nil and use_num ~= nil then
				if tonumber(use_num) > self:getCurItemMaxNum() then
					TipsManager:showOneButtonTipsPanel(525, {}, true)
				else
					self.create_info.use_call(tonumber(user_id),tonumber(use_num))
				end
			else
				TipsManager:showOneButtonTipsPanel(519, {}, true)
			end
		end
		self:close()
	end
end

function BackpackToUser:onCloseClick(e)
	if e.name == "ended" then
		self:close()
		global_music_ctrl.play_btn_one()
	end
end
--对自己使用
function BackpackToUser:onUseMyself(e)
	if e.name == "ended" then
		local pinfo = get_player_info()
		self.ui_lst.IDInput:setStringEx(pinfo.id)
		global_music_ctrl.play_btn_one()
	end
end
function BackpackToUser:_on_Input_Text(txt)
	if (text == nil) and (text == "") then
		text = 1
	else
		self.num = tonumber(txt)
	end
	if long_compare(self.num,self:getCurItemMaxNum()) >= 0 then  --超出数量限制
		self.num = self:getCurItemMaxNum()
	end
	if long_compare(self.num,1) <= 0 then  --小于数量限制
		self.num = 1
	end
	self:updateUi()
end
--加
function BackpackToUser:onAddNum(e)
	if e.name == "ended" then
		global_music_ctrl.play_btn_one()
		if self.num < self:getCurItemMaxNum() then
			self.num = self.num + 1
			self:updateUi()
			-- self.ui_lst.NumInput:setStringEx(self.num)
		end
	end
end
function BackpackToUser:onSubtractNum(e)
	if e.name == "ended" then
		global_music_ctrl.play_btn_one()
		if self.num > 1 then
			self.num = self.num - 1
			self:updateUi()
			-- self.ui_lst.NumInput:setStringEx(self.num)
		end
	end
end
--获取最大值
function BackpackToUser:getCurItemMaxNum()
	local num = 0
	local backpack_lst = get_player_info().backpack_list
	for k,v in pairs(backpack_lst) do
		if self.create_info.use_call_param == v.id then
			num = v.num
		end
	end
	return num
end
function BackpackToUser:updateUi()
	self.ui_lst.NumInput:setStringEx(self.num)
	self.ui_lst.btnAdd:setEnabled((self.num < self:getCurItemMaxNum()) and true or false)
	self.ui_lst.btnUnAdd:setEnabled((self.num > 1) and true or false)
end


