
-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

#remark
--[[
标题栏
]]

local panel_ui = require "lobby.ui_create.ui_tableTitle"

CTableTitleExt = class("CTableTitleExt", function ()
	local  ret = cc.Node:create()
	return ret
end)
ModuleObjMgr.add_module_obj(CTableTitleExt,"CTableTitleExt")

function CTableTitleExt.create()
	local node = CTableTitleExt.new()
	if node then
		node:init_ui()
		return node
	end
end

function CTableTitleExt:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	local data = game_config[get_player_info().curGameID]
	if data.id == 1 then--比赛
		self.panel_ui.textTitle:setString(data.name)
	else
		local room, roomsData = get_player_info():get_cur_roomInfo()
		local tableid = get_player_info().myTableId % 10000

		if roomsData then
			local addressStr = data.name.."-"..roomsData.typeName.."-"..tableid.."桌"
			self.panel_ui.textTitle:setString(addressStr)
		end
	end
	

	self:registerHandler()

	self.is_full_screen = false
end

function CTableTitleExt:registerHandler()
	-- self.panel_ui.btnBank:onTouch(function (e)
	-- 	if e.name == "ended" then
	-- 		TipsManager:showSafeBoxPanel()
	-- 	end
	-- end)
	self.panel_ui.btnHelp:onTouch(function (e)
		if e.name == "ended" then
			local _playerInfo = get_player_info()
			WindowScene.getInstance():openurl(game_rule_config[_playerInfo.curGameID].address)
		end
	end)
	self.panel_ui.btnSet:onTouch(function (e)
		if e.name == "ended" then
			local _playerInfo = get_player_info()
			TipsManager:showGameSetPanel(_playerInfo.curGameID)
		end
	end)
	self.panel_ui.btnSmall:onTouch(function (e)
		if e.name == "ended" then
			WindowModule.show_window(enum_win_show_mod.mod_mini)
		end
	end)
	self.panel_ui.btnClose:onTouch(function (e)
		if e.name == "ended" then
			if self.closeFunc then
				self.closeFunc()
			end
		end
	end)	

	self.panel_ui.btnBiggest:onTouch(function (e)
		if e.name == "ended" then
			self.is_full_screen = not self.is_full_screen
			WindowScene.getInstance():fullWindow(self.is_full_screen)
		end
	end)
end

function CTableTitleExt:setCloseFunc(func)
	self.closeFunc = func
end