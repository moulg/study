--[[
	鱼
]]
local pie_angle = 180
local pie = 3.1415926

local fish_zorder  = 500000


Fish = class("Fish",function ()
	local obj = cc.Node:create()
	return obj
end)


--[[
	info={
		obj_id,--对象id
		id,--鱼id
	}
]]
function Fish.create(info)
	local obj = Fish.new()
	if obj then
		obj:init(info)
	end

	return obj
end

function Fish:init(info)
	self:init_data(info)
	self:init_ui()
	self:registerEE()
end

function Fish:init_data(info)
	self.obj_id = info.obj_id
	self.start_pos = {x = 0,y = 0,}

	self.fcfg 			= clone(fish_config[info.id])--鱼配置
	self.bbx_cfg 		= clone(bonding_box_config[self.fcfg.bbx_id])--包围盒配置


	self.curve_cfg = nil
	if self.fcfg.cve_id ~= -1 then
		self.curve_cfg = curve_config[self.fcfg.cve_id]--路径曲线配置
	end
	

	-- if self.fcfg.alive.mus_id ~= -1 then
	-- 	self.alive_mus_cfg = voice_config[self.fcfg.alive.mus_id]--出生时声音 
	-- end

	if self.fcfg.alive.skl_id ~= -1 then
		self.alive_skl_cfg = skill_config[self.fcfg.alive.skl_id]--出生时技能
	end

	-- if self.fcfg.death.mus_id ~= -1 then
	-- 	self.deadth_mus_cfg = voice_config[self.fcfg.death.mus_id]--死亡时声音
	-- end

	if self.fcfg.death.skl_id ~= -1 then
		self.death_skl_cfg = skill_config[self.fcfg.death.skl_id]--死亡时技能
	end

	local info = {}
	if self.curve_cfg ~= nil then
		info = {spos  = self.start_pos,ratio = self.curve_cfg.ratio,}
	end
	

	self.fsh_curve = ActionCurve.create(info)--曲线轨迹对象

	if self.curve_cfg ~= nil then
		for i=1,#self.curve_cfg.data do
			self.fsh_curve:addCurve(self.curve_cfg.data[i])
		end

		
		self:setCurveRotation(self.curve_cfg.angle)
	end
	

	self.spr_alive_lst = {}--出生特效列表
	self.spr_death_lst = {}--死亡特效列表

	self.run_t = 0--鱼运动时间
	self.cur_pos   = {x = 0,y = 0,}--当前运动到的点
	self.cur_angle = 0--当前偏转角度

	self.gold_end_pos = {x = 0,y = 0,} --金币飞往的最后位置

	self.user_info = {--用户数据
		player_id = -1,
		set_id = -1,
	}

	self.use_test 	= 0--测试坐标
	self.fish_score = 0--鱼分数

	self.cur_rline_obj_lst = {}--当前关联鱼对象列表

	self.cur_line_obj = nil --当前连线的对象

	self.buse_light_mod = false
	self.cur_shadow_offset = {widht = 5,height = 5,}

	self.fish_level = 0 --鱼等级

	self.scene_id = -1

	self.is_draw_bondingbox = false--是否绘制出包围盒
	self.is_draw_curve = false--是否绘制路径
end

function Fish:init_ui()
	self:setLocalZOrder(fish_zorder)
	self:createFishItem(self.fcfg.alive,self.spr_alive_lst,self.buse_light_mod,true)
	self:createFishItem(self.fcfg.death,self.spr_death_lst,false,false)
	self:showAliveSpr(false)
	self:showDeadSpr(false)

	if self.use_test == 1 then
		self.info_label = cc.Label:create()
		self.info_label:setPosition(0,0)
		self:addChild(self.info_label)
		self.info_label:setString("test")
		self.info_label:setSystemFontSize(40)
	end



	if self.is_draw_bondingbox == true then
		local draw = cc.DrawNode:create()
		self:addChild(draw,1000)
		for k,v in pairs(self.bbx_cfg.data) do
			draw:drawCircle(cc.p(v.a,v.b),v.r,0,50,false,cc.c4f(0, 1,1, 1.0))
		end
	end
end

function Fish:registerEE()
	local function __on_enter_exit(event)
		if event == "enter" then
			self:onEnter()
		elseif event == "exit" then
			self:onExit()
		end
	end

	self:registerScriptHandler(__on_enter_exit)
end

function Fish:onEnter()
	
end

function Fish:onExit()
	self.run_t 	   = 0
	self.cur_pos   = nil
	self.cur_angle = nil
end

function Fish:runStartEff(spr_lst)
	for k,v in pairs(spr_lst) do
		if v.stype == 1 then
			local animation = cc.AnimationCache:getInstance():getAnimation(v.ani_key)
			if animation then
				local action = nil
				animation:retain()
				local animate = cc.Animate:create(animation)
				animation:release()
				if v.loop == -1 then
					action = cc.RepeatForever:create(animate)
				else
					action = cc.Repeat:create(animate,v.loop)
				end

				if v.spr then
					v.spr:runAction(action)
				end
			end
		elseif v.stype == 2 then
			--todo
		elseif v.stype == 3 then
			--todo
			local src_cfg = sprite_ani_config[v.src_id]
			local pit_obj = cc.ParticleSystemQuad:create(src_cfg.file)
			self:addChild(pit_obj)
			pit_obj:setPosition(v.sspos.x,v.sspos.y)
			pit_obj:setAutoRemoveOnFinish(true)
		end

		local __start_end_call = function ()
			self:startEffEndCall()
		end

		if v.spr then
			ActionEffectPlayer.getInstance():play(v.spr,__start_end_call,v.act_id)
		end
	end


	MusicEffectPlayer.getInstance():play(jc_random_select_id(self.fcfg.alive.mus_lst))
	for i=1,#self.fcfg.alive.skl_id_lst do
		SkillPlayer.getInstance():play(self,self.fcfg.alive.skl_id_lst[i])
	end
end

--开始动作结束时回调
function Fish:startEffEndCall()
	
end

function Fish:runStartSkill()
	--self.alive_skl_cfg
end

function Fish:runDeadEff(spr_lst)
	for k,v in pairs(spr_lst) do
		if v.stype == 1 then
			local animation = cc.AnimationCache:getInstance():getAnimation(v.ani_key)
			if animation then
				local action = nil
				animation:retain()
				local animate = cc.Animate:create(animation)
				animation:release()
				if v.loop == -1 then
					action = cc.RepeatForever:create(animate)
				else
					action = cc.Repeat:create(animate,v.loop)
				end

				if v.spr then
					v.spr:runAction(action)
				end
				
			end
		elseif v.stype == 2 then
			--todo
		elseif v.stype == 3 then
			--todo
			local src_cfg = sprite_ani_config[v.src_id]
			local pit_obj = cc.ParticleSystemQuad:create(src_cfg.file)
			self:addChild(pit_obj)
			pit_obj:setPosition(v.sspos.x,v.sspos.y)
			pit_obj:setAutoRemoveOnFinish(true)
		end

		local __dead_end_call = function ()
			self:deadEffEndCall()
		end

		if v.spr then
			ActionEffectPlayer.getInstance():play(v.spr,__dead_end_call,v.act_id,self)
		end
	end

	FishLabelFntManager.getInstance():play(self.cur_pos,self.fish_score)
	MusicEffectPlayer.getInstance():play(jc_random_select_id(self.fcfg.death.mus_lst))

	if #self.cur_rline_obj_lst > 0 then
		print("send line,fish obj id = " .. self.obj_id .. ",cfg_id = " .. self.fcfg.id)
	end

	for i=1,#self.fcfg.death.skl_id_lst do
		SkillPlayer.getInstance():play(self,self.fcfg.death.skl_id_lst[i])
	end
end

function Fish:deadEffEndCall()
	
	--play gold
	local info = {
		spos   = self.cur_pos,
		angle  = self.cur_angle,
		number = self.fish_score,
		end_pos = {
			x = self.gold_end_pos.x,
			y = self.gold_end_pos.y,
		},
	}
	FishGoldManager.getInstance():play(info)

	self.user_info = {}
	self.run_t = 0
	self.gold_end_pos = {x = 0,y = 0,}
	self.fsh_curve:resetInfo()

	if self.cur_line_obj then
		self.cur_line_obj:removeFromParent()
	end

	self.cur_rline_obj_lst = {}

	self:removeFromParent()

	if self.is_draw_curve == true then
		self.curve_draw:removeFromParent()
	end
end

function Fish:runDeadSkill()
	--self.death_skl_cfg
end

function Fish:setFishStartPos(pos)
	self:setPosition(pos.x,pos.y)
end

function Fish:setFishPosAndAngle(pos,angle,spr_lst)
	if self.use_test == 1 then
		local str = string.format("%d,%d",pos.x,pos.y)
		self.info_label:setString(str)
	end
	if pos then self:setPosition(pos.x,pos.y) end
	if angle then self:setRotation(angle) end
end

function Fish:setFishPos(pos,spr_lst)
	self:setPosition(pos)
end

function Fish:createFishSpr(cfg_item)
	local spr = nil
	if cfg_item then
		local frame_name = string.format(cfg_item.pattern,1)
		spr = cc.Sprite:createWithSpriteFrameName(frame_name)
	end

	return spr
end

function Fish:createAnimation(cfg_item,bregorg)
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

function Fish:createFishItem(data,item_lst,buseShadow,busepit)
	local len 	= #data.view_inf
	--local opos  = {x = data.size.width/2,y = data.size.height/2,}

	for i=1,len do
		local src_cfg = sprite_ani_config[data.view_inf[i].src_id]
		--local pos = {x = self.start_pos.x + opos.x + data.view_inf[i].pos.x,y = self.start_pos.y + opos.y + data.view_inf[i].pos.y,}

		local item  = {}
		item.loop 	= data.view_inf[i].loop
		item.act_id = data.view_inf[i].act_id
		item.src_id = data.view_inf[i].src_id
		item.stype	= src_cfg.stype
		item.sspos  = data.view_inf[i].pos
		item.ani_key = src_cfg.key

		if src_cfg.stype == 1 then
			item.spr = self:createFishSpr(src_cfg)

			local exit_ani = cc.AnimationCache:getInstance():getAnimation(item.ani_key)
			if exit_ani == nil then
				local animation = self:createAnimation(src_cfg)
				cc.AnimationCache:getInstance():addAnimation(animation,item.ani_key)
			end

			self:addChild(item.spr)
			item.spr:setPosition(data.view_inf[i].pos.x,data.view_inf[i].pos.y)
			-- if buseShadow == true then
			-- 	item.spr:enableShadow(self.cur_shadow_offset,lk_system_config.fish_shadow_alpha,buseShadow)
			-- end
		elseif src_cfg.stype == 2 then
			item.spr = cc.Sprite:create(src_cfg.file)
			self:addChild(item.spr)
			item.spr:setPosition(data.view_inf[i].pos.x,data.view_inf[i].pos.y)
			-- if buseShadow == true then
			-- 	item.spr:enableShadow(self.cur_shadow_offset,lk_system_config.fish_shadow_alpha,buseShadow)
			-- end
		elseif src_cfg.stype == 3 then
			--pirticle

			if busepit == true then
				local pit_obj = cc.ParticleSystemQuad:create(src_cfg.file)
				self:addChild(pit_obj)
				pit_obj:setPosition(data.view_inf[i].pos.x,data.view_inf[i].pos.y)
				pit_obj:setAutoRemoveOnFinish(true)
			end	
		end

		table.insert(item_lst,item)
	end
end

function Fish:setFishCurveId(id)
	if id and id ~= -1 then
		local ccfg = curve_config[id]

		if ccfg then
			self.curve_cfg = ccfg
			self.fsh_curve:clearAllCurve()
			self.fsh_curve:setCurveRatio(self.curve_cfg.ratio)
			for i=1,#self.curve_cfg.data do
				self.fsh_curve:addCurve(self.curve_cfg.data[i])
			end
			
			self:setCurveRotation(self.curve_cfg.angle)

			if self.is_draw_curve == true then
				self:drawFishCurve(self.fsh_curve)
			end
		end
	end
end

function Fish:drawFishCurve(cur_obj)
	local tmp_curve = clone(cur_obj)
	self.curve_draw = cc.DrawNode:create()
	FishManager.getInstance():getParent():addChild(self.curve_draw,100000000)

	local spos = clone(self.start_pos)
	local draw_t = 0
	while tmp_curve:isCurveEnd() == false do
		local epos = tmp_curve:getPosAndSlopeByTime(draw_t)
		self.curve_draw:drawLine(spos, epos, cc.c4f(1,1,1,1))
		spos = clone(epos)
		draw_t = draw_t + 0.1
	end
end

function Fish:setStartPos(pos)
	self.start_pos = pos
	self.fsh_curve:setStartPos(pos)
	self:setFishStartPos(pos)
end

function Fish:setRunTime(t)
	if t then
		self.run_t = t
	end
end

function Fish:update(dt)
	if (BackgroundSceneManager.getInstance():getSceneState() == 2)
		and (self.scene_id ~= BackgroundSceneManager.getInstance():getCurrentSceneId() and self.scene_id ~= -1) then
		dt = dt*lk_system_config.cut_scene_fish_vx
	end

	self.run_t = self.run_t + dt
	self.cur_pos,self.cur_angle = self.fsh_curve:getPosAndAngleByTime(self.run_t)
	self:setFishPosAndAngle(self.cur_pos,self.cur_angle,self.spr_alive_lst)

	--use light mod
	local light_obj = FishManager.getInstance():getFishLightObj()
	if light_obj and self.buse_light_mod == true then
		local vec3 = {x = self.cur_pos.x,y = self.cur_pos.y,z = lk_system_config.fish_light_distance,}
		local shadow_pos = light_obj:caluteSpotLampShadowPos(vec3)

		local def_way = self.fsh_curve:getActionWay()
		--self.cur_shadow_offset = {width = shadow_pos.x*def_way,height = shadow_pos.y*def_way,}
		local off_pos = {x = shadow_pos.x,y = shadow_pos.y,}

		local new_angle = 360 - self.cur_angle
		local new_x = off_pos.x*math.cos((new_angle/180)*math.pi) + off_pos.y*math.sin((new_angle/180)*math.pi)
		local new_y = off_pos.y*math.cos((new_angle/180)*math.pi) - off_pos.x*math.sin((new_angle/180)*math.pi)

		self.cur_shadow_offset = {width = new_x,height = new_y,}
		-- for k,v in pairs(self.spr_alive_lst) do
		-- 	if v.spr then
		-- 		v.spr:setShadowOffset(self.cur_shadow_offset)
		-- 	end
		-- end
	end
end

--[[
	cir_lst = {
		[1] = {a,b,r},
	}
]]
function Fish:isShotFish(cir_lst)
	if self.cur_pos ~= nil then
		for k,v in pairs(cir_lst) do
			for m,n in pairs(self.bbx_cfg.data) do
				local angle = self.cur_angle
				local new_a = n.a*math.cos((angle/pie_angle)*math.pi) + n.b*math.sin((angle/pie_angle)*math.pi)
				local new_b = n.b*math.cos((angle/pie_angle)*math.pi) - n.a*math.sin((angle/pie_angle)*math.pi)
				local cpos = {x = new_a + self.cur_pos.x,y = new_b + self.cur_pos.y,}
				local dis = math.sqrt(math.pow(cpos.x - v.a,2) + math.pow(cpos.y - v.b,2))
				if v.r + n.r > dis then
					return true
				end
			end
		end
	end

	return false
end

function Fish:getCurrentBBX()
	local bbx = clone(self.bbx_cfg.data)
	for k,v in pairs(self.bbx_cfg.data) do
		bbx[k].a = v.a*math.cos((self.cur_angle/pie_angle)*math.pi) + v.b*math.sin((self.cur_angle/pie_angle)*math.pi) + self.cur_pos.x
		bbx[k].b = v.b*math.cos((self.cur_angle/pie_angle)*math.pi) - v.a*math.sin((self.cur_angle/pie_angle)*math.pi) + self.cur_pos.y
	end

	return bbx
end

function Fish:isPointInFish(pos)
	if self.cur_pos ~= nil then
		for m,n in pairs(self.bbx_cfg.data) do
			local angle = self.cur_angle
			local new_a = n.a*math.cos((angle/pie_angle)*math.pi) + n.b*math.sin((angle/pie_angle)*math.pi)
			local new_b = n.b*math.cos((angle/pie_angle)*math.pi) - n.a*math.sin((angle/pie_angle)*math.pi)
			local cpos = {x = new_a + self.cur_pos.x,y = new_b + self.cur_pos.y,}
			local dis = math.sqrt(math.pow(cpos.x - pos.x,2) + math.pow(cpos.y - pos.y,2))
			if n.r > dis then
				return true
			end
		end
	end

	return false
end

function Fish:showAliveSpr(bshow)
	for k,v in pairs(self.spr_alive_lst) do
		if v.spr then
			v.spr:setVisible(bshow)
		end
	end
end

function Fish:showDeadSpr(bshow)
	for k,v in pairs(self.spr_death_lst) do
		if v.spr then
			v.spr:setVisible(bshow)
		end
	end
end

function Fish:fishDead()
	self:showAliveSpr(false)
	--self:setFishPosAndAngle(self.cur_pos,self.cur_angle,self.spr_death_lst)
	self:showDeadSpr(true)
	self:runDeadSkill()
	self:runDeadEff(self.spr_death_lst)
	self:setLocalZOrder(fish_zorder + 100)
end

function Fish:fishOut()
	self:showAliveSpr(false)
	self:showDeadSpr(false)
	self.run_t = 0
	self.gold_end_pos = {x = 0,y = 0,}
	self.fsh_curve:resetInfo()
	--print("fish out of time,fish id = " .. self.obj_id)
	if self.is_draw_curve == true then
		self.curve_draw:removeFromParent()
	end
	
	self:removeFromParent()
end

function Fish:isOutofTime()
	return self.fsh_curve:isCurveEnd()
end

function Fish:fishStart()
	self:showAliveSpr(true)
	self:showDeadSpr(false)
	self:runStartSkill()
	self:runStartEff(self.spr_alive_lst)

	self.cur_pos,self.cur_angle = self.fsh_curve:getPosAndAngleByTime(0.001)
	self:setFishPosAndAngle(self.cur_pos,self.cur_angle,self.spr_alive_lst)
end

function Fish:resumnOrgin()
	
end

function Fish:getObjectId()
	return self.obj_id
end

function Fish:getDataId()
	return self.fcfg.id
end


function Fish:setReserve(bres)
	self.fsh_curve:setActionReserve(bres)
end

function Fish:setCurveRotation(angle)
	self.fsh_curve:setActionRotation(angle)	
end

--[[
	user_info = {}
]]
function Fish:setUserInfo(user_info)
	if user_info then self.user_info = user_info end
end

function Fish:getUserInfo()
	return self.user_info
end

function Fish:getCurrentPosAndAngle()
	return self.cur_pos,self.cur_angle
end

function Fish:setGoldMoveEndPos(pos)
	self.gold_end_pos = {x = pos.x,y = pos.y,}
end

function Fish:setScoreVal(val)
	self.fish_score = val
end

function Fish:getScoreVal()
	return self.fish_score
end

function Fish:getLockLevel()
	return self.fcfg.lock_level
end

function Fish:getCurrentPos()
	return self.cur_pos
end

function Fish:setShotSetId(set_id)
	self.user_info.set_id = set_id
end

function Fish:getShotSetId()
	return self.user_info.set_id
end

function Fish:addLineRelObj(obj)
	if obj then	table.insert(self.cur_rline_obj_lst,obj) end
end

function Fish:getLineRelObjLst()
	return self.cur_rline_obj_lst
end

function Fish:setCurrentLineObj(obj)
	self.cur_line_obj = obj
end

function Fish:getCurrentLineObj()
	return self.cur_line_obj
end

function Fish:setUseLightModel(buse)
	self.buse_light_mod = buse
	-- for k,v in pairs(self.spr_alive_lst) do
	-- 	if v.spr then
	-- 		v.spr:enableShadow(self.cur_shadow_offset,lk_system_config.fish_shadow_alpha,self.buse_light_mod)
	-- 	end
	-- end
end

function Fish:setFishLevel(level)
	if level then
		self.fish_level = level
	end
end

function Fish:getFishLevel()
	return self.fish_level
end

function Fish:getFishConfigId()
	return self.fcfg.id
end

function Fish:setFishSceneId(sid)
	self.scene_id = sid
end

function Fish:getFishSceneId()
	return self.scene_id
end
