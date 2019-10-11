--[[
彩金icon对象
]]

CFS_rewardLotteryBitmap = class("CFS_rewardLotteryBitmap",function()
	-- body
	local  ret = cc.Sprite:create()
	return ret
end)

function CFS_rewardLotteryBitmap.create()
	-- body
	local layer = CFS_rewardLotteryBitmap.new()
	if layer ~= nil then
		layer:init()
		return layer
	end
end
function CFS_rewardLotteryBitmap:init()
	self.slotMachineCon = CSlotMachineCon.create(CSlotMachineCon.NORMAL_ALL)
	self:addChild(self.slotMachineCon)
end
function CFS_rewardLotteryBitmap:initBitmapInfo(id)
	self.icon_resPath = "game/4s_std/resource/image/lottery/"..id..".png"
	self.id = id

	self:setTexture(self.icon_resPath)
	--self:getTexture():setAntiAliasTexParameters()
	self.slotMachineCon:setContentSize(self:getContentSize())
end
--播发滚动动作
function CFS_rewardLotteryBitmap:playRollAction()
	self.slotMachineCon:clearRewardList()
	self.slotMachineCon:setVisible(true)
	local arr = {}
	for i=0,9 do
		local reward = CFS_scrollItem.create()
		reward:initBitmapInfo(i)
		table.insert(arr, reward)
	end
	local rewardlist = CRewardList.create()
	local scrolldata = {}
	scrolldata.offset = -1
	scrolldata.state = CRewardList.ROLL_UP_DOWN
	scrolldata.dir = 1
	scrolldata.stopType = CRewardList.IMMEDIATELY_STOP

	rewardlist:initRewards(arr, scrolldata)
	rewardlist:setPosition(0,0)
	self.slotMachineCon:addRewardList( rewardlist )
	self.slotMachineCon:setRewardListSpeed( 1 , 110 , 110 , 0 )
	self.slotMachineCon:setAnchorPoint(0,0)
	self.slotMachineCon:setPosition(0,0)
	self.slotMachineCon:startRoll( 1 )

	EventUtils.addEventListener( self.slotMachineCon.ALLLISTSTOP, self, function ()
		self.slotMachineCon:setVisible(false)
	end, true )
end

