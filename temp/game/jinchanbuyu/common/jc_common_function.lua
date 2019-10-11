

function jc_create_spr_by_plist(cfg)
	local spr = nil
	if cfg then
		local frame_name = string.format(cfg.pattern,1)
		spr = cc.Sprite:createWithSpriteFrameName(frame_name)
	end

	return spr
end

function jc_create_animation(cfg,bregorg)
	local animation = nil
	if cfg then
		local frames = display.newFrames(cfg.pattern,1,cfg.fs)
		animation = cc.Animation:createWithSpriteFrames(frames,cfg.ft)
		if bregorg == true then
			animation:setRestoreOriginalFrame(bregorg)
		end
	end

	return animation
end

function jc_dyanplay_ani(parent,data,pos,rotation,loop,end_call)
	if parent and data then

    	local frames = display.newFrames(data.pattern,1,data.fs)
		local animation,sprite = display.newAnimation(frames,data.ft)
		parent:addChild(sprite)
		sprite:setPosition(pos.x,pos.y)
		--sprite:setRotation(rotation)
		
		local seq_arr = {}
		if loop == -1 then
			table.insert(seq_arr,cc.RepeatForever:create(cc.Animate:create(animation)))
		elseif loop >= 1 then
			table.insert(seq_arr,cc.Repeat:create (cc.Animate:create(animation),loop))
		end

		local function __jc_auto_delete_call(node)
			node:stopAllActions()
			node:removeFromParent()
    		if end_call then end_call() end
    		--print("remove auto sprite src>>>>>>>>>>>>>>")
		end

		table.insert(seq_arr,cc.CallFunc:create(__jc_auto_delete_call))
		sprite:runAction(cc.Sequence:create(seq_arr))
	end
end

--[[lst = {[x] = {gi,id },} ]]
function jc_random_select_id(lst)
	math.newrandomseed()
	local val = math.random()
	local sum = 0
	for i=1,#lst do
		sum = sum + lst[i].gi
		if sum > val then
			return lst[i].id
		end
	end

	return -1
end

