#remark
--[[
	发送喇叭
]]
-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

local ui_create = require "lobby.ui_create.ui_horm"

CSendHorm = class("CSendHorm",function ()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")
    return ret
end)

function CSendHorm.create()
	local obj = CSendHorm.new()
	if obj then
		obj:init()
	end

	return obj
end

function CSendHorm:init()
	self:init_ui()
	self:registerEE()
end

function CSendHorm:init_ui()
	self.ui_lst = ui_create.create()
	self:addChild(self.ui_lst.root)
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))
	self.ui_lst.root:setPosition(size.width/2, size.height/2)
	
	local itemInfo = back_pack_manager:getItemInfo( 151 )
	self.ui_lst.textSurplusNum:setString(itemInfo.num)

	self.ui_lst.btnSure:onTouch(function (e)
		self:onSendClick(e)
	end)

	self.ui_lst.btnClose:onTouch(function (e)
		if e.name == "ended" then 
			self:close() 
		end
	end)
end

function CSendHorm:registerEE()
	local function __enter_exit(e)
		if e == "enter" then
			self:onEnter()
		elseif e == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__enter_exit)
end

function CSendHorm:onEnter()
	
end

function CSendHorm:onExit()

end

function CSendHorm:close()
	WindowScene.getInstance():closeDlg(self)
end

function CSendHorm:onSendClick(e)
	if e.name == "ended" then
		global_music_ctrl.play_btn_one()
		local str = self.ui_lst.inputHorm:getString()
		local asy_ret = ansy_string(str)
		local wide_len = 0
		for k,v in pairs(asy_ret.ch_lst) do
			 wide_len = wide_len + v.wide_len 
		end
		
		if wide_len == 0 then
			return
		elseif wide_len > 50 then
			TipsManager:showOneButtonTipsPanel(526, {}, true)
		else
			local pinfo = get_player_info()
			local obj_cont = {text = str,color = "白",}
			local str_cont = json.encode(obj_cont)
			local msg = {itemId = 151,
						 num = 1,
						 target = pinfo.id,
						 remark = str_cont,
				}
			send_backpack_ReqUseItem(msg)
			self:close()
		end
	end
end


