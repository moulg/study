
local panel_ui = require "game.ddz_match_std.script.ui_create.ui_ddzMatch_desk"

local _contentSize = cc.size(832, 590)

CDdzMatchDesk = class("CDdzMatchDesk", function ()
	-- body
	local  ret = ccui.ImageView:create()
	ret:setScale9Enabled(true)
    ret:setContentSize(_contentSize)
    ret:setAnchorPoint(0, 0)
	return ret
end)

function CDdzMatchDesk.getContentSize()
	return _contentSize
end

function CDdzMatchDesk.create()
	-- body
	local layer = CDdzMatchDesk.new()
	if layer ~= nil then
		layer:init_ui()
		layer:regEnterExit()
		return layer
	end
end

function CDdzMatchDesk:regEnterExit()
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

function CDdzMatchDesk:onEnter()
	self:playAction()
end

function CDdzMatchDesk:onExit()
	timeUtils:remove(self)
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.panel_ui.btnApply)
	WindowScene.getInstance():unregisterBtnMouseMoveEff(self.panel_ui.btnCancel)

	for i,v in ipairs(self._rewardList) do
		v:removeFromParent()
	end
	self._rewardList = nil
end

function CDdzMatchDesk:init_ui()
	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)

	self._rewardList = {}

	self:registerHandler()
	self:addButtonHightLight()

	self.maskLayer, self.maskDemo = uiUtils.createMask( "game/ddz_match_std/resource/image/sz.png" )
	self.maskLayer:setAnchorPoint(0.5,0.5)
	self.maskLayer:setPosition(104, 144)
	self:addChild(self.maskLayer)
	self.maskDemo:setAnchorPoint(0.5,0.5)
	local size = self.maskDemo:getContentSize()
	self.maskDemo:setPosition(size.width/2, size.height/2)
	self.maskDemo:setScale(0, 1)

	local spr = cc.Sprite:create("game/ddz_match_std/resource/image/sz.png")
	self.maskLayer:addChild(spr)
	spr:setAnchorPoint(0,0)

	self.fntJoinNum = ccui.TextBMFont:create()
	self.fntJoinNum:setFntFile("game/ddz_match_std/resource/number/peopleNum.fnt")
	self.fntJoinNum:setString("1r1")
	spr:addChild(self.fntJoinNum)
	self.fntJoinNum:setPosition(435, 192)

	self.nodeReward = cc.Node:create()
	spr:addChild(self.nodeReward)
	self.nodeReward:setPosition(329, 70)

	self.leftBar = cc.Sprite:create("game/ddz_match_std/resource/image/bangzi.png")
	self.leftBar:setFlippedX(true)
	self.leftBar:setPosition(432,300)
	self:addChild(self.leftBar)

	self.rightBar = cc.Sprite:create("game/ddz_match_std/resource/image/bangzi.png")
	self.rightBar:setPosition(432,300)
	self:addChild(self.rightBar)

end


function CDdzMatchDesk:addButtonHightLight()
	--注册按钮高亮事件
	local mov_obj = cc.Sprite:create("game/ddz_match_std/resource/button/baoming2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.btnApply,mov_obj,1)
	local mov_obj = cc.Sprite:create("game/ddz_match_std/resource/button/quxiaobaoming2.png")
	WindowScene.getInstance():registerBtnMouseMoveEff(self.panel_ui.btnCancel,mov_obj,1)
end

function CDdzMatchDesk:registerHandler()
	self.panel_ui.btnApply:onTouch(function (e)
		if e.name == "ended" then
			send_doudizhu_ReqApply()
		end
	end)
	self.panel_ui.btnCancel:onTouch(function (e)
		if e.name == "ended" then
			send_doudizhu_ReqCancelApply()
		end
	end)
end

--[[
	MatchInfo = {
		type, --1:快速赛,2:定时赛
		matchNum, --比赛人数
		appliedNum, --已报名玩家人数
		leftTime, --剩余开赛时间(秒,定时赛才有效)
		reward, --奖励字符串
	}
]]
function CDdzMatchDesk:setDeskInfo( matchInfo )
	local wordStr
	
	if matchInfo.type == 2 then
		--人数
		self.panel_ui.labBeginNum:setString("")

		--开赛时间
		wordStr = "开赛时间："..textUtils.unixTimeToFormat( matchInfo.matchTime , false, false, false, true, true)
		self.panel_ui.labWaitTime:setString(wordStr)

		--开赛剩余时间
		timeUtils:addTimeDown(self, matchInfo.leftTime, function ( t )
			local str = textUtils.timeToSecondStr( t )
			wordStr = "离开赛还有"..str
			self.panel_ui.labBeginTime:setString(wordStr)
		end)
		
		local str = textUtils.timeToSecondStr( matchInfo.leftTime )
		wordStr = "离开赛还有"..str
		self.panel_ui.labBeginTime:setString(wordStr)

		self.fntJoinNum:setString(matchInfo.matchNum)
	else
		--人数
		wordStr = "满"..matchInfo.matchNum.."人开赛"
		self.panel_ui.labBeginNum:setString(wordStr)

		--开赛时间
		wordStr = "预计等待时间120秒"
		self.panel_ui.labWaitTime:setString(wordStr)
		timeUtils:remove(self)

		--开赛剩余时间
		self.panel_ui.labBeginTime:setString("")

		wordStr = matchInfo.appliedNum.."r"..matchInfo.matchNum
		self.fntJoinNum:setString(wordStr)
	end

	

	self.panel_ui.loadingBar:setPercent(matchInfo.appliedNum * 100 / matchInfo.matchNum)

	if #self._rewardList == 0 then
		self:setRewardInfo(matchInfo.reward)
		self.panel_ui.sprMatchTitle:setTexture(ddz_match_type_config[matchInfo.type].titleRes)
	end
end

function CDdzMatchDesk:matchApplyResult( value )
	if value then
		self.panel_ui.btnApply:setVisible(false)
		self.panel_ui.btnCancel:setVisible(true)
	else
        self.panel_ui.btnApply:setVisible(true)
		self.panel_ui.btnCancel:setVisible(false)
	end
end

function CDdzMatchDesk:setRewardInfo( rewardsJson )
	local rewardsTab = json.decode(rewardsJson)
	local ranks = table.keys(rewardsTab)
	local itemSize
	local beginRank = 1

	table.sort( ranks, function(id1, id2)
        if tonumber(id1) < tonumber(id2) then
            return true
        else
            return false
        end
    end )
	for i,v in ipairs(ranks) do
		local item = CDdzMatchRewardItem.create()
		item:setRewardInfo(tonumber(beginRank), tonumber(v), rewardsTab[v])

		table.insert(self._rewardList, item)
		self.nodeReward:addChild(item)

		itemSize = item:getContentSize()
		beginRank = v
	end

	local diffW = itemSize.width + 30
	local num = #ranks
	local beginX = -(num - 1)*diffW/2
	for i,v in ipairs(self._rewardList) do
		local px = beginX + (i - 1) * diffW
		v:setPositionX(px)
	end
end

function CDdzMatchDesk:playAction()
	local actionScaleTo = cc.ScaleTo:create(1, 1, 1)
	self.maskDemo:runAction(actionScaleTo)

	self.leftBar:runAction(cc.MoveBy:create(1, cc.p(-328, 0)))
	self.rightBar:runAction(cc.MoveBy:create(1, cc.p(328, 0)))
end