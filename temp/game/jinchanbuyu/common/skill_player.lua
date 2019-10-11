


--[[
	特技播放器
]]



SkillPlayer = class("SkillPlayer",function ()
	local obj  = {}
	return obj
end)

local skl_func_lst = {}
__skill_player_obj = nil

function SkillPlayer.getInstance()
	if __skill_player_obj == nil then
		__skill_player_obj = SkillPlayer.new()
	end

	return __skill_player_obj
end

function SkillPlayer.destroyInstance()
	__skill_player_obj = nil
end

function SkillPlayer:init()
	
end

function SkillPlayer:play(obj,id)
	for k,v in pairs(skl_func_lst) do
		for m,n in pairs(v.sk_id_lst) do
			if n == id then
				if v.func then
					v.func(obj,id)
					return true
				end
			end
		end
	end
	return false
end



---执行函数


--full screen shake
local function full_screen_vibration(obj,id)
	-- local bk_obj = BackgroundSceneManager.getInstance():getCurrentBkSenceObj()

	-- if bk_obj and skill_config[id] then
	-- 	local seq_lst = {}
	-- 	local shake_obj = cc.Shake:create(skill_config[id].t,skill_config[id].dx,skill_config[id].dy)
	-- 	local rep_obj = cc.Repeat:create(shake_obj,skill_config[id].loop)
	-- 	table.insert(seq_lst,rep_obj)

	-- 	local function __fsv_end_call()
	-- 		bk_obj:setPosition(jc_system_config.scene_size.width/2,jc_system_config.scene_size.height/2)
	-- 	end

	-- 	local end_call_obj = cc.CallFunc:create(__fsv_end_call)
	-- 	table.insert(seq_lst,end_call_obj)



	-- 	bk_obj:runAction(cc.Sequence:create(seq_lst))
	-- end
end

--rotate score  pm = {pos,score}
local function rotate_score_skill(ext_obj,skid)
	local pm = {}
	pm.pos   = jc_system_config.rotate_score_pos
	pm.score = ext_obj:getScoreVal()

	local set_id = ext_obj:getShotSetId()
	--print("skill set id = " .. set_id)
	local parent = BatteryManager.getInstance():getBatteryBySetId(set_id)
	if parent then
		local info = {obj = parent,id = skid,param = pm,}
		RotateScore.create(info)
	end
end

local function line_fish(ext_obj,skid)
 	local pt = ext_obj:getParent()
	local spos = ext_obj:getCurrentPos()
	local rline_obj_lst = ext_obj:getLineRelObjLst()
	local sid = skill_config[skid].line_src_id

	for i=1,#rline_obj_lst do
 		local epos = rline_obj_lst[i]:getCurrentPos()
		local info = {pos1 = spos,pos2 = epos,parent = pt,src_id = sid,}
		local line_obj = SkillItemLine.create(info)
		rline_obj_lst[i]:setCurrentLineObj(line_obj)
	end

	print("execute line skill fshid =  "..ext_obj:getObjectId()..",line lst "..#rline_obj_lst .."cfg id = "..ext_obj:getFishConfigId())
end

local function add_show_word(ext_obj,skid)
	local buf = ext_obj:getChildByName(skill_config[skid].key)
	local fsh_level = ext_obj:getFishLevel()
	if buf ~= nil then
		buf:setString(string.format("%d",fsh_level))
	else
		buf = cc.Label:createWithBMFont(skill_config[skid].fnt_src,string.format("%d",fsh_level))
		buf:setName(skill_config[skid].key)
		ext_obj:addChild(buf)
		buf:setPosition(skill_config[skid].pos.x,skill_config[skid].pos.y)
	end
end

local function big_fish_boom(ext_obj,skid)
	local pos = ext_obj:getCurrentPos()
	local skl_info = skill_config[skid]

	for k,v in pairs(skl_info.src_id_lst) do
		local src_cfg = sprite_ani_config[v]
		if src_cfg.stype == 1 then
		elseif src_cfg.stype == 2 then
		elseif src_cfg.stype == 3 then
			local pit_obj = cc.ParticleSystemQuad:create(src_cfg.file)
			ext_obj:getParent():addChild(pit_obj)
			pit_obj:setPosition(pos.x,pos.y)
			pit_obj:setLocalZOrder(1000)
			pit_obj:setAutoRemoveOnFinish(true)
			--print("play big fish boom>>>>>>>>>>>>>>>>>>")
		end
	end
end


--register skill execute function
skl_func_lst[1] = {func = full_screen_vibration,sk_id_lst = {1,},}
skl_func_lst[2] = {func = rotate_score_skill,sk_id_lst = {2,},}
skl_func_lst[3] = {func = line_fish,sk_id_lst= {3,},}
skl_func_lst[4] = {func = add_show_word,sk_id_lst = {4,},}
skl_func_lst[5] = {func = big_fish_boom,sk_id_lst = {5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,},}

