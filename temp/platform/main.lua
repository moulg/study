--  function babe_tostring(...) 
--      local num = select("#",...); 
--         local args = {...}; 
--         local outs = {}; 
--         for i = 1, num do 
--              if i > 1 then 
--                  outs[#outs+1] = "\t"; 
--              end 
--              outs[#outs+1] = tostring(args[i]); 
--         end 
--         return table.concat(outs); 
--   end 

--   local babe_print = print; 

--   local babe_output = function(...) 
--      babe_print(...); 
--      if decoda_output ~= nil then 
--          local str = babe_tostring(...);
--           decoda_output(str); 
--      end 
--    end 
--    print = babe_output;
cc.FileUtils:getInstance():setPopupNotify(false)

--版本流程控制，0对外发布，1开发
local inner = 1
function is_inner_ver()
	if inner == 1 then return true end
	return false
end

--1.1比1版本 2.金币版本
local xueVersion = 1
function get_xue_Version()
	return xueVersion
end

--平台代码: 1为android, 2为ios, 3为windows
local platform_code = 1
function get_platform_code() return platform_code end


require "cocos.__init_cocos"
require "update.__init_update"
--CGamePackge:getInstance():LoadPackge("update.pkg",".wav|.mp3|.gif")

--增加文件系统搜索目录
local writable_path = cc.FileUtils:getInstance():getWritablePath()
cc.FileUtils:getInstance():addSearchPath(writable_path, ture)
cc.FileUtils:getInstance():addSearchPath("src", ture)
print("**Add writable path to search path:"..writable_path)
local temp = cc.FileUtils:getInstance():getSearchPaths()
--[[
	*****************
]]

print("**main()");

local function main() __game_main() end
local status, msg = xpcall(main,__G__TRACKBACK__)
if not status then 
	print(msg) 
end
