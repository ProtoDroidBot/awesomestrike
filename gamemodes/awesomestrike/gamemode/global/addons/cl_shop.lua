if SERVER then
	AddCSLuaFile(NDB_ADDON_NAME)
	return
end

local ShopCategoryIcons = {[CAT_HAT] = "gui/silkicons/emoticon_smile", [CAT_BODY] = "gui/silkicons/user", [CAT_BLOODDYE] = "gui/silkicons/palette", [CAT_ACCESSORY] = "gui/silkicons/plugin", [CAT_TITLE] = "gui/silkicons/sound"}

for nam, tab in pairs(NDB.ShopItems) do
	if tab.Category == CAT_TITLE and not tab.Model then
		tab.Model = "models/extras/info_speech.mdl"
	end
end

local function ItemConfirmPaint(p)
	draw.RoundedBox(8, 4, 4, p:GetWide() - 8, p:GetTall() - 8, color_black)
	draw.RoundedBox(8, 0, 0, p:GetWide(), p:GetTall(), color_black)

	surface.SetFont("Default")
	local texw, texh = surface.GetTextSize("ABCabc")
	surface.SetDrawColor(50, 50, 50, 255)
	surface.DrawRect(4, 28, p:GetWide() - 8, texh + 8)

	return true
end

local function BuyButtonConfirm(self)
	local itemname = self.Item
	local itemtab = NDB.ShopItems[itemname]
	local money = itemtab.Money
	local modelname = itemtab.Model
	local paint = itemtab.Paint
	local discount = self.Discount

	local df = vgui.Create("DFrame")
	df:SetSize(325, 200)
	df:Center()
	if money and money > 0 then
		df:SetTitle("Confirm Purchase - "..itemname.." (".. string.CommaSeparate(discount * money) .." Silver)")
	else
		df:SetTitle("Confirm Purchase - "..itemname)
	end
	df:SetVisible(true)
	df:MakePopup()
	df.Paint = ItemConfirmPaint

	if paint then
		local sb = vgui.Create("Panel", df)
		sb:SetVisible(true)
		sb:SetPos(130.5, 72)
		sb:SetSize(64, 64)
		sb.Paint = paint
	elseif modelname then
		local sb = vgui.Create("SpawnIcon", df)
		sb:SetPos(130.5, 72)
		sb:SetModel(modelname)
	end

	local dl = EasyLabel(df, "Are you sure you want to buy the "..itemname.."?")
	dl:SetPos(162.5 - dl:GetWide() * 0.5, 32)
	local dbutton = EasyButton(df, "OK")
	dbutton:SetPos(138.5, 150)
	dbutton:SetSize(48, 28)
	dbutton.Item = itemname
	dbutton.DoClick = function(btn)
		RunConsoleCommand("buyshopitem", btn.Item)
		surface.PlaySound("buttons/button15.wav")
		timer.Simple(0.4, RefreshNNShopPanel, self:GetParent(), itemname, NDB.ShopItems[itemname])
		btn:GetParent():Remove()
	end
end

local function UseButton(self)
	RunConsoleCommand("useitem", self.Item)
	surface.PlaySound("buttons/button15.wav")
end

function RefreshNNShopPanel(itempanel, itemname, itemtab, itempanelwidth)
	if not itempanelwidth then itempanelwidth = itempanel:GetWide() end
	if itempanel.Children then
		for _, pan in pairs(itempanel.Children) do pan:Remove() end
	end
	itempanel.Children = {}

	local hasitem = itemtab.CanUseCallback or NDB.PlayerHasShopItem(MySelf, itemname)

	local name
	if hasitem then
		name = EasyLabel(itempanel, itemname, "DefaultBold", COLOR_LIMEGREEN)
	else
		name = EasyLabel(itempanel, itemname, "DefaultBold", color_white)
	end
	local y = 4
	name:SetPos(72, y)
	y = y + name:GetTall() + 1
	itempanel.Children[#itempanel.Children + 1] = name

	if itemtab.Description then
		local desc = EasyLabel(itempanel, itemtab.Description, nil, color_white)
		desc:SetPos(72, y)
		itempanel.Children[#itempanel.Children + 1] = desc
		y = y + desc:GetTall() + 1
	end

	if itemtab.SpecialRequire and itemtab.SpecialRequire ~= "None" then
		local label = EasyLabel(itempanel, itemtab.SpecialRequire, "DefaultSmall", COLOR_YELLOW)
		label:SetPos(72, y)
		y = y + label:GetTall() + 1
	end

	if itemtab.Money and itemtab.Money > 0 then
		local discount = MySelf:GetDiscount()
		local discountpercent
		if discount ~= 1 then
			discountpercent = (1 - discount) * 100
		end

		local label
		if discountpercent then
			label = EasyLabel(itempanel, "Costs "..string.CommaSeparate(math.ceil(itemtab.Money * discount)) .." Silver ("..discountpercent.."% membership discount).", nil, COLOR_YELLOW)
		else
			label = EasyLabel(itempanel, "Costs "..string.CommaSeparate(itemtab.Money).." Silver.", nil, COLOR_YELLOW)
		end
		label:SetPos(72, y)
		y = y + label:GetTall() + 1
	end

	if itemtab.Awards then
		local label
		if #itemtab.Awards == 1 then
			label = EasyLabel(itempanel, "Award requirement: "..itemtab.Awards[1]..".", nil, color_white)
		else
			label = EasyLabel(itempanel, "Award requirements: "..table.concat(itemtab.Awards, ", ")..".", "DefaultSmall", color_white)
		end
		label:SetPos(72, y)
		y = y + label:GetWide() + 1
	end

	local req = {}
	if itemtab.GoldMember then
		req[#req + 1] = "Gold Member"
	end
	if itemtab.DiamondMember then
		req[#req + 1] = "Diamond Member"
	end
	if itemtab.NormalOnly then
		req[#req + 1] = "Non-Gold and Non-Diamond members only"
	end
	if itemtab.TeamPlayWinLossRatio then
		req[#req + 1] = (itemtab.TeamPlayWinLossRatio * 100).."% TeamPlay winning rate"
	end
	if itemtab.CTFKills then
		req[#req + 1] = itemtab.CTFKills.." TeamPlay kills"
	end
	if itemtab.CTFDeaths then
		req[#req + 1] = itemtab.CTFKills.." TeamPlay deaths"
	end
	if itemtab.CTFCaptures then
		req[#req + 1] = itemtab.CTFCaptures.." TeamPlay CTF captures"
	end
	if itemtab.TeamPlayOffense then
		req[#req + 1] = itemtab.TeamPlayOffense.." TeamPlay offensive rating"
	end
	if itemtab.TeamPlayDefense then
		req[#req + 1] = itemtab.TeamPlayOffense.." TeamPlay defensive rating"
	end
	if itemtab.TeamPlayOffenseDefenseRatio then
		req[#req + 1] = (itemtab.TeamPlayOffenseDefenseRatio * 100).."% offense-over-defense ratio"
	end
	if itemtab.TeamPlayDefenseOffenseRatio then
		req[#req + 1] = (itemtab.TeamPlayDefenseOffenseRatio * 100).."% defense-over-offense ratio"
	end
	if itemtab.ArenaWins then
		req[#req + 1] = itemtab.ArenaWins.." Arena victories"
	end
	if itemtab.ArenaLosses then
		req[#req + 1] = itemtab.ArenaWins.." Arena losses"
	end
	if itemtab.ArenaWinLossRatio then
		req[#req + 1] = (itemtab.ArenaWinLossRatio * 100).."% Arena winning rate"
	end
	if itemtab.ZSZombiesKilled then
		req[#req + 1] = itemtab.ZSZombiesKilled.." ZS zombies killed"
	end
	if itemtab.ZSBrainseaten then
		req[#req + 1] = itemtab.ZSBrainsEaten.." ZS brains eaten"
	end
	if itemtab.ZSZombiesKilledZSBrainsEatenRatio then
		req[#req + 1] = (itemtab.ZSZombiesKilledZSBrainsEatenRatio * 100).."% ZS zombies killed over brains eaten ratio"
	end
	if itemtab.ZSBrainsEatenZSZombiesKilledRatio then
		req[#req + 1] = (itemtab.ZSBrainsEatenZSZombiesKilledRatio * 100).."% ZS brains eaten over zombies killed ratio"
	end
	if itemtab.MarioWins then
		req[#req + 1] = itemtab.MarioWins.." Mario Boxes 2D victories"
	end
	if itemtab.MarioLosses then
		req[#req + 1] = itemtab.MarioLosses.." Mario Boxes 2D losses"
	end
	if itemtab.MarioKills then
		req[#req + 1] = itemtab.MarioKills.." Mario Boxes 2D kills"
	end
	if itemtab.MarioDeaths then
		req[#req + 1] = itemtab.MarioDeaths.." Mario Boxes 2D deaths"
	end

	if 0 < #req then
		local label = EasyLabel(itempanel, "Other requirements: "..table.concat(req, ", ")..".", "DefaultSmall", color_white)
		label:SetPos(72, y)
		y = y + label:GetTall() + 1
	end

	if hasitem and not itemtab.CanUseCallback then
		local img = vgui.Create("DImage", itempanel)
		img:SetImage("gui/silkicons/star")
		img:SizeToContents()
		img:SetMouseInputEnabled(true)
		img:SetTooltip("You have purchased this item!")
		img:SetPos(itempanelwidth - img:GetWide() - 8, 64 - img:GetTall())
		itempanel.Children[#itempanel.Children + 1] = img
	end

	if itemtab.Paint then
		local mdlpanel = vgui.Create("Panel", itempanel)
		mdlpanel:SetPos(4, 4)
		mdlpanel:SetModel(itemtab.Model)
		mdlpanel:SetSize(64, 64)
		mdlpanel:SetMouseInputEnabled(false)
		mdlpanel.Paint = itemtab.Paint
		itempanel.Children[#itempanel.Children + 1] = mdlpanel
	elseif itemtab.Model then
		local mdlpanel = vgui.Create("SpawnIcon", itempanel)
		mdlpanel:SetPos(4, 4)
		mdlpanel:SetModel(itemtab.Model)
		mdlpanel:SetSize(64, 64)
		mdlpanel:SetMouseInputEnabled(false)
		itempanel.Children[#itempanel.Children + 1] = mdlpanel
	end

	if hasitem then
		if not NDB.ShopItems[itemname].NoUse then
			local button = EasyButton(itempanel, "Use")
			button:SetSize(48, 26)
			button:SetPos(itempanelwidth - button:GetWide() - 8, 4)
			button.Item = itemname
			button.DoClick = UseButton
			itempanel.Children[#itempanel.Children + 1] = button
		end
	else
		local discount = MySelf:GetDiscount()
		local discountpercent
		if discount ~= 1 then
			discountpercent = (1 - discount) * 100
		end

		if not itemtab.SpecialRequire then
			local button = vgui.Create("DButton", itempanel)
			button:SetSize(48, 26)
			button:SetPos(itempanelwidth - button:GetWide() - 8, 4)
			button.Item = itemname
			--[[button.Money = itemtab.Money
			button.Model = itemtab.Model
			button.ItemTab = itemtab]]
			button.Discount = discount
			button:SetText("Buy")
			button.DoClick = BuyButtonConfirm
			itempanel.Children[#itempanel.Children + 1] = button
		end
	end
end

function MakepNNShop(category)
	if pNNShop and pNNShop:Valid() then
		pNNShop:Remove()
		pNNShop = nil
	end

	local wide, tall = math.min(w, 680), math.min(h, 580)

	local Window = vgui.Create("DFrame")
	Window:SetSize(wide, tall)
	Window:Center()
	Window:SetTitle("NoXiousNet Global Store")
	Window:SetDeleteOnClose(true)
	Window:SetVisible(true)
	Window:MakePopup()
	Window.PanelFor = {}
	pNNShop = Window

	local propertysheet = vgui.Create("DPropertySheet", Window)
	propertysheet:StretchToParent(4, 24, 4, 4)

	local catpanelwid, catpanelhei = propertysheet:GetWide() - 8, propertysheet:GetTall() - 32

	for catid, catname in pairs(NDB.ShopCategories) do
		local catpanel = vgui.Create("DPanel")
		catpanel:SetSize(catpanelwid, catpanelhei)

		local list = vgui.Create("DPanelList", catpanel)
		list:EnableVerticalScrollbar()
		list:EnableHorizontal(false)
		list:SetSpacing(2)
		list:SetPos(8, 32)
		list:StretchToParent(2, 2, 2, 2)
		local itempanelwidth = list:GetWide() - 16

		for itemname, itemtab in pairs(NDB.ShopItems) do
			if itemtab.Category == catid and (not itemtab.Hidden or NDB.PlayerHasShopItem(MySelf, itemname)) then
				local itempanel = vgui.Create("DPanel", list)
				itempanel:SetTall(72)
				list:AddItem(itempanel)
				Window.PanelFor[itemname] = itempanel

				RefreshNNShopPanel(itempanel, itemname, itemtab, itempanelwidth)
			end
		end

		propertysheet:AddSheet(catname, catpanel, ShopCategoryIcons[catid], false, false)
	end
end
concommand.Add("shopmenu", MakepNNShop)
