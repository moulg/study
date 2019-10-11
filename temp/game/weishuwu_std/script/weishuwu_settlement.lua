--[[
魏蜀吴结算面板
]]


local panel_ui = require "game.weishuwu_std.script.ui_create.ui_weishuwu_settlement"

CWeishuwuSettlement= class("CWeishuwuSettlement", function ()
	local ret = cc.Node:create()	
	return ret
end)


function CWeishuwuSettlement.create()
	local node = CWeishuwuSettlement.new()
	if node ~= nil then
		-- node:initData()
		node:init_ui()
		return node
	end
end
function CWeishuwuSettlement:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(960,580)
	self.panel_ui.root:setAnchorPoint(0.5,0)
	self.panel_ui.ImgBg:setVisible(false)
	self.fntMyList = {self.panel_ui.FtnMy1,self.panel_ui.FtnMy2,self.panel_ui.FtnMy3,
					self.panel_ui.FtnMy4,self.panel_ui.FtnMy5,self.panel_ui.FtnMy6,
					self.panel_ui.FtnMy7,self.panel_ui.FtnMy8,self.panel_ui.FtnMy9,}
	for k,v in pairs(self.fntMyList) do
		v:setString("0")
	end
	self.panel_ui.FntTotal:setString("")
end

function CWeishuwuSettlement:resetGame()
	-- body
	for k,v in pairs(self.fntMyList) do
		v:setString("0")
	end
	self.panel_ui.FntTotal:setString("")
end
function CWeishuwuSettlement:balance(list)
	-- dump(weishuwu_manager._bankerInfo.playerId)
	-- dump(get_player_info().id)
	local  multiple = {12,12,2,9,2,3,1.53,2.45,3}
	local playerTotalChips = 0
	for area = 0,8 do	
		if weishuwu_manager.curBetChipsMap[area] ~= nil then		
			self.fntMyList[area+1]:setString("-"..weishuwu_manager.curBetChipsMap[area])
			playerTotalChips = playerTotalChips + weishuwu_manager.curBetChipsMap[area]
		elseif  long_compare(weishuwu_manager.totalBetChipsMap[area],0) > 0 and weishuwu_manager._bankerInfo.playerId == get_player_info().id then
			print("玩家是庄家")
			self.fntMyList[area+1]:setString("+"..weishuwu_manager.totalBetChipsMap[area])
			-- playerTotalChips = playerTotalChips + weishuwu_manager.curBetChipsMap[area]
		end
	end
	for k,v in pairs(list) do	
		if weishuwu_manager.curBetChipsMap[v] ~= nil then
		-- dump(weishuwu_manager.curBetChipsMap[v]*(multiple[v+1]-1))						
			self.fntMyList[v+1]:setString("+"..math.floor(weishuwu_manager.curBetChipsMap[v]*(multiple[v+1]-1)))	
		elseif  long_compare(weishuwu_manager.totalBetChipsMap[v],0) > 0 and weishuwu_manager._bankerInfo.playerId == get_player_info().id then
			self.fntMyList[v+1]:setString("-"..math.floor(weishuwu_manager.totalBetChipsMap[v]*(multiple[v+1]-1)))
		end
	end
	
	--玩家筹码变化

	if self.panel_ui.FntTotal ~= nil then
		local playerStr = long_minus(weishuwu_manager.chipsChange,playerTotalChips)
		if long_compare(playerStr, 0) >= 0 then
			self.panel_ui.FntTotal:setString("+"..playerStr)
		else
			self.panel_ui.FntTotal:setString(playerStr)
		end

		local member = HallManager._members[get_player_info().id]
		-- if long_compare(playerStr, 0) >= 0 then
		-- 	audio_manager:playOtherSound(6, false)
		-- else
		-- 	audio_manager:playOtherSound(7, false)
		-- end
	end
end