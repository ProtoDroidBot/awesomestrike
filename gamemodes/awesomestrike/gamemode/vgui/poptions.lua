function MakepOptions()
	if pOptions then
		pOptions:SetVisible(true)
		pOptions:MakePopup()
		return
	end

	local Window = vgui.Create("DFrame")
	local truewide = 800
	local truetall = 600
	Window:SetSize(truewide, truetall)
	local wide = (w - truewide) * 0.5
	local tall = (h - truetall) * 0.5
	Window:SetPos(wide, tall)
	Window:SetTitle(" ")
	Window:SetVisible(true)
	Window:SetDraggable(false)
	Window:SetKeyboardInputEnabled(false)
	Window:MakePopup()
	Window:SetDeleteOnClose(false)
	Window:SetCursor("pointer")
	pOptions = Window

	surface.SetFont("noxnetnormal")
	local texw, texh = surface.GetTextSize("Options")
	local label = vgui.Create("DLabel", Window)
	label:SetSize(texw, texh)
	label:SetTextColor(COLOR_RED)
	label:SetFont("noxnetnormal")
	label:SetText("Options")
	label:SetPos(truewide * 0.5 - texw * 0.5, 2)
	label:SetMouseInputEnabled(false)
	surface.SetFont("noxnetnormal")
	local texw, texh = surface.GetTextSize("F1: Help")
	label:SetSize(texw, texh)

	surface.SetFont("Default")
	local ___, defh = surface.GetTextSize("|")

	local slider = vgui.Create("DNumSlider", Window)
	slider:SetPos(64, 40)
	slider:SetSize(200, 48)
	slider:SetDecimals(0)
	slider:SetMinMax(0, 1600)
	slider:SetConVar("cl_detaildist")
	slider:SetText("Grass draw distance (FPS eater)")

	local slider = vgui.Create("DNumSlider", Window)
	slider:SetPos(64, 100)
	slider:SetSize(200, 48)
	slider:SetDecimals(0)
	slider:SetMinMax(1, 3)
	slider:SetConVar("_nox_fontsize")
	slider:SetText("Chat text size")
	slider.OnValueChanged = function(slid, val)
		RunConsoleCommand("nox_fontsize", val, 1)
	end

	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetPos(64, 160)
	check:SetSize(wide, 32)
	check:SetText("Display player hats, auras, etc.")
	check:SetConVar("_nox_displayhats")
	check.Button.ConVarChanged = function(obj, strnewvalue)
		DISPLAYHATS = strnewvalue == "1"
		RunConsoleCommand("_nox_displayhats", strnewvalue)
	end

	local button = vgui.Create("DButton", Window)
	button:SetPos(truewide * 0.5 - 50, Window:GetTall() - 36)
	button:SetSize(100, 28)
	button:SetText("Close")
	button.DoClick = function(btn) btn:GetParent():SetVisible(false) end
end
