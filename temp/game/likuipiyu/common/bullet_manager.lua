


--[[
	子弹对象管理
]]

BulletManager = class("BulletManager",function ()
	local obj = {}
	return obj
end)


local __bullet_manager_object = nil


function BulletManager.getInstance()
	if __bullet_manager_object == nil then
		__bullet_manager_object = BulletManager.new()
	end

	return __bullet_manager_object
end

function BulletManager.destroyInstance()
	__bullet_manager_object = nil
end

--info = {bonding_size = {width,height,},}
function BulletManager:init(info)
	self.bonding_size = info.bonding_size
	self.alive_bullet_object_lst = {}
	self.alive_bullet_object_bbx_lst = {}
end

--[[
	info = {
		id, --子弹id
		pos, --起始位置
		angle,--偏转角
		side,--哪一边
		user_info = {
			player_id,--玩家id
			set_id,--坐位id
		},
		lock_fish_id,当前锁定鱼id
	} 
]]
function BulletManager:sendBullet(info)
	local obj = ObjectPool.getInstance():getObject(ObjectClassType.type_bullet,info.id)

	if obj then
		obj:setBondingSize(self.bonding_size)
		obj:setStartPosAndAngle(info.pos,info.angle,info.side,info.lock_fish_id)
		obj:setUserInfo(info.user_info)
		obj:setUseState(true)
		self.alive_bullet_object_lst[obj:getObjectId()] = obj
		self.alive_bullet_object_bbx_lst[obj:getObjectId()] = obj:getBondingBox()
	else
		print("can not get bullet object in object pool!")
	end
end

function BulletManager:update(dt)
	for k,v in pairs(self.alive_bullet_object_lst) do
		v:update(dt)
		self.alive_bullet_object_bbx_lst[k] = v:getBondingBox()
	end
end

function BulletManager:getBulletAliveLst()
	return self.alive_bullet_object_lst
end

function BulletManager:removeBulletObject(obj_id)
	local obj = self.alive_bullet_object_lst[obj_id]
	if obj then
		obj:shotSomething()
		obj:setUseState(false)
		obj:resumeOrgin()
		self.alive_bullet_object_lst[obj_id] = nil
		self.alive_bullet_object_bbx_lst[obj_id] = nil
	end
end

function BulletManager:removeBulletObjectBySetId(set_id)
	for k,v in pairs(self.alive_bullet_object_lst) do
		if set_id == v:getBulletSetId() then
			v:setUseState(false)
			v:resumeOrgin()
			self.alive_bullet_object_lst[k] = nil
			self.alive_bullet_object_bbx_lst[k] = nil
		end
	end
end

function BulletManager:getBulletConter()
	local conter = 0
	for k,v in pairs(self.alive_bullet_object_lst) do
		conter = conter + 1
	end

	return conter
end

function BulletManager:getBulletBBX(obj_id)
	return self.alive_bullet_object_bbx_lst[obj_id]
end


