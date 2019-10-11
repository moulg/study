#remark
--[[
动画创建工具
]]


animationUtils = {}

function animationUtils.createAnimation(animationData)
	if animationData == nil then
		return
	end

	local frames = display.newFrames(animationData.picName, animationData.beginFrame, animationData.length)
	local animation,sprite = display.newAnimation(frames, animationData.frameTime)

	return animation,sprite
end

function animationUtils.createAnimation2( animationData )
	local animation, effectSpr = animationUtils.createAnimation(animationData)
	effectSpr:runAction(cc.Animate:create(animation))
	return effectSpr
end

function animationUtils.createAndPlayAnimation(parents, animationData, callback)
	if animationData == nil then
		return
	end

	local frames = display.newFrames(animationData.picName, animationData.beginFrame, animationData.length)
	local animation,sprite = display.newAnimation(frames, animationData.frameTime)
	parents:addChild(sprite)

	local function dipose(node)
		if callback then
			callback(node)
		end

		if animationData.isLoop == 0 then
			node:stopAllActions()
			node:removeFromParent()
			node = nil
		end
	end

	local seq_arr = {}
	local call_action = cc.CallFunc:create(dipose)


	if animationData.isLoop == 1 then --循环动画
		if animationData.isMove == 1 then --存在移动
			local beginPos = string.split(animationData.beginPos, ",")
			sprite:setPosition(beginPos[1], beginPos[2])
			local endPos = string.split(animationData.endPos, ",")

			local move_action = cc.MoveTo:create(animationData.moveTime,cc.p(endPos[1], endPos[2]))
			table.insert(seq_arr,move_action)
			table.insert(seq_arr,call_action)
			local seq = cc.Sequence:create(seq_arr)

			sprite:runAction(cc.RepeatForever:create ( cc.Animate:create(animation) ))
			sprite:runAction(seq)
		else
			sprite:runAction(cc.RepeatForever:create ( cc.Animate:create(animation) ))

			if animationData.lifeTime ~= 0 then  --一段事件后销毁
				table.insert(seq_arr,cc.DelayTime:create(animationData.lifeTime))
				table.insert(seq_arr,call_action)
				local seq = cc.Sequence:create(seq_arr)
				sprite:runAction(seq)
			end
		end
	else --一次性动画
		table.insert(seq_arr,cc.Animate:create(animation))
		table.insert(seq_arr,call_action)
		local seq = cc.Sequence:create(seq_arr)
		sprite:runAction( seq )
	end

	audio_manager:playOtherSound(animationData.musicId)

	return sprite
end


--[[
	动态加载播放动画
	data = {
		file,
		pattern,
		ft,
		fs,
		loop,
		pos = {x,y},
	}
]]
function animationUtils.dyanplayAnimation(parent,data,end_call)
	if parent and data then
		local cache = cc.SpriteFrameCache:getInstance()
    	cache:addSpriteFrames(data.file)-- 加载资源

    	local frames = display.newFrames(data.pattern,1,data.fs)
		local animation,sprite = display.newAnimation(frames,data.ft)
		parent:addChild(sprite)
		sprite:setPosition(data.pos.x,data.pos.y)

		local function release_call(node)
			node:stopAllActions()
			node:removeFromParent()
			local cache = cc.SpriteFrameCache:getInstance()
    		cache:removeSpriteFramesFromFile(data.file)
    		if end_call then end_call() end
    		print("free cache file = " .. data.file)
		end
		local call_action = cc.CallFunc:create(release_call)
		local ani_main = nil

		if data.loop == -1 then
			ani_main = cc.RepeatForever:create(cc.Animate:create(animation))
		elseif data.loop > 1 then
			ani_main = cc.Repeat:create (cc.Animate:create(animation),data.loop)
		else
			ani_main = cc.Animate:create(animation)
		end

		local seq_arr = {}
		table.insert(seq_arr,ani_main)
		table.insert(seq_arr,call_action)
		sprite:runAction(cc.Sequence:create(seq_arr))
	end
end

function animationUtils.createAndPlayAnimationNoAutoRemove(parents, animationData, callback)
	if animationData == nil then
		return
	end

	local frames = display.newFrames(animationData.picName, animationData.beginFrame, animationData.length)
	local animation,sprite = display.newAnimation(frames, animationData.frameTime)
	parents:addChild(sprite)

	local function dipose(node)
		if callback then
			callback(node)
		end

		if animationData.isLoop == 0 then
			node:stopAllActions()
		end
	end

	local seq_arr = {}
	local call_action = cc.CallFunc:create(dipose)


	if animationData.isLoop == 1 then --循环动画
		if animationData.isMove == 1 then --存在移动
			local beginPos = string.split(animationData.beginPos, ",")
			sprite:setPosition(beginPos[1], beginPos[2])
			local endPos = string.split(animationData.endPos, ",")

			local move_action = cc.MoveTo:create(animationData.moveTime,cc.p(endPos[1], endPos[2]))
			table.insert(seq_arr,move_action)
			table.insert(seq_arr,call_action)
			local seq = cc.Sequence:create(seq_arr)

			sprite:runAction(cc.RepeatForever:create ( cc.Animate:create(animation) ))
			sprite:runAction(seq)
		else
			sprite:runAction(cc.RepeatForever:create ( cc.Animate:create(animation) ))

			if animationData.lifeTime ~= 0 then  --一段事件后销毁
				table.insert(seq_arr,cc.DelayTime:create(animationData.lifeTime))
				table.insert(seq_arr,call_action)
				local seq = cc.Sequence:create(seq_arr)
				sprite:runAction(seq)
			end
		end
	else --一次性动画
		table.insert(seq_arr,cc.Animate:create(animation))
		table.insert(seq_arr,call_action)
		local seq = cc.Sequence:create(seq_arr)
		sprite:runAction( seq )
	end

	audio_manager:playOtherSound(animationData.musicId)

	return sprite
end



-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。

-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
