function MakepHelp()
	if pHelp then
		pHelp:SetVisible(true)
		pHelp:MakePopup()
		return
	end

	local Window = vgui.Create("DFrame")
	local wide = 800
	local tall = 600
	Window:SetSize(wide, tall)
	Window:Center()
	Window:SetTitle(" ")
	Window:SetVisible(true)
	Window:SetDraggable(false)
	Window:SetKeyboardInputEnabled(false)
	Window:MakePopup()
	Window:SetDeleteOnClose(false)
	Window:SetCursor("pointer")
	pHelp = Window

	surface.SetFont("cstrike64")
	local texw, texh = surface.GetTextSize("Help")
	local label = vgui.Create("DLabel", Window)
	label:SetSize(texw, texh)
	label:SetTextColor(COLOR_RED)
	label:SetFont("cstrike64")
	label:SetText("Help")
	label:SetPos(wide * 0.5 - texw * 0.5, 2)
	label:SetMouseInputEnabled(false)

	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetPos(32, 32)
	check:SetSize(wide, 32)
	check:SetText("Display Controls on screen")
	check:SetConVar("awesomestrike_displaycontrols")

	local y = 72
	for i, line in ipairs({"In Awesome Strike, the objective is to either kill the other team or complete the objective.", "The objective in de_ maps is to plant / defuse the bomb. In cs_ maps it's to protect / rescue hostages.", "Any other map it's to just kill the other team.", "If you die, you can not respawn until the current round ends. Anything you say won't be heard by the living.", " ", "You can do a whole bunch of awesome moves (displayed on top of the screen) like wall jumping and dashing.", "All of the weapons have been made to be awesome!", "With that in mind, remember that all bullets are physical and take time to get to their target!", "You can hold three different weapons, each in a different slot - primary, secondary, and tertiary.", " ", "F1 - Help", "F2 - Change Team", "F3 - Buy", "F4 - Options", " ", "More and more is being added to this game so check http://www.noxiousnet.com for updates.", " ", "Game created by William \"JetBoom\" Moodhe (jetboom@yahoo.com)"}) do
		surface.SetFont("Default")
		local txtw, txth = surface.GetTextSize(line)

		local dlabel = vgui.Create("DLabel", Window)
		dlabel:SetSize(txtw, txth)
		dlabel:SetTextColor(COLOR_TEXTYELLOW)
		dlabel:SetFont("Default")
		dlabel:SetText(line)
		dlabel:SetPos(wide * 0.5 - txtw * 0.5, y)
		dlabel:SetMouseInputEnabled(false)

		y = y + txth
	end

	local button = vgui.Create("DButton", Window)
	button:SetPos(wide * 0.5 - 50, tall - 36)
	button:SetSize(100, 28)
	button:SetText("Close")
	button.DoClick = function(btn) btn:GetParent():SetVisible(false) end
end
