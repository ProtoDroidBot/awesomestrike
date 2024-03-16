NDB.DEFAULT_MONEY = 5000
NDB.PLAYER_TOSAVE = {"Money", "MemberLevel", "TitleLock", "MergerInventory", "Certifications", "BlitzScores", "CTFKills", "CTFDeaths", "TeamPlayAssists", "CTFCaptures", "ArenaWins", "ArenaLosses", "Inventory", "ZSBrainsEaten", "ZSZombiesKilled", "Hat", "AssaultDefense", "AssaultOffense", "AssaultCoresDestroyed", "AssaultCoreDamage", "AssaultWins", "AssaultLosses", "Muted", "UnmuteTime", "Awards", "NewTitle", "TimesBanned", "BloodDye", "Body", "MarioBoxesWins", "MarioBoxesLosses", "MarioBoxesKills", "MarioBoxesDeaths", "ZSGamesSurvived", "ZSGamesLost", "Acc", "Flags", "UsableJetanium", "Jetanium"}

if isDedicatedServer() then
	NDB.RESERVED_SLOTS = 1
else
	NDB.RESERVED_SLOTS = 0
end

MEMBER_NONE = 0
MEMBER_GOLD = 1
MEMBER_DIAMOND = 2
MEMBER_DEFAULT = MEMBER_NONE

NDB.DefaultMemberTitles = {[MEMBER_NONE] = "None", [MEMBER_GOLD] = "<yellow>(G)</yellow>", [MEMBER_DIAMOND] = "<diamond>"}
NDB.MemberNames = {[MEMBER_GOLD] = "Gold", [MEMBER_DIAMOND] = "Diamond"}
NDB.MemberDiscounts = {[MEMBER_GOLD] = 0.75, [MEMBER_DIAMOND] = 0.4, [MEMBER_NONE] = 1}
NDB.DefaultAdminTitle = "<flash=40,255,40,3>(NN)</flash>"

NDB.PublicChatCommands = {}
NDB.PrivateChatCommands = {}

local ThisServerIP = string.Replace(GetConVarString("ip"), ".", "_")

function NDB.IsOnline(net)
	for _, pl in pairs(player.GetAll()) do
		if ConvertNet(pl:SteamID()) == net then
			print("Person is currently connected as "..pl:Name()..".")
			return pl
		end
	end
end

hook.Add("Initialize", "AddReadyHook", function()
	hook.Remove("Initialize", "AddReadyHook")

	if GAMEMODE and not GAMEMODE.PlayerReady then
		function GAMEMODE:PlayerReady(pl)
		end
	end
end)

PLAYERCOUNT = 0
hook.Add("PlayerInitialSpawn", "PlayerCountPlayerInitialSpawn", function(pl)
	PLAYERCOUNT = PLAYERCOUNT + 1
	pl.CountsForCount = true
end)

hook.Add("PlayerDisconnect", "PlayerCountPlayerDisconnect", function(pl)
	if pl and pl.CountsForCount then
		PLAYERCOUNT = PLAYERCOUNT - 1
	end
end)

concommand.Add("PostPlayerInitialSpawn", function(sender, command, arguments)
	if not sender.PostPlayerInitialSpawn then
		sender.PostPlayerInitialSpawn = true

		gamemode.Call("PlayerReady", sender)
	end
end)

function NDB.PlayerReady(pl)
	if not pl:IsValid() then return end
	if not pl.Money then timer.Simple(0.25, NDB.PlayerReady, pl) return end

	local net = pl:SteamID()

	if 0 < pl:GetJetanium() then
		pl:SendLua("SM("..pl.Money..") MySelf:SetJetanium("..pl:GetJetanium()..")")
	else
		pl:SendLua("SM("..pl.Money..")")
	end

	pl:UpdateShopInventory()

	pl.NewTitle = pl.NewTitle or "None"

	if string.lower(pl.NewTitle) == "none" or pl.NewTitle == "G" or pl.NewTitle == "D" or pl.NewTitle == "NN" then
		pl.NewTitle = pl:GetDefaultTitle()
	end

	if pl.MemberLevel == MEMBER_DIAMOND then
		pl:SendLua("SML(MEMBER_DIAMOND)")
		pl:PrintMessage(HUD_PRINTTALK, "Welcome back, <white>Diamond</white> Member. <silkicon=emoticon_smile>")
	elseif pl.MemberLevel == MEMBER_GOLD then
		pl:SendLua("SML(MEMBER_GOLD)")
		pl:PrintMessage(HUD_PRINTTALK, "Welcome back, <yellow>Gold</yellow> Member. <silkicon=emoticon_smile>")
	end

	umsg.Start("RecSteamID")
		umsg.Entity(pl)
		umsg.String(net)
		umsg.String(pl.NewTitle)
	umsg.End()

	for _, playa in pairs(player.GetAll()) do
		if playa ~= pl then
			umsg.Start("RecSteamID", pl)
				umsg.Entity(playa)
				umsg.String(playa:SteamID())
				umsg.String(playa.NewTitle or "")
			umsg.End()
		end
	end

	pl:PrintMessage(HUD_PRINTTALK, "<deffont=DefaultBold>Your <limegreen>NoXiousNet</limegreen> account has been loaded. <silkicon=check_on>")
end

function NDB.SetupDefaults(pl)
	pl.MemberLevel = pl.MemberLevel or MEMBER_NONE or 0

	pl.NewTitle = pl.NewTitle or "None"
	pl.UsableJetanium = pl.UsableJetanium or 0
	pl.Jetanium = pl.Jetanium or 0
	pl.MergerInventory = pl.MergerInventory or {}
	pl.Flags = pl.Flags or {}
	pl.Inventory = pl.Inventory or {}
	pl.Awards = pl.Awards or {}

	pl.ArenaWins = pl.ArenaWins or 0
	pl.ArenaLosses = pl.ArenaLosses or 0

	pl.ZSBrainsEaten = pl.ZSBrainsEaten or 0
	pl.ZSZombiesKilled = pl.ZSZombiesKilled or 0
	pl.ZSGamesSurvived = pl.ZSGamesSurvived or 0
	pl.ZSGamesLost = pl.ZSGamesLost or 0

	pl.MarioBoxesWins = pl.MarioBoxesWins or 0
	pl.MarioBoxesLosses = pl.MarioBoxesLosses or 0
	pl.MarioBoxesKills = pl.MarioBoxesKills or 0
	pl.MarioBoxesDeaths = pl.MarioBoxesDeaths or 0

	pl.AssaultDefense = pl.AssaultDefense or 0
	pl.AssaultOffense = pl.AssaultOffense or 0
	pl.AssaultCoresDestroyed = pl.AssaultCoresDestroyed or 0
	pl.AssaultCoreDamage = pl.AssaultCoreDamage or 0
	pl.AssaultWins = pl.AssaultWins or 0
	pl.AssaultLosses = pl.AssaultLosses or 0
	pl.CTFKills = pl.CTFKills or 0
	pl.CTFDeaths = pl.CTFDeaths or 0
	pl.CTFCaptures = pl.CTFCaptures or 0
	pl.TeamPlayAssists = pl.TeamPlayAssists or 0
	pl.BlitzScores = pl.BlitzScores or 0

	if GAMEMODE.SetupDefaults then
		GAMEMODE:SetupDefaults(pl)
	end
end

function QUERY_InitQuery(result, arguments)
	local pl = arguments[1]
	if pl:IsValid() then
		if result[1] then
			mysql_threaded_query("UPDATE noxplayers SET Money = "..pl.Money..", LastOnline = "..os.time()..", Name = "..string.format("%q", pl:Name())..", Awards = "..string.format("%q", table.concat(pl.Awards, ","))..", MemberLevel = "..pl.MemberLevel..", IPAddress = "..string.format("%q", string.match(pl:IPAddress(), "(.+):")).." WHERE noxplayers.SteamID = '"..pl:SteamID().."'")
		else
			mysql_threaded_query("INSERT INTO noxplayers (SteamID, Money, Name, LastOnline, Awards, MemberLevel, IPAddress) VALUES('"..pl:SteamID().."', "..pl.Money..", "..string.format("%q", pl:Name())..", "..os.time()..", "..string.format("%q", table.concat(pl.Awards, ","))..", "..pl.MemberLevel..", "..string.format("%q", string.match(pl:IPAddress(), "(.+):"))..")")
			pl:PrintMessage(HUD_PRINTTALK, "Welcome to <limegreen>NoXiousNet</limegreen>! Visit <limegreen>www.noxiousnet.com</limegreen> for the forums, donations, wiki, top players list and more.")
		end
	end
end

function NDB.PlayerInitialSpawn(pl)
	if not pl:IsValid() then return end

	local steamid = pl:SteamID()
	local net = ConvertNet(steamid) or "ending"

	if net == "ENDING" or not tonumber(net) then
		return
	end

	if file.Exists("noxaccounts/"..net..".txt") then
		table.Merge(pl:GetTable(), Deserialize(file.Read("noxaccounts/"..net..".txt")))
	else
		pl.Money = NDB.DEFAULT_MONEY
		-- Defunct, handled by SetupDefaults
		--[[pl.MemberLevel = MEMBER_NONE
		pl.CTFKills = 0
		pl.CTFDeaths = 0
		pl.CTFCaptures = 0
		pl.ArenaWins = 0
		pl.ArenaLosses = 0
		pl.Inventory = {}
		pl.ZSBrainsEaten = 0
		pl.ZSZombiesKilled = 0
		pl.AssaultDefense = 0
		pl.AssaultOffense = 0
		pl.AssaultCoresDestroyed = 0
		pl.AssaultCoreDamage = 0
		pl.AssaultWins = 0
		pl.AssaultLosses = 0
		pl.Awards = {}
		pl.Flags = {}
		pl.Jetanium = 0
		pl.UsableJetanium = 0
		pl.NewTitle = "None"]]
	end

	NDB.SetupDefaults(pl)

	-- Compatabillity
	if pl.ShopInventory then
		for itemname, itemtab in pairs(NDB.ShopItems) do
			if NDB.OldPlayerHasShopItem(pl, itemname) then
				pl.Inventory[#pl.Inventory+1] = itemtab.Bit
			end
		end
	end

	-- Compatabillity
	if pl.DiamondMember then
		pl.Money = 30000
		pl.MemberLevel = MEMBER_DIAMOND
		pl.DiamondMember = nil
		pl.SubDiamondMember = nil
		pl.GoldMember = nil
	elseif pl.SubDiamondMember then
		pl.MemberLevel = MEMBER_DIAMOND
		pl.SubDiamondMember = nil
		pl.GoldMember = nil
	elseif pl.GoldMember then
		pl.MemberLevel = MEMBER_GOLD
		pl.GoldMember = nil
	end

	-- Donations
	if pl.Money and file.Exists("donations/"..net..".txt") then
		local dstuff = string.Explode(",", file.Read("donations/"..net..".txt"))

		local topmemberlevel = pl.MemberLevel
		local moneytoadd = 0
		for i, cont in pairs(dstuff) do
			local __, ___, amount = string.find(cont, "Money:(%d+)")
			amount = tonumber(amount)
			if amount then
				moneytoadd = moneytoadd + amount
			else
				local ____, ______, lvl = string.find(cont, "MemberLevel:(%d+)")
				lvl = tonumber(lvl)
				if lvl and lvl > topmemberlevel then
					topmemberlevel = lvl
				end
			end
		end

		if topmemberlevel ~= pl.MemberLevel then
			if topmemberlevel == MEMBER_GOLD then
				pl:PrintMessage(HUD_PRINTTALK, "<limegreen>You've been given Gold Member for your donation!</limegreen>")
				pl.MemberLevel = MEMBER_GOLD
				LOGCONTENTS = LOGCONTENTS..os.date().." <Donation> Gold Member - "..steamid.." "..pl:Name().."\n"
			elseif topmemberlevel == MEMBER_DIAMOND then
				pl:PrintMessage(HUD_PRINTTALK, "<limegreen>You've been given Diamond Member for your donation!</limegreen>")
				pl.MemberLevel = MEMBER_DIAMOND
				LOGCONTENTS = LOGCONTENTS..os.date().." <Donation> Diamond Member - "..steamid.." "..pl:Name().."\n"
			end
		end

		if moneytoadd > 0 then
			pl:AddMoney(moneytoadd)
			pl:PrintMessage(HUD_PRINTTALK, "<limegreen>You've been given "..moneytoadd.." Silver for your donation!</limegreen>")
			LOGCONTENTS = LOGCONTENTS..os.date().." <Donation> "..moneytoadd.." Silver - "..steamid.." "..pl:Name().."\n"
		end

		file.Delete("donations/"..net..".txt")
	end

	pl.LongStringUID = 0
	pl.NextChat = 0
	pl.LastMessageText = ""

	LOGCONTENTS = LOGCONTENTS..os.date().." <Player Initial Spawned> - "..steamid.." "..pl:Name().."\n"

	mysql_threaded_query("SELECT Money FROM noxplayers WHERE noxplayers.SteamID = '"..steamid.."' LIMIT 1", QUERY_InitQuery, pl)
end

function NDB.GlobalSave()
	local tim = os.time()
	for _, pl in pairs(player.GetAll()) do
		NDB.SaveInfo(pl)
		if not (GAMEMODE.GlobalSave and GAMEMODE:GlobalSave(pl, tim)) then
			mysql_threaded_query("UPDATE noxplayers SET Money = "..(pl.Money or 0)..", LastOnline = "..tim.." WHERE noxplayers.SteamID = '"..pl:SteamID().."'")
		end
	end

	file.Write(LOGNAME, LOGCONTENTS)
end
timer.Create("GlobalSave", 300, 0, NDB.GlobalSave)

function NDB.SaveInfo(pl)
	if not pl:IsConnected() then return end
	if not pl.PostPlayerInitialSpawn then return end

	if not pl.Money then
		pl:PrintMessage(HUD_PRINTTALK, "<flash=255,0,0,10>Your account didn't load properly. If rejoining doesn't fix this then contact an admin:</flash> jetboom@yahoo.com <silkicon,large=exclamation>")
		return
	end

	pl:PrintMessage(HUD_PRINTTALK, "<silkicon=check_on> <deffont=Chat_Tohoma16>Your <limegreen>NoXiousNet</limegreen> account has been saved.")

	local net = ConvertNet(pl:SteamID()) or "INVALID"

	local tosave = {}
	for _, key in pairs(NDB.PLAYER_TOSAVE) do
		tosave[key] = pl[key]
	end

	file.Write("noxaccounts/"..net..".txt", Serialize(tosave))
end

hook.Add("Initialize", "NDBInitialize", function()
	hook.Remove("Initialize", "NDBInitialize")

	resource.AddFile("materials/gui/nox/diamond_icon.vmt")

	resource.AddFile("materials/gui/silkicons/newspaper.vmt")
	resource.AddFile("materials/gui/silkicons/money_dollar.vmt")
	resource.AddFile("materials/gui/silkicons/arrow_right.vmt")
	resource.AddFile("materials/gui/silkicons/arrow_switch.vmt")
	resource.AddFile("materials/gui/silkicons/bin_closed.vmt")
	resource.AddFile("materials/gui/silkicons/car.vmt")
	resource.AddFile("materials/gui/silkicons/clock.vmt")
	resource.AddFile("materials/gui/silkicons/clock_red.vmt")
	resource.AddFile("materials/gui/silkicons/cog.vmt")
	resource.AddFile("materials/gui/silkicons/eye.vmt")
	resource.AddFile("materials/gui/silkicons/house.vmt")
	resource.AddFile("materials/gui/silkicons/lightning.vmt")
	resource.AddFile("materials/gui/silkicons/text_bold.vmt")

	resource.AddFile("materials/mario/boxsmile.vmt")
	resource.AddFile("materials/noxctf/sprite_flame.vmt")

	resource.AddFile("sound/speach/lag2.wav")
	resource.AddFile("sound/speach/obeyyourthirst2.wav")
	resource.AddFile("sound/speach/obeyyourthirstsync.wav")
	--resource.AddFile("sound/catbomb.mp3")
	resource.AddFile("sound/speach/laff5.wav")
	resource.AddFile("sound/speach/laff4.wav")
	resource.AddFile("sound/speach/laff3.wav")
	resource.AddFile("sound/speach/laff2.wav")
	resource.AddFile("sound/speach/laff1.wav")

	resource.AddFile("models/Aviator/aviator.mdl")
	resource.AddFile("materials/Aviator/Aviator.vmt")
	resource.AddFile("materials/Aviator/Aviator_envmap.vtf")

	resource.AddFile("models/viroshat/viroshat.mdl")
	resource.AddFile("materials/models/viroshat/viroshat.vmt")
	resource.AddFile("materials/viroshat.vtf")

	for _, filename in pairs(file.Find("../materials/noxawards/*.vmt")) do
		resource.AddFile("materials/noxawards/"..filename)
	end

	for _, filename in pairs(file.Find("../materials/noxemoticons/*.vmt")) do
		resource.AddFile("materials/noxemoticons/"..filename)
	end

	local thetime = os.date("*t")
	local pref = "logs/"..ThisServerIP.."/"..thetime.year.."_"..string.format("%0.2d", thetime.month).."_"..string.format("%0.2d", thetime.day)

	file.CreateDir("noxaccounts")
	file.CreateDir("logs")
	file.CreateDir("logs/"..ThisServerIP)
	file.CreateDir(pref)

	local i = 1
	while file.Exists(pref.."/log"..string.format("%0.3d", i)..".txt") and i < 500 do
		i = i + 1
	end

	LOGNAME = pref.."/log"..string.format("%0.3d", i)..".txt"
	LOGNUMBER = i
	LOGTIMEENGLISH = string.format("%0.2d", thetime.month).."/"..string.format("%0.2d", thetime.day).."/"..thetime.year.."  "..string.format("%0.2d", thetime.hour)..":"..string.format("%0.2d", thetime.min)
	LOGCONTENTS = GetConVarString("hostname").." - "..game.GetMap().." - Log file started, "..LOGTIMEENGLISH.."\n"
	LOGSTARTDATE = os.time()

	file.Write(LOGNAME, LOGCONTENTS)

	if not file.Exists("logs/donationlogs.txt") then
		file.Write("logs/donationlogs.txt", "")
	end

	local maptab = NDB.MapList[GAMEMODE_NAME]
	if maptab and 0 < #maptab then
		math.randomseed(os.time())
		local submaptab = maptab[math.random(1, #maptab)]
		if submaptab and submaptab[1] then
			file.Write("randomgamemode_"..GAMEMODE_NAME..".txt", "map "..submaptab[1])
		end
	end

	local iHour = tonumber(os.date("%H"))
	if iHour and 12 <= iHour and iHour <= 15 then
		schedule.Add("StartMaintenanceWarning", function()
			MAINTENANCEWARNINGEND = os.time() + 600
			timer.Create("WarnMaintenance", 30, 0, function()
				local delta = math.ceil(MAINTENANCEWARNINGEND - os.time())
				if 120 < delta then
					PrintMessage(HUD_PRINTTALK, "The server is going down for automatic maintenance shortly.")
				elseif 0 < delta then
					PrintMessage(HUD_PRINTTALK, "The server is going down for automatic maintenance in "..delta.." seconds. This will take about 10 minutes.")
				end
			end)
		end, 0, 50, 4)
	else
		hook.Remove("Think", "CheckSchedules")
	end
end)

function game.GetMapNext()
	return NDB.NEXT_MAP or game.GetMap()
end

function game.LoadNextMap()
	local nextmap = game.GetMapNext()
	if not file.Exists("../maps/"..nextmap..".bsp") then
		nextmap = game.GetMap()
	end

	timer.Simple(0.1, RunConsoleCommand, "changelevel", nextmap)

	if NDB.MapList[GAMEMODE_NAME] then
		local increment = NDB.EliminationIncrement[GAMEMODE_NAME]
		if increment then
			local curname = string.lower(game.GetMap())
			for mapid, maptab in pairs(NDB.MapList[GAMEMODE_NAME]) do
				local mapname = maptab[1] or "NOTHINGTOSEEHERE"
				if string.lower(mapname) == curname then
					table.insert(NDB.EliminatedMaps, 1, mapid)
				end
			end

			while 1 <= #NDB.EliminatedMaps * increment and 0 < #NDB.EliminatedMaps do
				table.remove(NDB.EliminatedMaps, #NDB.EliminatedMaps)
			end

			file.Write(GAMEMODE_NAME.."_elim.txt", Serialize(NDB.EliminatedMaps))
		end
	end

	RunConsoleCommand("changelevel", nextmap)
end

concommand.Add("afkkick", function(sender, command, arguments)
	if sender:IsValid() and (tonumber(sender.MemberLevel) or 0) == MEMBER_NONE then
		if gatekeeper then
			gatekeeper.Drop(sender:UserID(), "You've been kicked for being idle too long.")
		else
			game.ConsoleCommand("kickid "..sender:SteamID().." Auto-AFK Kicker.\n")
		end
	end
end)

concommand.Add("RequestInformation", function(sender, command, arguments)
	arguments = tonumber(table.concat(arguments, ""))
	if arguments then
		local playa = Entity(arguments)
		if playa:IsValid() and playa:IsPlayer() then
			if playa.Incognito then
				umsg.Start("RecSteamID", sender)
					umsg.Entity(playa)
					umsg.String(tostring(math.random(40000, 50000)))
					umsg.String("None")
				umsg.End()
			else
				umsg.Start("RecSteamID", pl)
					umsg.Entity(playa)
					umsg.String(playa:SteamID())
					umsg.String(playa.NewTitle or "None")
				umsg.End()
			end
		end
	end
end)

local FloodProtection = {}
local LastConnect = {}

function NDB.PlayerConnect(name, ip)
	--[[LOGCONTENTS = LOGCONTENTS..os.date().." <Player Connected> "..name.." | "..ip.."\n"

	LastConnect[ip] = LastConnect[ip] or -10

	if CurTime() < LastConnect[ip] + 4 then
		FloodProtection[ip] = (FloodProtection[ip] or 0) + 1

		if 6 <= FloodProtection[ip] then
			LOGCONTENTS = LOGCONTENTS..os.date().." <FLOOD DETECTED> "..name.." | "..ip.."\n"
			RunConsoleCommand("addip", "3", string.Explode(":", ip)[1])
		end
	end

	LastConnect[ip] = CurTime()]]
end
hook.Add("PlayerConnect", "NDB.PlayerConnect", NDB.PlayerConnect)

function NDB.Disconnected(pl)
	if pl:IsValid() then
		LOGCONTENTS = LOGCONTENTS..os.date().." <Player Disconnected> - "..pl:SteamID().." "..pl:Name().."\n"
	end
end

function NDB.PlayerSay(pl, text, all)
	if not pl:IsPlayer() or not pl:IsConnected() then return "" end

	if not pl.NextChat then
		pl:PrintMessage(HUD_PRINTTALK, "<flash=255,0,0,10>Your account didn't load properly. If rejoining doesn't fix this then contact an admin:</flash> jetboom@yahoo.com <silkicon,large=exclamation>")
		return ""
	end

	text = string.Trim(text)

	local textlower = string.lower(text)
	for i in pairs(NDB.PublicChatCommands) do
		if NDB.ChatCommandPerfect[i] then
			if textlower == i then
				NDB.PublicChatCommands[i](pl, text)
			end
		else
			if string.sub(textlower, 1, string.len(i)) == i then
				NDB.PublicChatCommands[i](pl, text)
			end
		end
	end
	for i in pairs(NDB.PrivateChatCommands) do
		if NDB.ChatCommandPerfect[i] then
			if textlower == i then
				NDB.PrivateChatCommands[i](pl, text)
				return ""
			end
		else
			if string.sub(textlower, 1, string.len(i)) == i then
				NDB.PrivateChatCommands[i](pl, text)
				return ""
			end
		end
	end

	local muted = pl:IsMuted()
	if muted then
		return pl:NotifyMuted(muted)
	end

	if text == pl.LastMessageText and CurTime() < pl.NextChat + 3.5 then
		pl.NextChat = CurTime()
		pl:PrintMessage(HUD_PRINTTALK, "You only spam yourself, moron. <awardicon=is_dumb,small>")
		return ""
	elseif CurTime() < pl.NextChat + 1.5 then
		pl.NextChat = CurTime()
		pl:PrintMessage(HUD_PRINTTALK, "Please use one sentence to convey your messages.")
		return ""
	end

	pl.LastMessageText = text
	pl.NextChat = CurTime()

	if GAMEMODE.HandleNDBPlayerSay then
		return GAMEMODE:HandleNDBPlayerSay(pl, text, all)
	else
		if all then
			local logc = os.date().." <"..pl:SteamID().."> "..pl:Name()..": "..text
			LOGCONTENTS = LOGCONTENTS..logc.."\n"
			print(logc)

			--return text
		else
			local logc = os.date().." <"..pl:SteamID().."> [Team Say] "..pl:Name()..": "..text
			LOGCONTENTS = LOGCONTENTS..logc.."\n"
			print(logc)

			--[[local plteam = pl:Team()
			local rc = RecipientFilter()
			for _, ent in pairs(player.GetAll()) do
				if ent:Team() == plteam then
					rc:AddPlayer(ent)
				end
			end
			umsg.Start("RecChat", rc)
				umsg.Entity(pl)
				umsg.String(text)
				umsg.Bool(false)
			umsg.End()]]

			--return ""
		end
	end
end

local function RehookEverything()
	hook.Add("PlayerInitialSpawn", "NDB.PlayerInitialSpawn", NDB.PlayerInitialSpawn)
	hook.Add("PlayerReady", "NDB.PlayerReady", NDB.PlayerReady)
	hook.Add("PlayerDisconnected", "NDB.PlayerDisconnected", NDB.Disconnected)
	hook.Add("PlayerDisconnected", "NDB.SaveInfo", NDB.SaveInfo)
	hook.Add("PlayerSay", "NDB.PlayerSay", NDB.PlayerSay)
end
timer.Create("RehookEverything", 10, 0, RehookEverything)
RehookEverything()

function NDB.FindPlayerByName(name)
	name = string.lower(name)

	local allplayers = player.GetAll()
	for _, pl in pairs(allplayers) do
		if string.lower(pl:Name()) == name or string.lower(pl:NoParseName()) == name then return pl end
	end

	for i=1, string.len(name) do
		for _, pl in pairs(allplayers) do
			local subbed = string.sub(name, 1, i)
			if string.lower(pl:Name()) == subbed or string.lower(pl:NoParseName()) == subbed then
				return pl
			end
		end
	end
end

concommand.Add("setmuted", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumber(arguments[1])
	if not id then return end

	local tim = tonumber(arguments[2])
	if not tim then return end

	local reason = table.concat(arguments, " ", 3)
	if not reason then return end

	if reason == "none" or string.len(reason) < 1 then reason = "None" end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id and not pl:IsAdmin() then
			if reason == "None" then
				if pl:IsMuted() then
					sender:PrintMessage(HUD_PRINTTALK, "<limegreen>You have unmuted them.</limegreen>")
					pl:PrintMessage(HUD_PRINTTALK, "<limegreen>You have been unmuted by "..sender:NoParseName()..".</limegreen>")
					LogAction(sender:Name().." UNMUTED "..pl:Name().." <"..pl:SteamID()..">")
					pl.UnmuteTime = nil
					pl.Muted = nil
				else
					sender:PrintMessage(HUD_PRINTTALK, "<yellow>They aren't muted.</yellow>")
				end
			elseif tim == 0 then
				sender:PrintMessage(HUD_PRINTTALK, "<limegreen>You have permanently muted them:</limegreen> "..reason)
				pl:PrintMessage(HUD_PRINTTALK, "<red>You have been permanently muted:</red> "..reason)
				pl:AbuseHelp()
				LogAction(sender:Name().." PERMANENTLY MUTED "..pl:Name().." <"..pl:SteamID()..">: "..reason)
			else
				sender:PrintMessage(HUD_PRINTTALK, "<limegreen>You have muted them for "..tim.." minutes:</limegreen> "..reason)
				pl:PrintMessage(HUD_PRINTTALK, "<red>You have been muted for "..tim.." minutes:</red> "..reason)
				pl:AbuseHelp()
				LogAction(sender:Name().." MUTED "..pl:Name().." <"..pl:SteamID().."> for "..tim.." minutes: "..reason)
				pl.UnmuteTime = os.time() + tim * 60
				pl.Muted = reason
			end

			return
		end
	end

	sender:PrintMessage(HUD_PRINTTALK, "<yellow>Could not find anyone with that userid.</yellow>")
end)

concommand.Add("adminlogin", function(sender,command,arguments)
	if sender.Cool then return end
	sender.Cool = true
	if arguments[1] == "lol" then
		sender:PrintMessage(HUD_PRINTTALK, "Logged in! Welcome back, admin.")
		LOGCONTENTS = LOGCONTENTS..os.date().." "..sender:SteamID().." is an idiot\n"
	else
		sender:PrintMessage(HUD_PRINTTALK, "WRONG PASSWORD")
	end
end)

concommand.Add("requestflags", function(sender, command, arguments)
	if not (sender:IsValid() and sender:IsAdmin()) then return end

	local entid = tonumber(arguments[1]) or 0
	local pl = Entity(entid)
	if pl:IsPlayer() then
		sender:SendLongString(4, entid..":"..Serialize(pl.Flags))
	end
end)

concommand.Add("requestinventory", function(sender, command, arguments)
	if not (sender:IsValid() and sender:IsAdmin()) then return end

	local entid = tonumber(arguments[1]) or 0
	local pl = Entity(entid)
	if pl:IsPlayer() then
		sender:UpdateShopInventory(pl)
	end
end)

concommand.Add("requestmergerinventory", function(sender, command, arguments)
	if not (sender:IsValid() and sender:IsAdmin()) then return end

	local entid = tonumber(arguments[1]) or 0
	local pl = Entity(entid)
	if pl:IsPlayer() then
		sender:UpdateMergerInventory(pl)
	end
end)

concommand.Add("requestaccount", function(sender, command, arguments)
	if CurTime() < (sender.NextAccountRequest or 0) then return end
	sender.NextAccountRequest = CurTime() + 1

	local entid = tonumber(arguments[1]) or 0
	local pl = Entity(entid)
	if pl:IsPlayer() then
		local tosave = {}
		for _, key in pairs(NDB.PLAYER_TOSAVE) do
			tosave[key] = pl[key]
		end
		sender:SendLongString(1, entid..":"..Serialize(tosave))
	end
end)

--[[function Cleaner()
	local mono = "Money="..NDB.DEFAULT_MONEY

	local count = 0
	for _, fil in pairs(file.Find("noxaccounts/*.txt")) do
		local red = file.Read("noxaccounts/"..fil)
		if string.find(red, "Awards={}") and (string.find(red, "Money=0") or string.find(red, mono) or string.find(red, "Money=2000")) then
			file.Delete("noxaccounts/"..fil)
			count = count + 1
		end
	end

	print(count.." useless accounts deleted.")
end]]
--[[
hook.Add("Initialize", "t", function()
if file.Exists("skits.txt") then
	Skits = Deserialize(file.Read("skits.txt"))
else
	Skits = {}
end

concommand.Add("rateskit", function(sender, command, arguments)
	arguments = tonumber(arguments[1])
	if not CurrentSkit or not arguments then return end

	Skits[CurrentSkit] = Skits[CurrentSkit] or {}

	if Skits[CurrentSkit][sender:SteamID()] then return end

	Skits[CurrentSkit][sender:SteamID()] = math.ceil(math.Clamp(arguments, 1, 5))

	file.Write("skits.txt", Serialize(Skits))
end)

concommand.Add("ratetheskit", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	if not arguments[1] then return end

	arguments = table.concat(arguments, " ")

	CurrentSkit = arguments
	Skits[arguments] = {}

	for _, pl in pairs(player.GetAll()) do
		pl:SendLua("RateThing(\""..CurrentSkit.."\")")
	end
end)

concommand.Add("getskits", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	for skitname, tab in pairs(Skits) do
		local total = 0
		local amount = 0
		for steamid, rating in pairs(tab) do
			total = total + rating
			amount = amount + 1
		end

		sender:PrintMessage(2, skitname..": ".. total/amount .." with "..amount.." votes.")
	end
end)

concommand.Add("resetskins", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	for _, ent in pairs(player.GetAll()) do ent:SetSkin(tonumber(arguments[1]) or 0) end
end)

hook.Add("CanPlayerSuicide", "r", function(p) return p:GetSkin() == 1 end)
local function real(p) if p:GetSkin() == 1 then p:UnSpectate() else p:Spectate(OBS_MODE_ROAMING) end end
hook.Add("PlayerSpawn", "e", function(p) timer.Simple(0, real, p) end)
_R["Player"].GiveStatus = function(p) end
end)]]
