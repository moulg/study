#remark
--[[
	game lobby init
]]
print("init game lobby")

require "lobby.script.player.net_message.rec_parse_common"
require "lobby.script.player.net_message.rec_pro_common"
require "lobby.script.player.net_message.rec_parse_player"
require "lobby.script.player.net_message.rec_pro_player"
require "lobby.script.player.panel.player_info"
require "lobby.script.player.player_manager"

require "lobby.script.prompt.panel.scroll_hit_text"
require "lobby.script.prompt.panel.oneButtonPanel"
require "lobby.script.prompt.panel.twoButtonPanel"
require "lobby.script.prompt.panel.system_notice_pro"
require "lobby.script.prompt.panel.wait_message_hit"
require "lobby.script.prompt.panel.black_message_hit"
require "lobby.script.prompt.tips_manager"



require "lobby.script.login.net_message.send_login"
require "lobby.script.login.net_message.rec_parse_login"
require "lobby.script.login.net_message.rec_pro_login"
require "lobby.script.login.panel.login_scene"
require "lobby.script.login.panel.account_login"
require "lobby.script.login.panel.phone_login"
require "lobby.script.login.panel.heart_pro"
require "lobby.script.login.login_manager"

require "lobby.script.hall.panel.game_lobby"
require "lobby.script.hall.panel.account_upgrade"
require "lobby.script.hall.panel.leave_lobby_tips"
require "lobby.script.hall.panel.game_btn_item"
require "lobby.script.hall.panel.room_item"
require "lobby.script.hall.panel.gameType_item"
require "lobby.script.hall.panel.hall_set"
require "lobby.script.hall.panel.system_message"
require "lobby.script.hall.panel.send_horm"
require "lobby.script.hall.panel.game_rank"
require "lobby.script.hall.panel.game_rank_item"
require "lobby.script.hall.panel.game_help"
require "lobby.script.hall.net_message.rec_parse_plaza"
require "lobby.script.hall.net_message.rec_pro_plaza"
require "lobby.script.hall.net_message.send_plaza"
require "lobby.script.hall.net_message.rec_parse_gamehall"
require "lobby.script.hall.net_message.rec_pro_gamehall"
require "lobby.script.hall.net_message.send_gamehall"
require "lobby.script.hall.net_message.rec_parse_chat"
require "lobby.script.hall.net_message.rec_pro_chat"
require "lobby.script.hall.net_message.send_chat"
require "lobby.script.hall.net_message.rec_parse_notice"
require "lobby.script.hall.net_message.rec_pro_notice"
require "lobby.script.hall.net_message.send_notice"
require "lobby.script.hall.hall_manager"
require "lobby.script.hall.net_message.send_rank"
require "lobby.script.hall.net_message.rec_parse_rank"
require "lobby.script.hall.net_message.rec_pro_rank"

require "lobby.script.game_update.game_version_manager"
require "lobby.script.game_update.panel.game_update_ask"
require "lobby.script.game_update.panel.game_update_download"

require "lobby.script.personal.net_message.rec_parse_personalcenter"
require "lobby.script.personal.net_message.rec_pro_personalcenter"
require "lobby.script.personal.net_message.send_personalcenter"
require "lobby.script.personal.panel.personal_center_main"
require "lobby.script.personal.panel.phone_banding"
require "lobby.script.personal.panel.realName_request"
require "lobby.script.personal.personal_manager"


require "lobby.script.safe_box.panel.bank"
require "lobby.script.safe_box.panel.bank_rePassword"
require "lobby.script.safe_box.panel.bank_bangding"
require "lobby.script.safe_box.panel.bank_transfer_evidence"
require "lobby.script.safe_box.net_message.rec_parse_bank"
require "lobby.script.safe_box.net_message.rec_pro_bank"
require "lobby.script.safe_box.net_message.send_bank"

require "lobby.script.shop.net_message.rec_parse_shop"
require "lobby.script.shop.net_message.rec_pro_shop"
require "lobby.script.shop.net_message.send_shop"
require "lobby.script.shop.panel.shop_item"
require "lobby.script.shop.panel.shop_panel"
require "lobby.script.shop.shop_manager"

require "lobby.script.bag.net_message.rec_parse_backpack"
require "lobby.script.bag.net_message.rec_pro_backpack"
require "lobby.script.bag.net_message.send_backpack"
require "lobby.script.bag.back_pack_manager"

require "lobby.script.welfare.net_message.rec_parse_welfare"
require "lobby.script.welfare.net_message.rec_pro_welfare"
require "lobby.script.welfare.net_message.send_welfare"
require "lobby.script.welfare.welfare_manager"

require "lobby.script.chips_exchange.panel.exchange_panel"





