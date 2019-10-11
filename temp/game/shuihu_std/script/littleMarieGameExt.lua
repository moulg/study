--[[

比倍界面
]]

local _begi_x = 410
local _begi_y = 385
local _diff_x = 275

local panel_ui = require "game.shuihu_std.script.ui_create.ui_xiao_ma_li"

CLittleMarieGameExt = class("CLittleMarieGameExt", function ()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
 	ret:loadTexture("lobby/resource/general/heidi.png")

    return ret
end)

function CLittleMarieGameExt.create()
	-- body
	local node = CLittleMarieGameExt.new()
	if node ~= nil then
		node:init_ui()
		node:regEnterExit()
		return node
	end
end

function CLittleMarieGameExt:regEnterExit()
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

function CLittleMarieGameExt:onEnter()
   self:setTouchEnabled(true)
end

function CLittleMarieGameExt:onExit()
	
end


function CLittleMarieGameExt:onShow()
	self:setVisible(true)

	self._gridObjList = {}
	self:createGridObjs()
	self:createOutsideRewardIcons()

	self:reset()

	performWithDelay(self, send_shuihu_ReqXiaoMaLiStart, 0.5)
end

function CLittleMarieGameExt:onHide()
	self:setVisible(false)

	for i,v in ipairs(self._gridObjList) do
		v:removeFromParent()
	end
	self._gridObjList = {}
	self.slotMachineCirCleCon:clearRewardList()

	shuihu_manager:reqSettleCountsGame()

	shuihu_manager:showWordTips( 2 )
end

function CLittleMarieGameExt:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	local size = self.panel_ui.imgBack:getContentSize()
	self:setContentSize(cc.size(size.width, size.height))

	--老虎机管理
	self.slotMachineCirCleCon = CSlotMachineConCirCle.create(CSlotMachineConCirCle.NORMAL_ALL)
	self:addChild(self.slotMachineCirCleCon)

	self._gridObjList = {}
end

--创建外围奖励图标
function CLittleMarieGameExt:createOutsideRewardIcons()
	--老虎机奖励
	local arr = {}
	for i,v in ipairs(shuihu_bonus_iconXY_config) do
		local reward = CLittleMarie_rewardBitmap.create()
		reward:initBitmapInfo(i, v.iconId)
		table.insert(arr, reward)
		reward:setPosition(v.posX, v.posY)
	end
	self._rewardlist = CRewardListCircle.create()

	self._rewardlist:initRewards(arr, self._rewardlist.ORDER_ROLL)
	self._rewardlist:setPosition(0,0)

	self.slotMachineCirCleCon:addRewardList( self._rewardlist )
	self.slotMachineCirCleCon:setRewardListSpeed( 1 , 2 , 60 , 2 )
	self.slotMachineCirCleCon:setAnchorPoint(0,0)
	self.slotMachineCirCleCon:setPosition(0,0)
end

--开始游戏
function CLittleMarieGameExt:startGame()
	self:startRollGridIcons()

	--音效
	audio_manager:playOtherSound(53)

	self:playCircleRollAction(function ()
		self:playOutsideEffect(function ()
			--shuihu_manager._outsideIconId == 9  表示 转到 退出
			if shuihu_manager._xiaoMaLiCount <= 0 or shuihu_manager._outsideIconId == 9 then
				performWithDelay(self, function ()
					shuihu_manager:showReplacePanelAnimation(function ()
						self:onHide()
					end)
					
					shuihu_manager._xiaoMaLiCount = 0
				end, 1)
			else
				performWithDelay(self, send_shuihu_ReqXiaoMaLiStart, 1)
			end

			if shuihu_manager._outsideIconId == 9 then
				--音效
				audio_manager:playOtherSound(32)
			end
		end)

		self:setCurWinChips(shuihu_manager._littleMarieCurWin)
		self:setTotalWinChips(shuihu_manager._curWinChips)
	end)
end

--播发转圈动作
function CLittleMarieGameExt:playCircleRollAction(callback)
	self._rewardlist:setFinalReward(shuihu_manager._outsideIconId)
	self.slotMachineCirCleCon:startRoll( 5, 60 )

	EventUtils.addEventListener( self.slotMachineCirCleCon.ALL_CIRCLE_STOP, self, function ()
		--音效
		audio_manager:playOtherSound(55)

		if callback then
			callback()
		end
	end, true )

	shuihu_manager._xiaoMaLiCount = shuihu_manager._xiaoMaLiCount - 1
	self:setCount(shuihu_manager._xiaoMaLiCount)
end

--开始滚动图标
function CLittleMarieGameExt:startRollGridIcons()
	for k, rewardObj in ipairs(self._gridObjList) do
		local call_action = function ()
			if k == 1 then --第一个转完 设置icon
				rewardObj:playRollAction(function ()
					self:setGridRewardIcon()
				end)
			elseif k == #self._gridObjList then
				rewardObj:playRollAction(function ()
					self:playInsideEffect()
				end)
			else
				rewardObj:playRollAction()	
			end
		end

		performWithDelay(rewardObj, call_action, 0.2 * (k - 1))
	end
end

--播发内部奖励特效
function CLittleMarieGameExt:playInsideEffect()
	if #shuihu_manager._insideIcons ~= 4 then
		return
	end
	--判断是否是4连
	if shuihu_manager._insideIcons[1] == shuihu_manager._insideIcons[2] and
		shuihu_manager._insideIcons[2] == shuihu_manager._insideIcons[3] and
		shuihu_manager._insideIcons[3] == shuihu_manager._insideIcons[4] then
		for k, rewardObj in ipairs(self._gridObjList) do
			rewardObj:playHightLightAnimation()
		end

		self._gridObjList[1]:playHightLightMusic()
	end


	--判断是否是3连
	if (shuihu_manager._insideIcons[1] == shuihu_manager._insideIcons[2] and
		shuihu_manager._insideIcons[2] == shuihu_manager._insideIcons[3]) then
		for i = 1, 3 do
			self._gridObjList[i]:playHightLightAnimation()
		end

		self._gridObjList[2]:playHightLightMusic()
	end

	if (shuihu_manager._insideIcons[2] == shuihu_manager._insideIcons[3] and
		shuihu_manager._insideIcons[3] == shuihu_manager._insideIcons[4]) then
		for i = 2, 4 do
			self._gridObjList[i]:playHightLightAnimation()
		end

		self._gridObjList[3]:playHightLightMusic()
	end
end

--播发外部中奖特效
function CLittleMarieGameExt:playOutsideEffect(callback)
	local isFind = false
	for i,v in ipairs(shuihu_manager._insideIcons) do
		if v == shuihu_manager._outsideIconId then
			if isFind == false then
				self._gridObjList[i]:playHightLightAnimation(callback)

				self._gridObjList[i]:playHightLightMusic()
			else
				self._gridObjList[i]:playHightLightAnimation()
			end

			isFind = true
		end
	end

	if isFind == false then
		callback()
	end
end

function CLittleMarieGameExt:setGridRewardIcon()
	for i,rewardObj in ipairs(self._gridObjList) do
		rewardObj:initBitmapInfo( shuihu_manager._insideIcons[i] )
        rewardObj:setRewardIconId( shuihu_manager._insideIcons[i] )
	end
end

--创建图标对象
--[[
客户端数据: {
	[1] = {[1] = CShuihu_rewardBitmap},
	[1] = {[2] = CShuihu_rewardBitmap},
	[2] = {[2] = CShuihu_rewardBitmap},
}

]]
function CLittleMarieGameExt:createGridObjs()
	for j=1,4 do
		local obj = CShuihu_rewardBitmap.create()
		obj:initBitmapInfo(j)
		obj:setPosition( _begi_x + (j-1)*_diff_x, _begi_y )
		obj:setBorderCon( self.panel_ui.imgBack )
		self.panel_ui.rollCon:addChild(obj)
		self._gridObjList[j] = obj
	end
end

--次数
function CLittleMarieGameExt:setCount( value )
	self.panel_ui.fntCount:setString(value)
end

--筹码
function CLittleMarieGameExt:setChips( value )
	self.panel_ui.fntOwnChips:setString(value)
end

--totalwin筹码
function CLittleMarieGameExt:setTotalWinChips( value )
	self.panel_ui.fntTotalWin:setString(value)
end

--curwin筹码
function CLittleMarieGameExt:setCurWinChips( value )
	self.panel_ui.fntCurWin:setString(value)
end

--重置
function CLittleMarieGameExt:reset()
	self:setChips(shuihu_manager._ownChips)
	self:setTotalWinChips(shuihu_manager._curWinChips)
	self:setCurWinChips(0)
	self:setCount(shuihu_manager._xiaoMaLiCount)
end
