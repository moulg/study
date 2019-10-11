--[[
水浒传主场景

]]

local _begi_x = 251
local _begi_y = 731
local _diff_x = 280
local _diff_y = 205

local shuihu_ui = require "game.shuihu_std.script.ui_create.ui_shuihu_mainscene"

CShuiHuMainScene = class("CShuiHuMainScene", function ()
	local ret = cc.Layer:create()
	return ret
end)
ModuleObjMgr.add_module_obj(CShuiHuMainScene,"CShuiHuMainScene")

function CShuiHuMainScene.create()
	local layer = CShuiHuMainScene.new()
	if layer ~= nil then
        layer:regEnterExit()
		layer:loading()
	end
	return layer
end


function CShuiHuMainScene:loading()
	local info = {
		parent 			= WindowScene.getInstance().game_layer,
		task_call 		= function (percent,index,texture) self:addImageSrc(percent,index,texture) end,
		complete_call 	= function () self:init() end,
		--task_lst = {[x] = {src = "",},},
		ui_info = {
			back_pic 		= "game/shuihu_std/resource/image/BG_3.jpg",
			bar_back_pic 	= "game/shuihu_std/resource/image/loading/loadingbg.png",
			bar_process_pic = "game/shuihu_std/resource/image/loading/loading.png",
			b_self_release 	= true,
		},
	}

	info.task_lst = {}
	for i=1,#shuihu_effect_res_config do
		local item = {src = shuihu_effect_res_config[i].imageName,}
		info.task_lst[i] = item
	end
	self._loadingTask = LoadingTask.create(info)
end

function CShuiHuMainScene:addImageSrc(percent,index,texture)
	print("index = " .. index .. ",plist path  = " .. shuihu_effect_res_config[index].plistPath)

	local cache = cc.SpriteFrameCache:getInstance()
	cache:addSpriteFrames(shuihu_effect_res_config[index].plistPath)
end

function CShuiHuMainScene:init()
	self._loadingTask = nil

	self:init_ui()
	self:init_after_enter()
end




function CShuiHuMainScene:regEnterExit()
	-- body
	local function _onEnterOrExit(event)
		-- body
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(_onEnterOrExit)
end

function CShuiHuMainScene:onEnter()
	self:setTouchEnabled(true)

	audio_manager:reloadMusicByConfig(shuihu_music_config)

	shuihu_manager:openCloseSpaceKeyboard( true )
end

function CShuiHuMainScene:onExit()
	local cache = cc.SpriteFrameCache:getInstance()
    
    for k,v in pairs(shuihu_effect_res_config) do
    	cache:removeSpriteFramesFromFile(v.plistPath)
    end

    audio_manager:destoryAllMusicRes()

    shuihu_manager:openCloseSpaceKeyboard( false )
    shuihu_manager:removeExitTableTimeDown()
end

function CShuiHuMainScene:destoryLoading()
	if self._loadingTask then
    	self._loadingTask:forcedDestory()
        self._loadingTask = nil
    end
end

function CShuiHuMainScene:init_ui()
	--基础界面
	self.shuihu_ui = shuihu_ui.create()
	self:addChild(self.shuihu_ui.root, 1)
	self.shuihu_ui.root:setPosition(0,0)
	self.shuihu_ui.root:setAnchorPoint(0,0)

	--押注界面
	self.betPanel =  CShuiHuBetExt.create()
	self.shuihu_ui.kuang_img:addChild(self.betPanel, 2)
	self.betPanel:setPosition(0,0)
	self.betPanel:setAnchorPoint(0,0)



	self:registerHandler()
end

function CShuiHuMainScene:registerHandler()
	local function closeFunc()
		if shuihu_manager._isAutoPlayGame == false and shuihu_manager._gameIsGoing == false then
			HallManager:reqExitCurGameTable()
		else
			TipsManager:showOneButtonTipsPanel( 78, {}, true)
		end
	end

	local title = WindowScene.getInstance():getModuleObjByClassName("CTableTitleExt")
	if title then
		title:setCloseFunc(closeFunc)
	end
end

function CShuiHuMainScene:init_after_enter()
	--最终奖励图标列表数据  2维数组
	self._rewardDataList = {}

	--单线最终奖励索引列表  服务器数据 
	--[[
		{
			[1] = {line = 1, indexs = {1,2,3} },
			[2] = {line = 2, indexs = {1,2,3} },
			[3] = {line = 9, indexs = {1,2,3} },
		}
	]]
	self._lineRewardListVect = {}
	--15 个格子 最终的图标
	self.icons = nil

	--每条线 拥有的 格子索引 列表
	self._lineGridListVect = {}

	--图标对象  列表
	self.allGridObjList = {}
	--线条图片  列表
	self.lineImgList = {}

	self:lineGridData_transformToClientData(shuihu_line_coord_config.shuihu_line_coord_table)

	self:createAllLines()
	self:createAllGridObj()
	self:showHumenWaitAnimaition()

	shuihu_manager._gameIsGoing = false
	shuihu_manager._isAutoPlayGame = false

	shuihu_manager:showWordTips(1)

	shuihu_manager:startExitTableTimeDown()
end

--将表格中的格子索引列表数据 转化为 客户端数据
--[[
	{
	[1] = {[1] = {row = 1, col = 1}, [2] = {row = 1, col = 2},},
	[2] = {[1] = {row = 2, col = 1}, [2] = {row = 2, col = 2},},
	}
]]
function CShuiHuMainScene:lineGridData_transformToClientData(gridData)
	for i = 1, #gridData do
		local v = gridData[i]
		if self._lineGridListVect[v.line] == nil then
			self._lineGridListVect[v.line] = {}
		end

		table.insert(self._lineGridListVect[v.line], {row = v.row + 1, col = v.column + 1})
	end
end

--显示比倍界面
function CShuiHuMainScene:showComparePanel(isCompare)
	--对比界面
	if self.comparePanel == nil then
		self.comparePanel = CShuiHuCompareExt.create()
		self.shuihu_ui.panelContent:addChild(self.comparePanel)
		self.comparePanel:setPosition(0,0)
		self.comparePanel:setAnchorPoint(0,0)
	end

	self.comparePanel:onShow(isCompare)
end

--显示结算界面  isCompare 是否是比倍游戏
function CShuiHuMainScene:showSettleAccountsPanel(isCompare, overCallBack, compareCallBack)
		--结算界面
	if self.overPanel == nil then
		self.overPanel = CShuiHuSettleAccounts.create()
		self:addChild(self.overPanel, 50)
		self.overPanel:setPosition(0,0)
		self.overPanel:setAnchorPoint(0,0)
	end

	self.overPanel:onShow(isCompare, overCallBack, compareCallBack)

	shuihu_manager:showWordTips( 5 )
end

--开始摇骰子
function CShuiHuMainScene:showOpenDice(point1, point2)
	self.comparePanel:showOpenDice(point1, point2)
end

--继续比倍
function CShuiHuMainScene:continueCompare()
	self.comparePanel:continueCompare()
end

--设置押线图片
function CShuiHuMainScene:resetBetLineImage()
	if self.lineImgList then
		for i=1,#self.lineImgList do 
			self.lineImgList[i]:setVisible(i <= shuihu_manager._lineNum)
		end
	end
end

function CShuiHuMainScene:updateChips( chips )
	self.betPanel:setChips(chips)
end


--创建线条
function CShuiHuMainScene:createAllLines()

	for i=1,9 do
		local imgFrame = display.newSpriteFrame("line_0"..i..".png")
        local imgline = cc.Sprite:createWithSpriteFrame(imgFrame);
		self.lineImgList[i] = imgline
		self.shuihu_ui.kuang_img:addChild(imgline)
		imgline:setAnchorPoint(0,0)
		imgline:setPosition(0,0)
		imgline:setVisible(false)
	end
end

--隐藏所有线
function CShuiHuMainScene:hideAllLines()
	for i,v in ipairs(self.lineImgList) do
		v:setVisible(false)
	end
end

--显示押注的线
function CShuiHuMainScene:showBetLines()
	self:resetBetLineImage()
end

--创建所有图标对象
--[[
客户端数据: {
	[1] = {[1] = CShuihu_rewardBitmap},
	[1] = {[2] = CShuihu_rewardBitmap},
	[2] = {[2] = CShuihu_rewardBitmap},
}

]]
function CShuiHuMainScene:createAllGridObj()
	for i=1,shuihu_manager.ROW_NUM do
		if self.allGridObjList[i] == nil then
			self.allGridObjList[i] = {}
		end

		for j=1,shuihu_manager.COL_NUM do
			local obj = CShuihu_rewardBitmap.create()
			obj:initBitmapInfo(i)
			obj:setPosition( cc.p(_begi_x + (j-1) * _diff_x, _begi_y - (i-1) * _diff_y) )
			obj:setBorderCon( self.shuihu_ui.kuang_img )
			self.shuihu_ui.iconContent:addChild(obj)
			self.allGridObjList[i][j] = obj
		end
	end
end

--奖励列表  转化成客户端数据
--[[
服务器数据为：{1,2,3,4,5,5,6,6,6,}

客户端数据: {
	[1] = {[1] = 1},
	[1] = {[2] = 2},
	[2] = {[2] = 2},
}
]]

function CShuiHuMainScene:rewardData_transformToClientData( list )
	self._rewardDataList = {}

	for k,v in ipairs(list) do
		local row = math.floor((k - 1) / self.COL_NUM) + 1
		local col = (k - 1) % self.ROW_NUM + 1

		if self._rewardDataList[row] == nil then
			self._rewardDataList[row] = {}
		end

		self._rewardDataList[row][col] = v
	end  
end

--开始滚动图标
function CShuiHuMainScene:startRollGridIcons()
	self:hideAllLines()
	self:showHumenPlayAnimaition()

	shuihu_manager:showWordTips( 3 )

	--音效
	audio_manager:playOtherSound(33)

	for i,v in ipairs(self.allGridObjList) do
		for k, rewardObj in ipairs(v) do
			local call_action = function ()
				if i == 1 and k == 1 then --第一个转完 设置icon
					rewardObj:playRollAction(function ()
						self:setAllGridRewardIcon()
					end)
				elseif i == #self.allGridObjList and k == #v then --最后一个转完 播发特效
					if shuihu_manager._quanPanRewardType then--如果是全盘奖
                        rewardObj:playRollAction(function ()
							self:showQuanPanHighlightEffect()
							self:showHumenWaitAnimaition()
						end)
					else
						rewardObj:playRollAction(function ()
							self:showHightLightEffect()
							self:showHumenWaitAnimaition()
						end)
					end
				else
					rewardObj:playRollAction()	
				end
			end

			performWithDelay(rewardObj, call_action, 0.2 * (k - 1))
		end
	end
end

--设置所有格子的最终奖励图标
function CShuiHuMainScene:setAllGridRewardIcon()
	local index = 1
	for i,v in ipairs(self.allGridObjList) do
		for k, rewardObj in ipairs(v) do
			rewardObj:initBitmapInfo( self.icons[index] )
			index = index + 1
		end
	end
end


--清除图标对象
function CShuiHuMainScene:clearGridObjs()
	for i,v in ipairs(self.allGridObjList) do
		for k, rewardObj in ipairs(v) do
			rewardObj:stopAllActons()
			rewardObj:removeFromParent()
			rewardObj = nil
		end
	end

	self.allGridObjList = {}
end

--展示全盘奖高光特效
function CShuiHuMainScene:showQuanPanHighlightEffect()
	local objList = self:getAllRewardObj()
	for i,v in ipairs(objList) do
		if i == #objList then
			v:playHightLightAnimation(function ()
				self:showActionEffect()
			end)
			--音效
			if shuihu_manager._quanPanRewardType == 10 then
				audio_manager:playOtherSound(52)
			elseif shuihu_manager._quanPanRewardType == 11 then
				audio_manager:playOtherSound(51)
			else
				v:playHightLightMusic()	
			end			
		else
			v:playHightLightAnimation()
		end
	end
end

--展示高光特效  默认index = 1
function CShuiHuMainScene:showHightLightEffect(index)
	index = index == nil and 1 or index

	local imgLine
	--隐藏上一次的线条
	if index - 1 >= 1 then
		imgLine = self.lineImgList[self._lineRewardListVect[index - 1].line]
		imgLine:setVisible(false)
	end

	if index <= #self._lineRewardListVect then
		local objList = self:getGridObjListByIndexList(self._lineRewardListVect[index])

		--显示高光特效
		local function showIconsHightLight()
			for i,v in ipairs(objList) do
				--设置边框纹理
				if shuihu_manager._quanPanRewardType == nil then
					if #objList == 3 then
						v:setBorderTexture(shuihu_manager.SAN_LIAN)
					elseif #objList == 4 then
						v:setBorderTexture(shuihu_manager.SI_LIAN)
					elseif #objList == 5 then
						v:setBorderTexture(shuihu_manager.WU_LIAN)
					end
				else
					v:setBorderTexture(shuihu_manager.QUAN_PAN)
				end

				--播发特效
				if i == #objList then
					v:playHightLightAnimation(function ()
						self:showHightLightEffect(index + 1)
					end)
					v:playHightLightMusic()
				else
					v:playHightLightAnimation()
				end
			end
		end
		
		--显示线条
		imgLine = self.lineImgList[self._lineRewardListVect[index].line]
		imgLine:setVisible(true)

		--延迟显示
		local call_action = cc.CallFunc:create(function ()
				showIconsHightLight()
			end)

		local seq_arr = {}
		table.insert(seq_arr,cc.DelayTime:create(0.5))
		table.insert(seq_arr,call_action)
		local seq = cc.Sequence:create(seq_arr)
		imgLine:runAction( seq )

	else
		self:showActionEffect()
	end

	shuihu_manager._quanPanRewardType = nil
end

--播放动作音效
function CShuiHuMainScene:playActionMusic()
	--选择最后一条线的音效播发
	local indexdata = self._lineRewardListVect[#self._lineRewardListVect]

    print("奖励icon", indexdata.icon)
	local musicid = shuihu_icon_config[indexdata.icon].music2
	audio_manager:playOtherSound(musicid)
end

--通过索引列表 获得 该线上中奖的图标对象列表
function CShuiHuMainScene:getGridObjListByIndexList( indexdata )
	local objList = {}
	for i,v in ipairs(indexdata.indexs) do
		local lineIconPos = self._lineGridListVect[indexdata.line]

		local row = lineIconPos[v+1].row
		local col = lineIconPos[v+1].col
		local obj = self.allGridObjList[row][col]
		obj:setRewardIconId(indexdata.icon)
		table.insert(objList, obj)
	end

	return objList
end

--获得所有中奖的图标对象列表  不存在重复
function CShuiHuMainScene:getAllRewardObj()
	local objList = {}

	--如果是全盘奖
	if shuihu_manager._quanPanRewardType then
		for i,v in ipairs(self.allGridObjList) do
			for k, rewardObj in ipairs(v) do
				table.insert(objList, rewardObj)
			end
		end

		return objList
	end

	local insertList = {}
	for k, rewardData in ipairs(self._lineRewardListVect) do
		for i,v in ipairs(rewardData.indexs) do
			local lineIconPos = self._lineGridListVect[rewardData.line]

			local row = lineIconPos[v+1].row
			local col = lineIconPos[v+1].col
			local obj = self.allGridObjList[row][col]
			if insertList[obj] == nil then
				table.insert(objList, obj)
				insertList[obj] = true
			end
		end
	end

	return objList
end

--展示动作特效  所有动作一起播发
function CShuiHuMainScene:showActionEffect()
	local objList = self:getAllRewardObj()

	local function overCallBack()
		self:showBetLines()

		performWithDelay(self, function ()
			self:effectShowOverCallBack()
		end, 0.3)
       
		--有一个播发完结  就删除所有特效
		for i,v in ipairs(objList) do
			v:clearAnimation()
		end
	end

	for i,v in ipairs(objList) do
		v:playActionAnimation(overCallBack)
	end

	if #objList == 0 then  --无奖励
		for i,v in ipairs(self.allGridObjList) do
			for k, rewardObj in ipairs(v) do
				rewardObj:setIconGray()
			end
		end

		self:showBetLines()

		performWithDelay(self, function ()
			self:effectShowOverCallBack()
		end, 0.3)

        --无奖励音效
        audio_manager:playOtherSound(44)
	else
		self:playActionMusic()
	end

	shuihu_manager:showWordTips( 4 )
end

--特效展示完毕  回调 
function CShuiHuMainScene:effectShowOverCallBack()
	if shuihu_manager._xiaoMaLiCount > 0 then
		shuihu_manager:showReplacePanelAnimation(function ()
			self:showLettleMariePanel()
		end)
	else
		--是否是  挂机状态
		if shuihu_manager._isAutoPlayGame then
			if long_compare(shuihu_manager._shuiHuCurWin, 0) > 0 then
				--自动比倍次数
				if shuihu_manager._compareCount > 0 then
					--是否是双比  存在身上钱不够双比的情况
					if shuihu_manager._compareType == shuihu_manager.COMPARE_TYPE_DOUBEL and
						long_compare(shuihu_manager._ownChips, shuihu_manager._shuiHuCurWin) < 0 then
						shuihu_manager:reqSettleCountsGame()
					else
						shuihu_manager:showComparePanel()
					end
					
				else
					shuihu_manager:reqSettleCountsGame()
				end
			else
				--结算告诉后端
				shuihu_manager:reqSettleCountsGame()
			end
		else--展示结算界面
			--赢钱可显示结算界面
			if long_compare(shuihu_manager._shuiHuCurWin, 0) > 0 then
				self:showSettleAccountsPanel(false, nil, function ()
					shuihu_manager:showComparePanel()
				end)
			else
				--结算告诉后端
				shuihu_manager:reqSettleCountsGame()
			end
			--shuihu_manager._gameIsGoing = false

			self.betPanel:setButtonsEnable(true)
		end
	end
end

function CShuiHuMainScene:setBetPanelButtonEnabled( value )
	self.betPanel:setButtonsEnable(value)
end

--显示小玛丽界面
function CShuiHuMainScene:showLettleMariePanel()
	--小玛丽游戏
	if self.lettleMariePanel == nil then
		self.lettleMariePanel = CLittleMarieGameExt.create()
		self.shuihu_ui.panelContent:addChild(self.lettleMariePanel, 4)
		self.lettleMariePanel:setPosition(0,0)
		self.lettleMariePanel:setAnchorPoint(0,0)
	end
	self.lettleMariePanel:onShow()
end

--显示/隐藏挂机设置
function CShuiHuMainScene:showHideAutoSetPanel()
	self.betPanel:showHideAutoSetPanel()
end

--快捷开始水浒传游戏
function CShuiHuMainScene:quickStartGame()
	self.betPanel:quickStartGame()
end


--开始小玛丽
function CShuiHuMainScene:startlittleMarie()
	if self.lettleMariePanel then
		self.lettleMariePanel:startGame()
	end
end


--显示下注提示
function CShuiHuMainScene:showBetTips()
	self:resetTips()
	self.shuihu_ui.imgPleaseBet:runAction(cc.RepeatForever:create(cc.Blink:create(1.5,1)))
	self.shuihu_ui.imgPleaseBet:setVisible(true)
end


--显示开始提示
function CShuiHuMainScene:showStartTips()
	self:resetTips()
	self.shuihu_ui.imgPleaseStart:runAction(cc.RepeatForever:create(cc.Blink:create(1.5,1)))
	self.shuihu_ui.imgPleaseStart:setVisible(true)
end

--显示好运提示
function CShuiHuMainScene:showGoodLuckTips()
	self:resetTips()
	self.shuihu_ui.imgGoodLuck:runAction(cc.RepeatForever:create(cc.Blink:create(1.5,1)))
	self.shuihu_ui.imgGoodLuck:setVisible(true)
end

--显示赢钱提示
function CShuiHuMainScene:showWiningTips()
	self:resetTips()
	self.shuihu_ui.imgWin:runAction(cc.RepeatForever:create(cc.Blink:create(1.5,1)))
	self.shuihu_ui.fntWin:setString(shuihu_manager._shuiHuCurWin)
	self.shuihu_ui.imgWin:setVisible(true)
end

--显示请比倍提示
function CShuiHuMainScene:showCompareTips()
	self:resetTips()
	self.shuihu_ui.imgCompare:runAction(cc.RepeatForever:create(cc.Blink:create(1.5,1)))
	self.shuihu_ui.imgCompare:setVisible(true)
end

function CShuiHuMainScene:resetTips()
	self.shuihu_ui.imgPleaseBet:setVisible(false)
	self.shuihu_ui.imgPleaseBet:stopAllActions()

	self.shuihu_ui.imgWin:setVisible(false)
	self.shuihu_ui.imgWin:stopAllActions()

	self.shuihu_ui.imgGoodLuck:setVisible(false)
	self.shuihu_ui.imgGoodLuck:stopAllActions()

	self.shuihu_ui.imgPleaseStart:setVisible(false)
	self.shuihu_ui.imgPleaseStart:stopAllActions()

	self.shuihu_ui.imgCompare:setVisible(false)
	self.shuihu_ui.imgCompare:stopAllActions()
end

--显示人物等待动画
function CShuiHuMainScene:showHumenWaitAnimaition()
	if self.leftAnimation then
		self.leftAnimation:removeFromParent()
		self.leftAnimation = nil
	end

	if self.rightAnimation then
		self.rightAnimation:removeFromParent()
		self.rightAnimation = nil
	end

	local v,sprite = animationUtils.createAnimation(shuihu_effect_config["drum"])
	self.shuihu_ui.kuang_img:addChild(sprite)
	sprite:setPosition(7,873)
	sprite:setAnchorPoint(0,0)
	self.leftAnimation = sprite

	self.rightAnimation = animationUtils.createAndPlayAnimation(self.shuihu_ui.kuang_img, shuihu_effect_config["wait"])
	self.rightAnimation:setPosition(1188,852)
	self.rightAnimation:setAnchorPoint(0,0)
end

--显示人物激进动画
function CShuiHuMainScene:showHumenPlayAnimaition()
		if self.leftAnimation then
		self.leftAnimation:removeFromParent()
		self.leftAnimation = nil
	end

	if self.rightAnimation then
		self.rightAnimation:removeFromParent()
		self.rightAnimation = nil
	end

	self.leftAnimation = animationUtils.createAndPlayAnimation(self.shuihu_ui.kuang_img, shuihu_effect_config["drum"])
	self.leftAnimation:setPosition(7,873)
	self.leftAnimation:setAnchorPoint(0,0)

	self.rightAnimation = animationUtils.createAndPlayAnimation(self.shuihu_ui.kuang_img, shuihu_effect_config["start"])
	self.rightAnimation:setPosition(1246,875)
	self.rightAnimation:setAnchorPoint(0,0)
end