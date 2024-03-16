NDB = {}

MEMBER_NONE = 0
MEMBER_GOLD = 1
MEMBER_DIAMOND = 2
MEMBER_DEFAULT = MEMBER_NONE

NDB.DefaultMemberTitles = {[MEMBER_NONE] = "", [MEMBER_GOLD] = "<yellow>(G)</yellow>", [MEMBER_DIAMOND] = "<diamond>"}
NDB.MemberNames = {[MEMBER_GOLD] = "Gold", [MEMBER_DIAMOND] = "Diamond"}
NDB.MemberDiscounts = {[MEMBER_GOLD] = 0.75, [MEMBER_DIAMOND] = 0.4, [MEMBER_NONE] = 1}
NDB.DefaultAdminTitle = "<flash=40,255,40,3>(NN)</flash>"

include("maplist.lua")

include("addons/cl_admin.lua")
include("addons/cl_announcements.lua")
include("addons/cl_awards.lua")
include("addons/cl_votemap.lua")
include("addons/serialize.lua")
include("addons/shop.lua")
include("addons/cl_shop.lua")
include("addons/zcl_gamemodename.lua")
include("addons/cl_chatbox.lua")
include("extensions/ndb_player_extend.lua")
include("extensions/string.lua")

CreateClientConVar("nox_limitdecals", "256", true, false)
CreateClientConVar("_nox_displayhats", "1", true, false)
DISPLAYHATS = GetConVarNumber("_nox_displayhats") == 1

concommand.Add("nox_displayhats", function(sender, command, arguments)
	if tostring(arguments[1]) == "1" then
		DISPLAYHATS = true
		RunConsoleCommand("_nox_displayhats", "1")
		print("Displaying hats")
	else
		DISPLAYHATS = false
		RunConsoleCommand("_nox_displayhats", "0")
		print("Hiding hats")
	end
end)

if not MySelf then
	MySelf = NULL
end
hook.Add("Think", "GetLocal", function()
	MySelf = LocalPlayer()
	if MySelf:IsValid() then
		gamemode.Call("HookGetLocal", MySelf)
		MySelf.Money = MySelf.Money or 0
		MySelf.MemberLevel = MySelf.MemberLevel or MEMBER_NONE or 0
		RunConsoleCommand("PostPlayerInitialSpawn")
		RunConsoleCommand("r_decals", GetConVarNumber("nox_limitdecals") or 0)
		hook.Remove("Think", "GetLocal")
	end
end)

w, h = ScrW(), ScrH()
timer.Create("UpdateResolution", 4, 0, function()
	w, h = ScrW(), ScrH()
end)

hook.Add("Think", "AFKWaitTillValid", function()
	if MySelf:IsValid() and MySelf.SteamID then
		hook.Remove("Think", "AFKWaitTillValid")

		if MySelf.MemberLevel == MEMBER_NONE then
			local AFKKick = CurTime() + 600
			hook.Add("KeyPress", "AFKKickerReset", function(pl)
				AFKKick = CurTime() + 600
			end)

			local lastx, lasty = gui.MousePos()
			hook.Add("Think", "AFKKicker", function() --timer.Create("CheckAFKKick", 30, 0, function()
				if MySelf.MemberLevel == MEMBER_NONE then
					local x, y = gui.MousePos()
					if x == lastx and lasty == y then
						local ct = CurTime()
						if AFKKick <= ct then
							RunConsoleCommand("afkkick")
						elseif AFKKick - 120 <= ct then
							--MySelf:ChatPrint("You're going to be kicked for being idle in... ".. math.ceil(AFKKick - ct))
							if not pAFKKicker then
								pAFKKicker = vgui.Create("DPanel")
								pAFKKicker:SetSize(200, 64)
								pAFKKicker:Center()
								local lab = EasyLabel(pAFKKicker, "You're going to be kicked for being idle in... ".. math.ceil(AFKKick - ct), "DefaultBold", COLOR_RED)
								lab:SetPos(100 - lab:GetWide(), 32)
								lab.OldPaint = lab.Paint
								lab.Paint = function(me)
									local str = "You're going to be kicked for being idle in... ".. math.ceil(AFKKick - ct)

									if str ~= me:GetText() then
										me:SetText(str)
										me:SetFGColor(COLOR_RED)
										me:SizeToContents()
									end

									me:OldPaint()

									if 120 < AFKKick - CurTime() then
										pAFKKicker:Remove()
										pAFKKicker = nil
									end
								end
							end
						end
					else
						if pAFKKicker then
							pAFKKicker:Remove()
							pAFKKicker = nil
						end
						AFKKick = CurTime() + 600
					end
					lastx, lasty = x, y
				else
					if pAFKKicker then
						pAFKKicker:Remove()
						pAFKKicker = nil
					end
					hook.Remove("Think", "AFKKicker")
				end
			end)
		end
	end
end)

--[[function ScreenScale(int)
	return (ScrH() / 480) * int
end]]

function BetterScreenScale()
	return ScrH() / 1200
end

function WordBox(parent, text, font, textcolor)
	local cpanel = vgui.Create("DPanel", parent)
	local label = EasyLabel(cpanel, text, font, textcolor)
	local tsizex, tsizey = label:GetSize()
	cpanel:SetSize(tsizex + 16, tsizey + 8)
	label:SetPos(8, (tsizey + 8) * 0.5 - tsizey * 0.5)
	cpanel:SetVisible(true)
	cpanel:SetMouseInputEnabled(false)
	cpanel:SetKeyboardInputEnabled(false)

	return cpanel
end

function EasyLabel(parent, text, font, textcolor)
	local dpanel = vgui.Create("DLabel", parent)
	if font then
		dpanel:SetFont(font or "Default")
	end
	dpanel:SetText(text)
	dpanel:SizeToContents()
	if textcolor then
		dpanel:SetTextColor(textcolor)
	end
	dpanel:SetKeyboardInputEnabled(false)
	dpanel:SetMouseInputEnabled(false)

	return dpanel
end

function EasyButton(parent, text, xpadding, ypadding)
	local dpanel = vgui.Create("DButton", parent)
	if textcolor then
		dpanel:SetFGColor(textcolor or color_white)
	end
	if text then
		dpanel:SetText(text)
	end
	dpanel:SizeToContents()

	if xpadding then
		dpanel:SetWide(dpanel:GetWide() + xpadding * 2)
	end

	if ypadding then
		dpanel:SetTall(dpanel:GetTall() + ypadding * 2)
	end

	return dpanel
end

NDB.ServerRules = [[These are the server rules, they're a lot more lax than other servers so at least take the time to read this!

* Don't use third-party programs designed to alter the game. Custom Lua scripts are OK in servers without Script Enforcer.
* Don't purposely exploit any game glitches or tell other players else how to exploit it. This includes maps where you can 'get outside' the playing area.
* Don't spam chat. There are measures put in place to prevent spamming so if you are circumventing it there's no excuses.
* Don't be an ass to the point where people can't play the game.
* Don't try to trick people who are asking for help. For example, don't tell someone to 'say blah' when they ask how to use something. It is still alright to try and fool people as long as they aren't asking how to play.
* Don't pretend to be an admin or 'know' an admin. Admins will not care about your personal affairs on these servers.
* In SandBox, don't destroy property or harrass anyone else unless they say it's OK.

Profanity, racism, sexism, etc. is allowed. If you have a problem with it then you can turn off chat by using the chat box's OPTION menu.

Admins have a blinking green (NN) title in chat. Anyone else is an imposter.]]

function NDB.FindPlayerByName(name)
	name = string.lower(name)

	local allplayers = player.GetAll()
	for _, pl in pairs(allplayers) do
		if pl:Name() == name then return pl end
	end

	for i=1, string.len(name) do
		for _, pl in pairs(allplayers) do
			if string.lower(pl:Name()) == string.sub(name, 1, i) then
				return pl
			end
		end
	end
end

IGNORELIST = {}

COLOR_RED = Color(255, 0, 0)
COLOR_YELLOW = Color(255, 255, 0)
COLOR_PINK = Color(255, 20, 100)

COLOR_GREEN = Color(0, 255, 0)
COLOR_LIMEGREEN = Color(50, 255, 50)

COLOR_PURPLE = Color(255, 0, 255)

COLOR_BLUE = Color(0, 0, 255)
COLOR_LIGHTBLUE = Color(0, 80, 255)
COLOR_CYAN = Color(0, 255, 255)

COLOR_WHITE = Color(255, 255, 255)
COLOR_BLACK = Color(0, 0, 0)

COLOR_GOLD = Color(255, 255, 80)
COLOR_DIAMOND = Color(255, 255, 255)

color_black_alpha90 = Color(0, 0, 0, 90)
color_black_alpha180 = Color(0, 0, 0, 180)
color_black_alpha220 = Color(0, 0, 0, 220)

hook.Add("Initialize", "NDBINITIALIZE", function()
	hook.Remove("Initialize", "NDBINITIALIZE")
	surface.CreateFont("frosty", 32, 200, true, false, "noxnetbig")
	surface.CreateFont("akbar", 24, 500, true, false, "noxnetnormal")
	surface.CreateFont("tohoma", 24, 400, true, false, "awardsname")
	surface.CreateFont("akbar", 16, 500, true, true, "noxnet")
	surface.CreateFont("akbar", 30, 500, true, true, "noxnetbigger")

	--IgnoreListLoad()
end)

local cvarAccountBoxX = CreateClientConVar("nox_accountbox_x", 8, true, false)
local cvarAccountBoxY = CreateClientConVar("nox_accountbox_y", ScrH() * 0.25, true, false)

hook.Add("HUDPaint", "GetWH", function()
	hook.Remove("HUDPaint", "GetWH")

	w, h = ScrW(), ScrH()

	local hideaccountbox = CreateClientConVar("nox_accountbox_hideunlesschatting", 0, true, false)
	local accountboxalpha = CreateClientConVar("nox_accountbox_transparency", 160, true, false)

	local frame = vgui.Create("DFrame")
	NDB.AccountFrame = frame
	frame:SetDeleteOnClose(false)
	frame:ShowCloseButton(false)
	frame.Children = {}
	frame.ChildrenShowing = true

	if GAMEMODE.AccountPaint then
		frame.Paint = GAMEMODE.AccountPaint
	else
		frame.Paint = function(me)
			if NDB.ChatOn or not hideaccountbox:GetBool() then
				local wi, he = me:GetSize()
				local alpha = accountboxalpha:GetInt()
				surface.SetDrawColor(0, 0, 0, alpha)
				surface.DrawRect(0, 24, wi, he - 24)
				surface.SetDrawColor(15, 15, 60, alpha)
				surface.DrawRect(0, 0, wi, 24)
				surface.SetDrawColor(120, 120, 120, alpha)
				surface.DrawOutlinedRect(0, 0, wi, he)

				if not me.ChildrenShowing then
					me:SetMouseInputEnabled(true)
					me:ShowChildren(true)
				end
			elseif me.ChildrenShowing then
				me:SetMouseInputEnabled(false)
				me:ShowChildren(false)
			end
		end
	end
	frame.OldOnMouseReleased = frame.OnMouseReleased
	frame.OnMouseReleased = function(me)
		local ret = me:OldOnMouseReleased()
		local x, y = me:GetPos()
		RunConsoleCommand("nox_accountbox_x", x)
		RunConsoleCommand("nox_accountbox_y", y)
		return ret
	end

	frame.ShowChildren = function(me, bool)
		me.ChildrenShowing = bool
		for _, child in pairs(me.Children) do
			child:SetVisible(bool)
		end
	end

	local title = EasyLabel(frame, "NoXiousNet Account", "noxnet", COLOR_LIMEGREEN)
	local titlw, titlh = title:GetSize()
	--local wid, hei = titlw + 32, titlh * 5
	local wid = titlw + 32
	title:SetPos(wid * 0.5 - title:GetWide() * 0.5, 12 - titlh * 0.5)
	table.insert(frame.Children, title)

	local y = 24 + title:GetTall()

	frame:SetWide(wid)
	frame.lblTitle:SetVisible(false)

	local monlab = EasyLabel(frame, "Silver: 0", "DefaultBold", color_white)
	monlab:SetPos(8, y)
	monlab.OldPaint = monlab.Paint
	local LastMoney = 0
	monlab.Paint = function(me)
		if MySelf.Money ~= LastMoney then
			LastMoney = MySelf.Money
			me:SetText("Silver: "..string.CommaSeparate(tostring(LastMoney)))
			me:SetFGColor(color_white)
			me:SizeToContents()
		end
		return me:OldPaint()
	end
	table.insert(frame.Children, monlab)
	y = y + monlab:GetTall()

	--[[local monlab2 = EasyLabel(frame, 0, "DefaultBold", color_white)
	monlab2:SetPos(8 + monlab:GetWide(), y)
	monlab2:SetFGColorEx(0, 0, 0, 0)
	monlab2.OldPaint = monlab2.Paint
	monlab2.MoneyChange = 0
	monlab2.FadeTime = -2
	monlab2.Positive = true
	monlab2.Paint = function(me)
		if me.MoneyChange ~= LastMoney then
			local dif = LastMoney - me.MoneyChange
			me.MoneyChange = LastMoney
			me.FadeTime = CurTime() + 3
			if 0 < dif then
				me.Positive = true
				me:SetText("+ "..dif)
				me:SetFGColorEx(30, 255, 30, 255)
			else
				me.Positive = false
				me:SetText("- "..math.abs(dif))
				me:SetFGColorEx(255, 0, 0, 255)
			end
			me:SizeToContents()
		elseif CurTime() - 1 <= me.FadeTime then
			local alpha = math.min(255, (me.FadeTime - CurTime()) * 255)
			if me.Positive then
				me:SetFGColorEx(30, 255, 30, alpha)
			else
				me:SetFGColorEx(255, 0, 0, alpha)
			end
		end
		return me:OldPaint()
	end
	table.insert(frame.Children, monlab)
	y = y + monlab2:GetTall()]]

	local LastMemberLevel = MEMBER_NONE
	local memlab = EasyLabel(frame, " ", "DefaultSmall", color_white)
	--memlab:SetPos(8, hei - memlab:GetTall() - 8)
	memlab:SetPos(8, y)
	memlab.OldPaint = memlab.Paint
	memlab.Paint = function(me)
		if MySelf.MemberLevel ~= LastMemberLevel then
			LastMemberLevel = MySelf.MemberLevel
			if not LastMemberLevel or LastMemberLevel == MEMBER_NONE or not NDB.MemberNames[LastMemberLevel] then
				memlab:SetVisible(false)
			else
				memlab:SetText(tostring(NDB.MemberNames[LastMemberLevel]).." Member")
				memlab:SetFGColor(color_white)
				memlab:SizeToContents()
			end
		end
		return memlab:OldPaint()
	end
	table.insert(frame.Children, memlab)
	y = y + memlab:GetTall()

	frame:SetTall(y + 8)
	frame:SetPos(math.max(0, math.min(cvarAccountBoxX:GetFloat(), w - wid)), math.max(0, math.min(cvarAccountBoxY:GetFloat(), h - y + 8)))
end)

function DrawNoXNetBox()
end

function CheckDiamondGold()
end

usermessage.Hook("RecChat", function(um)
	local from = um:ReadEntity()
	local msg = string.Trim(um:ReadString())
	local all = um:ReadBool()
	if string.len(msg) > 0 then
		local isteamchat = not all
		local channel
		if isteamchat then
			channel = CHANNEL_PLAYERSAY_TEAM
		else
			channel = CHANNEL_PLAYERSAY
		end
		if from and from:IsValid() then
			NDB.FullChatText(from:EntIndex(), from:NoParseName(), msg, "chat", isteamchat, channel)
		else
			NDB.FullChatText(-1, nil, msg, "chat", isteamchat, channel)
		end
	end
end)

function RequestingInformation(pl)
	if pl:IsValid() and pl:IsPlayer() and (pl.NextRequestInfo or 0) < CurTime() then
		pl.NextRequestInfo = CurTime() + 3 -- This is already limited on the server but sending this too many times will "lock" the client from receiving usermesssages for a short time.
		RunConsoleCommand("RequestInformation", pl:EntIndex())
	end
end

function IgnoreListAdd(name)
	MySelf:ChatPrint("/ignore removed because you're all whiney babies. Do yourselves a favor and learn to not pay attention to chat or reduce the chat size.")
	--[[local place = string.find(name, " ", 1, true)
	if not place then return end
	name = string.sub(name, place+1)
	local lowername = string.lower(name)

	for i=1, string.len(lowername) do
		for _, pl in pairs(player.GetAll()) do
			if string.lower(pl:Name()) == string.sub(lowername, 1, i) then
				if pl == MySelf then
					MySelf:ChatPrint("You attempt to block out your own thoughts but fail miserably!")
				elseif pl:IsAdmin() or pl:IsSuperAdmin() then
					MySelf:ChatPrint(pl:NoParseName().." can not be ignored.")
				else
					IGNORELIST[pl.SteamID or "QQQQQ"] = true
					MySelf:ChatPrint(pl:NoParseName().." has been permanently ignored. You must use /unignore to remove them from your list of ignored people. THIS LIST SAVES ACROSS MAPS ON YOUR HARDDRIVE!")

					IgnoreListSave()
				end
				return
			end
		end
	end
	MySelf:ChatPrint("No one with that name found.")]]
end

function IgnoreListSave()
	--[[if table.Count(IGNORELIST) > 0 then
		local sav = {}
		for i, whatever in pairs(IGNORELIST) do
			table.insert(sav, i)
		end
		file.Write("noxnet_ignorelist.txt", table.concat(sav, ","))
	elseif file.Exists("noxnet_ignorelist.txt") then
		file.Delete("noxnet_ignorelist.txt")
	end]]
end

function IgnoreListLoad()
	--[[if file.Exists("noxnet_ignorelist.txt") then
		IGNORELIST = {}
		for _, id in pairs(string.Explode(",", file.Read("noxnet_ignorelist.txt"))) do
			IGNORELIST[id] = true
		end
	end]]
end

function IgnoreListRemove(name)
	MySelf:ChatPrint("/ignore removed because you're all whiney babies. Do yourselves a favor and learn to not pay attention to chat or reduce the chat size.")
	--[[local place = string.find(name, " ", 1, true)
	if not place then return end
	name = string.sub(name, place+1)
	local lowername = string.lower(name)

	if lowername == "all" then
		IGNORELIST = {}
		MySelf:ChatPrint("Your ignore list has been cleared.")
		IgnoreListSave()
		return
	end

	for i=1, string.len(lowername) do
		for _, pl in pairs(player.GetAll()) do
			if string.lower(pl:Name()) == string.sub(lowername, 1, i) then
				if pl == MySelf then
					MySelf:ChatPrint("How could you ignore yourself anyway?")
				elseif IGNORELIST[pl.SteamID] then
					IGNORELIST[pl.SteamID or "QQQQQQ"] = nil
					MySelf:ChatPrint("You can now hear "..pl:NoParseName()..".")
					IgnoreListSave()
				else
					MySelf:ChatPrint("That person was never ignored in the first place.")
				end
				return
			end
		end
	end
	MySelf:ChatPrint("No one with that name found.")]]
end

function ForceURL(url)
	local pan = vgui.Create("HTML")
	pan:SetPos(0,0)
	pan:SetSize(ScrW(), ScrH())
	if string.sub(url, 1, 4) == "http" then
		pan:OpenURL(url)
	else
		pan:OpenURL("http://"..url)
	end
end

function SM(int)
	MySelf.Money = int
end

function SML(int)
	MySelf.MemberLevel = int
	CheckDiamondGold()
end

usermessage.Hook("RecSteamID", function(um)
	local playa = um:ReadEntity()
	if not playa:IsValid() then return end
	local reals = um:ReadString()
	playa.RealSteamID = reals
	playa.SteamID = string.sub(reals, 11)
	playa.NewTitle = um:ReadString()
end)

usermessage.Hook("RecTitle", function(um)
	local pl = um:ReadEntity()
	if not pl:IsValid() then return end

	pl.NewTitle = um:ReadString()
end)

function draw.DrawTextShadow(text, font, x, y, color, shadowcolor, xalign)
	local tw, th = 0, 0
	surface.SetFont(font)

	if xalign == TEXT_ALIGN_CENTER then
		tw, th = surface.GetTextSize(text)
		x = x - tw * 0.5
	elseif xalign == TEXT_ALIGN_RIGHT then
		tw, th = surface.GetTextSize(text)
		x = x - tw
	end

	surface.SetTextColor(shadowcolor.r, shadowcolor.g, shadowcolor.b, shadowcolor.a or 255)
	surface.SetTextPos(x+1, y+1)
	surface.DrawText(text)
	surface.SetTextPos(x-1, y-1)
	surface.DrawText(text)
	surface.SetTextPos(x+1, y-1)
	surface.DrawText(text)
	surface.SetTextPos(x-1, y+1)
	surface.DrawText(text)

	if color then
		surface.SetTextColor(color.r, color.g, color.b, color.a or 255)
	end

	surface.SetTextPos(x, y)
	surface.DrawText(text)

	return tw, th
end

function draw.SimpleTextShadow(text, font, x, y, color, shadowcolor, xalign, yalign)
	font 	= font 		or "Default"
	x 		= x 		or 0
	y 		= y 		or 0
	xalign 	= xalign 	or TEXT_ALIGN_LEFT
	yalign 	= yalign 	or TEXT_ALIGN_TOP
	local tw, th = 0, 0
	surface.SetFont(font)
	
	if xalign == TEXT_ALIGN_CENTER then
		tw, th = surface.GetTextSize(text)
		x = x - tw*0.5
	elseif xalign == TEXT_ALIGN_RIGHT then
		tw, th = surface.GetTextSize(text)
		x = x - tw
	end
	
	if yalign == TEXT_ALIGN_CENTER then
		tw, th = surface.GetTextSize(text)
		y = y - th*0.5
	end

	surface.SetTextColor(shadowcolor.r, shadowcolor.g, shadowcolor.b, shadowcolor.a or 255)
	surface.SetTextPos(x+1, y+1)
	surface.DrawText(text)
	surface.SetTextPos(x-1, y-1)
	surface.DrawText(text)
	surface.SetTextPos(x+1, y-1)
	surface.DrawText(text)
	surface.SetTextPos(x-1, y+1)
	surface.DrawText(text)

	if color then
		surface.SetTextColor(color.r, color.g, color.b, color.a or 255)
	else
		surface.SetTextColor(255, 255, 255, 255)
	end

	surface.SetTextPos(x, y)
	surface.DrawText(text)

	return tw, th
end

local Obscenities = {}
Obscenities["cunt"] = true
Obscenities["fuck"] = true
Obscenities["motherfuck"] = true
Obscenities["wank"] = true
Obscenities["nigger"] = true
Obscenities["nigga"] = true
Obscenities["bastard"] = true
Obscenities["dick"] = true
Obscenities["prick"] = true
Obscenities["bollocks"] = true
Obscenities["ass"] = true
Obscenities["arse"] = true
Obscenities["paki"] = true
Obscenities["blowjob"] = true
Obscenities["handjob"] = true
Obscenities["titjob"] = true
Obscenities["cock"] = true
Obscenities["shit"] = true
Obscenities["crap"] = true
Obscenities["bollocks"] = true
Obscenities["ahole"] = true
Obscenities["a-hole"] = true
Obscenities["arse"] = true
Obscenities["asswipe"] = true
Obscenities["bastard"] = true
Obscenities["bitch"] = true
Obscenities["testicle"] = true
Obscenities["spic"] = true
Obscenities["boner"] = true
Obscenities["bumboy"] = true
Obscenities["bugger"] = true
Obscenities["coon"] = true
Obscenities["cock"] = true
Obscenities["cracker"] = true
Obscenities["cum"] = true
Obscenities["cunt"] = true
Obscenities["damn"] = true
Obscenities["dildo"] = true
Obscenities["douche"] = true
Obscenities["fag"] = true
Obscenities["honky"] = true
Obscenities["jism"] = true
Obscenities["smegma"] = true
Obscenities["minge"] = true
Obscenities["motherfucker"] = true
Obscenities["piss"] = true
Obscenities["prick"] = true
Obscenities["puss"] = true
Obscenities["rimmer"] = true
Obscenities["schmuck"] = true
Obscenities["shmuk"] = true
Obscenities["shmuc"] = true
Obscenities["slut"] = true
Obscenities["spakka"] = true
Obscenities["skank"] = true
Obscenities["tit"] = true
Obscenities["twat"] = true
Obscenities["whore"] = true
Obscenities["asses"] = true

local ObscenitiesExceptions = {}
ObscenitiesExceptions["ass"] = {"lass", "bass", "cass", "assa", "asse", "assi", "asso", "assu", "assye", "pass"}
ObscenitiesExceptions["asses"] = {"assess"}
ObscenitiesExceptions["dick"] = {"dicke", "dickens", "dickers", "dickeys"}
ObscenitiesExceptions["wank"] = {"swank", "twank"}
ObscenitiesExceptions["paki"] = {"pakist"}
ObscenitiesExceptions["shit"] = {"shita", "shittim", "shitake", "mishit"}
ObscenitiesExceptions["prick"] = {"nprick", "pricke", "prickl"}
ObscenitiesExceptions["tit"] = {"ltit", "ntit", "atit", "etit", "ptit", "ttit", "otit", "htit", "stit", "stit", "ntit", "rtit", "ctit", "ctit", "btit", "ktit", "tita", "tith", "titi", "titl", "titm", "titr", "titt", "titu", "tite", "titb", "titf", "tith", "titl", "titm", "titr", "mtit", "tity", "titre"}

local function FindObscenity(text)
	local lowertext = string.lower(text)
	lowertext = string.gsub(lowertext, "1", "i")
	lowertext = string.gsub(lowertext, "2", "r")
	lowertext = string.gsub(lowertext, "3", "e")
	lowertext = string.gsub(lowertext, "4", "a")
	lowertext = string.gsub(lowertext, "6", "g")
	lowertext = string.gsub(lowertext, "7", "t")
	lowertext = string.gsub(lowertext, "0", "o")
	lowertext = string.gsub(lowertext, "v", "u")
	lowertext = string.gsub(lowertext, "!", "i")
	lowertext = string.gsub(lowertext, "@", "a")
	lowertext = string.gsub(lowertext, "%$", "s")

	for obscenity in pairs(Obscenities) do
		local place, placeend = string.find(lowertext, obscenity)
		if place then
			if ObscenitiesExceptions[obscenity] then
				for _, exception in pairs(ObscenitiesExceptions[obscenity]) do
					local lookat = place - (string.find(exception, obscenity) - 1)
					if string.sub(lowertext, lookat, (lookat - 1) + string.len(exception)) == exception then
						local pretendtext = text
						local prefix = string.sub(pretendtext, 1, place - 1)
						local suffix = string.sub(pretendtext, placeend + 1)
						local stars = ""
						for i=0, placeend - place do
							stars = stars.."_"
						end
						pretendtext = prefix..stars..suffix
						return FindObscenity(pretendtext)
					end
				end
				return place, placeend
			else
				return place, placeend
			end
		end
	end
end

local NOXFILTER = CreateClientConVar("nox_profanityfilter", 0, true, false)
function WordFilter(text)
	local wordfilter = NOXFILTER:GetInt()
	if wordfilter == 0 then
		return text
	elseif wordfilter == 1 then
		while true do
			local obscenitystart, obscenityend = FindObscenity(text)
			if not obscenitystart then break end

			local prefix = string.sub(text, 1, obscenitystart - 1)
			local suffix = string.sub(text, obscenityend + 1)
			local stars = ""
			for i=0, obscenityend - obscenitystart do
				stars = stars.."*"
			end
			text = prefix..stars..suffix
		end
	elseif FindObscenity(text) then
		return "****"
	end

	return text
end

local pVoteKick

local function VoteButton(btn)
	if btn.Ban then
		RunConsoleCommand("voteban", btn.Name)
	else
		RunConsoleCommand("votekick", btn.Name)
	end

	surface.PlaySound("buttons/button3.wav")
	btn:GetParent():SetVisible(false)
end

function OpenVoteKick(ban)
	if pVoteKick then
		pVoteKick:Remove()
	end

	local frame = vgui.Create("DFrame")
	pVoteKick = frame
	frame:SetPos(w * 0.25, h * 0.1)
	local ysize = h * 0.8
	frame:SetSize(w * 0.5, ysize)
	if ban then
		frame:SetTitle("Voteban")
	else
		frame:SetTitle("Votekick")
	end
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetDeleteOnClose(false)

	local dlabel = vgui.Create("DLabel", frame)
	surface.SetFont("DefaultBold")
	local texw, texh = surface.GetTextSize("If you abuse this system to kick or ban people who are not breaking any rules, expect HARSH punishments on yourself!") 
	dlabel:SetPos(w * 0.25 - texw * 0.5, 32)
	dlabel:SetSize(texw, texh)
	dlabel:SetFont("DefaultBold")
	dlabel:SetText("If you abuse this system to kick or ban people who are not breaking any rules, expect bans lasting weeks on yourself!")
	dlabel:SetTextColor(COLOR_RED)

	local x = 32
	local y = 64

	for _, pl in pairs(player.GetAll()) do
		if pl ~= MySelf and pl:IsValid() and not pl:IsAdmin() then
			local button = vgui.Create("DButton", frame)
			button:SetPos(x, y)
			button:SetSize(105, 24)
			button.DoClick = VoteButton
			button.Ban = ban
			local name = pl:Name()
			button:SetText(name)
			button.Name = pl.SteamID or name
			y = y + 32
			if y > ysize - 32 then
				x = x + 120
				y = 64
			end
		end
	end
end

function OpenDonationHTML()
	local Window = vgui.Create("DFrame")
	local tall = 450
	local wide = 600
	Window:SetSize(wide, tall)
	Window:Center()
	Window:SetTitle("Donations")
	Window:SetVisible(true)
	Window:SetDraggable(false)
	Window:MakePopup()
	Window:SetDeleteOnClose(true)
	Window:SetCursor("pointer")
	Window.Paint = function(self)
		draw.RoundedBox(8, 0, 0, wide, tall, color_black)
	end

	local y = 32
	for i, line in ipairs(string.Explode("@", "Donations§noxnetnormal§30,255,30@NoXiousNet runs purely off of donations from its users. By donating you help prolong the life of the servers and community.§DefaultBold§200,255,200@In return, you can receive any of the below as gifts.§DefaultBold§200,255,200@ @Silver§DefaultBold@* Donate a dollar and get 30,000 Silver for each dollar.@ @Gold Member§DefaultBold§255,255,60@If you donate $5 then you can get Gold Member for life. You will...@* Get a 25% discount on all in-game purchases such as shop items, classes, weapons, and anything else that is buyable.@* Get a special donator's title and have your Steam avatar displayed next to your name in chat.@* Get 50% extra map voting power.@* Be immune to the AFK Kicker@* Get automatic SandBox building rights.@* Not be kicked to make room for Diamond Members using reserved slots.@ @Diamond Member§DefaultBold@If you donate $15 then you can get Diamond Member for life. You will...@* Get any Gold Member features.@* Get a 60% discount on everything instead of a 25% discount.@* Get access to reserved slots on all NoXiousNet servers. Never wait in line to join a full server.@ @ @To donate, please visit the website at www.noxiousnet.com and click the Donations tab at the top of the page for more details.§DefaultBold§20,255,20@We are only accepting PayPal as a means for receiving donations in order to protect our donators!")) do
		local col
		local fontsize
		local expl = string.Explode("§", line)
		if expl[2] then
			fontsize = expl[2]
		end
		if expl[3] then
			local coltab = string.Explode(",", expl[3])
			col = Color(tonumber(coltab[1]), tonumber(coltab[2]), tonumber(coltab[3]), 255)
		end
		local label = EasyLabel(Window, expl[1], fontsize, col)
		label:SetPos(8, y)
		y = y + label:GetTall()
	end

	local button = EasyButton(Window, "Close", 32, 4)
	button:SetPos(wide * 0.5 - button:GetWide() * 0.5, tall - 16 - button:GetTall())
	button.DoClick = function(btn) btn:GetParent():Remove() end
end

function NDB.GeneralPlayerMenu(pl, popup, x, y)
	if not pl:IsValid() then return end

	if pl.HasDermaMenu and pl.HasDermaMenu:Valid() then
		pl.HasDermaMenu:Remove()
	end

	local plmenu = DermaMenu()
	pl.HasDermaMenu = plmenu
	if x and y then
		plmenu:SetPos(x, y)
	else
		plmenu:SetPos(gui.MouseX(), gui.MouseY())
	end

	plmenu.Player = pl
	local userid = pl:UserID()
	local steamid = pl.SteamID or pl:Name()
	plmenu:AddOption(pl:Name())
	plmenu:AddSpacer()
	plmenu:AddOption("View Profile and Awards", function() NDB.CreateProfile(pl) end)
	if pl ~= MySelf then
		plmenu:AddSpacer()
		plmenu:AddOption("Vote to kick", function() RunConsoleCommand("votekick", steamid) end)
		plmenu:AddOption("Vote to ban", function() RunConsoleCommand("voteban", steamid) end)
		--[[if IGNORELIST[steamid or "QQQQQ"] then
			plmenu:AddOption("Unignore chat", function()
				IGNORELIST[steamid] = nil
				MySelf:ChatPrint(pl:NoParseName().." has been unignored.")
				IgnoreListSave()
			end)
		else
			plmenu:AddOption("Ignore chat on all NoXiousNet servers", function()
				if pl:IsAdmin() or pl:IsSuperAdmin() then
					MySelf:ChatPrint(pl:NoParseName().." can not be ignored.")
				else
					IGNORELIST[steamid] = true
					MySelf:ChatPrint(pl:NoParseName().." has been permanently ignored. You must use /unignore or this menu to remove them from your list of ignored people. THIS LIST SAVES ACROSS MAPS ON YOUR HARDDRIVE!")
					IgnoreListSave()
				end
			end)
		end]]
	end
	plmenu:AddSpacer()
	if MySelf:IsAdmin() then
		NDB.AdminMenu(plmenu, pl)
		plmenu:AddSpacer()
	end
	plmenu:AddOption("Nevermind...")

	if popup then
		plmenu:MakePopup()
	end

	return plmenu
end

NDB.Servers = {
{"NoXious - Team Play", "65.60.53.26:27015", "NoXious is home the most action you can find on GMod.\nThe latest reincarnation of the NoX gamemode, designed to be more fast-paced and skill-based than the old TeamPlay.\nThis version has players creating their own classes instead of buying prebuilt ones and tons of new ways to obliterate your opponents.\nFrom slamming people in to walls, to aerial dog fights with fighter jets, to running on the walls themselves, NoXious is your first choice for non-stop action."},
{"Zombie Survival", "65.60.53.27:27015", "The official Zombie Survival server. A team of humans try to survive an onslaught of player zombies. When a human dies, they respawn as a zombie.\nKill zombies to get better weapons and use barricade to slow down the oncoming undead.\nZombie players have an assortment of different classes to use each with their own special abilities."},
{"NoX TeamPlay", "65.60.53.26:27016", "The game that started it all. This is a retro version of the new flagship gamemode \"NoXious\".\nMagic and technology clash as two or more teams compete against each other to complete objectives.\nFeatures tons of classes, vehicular warfare, strategic combat, and plenty of action."},
{"SandBox", "65.60.53.27:27018", "NoXiousNet's SandBox server.\nEnjoy pester-free building as new players are required to get building rights from an admin in order to do anything.\nBuilding rights and records are kept in a database so we always know who's actually playing and who's just there to be annoying."},
{"Incredible RP", "65.60.53.26:27017", "The best RP you will ever play, ever."},
{"Mario Boxes 2D", "65.60.53.26:27018", "A 'Half-2D' physics side-scroller.\nThe Mario and Luigi teams compete against eachother with an assortment of weapons and powerups."},
{"NoX Arena", "65.60.53.27:27016", "An arena to settle your differences. This is NoXious in a 1-on-1 setting."},
{"Awesome Strike", "65.60.53.27:27017", "An attempt at creating a Counter-Strike that's more awesome.\nPhysical bullets, dodging, wall jumping, and tons of cool weapons are at the disposal of the Terrorist and Counter-Terrorist teams."}
}

local function ConnectDoClick(me)
	surface.PlaySound("buttons/button15.wav")
	surface.PlaySound("ambient/machines/teleport1.wav")
	me:GetParent():Close()
	local start = CurTime()
	hook.Add("HUDPaint", "NoXiousPortalDraw", function()
		surface.SetDrawColor(255, 255, 255, math.min(255, (CurTime() - start) * 400))
		surface.DrawRect(0, 0, ScrW(), ScrH())
	end)
	timer.Simple(1.5, MySelf.ConCommand, MySelf, "connect "..me.IP)
end

function MakepPortal()
	if pServerPortal and pServerPortal:Valid() then
		pServerPortal:Remove()
		pServerPortal = nil
	end

	if math.random(1, 2) == 1 then
		surface.PlaySound("vo/k_lab/kl_masslessfieldflux.wav")
	else
		surface.PlaySound("vo/k_lab/kl_ensconced.wav")
	end

	local wid = 400
	local halfw = wid * 0.5

	local df = vgui.Create("DFrame")
	pServerPortal = df
	df:SetWide(wid)
	df:SetTitle("Server Portal")

	local y = 28

	local wb = WordBox(df, "Pick another server to join!", "DefaultBold", color_white)
	wb:SetPos(halfw - wb:GetWide() * 0.5, y)
	y = y + wb:GetTall() + 4

	local sillypanel = vgui.Create("DPanel", df)
	sillypanel:SetPos(8, y)
	sillypanel:SetSize(wid - 16, 100)

	local kleiner = vgui.Create("DModelPanel", sillypanel)
	kleiner:SetAnimated(true)
	kleiner:SetModel("models/kleiner.mdl")
	local tall = sillypanel:GetTall()
	kleiner:SetSize(tall, tall)
	kleiner:SetPos(sillypanel:GetWide() * 0.5 - kleiner:GetWide(), 0)
	kleiner.Entity:ResetSequence(kleiner.Entity:LookupSequence("idle_subtle"))
	kleiner.Entity:SetPoseParameter("breathing", 1)
	kleiner:SetCamPos(Vector(92,-48,64))
	kleiner:SetLookAt(Vector(0,0,32))
	kleiner.LayoutEntity = function(k, ent)
		if k.bAnimated then
			k:RunAnimation()
		end
	end

	local telepad = vgui.Create("DModelPanel", sillypanel)
	telepad:SetAnimated(false)
	telepad:SetModel("models/props_lab/teleplatform.mdl")
	telepad:SetSize(tall, tall)
	telepad:SetPos(sillypanel:GetWide() * 0.5, 0)
	telepad:SetCamPos(Vector(128,64,92))
	telepad:SetLookAt(Vector(0,0,0))
	telepad.LayoutEntity = kleiner.LayoutEntity

	y = y + sillypanel:GetTall() + 8

	for i, tab in ipairs(NDB.Servers) do
		local but = EasyButton(df, tab[1], 0, 8)
		but:SetWide(wid - 64)
		but:SetPos(32, y)
		but:SetTooltip(tab[3])
		but.IP = tab[2]
		but.DoClick = ConnectDoClick
		y = y + but:GetTall() + 4
	end

	df:SetTall(y + 4)

	df:Center()
	df:SetVisible(true)
	df:MakePopup()
end

concommand.Add("serverportal", function(sender, command, arguments)
	MakepPortal()
end)

usermessage.Hook("RecMergInvent", function(um)
	local ent = um:ReadEntity()
	local str = um:ReadString()
	if ent:IsValid() then
		ent.MergerInventory = Deserialize(str)
		if ent == MySelf and pLoadout and pLoadout:Valid() and pLoadout.List and pLoadout.List:Valid() then
			pLoadout.List:RefreshList()
		end
	end
end)

usermessage.Hook("RecInvent", function(um)
	local ent = um:ReadEntity()
	local str = um:ReadString()
	if ent:IsValid() then
		ent.Inventory = Deserialize(str)
		--[[if um:ReadBool() and ent == MySelf then
			RunConsoleCommand("shopmenu")
		end]]
	end
end)

function NDB.GetWikiFrame()
	local frame = vgui.Create("DFrame")
	frame:SetDeleteOnClose(true)
	frame:SetSize(800, 600)
	frame:SetTitle("In-game Wiki")

	local pan = NDB.GetWikiPanel()
	pan:SetParent(frame)
	pan:SetPos(8, 600 - pan:GetTall() - 8)

	frame.WikiPanel = pan

	return frame
end

local NextAllowClick = 0
local function ArticleDoClick(me)
	if NextAllowClick <= SysTime() then
		NextAllowClick = SysTime() + 2
		surface.PlaySound("weapons/ar2/ar2_reload_push.wav")
		me.Output:SetHTML("<html><head></head><body bgcolor='black'><span style='text-align:center;color:red;font-decoration:bold;font-size:200%;'>Loading...</span></body></html>")
		me.Output:OpenURL("http://heavy.noxiousnet.com/wiki/index.php?title="..tostring(me.Article))
	end
end

local function ContentsDoClick(me)
	surface.PlaySound("weapons/ar2/ar2_reload_push.wav")
	me.Output:SetHTML(tostring(me.Contents))
end

local function RecursiveAdd(window, current, output, contenttab)
	for i, tab in ipairs(contenttab) do
		if tab.Contents then
			local but = current:AddNode(tab.Name)
			but.Contents = tab.Contents
			but.DoClick = ContentsDoClick
			but.Output = output
			window.Contents[tab.Name] = tab.Contents
		elseif tab.Article then
			local but = current:AddNode(tab.Name)
			but.Article = tab.Article
			but.DoClick = ArticleDoClick
			but.Output = output
		elseif tab.Name then
			local node = current:AddNode(tab.Name)
			RecursiveAdd(window, node, output, tab)
		else
			print("Garbage detected in pHelp RecursiveAdd:", i, tab, current, contenttab)
		end
	end
end

function NDB.GetWikiPanel()
	local Window = vgui.Create("DPanel")
	Window:SetSize(784, 540)
	Window:SetCursor("pointer")
	Window.Contents = {}
	pWiki = Window

	local button = EasyButton(Window, "View the ENTIRE wiki", 8, 4)
	button:SetPos(8, Window:GetTall() - button:GetTall() - 8)
	button.DoClick = function(btn)
		Window.Output:OpenURL("http://heavy.noxiousnet.com/wiki/index.php")
	end

	local tree = vgui.Create("DTree", Window)
	tree:SetSize(Window:GetWide() * 0.25 - 8, Window:GetTall() - 24 - button:GetTall())
	tree:SetPos(8, 8)
	tree:SetIndentSize(8)
	tree.Window = Window
	Window.Tree = tree

	local output = vgui.Create("HTML", Window)
	output:SetSize(Window:GetWide() - tree:GetWide() - 24, Window:GetTall() - 16)
	output:SetPos(Window:GetWide() - output:GetWide() - 8, 8)
	output.Window = Window
	Window.Output = output

	if GAMEMODE.Wiki then
		RecursiveAdd(Window, tree, output, GAMEMODE.Wiki)
	end
	if NDB.Wiki then
		RecursiveAdd(Window, tree, output, NDB.Wiki)
	end

	return Window
end

function NDB.OpenWiki(article)
	if GAMEMODE.HandleWiki and GAMEMODE:HandleWiki(article) then
		return
	end

	local frame = NDB.GetWikiFrame()
	frame:Center()
	frame:MakePopup()
	if article then
		if frame.WikiPanel.Contents[article] then
			frame.WikiPanel.Output:SetHTML(frame.WikiPanel.Contents[article])
		else
			frame.WikiPanel.Output:OpenURL("http://heavy.noxiousnet.com/wiki/index.php?title="..tostring(article))
		end
	end
end

usermessage.Hook("recelim", function(um)
	NDB.EliminatedMaps = Deserialize(um:ReadString())
end)

local ContentsCallback = {}
ContentsCallback[1] = function(contents)
	local sf = string.find(contents, ":", 1, true)
	if sf then
		local id = string.sub(contents, 1, sf - 1)
		local acc = string.sub(contents, sf + 1)

		local ent = Entity(id)
		if ent:IsValid() then
			ent.AccountContents = Deserialize(acc)
		end
	end
end

ContentsCallback[2] = function(contents)
	NDB.EliminatedMaps = Deserialize(contents)
end

ContentsCallback[3] = function(contents)
	NDB.MapTags = Deserialize(contents)
end

ContentsCallback[4] = function(contents)
	local sf = string.find(contents, ":", 1, true)
	if sf then
		local id = string.sub(contents, 1, sf - 1)
		local acc = string.sub(contents, sf + 1)

		local ent = Entity(id)
		if ent:IsValid() then
			ent.Flags = Deserialize(acc)
		end
	end
end

ContentsCallback[5] = function(contents)
	local findmin, findmax, entid, acc = string.find(contents, "(%d)%:(.+)")
	if entid and acc then
		local ent = Entity(entid)
		if ent:IsValid() then
			ent.Inventory = Deserialize(acc)
		end
	end
end

ContentsCallback[6] = function(contents)
	MySelf.MergerInventory = Deserialize(contents)
	if pLoadout and pLoadout:Valid() and pMain:IsVisible() and pLoadout.List and pLoadout.List:Valid() then
		pLoadout.List:RefreshList()
	end
end

local Contents = {}

function RLs(uid, id, numpieces)
	local tab = Contents[uid]
	if tab then
		tab.NumPieces = numpieces
		tab.ID = id
		tab.Pieces = tab.Pieces or {}
	else
		Contents[uid] = {NumPieces = numpieces, ID = id, Pieces = {}}
	end
	return Contents[uid]
end

function RL(uid, pieceid, contents)
	local tab = Contents[uid]
	if not tab then
		tab = RLs(uid, -1, -1)
	end

	tab.Pieces[pieceid] = contents

	if tab.NumPieces <= 0 then return end

	local finished = true
	for i=1, tab.NumPieces do
		if not tab.Pieces[i] then
			finished = false
			break
		end
	end

	if finished then
		local id = tab.ID
		if ContentsCallback[id] then
			ContentsCallback[id](table.concat(tab.Pieces, ""))
		end

		tab = nil
		Contents[uid] = nil
	end
end

usermessage.Hook("RLStrs", function(um)
	RLs(um:ReadLong(), um:ReadShort(), um:ReadShort())
end)

usermessage.Hook("RLStr", function(um)
	RL(um:ReadLong(), um:ReadShort(), um:ReadString())
end)

scripted_ents.Register({Type = "anim", Draw = function(self) self:DrawModel() end}, "bantrain")
