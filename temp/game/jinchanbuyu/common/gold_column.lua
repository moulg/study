

--[[
	金币柱
]]

local __gold_col_creater = require "game.jinchanbuyu.ui.ui_jinchabuyu_goldZhu"

GoldColumn = class("GoldColumn",function ()
	local obj = cc.Node:create()
	return obj
end)

function GoldColumn.create()
	local obj  = GoldColumn.new()
	if obj then
		obj:init()
	end

	return obj
end


function GoldColumn:init()
	self:initData()
	self:initUI()
end

function GoldColumn:initData()
	self.max_val = 10000
	self.cur_val = 0
	self.add_num_v = 0
	self.add_val_time = 0.8
	self.add_val_time_add = 0
	self.bupdate_pos = false
	self.bhide_self = true

	self.hide_time = 2
	self.hide_time_add = 0
end

function GoldColumn:initUI()
	self.ui_lst = __gold_col_creater.create()
	self:addChild(self.ui_lst.root)
	self.bar_size = self.ui_lst.LoadingBar_goldZhu:getContentSize()
	self.fnt_size = self.ui_lst.fnt_goldZhu:getContentSize()

	self.ui_lst.LoadingBar_goldZhu:setPercent(0)

	local cur_y = self.ui_lst.LoadingBar_goldZhu:getPercent()/100*self.bar_size.width
	self.ui_lst.fnt_goldZhu:setPositionY(cur_y)


	self:setVisible(false)
	self.ui_lst.fnt_goldZhu:setString(0)

	self.ui_lst.SpriteGold1:setVisible(false)

	local exit_ani = cc.AnimationCache:getInstance():getAnimation(sprite_ani_config[jc_system_config.gold_column_ani_src_id].key)
	if exit_ani == nil then
		local animation = self:createAnimation(sprite_ani_config[jc_system_config.gold_column_ani_src_id],true)
		cc.AnimationCache:getInstance():addAnimation(animation,sprite_ani_config[jc_system_config.gold_column_ani_src_id].key)
	end
end

function GoldColumn:setMaxValue(val)
	self.max_val = val
	self.add_num_v = self.max_val/self.add_val_time
end

function GoldColumn:setHideCall(call)
	self.hide_call = call
end

function GoldColumn:getGoldSize()
	return self.ui_lst.LoadingBar_goldZhu:getContentSize()
end

function GoldColumn:setVal(val)
	self.hide_time_add = 0
	self.add_val_time_add = 0
	self.bupdate_pos = true
	self.bhide_self  = false
	self.cur_val = val
	self.ui_lst.fnt_goldZhu:setString(string.format("%d",self.cur_val))
	if self.cur_val > self.max_val then self.cur_val = self.max_val end
	self.add_num_v = self.max_val/self.add_val_time

	local gold_unit_number = FishGoldManager.getInstance():getUnitGoldNumber()
	local mod = math.floor(self.cur_val/gold_unit_number) + 1
	self.cur_val = mod*gold_unit_number

	self.ui_lst.LoadingBar_goldZhu:setPercent(0)
	local cur_y = self.ui_lst.LoadingBar_goldZhu:getPercent()/100*self.bar_size.width

	self.ui_lst.fnt_goldZhu:setPositionY(cur_y)
	self.ui_lst.fnt_goldZhu:setVisible(false)

	self:resetGoldSpr()

	self:setVisible(true)
end

function GoldColumn:forceHide()
	self.ui_lst.SpriteGold1:setVisible(false)
	self:stopAllActions()
	self:setVisible(false)
	self.bupdate_pos = false
	self.bhide_self = true
end

function GoldColumn:isHide()
	return self.bhide_self
end

function GoldColumn:update(dt)
	if self.bupdate_pos == true then
		if self.add_val_time_add*self.add_num_v > self.cur_val then
			self.ui_lst.fnt_goldZhu:setVisible(true)
			self.bupdate_pos = false
			self.ui_lst.LoadingBar_goldZhu:setPercent((self.cur_val/self.max_val)*100)
			local cur_y = (self.cur_val/self.max_val)*self.bar_size.width + self.fnt_size.height/2 + 2
			self.ui_lst.fnt_goldZhu:setPositionY(cur_y)
			self.add_val_time_add = 0
			self.ui_lst.SpriteGold1:setVisible(false)
		else
			self.add_val_time_add = self.add_val_time_add + dt
			local val = self.add_val_time_add*self.add_num_v
			self.ui_lst.LoadingBar_goldZhu:setPercent((val/self.max_val)*100)

			local cur_y = (val/self.max_val)*self.bar_size.width + self.fnt_size.height/2 + 4
			self.ui_lst.SpriteGold1:setPositionY(cur_y)
		end
	end

	if self.bhide_self == false then
		if self.hide_time_add > self.hide_time then
			self:setVisible(false)
			self.ui_lst.fnt_goldZhu:setVisible(false)
			self.ui_lst.SpriteGold1:setVisible(false)
			self.ui_lst.SpriteGold1:stopAllActions()
			self.bhide_self = true
			if self.hide_call then
				self.hide_call(self)
			end
		else
			self.hide_time_add = self.hide_time_add + dt
		end
	end
end

function GoldColumn:resetGoldSpr()
	self.ui_lst.SpriteGold1:setVisible(true)
	local frame_name = string.format(sprite_ani_config[jc_system_config.gold_column_ani_src_id].pattern,1)
	self.ui_lst.SpriteGold1:setSpriteFrame(frame_name)

	local ani_key = sprite_ani_config[jc_system_config.gold_column_ani_src_id].key
	local animation = cc.AnimationCache:getInstance():getAnimation(ani_key)
	if animation then
		animation:retain()
		local animate = cc.Animate:create(animation)
		animation:release()
		self.ui_lst.SpriteGold1:runAction(cc.RepeatForever:create(animate) )
	end
end

function GoldColumn:createAnimation(cfg_item,bregorg)
	local animation = nil
	if cfg_item then
		local frames = display.newFrames(cfg_item.pattern,1,cfg_item.fs)
		animation = cc.Animation:createWithSpriteFrames(frames,cfg_item.ft)
		if bregorg == true then
			animation:setRestoreOriginalFrame(bregorg)
		end
	end

	return animation
end

