#remark

--[[
	每日福利
]]
local item_dis_w = 2
local item_dis_h = 5
local g_welfareMainDlg = nil
local ui_create = require "lobby.ui_create.ui_welfare"

WelfareMainDlg = class("WelfareMainDlg",function ()
	local obj = cc.Layer:create()
	return obj
end)

--[[
	info = {
		
	}
]]

function WelfareMainDlg.create(info)
	local obj = WelfareMainDlg.new()
	if obj then
		obj:init()
		obj:regEnterExit()
	end

	return obj
end

function WelfareMainDlg:getInstance()
	return g_welfareMainDlg
end
function WelfareMainDlg:init(info)
	self.create_info = info
	self:init_ui()
	self:registerTouchEvent()
	self:createItemLst()
	self:updateUi()
	g_welfareMainDlg = self
end

function WelfareMainDlg:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter();
		elseif event == "exit" then
			self:onExit();
		end
	end

	self:registerScriptHandler(_onEnterOrExit);
end

function WelfareMainDlg:onEnter()
	-- body
end

function WelfareMainDlg:onExit()
	-- body 
	g_welfareMainDlg = nil
end
function WelfareMainDlg:init_ui()
	--遮罩
	self.imgMask = ccui.ImageView:create()
	self.imgMask:loadTexture("lobby/resource/general/heidi.png")
	self.imgMask:setScale9Enabled(true)
	self:addChild(self.imgMask)
	local size = WindowModule.get_window_size()
	self.imgMask:setContentSize(cc.size(size.width, size.height))
	
	self.ui_lst = ui_create.create()
	self:addChild(self.ui_lst.root)
	self.ui_lst.ImgNo:setVisible(false)

	self.ItemList = {}
	self.ui_lst.btnClose:onTouch(function (e)
		if e.name == "ended" then
			self:close()
		end
	end)
end
function WelfareMainDlg:updateUi()
	local welfare_lst = get_player_info().welfares
	-- welfare_lst = {{id = 1, type = 0,param = nil,},{id = 2, type = 1,param = nil,},{id = 3, type = 0,param = nil,},{id = 4, type = 1,param = nil,},
	-- 	{id = 5, type = 0,param = nil,},{id = 6, type = 1,param = nil,},{id = 7, type = 0,param = nil,},{id = 8, type = 1,param = nil,},} --test data
	if table.nums(welfare_lst) > 0 then
		-- print("*****************福利1***************")
		-- dump(welfare_lst)
		-- print("*****************福利2***************")
		self:addListItem(welfare_lst)
	else
		self.ui_lst.ImgNo:setVisible(true)
	end
end
function WelfareMainDlg:createItemLst()
	--self.cur_lst_len  	= 0

	self.item_lst_obj = CSilderScroll.create()
	self.ui_lst.ImgWelfare:addChild(self.item_lst_obj)
	self.item_lst_obj:setPosition(10,20) --(26,24)

	self.item_lst_obj:init_sliderScroll(cc.size(465, 310),0)
	self.item_lst_obj:showHideSlider(false)

end

function WelfareMainDlg:addListItem(welfare_lst)
	self.item_lst_obj:removeAllObjects()
	self.ItemList = {}
	if welfare_lst and #welfare_lst > 0 then
		for k,v in pairs(welfare_lst) do
			local item_info = {
				type = v.type,
				num = v.num,
				params = v.params,
			}
			local item_obj = CwelfareItem.create(item_info)
			self.item_lst_obj:addObject(item_obj)
			self.ItemList[v.type] = item_obj
		end
	end	
end

function WelfareMainDlg:updateItem(itemId)
	for k,v in pairs(self.ItemList[id]) do
		if v.id == itemId then
			--
		end
	end
end

function WelfareMainDlg:registerTouchEvent()
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

function WelfareMainDlg:doModule(pos)
	self:setPosition(pos.x,pos.y)
	WindowScene.getInstance():showDlg(self)
end

function WelfareMainDlg:close()
	WindowScene.getInstance():closeDlg(self)
end



-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

