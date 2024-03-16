if SERVER then
	AddCSLuaFile(NDB_ADDON_NAME)
	return
end

local function kickcallback(pl)
	if not pl:IsValid() then
		LocalPlayer():ChatPrint("Player already left.")
		return
	end

	local frame = vgui.Create("DFrame")
	frame:SetTitle("Kick "..pl:Name().." because...")
	frame:SetPos(gui.MousePos())
	frame:SetSize(300, 100)

	local tentry = vgui.Create("DTextEntry", frame)
	tentry:SetUpdateOnType(true)
	tentry:SetPos(20, 40)
	tentry:SetSize(260, 28)

	local button = vgui.Create("DButton", frame)
	button:SetPos(133, 75)
	button:SetSize(34, 16)
	button:SetText("Bye!")
	button.UserID = pl:UserID()
	button.DoClick = function(btn)
		RunConsoleCommand("a_kick", btn.UserID, tentry:GetValue())
		frame:Remove()
	end

	frame:MakePopup()
end

local function forceurlcallback(pl)
	if not pl:IsValid() then
		LocalPlayer():ChatPrint("Player already left.")
		return
	end

	local frame = vgui.Create("DFrame")
	frame:SetTitle("Force "..pl:Name().." to go to...")
	frame:SetPos(gui.MousePos())
	frame:SetSize(300, 100)

	local tentry = vgui.Create("DTextEntry", frame)
	tentry:SetUpdateOnType(true)
	tentry:SetPos(20, 40)
	tentry:SetSize(260, 28)

	local button = vgui.Create("DButton", frame)
	button:SetPos(133, 75)
	button:SetSize(34, 16)
	button:SetText("hello.jpg!")
	button.UserID = pl:UserID()
	button.DoClick = function(btn)
		RunConsoleCommand("a_forceurl", btn.UserID, tentry:GetValue())
		frame:Remove()
	end

	frame:MakePopup()
end

local function mutecallback(pl)
	if not pl:IsValid() then
		LocalPlayer():ChatPrint("Player already left.")
		return
	end

	local frame = vgui.Create("DFrame")
	frame:SetTitle("Mute "..pl:Name().."...")
	frame:SetPos(gui.MousePos())
	frame:SetSize(300, 150)

	local numslider = vgui.Create("DNumSlider", frame)
	numslider:SetMinMax(0, 10080)
	numslider:SetValue(0)
	numslider:SetDecimals(0)
	numslider:SetPos(20, 75)
	numslider:SetSize(260, 28)
	numslider:SetText("Minutes. 0 = perma.")

	local tentry = vgui.Create("DTextEntry", frame)
	tentry:SetUpdateOnType(true)
	tentry:SetPos(20, 40)
	tentry:SetSize(260, 28)

	local button = vgui.Create("DButton", frame)
	button:SetPos(133, 75)
	button:SetSize(34, 16)
	button:SetText("Muted!")
	button.UserID = pl:UserID()
	button.DoClick = function(btn)
		RunConsoleCommand("setmuted", btn.UserID, numslider:GetValue(), tentry:GetValue())
		frame:Remove()
	end

	frame:MakePopup()
end

local function rightscallback(userid, level)
	local frame = vgui.Create("DFrame")
	frame:SetTitle("Set rights")
	frame:SetPos(gui.MousePos())
	frame:SetSize(300, 150)

	local tentry = vgui.Create("DTextEntry", frame)
	tentry:SetUpdateOnType(true)
	tentry:SetPos(20, 40)
	tentry:SetSize(260, 28)

	local button = vgui.Create("DButton", frame)
	button:SetPos(133, 75)
	button:SetSize(34, 16)
	button:SetText("OK")
	button.DoClick = function(btn)
		RunConsoleCommand("setrights", userid, level, tentry:GetValue())
		frame:Remove()
	end

	frame:MakePopup()
end

local function bancallback(pl)
	if not pl:IsValid() then
		LocalPlayer():ChatPrint("Player already left.")
		return
	end

	local frame = vgui.Create("DFrame")
	frame:SetTitle("Ban "..pl:Name().."...")
	frame:SetPos(gui.MousePos())
	frame:SetSize(300, 150)

	local tentry = vgui.Create("DNumSlider", frame)
	tentry:SetMinMax(0, 2880)
	tentry:SetValue(0)
	tentry:SetDecimals(0)
	tentry:SetPos(20, 75)
	tentry:SetSize(260, 28)
	tentry:SetText("Minutes. 0 = perma.")

	local tentry2 = vgui.Create("DTextEntry", frame)
	tentry2:SetValue("General Idiot")
	tentry2:SetUpdateOnType(true)
	tentry2:SetPos(20, 40)
	tentry2:SetSize(260, 28)

	local button = vgui.Create("DButton", frame)
	button:SetPos(133, 130)
	button:SetSize(34, 16)
	button:SetText("Bye!")
	button.SteamID = pl.RealSteamID
	button.DoClick = function(btn)
		RunConsoleCommand("suspend", tostring(btn.SteamID), tentry:GetValue(), tentry2:GetValue())
		frame:Remove()
	end

	frame:MakePopup()
end

function NDB.AdminMenu(menu, pl)
	local userid = pl:UserID()
	local plmenu = menu:AddSubMenu("Administrate "..pl:Name().." ("..userid..")")
	plmenu.Player = pl
	--plmenu:AddOption("Edit flags", function() FlagEdit(pl) end)
	--plmenu:AddSpacer()
	plmenu:AddOption("Kick...", function() kickcallback(pl) end)
	plmenu:AddOption("Ban...", function() bancallback(pl) end)
	plmenu:AddSpacer()
	if not pl:IsUserGroup("admin") and not pl:IsUserGroup("superadmin") then
		plmenu:AddOption("Mute >", function() mutecallback(pl) end)
		plmenu:AddOption("Unmute", function() RunConsoleCommand("setmuted", userid, "0", "None") end)
		plmenu:AddSpacer()
		plmenu:AddOption("Force URL...", function() forceurlcallback(pl) end)
		plmenu:AddSpacer()
	end
	plmenu:AddOption("Kill", function() RunConsoleCommand("a_slay", userid) end)
	local slapmenu = plmenu:AddSubMenu("Slap >")
	slapmenu:AddOption("Hard with no damage", function() RunConsoleCommand("a_slap", userid, 2000, 0) end)
	slapmenu:AddOption("To the Moon", function() RunConsoleCommand("a_slap", userid, 5000, 100) end)
	slapmenu:AddOption("Very hard", function() RunConsoleCommand("a_slap", userid, 1500, 50) end)
	slapmenu:AddOption("Hard", function() RunConsoleCommand("a_slap", userid, 1000, 25) end)
	slapmenu:AddOption("Softly", function() RunConsoleCommand("a_slap", userid, 500, 15) end)
	slapmenu:AddOption("Nudge", function() RunConsoleCommand("a_slap", userid, 200, 0) end)
	local ignitemenu = plmenu:AddSubMenu("Ignite >")
	ignitemenu:AddOption("2 seconds", function() RunConsoleCommand("a_ignite", userid, 2) end)
	ignitemenu:AddOption("5 seconds", function() RunConsoleCommand("a_ignite", userid, 5) end)
	ignitemenu:AddOption("10 seconds", function() RunConsoleCommand("a_ignite", userid, 10) end)
	ignitemenu:AddOption("15 seconds", function() RunConsoleCommand("a_ignite", userid, 15) end)
	ignitemenu:AddOption("20 seconds", function() RunConsoleCommand("a_ignite", userid, 20) end)
	ignitemenu:AddOption("30 seconds", function() RunConsoleCommand("a_ignite", userid, 30) end)
	plmenu:AddSpacer()
	plmenu:AddOption("Teleport them to me", function() RunConsoleCommand("a_bringtome", userid) end)
	plmenu:AddOption("Teleport to them", function() RunConsoleCommand("a_teleporttothem", userid) end)
	plmenu:AddOption("Teleport them to my target", function() RunConsoleCommand("a_teleporttotarget", userid) end)
	plmenu:AddSpacer()
	if MySelf:IsUserGroup("superadmin") then
		plmenu:AddOption("Enable godmode", function() RunConsoleCommand("a_god", userid, 1) end)
		plmenu:AddOption("Disable godmode", function() RunConsoleCommand("a_god", userid, 0) end)
		plmenu:AddSpacer()
		plmenu:AddOption("Enable invisibility", function() RunConsoleCommand("a_invisibility", userid, 1) end)
		plmenu:AddOption("Disable invisibility", function() RunConsoleCommand("a_invisibility", userid, 0) end)
		plmenu:AddSpacer()
	end
	plmenu:AddOption("Freeze", function() RunConsoleCommand("a_freeze", userid, 1) end)
	plmenu:AddOption("Unfreeze", function() RunConsoleCommand("a_freeze", userid, 0) end)
	plmenu:AddSpacer()
	local rightsmenu = plmenu:AddSubMenu("Set rights >")
	rightsmenu:AddOption("1 (Non-builder)", function() rightscallback(userid, 1) end)
	rightsmenu:AddOption("2 (Trial builder)", function() rightscallback(userid, 2) end)
	rightsmenu:AddOption("3 (Builder)", function() rightscallback(userid, 3) end)
	rightsmenu:AddOption("4 (Adv. builder)", function() rightscallback(userid, 4) end)
	rightsmenu:AddOption("5 (Super builder)", function() rightscallback(userid, 5) end)
	rightsmenu:AddOption("6 (Moderator)", function() rightscallback(userid, 6) end)
	plmenu:AddOption("Get rights history", function() RunConsoleCommand("getrights", userid) end)
end

local menu
concommand.Add("+admin", function(sender, command, arguments)
	if not sender:IsUserGroup("admin") and not sender:IsUserGroup("superadmin") then return end

	menu = DermaMenu()
	menu:SetPos(150, 100)

	local allplayers = player.GetAll()
	table.sort(allplayers, function(a,b)
		local tab = {a:Name(), b:Name()}
		table.sort(tab)
		return a:Name() == tab[1]
	end)

	local submenu = menu:AddSubMenu("Players")
	for _, pl in ipairs(allplayers) do
		NDB.AdminMenu(submenu, pl)
	end

	menu:AddSpacer()
	local mapmenu = menu:AddSubMenu("Restart the map")
	local mapmenu2 = mapmenu:AddSubMenu("Really?")
	mapmenu2:AddOption("Really, really?", function() RunConsoleCommand("a_restartmap") end)

	menu:MakePopup()

	timer.Simple(0, gui.SetMousePos, 150, 100)
end)

concommand.Add("-admin", function(sender, command, arguments)
	if menu then
		menu:Remove()
		menu = nil
	end
end)
