
--[[
	函数计算规则
]]

--抛物线[y = ax2 + bx + c]
local function __parabola(param)
	return param.a*math.pow(param.x,2) + param.b*param.x + param.c
end

--三次曲线[y = ax3]
local function __acubiccve(param)
	return param.a*math.pow(param.x,3)
end

--指数函数[y = a(x)]
local function __aexponential(param)
	return math.pow(param.a,param.x)
end

--对数函数[y = alog(x)]
local function __alogarithm(param)
	return param.a*math.log(param.x)
end

--正弦曲线[y = asin(x)]
local function __asin(param)
	return param.a*math.sin(param.b*param.x)
end

--余弦曲线[y = acos(x)]
local function __acos(param)
	return param.a*math.cos(param.b*param.x)
end

--圆[(x + a)2 + (y + b)2 = r2]
local function __circle(param)
	if param.way == 1 then
		return math.sqrt(math.pow(param.r,2) - math.pow(param.x + param.a,2)) - param.b
	else
		return -math.sqrt(math.pow(param.r,2) - math.pow(param.x + param.a,2)) - param.b
	end
end

--直线[y = kx]
local function __kline(param)
	return param.k*param.x
end

curve_rule_type = {
	pbl 	= 1,--抛物线[y = ax2 + bx + c]
	ccve 	= 2,--三次曲线[y = ax3]
	expt 	= 3,--指数函数[y = a(x)]
	logh	= 4,--对数函数[y = alog(x)]
	sin		= 5,--正弦曲线[y = asin(x)]
	cos		= 6,--余弦曲线[y = acos(x)]
	cicle 	= 7,--圆[(x + a)2 + (y + b)2 = r2]
	line 	= 8,--直线[y = kx]	
}

frule = {
	fun_lst = {
		[curve_rule_type.pbl] 	= __parabola,
		[curve_rule_type.ccve] 	= __acubiccve,
		[curve_rule_type.expt]	= __aexponential,
		[curve_rule_type.logh]	= __alogarithm,
		[curve_rule_type.sin]	= __asin,
		[curve_rule_type.cos]	= __acos,
		[curve_rule_type.cicle]	= __circle,
		[curve_rule_type.line]	= __kline,
	},
}


--[[
	param = {
		a,
		b,
		c,
		way,
		r,
		k,
		x,
	}
]]
function frule.getpos(idx,param)
	local pos = {x = 0,y = 0,}
	if idx and type(idx) == "number" then
		local fun = frule.fun_lst[idx]
		local y = fun(param)
		pos.x = param.x
		pos.y = y
	end

	return pos
end





