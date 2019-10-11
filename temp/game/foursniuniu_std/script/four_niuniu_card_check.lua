--[[
牛牛 牌型 检测
]]
C4PNiuNiuCardCheck = {}

C4PNiuNiuCardCheck.CardsKinds = {
	MEI_NIU = 0, --没牛
	NIU_1 	= 1, --牛1
	NIU_2 	= 2, --牛2
	NIU_3 	= 3, --牛3
	NIU_4 	= 4, --牛4
	NIU_5 	= 5, --牛5
	NIU_6 	= 6, --牛6
	NIU_7 	= 7, --牛7
	NIU_8 	= 8, --牛8
	NIU_9 	= 9, --牛9
	NIU_NIU	= 10, --牛牛
	SI_HUA = 11, --四花
	SI_ZHA = 12, --四炸
	WU_HUA = 13, --五花
	WU_XIAO = 14, --五小
}


--检测出最大牛牛的点数
function C4PNiuNiuCardCheck.checkMaxNiuNiuPower(list)
	if checkIsWuXiao(list) then	--五小
		return C4PNiuNiuCardCheck.CardsKinds.WU_XIAO
	elseif checkIsWuHua(list) then --五花
		return C4PNiuNiuCardCheck.CardsKinds.WU_HUA
	elseif checkIsSiZha(list) then --四炸
		return C4PNiuNiuCardCheck.CardsKinds.SI_ZHA
	elseif checkIsSiHua(list) then --四花
		return C4PNiuNiuCardCheck.CardsKinds.SI_HUA
	else
		return C4PNiuNiuCardCheck.getNormalNiuNiuMaxPower(list)
	end
end

--五小
local function checkIsWuXiao(list)
	local totalPower = 0

	for k,id in pairs(list) do
		if four_niuniu_card_data[id].power >= 5 then
			return false
		end

		totalPower = totalPower + four_niuniu_card_data[id].power
	end

	if totalPower <= 10 then
		return true
	else
		return false
	end
end

--五花
local function checkIsWuHua(list)
	for k,id in pairs(list) do
		if four_niuniu_card_data[id].power < 11 or four_niuniu_card_data[id].power > 13 then  --小于J  大于k 
			return false
		end
	end
	
	return true
end

--4花
local function checkIsSiHua(list)
	local num = 0
	local haveTen = false
	for k,id in pairs(list) do
		if four_niuniu_card_data[id].power >= 11 or four_niuniu_card_data[id].power <= 13 then  --大于等于J  小于等于k 
			num = num + 1
		end

		if four_niuniu_card_data[id].power == 10 then
			haveTen = true
		end
	end
	
	if num == 4 and haveTen then
		return true
	else
		return false
	end
end

--4炸
local function checkIsSiZha(list)
	local tmp = {}
	for k,id in pairs(list) do
		if tmp[four_niuniu_card_data[id].power] then
			tmp[four_niuniu_card_data[id].power] = tmp[four_niuniu_card_data[id].power] + 1
		else
			tmp[four_niuniu_card_data[id].power] = 1
		end
	end
	
	if #tmp == 2 and (tmp[list[0]] == 1 or tmp[list[0]] == 4) then
		return true
	else
		return false
	end
end

--检测出普通牛牛的最大点数
local function getNormalNiuNiuMaxPower(list)
	local maxPower = 0	--牌型点数
	local totalPower = 0
	local kingNum = 0

	local tmpList = {}
	for i,v in ipairs(list) do
		totalPower = totalPower + four_niuniu_card_data[v].power

		if four_niuniu_card_data[v].four_niuniu_card_type == four_niuniu_card_type.XIAO_WANG or 
			four_niuniu_card_data[v].four_niuniu_card_type == four_niuniu_card_type.DA_WANG then
			kingNum = kingNum + 1
		else
			table.insert(tmpList, four_niuniu_card_data[v])
		end
	end

	if kingNum == 0 then --没有王
		for index1 = 1, 5 do
			for index2 = index1 + 1, 5 do
				for index3 = index2 + 1, 5 do
					--三张牌相加  是否是 10的倍数
					local power = tmpList[index1].power + tmpList[index2].power + tmpList[index3].power
					if power % 10 == 0 then
						power = (totalPower - power) % 10 --获得剩余点数
						if power > maxPower then
							maxPower = power
						end 
					end
				end
			end
		end
	elseif kingNum == 1 then --有一张王， 必是有牛  从剩余四张中选出两张加起来最大
		for index1 = 1, 4 do
			for index2 = index1 + 1, 4 do
				local power = tmpList[index1].power + tmpList[index2].power
				if power % 10 > maxPower then
					maxPower = power
				end
			end
		end
	elseif kingNum == 2 then --有两张王，必是牛牛
		maxPower = C4PNiuNiuCardCheck.CardsKinds.NIU_NIU
	end

	return maxPower
end


--计算底注  庄家筹码  自己的筹码
function C4PNiuNiuCardCheck.calute_bottomCash(bankerChips, myChips, playerTotalChips)
	local roominfo = get_player_info():get_cur_roomInfo()

	--默认最低
	local defaultMinCash = roominfo.minOne
	--默认最高`
	local defaultMaxCash = roominfo.maxOne
   	print(bankerChips, myChips)
	local tmp   = long_multiply(myChips, bankerChips)
	bankerChips = long_divide(tmp, playerTotalChips)

	local minChips = long_compare(bankerChips, myChips) > 0 and myChips or bankerChips

	local tmpNum1 = long_multiply(defaultMinCash, 16)
	local tmpNum2 = long_multiply(defaultMinCash, 24)
	local tmpNum3 = long_multiply(defaultMinCash, 32)
	local tmpNum4 = long_multiply(defaultMaxCash, 32)
	if long_compare(minChips, tmpNum1) == -1 then

		return {long_multiply(defaultMinCash,4), long_multiply(defaultMinCash,3), 
				long_multiply(defaultMinCash,2), long_multiply(defaultMinCash,1),
				false,false,false,true}

	elseif long_compare(minChips, tmpNum2) == -1 then

		return {long_multiply(defaultMinCash,4), long_multiply(defaultMinCash,3), 
				long_multiply(defaultMinCash,2), long_multiply(defaultMinCash,1),
		false,false,true,true}

	elseif long_compare(minChips, tmpNum3) == -1 then

		return {long_multiply(defaultMinCash,4), long_multiply(defaultMinCash,3), 
				long_multiply(defaultMinCash,2), long_multiply(defaultMinCash,1),
		false,true,true,true}

	elseif long_compare(minChips, tmpNum4) == -1 then
		local tmp1 = long_divide(minChips,8)
		local tmp2 = long_multiply(minChips,3)
		tmp2 = long_divide(tmp2,32)
		local tmp3 = long_divide(minChips,16)
		local tmp4 = long_divide(minChips,32)

		return {tmp1,tmp2,tmp3,tmp4,
		true,true,true,true}

	else

		return {long_multiply(defaultMaxCash,4),long_multiply(defaultMaxCash,3),
				long_multiply(defaultMaxCash,2),long_multiply(defaultMaxCash,1),
				true,true,true,true}

	end

end

--返回牌型排列  特殊牌型和无牛排列相同
function C4PNiuNiuCardCheck.getCardsTypeFormation( type )
	if type == C4PNiuNiuCardCheck.CardsKinds.MEI_NIU or type == C4PNiuNiuCardCheck.CardsKinds.SI_HUA or
	type == C4PNiuNiuCardCheck.CardsKinds.SI_ZHA or type == C4PNiuNiuCardCheck.CardsKinds.WU_HUA or
	type == C4PNiuNiuCardCheck.CardsKinds.WU_XIAO then

		return false
	else
		return true
	end
end


--检测是否是最优牌型
function C4PNiuNiuCardCheck.checkIsBestCardsType(list, selecedlist, bestCardsType)
	--特殊牌型和无牛  无需提示
	if C4PNiuNiuCardCheck.getCardsTypeFormation( bestCardsType ) == false then
		return true
	end

	local count = 0
	if #selecedlist == 0 then
		return true
	end

	for k,v in pairs(selecedlist) do
		count = count + 1
	end

	if count ~= 3 then
		return true
	end

	local power = 0
    local isHaveKind = false
	for k,v in pairs(list) do
		local isfind = false
		for id, card in pairs(selecedlist) do
			if card == v then 
				isfind = true
			end
		end

		if isfind == false then
			power = power + four_niuniu_card_data[v].mathpower
            if four_niuniu_card_data[v].mathpower == 0 then
                isHaveKind = true
            end
		end
	end

    if isHaveKind then
        power = C4PNiuNiuCardCheck.CardsKinds.NIU_NIU
    end

	if power % 10 == 0 then
		power = C4PNiuNiuCardCheck.CardsKinds.NIU_NIU
	else
		power = power % 10
	end

	if power ~= bestCardsType then
		return false
	end

	return true
end