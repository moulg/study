
local panel_ui = require "game.shark_std.script.ui_create.ui_shark_tips"

CSharkTipsPanel = class("CSharkTipsPanel", function ()
	local ret = ccui.ImageView:create()
	--cc.LayerColor:create(cc.c4b(255,255,255,255),10,10)
	ret:setScale9Enabled(true)
    ret:loadTexture("lobby/resource/general/heidi.png")

    return ret
end)


function CSharkTipsPanel.create()
	-- body
	local layer = CSharkTipsPanel.new()
	if layer ~= nil then
		layer:init_ui()
		return layer
	end
end

function CSharkTipsPanel:onHide()
    if self._waitEffect then
        self._waitEffect:removeFromParent()
        self._waitEffect = nil
    end

	local scene = WindowScene.getInstance()
	scene:closeDlg(self)
end

function CSharkTipsPanel:init_ui()
	local size = WindowModule.get_window_size()
	self:setContentSize(cc.size(size.width, size.height))

	self.panel_ui = panel_ui.create()
	self:addChild(self.panel_ui.root)
	
	local size = self:getContentSize()
	self.panel_ui.root:setPosition(size.width/2, size.height/2)
	self:setAnchorPoint(0,0)
	self:setPosition(0,0)

	self:setTouchEnabled(true)
end

function CSharkTipsPanel:showMe( data )
	local scene = WindowScene.getInstance()
	scene:showDlg(self)
	local size = scene:getScaleSize()
	self.panel_ui.root:setScale(1/size.x, 1/size.y)

	if data then
		self.panel_ui.fntBankerScore:setString(data.banker)
		self.panel_ui.fntPlayerScore:setString(data.player)
		self.panel_ui.fntAnimalMutiply:setString(data.mutiply)
	else
		self.panel_ui.root:setVisible(false)

		local size = self:getContentSize()
		self._waitEffect =  animationUtils.createAndPlayAnimation(self, shark_effect_config["wait"])	
		self._waitEffect:setAnchorPoint(0.5,0.5)
		self._waitEffect:setPosition(size.width/2, size.height/2)
	end
end