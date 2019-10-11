

--[[
	动作链播放器
]]

ActionEffectPlayer = class("ActionEffectPlayer",function ()
	local obj = {}
	return obj
end)

local __action_effect_player_obj = nil


function ActionEffectPlayer.getInstance()
	if __action_effect_player_obj == nil then
		__action_effect_player_obj = ActionEffectPlayer.new()
	end
	
	return __action_effect_player_obj
end

function ActionEffectPlayer.destroyInstance()
	__action_effect_player_obj = nil
end

function ActionEffectPlayer:init()
	print("action effect player initialize!")
end

function ActionEffectPlayer:play(obj,end_call,eff_id,parent_obj)
	if obj and eff_id ~= nil and eff_id ~= -1 then
		local eff_cfg  = action_eff_config[eff_id]
		local aeff_lst = self:analyze(eff_cfg)
		self:setInitParam(eff_cfg.init_param,obj,parent_obj)

		local aeff_len = #aeff_lst

		for i=1,aeff_len do

			local len = #aeff_lst[i]
			local lst = aeff_lst[i]

			local seq_all_lst = {} --一个链

			for j=1,len do
				local act_obj 		= ActionCreater.create(lst[j].key,lst[j].param)
				local act_obj_rvs 	= nil

				if act_obj and self:isCanReserver(lst[j].key) == true and lst[j].breserver == true then 
					act_obj_rvs = act_obj:reverse() 
				end

				local seq_part_lst = {}
				if act_obj then	table.insert(seq_part_lst,act_obj) end
				if act_obj_rvs then table.insert(seq_part_lst,act_obj_rvs) end

				local reapt_obj = nil
				if lst[j].loop == -1 then
					reapt_obj = cc.Repeat:create(cc.Sequence:create(seq_part_lst),100000000)
				else
					reapt_obj = cc.Repeat:create(cc.Sequence:create(seq_part_lst),lst[j].loop)
				end
				table.insert(seq_all_lst,reapt_obj)
			end

			if i == aeff_len then --最后一个链来执行完成回调
				local __end_call_func = function ()
					if end_call then end_call() end
				end
				local end_call_obj = cc.CallFunc:create(__end_call_func)

				table.insert(seq_all_lst,end_call_obj)
			end
			

			obj:runAction(cc.Sequence:create(seq_all_lst))
		end
	else--没有动作链直接执行完成回调
		if end_call then end_call() end
	end
end

function ActionEffectPlayer:analyze(data)
	local act_lst = {}

	if data then
		local eff_cfg_lst 	= data.eff_lst
	
		local cur_new_index = 1
		table.insert(act_lst,{})
		local eff_len = #eff_cfg_lst

		for i=1,eff_len do
			table.insert(act_lst[cur_new_index],eff_cfg_lst[i])

			if eff_cfg_lst[i].nxt_idx == -1 and i < eff_len then
				table.insert(act_lst,{})
				cur_new_index = #act_lst
			end
		end
	end

	return act_lst
end

function ActionEffectPlayer:isCanReserver(act_key)

	if act_key == "move_by" 
		or act_key == "scale_by" 
		or act_key == "rotate_by" 
		or act_key == "skew_by" 
		or act_key == "jump_by" 
		or act_key == "tint_by" 
		then

		return true
	end

	return false
end

function ActionEffectPlayer:setInitParam(param,obj,parent_obj)
	if param and obj then
		if param.angle then	obj:setRotation(param.angle) end
		if param.sax then obj:setScaleX(param.sax) end
		if param.say then obj:setScaleY(param.say) end
		if param.skx then obj:setSkewX(param.skx) end
		if param.sky then obj:setSkewY(param.sky) end
		if param.srkx then obj:setRotationSkewX(param.srkx) end
		if param.srky then obj:setRotationSkewY(param.srky) end
		
		if param.zorder then
			if parent_obj then
				parent_obj:setLocalZOrder(param.zorder)
			else
				obj:setLocalZOrder(param.zorder)
			end
		end
	end
end


