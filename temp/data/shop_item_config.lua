
if get_xue_Version() == 1 then
    shop_item_config = {
        --[11] = {id = 11, name = "10元宝", price = 10, currency = 1, give = 0, type = 1, desc = "", },
        --[12] = {id = 12, name = "20元宝", price = 20, currency = 1, give = 0, type = 1, desc = "", },
        --[13] = {id = 13, name = "50元宝", price = 50, currency = 1, give = 0, type = 1, desc = "", },
        --[14] = {id = 14, name = "100元宝", price = 100, currency = 1, give = 0, type = 1, desc = "", },
        --[15] = {id = 15, name = "500元宝", price = 500, currency = 1, give = 0, type = 1, desc = "", },
        [101] = {id = 101, name = "1金币", price = 1, currency = 2, give = 1, type = 2, desc = "鸡蛋，积分减少1", },
        [102] = {id = 102, name = "10金币", price = 10, currency = 2, give = 10, type = 2, desc = "板砖，积分减少10", },
        [109] = {id = 109, name = "20金币", price = 20, currency = 2, give = 20, type = 2, desc = "香烟，积分增加20", },
        [110] = {id = 110, name = "50金币", price = 50, currency = 2, give = 50, type = 2, desc = "香吻，积分增加50", },
        --[151] = {id = 151, name = "大喇叭", price = 10, currency = 2, give = 0, type = 3, desc = "大喇叭，可向全服玩家发送聊天信息", },
     }
else
    shop_item_config = {
        --[11] = {id = 11, name = "10元宝", price = 10, currency = 1, give = 0, type = 1, desc = "", },
        --[12] = {id = 12, name = "20元宝", price = 20, currency = 1, give = 0, type = 1, desc = "", },
        --[13] = {id = 13, name = "50元宝", price = 50, currency = 1, give = 0, type = 1, desc = "", },
        --[14] = {id = 14, name = "100元宝", price = 100, currency = 1, give = 0, type = 1, desc = "", },
        --[15] = {id = 15, name = "500元宝", price = 500, currency = 1, give = 0, type = 1, desc = "", },
        [101] = {id = 101, name = "1000金币", price = 1, currency = 2, give = 1, type = 2, desc = "鸡蛋，积分减少1", },
        [102] = {id = 102, name = "10000金币", price = 10, currency = 2, give = 10, type = 2, desc = "板砖，积分减少10", },
        [109] = {id = 109, name = "20000金币", price = 20, currency = 2, give = 20, type = 2, desc = "香烟，积分增加20", },
        [110] = {id = 110, name = "50000金币", price = 50, currency = 2, give = 50, type = 2, desc = "香吻，积分增加50", },
        --[151] = {id = 151, name = "大喇叭", price = 10, currency = 2, give = 0, type = 3, desc = "大喇叭，可向全服玩家发送聊天信息", },
     }
end

shop_goods_config = {
   size = 0,
   items = {}
}