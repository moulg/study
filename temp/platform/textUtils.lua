#remark
textUtils = {}

--秒 转化  00:00:00
function textUtils.timeToSecondStr( time )
    local timeStr = ""
    local hours = math.floor(time / 60 / 60)
    if hours == 0 then
        timeStr = "00:"
    elseif hours <= 9 then
        timeStr = timeStr.."0"..hours..":"
    else
        timeStr = timeStr..hours..":"
    end
    time = time - hours * 60 * 60

    local minute = math.floor(time / 60)
    if minute == 0 then
        timeStr = timeStr.."00:"
    elseif minute <= 9 then
        timeStr = timeStr.."0"..minute..":"
    else
        timeStr = timeStr..minute..":"
    end

    local second = time - minute * 60

    if second == 0 then
        timeStr = timeStr.."00"
    elseif second <= 9 then
        timeStr = timeStr.."0"..second
    else
        timeStr = timeStr..second
    end

    return timeStr
end

--[[

2016/3/17 15:37:20
]]
function textUtils.unixTimeToFormat( unix , isyears, ismonth, isdate, ishour, isminute, issecond)
    local years = os.date("%Y", unix)
    local month = os.date("%m", unix)
    local date = os.date("%d", unix)
    local hour = os.date("%H", unix)
    local minute = os.date("%M", unix)
    local second = os.date("%S", unix)

    local timeStr = ""
    if isyears then
        timeStr = timeStr..years
    end

    if ismonth then
        timeStr = timeStr.."/"..month
    end

    if isdate then
        timeStr = timeStr.."/"..date
    end

    if ishour then
        timeStr = timeStr.." "..hour
    end

    if isminute then
        timeStr = timeStr..":"..minute
    end

    if issecond then
        timeStr = timeStr..":"..second
    end

    return timeStr
end

--替换textfield 数据
function textUtils.connectTextFieldText(textObj, repArr)
	textObj:setString(textUtils.connectParam(textObj:getString(), repArr))
end

--替换字符串
function textUtils.connectParam(str, repArr)
	if str then
		if repArr then
			for i,v in pairs(repArr) do
				str = string.gsub(str, "{"..i.."}", v)	
			end
		end
		
		return str
	end
end

function textUtils.getTextPixelSize(text,ft_size,ft_name)
    return cc.Label:createWithSystemFont(text,ft_name,ft_size):getContentSize()
end


--字符串按位分割函数,传入字符串，返回分割后的table，必须为字母、数字，否则返回nil
function gsplit(str)
    str = tostring(str)
    if str == nil then
        return nil
    end

    local str_tb = {}
    if string.len(str) ~= 0 then
        for i=1,string.len(str) do
            new_str= string.sub(str,i,i)            
            if (string.byte(new_str) >=48 and string.byte(new_str) <=57) or (string.byte(new_str)>=65 and string.byte(new_str)<=90) or (string.byte(new_str)>=97 and string.byte(new_str)<=122) then                
                table.insert( str_tb, tonumber(string.sub(str,i,i)) )                
            else
                return nil
            end
        end
        return str_tb
    else
        return nil
    end
end

--替换从index字节后的字符串
function textUtils.replaceStr( str, index, param )
    local len = 0
    if str == nil then
        return ""
    end
	local charArr = get_char(str)
    local tmp = ""

    for i, ch in ipairs(charArr) do
        if string.len(ch) > 1 then
            len = len + 2
        else
            len = len + 1
        end
        if len > index then
            tmp = tmp..param
            break
        else
            tmp = tmp..ch
        end

    end
    
	return tmp
end

--long 型 计算  加法
function long_plus(a, b)
	-- body
	return CLong:plus(tostring(a), tostring(b))
end

--long 型 计算  减法
function long_minus(a, b)
    -- body
    return CLong:minus(tostring(a), tostring(b))
end

--long 型 计算  乘法
function long_multiply(a, b)
	-- body
	return CLong:multiply(tostring(a), tostring(b))
end

--long 型 计算  除法
function long_divide(a, b)
	-- body
	return CLong:divide(tostring(a), tostring(b))
end

--long 型 计算  次方
function long_power(a, b)
	-- body
	return CLong:power(tostring(a), tonumber(b))
end

--long 型 计算  比较 0 相等  1 大于  -1  小于
function long_compare(a, b)
	-- body
	return CLong:compare(tostring(a), tostring(b))
end

--long 型 计算  求余
function long_mod(a, b)
    -- body
    return CLong:mod(tostring(a), tostring(b))
end


-- 愤怒、悲伤、受伤、杀害，你背负着痛苦之火。

-- 痛苦吗？和你内心的野兽战斗，然后成为人吧。

-- 确实每个人的心中都有一只野兽，但是却和一般的野兽不同——心。人有心，人越偏向野兽越痛苦，你刚才说你很痛苦，那正是你身为人的证明。

-- 谁都会有偏离人道暴露出野兽本性的时候，所以才要和心中的野兽进行战斗。不要恨别人，要恨就恨你自己，恨你自己心中的那头野兽。
