local function SubmitWeapon(btn)
	RunConsoleCommand("buyweapon", btn.WeaponSlot)
	pBuyMenu:Remove()
end

local function WeaponSelectThink(btn)
	if btn.Hovered and pBuyMenu.CurrentButton ~= btn then
		pBuyMenu.CurrentButton = btn
		local desc = btn.WepTab.Description
		if desc then
			if pBuyMenu.DescLabel then
				pBuyMenu.DescLabel:SetText(desc)
				surface.SetFont("cstrike16")
				local labw, labh = surface.GetTextSize(desc)
				pBuyMenu.DescLabel:SetSize(labw, labh)
			else
				local label = vgui.Create("DLabel", pBuyMenu)
				label:SetText(desc)
				label:SetTextColor(COLOR_TEXTYELLOW)
				label:SetFont("cstrike16")
				surface.SetFont("cstrike16")
				local labw, labh = surface.GetTextSize(desc)
				label:SetSize(labw, labh)
				label:SetPos(400, 500)
				label:SetMouseInputEnabled(false)
				label:SetKeyboardInputEnabled(false)
				pBuyMenu.DescLabel = label
				table.insert(pBuyMenu.Buttons, label)
			end
		end
	end
end

local function MakeWeapons(typ, panel)
	for _, p in pairs(panel.Buttons) do if p:Valid() then p:Remove() end end
	panel.Buttons = {}

	if typ == 0 then
		panel:SetTitle("PRIMARY WEAPONS")
	elseif typ == 1 then
		panel:SetTitle("SECONDARY WEAPONS")
	else
		panel:SetTitle("TERTIARY WEAPONS")
	end

	--[[local y = 90
	for i, weptab in ipairs(GAMEMODE.Buyables) do
		if weptab.Type == typ and (not weptab.Team or weptab.Team == MySelf:Team()) then
			local button = CSButton(panel, "  "..string.upper(weptab.Name).." - "..weptab.Cost.." Silver", SubmitWeapon, nil, WeaponSelectThink)
			button:SetPos(48, y)
			button.WepTab = weptab
			button.Weapon = weptab.Name
			button.WeaponSlot = weptab.Slot
			table.insert(panel.Buttons, button)
			y = y + 64
		end
	end

	y = y + 64
	CSButton(panel, "  CANCEL", MakepBuyMenu):SetPos(48, y)]]

	local pList = vgui.Create("DPanelList", panel)
	pList:SetPos(48, 90)
	pList:SetSize(350, panel:GetTall() - 218)
	pList:SetSpacing(16)
	pList:EnableVerticalScrollbar()
	table.insert(panel.Buttons, pList)

	for i, weptab in ipairs(GAMEMODE.Buyables) do
		if weptab.Type == typ and (not weptab.Team or weptab.Team == MySelf:Team()) then
			local button = CSButton(panel, "  "..string.upper(weptab.Name).." - "..math.ceil(MySelf:GetDiscount() * weptab.Cost).." Silver", SubmitWeapon, nil, WeaponSelectThink)
			button.WepTab = weptab
			button.Weapon = weptab.Name
			button.WeaponSlot = weptab.Slot

			local oldwide = button:GetWide()
			pList:AddItem(button)
			button:SetWide(oldwide)
		end
	end

	CSButton(panel, "  CANCEL", MakepBuyMenu):SetPos(48, panel:GetTall() - 112)
end

function MakepBuyMenu()
	if pBuyMenu then
		pBuyMenu:Remove()
		pBuyMenu = nil
	end

	local pw = 800
	local ph = 600

	local Window = vgui.Create("DFrame")
	Window.Buttons = {}
	Window:SetSize(pw, ph)
	Window:Center()
	Window:SetTitle("BUY")
	Window:SetVisible(true)
	Window:SetDraggable(false)
	Window:SetKeyboardInputEnabled(false)
	Window:MakePopup()
	Window.OldThink = Window.Think
	Window.Think = function(wind)
		if not CanBuy then wind:Remove() end
		wind:OldThink()
	end
	pBuyMenu = Window

	local button = CSButton(Window, "  PRIMARY WEAPONS", function(btn) MakeWeapons(0, Window) end)
	button:SetPos(48, 200)
	table.insert(Window.Buttons, button)

	local button = CSButton(Window, "  SECONDARY WEAPONS", function(btn) MakeWeapons(1, Window) end)
	button:SetPos(48, 264)
	table.insert(Window.Buttons, button)

	local button = CSButton(Window, "  TERTIARY WEAPONS", function(btn) MakeWeapons(2, Window) end)
	button:SetPos(48, 328)
	table.insert(Window.Buttons, button)

	local button = CSButton(Window, "  MAKING FAVORITES", function(btn)
		RunConsoleCommand("showconsole")
		print("How to use the console to make favorites:")
		print("Use the console command buyweapon # to buy a weapon. Example, buyweapon 3 will get a Crossfire.")
		print("Then you can bind a key to buy that weapon or even multiple ones. Example, bind \"f9\" \"buyweapon 3;buyweapon 18;buyweapon 17\"")
		print("Then when you press f9 you will buy a Crossfire, a Grapple Beam, and a Med-ray all at once.")
		print("Complete listing of all weapons and their ID's:")
		for i, weptab in pairs(GAMEMODE.Buyables) do
			print(weptab.Slot, weptab.Name)
		end
	end)
	button:SetPos(pw - button:GetWide() - 48, 456)
	table.insert(Window.Buttons, button)

	local button = CSButton(Window, "  CLOSE", function(btn) pBuyMenu:Remove() end)
	button:SetPos(48, 456)
	table.insert(Window.Buttons, button)
end
