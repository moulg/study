

--[[
	炮台管理
]]

BatteryManager = class("BatteryManager",function ()
	local obj = {}
	return obj
end)

local __battery_manager_obj = nil

function BatteryManager.getInstance()
	if __battery_manager_obj == nil then
		__battery_manager_obj = BatteryManager.new()
	end
	return __battery_manager_obj
end

function BatteryManager.destroyInstance()
	for k,v in pairs(__battery_manager_obj.object_lst) do
        if v then
		    v:removeFromParent()
        end
	end
	__battery_manager_obj = nil
	WindowRegFun.unreg_key_down_call("__on_battery_key_down")
	WindowRegFun.unreg_key_up_call("__on_battery_key_up")
end

function BatteryManager:init(parent)
	self.object_lst = {}
	self.parent = parent

	local function __on_battery_key_down(s)	self:onKeyDown(s) end
	WindowRegFun.reg_key_down_call(__on_battery_key_down,"__on_battery_key_down")

	local function __on_battery_key_up(s) self:onKeyUp(s) end
	WindowRegFun.reg_key_up_call(__on_battery_key_up,"__on_battery_key_up")

	self.clear_call = nil
end

--[[
	info = {
		user_info = {
			player_id,--玩家id
			set_id,--坐位id
			is_local
			chips,
			....
		},
	}
	binit
]]
function BatteryManager:createBattery(info,binit)
	local battery_obj = self.object_lst[info.user_info.set_id]

	if battery_obj == nil then
		battery_obj = Battery.create()
		self.parent:addChild(battery_obj)

		local pinfo,changed = conversionLocalInfo.getConfig(info.user_info.set_id)
		--local pinfo = battery_position_config[info.user_info.set_id]
		battery_obj:setPosition(pinfo.pos.x,pinfo.pos.y)
		battery_obj.setID_changed = changed

		local info = {
			config_id = pinfo.batt_cfg_id,
			user_info = info.user_info,
			side 	  = pinfo.side,
		}
		battery_obj:setBatteryInfo(info,binit)

		self.object_lst[info.user_info.set_id] = battery_obj
	else
		print("battery_obj has exist!")
	end
end

function BatteryManager:removeBatteryBySetId(set_id)
	if set_id then 
		local battery_obj = self.object_lst[set_id]
		if battery_obj then
			battery_obj:removeFromParent()
		end
		
		self.object_lst[set_id] = nil
	end
end

function BatteryManager:getBatteryBySetId(set_id)
	if set_id then return self.object_lst[set_id] end
end

function BatteryManager:update(dt)
	for k,v in pairs(self.object_lst) do
		v:update(dt)
	end
end

function BatteryManager:resetLockFishLst(lst)
	for k,v in pairs(self.object_lst) do
		v:resetLockFishLst(lst)
	end
end

function BatteryManager:getMyselfBatteryObj()
	for k,v in pairs(self.object_lst) do
		if v:isMyBattery() == true then
			return v
		end
	end

	return nil
end

function BatteryManager:clearAllLockState()
	for k,v in pairs(self.object_lst) do
		v:resetLockFishLst({})
		v:unLockFish()
	end

	if self.clear_call then
		self.clear_call()
	end
end

function BatteryManager:onKeyUp(s)
	for k,v in pairs(self.object_lst) do
		v:onKeyUp(s)
	end
end

function BatteryManager:onKeyDown(s)
	for k,v in pairs(self.object_lst) do
		v:onKeyDown(s)
	end
end

function BatteryManager:setClearStateCall(f)
	self.clear_call = f
	self:setMyBatteryClearLockStateCall(f)
end

function BatteryManager:setMyBatteryClearLockStateCall(f)
	for k,v in pairs(self.object_lst) do
		if v:isMyBattery() == true then
			v:setClearLockState(f)
			break
		end
	end
end
