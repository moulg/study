

-- local add_title_creater = require "game.jinchanbuyu.ui.ui_jinchabuyu_title"
local auto_exit_scene_hit = require "game.jinchanbuyu.ui.ui_jinchanbuyu_leve"
local set_ui_create = require "game.jinchanbuyu.ui.ui_setUp"
local lock_ctrl_create = require "game.jinchanbuyu.ui.ui_jinchanbuyu_lock"

--[[
	游戏主场景
]]
Jinchanbuyu = class("Jinchanbuyu",function ()
	local obj = cc.Layer:create()
	return obj
end)
ModuleObjMgr.add_module_obj(Jinchanbuyu,"Jinchanbuyu")

-- local get_bullet_sum = 0
-- local send_bullet_sum = 0


function Jinchanbuyu.create()
	local obj = Jinchanbuyu.new()
	if obj then
		obj:init()
	end

	return obj
end

function Jinchanbuyu:init()

	self:loadConfigData()
	
	--动作播放器
	ActionEffectPlayer.getInstance():init()

	--音效播放器
	MusicEffectPlayer.getInstance():init()

	--鱼对象管理器
	FishManager.getInstance():init(self)

	--子弹对象管理器
	BulletManager.getInstance():init({bonding_size = jc_system_config.bonding_size,})

	--鱼网对象管理
	FishNetManager.getInstance():init()

	--对象作用世界对象
	ObjectEffectWorld.getInstance():init()

	--金币对象管理
	FishGoldManager.getInstance():init()

	--炮台对象管理
	BatteryManager.getInstance():init(self)

	--金币字体对象
	FishLabelFntManager.getInstance():init()

	--背景场景对象
	BackgroundSceneManager.getInstance():init(self)

	--特技管理
	SkillPlayer.getInstance():init()

	--对象池
	ObjectPool.getInstance():init(self)



	self:init_data()
	self:loading()

	self.is_loding = true --是否正在加载资源
	self.is_enter_scene = false --是否进入场景

	self.auto_exit_time = 60
	self.auto_exit_time_add = 0
	self.bauto_exit = false
end

function Jinchanbuyu:loadConfigData()

	--load data from json file
	-- fish_config  = load_json_file("game/jinchanbuyu/data/fish_config.json").fish_config
	-- curve_config = load_json_file("game/jinchanbuyu/data/curve_config.json").curve_config

	fish_config  = require("game/jinchanbuyu/data/fish_config.lua")
	curve_config = require("game/jinchanbuyu/data/curve_config.lua")


	reload_module ("game.jinchanbuyu.data.bonding_box_config")
	reload_module ("game.jinchanbuyu.data.sprite_ani_config")
	reload_module ("game.jinchanbuyu.data.voice_config")
	reload_module ("game.jinchanbuyu.data.action_eff_config")
	reload_module ("game.jinchanbuyu.data.skill_config")
	reload_module ("game.jinchanbuyu.data.music_effect_config")
	reload_module ("game.jinchanbuyu.data.background_music_src_config")
	reload_module ("game.jinchanbuyu.data.bullet_config")
	reload_module ("game.jinchanbuyu.data.jc_system_config")
	reload_module ("game.jinchanbuyu.data.battery_config")
	reload_module ("game.jinchanbuyu.data.fish_gold_config")
	reload_module ("game.jinchanbuyu.data.battery_position_config")
	reload_module ("game.jinchanbuyu.data.fish_label_fnt_config")
	reload_module ("game.jinchanbuyu.data.background_config")
	reload_module ("game.jinchanbuyu.data.fish_water_config")
	reload_module ("game.jinchanbuyu.data.fish_net_config")

	--loading comment
	reload_module ( "game.jinchanbuyu.common.jc_common_function")
	reload_module ( "game.jinchanbuyu.common.calculte_rule")
	reload_module ( "game.jinchanbuyu.common.action_curve")
	reload_module ( "game.jinchanbuyu.common.fish")
	reload_module ( "game.jinchanbuyu.common.object_pool")
	reload_module ( "game.jinchanbuyu.common.bullet")
	reload_module ( "game.jinchanbuyu.common.bullet_manager")
	reload_module ( "game.jinchanbuyu.common.battery")
	reload_module ( "game.jinchanbuyu.common.battery_manager")
	reload_module ( "game.jinchanbuyu.common.action_creater")
	reload_module ( "game.jinchanbuyu.common.action_effect_player")
	reload_module ( "game.jinchanbuyu.common.music_effect_player")
	reload_module ( "game.jinchanbuyu.common.fish_manager")
	reload_module ( "game.jinchanbuyu.common.object_effect_world")
	reload_module ( "game.jinchanbuyu.common.fish_net")
	reload_module ( "game.jinchanbuyu.common.fish_net_manager")
	reload_module ( "game.jinchanbuyu.common.fish_gold")
	reload_module ( "game.jinchanbuyu.common.fish_gold_manager")
	reload_module ( "game.jinchanbuyu.common.fish_label_fnt")
	reload_module ( "game.jinchanbuyu.common.fish_label_fnt_manager")
	-- reload_module ( "game.jinchanbuyu.common.gold_column")
	-- reload_module ( "game.jinchanbuyu.common.gold_column_action")
	reload_module ( "game.jinchanbuyu.common.lock_fish")
	reload_module ( "game.jinchanbuyu.common.simple_fish")
	reload_module ( "game.jinchanbuyu.common.background_scene")
	reload_module ( "game.jinchanbuyu.common.background_scene_manager")
	reload_module ( "game.jinchanbuyu.common.fish_water")
	reload_module ( "game.jinchanbuyu.common.skill_player")
	reload_module ( "game.jinchanbuyu.common.skill_item_rotate_score")
	reload_module ( "game.jinchanbuyu.common.skill_item_line")
	reload_module ( "game.jinchanbuyu.common.light_model")
end

function Jinchanbuyu:unloadData()
	fish_config  = {}
	curve_config = {}

	unload_module("game/jinchanbuyu/data/fish_config.lua")
	unload_module("game/jinchanbuyu/data/curve_config.lua")

	unload_module("game.jinchanbuyu.data.bonding_box_config")
	unload_module("game.jinchanbuyu.data.sprite_ani_config")
	unload_module("game.jinchanbuyu.data.voice_config")
	unload_module("game.jinchanbuyu.data.action_eff_config")
	unload_module("game.jinchanbuyu.data.skill_config")
	unload_module("game.jinchanbuyu.data.music_effect_config")
	unload_module("game.jinchanbuyu.data.background_music_src_config")
	unload_module("game.jinchanbuyu.data.bullet_config")
	unload_module("game.jinchanbuyu.data.jc_system_config")
	unload_module("game.jinchanbuyu.data.battery_config")
	unload_module("game.jinchanbuyu.data.fish_gold_config")
	unload_module("game.jinchanbuyu.data.battery_position_config")
	unload_module("game.jinchanbuyu.data.fish_label_fnt_config")
	unload_module("game.jinchanbuyu.data.background_config")
	unload_module("game.jinchanbuyu.data.fish_water_config")
	unload_module("game.jinchanbuyu.data.fish_net_config")

	--loading comment
	unload_module( "game.jinchanbuyu.common.jc_common_function")
	unload_module( "game.jinchanbuyu.common.calculte_rule")
	unload_module( "game.jinchanbuyu.common.action_curve")
	unload_module( "game.jinchanbuyu.common.fish")
	unload_module( "game.jinchanbuyu.common.object_pool")
	unload_module( "game.jinchanbuyu.common.bullet")
	unload_module( "game.jinchanbuyu.common.bullet_manager")
	unload_module( "game.jinchanbuyu.common.battery")
	unload_module( "game.jinchanbuyu.common.battery_manager")
	unload_module( "game.jinchanbuyu.common.action_creater")
	unload_module( "game.jinchanbuyu.common.action_effect_player")
	unload_module( "game.jinchanbuyu.common.music_effect_player")
	unload_module( "game.jinchanbuyu.common.fish_manager")
	unload_module( "game.jinchanbuyu.common.object_effect_world")
	unload_module( "game.jinchanbuyu.common.fish_net")
	unload_module( "game.jinchanbuyu.common.fish_net_manager")
	unload_module( "game.jinchanbuyu.common.fish_gold")
	unload_module( "game.jinchanbuyu.common.fish_gold_manager")
	unload_module( "game.jinchanbuyu.common.fish_label_fnt")
	unload_module( "game.jinchanbuyu.common.fish_label_fnt_manager")
	-- unload_module( "game.jinchanbuyu.common.gold_column")
	-- unload_module( "game.jinchanbuyu.common.gold_column_action")
	unload_module( "game.jinchanbuyu.common.lock_fish")
	unload_module( "game.jinchanbuyu.common.simple_fish")
	unload_module( "game.jinchanbuyu.common.background_scene")
	unload_module( "game.jinchanbuyu.common.background_scene_manager")
	unload_module( "game.jinchanbuyu.common.fish_water")
	unload_module( "game.jinchanbuyu.common.skill_player")
	unload_module( "game.jinchanbuyu.common.skill_item_rotate_score")
	unload_module( "game.jinchanbuyu.common.skill_item_line")
	unload_module( "game.jinchanbuyu.common.light_model")
end

function Jinchanbuyu:init_data()

	--玩家的用户信息
	self.user_info_lst = {}
	for i=1,#battery_position_config do
		self.user_info_lst[i] = {player_id = -1,set_id = -1,is_local = false,chips = 0,}
	end

	self.instead_send_player_lst = {}--请求代发玩家列表
end


function Jinchanbuyu:init_ui()
	-- local __close_scene_func = function ()
	-- 	print("close game!")
	-- 	HallManager:reqExitCurGameTable()
	-- end

	-- local title = WindowScene.getInstance():getModuleObjByClassName("CTableTitleExt")
	-- if title then title:setCloseFunc(__close_scene_func) end
	-- self.title_spr = title

	for k,v in pairs(self.user_info_lst) do
		if v.player_id ~= -1 and v.set_id ~= -1 then
			local info = {user_info = v,}
			BatteryManager.getInstance():createBattery(info,true)
		end
	end

	--add back_image
	-- local title_bk_spr = ccui.ImageView:create("game/jinchanbuyu/resource/other/tiao.png")
	-- title:addChild(title_bk_spr)
	-- title_bk_spr:setLocalZOrder(-10)
	-- local tt_bk_sz = title_bk_spr:getContentSize()
	-- title_bk_spr:setPosition(jc_system_config.scene_size.width/2,jc_system_config.scene_size.height - tt_bk_sz.height/2)
	-- title_bk_spr:setTouchEnabled(true)

	-- self.title_ext_ui = add_title_creater.create()
	-- title:addChild(self.title_ext_ui.root)
	-- self.title_ext_ui.root:setPosition(jc_system_config.scene_size.width/2,jc_system_config.scene_size.height - tt_bk_sz.height/2)

	-- self.title_ext_ui.CheckBox_autoShoot:setSelected(false)
	-- self.title_ext_ui.CheckBox_autoShoot:onEvent(function (e)
	-- 	self:onAutoFire(e)
	-- end)

	-- self.title_ext_ui.CheckBox_fast:setSelected(false)
	-- self.title_ext_ui.CheckBox_fast:onEvent(function (e)
	-- 	self:onAutoAddV(e)
	-- end)

	self.auto_exit_scene_ui = auto_exit_scene_hit.create()
	self:addChild(self.auto_exit_scene_ui.root)
	self.auto_exit_scene_ui.root:setPosition(jc_system_config.scene_size.width/2,jc_system_config.scene_size.height/2)
	self.auto_exit_scene_ui.Fnt_leveNum:setString(string.format("%d",self.auto_exit_time))
	self.auto_exit_scene_ui.root:setVisible(false)

	-- cc.Director:getInstance():getOpenGLView():setCursorVisible(false)
	-- self.spr_cursor = cc.Sprite:create("game/jinchanbuyu/resource/other/cursor.png")
	-- self:addChild(self.spr_cursor)
	-- self.spr_cursor:setPosition(jc_system_config.scene_size.width/2,jc_system_config.scene_size.height/2)
	-- self.spr_cursor:setLocalZOrder(3300000)


	self.setup_obj = JinchanSetup.create()
	self:addChild(self.setup_obj)

	--set lock fish control
	self.lock_ui = lock_ctrl_create.create()
	self:addChild(self.lock_ui.root)
	self.lock_ui.root:setLocalZOrder(3300001)
	--
	self.lock_ui.CheckBox_auto_lock:setPosition(jc_system_config.lock_ctrl_pos.x,jc_system_config.lock_ctrl_pos.y)
	self.lock_ui.CheckBox_auto_lock:onEvent(function (e)

		self.lock_ui.CheckBox_auto_fire:setSelected(false)

		if e.name == "selected" then
			local bat_obj = BatteryManager.getInstance():getMyselfBatteryObj()
			if bat_obj then
				bat_obj:lockFish()
				bat_obj:setAutoFire(true)
			end
		elseif e.name == "unselected" then
			local bat_obj = BatteryManager.getInstance():getMyselfBatteryObj()
			if bat_obj then
				bat_obj:unLockFish()
				bat_obj:setAutoFire(false)
			end
		end
	end)


	self.lock_ui.CheckBox_auto_fire:setPosition(jc_system_config.lock_ctrl_pos.x+220,jc_system_config.lock_ctrl_pos.y)
	self.lock_ui.CheckBox_auto_fire:onEvent(function (e)

		self.lock_ui.CheckBox_auto_lock:setSelected(false)

		if e.name == "selected" then
			local bat_obj = BatteryManager.getInstance():getMyselfBatteryObj()
			if bat_obj then
				bat_obj:unLockFish()

				if bat_obj.cur_angle ==0 then
					bat_obj:rotationBatteryByPos({x = 600,y = 500,})
				end

				bat_obj:setAutoFire(true)
			end
		elseif e.name == "unselected" then
			local bat_obj = BatteryManager.getInstance():getMyselfBatteryObj()
			if bat_obj then
				bat_obj:unLockFish()
				bat_obj:setAutoFire(false)
			end
		end
		
	end)

	BatteryManager.getInstance():setClearStateCall(function ()
	end)
end


function Jinchanbuyu:loading()
	self.loading_info_param = {
		parent 			= WindowScene.getInstance().game_layer,
		task_call 		= function (percent,index,texture) self:loadingImage(percent,index,texture) end,
		complete_call 	= function () self:loadingComplete() end,
		ui_info = {
			back_pic 		= "game/jinchanbuyu/resource/loading/loadingbg.png",
			bar_back_pic 	= "game/jinchanbuyu/resource/loading/loadbg.png",
			bar_process_pic = "game/jinchanbuyu/resource/loading/loadt.png",
			b_self_release 	= true,
		},
	}

	self.loading_info_param.task_lst = {}
	for k,v in pairs(sprite_ani_config) do
		table.insert(self.loading_info_param.task_lst,v)
	end
	self.loading_obj = LoadingTask.create(self.loading_info_param)
end

function Jinchanbuyu:loadingImage(percent,index,texture)
	local item = self.loading_info_param.task_lst[index]
	if item.stype == 1 then
		print("index = " .. index .. ",plist path  = " .. item.file)
		local cache = cc.SpriteFrameCache:getInstance()
		cache:addSpriteFrames(item.file)
	end
end

function Jinchanbuyu:reloadSetData()
	open_user_config()
	local key = string.format("%d",get_player_info().curGameID)
	local user_set = get_user_config()[key]
	if user_set == nil then user_set = {} end

	if user_set.graphic_level == nil then
		user_set.graphic_level = 3
		get_user_config()[key] = user_set
		save_uer_config()
	end

	self:setGraphicLevel(user_set.graphic_level)
	reset_music_config()
end

function Jinchanbuyu:setGraphicLevel(level)
	if level == 3 then
		FishManager.getInstance():useLight(true)
		BackgroundSceneManager.getInstance():useWaterWave(true)
	elseif level == 2 then
		FishManager.getInstance():useLight(false)
		BackgroundSceneManager.getInstance():useWaterWave(true)
	elseif level == 1 then
		FishManager.getInstance():useLight(false)
		BackgroundSceneManager.getInstance():useWaterWave(false)
	end
end

function Jinchanbuyu:loadingComplete()
	self:reloadSetData()

	self.loading_obj = nil

	--注册对象作用回调
	local function __shot_effect_world_call(shot_lst) self:onShotCallback(shot_lst) end
	ObjectEffectWorld.getInstance():registerCallback(__shot_effect_world_call)

	--注册子弹
	ObjectPool.getInstance():registerObjectCreater(ObjectClassType.type_bullet,Bullet)--注册子弹
	for k,v in pairs(bullet_config) do
		ObjectPool.getInstance():newSomeObject(ObjectClassType.type_bullet,v.id,50)--预分配子弹对象
	end

	--注册鱼网
	ObjectPool.getInstance():registerObjectCreater(ObjectClassType.type_fish_net,FishNet)
	for k,v in pairs(fish_net_config) do
		ObjectPool.getInstance():newSomeObject(ObjectClassType.type_fish_net,v.id,20)--预分配鱼网对象
	end

	--注册金币
	ObjectPool.getInstance():registerObjectCreater(ObjectClassType.type_fish_gold,FishGold)
	for k,v in pairs(fish_gold_config) do
		ObjectPool.getInstance():newSomeObject(ObjectClassType.type_fish_gold,v.id,20)--预分配金币对象
	end

	--注册鱼数字对象
	ObjectPool.getInstance():registerObjectCreater(ObjectClassType.type_fish_fnt,FishLabelFnt)
	ObjectPool.getInstance():newSomeObject(ObjectClassType.type_fish_fnt,jc_system_config.gold_fnt_index,20)

	local function __callback()
		if self.lock_ui.CheckBox_auto_lock:isSelected() then
			local bat_obj = BatteryManager.getInstance():getMyselfBatteryObj()
			if bat_obj then
				bat_obj:lockFish()
				bat_obj:setAutoFire(true)
				print("===================================================================================================")
			end
		end
	end

	--创建浪花对象
	BackgroundSceneManager.getInstance():createSeawaveObj(__callback)


	self:init_ui()
	self:registerEE()
	self:registerUpdate()
	--self:registerMouseEvent()
	--self:loadMusicEffect()
	self.is_loding = false

	send_jcby_ReqScence({})
	send_jcby_ReqExchangeAllChips({})
	print("send send_jcby_ReqExchangeAllChips >>>>>>>>>>>>")
end

function Jinchanbuyu:destoryLoading()
	if self.loading_obj then
    	self.loading_obj:forcedDestory()
        self.loading_obj = nil
    end
end

function Jinchanbuyu:loadMusicEffect()
	for k,v in pairs(voice_config) do
		AudioEngine.preloadEffect(v.file)
	end
end

function Jinchanbuyu:removeMusicEffect()
	AudioEngine.destroyInstance()
end

function Jinchanbuyu:registerEE()
	local function __on_enter_exit(event)
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__on_enter_exit)
end

function Jinchanbuyu:registerMouseEvent()
	local function __on_mouse_move(e)
    	self:onMouseMove(e)
    end

    local mouse_listener = cc.EventListenerMouse:create()
	mouse_listener:registerScriptHandler(__on_mouse_move,cc.Handler.EVENT_MOUSE_MOVE)

	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(mouse_listener,self)
end


function Jinchanbuyu:registerUpdate()

	local function _main_scene_update(dt) self:update(dt) end
	local scheduler = cc.Director:getInstance():getScheduler()
	self.sch_handle = scheduler:scheduleScriptFunc(_main_scene_update,0.0,false)
end

function Jinchanbuyu:onEnter()
	--cc.AnimationCache:getInstance():destroyInstance()
end

function Jinchanbuyu:onExit()
	local scheduler = cc.Director:getInstance():getScheduler()
	scheduler:unscheduleScriptEntry(self.sch_handle)

	ActionEffectPlayer.destroyInstance()
	MusicEffectPlayer.destroyInstance()
	FishManager.destroyInstance()
	BulletManager.destroyInstance()
	ObjectEffectWorld.destroyInstance()
	ObjectPool.destroyInstance()
	FishNetManager.destroyInstance()
	BatteryManager.destroyInstance()
	FishLabelFntManager.destroyInstance()
	BackgroundSceneManager.destroyInstance()
	SkillPlayer.destroyInstance()

	
	self:removePicSrc()
	self:removeMusicEffect()

	--cc.Director:getInstance():getOpenGLView():setCursorVisible(true)

	self:unloadData()
end

function Jinchanbuyu:onMouseMove(e)
	-- local local_pos  = e:getLocation()
	-- local global_pos = cc.Director:getInstance():convertToGL(local_pos)
	-- local rect = {x = 0,y = 0,width = jc_system_config.mouse_move_size.width,height= jc_system_config.mouse_move_size.height,}

	-- if is_point_in_rect(rect,global_pos) == true and WindowScene.getInstance():isHaveShowDlg() == false then
	-- 	self.spr_cursor:setVisible(true)
	-- 	cc.Director:getInstance():getOpenGLView():setCursorVisible(false)
	-- 	self.spr_cursor:setPosition(global_pos.x,global_pos.y)
	-- else
	-- 	self.spr_cursor:setVisible(false)
	-- 	cc.Director:getInstance():getOpenGLView():setCursorVisible(true)
	-- end
end

function Jinchanbuyu:removePicSrc()
	local spr_cache = cc.SpriteFrameCache:getInstance()
	local ani_cache = cc.AnimationCache:getInstance()

    for k,v in pairs(sprite_ani_config) do
    	if v.stype == 1 then
    		ani_cache:removeAnimation(v.key)
    		spr_cache:removeSpriteFramesFromFile(v.file)
    	end
    end
end

function Jinchanbuyu:update(dt)
	FishManager.getInstance():update(dt)
	BulletManager.getInstance():update(dt)
	ObjectEffectWorld.getInstance():update(dt)
	BatteryManager.getInstance():update(dt)
	BackgroundSceneManager.getInstance():update(dt)

	self:autoExitScene(dt)
end

function Jinchanbuyu:autoExitScene(dt)
	self:isAutoExitScene()


	if self.bauto_exit == true then
		if math.floor(self.auto_exit_time_add) >= self.auto_exit_time then
			HallManager:reqExitCurGameTable()
			HallManager:reqExitCurGameRoom()
		else
			self.auto_exit_time_add = self.auto_exit_time_add + dt
			local time = self.auto_exit_time - math.floor(self.auto_exit_time_add)
			self.auto_exit_scene_ui.Fnt_leveNum:setString(string.format("%d",time))
		end
	end
end

function Jinchanbuyu:isAccessServerMessage()
	if self.is_loding == false and self.is_enter_scene == true then
		return true
	end

	return false
end

--鱼碰撞回调
function Jinchanbuyu:onShotCallback(shot_lst)

	for k,v in pairs(shot_lst) do
		if v.bullet_obj:isMyBullet() then--自身子弹
			local msg = {
				playerId = v.bullet_obj:getBulletPlayerId(),
				bulletId = v.bullet_obj:getBulletServeId(),
				fishId 	 = v.fish_obj:getObjectId(),
			}
			send_jcby_ReqHit(msg)
		end

		--代发子弹
		for m,n in pairs(self.instead_send_player_lst) do
			if v.bullet_obj:getBulletPlayerId() == n then
				local msg = {
					playerId = v.bullet_obj:getBulletPlayerId(),
					bulletId = v.bullet_obj:getBulletServeId(),
					fishId 	 = v.fish_obj:getObjectId(),
				}
				send_jcby_ReqHit(msg)
				break
			end
		end

		local obj_id = v.bullet_obj:getObjectId()
		BulletManager.getInstance():removeBulletObject(obj_id)
	end

	
	--send_sum = 0
end

function Jinchanbuyu:onAutoFire(e)
	local my_bat_obj = BatteryManager.getInstance():getMyselfBatteryObj()

	if my_bat_obj then
		if e.name == "selected" then
			my_bat_obj:setAutoFire(true)
		elseif e.name == "unselected" then
			my_bat_obj:setAutoFire(false)
		end
	end
end

function Jinchanbuyu:onAutoAddV(e)
	local my_bat_obj = BatteryManager.getInstance():getMyselfBatteryObj()
	if my_bat_obj then
		if e.name == "selected" then
			my_bat_obj:setAutoAddV(true)
		elseif e.name == "unselected" then
			my_bat_obj:setAutoAddV(false)
		end
	end
end

--info = {player_id,set_id,is_local,chips,}
function Jinchanbuyu:setUserInfo(info)
	if self.user_info_lst[info.set_id] then
		self.user_info_lst[info.set_id].set_id = info.set_id
		self.user_info_lst[info.set_id].player_id = info.player_id
		self.user_info_lst[info.set_id].is_local = info.is_local
		self.user_info_lst[info.set_id].chips = info.chips

		if info.is_local then
			print("setUserInfo=============================="..info.set_id)
			conversionLocalInfo.id =info.set_id
		end
	end
end

--info = {player_id,set_id,is_local,chips,}
function Jinchanbuyu:setOtherPlayerUserInfo(info)
	if self.user_info_lst[info.set_id].set_id == -1 then
		self.user_info_lst[info.set_id].set_id 		= info.set_id
		self.user_info_lst[info.set_id].player_id   = info.player_id
		self.user_info_lst[info.set_id].is_local 	= info.is_local
		self.user_info_lst[info.set_id].chips 		= info.chips

		if self.is_loding == false then
			local info = {user_info = self.user_info_lst[info.set_id],}
			BatteryManager.getInstance():createBattery(info,false)
		end
	end
end

function Jinchanbuyu:removeSet(setid)
	if self.user_info_lst[setid].set_id ~= -1 then
		BatteryManager.getInstance():removeBatteryBySetId(setid)
		BulletManager.getInstance():removeBulletObjectBySetId(setid)

		self.user_info_lst[setid].set_id 	= -1
		self.user_info_lst[setid].player_id = -1
		self.user_info_lst[setid].is_local	= false
	end
end

function Jinchanbuyu:isMySet(setid)
	return self.user_info_lst[setid].is_local
end

function Jinchanbuyu:isAutoExitScene()
	local bat_obj = BatteryManager.getInstance():getMyselfBatteryObj()
	if bat_obj then
		if bat_obj:isLongTimeNoSendBullet() == true then

			if self.bauto_exit == false then
				self.auto_exit_scene_ui.root:setVisible(true)
				self.auto_exit_scene_ui.Fnt_leveNum:setString(string.format("%d",self.auto_exit_time))
				self.auto_exit_scene_ui.root:setLocalZOrder(5000000)
				self.auto_exit_time_add = 0
			end

			self.bauto_exit = true
		else
			self.bauto_exit = false
			self.auto_exit_scene_ui.root:setVisible(false)
		end
	end
end


function Jinchanbuyu:cutBattery(setid,num,score,power)

	local is_pow = true
	if power == 0 then is_pow = false end

	local obj = BatteryManager.getInstance():getBatteryBySetId(setid)
	if obj then obj:setBarrelIndex(num,score,is_pow) end
end

function Jinchanbuyu:runSendBullet(setid,bsid,angle)
	local obj = BatteryManager.getInstance():getBatteryBySetId(setid)
	--print("get bullet serverid: " .. bsid)
	--get_bullet_sum = get_bullet_sum + 1
	if obj then
		obj:runSendBullet(bsid,angle)
	end
	--print("get_bullet_sum = " .. get_bullet_sum)
end

function Jinchanbuyu:updateScore(setid,score)

	local obj = BatteryManager.getInstance():getBatteryBySetId(setid)
	if obj then
		obj:setScoreVal(score)
		self.user_info_lst[setid].chips = score
	end
end

function Jinchanbuyu:fishDeath(setid,fshid,score)
	local bat_obj = BatteryManager.getInstance():getBatteryBySetId(setid)
	local fsh_obj = FishManager.getInstance():getFishObjById(fshid)

	if bat_obj and fsh_obj then
		bat_obj:setGoldColumnVal(score)
		fsh_obj:setScoreVal(score)
		fsh_obj:setGoldMoveEndPos(bat_obj:getBatteryPos())
		fsh_obj:setShotSetId(setid)
		local pos = fsh_obj:getCurrentPos()
		--print("fish death id= " .. fshid .. ",pos = " ..  pos.x .. "," .. pos.y)
		FishManager.getInstance():removeFish(fshid)
		bat_obj:lockAgain()
	end
end

--[[
	lst = {
		[] = {fishId,score}
	}
]]
function Jinchanbuyu:fishLstDeath(setid,lst)

	if #lst <= 0 then return end

	
	local fsh_id = -1
	for i=1,#lst do
	 	if i == 1 then 
	 		fsh_id = lst[i].fishId
	 		if #lst > 1 then
	 			print("first fish obj id = " .. fsh_id)
	 		end
	 	end

	 	if i > 1 then
	 		local fsh_obj   = FishManager.getInstance():getFishObjById(lst[i].fishId)
	 		local first_obj = FishManager.getInstance():getFishObjById(fsh_id)
	 		if first_obj and fsh_obj then
	 			first_obj:addLineRelObj(fsh_obj)
	 		end

	 		self:fishDeath(setid,lst[i].fishId,lst[i].score)
	 	end
	end

	self:fishDeath(setid,lst[1].fishId,lst[1].score)
end

function Jinchanbuyu:cutScene(sid)
	BackgroundSceneManager.getInstance():cutBackgroundScene(sid)
end

function Jinchanbuyu:freshFish(info)
	FishManager.getInstance():addFish(info)
end

function Jinchanbuyu:enterScene(scene_id)
	self.is_enter_scene = true
	BackgroundSceneManager.getInstance():cutBackgroundScene(scene_id)
end

function Jinchanbuyu:setLockFish(setid,fsh_id)
	local obj = BatteryManager.getInstance():getBatteryBySetId(setid)
	if obj then
		obj:setLockFish(fsh_id)
	end
end

function Jinchanbuyu:unLockFish(setid)
	local obj = BatteryManager.getInstance():getBatteryBySetId(setid)
	if obj then
		obj:setUnlockFish()
	end
end

function Jinchanbuyu:setFishShowLevel(cfg_id,lv)
	local up_info = {level = lv,fish_id = cfg_id,}
	FishManager.getInstance():setLevelupInfo(up_info)
	local fsh_lst = FishManager.getInstance():getFishByConfigId(cfg_id)

	for k,v in pairs(fsh_lst) do
		v:setFishLevel(lv)
		SkillPlayer.getInstance():play(v,4)
	end
end

function Jinchanbuyu:setInsteadPlayerLst(lst)
	self.instead_send_player_lst = lst
end


