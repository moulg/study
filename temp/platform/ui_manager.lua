#remark
--[[
	场景对象管理
]]
UISceneObjManager = {
	obj_lst = {},
}

function UISceneObjManager.add_sc_obj(key,obj)
	-- body
	local bExits = false
	for k,v in pairs(UISceneObjManager.obj_lst) do
		if k == key then
			bExits = true
			break
		end
	end

	if bExits == false then
		UISceneObjManager.obj_lst[key] = obj

		return true
	end

	return false
end

function UISceneObjManager.del_sc_obj(key)
	-- body
	if key then
		UISceneObjManager.obj_lst[key] = nil
	end
end


function UISceneObjManager.get_sc_obj_by_key(key)
	-- body
	return UISceneObjManager.obj_lst[key]
end

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
