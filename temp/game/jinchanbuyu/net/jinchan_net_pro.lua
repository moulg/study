
require "game.jinchanbuyu.net.server.rec_parse_jcby"
require "game.jinchanbuyu.net.server.rec_pro_jcby"
require "game.jinchanbuyu.net.server.send_jcby"

--[[
	与服务器交互接口
]]

JinChanNetPro = {}


--[[
	进入游戏大厅返回房间数据消息
	msg = {
		名称:roomTypes 类型:List<RoomTypeDetailInfo> 备注:房间
	}
]]
function JinChanNetPro.recEnterGameHallMsg(msg)
	local pinfo 				= get_player_info()
	pinfo.myRoomTypeInfo 		= msg.roomTypes
	pinfo.curGameID 			= 9
	pinfo.curGameDeskClassName 	= "JinChanDesk"

	local gamelobby = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
	if gamelobby then
		gamelobby:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL)
	end
end

--[[
	进入牌桌结果消息
	msg = {
		名称:mems 类型:List<com.wly.game.gamehall.dto.MemInfo> 备注:牌桌中的玩家信息
	}
]]
function JinChanNetPro.recEnterTableMsg(msg)

	local members 	= msg.mems
	local pinfo 	= get_player_info()
    pinfo.myTableId = members[1].tableId
	
	WindowScene.getInstance():replaceModuleByModuleName("jinchan")
	HallManager:enterTableHandler(msg)

	local obj = WindowScene.getInstance():getModuleObjByClassName("Jinchanbuyu")
	if obj then
		for k,v in pairs(members) do
			local info = {
				player_id 	= v.playerId,
				set_id 		= v.order + 1,
				is_local 	= player_is_myself(v.playerId),
				chips 		= v.chips,
			}
			obj:setUserInfo(info)
		end
	end
end

--[[
	其他人进入桌子消息
	msg = {
		名称:battery 类型:BatteryInfo 备注:炮台
		名称:mem 类型:com.wly.game.gamehall.dto.MemInfo 备注:进入桌子的其他玩家
	}
]]
function JinChanNetPro.recOtherPlayerEnterTableMgs(msg)

	local member = msg.mem
	local obj = WindowScene.getInstance():getModuleObjByClassName("Jinchanbuyu")
	if obj then
		local info = {
			player_id 	= msg.battery.playerId,
			set_id 		= msg.battery.order + 1,
			is_local 	= player_is_myself(msg.battery.playerId),
			chips 		= member.chips,
		}
		obj:setOtherPlayerUserInfo(info)
		obj:cutBattery(msg.battery.order + 1,msg.battery.num,msg.battery.score,msg.battery.power)
	end
end

--[[
	玩家请求退出房间牌桌结果消息
	msg = {
		名称:order 类型:int 备注:座位顺序
		名称:playerId 类型:long 备注:玩家id
	}
]]
function JinChanNetPro.recExitTableMsg(msg)
	if WindowScene.getInstance():getCurModuleName() == "game_lobby" then
		return 
	end

	print("order == " ..msg.order + 1)

	local obj = WindowScene.getInstance():getModuleObjByClassName("Jinchanbuyu")
	if obj then
		if obj:isMySet(msg.order + 1) == true then
			WindowScene.getInstance():replaceModuleByModuleName("game_lobby")
			local lobby_obj = WindowScene.getInstance():getModuleObjByClassName("CGameLobby")
			if lobby_obj then lobby_obj:showPanelByType(CGameLobby.PANEL_TYPE_SECOND_HALL) end
		else
			obj:removeSet(msg.order + 1)

			--HallManager:informPlayerExitGame(name)
		end
	end
end

--[[
	玩家切换炮台结果消息
	msg = {
		名称:battery 类型:BatteryInfo 备注:炮台
	}
	BatteryInfo = {
		playerId, --玩家id
		order, --座位顺序
		score, --炮管分数
		num, --炮管数量
		power, --是否能量炮(0:不是,非0:能量炮)
	}
]]
function JinChanNetPro.recCutBattery(msg)
	local obj = WindowScene.getInstance():getModuleObjByClassName("Jinchanbuyu")
	if obj then
		obj:cutBattery(msg.battery.order + 1,msg.battery.num,msg.battery.score,msg.battery.power)
	end
end

--[[
	玩家请求开炮结果消息
	msg = {
		名称:playerId 类型:long 备注:发炮玩家
		名称:order 类型:int 备注:位置
		名称:bulletId 类型:int 备注:子弹id
		名称:angle 类型:int 备注:夹角
	}
]]
function JinChanNetPro.recFire(msg)
	local obj = WindowScene.getInstance():getModuleObjByClassName("Jinchanbuyu")
	if obj and obj:isAccessServerMessage() == true then
		obj:runSendBullet(msg.order + 1,msg.bulletId,msg.angle)
	end
end

--[[
	子弹打死鱼消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:位置
		名称:dies 类型:List<FinshDieInfo> 备注:死亡的鱼
		FinshDieInfo = {
			fishId, --鱼id
			score, --分数
		}
	}
]]
function JinChanNetPro.recShotFish(msg)
	local obj = WindowScene.getInstance():getModuleObjByClassName("Jinchanbuyu")
	if obj and obj:isAccessServerMessage() == true then
		-- for k,v in pairs(msg.dies) do
		-- 	obj:fishDeath(msg.order + 1,v.fishId,v.score)
		-- end
		obj:fishLstDeath(msg.order + 1,msg.dies)
	end
end


--[[
	玩家筹码变化消息消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:座位顺序
		名称:chips 类型:long 备注:兑换的游戏币后的筹码
	}
]]
function JinChanNetPro.recChipsChange(msg)
	local obj = WindowScene.getInstance():getModuleObjByClassName("Jinchanbuyu")
	if obj then
		obj:updateScore(msg.order + 1,msg.chips)
	end
end

--[[
	切换场景消息
	msg = {
		名称:scene 类型:int 备注:场景id
	}
]]
function JinChanNetPro.recCutScene(msg)
	local obj = WindowScene.getInstance():getModuleObjByClassName("Jinchanbuyu")
	if obj and obj:isAccessServerMessage() == true then
		obj:cutScene(msg.scene)
	end
end


--[[
	产生鱼消息消息
	msg = {
		名称:fishs 类型:List<FinshInfo> 备注:鱼
	}
	FinshInfo = {
		id, --鱼id
		type, --鱼的类型
		x, --起点x
		y, --起点y
		road, --路径id
		t, --时间ms
		angle, --夹角(负数不处理)
	}
]]
function JinChanNetPro.recFreshFish(msg)
	local obj = WindowScene.getInstance():getModuleObjByClassName("Jinchanbuyu")
	if obj and obj:isAccessServerMessage() == true then
		for k,v in pairs(msg.fishs) do
			local info = {
				object_id 	= v.id,
				fish_id 	= v.type,
				spos 		= {x = v.x,y = v.y,},
				cve_id 		= v.road,
				run_t 		= v.t/1000,
				user_info 	= {},
				angle 		= v.angle,
			}
			--print("oid:" .. info.object_id .. " fid:" .. info.fish_id .. " pos:" .. info.spos.x .. "," .. info.spos.y .. " cid:" .. info.cve_id .. " t:" ..info.run_t .. "agl:" .. v.angle)
			--if v.angle >= 0 then	info.angle =  360 - v.angle end
			obj:freshFish(info)
		end
	end
end

--[[
	玩家请求场景数据结果消息
	msg = {
		名称:scenceId 类型:int 备注:场景id
		名称:fishs 类型:List<FinshInfo> 备注:鱼
		名称:batterys 类型:List<BatteryInfo> 备注:炮台
		名称:insteadPlayers 类型:List<long> 备注:代发碰撞玩家列表
	}
]]
function JinChanNetPro.recEnterScene(msg)
	local obj = WindowScene.getInstance():getModuleObjByClassName("Jinchanbuyu")
	if obj then
		obj:enterScene(msg.scenceId)

		for k,v in pairs(msg.fishs) do
			local info = {
				object_id 	= v.id,
				fish_id 	= v.type,
				spos 		= {x = v.x,y = v.y,},
				cve_id 		= v.road,
				run_t 		= v.t/1000,
				user_info 	= {},
			}
			--print("oid:" .. info.object_id .. " fid:" .. info.fish_id .. " pos:" .. info.spos.x .. "," .. info.spos.y .. " cid:" .. info.cve_id .. " t:" .. info.run_t)
			if v.angle > 0 then	info.angle = 360 - v.angle end
			obj:freshFish(info)
		end

		for k,v in pairs(msg.batterys) do
			obj:cutBattery(v.order + 1,v.num,v.score,v.power)
		end

		obj:setInsteadPlayerLst(msg.insteadPlayers)
	end
end

--[[
	玩家请求锁定结果消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:位置
		名称:fishId 类型:int 备注:锁定鱼
	}
]]
function JinChanNetPro.recLockFish(msg)
	local obj = WindowScene.getInstance():getModuleObjByClassName("Jinchanbuyu")
	if obj then
		obj:setLockFish(msg.order + 1,msg.fishId)
	end
end

--[[
	玩家取消锁定消息
	msg = {
		名称:playerId 类型:long 备注:玩家id
		名称:order 类型:int 备注:位置
	}
]]
function JinChanNetPro.recUnLockFish(msg)
	local obj = WindowScene.getInstance():getModuleObjByClassName("Jinchanbuyu")
	if obj then
		obj:unLockFish(msg.order + 1)
	end
end

--[[
	李逵升级消息
	msg = {
		名称:fishId 类型:int 备注:李逵的鱼id
		名称:rate 类型:int 备注:升级后的倍率
	}
]]
function JinChanNetPro.recChangeFishLevel(msg)
	local obj = WindowScene.getInstance():getModuleObjByClassName("Jinchanbuyu")
	if obj then
		obj:setFishShowLevel(msg.fishId,msg.rate)
	end
end

--[[
	代发碰撞玩家列表更新消息
	msg = {
		名称:insteadPlayers 类型:List<long> 备注:代发碰撞玩家列表
	}
]]
function JinChanNetPro.recInsteadPlayerLst(msg)
	local obj = WindowScene.getInstance():getModuleObjByClassName("Jinchanbuyu")
	if obj then
		obj:setInsteadPlayerLst(msg.insteadPlayers)
	end
end

