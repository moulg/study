#remark
local obj_data = {}
ModuleObjMgr   = {}

function ModuleObjMgr.add_module_obj(p,name)
	-- body
	if p and name then obj_data[name] = p end
end

function ModuleObjMgr.get_module_class_by_name(name)
	-- body
	if name then return obj_data[name] end
end


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
