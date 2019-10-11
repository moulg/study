errentexas_card_check = {}

--找出最大牌型
function errentexas_card_check.findOutMaxPowerCards(list)
	local cards = errentexas_card_check.findOutRoyalFlush(list)
	if cards then
		return cards, "皇家同花顺"
	end

	local cards = errentexas_card_check.findOutFlush(list)
	if cards then
		return cards, "同花顺"
	end

	local cards = errentexas_card_check.findOutSiTiao(list)
	if cards then
		return cards, "四条"
	end

	local cards = errentexas_card_check.findOutHuLu(list)
	if cards then
		return cards, "葫芦"
	end

	local cards = errentexas_card_check.findOutSameFlowers(list)
	if cards then
		return cards, "同花"
	end

	local cards = errentexas_card_check.findOutShunZi(list)
	if cards then
		return cards, "顺子"
	end

	local cards = errentexas_card_check.findOutSanTiao(list)
	if cards then
		return cards, "三条"
	end

	local cards = errentexas_card_check.findOutLiangDui(list)
	if cards then
		return cards, "两对"
	end

	local cards = errentexas_card_check.findOutDanDui(list)
	if cards then
		return cards, "一对"
	end

	local cards = errentexas_card_check.findOutSingleCards(list)
	if cards then
		return cards, "单牌"
	end

	return nil
end



--是否是同花
local function checkIsSameFlowers(beginI, endI, tmpCards, powerList)
	local cards = {}
	for i=beginI,endI do
		for k,id in ipairs(tmpCards[powerList[i]]) do
			local cardType = errentexaspoker_card_data[id].type
			if cards[cardType] == nil then
				cards[cardType] = {}
			end

			table.insert(cards[cardType], id)
		end
	end

	for i,v in pairs(cards) do
		if #v == 5 then
			return v
		end
	end

	return nil
end

--找出皇家同花顺
function errentexas_card_check.findOutRoyalFlush(list)
	--[[
	tmpCards = {
		[power1] = {id1, id2,},
		[power2] = {id1, },
		}
	]]
	local tmpCards = {}
	local powerList = {}
	for i,v in ipairs(list) do
		local cardData = errentexaspoker_card_data[v]
		if tmpCards[cardData.power] == nil then
			tmpCards[cardData.power] = {}
			table.insert(powerList, cardData.power)
		end

		table.insert(tmpCards[cardData.power], v)
	end

	--小于5 没有顺子
	if #powerList < 5 then
		return nil
	end

	--是否有 A power = 14
	if tmpCards[14] == nil or tmpCards[13] == nil or tmpCards[12] == nil or tmpCards[11] == nil or tmpCards[10] == nil then 
		return nil
	end

    --排序
	table.sort( powerList )

	--7张牌  三次 if  就能判断是否有顺子
	if powerList[7] ~= nil and powerList[7] - powerList[3] == 4 then
		--判断是否是同花色  只要判断其中一种花色有五张
		return checkIsSameFlowers(3,7, tmpCards, powerList)
	elseif powerList[6] ~= nil and powerList[6] - powerList[2] == 4 then
		return checkIsSameFlowers(2,6, tmpCards, powerList)
	elseif powerList[5] ~= nil and powerList[5] - powerList[1] == 4 then
		return checkIsSameFlowers(1,5, tmpCards, powerList)
	else
		return nil
	end
end

--找出同花顺
function errentexas_card_check.findOutFlush(list)
	--[[
	tmpCards = {
		[type] = {id1, id2,},
		[type] = {id1, },
		}
	]]
	local tmpCards = {}
	for i,v in ipairs(list) do
		local cardData = errentexaspoker_card_data[v]
		if tmpCards[cardData.type] == nil then
			tmpCards[cardData.type] = {}
		end

		table.insert(tmpCards[cardData.type], v)
	end

	local function sortCards(id1, id2)
		if errentexaspoker_card_data[id1].power > errentexaspoker_card_data[id2].power then
			return true
		end

		return false
	end

	for k,cards in pairs(tmpCards) do
		if #cards >= 5 then
			--power从大到小排序 cards 同种花色的牌
			table.sort( cards, sortCards )

			--检测顺子
			return errentexas_card_check.findOutShunZi(cards)

		end
	end

    return nil
end

--找出顺子
function errentexas_card_check.findOutShunZi(list)
	--[[
	tmpCards = {
		[power1] = {id1, id2,},
		[power2] = {id1, },
		}
	]]
	local tmpCards = {}
	local powerList = {}
	for i,v in ipairs(list) do
		local cardData = errentexaspoker_card_data[v]
		if tmpCards[cardData.power] == nil then
			tmpCards[cardData.power] = {}
			table.insert(powerList, cardData.power)
		end

		table.insert(tmpCards[cardData.power], v)
	end

	--小于5 没有顺子
	if #powerList < 5 then
		return nil
	end

	--排序
	table.sort( powerList )

	local function getCards(beginI, endI)
		local cards = {}
		for i=beginI,endI do
			local idArr = tmpCards[powerList[i]]
			table.insert(cards, idArr[1])
		end

		return cards
	end


	--7张牌  三次 if  就能判断是否有顺子
	if powerList[7] ~= nil and powerList[7] - powerList[3] == 4 then
		return getCards(3, 7)
	elseif powerList[6] ~= nil and powerList[6] - powerList[2] == 4 then
		return getCards(2, 6)
	elseif powerList[5] ~= nil and powerList[5] - powerList[1] == 4 then
		return getCards(1, 5)
	else
		--有 A power = 14  增加一次  2 3 4 5 A的判断
	    if tmpCards[14] ~= nil then 
		    if powerList[4] ~= nil and powerList[4] - powerList[1] == 3 and powerList[1] == 2 then
				local tmpArr = getCards(1, 4)
                
                local idArr = tmpCards[powerList[#powerList]]
                table.insert(tmpArr, idArr[1])
                return tmpArr
		    else
			    return nil
		    end
	    end
	end

    return nil
end

--找出四条
function errentexas_card_check.findOutSiTiao( list )
	--[[
	tmpCards = {
		[power1] = {id1, id2,},
		[power2] = {id1, },
		}
	]]
	local tmpCards = {}
	local powerList = {}
	for i,v in ipairs(list) do
		local cardData = errentexaspoker_card_data[v]
		if tmpCards[cardData.power] == nil then
			tmpCards[cardData.power] = {}
			table.insert(powerList, cardData.power)
		end

		table.insert(tmpCards[cardData.power], v)
	end

	local function sortCards(p1, p2)
		if p1 > p2 then
			return true
		end

		return false
	end

	--排序
	table.sort( powerList, sortCards )

	local arr = nil
	for i,v in pairs(tmpCards) do
		if #v == 4 then
			arr = v
			break
		end
	end

	if arr == nil then
		return nil
	end

	for i,power in ipairs(powerList) do
		if tmpCards[power][1] ~= arr[1] then
			table.insert(arr, tmpCards[power][1])
			return arr
		end
	end

	return nil
end

--找出葫芦
function errentexas_card_check.findOutHuLu( list )
	--[[
	tmpCards = {
		[power1] = {id1, id2,},
		[power2] = {id1, },
		}
	]]
	local tmpCards = {}
	for i,v in ipairs(list) do
		local cardData = errentexaspoker_card_data[v]
		if tmpCards[cardData.power] == nil then
			tmpCards[cardData.power] = {}
		end

		table.insert(tmpCards[cardData.power], v)
	end

	local arr1 = nil
	local arr2 = nil

	for i,v in pairs(tmpCards) do
		if #v == 3 then
			if arr1 then --存在2对  选择最大的三条
				if errentexaspoker_card_data[arr1[1]].power < errentexaspoker_card_data[v[1]].power then
					arr1 =  v	
				end
			else
				arr1 =  v
			end
		end
	end

	if arr1 == nil then
		return nil
	end

	for i,v in pairs(tmpCards) do
		--两个三条  也可以凑出葫芦
		if #v == 3 or #v == 2 then
			--是否已经被三条选去
			if errentexaspoker_card_data[v[1]].power ~= errentexaspoker_card_data[arr1[1]].power then
				if arr2 then --存在2对  选择最大的一对
					if errentexaspoker_card_data[arr2[1]].power < errentexaspoker_card_data[v[1]].power then
						arr2 =  v	
					end
				else
					arr2 =  v
				end
			end
		end
	end

	if arr1 and arr2 then
		if #arr2 == 3 then
			local arr = table.copyOfRange(arr2, 1, 2)
			--合并数组
			table.insertto(arr1, arr, 0)
		else
			--合并数组
			table.insertto(arr1, arr2, 0)
		end

		return arr1
	end

	return nil
end

--找出同花
function errentexas_card_check.findOutSameFlowers(list)
	--[[
	tmpCards = {
		[type] = {id1, id2,},
		[type] = {id1, },
		}
	]]
	local tmpCards = {}
	for i,v in ipairs(list) do
		local cardData = errentexaspoker_card_data[v]
		if tmpCards[cardData.type] == nil then
			tmpCards[cardData.type] = {}
		end

		table.insert(tmpCards[cardData.type], v)
	end

	local function sortCards(id1, id2)
		if errentexaspoker_card_data[id1].power > errentexaspoker_card_data[id2].power then
			return true
		end

		return false
	end

	for k,cards in pairs(tmpCards) do
		if #cards >= 5 then
			--power从大到小排序
			table.sort( cards, sortCards )

			return table.copyOfRange(cards, 1, 5)
		end
	end

	return nil
end

--找出三条
function errentexas_card_check.findOutSanTiao( list )
	--[[
	tmpCards = {
		[power1] = {id1, id2,},
		[power2] = {id1, },
		}
	]]
	local tmpCards = {}
	local powerList = {}
	for i,v in ipairs(list) do
		local cardData = errentexaspoker_card_data[v]
		if tmpCards[cardData.power] == nil then
			tmpCards[cardData.power] = {}
			table.insert(powerList, cardData.power)
		end

		table.insert(tmpCards[cardData.power], v)
	end

	local function sortCardID(power1, power2)
		if power1 > power2 then
			return true
		end

		return false
	end

	--大到小排序
	table.sort( powerList, sortCardID )

	local arr1 = nil
	for k,v in pairs(tmpCards) do
		if #v == 3 then
			if arr1 then --存在2对  选择最大的三条
				if errentexaspoker_card_data[arr1[1]].power < errentexaspoker_card_data[v[1]].power then
					arr1 =  v	
				end
			else
				arr1 =  v
			end
		end
	end

	--凑两张最大的牌
	if arr1 then
		for i,power in ipairs(powerList) do
			if tmpCards[power][1] ~= arr1[1] then
				for k,id in ipairs(tmpCards[power]) do
					if #arr1 < 5 then
						table.insert(arr1,id)
					else
						return arr1
					end
				end
			end
		end
	else
		return nil
	end

end

--找两对
function errentexas_card_check.findOutLiangDui( list )
	--[[
	tmpCards = {
		[power1] = {id1, id2,},
		[power2] = {id1, },
		}
	]]
	local tmpCards = {}
	local powerList = {}
	for i,v in ipairs(list) do
		local cardData = errentexaspoker_card_data[v]
		if tmpCards[cardData.power] == nil then
			tmpCards[cardData.power] = {}
			table.insert(powerList, cardData.power)
		end

		table.insert(tmpCards[cardData.power], v)
	end

	local function sortCardID(power1, power2)
		if power1 > power2 then
			return true
		end

		return false
	end

	--大到小排序
	table.sort( powerList, sortCardID )

	local arr = {}
	for k,v in pairs(powerList) do
		if #tmpCards[v] == 2 and #arr < 4 then
			table.insertto(arr, tmpCards[v], 0)
		end
	end

    if #arr ~= 4 then
        return nil
    end

	--凑一张最大牌
	for i,power in ipairs(powerList) do
		if arr[1] ~= tmpCards[power][1] and arr[3] ~= tmpCards[power][1] then
			table.insert(arr, tmpCards[power][1])
			return arr
		end
	end

	return nil
end

--找一对
function errentexas_card_check.findOutDanDui( list )
	--[[
	tmpCards = {
		[power1] = {id1, id2,},
		[power2] = {id1, },
		}
	]]
	local tmpCards = {}
	local powerList = {}
	for i,v in ipairs(list) do
		local cardData = errentexaspoker_card_data[v]
		if tmpCards[cardData.power] == nil then
			tmpCards[cardData.power] = {}
			table.insert(powerList, cardData.power)
		end

		table.insert(tmpCards[cardData.power], v)
	end

	local function sortCardID(power1, power2)
		if power1 > power2 then
			return true
		end

		return false
	end

	--大到小排序
	table.sort( powerList, sortCardID )

	local arr = {}
	for k,v in pairs(powerList) do
		if #tmpCards[v] == 2 then
			table.insertto(arr, tmpCards[v])
            break
		end
	end

	if #arr ~= 2 then
		return nil
	end

	--凑3张最大牌
	for i,power in ipairs(powerList) do
		if tmpCards[power][1] ~= arr[1] then
			for k,id in ipairs(tmpCards[power]) do
				if #arr < 5 then
					table.insert(arr,id)
				else
					return arr
				end
			end
		end
	end

	return arr
end

--找出最大5单牌
function errentexas_card_check.findOutSingleCards(list)
		--[[
	tmpCards = {
		[power1] = {id1, id2,},
		[power2] = {id1, },
		}
	]]
	local tmpCards = {}
	local powerList = {}
	for i,v in ipairs(list) do
		local cardData = errentexaspoker_card_data[v]
		if tmpCards[cardData.power] == nil then
			tmpCards[cardData.power] = {}
			table.insert(powerList, cardData.power)
		end

		table.insert(tmpCards[cardData.power], v)
	end

	local function sortCardID(power1, power2)
		if power1 > power2 then
			return true
		end

		return false
	end

	--大到小排序
	table.sort( powerList, sortCardID )
	local arr = {}
	for k,v in pairs(powerList) do
		if #arr < 5 and #tmpCards[v] == 1 then
			table.insertto(arr, tmpCards[v])
		end
	end

	return arr
end