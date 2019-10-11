#remark
--[[
	模块配置管理
]]

local cfg_data = {}
ModuleCfgMgr = {}

function ModuleCfgMgr.add_module_cfg(p)
	-- body
	if p then cfg_data[p.property.name] = p end
end

function ModuleCfgMgr.get_module_cfg(name)
	-- body
	if name then return cfg_data[name] end
end


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
