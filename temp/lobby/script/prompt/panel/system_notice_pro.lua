#remark
--[[
	系统推送通知处理
]]

SystemNoticePro = {}


--[[
	msg = {
		text,
		type,
	}
]]
function SystemNoticePro.showScrollTextPro(msg) --跑马灯显示文字处理
	-- local info = {
	-- 	item_type = 1,
	-- 	item = {
	-- 		txt 		= msg.content,
	-- 		ft_size 	= 20,
	-- 		ft_color 	= cc.c3b(255,255,255),
	-- 		second 		= 5,
	-- 		repeat_time = 1,
	-- 		text_type 	= msg.type, 
	-- 		noticeid 	= msg.noticeid, 
	-- 	},
	-- }
	-- if text_color_config[msg.type] then
	-- 	info.item.ft_size  = text_color_config[msg.type].ft_size
	-- 	info.item.ft_color = text_color_config[msg.type].ft_color
	-- 	info.item.second   = text_color_config[msg.type].second
	-- end
	WindowScene.getInstance():instertScrollText(msg)
end





