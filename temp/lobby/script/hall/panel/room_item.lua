#remark
-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

CRoomItem = class("CRoomItem", function ()
	local obj = ccui.Button:create()
	return obj
end)

function CRoomItem.create(info)
	local obj = CRoomItem.new()

	if obj ~= nil then obj:init(info) end

	return obj
end

function CRoomItem:init(info)
	self.roomInfo = info
	if self.roomInfo then
		self:loadTextures("lobby/resource/RoomList/" .. self.roomInfo.type .. ".png","")
		-- print("roomId============================================"..self.roomInfo.roomId)
		-- print("name=============================================="..self.roomInfo.name)
		-- print("type=============================================="..self.roomInfo.type)
		-- print("maxNum============================================"..self.roomInfo.maxNum)
		-- print("free=============================================="..self.roomInfo.free)
		-- print("general==========================================="..self.roomInfo.general)
		-- print("crowded==========================================="..self.roomInfo.crowded)
		-- print("lower============================================="..self.roomInfo.lower)
		-- print("upper============================================="..self.roomInfo.upper)
		-- print("proportionGold===================================="..self.roomInfo.proportionGold)
		
		-- print("proportionChips==================================="..self.roomInfo.proportionChips)
		-- print("tabble============================================"..self.roomInfo.tabble)
		-- print("afee=============================================="..self.roomInfo.afee)
		-- print("inType============================================"..self.roomInfo.inType)
		-- print("playerNum========================================="..self.roomInfo.playerNum)
		-- print("status============================================"..self.roomInfo.status)
		-- print("minOne============================================"..self.roomInfo.minOne)
		-- print("displayNames======================================"..self.roomInfo.displayNames)
		-- print("placeHolder======================================="..self.roomInfo.placeHolder)

		local displayNames = string.split(self.roomInfo.displayNames, ",")
		local placeHolder = string.split(self.roomInfo.placeHolder, ",")

		local text = ""
		
		for i=1,#displayNames do
			
			if placeHolder[i] and self.roomInfo[displayNames[i]] then

				local temp = textUtils.connectParam( placeHolder[i], { self.roomInfo[displayNames[i]] } )
				text = text..temp.."\n"
			end
		end

		print(text)

		local info = ccui.Text:create()
		info:setFontName("simhei.ttf")
		info:setFontSize(28)
		info:setTextHorizontalAlignment(1)
		info:setTextVerticalAlignment(1)
		info:setString(text)
		info:setAnchorPoint(0,1)
		info:setPosition(100.0000, 5.0000)
		info:setTextColor({r = 255, g = 178, b = 29})
		self:addChild(info)

        local title = ccui.ImageView:create()
        title:loadTexture("lobby/resource/RoomList/".."1_".. self.roomInfo.type .. ".png")
        title:setPosition(100.0000, 5.0000)
        self:addChild(title)

		-- local str_id = string.sub(self.roomInfo.name,-1)
		-- local text1 =  self.roomInfo
		-- local fnt_id = ccui.TextBMFont:create()
		-- fnt_id:setFntFile("lobby/resource/fnt_font/roomNum.fnt")
		-- self:addChild(fnt_id)

		-- fnt_id:setString(str_id)
		-- fnt_id:setPosition(190,190)
		
		self:onTouch(function ( e )
			if e.name == "ended" then
				HallManager:reqEnterCurGameRoom(self.roomInfo.roomId)
				global_music_ctrl.play_btn_one()
				WaitMessageHit.showWaitMessageHit(1)
			end
		end)
	end
end

