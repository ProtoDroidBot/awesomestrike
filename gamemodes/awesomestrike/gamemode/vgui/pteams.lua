local function SubmitModel(btn)
	RunConsoleCommand("changeteam", btn.TeamID, btn.MDL)
	pTeams:Remove()
end

local function SkinSelectThink(btn)
	if btn.Hovered and pTeams.CurrentButton ~= btn then
		pTeams.CurrentButton = btn
		local desc = GAMEMODE.SkinDescriptions[btn.Name]
		if desc then
			if pTeams.DescLabel then
				pTeams.DescLabel:SetText(desc)
				surface.SetFont("cstrike16")
				local labw, labh = surface.GetTextSize(desc)
				pTeams.DescLabel:SetSize(labw, labh)
			else
				local label = vgui.Create("DLabel", pTeams)
				label:SetText(desc)
				label:SetTextColor(COLOR_TEXTYELLOW)
				label:SetFont("cstrike16")
				surface.SetFont("cstrike16")
				local labw, labh = surface.GetTextSize(desc)
				label:SetSize(labw, labh)
				label:SetPos(400, 500)
				label:SetMouseInputEnabled(false)
				label:SetKeyboardInputEnabled(false)
				pTeams.DescLabel = label
				table.insert(pTeams.Buttons, label)
			end
		end
	end
end

local function PutTeamSkinsIn(panel, teamid)
	for _, p in pairs(panel.Buttons) do if p:Valid() then p:Remove() end end
	panel.Buttons = {}

	panel:SetTitle("SELECT CHARACTER")

	local y = 90
	for mdl, name in pairs(GAMEMODE.Skins[teamid]) do
		local button = CSButton(panel, "  "..string.upper(name), SubmitModel, nil, SkinSelectThink)
		button:SetPos(48, y)
		button.Name = name
		button.MDL = mdl
		button.TeamID = teamid
		table.insert(panel.Buttons, button)

		y = y + 64
	end

	y = y + 64

	local button = CSButton(panel, "  CANCEL", MakepTeams)
	button:SetPos(48, y)
	table.insert(panel.Buttons, button)
end

function MakepTeams()
	if pTeams then
		pTeams:Remove()
		pTeams = nil
	end

	local pw = 800
	local ph = 600

	local Window = vgui.Create("DFrame")
	Window.Buttons = {}
	Window:SetSize(pw, ph)
	Window:Center()
	Window:SetTitle("SELECT TEAM")
	Window:SetVisible(true)
	Window:SetDraggable(false)
	Window:SetKeyboardInputEnabled(false)
	Window:MakePopup()
	pTeams = Window

	local button = CSButton(Window, "  COUNTER-TERRORIST FORCES", function(btn) PutTeamSkinsIn(Window, TEAM_CT) end)
	button:SetPos(48, 200)
	table.insert(Window.Buttons, button)

	local button = CSButton(Window, "  TERRORIST FORCES", function(btn) PutTeamSkinsIn(Window, TEAM_T) end)
	button:SetPos(48, 264)
	table.insert(Window.Buttons, button)


	local button = CSButton(Window, "  AUTO-SELECT", function(btn)
		local numt = team.NumPlayers(TEAM_T)
		local numct = team.NumPlayers(TEAM_CT)
		if numt == numct then
			if math.random(1, 2) == 1 then
				PutTeamSkinsIn(Window, TEAM_CT)
			else
				PutTeamSkinsIn(Window, TEAM_T)
			end
		elseif numt < numct then
			PutTeamSkinsIn(Window, TEAM_T)
		else
			PutTeamSkinsIn(Window, TEAM_CT)
		end
	end)
	button:SetPos(48, 392)
	table.insert(Window.Buttons, button)

	local button = CSButton(Window, "  SPECTATE", function(btn) RunConsoleCommand("changeteam", TEAM_SPECTATOR) btn:GetParent():Remove() end)
	button:SetPos(48, 456)
	table.insert(Window.Buttons, button)
end
