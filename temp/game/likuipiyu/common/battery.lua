
--[[
	炮台
]]

--[[
	side 1->left,2->right,3->top,4->bottom
]]

local __battery_ui_creater = require "game.likuipiyu.ui.ui_likuipiyu_battery"

local pi = 3.1415926
local pi_angle = 180

local battery_zorder =  3000000


Battery = class("Battery",function ()
	local obj = cc.Node:create()
	return obj
end)


function Battery.create()
	local obj = Battery.new()
	if obj then
		obj:init()
	end

	return obj
end

function Battery:init()
	self:initData()
	self:initUI()
	self:registerEE()
	--self:registerUpdate()
	--self:registerMouseEvent()
	self:registerTouch()
end

function Battery:initData()
	self.buse_mousemove_rotation = false --是否用鼠标移动控制炮台转动

	self.battery_config = {}
	self.side = 4
	self.cur_move_pos = {x = 0,y = 0,}
	self.cur_angle 	= 0
	self.bullet_send_dis = 60
	self.send_bullet_add_time = 0
	self.key_is_down = false

	self.gold_column_obj_lst = {} --金币柱对象列表

	self.user_info = {--用户数据
		player_id 	= 0, --玩家id
		set_id 		= 0,--坐位id
		is_local 	= true,--是否为本地，区别自己与别人的炮台
		chips 		= 0,--筹码
	}

	self.front_fish_data_id = -1--上一次锁定的鱼类型id

	--子弹发射速度
	self.send_bullet_v = 1


	self.cur_barrel_index = 1--炮管数索引

	self.is_have_enger = false --是否有能量炮

	self.is_auto_send = false -- 是否自动开炮
	self.is_auto_add_v = false --是否自动加速

	self.auto_exit_time = 60
	self.auto_exit_time_add = 0


	self.begin_pos = {x = 0,y = 0,}--开始点击位置
	self.move_pos  = {x = 0,y = 0,}--移动位置

	self.setID_changed = false			--被交换过
end

function Battery:initUI()
	self.ui_lst = __battery_ui_creater.create()
	self:addChild(self.ui_lst.root)

	-- self.ui_lst.SpriteNengliangpao:setVisible(false)
	-- self.energy_connon_size = self.ui_lst.SpriteNengliangpao:getContentSize()
	-- self.energy_connon_org_pos = {}
	-- self.energy_connon_org_pos.x,self.energy_connon_org_pos.y = self.ui_lst.SpriteNengliangpao:getPosition()

	-- self.ui_lst.SpriteSuoding:setVisible(false)
	-- self.lock_mark_size = self.ui_lst.SpriteSuoding:getContentSize()
	-- self.lock_org_pos = {}
	-- self.lock_org_pos.x,self.lock_org_pos.y = self.ui_lst.SpriteSuoding:getPosition()

	-- self.enger_org_pos = {}
	-- self.enger_org_pos.x,self.enger_org_pos.y = self.ui_lst.SpriteNengliangpao:getPosition()

	self.ui_lst.FntLv:setString("1")
	self.ui_lst.FntJifen:setString("0")


	self:setLocalZOrder(battery_zorder)
	battery_zorder = battery_zorder + 1

	self.no_money_spr = cc.Sprite:create("game/likuipiyu/resource/other/yubibuzhu.png")
	self.ui_lst.root:addChild(self.no_money_spr)
	self.no_money_spr:setVisible(false)
	self.no_money_spr:setAnchorPoint(0.17,0)
	self.no_money_spr:setPosition(1,90)

	self.running_init = true


	self.ui_lst.btnDda:onTouch(function (e)
		if e.name == "ended" then
			self:onMinusBarrelIndex()
		end
	end)

	self.ui_lst.btnAdd:onTouch(function (e)
		if e.name == "ended" then
			self:onAddBarrelIndex()
		end
	end)

end

function Battery:registerEE()
	local function __on_enter_exit(event)
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__on_enter_exit)
end

function Battery:registerUpdate()
	-- local function __battery_update(dt) self:update(dt) end
	-- local scheduler = cc.Director:getInstance():getScheduler()
	-- self.sch_handle = scheduler:scheduleScriptFunc(__battery_update,0.0,false)
end

function Battery:onEnter()
	
end

function Battery:onExit()
	-- local scheduler = cc.Director:getInstance():getScheduler()
	-- scheduler:unscheduleScriptEntry(self.sch_handle)
	
end

function Battery:registerMouseEvent()
	local function __on_mouse_move(e)
    	self:onMouseMove(e)
    end

    local function __on_mouse_up(e)
    	self:onMouseUp(e)
    end

    local mouse_listener = cc.EventListenerMouse:create()
	mouse_listener:registerScriptHandler(__on_mouse_move,cc.Handler.EVENT_MOUSE_MOVE)
	mouse_listener:registerScriptHandler(__on_mouse_up,cc.Handler.EVENT_MOUSE_UP)

	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(mouse_listener,self)
end

function Battery:registerTouch()
	local function __touch_began(touch, event) return self:onTouchBegan(touch) end
    local function __touch_moved(touch, event) return self:onTouchMoved(touch) end
    local function __touch_ended(touch, event) return self:onTouchEnded(touch) end
    
    local listener = cc.EventListenerTouchOneByOne:create()

    listener:registerScriptHandler(__touch_began,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(__touch_moved,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(__touch_ended,cc.Handler.EVENT_TOUCH_ENDED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)
end

function Battery:onTouchBegan(e)
	if self.user_info.is_local == true then
		--self.key_is_down = true

		if self:isLockFish() == true then return true end

		local cut_state = BackgroundSceneManager.getInstance():getSceneState()
        if (cut_state == 1) and self:isHaveEnoughScore() == true then
			send_lkby_ReqFire({angle = self.cur_angle,})
	    end

		if self.buse_mousemove_rotation == false then
			local local_pos  = e:getLocation()
			self:rotationBatteryByPos(local_pos)

			self.begin_pos = local_pos
		end
	end
	
	return true
end

function Battery:onTouchMoved(e)
	if self.user_info.is_local == true then
		--self.key_is_down = true

		if self:isLockFish() == true then 
			return true 
		end

		if self.buse_mousemove_rotation == false then
			local local_pos  = e:getLocation()
			self:rotationBatteryByPos(local_pos)

			self.move_pos = local_pos
		end
	end

	return true
end

function Battery:onTouchEnded(e)
	if self.user_info.is_local == true then
		self.key_is_down = false

		if (math.abs(self.begin_pos.x - self.move_pos.x) < 5 and math.abs(self.begin_pos.y - self.move_pos.y) < 5) or
			(self.move_pos.x == 0 and self.move_pos.y == 0) then
			local local_pos  = e:getLocation()
			self:lockFishByPoint(local_pos)

			if self:isLockFish() == true then
				print("lock fish pos(" .. local_pos.x .. "," .. local_pos.y .. ")")
				self:setAutoFire(true)
				if self.clrear_lock_call then
					self.clrear_lock_call()
				end
			end
		end

		self.begin_pos = {x = 0,y = 0,}
		self.move_pos  = {x = 0,y = 0,}
	end
	
	return false
end

function Battery:onMouseMove(e)

	-- if self.user_info.is_local == true then
	-- 	if self:isLockFish() == true then
	-- 		return 
	-- 	end

	-- 	if self.buse_mousemove_rotation == true then
	-- 		local local_pos  = e:getLocation()
	-- 		local global_pos = cc.Director:getInstance():convertToGL(local_pos)
	-- 		self:rotationBatteryByPos(global_pos)
	-- 	end
	-- end
end

function Battery:onMouseUp(e)
	local btn_type = e:getMouseButton()
	if btn_type == 0 then --left mouse button
	elseif btn_type == 1 then --right mouse button
		local local_pos  = e:getLocation()
		local global_pos = cc.Director:getInstance():convertToGL(local_pos)
		self:lockFishByPoint(global_pos)
	elseif btn_type == 2 then --center mouse button
	end
end

function Battery:onKeyDown(s)
	if self.user_info.is_local == true then
		if s == "space" then
			self:onSapceKeyDownPro()
		elseif s == "Z" then
			self:onZKeyDownPro()
		elseif s == "S" then
			self:onSKeyDownPro()
		elseif s == "Q" then
			self:onQKeyDownPro()
		end
	end
end

function Battery:onKeyUp(s)
	if self.user_info.is_local == true then
		if s == "space" then
			self:onSapceKeyUpPro()
		elseif s == "Z" then
			self:onZKeyUpPro()
		elseif s == "S" then
			self:onSKeyUpPro()
		elseif s == "Q" then
			self:onQKeyUpPro()
		elseif s == "up" or s == "f1" then
			self:onAddBarrelIndex()
		elseif s == "down" or s == "f2" then
			self:onMinusBarrelIndex()
		elseif s == "f3" or s == "right" then
			self:onAddScore()
		elseif s == "f4" or s == "left" then
			self:onMinusScore()
		elseif s == "f5" then
			self:onAddMaxScore()
		end
	end
end

function Battery:rotationBatteryByPos(pos)
	local pp_pos = {x = 0,y = 0,}

	pp_pos.x,pp_pos.y = self.ui_lst.ImgPaoguan:getPosition()
	local gl_pp_pos   = self.ui_lst.root:convertToWorldSpace(pp_pos)
	self.cur_angle 	  = self:getRotationAngle(pos,gl_pp_pos,self.side)

	local rotate_angle = self:getBatteryRotationAngle(self.cur_angle)

	self.ui_lst.ImgPaoguan:setRotation(rotate_angle)
end

function Battery:getBatteryRotationAngle(bangle)
	local rotate_angle = 0

	if self.side == 1 then
		rotate_angle = 2*pi_angle - bangle - pi_angle/2
	elseif self.side == 2 then
		rotate_angle = 2*pi_angle - bangle - pi_angle*3/2
	elseif self.side == 3 then
		rotate_angle = 2*pi_angle - bangle - pi_angle
	elseif self.side == 4 then
		rotate_angle = 2*pi_angle - bangle
	end

	return rotate_angle
end


--获取到为逆时针角度
function Battery:getRotationAngle(pos1,pos2,side)

	local angle = 0 
	if pos1.x == pos2.x then
		if side == 1 and pos1.y >= pos2.y then
			angle = 90
		elseif side == 1 and pos1.y < pos2.y then
			angle = 270
		elseif side == 2 and pos1.y >= pos2.y then
			angle = 90
		elseif side == 2 and pos1.y < pos2.y then
			angle = 270
		elseif side == 3 then
			angle = 270
		elseif side == 4 then
			angle = 90
		end
	else
		local k = (pos1.y - pos2.y)/(pos1.x - pos2.x)
		angle = math.atan(k)*pi_angle/pi


		if side == 1 and angle <= 0 then
			angle = 2*pi_angle + angle	
		elseif side == 2 then
			angle = pi_angle + angle
		elseif side == 3 and angle > 0 then
			angle = pi_angle + angle
		elseif side == 3 and angle <= 0 then
			angle = 2*pi_angle + angle
		elseif side == 4 and angle <= 0 then
			angle = pi_angle + angle
		end
	end

	return angle
end

--[[
	info = {
		config_id,
		user_info,
		side,
	}
	binit
]]
function Battery:setBatteryInfo(info,binit)
	local bat_cfg = battery_config[info.config_id]

	if bat_cfg then 
		self.battery_config = bat_cfg
		self.send_bullet_v  = self.battery_config.send_v
	end

	if info.user_info then self.user_info = info.user_info end
	if info.side then self.side = info.side end

	self:showEnterAnimation(binit)

	--do change src
	self:setBatterySrcByConfig(self.battery_config)
	self:setRotationAndPosBySide(self.side)
	--self:createGoldColumnObj(self.battery_config)
	self:createLockObj()

	self.ui_lst.FntJifen:setString(self.user_info.chips)

	if self:isMyBattery() == false then
		self.ui_lst.btnAdd:setVisible(false)
		self.ui_lst.btnDda:setVisible(false)
	end
end

function Battery:showEnterAnimation(binit)

	if self.user_info.is_local == true then
		local function __init_cmp_call()
			self.running_init = false
			print("init battery complete>>>>>>>>>")
		end

		local src_cfg1 = sprite_ani_config[lk_system_config.selfbat_enter_ani_id]
		jc_dyanplay_ani(self.ui_lst.root,src_cfg1,{x = 13,y = 164,},self.cur_angle,1,__init_cmp_call)

		local src_cfg2 = sprite_ani_config[lk_system_config.selfbat_hit_ani_id]
		jc_dyanplay_ani(self.ui_lst.root,src_cfg2,{x = 0,y = 180,},self.cur_angle,5)

		self:setOpacity(0)
		self:runAction(cc.FadeIn:create(0.8))
	else
		if binit == false then
			local src_cfg1 = sprite_ani_config[lk_system_config.otherbat_enter_ani_id]
			jc_dyanplay_ani(self.ui_lst.root,src_cfg1,{x = 13,y = 164,},self.cur_angle,1)

			self:setOpacity(0)
			self:runAction(cc.FadeIn:create(0.8))
		end
	end
end


function Battery:setBatterySrcByConfig(config)
	self.bullet_send_dis = self.battery_config.offset_dis

	local id_lst = self.battery_config.bubr_info[self.cur_barrel_index]
	local src_id = id_lst[3]
	if self.user_info.is_local == false then src_id = id_lst[4] end
	if self.is_have_enger == true then src_id = id_lst[5] end

	local frame_name = string.format(sprite_ani_config[src_id].pattern,1)
	self.ui_lst.ImgPaoguan:setSpriteFrame(frame_name)

	
	local ani_key  = sprite_ani_config[src_id].key
	local exit_ani = cc.AnimationCache:getInstance():getAnimation(ani_key)
	if exit_ani == nil then
		local animation = self:createAnimation(sprite_ani_config[src_id],true)
		cc.AnimationCache:getInstance():addAnimation(animation,ani_key)
	end


	self.ui_lst.ImgJifenkuang:setSpriteFrame(self.battery_config.frame_key)
end

function Battery:setRotationAndPosBySide(side)
	if side == 1 then
		self.ui_lst.root:setRotation(90)
		self.cur_angle = 0
	elseif side == 2 then
		self.ui_lst.root:setRotation(270)
		self.cur_angle = 0
	elseif side == 3 then
		self.ui_lst.root:setRotation(180)
		self.cur_angle = 0
	elseif side == 4 then
		self.ui_lst.root:setRotation(0)
		self.cur_angle = 0
	end

	if setID_changed then
		self.cur_angle = 270
	end
end

function Battery:createGoldColumnObj(item)
	-- local gold_unit_number = FishGoldManager.getInstance():getUnitGoldNumber()
	-- local info = {
	-- 	parent = self.ui_lst.ImgDizhuo,
	-- 	spos  = item.gold_cl_spos,
	-- 	number = item.gold_cl_num,
	-- 	col_way = item.gold_cl_way,
	-- 	max_val = lk_system_config.gold_column_max_number*gold_unit_number,
	-- }
	-- self.gold_action_obj = GoldColumnAction.create(info)
end

function Battery:createLockObj()
	if self.lock_obj == nil then
		local fx,fy = self:getPosition()
		local info = {
			parent = self,
			side   = self.side,
			set_id = self.user_info.set_id,
			is_local = self.user_info.is_local,
			lkey   = self.battery_config.lock_line_key,
			offset_pos = {x = fx,y = fy,},
		}
		self.lock_obj = LockFish.create(info)

		local function __on_lock_call(fsh_id)
			self:sendLockMsg(fsh_id)
		end
		self.lock_obj:setLockCall(__on_lock_call)
	end
end

function Battery:sendLockMsg(fsh_id)
	if self.user_info.is_local == true then
		local msg  = {fishId = fsh_id,}
		--print("send lock msg fsh_id = " .. fsh_id .. "set id = " .. self.user_info.set_id)
		send_lkby_ReqLock(msg)
	end
end

function Battery:getSendBulletPos()
	local pp_pos = {}
	pp_pos.x,pp_pos.y = self.ui_lst.ImgPaoguan:getPosition()
	local gl_pp_pos = self.ui_lst.root:convertToWorldSpace(pp_pos)

	local sx = self.bullet_send_dis*math.cos((self.cur_angle/pi_angle)*math.pi)
	local sy = self.bullet_send_dis*math.sin((self.cur_angle/pi_angle)*math.pi)

	local send_pos = {x = gl_pp_pos.x + sx,y = gl_pp_pos.y + sy,}

	return send_pos
end

function Battery:update(dt)--call update at BatteryManager
	
	-- if self.gold_action_obj then
	-- 	self.gold_action_obj:update(dt)
	-- end

	if self.lock_obj then
		self.lock_obj:update(dt)
	end

	--run lock
	if self:isLockFish() == true then
		self.cur_angle = self.lock_obj:getCurrentLockAngle()

		local rotation_angle = 0
		if self.side == 1 then
			rotate_angle = 2*pi_angle - self.cur_angle - pi_angle/2
		elseif self.side == 2 then
			rotate_angle = 2*pi_angle - self.cur_angle - pi_angle*3/2
		elseif self.side == 3 then
			rotate_angle = 2*pi_angle - self.cur_angle - pi_angle
		elseif self.side == 4 then
			rotate_angle = 2*pi_angle - self.cur_angle
		end

		self.ui_lst.ImgPaoguan:setRotation(rotate_angle)
	end

	--self:updateLockFishMark()

	self:sendBullet(dt)

	if self.user_info.is_local == true then
		if self.auto_exit_time_add < self.auto_exit_time then
			self.auto_exit_time_add = self.auto_exit_time_add + dt
		end


		--when lock fish auto fire
		-- if self:isLockFish() == true then
		-- 	self:setAutoFire(true)
		-- else
		-- 	self:setAutoFire(false)
		-- end
	end
end

--定时发射子弹
function Battery:sendBullet(dt)
	if self.send_bullet_add_time > self.send_bullet_v then
		self.send_bullet_add_time = 0
		if self:isCanSendBullet() == true then

			--向服务器发送发炮消息
			send_lkby_ReqFire({angle = self.cur_angle,})

			--test code delete
			--self:runSendBullet(-1,self.cur_angle)
		end
	else
		self.send_bullet_add_time = self.send_bullet_add_time + dt
	end
end

function Battery:runSendBullet(bsid,angle)
	if self.user_info.is_local == true then
		local music_id = self.battery_config.mus_eff_lst[1]
		if self.is_have_enger == true then
			music_id = self.battery_config.mus_eff_lst[2]
		end
		MusicEffectPlayer.getInstance():play(music_id)
	end
	
	if self.setID_changed then
		angle = angle+ 180
	end

	local id_lst 	= self.battery_config.bubr_info[self.cur_barrel_index]
	local bullet_id = id_lst[1]
	if self.is_have_enger == true then bullet_id = id_lst[2] end

	local info = {
		id 			= bullet_id,
		pos 		= self:getSendBulletPos(),
		angle 		= angle,
		side 		= self.side,
		user_info 	= clone(self.user_info),
		lock_fish_id = -1,
	}

	--print("send start,side = " .. info.side .. ",angle = " .. info.angle)
	info.user_info.server_id = bsid
	if self.lock_obj then
		info.lock_fish_id = self:getLockFishId()
	end

	if self.user_info.is_local == true then
		info.angle = self.cur_angle
	end

	BulletManager.getInstance():sendBullet(info)

	self.ui_lst.ImgPaoguan:stopAllActions()
	local id_lst = self.battery_config.bubr_info[self.cur_barrel_index]
	local src_id = id_lst[3]

	if self.user_info.is_local == false then src_id = id_lst[4] end
	if self.is_have_enger == true then src_id = id_lst[5] end

	local frame_name = string.format(sprite_ani_config[src_id].pattern,1)
	self.ui_lst.ImgPaoguan:setSpriteFrame(frame_name)

	local ani_key 	= sprite_ani_config[src_id].key
	local animation = cc.AnimationCache:getInstance():getAnimation(ani_key)

	if animation then
		animation:retain()
		local animate = cc.Animate:create(animation)
		animation:release()
		self.ui_lst.ImgPaoguan:runAction(animate)
	end

	if self.user_info.is_local == false then
		--other player can not use mouse move
		self.cur_angle 		= angle
		local rotate_angle 	= self:getBatteryRotationAngle(self.cur_angle)
		self.ui_lst.ImgPaoguan:setRotation(rotate_angle)
	end

	if self.user_info.is_local == true then
		self.auto_exit_time_add = 0
	end
end

--是否定时发射子弹
function Battery:isCanSendBullet()
	local is_can_send_bullet = false

	local cut_state = BackgroundSceneManager.getInstance():getSceneState()

	if (self.key_is_down == true or (self.is_auto_send == true and self.user_info.is_local == true) ) 
		and (cut_state == 1) and self:isHaveEnoughScore() == true then

		is_can_send_bullet = true
	end

	return is_can_send_bullet
end

function Battery:onSapceKeyDownPro()
	self.key_is_down = true
	--print("key is down!")
end

function Battery:onSapceKeyUpPro()
	self.key_is_down = false
	--print("key is up")
end

function Battery:onZKeyDownPro()
	self.send_bullet_v = self.battery_config.send_v/2
end

function Battery:onZKeyUpPro()
	if self.is_auto_add_v == false then
		self.send_bullet_v = self.battery_config.send_v
	end
end

function Battery:createBatterySpr(cfg_item)
	local spr = nil
	if cfg_item then
		local frame_name = string.format(cfg_item.pattern,1)
		spr = cc.Sprite:createWithSpriteFrameName(frame_name)
	end

	return spr
end

function Battery:createAnimation(cfg_item,bregorg)
	local animation = nil
	if cfg_item then
		local frames = display.newFrames(cfg_item.pattern,1,cfg_item.fs)
		animation = cc.Animation:createWithSpriteFrames(frames,cfg_item.ft)
		if bregorg == true then
			animation:setRestoreOriginalFrame(bregorg)
		end
	end

	return animation
end

function Battery:getUserInfo()
	return self.user_info
end

function Battery:getBatteryPos()
	local pp_pos = {}
	pp_pos.x,pp_pos.y = self.ui_lst.ImgPaoguan:getPosition()
	local word_pos = self.ui_lst.root:convertToWorldSpace(pp_pos)

	return word_pos
end

function Battery:setScoreVal(val)
	self.user_info.chips = val
	self.ui_lst.FntJifen:setString(string.format("%d",val))
	self:isHaveEnoughScore()
end

function Battery:isHaveEnoughScore()

	if self.user_info.is_local == true and self.running_init == false then
		local str_level = self.ui_lst.FntLv:getString()
		local str_jifen = self.ui_lst.FntJifen:getString()

		if long_compare(str_jifen,str_level) < 0 then
			if self.no_money_spr:isVisible() == false then
				self.no_money_spr:setScale(0.1)
				self.no_money_spr:setVisible(true)
				self.no_money_spr:runAction(cc.ScaleBy:create(0.3,10))
			end

			return false
		else
			self.no_money_spr:setVisible(false)
		end
	end
	

	return true
end

function Battery:setGoldColumnVal(val)
	-- if self.gold_action_obj then
	-- 	self.gold_action_obj:setVal(val)
	-- end
end

function Battery:lockFish()
	if self.lock_obj and BackgroundSceneManager.getInstance():getSceneState() == 1 then
		self.lock_obj.hand_lock = true
		self.lock_obj:lock() 
	end
end

function Battery:unLockFish()

	if self.lock_obj then 
		self.lock_obj.hand_lock = false
		self.lock_obj:unlock() 
	end

	if self.user_info.is_local == true then
		send_lkby_ReqCancelLock({})
	end
end

function Battery:setUnlockFish()
	if self.lock_obj and self.user_info.is_local == false then
		self.lock_obj:unlock()
	end
end

function Battery:resetLockFishLst(lst)
	self.lock_obj:resetLockLst(lst)
end

function Battery:isLockFish()
	if self.lock_obj then
		if self.lock_obj:getLockState() == true and self.lock_obj:getCurrentLockFishId() ~= -1 then
			return true
		end
	end

	return false
end

function Battery:getLockFishId()
	if self.lock_obj then
		return self.lock_obj:getCurrentLockFishId()
	end

	return -1
end

function Battery:updateLockFishMark()
	-- if self:isLockFish() == true then
	-- 	local obj_id  = self:getLockFishId()
	-- 	local fsh_obj = FishManager.getInstance():getFishObjById(obj_id)

	-- 	if fsh_obj then
	-- 		local cfg_id  = fsh_obj:getDataId()

	-- 		if cfg_id == self.front_fish_data_id then
	-- 			return
	-- 		else
	-- 			self.ui_lst.SpriteSuoding:stopAllActions()
	-- 			self.ui_lst.SpriteSuoding:removeAllChildrenWithCleanup(true)
	-- 			self.ui_lst.SpriteSuoding:setPosition(self.lock_org_pos.x,self.lock_org_pos.y)
	-- 			self.front_fish_data_id = cfg_id
	-- 		end

	-- 		if fish_config[cfg_id] then
	-- 			local new_sfish = SimpleFish.create({id = cfg_id,balive = true,})
	-- 			self.ui_lst.SpriteSuoding:addChild(new_sfish)
	-- 			new_sfish:setPosition(self.lock_mark_size.width/2,self.lock_mark_size.height/2 - 10)
	-- 			new_sfish:setVisible(true)

	-- 			--local spr_size = new_sfish:getContentSize()
	-- 			local spr_size = fish_config[cfg_id].alive.size

	-- 			local scale = get_scale_with_size(spr_size,self.lock_mark_size)
	-- 			new_sfish:setScale(scale)

	-- 			self.ui_lst.SpriteSuoding:setVisible(true)
	-- 			ActionEffectPlayer.getInstance():play(self.ui_lst.SpriteSuoding,nil,lk_system_config.lock_fish_mark_act_id)
	-- 		end
	-- 	end 
	-- else
	-- 	self.ui_lst.SpriteSuoding:stopAllActions()
	-- 	self.ui_lst.SpriteSuoding:setVisible(false)
	-- 	self.ui_lst.SpriteSuoding:removeAllChildrenWithCleanup(true)
	-- 	self.ui_lst.SpriteSuoding:setPosition(self.lock_org_pos.x,self.lock_org_pos.y)
	-- 	self.front_fish_data_id = -1
	-- end
end

function Battery:setBarrelIndex(index,score,is_pow)
	self.cur_barrel_index = index
	if is_pow ~= nil then self.is_have_enger = is_pow end

	self.ui_lst.ImgPaoguan:stopAllActions()
	local id_lst = self.battery_config.bubr_info[self.cur_barrel_index]
	local src_id = id_lst[3]
	if self.user_info.is_local == false then src_id = id_lst[4] end
	if self.is_have_enger == true then src_id = id_lst[5] end

	local frame_name = string.format(sprite_ani_config[src_id].pattern,1)
	self.ui_lst.ImgPaoguan:setSpriteFrame(frame_name)

	self.ui_lst.FntLv:setString(string.format("%d",score))

	local ani_key  = sprite_ani_config[src_id].key
	local exit_ani = cc.AnimationCache:getInstance():getAnimation(ani_key)
	if exit_ani == nil then
		local animation = self:createAnimation(sprite_ani_config[src_id],true)
		cc.AnimationCache:getInstance():addAnimation(animation,ani_key)
	end

	self:isHaveEnoughScore()
	--self:updateEngerMark()
end

function Battery:updateEngerMark()
	-- self.ui_lst.SpriteNengliangpao:stopAllActions()
	-- self.ui_lst.SpriteNengliangpao:setPosition(self.enger_org_pos.x,self.enger_org_pos.y)

	-- if self.is_have_enger == true then
	-- 	self.ui_lst.SpriteNengliangpao:setVisible(true)
	-- 	ActionEffectPlayer.getInstance():play(self.ui_lst.SpriteNengliangpao,nil,lk_system_config.energy_connon_act_id)
	-- else
	-- 	self.ui_lst.SpriteNengliangpao:setVisible(false)
	-- end
end

function Battery:setLockFish(fsh_id)
	if self.lock_obj then
		self.lock_obj:setLockFish(fsh_id)
	end
end

function Battery:onSKeyDownPro()
	
end

function Battery:onSKeyUpPro()
	self:lockFish()
end

function Battery:onQKeyDownPro()

end

function Battery:onQKeyUpPro()
	self:unLockFish()
end

function Battery:onAddBarrelIndex()
	--send message to serve
	send_lkby_ReqSwitchBattery({type= 0,})
end

function Battery:onMinusBarrelIndex()
	--send message to serve
	send_lkby_ReqSwitchBattery({type=1,})
end

--上分
function Battery:onAddScore()
	send_lkby_ReqExchangeChips({})
end

function Battery:onMinusScore()
	send_lkby_ReqExchangeGolds({})
end

function Battery:onAddMaxScore()
	send_lkby_ReqExchangeAllChips({})
end

function Battery:getLockAngle()
	if self.lock_obj then
		return self.lock_obj:getCurrentLockAngle()
	end

	return 0
end


function Battery:isLockObjChange()
	if self.lock_obj then
		return self.lock_obj:isLockObjChange()
	end

	return true
end

function Battery:getSide()
	return self.side
end

function Battery:setAutoFire(bauto)
	if bauto ~= nil and self.user_info.is_local == true then
		self.is_auto_send = bauto
	end
end

function Battery:setAutoAddV(bauto)
	if bauto ~= nil and self.user_info.is_local == true then
		self.is_auto_add_v = bauto
	end

	if self.is_auto_add_v == true then
		self.send_bullet_v = self.battery_config.send_v/2
	else
		self.send_bullet_v = self.battery_config.send_v
	end
end

function Battery:isMyBattery()
	return self.user_info.is_local
end

function Battery:isLongTimeNoSendBullet()
	local is_no_send = false
	if self.user_info.is_local == true then
		if self.auto_exit_time_add > self.auto_exit_time then
			is_no_send = true
		else
			is_no_send = false
		end
	end

	return is_no_send
end

function Battery:lockFishByPoint(pos)
	local fsh_id = FishManager.getInstance():getFishIdByPoint(pos)
	self.lock_obj:forceToLockFish(fsh_id)
end

function Battery:setClearLockState(f)
	self.clrear_lock_call = f
end

function Battery:lockAgain()
	if self.lock_obj and self.lock_obj.hand_lock == true then
		self:lockFish()
		print("============================================================")
	end
end