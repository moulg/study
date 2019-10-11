#remark
EventUtils = {}

--金币变化事件
EventUtils.GOLD_CHANGE = "GOLD_CHANGE"
--银行金币变化事件
EventUtils.SAFEGOLD_CHANGE = "SAFEGOLD_CHANGE"
--会员信息变化事件
EventUtils.VIP_CHANGE = "VIP_CHANGE"
--元宝变化事件
EventUtils.ACER_CHANGE = "ACER_CHANGE"
--等级变化事件
EventUtils.LEVEL_CHANGE = "LEVEL_CHANGE"
--刷新转账记录
EventUtils.FRESH_RECORD = "FRESH_RECORD"
-- EventUtils.eventsGroup[eventname] = {event1, event2, event3..}
EventUtils.eventsGroup = {}

--注册事件
--[[
justOnce  只回调一次
]]
function EventUtils.addEventListener(name, target, callback, justOnce)
	if EventUtils.eventsGroup[name]	== nil then
		EventUtils.eventsGroup[name] = {}
	end

	table.insert( EventUtils.eventsGroup[name], {target = target, callback = callback, justOnce = justOnce} )
end

--触发事件
function EventUtils.dispathEvents( name )
	if EventUtils.eventsGroup[name] then
		for k,edata in pairs(EventUtils.eventsGroup[name]) do
			if edata and edata.callback ~= nil then
				edata.callback()

                if edata.justOnce == true then
                   EventUtils.eventsGroup[name][k] = nil
                   return
                end
			end
		end
	end
end

--删除事件、
function EventUtils.removeEventListener( name, target )
	local index
	if EventUtils.eventsGroup[name] then
		for k,edata in pairs(EventUtils.eventsGroup[name]) do
			if edata.target == target then
				index = k
				break
			end
		end

		if index then
			table.remove(EventUtils.eventsGroup[name], index)
			if #EventUtils.eventsGroup[name]  == 0 then
				EventUtils.eventsGroup[name] = nil
			end
		end
	end
end