
local ui_panel
-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

CGameTypeItem = class("CGameTypeItem", function ()
	local ret = ccui.Button:create()
	ret:setScale9Enabled(true)
	ret:setContentSize(400,500)
	--ret:loadTextures("lobby/resource/gameType/by.png","")
    return ret	
end)


function CGameTypeItem:create(gameType, callback)
	local obj = CGameTypeItem.new()
	if obj ~= nil then
		obj:init_data(gameType, callback)
		obj:init_ui()
		obj:registerEE()
	end

	return obj
end

function CGameTypeItem:init_data(gameType, callback)
	self.gameType = gameType
	self.callback = callback
end

function CGameTypeItem:registerEE()
	local function __on_enter_exit(event)
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__on_enter_exit)
end

function CGameTypeItem:onEnter()
	
end

function CGameTypeItem:onExit()
	--self:removeFrameCache()	
end

function CGameTypeItem:init_ui()
	self:addFrameCache()
	self:registerHandler()
end

function CGameTypeItem:registerHandler()
	self:onTouch(function ( e )
		if e.name == "ended" then
			self.callback(self.gameType.id)
			global_music_ctrl.play_btn_one()
			self:setScale(1.0)
		elseif e.name == "began" then
			self:setScale(1.1)
		elseif e.name == "cancelled" then 
			self:setScale(1.0)
		elseif e.name == "moved" then 
			self:setScale(1.1)
		end
	end)
end

function CGameTypeItem:addFrameCache()
	local atlasPath = self.gameType.atlasPath
	local jsonPath = self.gameType.jsonPath
	local actName = self.gameType.actName
	if atlasPath and jsonPath and  actName then
		
		self.ani_spr = sp.SkeletonAnimation:create( jsonPath, atlasPath,1.0)
		self.ani_spr:setAnimation(0,actName,true)
		self.ani_spr:setPositionX(self:getContentSize().width/2)
		self.ani_spr:setTimeScale(1+0.2^self.gameType.id)
		--self.ani_spr:setDebugBonesEnabled(true) 
		--self.ani_spr:setDebugSlotsEnabled(true)
		self:addChild(self.ani_spr)
    end
end

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
