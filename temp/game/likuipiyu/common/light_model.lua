
--[[
	模拟光照模型
]]

light_model_val = {
	spot_lamp = 1,--聚光灯模型
}


PlaneShadowLightModel = class("PlaneShadowLightModel",function ()
	local obj = {}
	return obj
end)


function PlaneShadowLightModel.create()
	local obj = PlaneShadowLightModel.new()
	if obj then
		obj:init()
	end

	return obj
end

function PlaneShadowLightModel:init()
	self.lgmodel = -1
	self.calute_param = {}
end

--[[
	info = {
		model,
		svec3 = {x,y,z},
	}
]]
function PlaneShadowLightModel:setLightInfo(info)
	self.lgmodel = info.model
	if self.lgmodel == light_model_val.spot_lamp then
		self.calute_param.spos = clone(info.svec3)
		-- add another light model
	end
end

function PlaneShadowLightModel:getPlaneShadowPos(vec3)
	if self.lgmodel == 1 then
		return self:caluteSpotLampShadowPos(vec3)
	end
end

function PlaneShadowLightModel:caluteSpotLampShadowPos(vec3)
	if vec3.z >= self.calute_param.spos.z or vec3.z < 0 then return nil end
	local spos  = {x = 0,y = 0,z = self.calute_param.spos.z,}
	local svec3 = {x = vec3.x - self.calute_param.spos.x ,y = vec3.y - self.calute_param.spos.y,z = vec3.z}

	local za_dis = math.sqrt(math.pow(svec3.x,2) + math.pow(svec3.y,2) )
	local zb_dis = za_dis*math.abs(spos.z)/(math.abs(spos.z - svec3.z))

	local bx = 0
	local by = 0

	if za_dis > 0.0001 then
		by = zb_dis*math.abs(svec3.y)/za_dis
		bx = zb_dis*math.abs(svec3.x)/za_dis
	end
	
	if svec3.x < 0 then bx = -bx end
	if svec3.y < 0 then by = -by end

	return {x = self.calute_param.spos.x + bx - vec3.x,y = self.calute_param.spos.y + by - vec3.y,}
end



