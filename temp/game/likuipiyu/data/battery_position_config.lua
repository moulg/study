
--[[
	炮台位置配置
	id: 位置id
	side: 在哪条边上 1->左,2->右,3->上,4->下
	batt_cfg_id: 炮台配置id battery_config.lua
	pos: 所在位置
]]
battery_position_config = {
	[1] = {id = 1,side = 3,batt_cfg_id = 1,pos = {x = 1577,y = 1015,},},
	[2] = {id = 2,side = 3,batt_cfg_id = 2,pos = {x = 537,y = 1015,},},
	[3] = {id = 3,side = 4,batt_cfg_id = 3,pos = {x = 1383,y = 73,},},
	[4] = {id = 4,side = 4,batt_cfg_id = 4,pos = {x = 343,y = 73,},},
}

conversionLocalInfo={}
conversionLocalInfo.id=1
function conversionLocalInfo.getConfig(var)

	if conversionLocalInfo.id == 1 then
		if var == 1 then
			return battery_position_config[3]
		elseif var == 3 then
			return battery_position_config[1]
		else
			return battery_position_config[var]
		end
	elseif conversionLocalInfo.id == 2 then
		if var == 2 then
			return battery_position_config[4]
		elseif var == 4 then
			return battery_position_config[2]
		else
			return battery_position_config[var]
		end
	else
		return battery_position_config[var]
	end
end