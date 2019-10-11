--[[

比倍界面
]]

local panel_ui = require "game.shuihu_std.script.ui_create.ui_shuihu_compare"

CShuiHuCompareExt = class("CShuiHuCompareExt", function ()
	local ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
 	ret:loadTexture("lobby/resource/general/heidi.png")

    return ret
end)

function CShuiHuCompareExt.create()
	-- body
	local node = CShuiHuCompareExt.new()
	if node ~= nil then
		node:init_ui()
		node:regEnterExit()
		return node
	end
end

function CShuiHuCompareExt:regEnterExit()
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

function CShuiHuCompareExt:onEnter()
   self:setTouchEnabled(true)
end

function CShuiHuCompareExt:onExit()
	--删除  催促音效倒计时
	timeUtils:remove(self)
end


function CShuiHuCompareExt:onShow()
	-- self:reset()
	self:setVisible(true)
	
	--本地结算 临时数据存储
	self.originOwnChips = shuihu_manager._ownChips

	self:continueCompare()
	
	--设置押注信息  --第一次的押注是 水浒传赢的钱
	self.baseBetChips = shuihu_manager._shuiHuCurWin

	if shuihu_manager._isAutoPlayGame then
		self.compareType = shuihu_manager._compareType
	end

	if self.compareType == nil then
		self.compareType = shuihu_manager.COMPARE_TYPE_HALF
	end

	if self.compareType == shuihu_manager.COMPARE_TYPE_HALF then
		self:setBetChips(long_divide(self.baseBetChips,2))
	elseif self.compareType == shuihu_manager.COMPARE_TYPE_ALL then			
		self:setBetChips(self.baseBetChips)
	elseif self.compareType == shuihu_manager.COMPARE_TYPE_DOUBEL then
		self:setBetChips(long_multiply(self.baseBetChips,2))
	end

	--比倍次数
	self._compareCount = shuihu_manager._compareCount

	self:showCompareResultRecords()
end

function CShuiHuCompareExt:onHide()
	self:setVisible(false)

	if self._bossFeelingSprite then
		self._bossFeelingSprite:removeFromParent()
		self._bossFeelingSprite = nil
	end

	if self._bossWaitSprite then
		self._bossWaitSprite:removeFromParent()
		self._bossWaitSprite = nil
	end

	if self._bossOpenSprite then
		self._bossOpenSprite:removeFromParent()
		self._bossOpenSprite = nil
	end

	if self._bossShakeSprite then
		self._bossShakeSprite:removeFromParent()
		self._bossShakeSprite = nil
	end

	if self._leftFeelingSprite then
		self._leftFeelingSprite:removeFromParent()
		self._leftFeelingSprite = nil
	end

	if self._leftWaitSprite then
		self._leftWaitSprite:removeFromParent()
		self._leftWaitSprite = nil
	end

	if self._leftShakeSprite then
		self._leftShakeSprite:removeFromParent()
		self._leftShakeSprite = nil
	end

	if self._rightFeelingSprite then
		self._rightFeelingSprite:removeFromParent()
		self._rightFeelingSprite = nil
	end

	if self._rightWaitSprite then
		self._rightWaitSprite:removeFromParent()
		self._rightWaitSprite = nil
	end

	if self._rightShakeSprite then
		self._rightShakeSprite:removeFromParent()
		self._rightShakeSprite = nil
	end

	self:setButtonsEnable(true)
    self:reset()

	for i,v in ipairs(self._recodImgList) do
		v:removeFromParent()
	end
	self._recodImgList = {}

	shuihu_manager:showWordTips( 2 )
end

function CShuiHuCompareExt:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	self.panel_ui.root:setPosition(0,0)
	self.panel_ui.root:setAnchorPoint(0,0)

	local size = self.panel_ui.imgBack:getContentSize()
	self:setContentSize(cc.size(size.width, size.height))

	self.baseBetChips = 0
	--比倍记录
	self._resultRecod = {}
	self._recodImgList = {}

	self:registerHandler()

	-- self:initButtonHighLight()
end

function CShuiHuCompareExt:initButtonHighLight()
	local mov_obj = cc.Sprite:create(shuihuImageRes_config["banbiMoveOver"].resPath)
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.sbtnHalf,mov_obj,2)

	mov_obj = cc.Sprite:create(shuihuImageRes_config["quanbiMoveOver"].resPath)
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.sbtnAll,mov_obj,2)

	mov_obj = cc.Sprite:create(shuihuImageRes_config["shuangbiMoveOver"].resPath)
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.sbtnDouble,mov_obj,2)


	mov_obj = cc.Sprite:create(shuihuImageRes_config["goldMoveOver1"].resPath)
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.sbtnXiao,mov_obj,2)

	mov_obj = cc.Sprite:create(shuihuImageRes_config["goldMoveOver1"].resPath)
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.sbtnHe,mov_obj,2)

	mov_obj = cc.Sprite:create(shuihuImageRes_config["goldMoveOver1"].resPath)
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.sbtnDa,mov_obj,2)
end

--比倍结果记录
function CShuiHuCompareExt:recordCompareResult(value)
	if #self._resultRecod < 19 then
		self:addCompareResultRecord(value)
	else
		self:removeCompareResultRecord()
		self:addCompareResultRecord(value)
	end
end

--显示比倍记录
function CShuiHuCompareExt:showCompareResultRecords()
	for i,v in ipairs(self._recodImgList) do
		v:removeFromParent()
	end
	self._recodImgList = {}

	local arr = self._resultRecod
	self._resultRecod = {}
	for i,v in ipairs(arr) do
		self:addCompareResultRecord(v)
	end
end

--添加记录
function CShuiHuCompareExt:addCompareResultRecord(value)
	table.insert(self._resultRecod, value)

	local name = ""
	if value == shuihu_manager.BET_TYPE_XIAO then
		name = "recordXiao"
	elseif value == shuihu_manager.BET_TYPE_HE then
		name = "recordHe"
	elseif value == shuihu_manager.BET_TYPE_DA then
		name = "recordDa"
	end

	local imgRecord = cc.Sprite:create(shuihuImageRes_config[name].resPath)
	self:addChild(imgRecord)
	imgRecord:setPosition(55 + 85 * #self._recodImgList, 992)
	table.insert(self._recodImgList, imgRecord)
end

--删除记录
function CShuiHuCompareExt:removeCompareResultRecord()
	table.remove(self._resultRecod, 1)
	
	self._recodImgList[1]:removeFromParent()
	table.remove(self._recodImgList, 1)

	for i,imgRecord in ipairs(self._recodImgList) do
		imgRecord:setPositionX(55 + 85 * (i-1))
	end
end

function CShuiHuCompareExt:registerHandler()
	--比倍类型 选择
	local compareTypecallback = function (sender, eventType)
		if sender == self.panel_ui.sbtnHalf then
			self.compareType = shuihu_manager.COMPARE_TYPE_HALF
			self:setBetChips(long_divide(self.baseBetChips,2))
		elseif sender == self.panel_ui.sbtnAll then
			self.compareType = shuihu_manager.COMPARE_TYPE_ALL
			self:setBetChips(self.baseBetChips)
		elseif sender == self.panel_ui.sbtnDouble then
			self.compareType = shuihu_manager.COMPARE_TYPE_DOUBEL
			self:setBetChips(long_multiply(self.baseBetChips,2))
		end
		--音效
		audio_manager:playOtherSound(18)
	end

	local btn_group_lst = {self.panel_ui.sbtnHalf,self.panel_ui.sbtnAll,self.panel_ui.sbtnDouble,}
	WindowScene.getInstance():registerGroupEvent(btn_group_lst,compareTypecallback)

	--押注类型 选择
	local betTypecallback = function (sender, eventType)
		if eventType == "selected" then
			if sender == self.panel_ui.sbtnXiao then
				self.betType = shuihu_manager.BET_TYPE_XIAO
			elseif sender == self.panel_ui.sbtnHe then
				self.betType = shuihu_manager.BET_TYPE_HE
			elseif sender == self.panel_ui.sbtnDa then
				self.betType = shuihu_manager.BET_TYPE_DA
			end

			send_shuihu_ReqDiceGameStart({bet = self.betType, type = self.compareType})
			self:setButtonsEnable(false)

			--音效
			audio_manager:playOtherSound(19)
		end
	end

	local btnBetTypeList = {self.panel_ui.sbtnXiao,self.panel_ui.sbtnHe,self.panel_ui.sbtnDa}
	WindowScene.getInstance():registerGroupEvent(btnBetTypeList,betTypecallback)

	-- self.panel_ui.sbtnXiao:addEventListener(betTypecallback)
	-- self.panel_ui.sbtnHe:addEventListener(betTypecallback)
	-- self.panel_ui.sbtnDa:addEventListener(betTypecallback)

	self.btnList = {self.panel_ui.sbtnHalf,self.panel_ui.sbtnAll,self.panel_ui.sbtnDouble,
					self.panel_ui.sbtnXiao,self.panel_ui.sbtnHe,self.panel_ui.sbtnDa,}

end

--禁用/启用按钮
function CShuiHuCompareExt:setButtonsEnable(value)
	for i,v in ipairs(self.btnList) do
		v:setEnabled(value)
		v:setBright(value)
	end

	if long_compare(self.originOwnChips, self.baseBetChips) < 0 then
		self.panel_ui.sbtnDouble:setVisible(false)
		self.panel_ui.sbtnDouble:setVisible(false)
	else
		self.panel_ui.sbtnDouble:setVisible(true)
		self.panel_ui.sbtnDouble:setVisible(true)
	end
end

function CShuiHuCompareExt:setBtnByCompareType()
    if self.compareType == shuihu_manager.COMPARE_TYPE_HALF then
    	self.panel_ui.sbtnHalf:setSelected(true)
	    self.panel_ui.sbtnHalf:setEnabled(false)
        self.panel_ui.sbtnHalf:setBright(false)
    elseif self.compareType == shuihu_manager.COMPARE_TYPE_ALL then	
    	self.panel_ui.sbtnAll:setSelected(true)		
	    self.panel_ui.sbtnAll:setEnabled(false)
        self.panel_ui.sbtnAll:setBright(false)
    elseif self.compareType == shuihu_manager.COMPARE_TYPE_DOUBEL then
    	self.panel_ui.sbtnDouble:setSelected(true)
	    self.panel_ui.sbtnDouble:setEnabled(false)
        self.panel_ui.sbtnDouble:setBright(false)
    end
end

--筹码
function CShuiHuCompareExt:setChips( value )
	self.tmpOwnChips = value
	self.panel_ui.fntTotalChips:setString(value)
end

--押注
function CShuiHuCompareExt:setBetChips( value )
	self.curBetChips = value
	self.panel_ui.fntBetChips:setString(value)

	local moveRes = ""
	local bgClickRes = ""
	local frontRes = ""
	local frontDisRes = ""

	if long_compare(value, 1) >= 0 and long_compare(value, 10) < 0 then
		moveRes = "goldMoveOver1"
		bgClickRes = "goldBGClick1"
		frontRes = "goldFront1"
		frontDisRes = "goldFrontDis1"
	elseif long_compare(value, 10) >= 0 and long_compare(value, 50) < 0 then
		moveRes = "goldMoveOver2"
		bgClickRes = "goldBGClick2"
		frontRes = "goldFront2"
		frontDisRes = "goldFrontDis2"
	elseif long_compare(value, 50) >= 0 and long_compare(value, 100) < 0 then
		moveRes = "goldMoveOver3"
		bgClickRes = "goldBGClick3"
		frontRes = "goldFront3"
		frontDisRes = "goldFrontDis3"
	elseif long_compare(value, 100) >= 0 and long_compare(value, 500) < 0 then
		moveRes = "goldMoveOver4"
		bgClickRes = "goldBGClick4"
		frontRes = "goldFront4"
		frontDisRes = "goldFrontDis4"
	else
		moveRes = "goldMoveOver5"
		bgClickRes = "goldBGClick5"
		frontRes = "goldFront5"
		frontDisRes = "goldFrontDis5"
	end

	-- self.panel_ui.sbtnXiao._moveOverSpr:setTexture(shuihuImageRes_config[moveRes].resPath)
	self.panel_ui.sbtnXiao:loadTextureBackGroundSelected(shuihuImageRes_config[bgClickRes].resPath)
	self.panel_ui.sbtnXiao:loadTextureFrontCross(shuihuImageRes_config[frontRes].resPath)
	self.panel_ui.sbtnXiao:loadTextureFrontCrossDisabled(shuihuImageRes_config[frontDisRes].resPath)

	-- self.panel_ui.sbtnHe._moveOverSpr:setTexture(shuihuImageRes_config[moveRes].resPath)
	self.panel_ui.sbtnHe:loadTextureBackGroundSelected(shuihuImageRes_config[bgClickRes].resPath)
	self.panel_ui.sbtnHe:loadTextureFrontCross(shuihuImageRes_config[frontRes].resPath)
	self.panel_ui.sbtnHe:loadTextureFrontCrossDisabled(shuihuImageRes_config[frontDisRes].resPath)

	-- self.panel_ui.sbtnDa._moveOverSpr:setTexture(shuihuImageRes_config[moveRes].resPath)
	self.panel_ui.sbtnDa:loadTextureBackGroundSelected(shuihuImageRes_config[bgClickRes].resPath)
	self.panel_ui.sbtnDa:loadTextureFrontCross(shuihuImageRes_config[frontRes].resPath)
	self.panel_ui.sbtnDa:loadTextureFrontCrossDisabled(shuihuImageRes_config[frontDisRes].resPath)


	---前端模拟更新总筹码
	if self.compareType == shuihu_manager.COMPARE_TYPE_HALF then
		local tmpNum = long_divide(self.baseBetChips,2)
		tmpNum = long_plus(tmpNum, self.originOwnChips)
		self:setChips(tmpNum)
	elseif self.compareType == shuihu_manager.COMPARE_TYPE_ALL then			
		self:setChips(self.originOwnChips)
	elseif self.compareType == shuihu_manager.COMPARE_TYPE_DOUBEL then
		self:setChips(long_minus(self.originOwnChips, self.baseBetChips))
	end
end

--开奖
function CShuiHuCompareExt:showOpenDice(point1, point2)
	self.point1 = point1
	self.point2 = point2

	if self._bossWaitSprite then
		self._bossWaitSprite:removeFromParent()
	end
	self._bossWaitSprite = nil
	
	self._bossOpenSprite = animationUtils.createAndPlayAnimation(self.panel_ui.bossCon, shuihu_effect_config["bossOpen"], function ()
		--音效
		audio_manager:playOtherSound(18 + self.point1 + self.point2)
		self:showCompareResult()
	end)

	self._bossOpenSprite:setPosition(0,0)
	self._bossOpenSprite:setAnchorPoint(0,0)

	performWithDelay(self, function ()
		--设置点数
		if self.point1 < self.point2 then
			self.panel_ui.imgPointResult:setTexture(doubleDiceRes_config[self.point1.."_"..self.point2].resPath)
		else
			self.panel_ui.imgPointResult:setTexture(doubleDiceRes_config[self.point2.."_"..self.point1].resPath)
		end
		self.panel_ui.imgPointResult:setVisible(true)

	end, 0.6)

	--删除  催促音效倒计时
	timeUtils:remove(self)
end

--继续比倍
function CShuiHuCompareExt:continueCompare()
	self:setButtonsEnable(true)
    self:clearResult()
    self:reset()
    self:setButtonsEnable(false)

	if self._bossFeelingSprite then
		self._bossFeelingSprite:removeFromParent()
	end
	self._bossFeelingSprite = nil

	--播发摇骰子特效
	self._bossShakeSprite = animationUtils.createAndPlayAnimation(self.panel_ui.bossCon, shuihu_effect_config["bossShake"], function ()
		self:playBossWaitEffect()
	end)
	--音效
	audio_manager:playOtherSound(31)

	self._bossShakeSprite:setPosition(0,0)
	self._bossShakeSprite:setAnchorPoint(0,0)

	if self._leftFeelingSprite then
		self._leftFeelingSprite:removeFromParent()
	end
	self._leftFeelingSprite = nil

	--NPC加油特效
	self._leftShakeSprite = animationUtils.createAndPlayAnimation(self.panel_ui.leftCon, shuihu_effect_config["leftSupport"])
	self._leftShakeSprite:setPosition(0,0)
	self._leftShakeSprite:setAnchorPoint(0,0)

	if self._rightFeelingSprite then
		self._rightFeelingSprite:removeFromParent()
	end
	self._rightFeelingSprite = nil

	self._rightShakeSprite = animationUtils.createAndPlayAnimation(self.panel_ui.rightCon, shuihu_effect_config["rightSupport"])
	self._rightShakeSprite:setPosition(0,0)
	self._rightShakeSprite:setAnchorPoint(0,0)
end

--boss等待特效
function CShuiHuCompareExt:playBossWaitEffect()
	if self._bossShakeSprite then
		self._bossShakeSprite:removeFromParent()
	end
	self._bossShakeSprite = nil

	--NPC  等待动作
	self._bossWaitSprite = animationUtils.createAndPlayAnimation(self.panel_ui.bossCon, shuihu_effect_config["bossWait"])
	self._bossWaitSprite:setPosition(0,0)
	self._bossWaitSprite:setAnchorPoint(0,0)

	if self._leftShakeSprite then
		self._leftShakeSprite:removeFromParent()
		self._leftShakeSprite = nil
	end

	self._leftWaitSprite = animationUtils.createAndPlayAnimation(self.panel_ui.leftCon, shuihu_effect_config["leftWait"])
	self._leftWaitSprite:setPosition(0,0)
	self._leftWaitSprite:setAnchorPoint(0,0)

	if self._rightShakeSprite then
		self._rightShakeSprite:removeFromParent()
		self._rightShakeSprite = nil
	end

	self._rightWaitSprite = animationUtils.createAndPlayAnimation(self.panel_ui.rightCon, shuihu_effect_config["rightWait"])
	self._rightWaitSprite:setPosition(0,0)
	self._rightWaitSprite:setAnchorPoint(0,0)

	--庄家喊话音效
	local musicid = math.random(11, 15)
	audio_manager:playOtherSound(musicid)

	--自动比倍
	self:autoCompare()
end

--auto  compare
function CShuiHuCompareExt:autoCompare()
	if shuihu_manager._isAutoPlayGame and self._compareCount > 0 then
		self:setButtonsEnable(true)
		if shuihu_manager._betType == shuihu_manager.BET_TYPE_XIAO then
			self.panel_ui.sbtnXiao:setSelected(true)
		elseif shuihu_manager._betType == shuihu_manager.BET_TYPE_HE then
			self.panel_ui.sbtnHe:setSelected(true)
		elseif shuihu_manager._betType == shuihu_manager.BET_TYPE_DA then
			self.panel_ui.sbtnDa:setSelected(true)
		end
		self:setButtonsEnable(false)

		send_shuihu_ReqDiceGameStart({bet = shuihu_manager._betType, type = self.compareType})
	else
		--默认为半比
		self.compareType = shuihu_manager.COMPARE_TYPE_HALF
		-- self.panel_ui.sbtnHalf:setSelected(true)
		self:setBtnByCompareType()
		self:setButtonsEnable(true)

		self:addTimeDownForMusic()
	end
end

--为播发音乐  添加倒计时
function CShuiHuCompareExt:addTimeDownForMusic()
	local showtime = 5
	
	timeUtils:addTimeDown(self, showtime, nil,
		function ( args ) self:playHarryUpMusic() end)
end

--播发催促语音
function CShuiHuCompareExt:playHarryUpMusic()
	local musicid = math.random(1, 10)
	audio_manager:playOtherSound(musicid)

	self:addTimeDownForMusic()
end


--显示比倍结果
function CShuiHuCompareExt:showCompareResult()
	print("--显示比倍结果")
	if self._bossOpenSprite then
		self._bossOpenSprite:removeFromParent()
	end
	self._bossOpenSprite = nil


	self.panel_ui.imgW3:setVisible(true)


	local leftRes = ""
	local rightRes = ""
	if self.point1 + self.point2 <= 6 and self.point1 + self.point2 >= 2 then--小
		self.panel_ui.imgW_Da_Xiao:setTexture(shuihuImageRes_config["imgXiao"].resPath)
		leftRes = "leftWin"
		rightRes = "rightLose"

		self:recordCompareResult(shuihu_manager.BET_TYPE_XIAO)
	elseif self.point1 + self.point2 <= 12 and self.point1 + self.point2 >= 8 then--大
		self.panel_ui.imgW_Da_Xiao:setTexture(shuihuImageRes_config["imgDa"].resPath)
		leftRes = "leftLose"
		rightRes = "rightWin"

		self:recordCompareResult(shuihu_manager.BET_TYPE_DA)
	else--和
		self.panel_ui.imgW_Da_Xiao:setTexture(shuihuImageRes_config["imgHe"].resPath)
		leftRes = "leftLose"
		rightRes = "rightLose"

		self:recordCompareResult(shuihu_manager.BET_TYPE_HE)
	end
	
	if self._leftWaitSprite then
		self._leftWaitSprite:removeFromParent()
		self._leftWaitSprite = nil
	end

	if self._rightWaitSprite then
		self._rightWaitSprite:removeFromParent()
		self._rightWaitSprite = nil
	end

	--左右人的表情
	self._leftFeelingSprite = animationUtils.createAndPlayAnimation(self.panel_ui.leftCon, shuihu_effect_config[leftRes])
	self._leftFeelingSprite:setPosition(0,0)
	self._leftFeelingSprite:setAnchorPoint(0,0)

	self._rightFeelingSprite = animationUtils.createAndPlayAnimation(self.panel_ui.rightCon, shuihu_effect_config[rightRes])
	self._rightFeelingSprite:setPosition(0,0)
	self._rightFeelingSprite:setAnchorPoint(0,0)

	--点数信息
	self.panel_ui.fntPoint:setString(self.point2 + self.point1)
	self.panel_ui.imgPoint1:setTexture(singleDiceRes_config[self.point1].resPath)
	self.panel_ui.imgPoint2:setTexture(singleDiceRes_config[self.point2].resPath)

	--赢了
	if shuihu_manager._shakeDiceWin then
		self.panel_ui.imgW3:setTexture(shuihuImageRes_config["wordWin"].resPath)

		self._bossFeelingSprite = animationUtils.createAndPlayAnimation(self.panel_ui.bossCon, shuihu_effect_config["bossLose"])
		self._bossFeelingSprite:setPosition(0,0)
		self._bossFeelingSprite:setAnchorPoint(0,0)

		--庄家哭
		performWithDelay(self, function ()
			audio_manager:playOtherSound(17)
		end, 1.2)
		
	else
		self.panel_ui.imgW3:setTexture(shuihuImageRes_config["wordLose"].resPath)

		self._bossFeelingSprite = animationUtils.createAndPlayAnimation(self.panel_ui.bossCon, shuihu_effect_config["bossWin"])
		self._bossFeelingSprite:setPosition(0,0)
		self._bossFeelingSprite:setAnchorPoint(0,0)

		--庄家笑
		performWithDelay(self, function ()
			audio_manager:playOtherSound(16)
		end, 1.2)
	end

	--back to shuihu
	local function overCallBack()
		self:backToShuiHu()
	end

	--自动比倍回调
	local function autoCompareCallBack()
		self:continueCompare()

		--本地结算 临时数据存储
		self.originOwnChips = self.tmpOwnChips

		--第二次比倍 的押注 是 比倍赢的钱
		--设置押注信息
		self.baseBetChips = shuihu_manager._diceCurWin
		if self.compareType == shuihu_manager.COMPARE_TYPE_HALF then
			self:setBetChips(long_divide(self.baseBetChips,2))
		elseif self.compareType == shuihu_manager.COMPARE_TYPE_ALL then			
			self:setBetChips(self.baseBetChips)
		elseif self.compareType == shuihu_manager.COMPARE_TYPE_DOUBEL then
			self:setBetChips(long_multiply(self.baseBetChips,2))
		end
	end

	--普通比倍回调
	local function compareCallBack()
		self:continueCompare()

		--本地结算 临时数据存储
		self.originOwnChips = self.tmpOwnChips

		--第二次比倍 的押注 是 比倍赢的钱
		--设置押注信息
		self.baseBetChips = shuihu_manager._diceCurWin
		if self.compareType == shuihu_manager.COMPARE_TYPE_HALF then
			self:setBetChips(long_divide(self.baseBetChips,2))
		elseif self.compareType == shuihu_manager.COMPARE_TYPE_ALL then			
			self:setBetChips(self.baseBetChips)
		elseif self.compareType == shuihu_manager.COMPARE_TYPE_DOUBEL then
			self:setBetChips(long_multiply(self.baseBetChips,2))
		end
	end


	if shuihu_manager._isAutoPlayGame then
		--自动比倍次数
		self._compareCount = self._compareCount - 1
		if self._compareCount > 0 then
			--够不够下次双比
			if self.compareType == shuihu_manager.COMPARE_TYPE_DOUBEL and
			    long_compare(self.originOwnChips, shuihu_manager._diceCurWin) < 0 then
				performWithDelay(self, function ()
		           self:backToShuiHu()
				end, 2)
			else
				performWithDelay(self, function ()
			        if shuihu_manager._shakeDiceWin then  --赢了继续比倍
					    autoCompareCallBack()
			        else
			            self:backToShuiHu()
			        end
				end, 2)
			end
		else --没有次数  不管输赢 都退出比倍
			performWithDelay(self, function ()
	           self:backToShuiHu()
			end, 2)
		end
	else
		performWithDelay(self, function ()
	        if shuihu_manager._shakeDiceWin then
			    shuihu_manager:showSettleAccountsPanel(true, overCallBack, compareCallBack)
	        else
	            self:backToShuiHu()
	        end
		end, 2)
	end
	
		
end

--返回水浒传
function CShuiHuCompareExt:backToShuiHu()
	shuihu_manager:showReplacePanelAnimation(function ()
		self:onHide()

		--结算
		shuihu_manager:reqSettleCountsGame()
	end)
end


--重置
function CShuiHuCompareExt:reset()
	self.compareType = shuihu_manager.COMPARE_TYPE_HALF
	-- self.panel_ui.sbtnHalf:setSelected(true)
	self.panel_ui.sbtnHalf:setSelected(false)
	self.panel_ui.sbtnAll:setSelected(false)
	self.panel_ui.sbtnDouble:setSelected(false)

	self.panel_ui.sbtnXiao:setSelected(false)
	self.panel_ui.sbtnHe:setSelected(false)
	self.panel_ui.sbtnDa:setSelected(false)

	self.panel_ui.imgPointResult:setVisible(false)

	self.panel_ui.imgW3:setVisible(false)
	self.panel_ui.imgPointResult:setVisible(false)
end

--清理
function CShuiHuCompareExt:clearResult()
	self.panel_ui.sbtnXiao:setSelected(false)
    self.panel_ui.sbtnXiao:setBright(true)
	self.panel_ui.sbtnHe:setSelected(false)
    self.panel_ui.sbtnHe:setBright(true)
	self.panel_ui.sbtnDa:setSelected(false)
    self.panel_ui.sbtnDa:setBright(true)

	self.panel_ui.imgPointResult:setVisible(false)

	self.panel_ui.imgW3:setVisible(false)
	self.panel_ui.imgPointResult:setVisible(false)
end