--[[
庄家信息
]]

local panel_ui = require "game.shark_std.script.ui_create.ui_banker_node"


CSharkBankerExt = class("CSharkBankerExt",function()
	-- body
	local  ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:setAnchorPoint(0, 0)
	return ret
end)


function CSharkBankerExt.create()
	-- body
	local node = CSharkBankerExt.new()
	if node ~= nil then
		node:init_ui()
		node:regEnterExit()
		return node
	end
end


function CSharkBankerExt:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter();
		elseif event == "exit" then
			self:onExit();
		end
	end

	self:registerScriptHandler(_onEnterOrExit)
end

function CSharkBankerExt:onEnter()
   
end

function CSharkBankerExt:onExit()
	
end

function CSharkBankerExt:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)

	self:registerHandler()
	-- self:addButtonHightLight()

	-- for i=1,7 do
	-- 	local key = "labName"..i
	-- 	self.panel_ui[key]:setVisible(false)
	-- 	key = "labChips"..i
	-- 	self.panel_ui[key]:setVisible(false)
	-- end

	--玩家列表
	self._playerInfoList = {}
end

function CSharkBankerExt:registerHandler()
	self.panel_ui.btnRequest:onTouch(function (e)
		if e.name == "ended" then
			send_shark_ReqApplyBanker()
		end
	end)

	self.panel_ui.btnCancelRequest:onTouch(function (e)
		if e.name == "ended" then
			send_shark_ReqCancelApplyBanker()
		end
	end)

	self.panel_ui.btnBeUnBanker:onTouch(function (e)
		if e.name == "ended" then
			send_shark_ReqOffBanker()
		end
	end)
end

function CSharkBankerExt:hideUnBankerButton()
	self.panel_ui.btnBeUnBanker:setEnabled(false)
	self.panel_ui.btnBeUnBanker:setBright(false)
end

function CSharkBankerExt:addButtonHightLight()
	local btnArr = {self.panel_ui.btnRequest, self.panel_ui.btnCancelRequest, 
				self.panel_ui.btnBeUnBanker,}

	local resArr = {"申请上庄高亮", "取消申请高亮",
					"申请下庄高亮",}

	for i,btn in ipairs(btnArr) do
		local mov_obj = cc.Sprite:create(shark_imgRes_config[resArr[i]].resPath)
		WindowScene.getInstance():registerBtnMouseMoveEff(btn,mov_obj,1)
	end
end

--设置庄家信息
function CSharkBankerExt:setBankerInfo( info )
	-- 头像
	--if shark_manager._bankerID == "0" then
	--	uiUtils:setPhonePlayerHead(self.panel_ui.sprBankerHead, 2, uiUtils.HEAD_SIZE_223)
	--else
	--	local sex = get_player_info().sex == "男" and 0 or 1
		uiUtils:setPhonePlayerHead(self.panel_ui.sprBankerHead, info.sex, uiUtils.HEAD_SIZE_223)
	--end
	self.panel_ui.labBankerName:setString(info.name)
	self.panel_ui.labBankerChips:setString(info.chips)
	self.panel_ui.labBankerTime:setString(info.num)
	self.panel_ui.labBankerWin:setString(info.score)

	self:setButtonShow()
end

--设置申请玩家
function CSharkBankerExt:setApplyPlayers( infolist )
	-- for i=1,7 do
	-- 	local key1 = "labName"..i
	-- 	local key2 = "labChips"..i
	-- 	local v = infolist[i]
	-- 	if v then
	-- 		self.panel_ui[key1]:setString(v.playerName)
	-- 		self.panel_ui[key1]:setVisible(true)
	-- 		self.panel_ui[key2]:setString(v.chips)
	-- 		self.panel_ui[key2]:setVisible(true)
	-- 	else
	-- 		self.panel_ui[key1]:setVisible(false)
	-- 		self.panel_ui[key2]:setVisible(false)
	-- 	end
	-- end
	local nums = table.nums(infolist)
	self.panel_ui.ruquestNumber:setString(nums)

    self._playerInfoList = infolist

    self:setButtonShow()
end

--设置按钮显示
function CSharkBankerExt:setButtonShow()
	--判断庄家 以及 列表中是否有自己
	local playerInfo = get_player_info()
	if long_compare(playerInfo.id, shark_manager._bankerID) == 0 then
		self.panel_ui.btnRequest:setVisible(false)
		self.panel_ui.btnCancelRequest:setVisible(false)
		self.panel_ui.btnBeUnBanker:setVisible(true)
		self.panel_ui.btnBeUnBanker:setEnabled(true)
		self.panel_ui.btnBeUnBanker:setBright(true)
	else
		local isInList = false
		for i,v in ipairs(self._playerInfoList) do
			if long_compare(v.playerId, playerInfo.id) == 0 then
				isInList = true
				break
			end
		end

		if isInList then
			self.panel_ui.btnRequest:setVisible(false)
			self.panel_ui.btnCancelRequest:setVisible(true)
			self.panel_ui.btnBeUnBanker:setVisible(false)
		else
			self.panel_ui.btnRequest:setVisible(true)
			self.panel_ui.btnCancelRequest:setVisible(false)
			self.panel_ui.btnBeUnBanker:setVisible(false)
		end
	end
	self.panel_ui.btnRequest:setVisible(false)
	self.panel_ui.btnCancelRequest:setVisible(false)
	self.panel_ui.btnBeUnBanker:setVisible(false)
end