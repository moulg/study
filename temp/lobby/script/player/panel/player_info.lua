#remark
--[[
	玩家数据，包含所有游戏数据
]]
local player_info = {
	id = 0 , --账号id
	head_id = 1, --头像id
	name = "", --玩家名字
	serverId = 0, --服务器id
	level = 0, --玩家等级
	vipLevel = 0, --vip等级
	gold = 0, --金币
	acer = 0, --元宝
	safeGold = 0, --银行中的金币
	integral = 0, --积分
	lottery = 0, --奖券
	vipTime = 0, --vip时长 
	myTableId = 0, --桌子

	password  = "", --玩家密码
	user_name = "", --登陆用户名
	is_have_login = false, --是否登陆
	is_tourist = false, --是否是游客

	chose_login_mod = 1, --选择的登陆方式，0为账号登陆，1为游客登陆 2微信 3 手机

	phone            = "",  --电话
	email 			 = "",	--邮箱
	fullName         = "",	-- 玩家姓名
	sex        		 = "女",--性别
	idCardNo         = "",	-- 玩家身份证号
	age              = 18,	-- 年龄
	birthMonth       = 1, 	-- 出生月
	birthDay         = 1,	-- 出生日
	province         = "",	-- 省
	city             = "",	-- 市
	addr             = "",	-- 地址
	signature        = "",	-- 签名
	bindingMac       = "",	-- 绑定机器码
	havePwdProtect	 = 0,	--是否有密保(0:没有,非0:有)
	loginPhoneVerify = 0,	-- 登录是否需要手机验证(0:不需要，非0:需要)
	playItemEffect   = 0,	-- 是否需要播放道具使用特效(0:不需要，非0:需要)

	myRoomTypeInfo = {}, --所有房间的信息
	myDesksInfo = {}, --当前房间所有桌子信息
	curGameID = nil,
	curMatchRoomID = nil,
	curGameDeskClassName = "", --当前游戏桌子类名
	curGameRoomClassName = "", --当前游戏房间类名

	backpack_list = {},--玩家背包数据 item = {id,num,}
	noticeList = nil ,--活动公告列表
	selectGameType = -1, -- 当前游戏类别

	selectGameType = -1, -- 当前游戏类别
	bankCardnumber="",		--银行卡号
}

function player_info:updateRoomInfo(id, num)
	for k,roomsData in pairs(self.myRoomTypeInfo) do
		for k,room in pairs(roomsData.rooms) do
			if room.roomId == id then
				room.playerNum = num
				return
			end
		end
	end
end


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。


function player_info:updateDeskInfo(value)
	for k, desk in pairs(self.myDesksInfo) do
		if desk.id == value.tableId then
			for i,seat in pairs(desk.seats) do
				if seat.order == value.order then
					desk.seats[i] = value
					return true
				end
			end
		end
	end

	return false
end

--更新座子密码
function player_info:updateDeskPassWord( id, password )
	for k, desk in pairs(self.myDesksInfo) do
		if desk.id == id then
			desk.hasPwd = password
		end
	end	
end

function get_player_info()
	-- body
	return player_info
end

function get_player_goldStr()
	-- body
	if long_compare(player_info.gold, 10000) == 1 then --万
		return long_divide(player_info.gold, 10000).."万"
	elseif long_compare(player_info.gold, 10000*1000) == 1 then --千万
		return long_divide(player_info.gold, 10000*1000).."千万"
	elseif long_compare(player_info.gold, 10000*10000) == 1 then	--亿
		return long_divide(player_info.gold, 10000*10000).."亿"
	else
		return player_info.gold
	end
end

--是否是自己
function player_is_myself(value)
	if long_compare(player_info.id, value) == 0 then
		return true
	else
		return false
	end
end

--获得当前房间的数据
function player_info:get_cur_roomInfo()
	for k,roomsData in pairs(self.myRoomTypeInfo) do
		for k,room in pairs(roomsData.rooms) do
			if room.roomId == self.myDesksInfo[1].roomId then
				
				return room, roomsData
			end
		end
	end	
end

--获得当前比赛房间的数据
function player_info:get_cur_matchRoomInfo()
	for k,roomsData in pairs(self.myRoomTypeInfo) do
		for k,room in pairs(roomsData.rooms) do
			if room.roomId == self.curMatchRoomID then
				
				return room
			end
		end
	end	
end

--更新登陆成功记录
function update_login_state(blogin)
	player_info.is_have_login = blogin
end

