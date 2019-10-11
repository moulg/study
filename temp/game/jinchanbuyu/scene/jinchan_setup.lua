
--[[
	jinchan bu yu setup ui
]]

local __setup_ui_create = require "game.jinchanbuyu.ui.ui_setUp"

JinchanSetup = class("JinchanSetup",function ()
	return cc.Node:create()
end)

function JinchanSetup.create()
	local obj = JinchanSetup.new()
	if obj then
		obj:init()
	end

	return obj
end

function JinchanSetup:init()
	self:setLocalZOrder(3300000)

	
	self.ui_lst = __setup_ui_create.create()
	self:addChild(self.ui_lst.root)

	local des_size = WindowScene.getInstance():getDesSize()
	self.img_size  = self.ui_lst.ImgPanelBj:getContentSize()

	self:setPosition(des_size.w,des_size.h/2)


	self:registerEvent()
end


function JinchanSetup:registerEvent()
	self.ui_lst.CheckBox_Set:onEvent(function (e)
		self:onLook(e)
	end)


	self.ui_lst.btnSet:onTouch(function (e)
		if e.name == "ended" then
			self:onSet()
		end
	end)

	self.ui_lst.btnHelp:onTouch(function (e)
		if e.name == "ended" then
			self:onHelp()
		end
	end)

	self.ui_lst.btnOut:onTouch(function (e)
		if e.name == "ended" then
			self:onExit()
		end
	end)

	self.ui_lst.btnPs:onTouch(function (e)
		if e.name == "ended" then
			self:onGraphicSet()
		end
	end)
end

function JinchanSetup:onLook(e)
	if e.name == "selected" then
		self.ui_lst.root:runAction(cc.MoveBy:create(0.3,cc.p(-self.img_size.width,0)))
	elseif e.name == "unselected" then
		self.ui_lst.root:runAction(cc.MoveBy:create(0.3,cc.p(self.img_size.width,0)))
	end
end

function JinchanSetup:onHelp()
	self.ui_lst.CheckBox_Set:setSelected(false)
	self.ui_lst.root:runAction(cc.MoveBy:create(0.1,cc.p(self.img_size.width,0)))


	local help_obj = JinchanHelp.create()
	WindowScene.getInstance():showDlg(help_obj)
end

function JinchanSetup:onExit()
	HallManager:reqExitCurGameTable()
	HallManager:reqExitCurGameRoom()
end

function JinchanSetup:onSet()
	self.ui_lst.CheckBox_Set:setSelected(false)
	self.ui_lst.root:runAction(cc.MoveBy:create(0.1,cc.p(self.img_size.width,0)))

	local gameid = get_player_info().curGameID
	if gameid ~= nil then
		WindowScene.getInstance():showDlgByName("CHallSet")
	end
end

function JinchanSetup:onGraphicSet()
	self.ui_lst.CheckBox_Set:setSelected(false)
	self.ui_lst.root:runAction(cc.MoveBy:create(0.1,cc.p(self.img_size.width,0)))

	local gset_obj = JinchanGraphicSet.create()
	WindowScene.getInstance():showDlg(gset_obj)
end

