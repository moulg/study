--[[

水浒传 管理类
]]

shuihu_manager = {}

--行数
shuihu_manager.ROW_NUM = 3
--列数
shuihu_manager.COL_NUM = 5

--小玛丽次数
shuihu_manager._xiaoMaLiCount = 0

--全盘奖种类
shuihu_manager._quanPanRewardType = nil

--奖励类型
--全盘
shuihu_manager.QUAN_PAN = 1
--三联
shuihu_manager.SAN_LIAN = 2
--四联
shuihu_manager.SI_LIAN = 3
--五连
shuihu_manager.WU_LIAN = 4

--拥有筹码
shuihu_manager._ownChips = "0"
--总押注
shuihu_manager._totalBetChips = "0"
--押线数
shuihu_manager._lineNum = 0
--单线押注
shuihu_manager._singleBetChips = "0"

--游戏是否进行中
shuihu_manager._gameIsGoing = false

--是否自动开始游戏
shuihu_manager._isAutoPlayGame = false

--挂机次数
shuihu_manager._autoCount = 0
--比倍次数
shuihu_manager._compareCount = 0
--比倍类型 0 半比  1 全比  2 双比
shuihu_manager._compareType = 0

shuihu_manager.COMPARE_TYPE_HALF = 0
shuihu_manager.COMPARE_TYPE_ALL = 1
shuihu_manager.COMPARE_TYPE_DOUBEL = 2
--小于0:小,0:和,大于0:大
shuihu_manager._betType = 0

shuihu_manager.BET_TYPE_XIAO = -1
shuihu_manager.BET_TYPE_HE = 0
shuihu_manager.BET_TYPE_DA = 1

--单注赢上限值
shuihu_manager._singleWinLimit = "0"
--是否有单注赢取上限
shuihu_manager._isLimitSingleWin = false
--总体赢取上限值
shuihu_manager._totalWinLimit = "0"
--是否有总体赢取上限
shuihu_manager._isLimitTotalWin = false
--筹码不足是否自动兑换
shuihu_manager._isAutoExchange = false

--当前局 赢的筹码  （包含 水浒传 比倍 和  小玛丽  的输赢）
shuihu_manager._curWinChips = "0"
--所有局 总共赢取的筹码
shuihu_manager._totalWinChips = "0"

--摇骰子输赢
shuihu_manager._shakeDiceWin = false

--小玛丽内部最终图标
shuihu_manager._insideIcons = nil
--小玛丽外部最终图标id
shuihu_manager._outsideIconId = 0

--小玛丽 当前单把赢
shuihu_manager._littleMarieCurWin = "0"
--水浒传 当前单把赢
shuihu_manager._shuiHuCurWin = "0"
--比倍 当前单把赢
shuihu_manager._diceCurWin = "0"

--是否是被T出
shuihu_manager._isForcedOut = false




--开启/关闭 空格快捷键
function shuihu_manager:openCloseSpaceKeyboard( enable )
	local callback = function (s)
        local isEnable = long_compare(shuihu_manager._totalBetChips, shuihu_manager._ownChips) <= 0 and long_compare(shuihu_manager._totalBetChips, 0) > 0
		if s == "space" and self._gameIsGoing == false and self._isAutoPlayGame == false and isEnable then
			local game_shuihu = WindowScene.getInstance():getModuleObjByClassName("CShuiHuMainScene")
			if game_shuihu then
				game_shuihu:quickStartGame()
			end
		end
	end

	if enable then
		WindowRegFun.reg_key_up_call(callback, self)
	else
		WindowRegFun.unreg_key_up_call(self)
	end
end

--显示跳转动画
function shuihu_manager:showReplacePanelAnimation( callback )
	local game_shuihu = WindowScene.getInstance():getModuleObjByClassName("CShuiHuMainScene")
	if game_shuihu == nil then
		return
	end

	local size = WindowModule.get_window_size()

	local spr1 = cc.Sprite:create("game/shuihu_std/resource/image/flag_left.png")
	game_shuihu.shuihu_ui.panelContent:addChild(spr1,5)
	spr1:setAnchorPoint(1,0.5)
	spr1:setPosition(0, size.height/2)
	local spr2 = cc.Sprite:create("game/shuihu_std/resource/image/flag_right.png")
	game_shuihu.shuihu_ui.panelContent:addChild(spr2,5)
	spr2:setAnchorPoint(0,0.5)
	spr2:setPosition(size.width, size.height/2)

	local tmpCallBack = function ()
		spr1:stopAllActions()
		spr1:removeFromParent()
		spr2:stopAllActions()
		spr2:removeFromParent()

		callback()
	end


	local params = {}
	params.endPos_x = size.width + spr1:getContentSize().width
	params.endPos_y = size.height/2
	params.flyendCallback = tmpCallBack
	CFlyAction:Fly(spr1, 1, params, CFlyAction.FLY_TYPE_NORMAL)

	local params = {}
	params.endPos_x =  - spr2:getContentSize().width
	params.endPos_y = size.height/2
	CFlyAction:Fly(spr2, 1, params, CFlyAction.FLY_TYPE_NORMAL)
end

--开始退桌倒计时
function shuihu_manager:startExitTableTimeDown()
	timeUtils:addTimeDown(self, 120, nil, function ()
		send_shuihu_ReqExitTable()
		shuihu_manager._isForcedOut = true
	end)
end

--结束退桌倒计时
function shuihu_manager:removeExitTableTimeDown()
	timeUtils:remove(self)
end

--显示水浒传文字提示
--[[
	1--显示下注提示
	2--显示开始提示
	3--显示好运提示
	4--显示赢钱提示
	5--显示请比倍提示
]]
function shuihu_manager:showWordTips( type )
	local game_shuihu = WindowScene.getInstance():getModuleObjByClassName("CShuiHuMainScene")
	if game_shuihu then
		if type == 1 then
			game_shuihu:showBetTips()
		elseif type == 2 then
			game_shuihu:showStartTips()
		elseif type == 3 then
			game_shuihu:showGoodLuckTips()
		elseif type == 4 then
			game_shuihu:showWiningTips()
		elseif type == 5 then
			game_shuihu:showCompareTips()
		end
	end	
end

--继续水浒传游戏   判断为挂机调用
function shuihu_manager:continueShuiHuGame()
	local game_shuihu = WindowScene.getInstance():getModuleObjByClassName("CShuiHuMainScene")
	if game_shuihu then
		game_shuihu.betPanel:continueGame()
	end	
end

--显示结算界面  isCompare 是否是比倍游戏
function shuihu_manager:showSettleAccountsPanel(isCompare, overCallBack, compareCallBack)
	local game_shuihu = WindowScene.getInstance():getModuleObjByClassName("CShuiHuMainScene")
	if game_shuihu then
		game_shuihu:showSettleAccountsPanel(isCompare, overCallBack, compareCallBack)
	end	
end

--显示比倍界面
function shuihu_manager:showComparePanel()
	local game_shuihu = WindowScene.getInstance():getModuleObjByClassName("CShuiHuMainScene")
	if game_shuihu then
		shuihu_manager:showReplacePanelAnimation( function ()
			game_shuihu:showComparePanel()
		end )
		
	end	
end

--摇骰子开奖
function shuihu_manager:showOpenDice(point1, point2)
	local game_shuihu = WindowScene.getInstance():getModuleObjByClassName("CShuiHuMainScene")
	if game_shuihu then
		game_shuihu:showOpenDice(point1, point2)
	end	
end

--继续比倍
function shuihu_manager:continueCompare()
	local game_shuihu = WindowScene.getInstance():getModuleObjByClassName("CShuiHuMainScene")
	if game_shuihu then
		game_shuihu:continueCompare()
	end	
end

--设置押线数目
function shuihu_manager:setBetLineNum(value)
	shuihu_manager._lineNum = value

	local game_shuihu = WindowScene.getInstance():getModuleObjByClassName("CShuiHuMainScene")
	if game_shuihu then
		game_shuihu:resetBetLineImage()
	end
end

--自动次数削减
function shuihu_manager:reduceAutoGameCount()
	if shuihu_manager._autoCount > 0 then
		shuihu_manager._autoCount = shuihu_manager._autoCount - 1

		---次数不足
		if shuihu_manager._autoCount == 0 then
			shuihu_manager._isAutoPlayGame = false
		end
	end
end

--显示/隐藏挂机设置
function shuihu_manager:showHideAutoSetPanel()
	local game_shuihu = WindowScene.getInstance():getModuleObjByClassName("CShuiHuMainScene")
	if game_shuihu then
		game_shuihu:showHideAutoSetPanel()
	end
end

function shuihu_manager:setBetPanelButtonEnabled( value )
	local game_shuihu = WindowScene.getInstance():getModuleObjByClassName("CShuiHuMainScene")
	if game_shuihu then
		game_shuihu:setBetPanelButtonEnabled(value)
	end
end

--开始小玛丽
function shuihu_manager:startlittleMarie()
	local game_shuihu = WindowScene.getInstance():getModuleObjByClassName("CShuiHuMainScene")
	if game_shuihu then
		game_shuihu:startlittleMarie()
	end
end

--检测赢取上限值
function shuihu_manager:checkWinLimit()
	--赢取上限  判断
	if (shuihu_manager._isLimitSingleWin and long_compare(shuihu_manager._curWinChips, shuihu_manager._singleWinLimit) >= 0) or
		(shuihu_manager._isLimitTotalWin and long_compare(shuihu_manager._totalWinChips, shuihu_manager._totalWinLimit) >= 0 ) then
		shuihu_manager._isAutoPlayGame = false

		shuihu_manager._totalWinChips = 0
		shuihu_manager._curWinChips = 0
	end
end

--------------------------------------------------消息
--请求结算游戏
function shuihu_manager:reqSettleCountsGame()
	shuihu_manager._shuiHuCurWin = 0
	shuihu_manager._littleMarieCurWin = 0
	shuihu_manager._diceCurWin = 0

	-- self:reduceAutoGameCount()

	send_shuihu_ReqBill()

	shuihu_manager:startExitTableTimeDown()
end


--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function shuihu_manager:resEnterGameHallMsg(msg)
	local _playerInfo = get_player_info()
	_playerInfo.myRoomTypeInfo = msg.roomTypes
	_playerInfo.curGameID = 3
	_playerInfo.curGameDeskClassName = "CShuiHu_DeskItem"

	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
end

--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:chips 类型:int 
	}
]]
function shuihu_manager:resChipsChangeMsg(msg)
	local game_shuihu = WindowScene.getInstance():getModuleObjByClassName("CShuiHuMainScene")
	if game_shuihu then
		game_shuihu:updateChips(msg.chips)
	end
end

--[[
	玩家筹码兑换
	msg = {
		名称:chips 类型:int 备注:兑换后的筹码
	}
]]
function shuihu_manager:resChipsExChangeMsg(msg)
	shuihu_manager._ownChips = msg.chips
	if long_compare(shuihu_manager._ownChips, shuihu_manager._totalBetChips) < 0 then
		shuihu_manager._isAutoPlayGame = false

		--音效
		audio_manager:playOtherSound(35)
	end

	if shuihu_manager._isAutoPlayGame == true then
		shuihu_manager:continueShuiHuGame()
	else
		shuihu_manager._gameIsGoing = false
		shuihu_manager:setBetPanelButtonEnabled( true )
	end
end

--[[
	座位信息变化消息
	msg = {
		名称:seat 类型:SeatInfo 备注:变化的座位信息
	}
]]
-- function shuihu_manager:resSeatInfoUpdateMsg(msg)
--     local _playerInfo = get_player_info()
-- 	_playerInfo:updateDeskInfo(msg.seat)

--     local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
-- 	if gamelobby then
-- 		local game_room_obj = gamelobby.game_room_ui_list
-- 		if game_room_obj then
-- 			game_room_obj:upDateSeatInfo(msg.seat)
-- 		end
-- 	end

-- end

--[[
	请求进入房间结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:人数超过房间上限
		名称:tables 类型:List<TableInfo> 备注:房间中的牌桌信息
	}
]]
-- function shuihu_manager:resEnterRoomMsg(msg)
-- 	if msg.res == 0 then
-- 		local _playerInfo = get_player_info()
-- 		_playerInfo.myDesksInfo = msg.tables

-- 		local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
-- 		if gamelobby then
-- 			gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_GAME_ROOM)
-- 		end
-- 	end

-- end


--[[
	请求进入牌桌消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
function shuihu_manager.resEnterTableMsg(msg)
	local members = msg.mems
	local _playerInfo = get_player_info()
    _playerInfo.myTableId = members[1].tableId

	WindowScene.getInstance():replaceModuleByModuleName("shuihu_std")

	HallManager:enterTableHandler(msg)
end


--[[
	水浒传房间人数消息
	msg = {
		名称:roomId 类型:int 备注:房间
		名称:type 类型:int 备注:房间类型
		名称:num 类型:int 备注:房间人数
	}
]]
-- function shuihu_manager:resRoomPlayerNumMsg(msg)
-- 	get_player_info():updateRoomInfo(msg.roomId, msg.type, msg.num)
-- 	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
-- 	if gamelobby and gamelobby.second_hall_ui_list then
-- 		gamelobby.second_hall_ui_list:updateRoomInfo(msg.type, msg.roomId, msg.num)
-- 	end
-- end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
	}
]]
function shuihu_manager:resExitTableMsg(msg)
	HallManager:reqExitCurGameRoom()
	if WindowScene.getInstance():getCurModuleName()  == "game_lobby" then
		return
	end
	WindowScene.getInstance():replaceModuleByModuleName("game_lobby")

	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
	self.seatsMap = {}
	local _playerInfo = get_player_info()
	_playerInfo.myTableId = 0

	if shuihu_manager._isForcedOut then
		shuihu_manager._isForcedOut = false
		TipsManager:showOneButtonTipsPanel(34, {}, true)
	end
end

--[[
	水浒传游戏开始结果消息
	msg = {
		名称:res 类型:int 备注:0:成功,1:筹码不足
		名称:type 类型:int 备注:类型(0:普通连线奖励 ,全盘奖励[1:铁斧,2:银枪,3:金刀,4:鲁智深,5:林冲,6:宋江,7:替天行道,8:忠义堂,9:水浒传,10:人物,11:武器]
		名称:bonus 类型:int 备注:bonus次数
		名称:icons 类型:List<int> 备注:图标(固定15个,按行取,每行5个)
		名称:lineRewards 类型:List<LineRewardIcons> 备注:线路中奖图标信息
		名称:totalWin 类型:int 备注:合计赢的筹码(0:没有赢)
	}
]]
function shuihu_manager:resShuihuStartMsg(msg)
	if msg.res == 0 then
		shuihu_manager:removeExitTableTimeDown()
		
		shuihu_manager._xiaoMaLiCount = msg.bonus

		if msg.type ~= 0 then
			shuihu_manager._quanPanRewardType = msg.type
		else
			shuihu_manager._quanPanRewardType = nil
		end

		shuihu_manager._shuiHuCurWin = msg.totalWin 
		shuihu_manager._curWinChips = msg.totalWin
		shuihu_manager._totalWinChips = long_plus(shuihu_manager._totalWinChips, msg.totalWin)

		--检测赢取上限值
		shuihu_manager:checkWinLimit()

		local game_shuihu = WindowScene.getInstance():getModuleObjByClassName("CShuiHuMainScene")
		if game_shuihu then
			game_shuihu.icons = msg.icons
            game_shuihu._lineRewardListVect = msg.lineRewards
            if #msg.lineRewards > 1 then --排序
			    table.sort(game_shuihu._lineRewardListVect, function (reward1, reward2)
                    if reward1 == nil or reward2 == nil then
                        return true
                    end

                    if #reward1.indexs < #reward2.indexs then
                        return true
                    else
                        return false
                    end
                end)
            end

			game_shuihu:startRollGridIcons()
		end
	end
end

--[[
	骰子游戏开始结果消息
	msg = {
		名称:res 类型:int 备注:0:开始成功,1:双比筹码不足
		名称:win 类型:int 备注:0:输,非0:本局赢得的筹码
		名称:point1 类型:int 备注:骰子1点数
		名称:point2 类型:int 备注:骰子2点数
		名称:totalWin 类型:int 备注:合计赢的筹码(0:没有赢)
	}
]]
function shuihu_manager:resDIceGameStartMsg(msg)
	if msg.res == 0 then
		--需要减去之前 赢的 才是最终赢的
		local tmpNum = long_plus(shuihu_manager._totalWinChips, msg.totalWin)
		shuihu_manager._totalWinChips = long_minus(tmpNum, shuihu_manager._curWinChips)
		shuihu_manager._curWinChips = msg.totalWin
		shuihu_manager._diceCurWin = msg.win

        shuihu_manager._shakeDiceWin = (long_compare(msg.win, 0) > 0) and true or false

		self:showOpenDice(msg.point1, msg.point2)

		--检测赢取上限值
		shuihu_manager:checkWinLimit()
	end
end

--[[
	小玛丽开始消息
	msg = {
		名称:insideIcons 类型:List<int> 备注:内部图标
		名称:outsideIcon 类型:int 备注:外部图标
		名称:win 类型:int 备注:当前赢的筹码(0:没有赢)
		名称:totalWin 类型:int 备注:合计赢的筹码(0:没有赢)
		名称:over 类型:int 备注:是否结束(0:没有结束,非0:结束)
	}
]]
function shuihu_manager:resXiaoMaLiStartMsg(msg)
	shuihu_manager._totalWinChips = long_plus(shuihu_manager._totalWinChips, msg.win)
	shuihu_manager._curWinChips = msg.totalWin
	shuihu_manager._littleMarieCurWin = msg.win

	--检测赢取上限值
	shuihu_manager:checkWinLimit()

	shuihu_manager._outsideIconId = msg.outsideIcon
	shuihu_manager._insideIcons = msg.insideIcons
	self:startlittleMarie()
end

--[[
	请求结算结果消息
	msg = {
		
	}
]]
function shuihu_manager:resBillMsg()
	--筹码不足
	local exchangeGold = get_player_info().gold
	if long_compare(shuihu_manager._ownChips, shuihu_manager._totalBetChips) < 0 and shuihu_manager._isAutoPlayGame == true and
     self._isAutoExchange and long_compare(exchangeGold, 0) == 1  then
		send_shuihu_ReqExchangeChips({gold = exchangeGold})
	else
		if long_compare(shuihu_manager._ownChips, shuihu_manager._totalBetChips) < 0 then
			shuihu_manager._isAutoPlayGame = false

			--音效
			audio_manager:playOtherSound(35)
		end

		if shuihu_manager._isAutoPlayGame == true then
			shuihu_manager:continueShuiHuGame()
		else
			shuihu_manager._gameIsGoing = false
			shuihu_manager:setBetPanelButtonEnabled( true )
		end
	end
end