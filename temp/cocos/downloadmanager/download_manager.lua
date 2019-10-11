
--[[
	文件下载服务
]]

require "cocos.downloadmanager.download_message_hit"

local file_format_keys = {"uncompress","compress","execute",".",}


local call_task_func_lst = {
	-- ["key"] = {
	-- 	on_err_call, --下载错误处理回调
	-- 	on_pro_call, --下载进度处理回调
	-- 	on_dlcmp_call,--下载完成回调
	-- 	on_ftcmp_call, --文件格式化完成回调
	-- 	on_tkcmp_call, --下载任务完成回调
	-- },
}



local function __dl_on_error(code,file,key,fdiscrib)
	print(string.format("err = %d,file = %s,key = %s",code,file,key))
	if call_task_func_lst[key] and call_task_func_lst[key].on_err_call then
		call_task_func_lst[key].on_err_call(download_err_msg_hit[code],file,key,code,fdiscrib)
	end
end

local function __dl_on_process(tts,dls,file,key,fdiscrib)
	print(string.format("tts = %d,dls = %d,file = %s,key = %s",tts,dls,file,key))
	if call_task_func_lst[key] and call_task_func_lst[key].on_pro_call then
		call_task_func_lst[key].on_pro_call(tts,dls,file,key,fdiscrib)
	end
end

local function __dl_on_dl_complete(file,key,fdiscrib)
	print(string.format("file = %s,key = %s",file,key))
	if call_task_func_lst[key] and call_task_func_lst[key].on_dlcmp_call then
		call_task_func_lst[key].on_dlcmp_call(file,key,fdiscrib)
	end
end

local function __dl_on_ft_complete(file,fmt,key,fdiscrib)
	print(string.format("file = %s,format = %s,key = %s",file,fmt,key))
	if call_task_func_lst[key] and call_task_func_lst[key].on_ftcmp_call then
		call_task_func_lst[key].on_ftcmp_call(file,fmt,key,fdiscrib)
	end
end

local function __dl_on_tk_complete(file,key,fdiscrib)
	print(string.format("file = %s,key = %s",file,key))
	if call_task_func_lst[key] and call_task_func_lst[key].on_tkcmp_call then
		call_task_func_lst[key].on_tkcmp_call(file,key,fdiscrib)
	end
end



DownloadManager = {}

function DownloadManager.init()
	print("**DownloadManager.init()")
	CDownLoad:getInstance():registerCallFunc(0,__dl_on_error)
	CDownLoad:getInstance():registerCallFunc(1,__dl_on_process)
	CDownLoad:getInstance():registerCallFunc(2,__dl_on_dl_complete)
	CDownLoad:getInstance():registerCallFunc(3,__dl_on_ft_complete)
	CDownLoad:getInstance():registerCallFunc(4,__dl_on_tk_complete)
end


--[[
	item = {
		key,任务回调key
	 	err_call,--下载错误处理回调
	 	pro_call,--下载进度处理回调
	 	dlcmp_call,--下载完成回调
	 	ftcmp_call,--文件格式化完成回调
	 	tkcmp_call,--下载任务完成回调
	}
]]
function DownloadManager.registerTaskCall(item)
	if item and item.key then
		call_task_func_lst[item.key] = {}
		call_task_func_lst[item.key].on_err_call = item.err_call
		call_task_func_lst[item.key].on_pro_call = item.pro_call
		call_task_func_lst[item.key].on_dlcmp_call = item.dlcmp_call
		call_task_func_lst[item.key].on_ftcmp_call = item.ftcmp_call
		call_task_func_lst[item.key].on_tkcmp_call = item.tkcmp_call

		return true
	end

	return false
end

function DownloadManager.unregisterTaskCall(key)
	if key then call_task_func_lst[key] = nil end
end

--提交下载任务
function DownloadManager.sumbitTask(url,fname,fstorage,ftype,fmt,key,file_discrib)
	print("**DownloadManager.sumbitTask")
	print("url="..url..",fname="..fname..",fsave="..fstorage..",ftype="..ftype..",fmt="..fmt..",key="..key..",fdiscrib="..file_discrib)
	CDownLoad:getInstance():sumbitTask(url,fname,fstorage,ftype,fmt,key,file_discrib)
	-- CDownLoad:getInstance():sumbitTask(url,fname,fstorage,ftype,fmt,key)
end

--中断当前下载任务
function DownloadManager.terminateCurTask()
	CDownLoad:getInstance():terminateCurrentTask()
end

--中断指定下载任务
function DownloadManager.terminateTask(key)
	if key then	CDownLoad:getInstance():terminateTask(key) end
end

--中断所有下载任务
function DownloadManager.terminateAll()
	CDownLoad:getInstance():terminateAllTask()
end

