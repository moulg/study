--[[
	动作创建器
]]

local __function_lst = {}
ActionCreater = {}

function ActionCreater.create(key,param)
	local func = __function_lst[key]
	if func ~= nil then
		return func(param)
	end

	return nil
end

--param = {t,pos}
local function __move_to(param)
	return cc.MoveTo:create(param.t,param.pos)
end

--param = {t,pos}
local function __move_by(param)
	return cc.MoveBy:create(param.t,param.pos)
end

--param ={t,sx,sy}
local function __scale_to(param)
	return cc.ScaleTo:create(param.t,param.sx,param.sy)
end

--param ={t,sx,sy}
local function __scale_by(param)
	return cc.ScaleBy:create(param.t,param.sx,param.sy)
end

--param ={t,angle}
local function __rotate_to(param)
	return cc.RotateTo:create(param.t,param.angle)
end

--param ={t,angle}
local function __rotate_by(param)
	return cc.RotateBy:create(param.t,param.angle)
end

--param ={t,sx,sy}
local function __skew_to(param)
	return cc.SkewTo:create(param.t,param.sx,param.sy)
end

--param ={t,sx,sy}
local function __skew_by(param)
	return cc.SkewBy:create(param.t,param.sx,param.sy)
end

--param = {t,pos,h,ts}
local function __jump_to(param)
	return cc.JumpTo:create(param.t,param.pos,param.h,param.ts)
end

--param ={t,pos,h,ts}
local function __jump_by(param)
	return cc.JumpBy:create(param.t,param.pos,param.h,param.ts)
end

--param ={t,ts}
local function __blink(param)
	return cc.Blink:create(param.t,param.ts)
end

--param ={t}
local function __fade_in(param)
	return cc.FadeIn:create(param.t)
end

--param ={t}
local function __fade_out(param)
	return cc.FadeOut:create(param.t)
end

--param={t,r,g,b}
local function __tint_to(param)
	return cc.TintTo:create(param.t,param.r,param.g,param.b)
end

--param={t,r,g,b}
local function __tint_by(param)
	return cc.TintBy:create(param.t,param.r,param.g,param.b)
end

--param={t}
local function __delay(param)
	return cc.DelayTime:create(param.t)
end

--param={t,dx,dy}
local function __shake(param)
	return cc.Shake:create(param.t,param.dx,param.dy)
end

--param={t,dx,dy}
local function __fallofshake(param)
	return cc.FallOffShake:createWithStrength(param.t,param.dx,param.dy)
end

--param = {t,pos = {x,y,},sl,angle,}
local function __circle(param)
	return cc.Circle:create(param.t,param.pos,param.sl,param.angle)
end

__function_lst["move_to"] 	= __move_to
__function_lst["move_by"] 	= __move_by
__function_lst["scale_to"] 	= __scale_to
__function_lst["scale_by"] 	= __scale_by
__function_lst["rotate_to"] = __rotate_to
__function_lst["rotate_by"] = __rotate_by
__function_lst["skew_to"] 	= __skew_to
__function_lst["skew_by"] 	= __skew_by
__function_lst["jump_to"] 	= __jump_to
__function_lst["jump_by"] 	= __jump_by
__function_lst["blink"] 	= __blink
__function_lst["fade_in"]	= __fade_in
__function_lst["fade_out"]	= __fade_out
__function_lst["tint_to"] 	= __tint_to
__function_lst["tint_by"]	= __tint_by
__function_lst["delay"] 	= __delay
__function_lst["shake"]		= __shake
__function_lst["ffshake"]	= __fallofshake
__function_lst["circle"]	= __circle