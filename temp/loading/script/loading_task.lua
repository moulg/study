#remark
--[[
	任务加载
]]
local barDefaultPos = cc.p(960, 100)

LoadingTask = class("LoadingTask",function ()
	local obj = cc.Node:create()
	return obj
end)

--[[
	info = {
		parent,
		task_call = function (percent,index,texture),
		complete_call = function (),
		task_lst = {[x] = {src = "",},},
		ui_info = {
			back_pic 		= "",
			bar_back_pic 	= "",
			bar_process_pic = "",
			b_self_release 	= true, --决定是否由loading界面自动释放
			bar_Pos 		= cc.p(960,100)
		},
	}
]]
function LoadingTask.create(info)
	local obj = LoadingTask.new()
	if obj and info then
		if info.parent then info.parent:addChild(obj, 100) end
		obj:init(info)
	end

	return obj
end


function LoadingTask:init(info)
	self:init_data(info)
	self:init_ui()
	self:registerUpdate()
end

function LoadingTask:init_data(info)
	self.task_info = info
	self.b_create_self_ui = false
	if self.task_info.ui_info then self.b_create_self_ui = true end

	self.b_self_release = false
	if self.task_info.ui_info.b_self_release then self.b_self_release = self.task_info.ui_info.b_self_release end

	self.add_item_index = -1
	self.cur_task_index = -1
	self.total_task 	= 0
	if #self.task_info.task_lst > 0 then 
		self.cur_task_index = 1
		self.add_item_index = 1
		self.total_task = #self.task_info.task_lst

		self.work_func = function (texture)
			if self.cur_task_index <= self.total_task then
				local item 		= self.task_info.task_lst[self.cur_task_index]
				local percent 	= self.cur_task_index/self.total_task

				if self.task_info.task_call then self.task_info.task_call(percent,self.cur_task_index,texture) end

                if self.cur_task_index == nil then
                    return
                end
				self.cur_task_index = self.cur_task_index + 1
			end
		end
	end
end

function LoadingTask:init_ui()
	self:setPosition(0,0)
	if self.b_create_self_ui == true then
		self.imgBack = ccui.ImageView:create(self.task_info.ui_info.back_pic)
		self.imgBack:setTouchEnabled(true)
		self.imgBack:setAnchorPoint(0,0)
		self.imgBack:setPosition(0,0)
		self:addChild(self.imgBack)

		self.loadBar = ccui.Slider:create()
		self.loadBar:setPercent(0)
		self.loadBar:loadBarTexture(self.task_info.ui_info.bar_back_pic,0)
		self.loadBar:loadProgressBarTexture(self.task_info.ui_info.bar_process_pic,0)
		self.loadBar:setAnchorPoint(0.5,0.5)
		if self.task_info.ui_info.bar_Pos then
			self.loadBar:setPosition(self.task_info.ui_info.bar_Pos)
		else
			self.loadBar:setPosition(barDefaultPos)
		end
		self:addChild(self.loadBar)
	end
end

function LoadingTask:registerUpdate()
	local scheduler = cc.Director:getInstance():getScheduler()
	self.schedule_handler = scheduler:scheduleScriptFunc(function (dt) return self:update(dt) end,0.0,false)
end

function LoadingTask:destroy()
	print("remove loading task>>>>>>>>>>>>>>>>>>>>>")
	local scheduler = cc.Director:getInstance():getScheduler()
	scheduler:unscheduleScriptEntry(self.schedule_handler)
	if self.task_info.complete_call then self.task_info.complete_call() end
	if self.b_self_release == true then self:removeFromParent() end

	return true
end

function LoadingTask:forcedDestory()
    self.total_task = 0
    self.task_info.complete_call = nil
end

function LoadingTask:update(dt)
	if self.total_task <= 0 then
		return self:destroy()
	end

	if self.add_item_index > 0 and self.add_item_index <= self.total_task and self.work_func then
		--display.loadImage(self.task_info.task_lst[self.add_item_index].src,self.work_func) --异步有问题
		self.work_func(0,self.cur_task_index,nil)
		self.add_item_index = self.add_item_index + 1
	end
	

	if self.cur_task_index > self.total_task then
		return self:destroy()
	end
	
	if self.b_create_self_ui == true and self.total_task > 0 then
		local percent = self.cur_task_index/self.total_task
		self.loadBar:setPercent(percent*100)
	end

	return true
end

