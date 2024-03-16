if CLIENT then return end

NDB.BANS = {}

function NDB.BansToTable(in_str)
	if in_str == "" then return {} end

	local final_table = {}
	local seperate_bans = string.Explode("|", in_str)
	for i=1, #seperate_bans do
		local bantable = {}
		local ban = string.Explode("~", seperate_bans[i])
		bantable.Name = tostring(ban[1]) or "Unknown"
		bantable.SteamID = tostring(ban[2]) or "STEAM_0:0:00000"
		bantable.Unban = tonumber(ban[3]) or 1
		bantable.Reason = tostring(ban[4]) or "Problem loading ban reason."
		bantable.Banner = tostring(ban[5]) or "Someone"
		table.insert(final_table, bantable)
	end
	return final_table
end

function NDB.BansToString()
	if #NDB.BANS == 0 then
		return ""
	end

	local temp_table = {}
	for i, ban in ipairs(NDB.BANS) do
		table.insert(temp_table, NDB.SerializeBan(i))
	end
	local savestr = table.concat(temp_table, "|")
	if not savestr then savestr = "" end
	return savestr
end

function NDB.SerializeBan(index)
	if not NDB.BANS[index] then return "Unknown~STEAM_0:0:10000~1~Problem serializing ban.~Someone" end
	local ban = NDB.BANS[index]
	return ban.Name.."~"..ban.SteamID.."~"..ban.Unban.."~"..ban.Reason.."~"..ban.Banner
end

function TimeToEnglish(delta)
	local delta = math.max(0, delta)
	local strTime = ""
	if delta < 60 then
		strTime = delta .." seconds"
	elseif delta < 3600 then
		strTime = math.ceil(delta / 60) .." minutes"
	elseif delta < 86400 then
		strTime = math.ceil(delta / 3600) .." hours"
	else
		strTime = math.ceil(delta / 86400) .." days"
	end

	return strTime
end

function NDB.InstantBan(pl, reason, tim, banner, nokick)
	reason = reason or "Banned"
	banner = banner or "Instantaneous"
	if pl:IsValid() and not pl:IsAdmin() then
		local steamid = pl:SteamID()

		if 172800 < tim and (pl.MemberLevel or 0) > 0 then
			tim = 172800
		end

		local found = false
		for _, ban in pairs(NDB.BANS) do
			if ban.SteamID == steamid then found = true end
		end

		if not found then
			local toinsert = {}

			toinsert.SteamID = steamid
			toinsert.Reason = reason
			toinsert.Banner = banner
			if not tim or tim == 0 then
				toinsert.Unban = 0
			else
				toinsert.Unban = os.time() + tim
			end
			toinsert.Name = string.gsub(string.gsub(pl:Name(), "|", " "), "~", " ")

			table.insert(NDB.BANS, toinsert)
			file.Write("banlist.txt", NDB.BansToString())

			pl.TimesBanned = (pl.TimesBanned or 0) + 1
			if 2 < pl.TimesBanned then
				if pl.Awards then
					local doesnthaveaward = true
					for _, award in pairs(pl.Awards) do
						if award == "Ban_Bait" then
							doesnthaveaward = false
							break
						end
					end
					if doesnthaveaward then
						NDB.GiveAward(pl, "Ban_Bait")
					end
				end
			end
		end

		local concom
		if nokick then
			concom = "kickid "..steamid.." "..reason.."\n"
		else
			for _, en in pairs(player.GetAll()) do
				if en:SteamID() == steamid then
					gatekeeper.Drop(en:UserID(), "Banned for "..TimeToEnglish(tim).." because "..reason)
				end
			end
			concom = "kickid "..steamid.." "..reason.."\n"
		end

		game.ConsoleCommand(concom)
		game.ConsoleCommand(concom)
		game.ConsoleCommand(concom)
		game.ConsoleCommand(concom)
		game.ConsoleCommand(concom)
		game.ConsoleCommand(concom)
		--game.ConsoleCommand("writeid\n")
	end
end

function NDB.UpdateBanID()
	local thetime = os.time()
	for _, pl in pairs(player.GetAll()) do
		for i, tab in pairs(NDB.BANS) do
			if tostring(tab.SteamID) == pl:SteamID() and (thetime < tab.Unban or tab.Unban == 0) then
				if gatekeeper then
					gatekeeper.Drop(pl:UserID(), "Banned: "..tostring(tab.Reason))
				else
					local concom = "kickid "..pl:SteamID().." Banned: "..tostring(tab.Reason).."\n"
					game.ConsoleCommand(concom)
					game.ConsoleCommand(concom)
					game.ConsoleCommand(concom)
					game.ConsoleCommand(concom)
					game.ConsoleCommand(concom)
					game.ConsoleCommand(concom)
				end
			end
		end
	end
end

function NDB.SyncBans()
	if file.Exists("banlist.txt") then
		NDB.BANS = NDB.BansToTable(file.Read("banlist.txt"))
		NDB.UpdateBanID()
	end
end

function CheckAllBans()
	NDB.BANS = NDB.BansToTable(file.Read("banlist.txt"))

	local changed = false
	local thetime = os.time()
	for i=1, #NDB.BANS do
		local ban = NDB.BANS[i]
		if ban then
			if ban.Unban ~= 0 and ban.Unban < thetime then
				print(ban.Name.." ("..ban.SteamID..") unbanned by schedule.")
				changed = true
				table.remove(NDB.BANS, i)
				i = i - 1
			end
		end
	end

	if changed then
		file.Write("banlist.txt", NDB.BansToString())
	end
end

function BanTrain(pl)
	PrintMessage(HUD_PRINTTALK, "<defc=255,0,0>The Ban Train is coming to pick up "..pl:Name()..". <flash=255,255,255,10>No return trips!</flash>")

	pl:Freeze(true)
	pl:SetEyeAngles(Angle(0, 270, 0))

	local ent = ents.Create("bantrain")
	if ent:IsValid() then
		ent:SetPos(pl:GetPos() + Vector(0, -24000, 100))
		ent.Banee = pl
		ent:Spawn()
		ent:Fire("farhorn", "", 1)
		ent:Fire("closehorn", "", 8)
		ent:Fire("kill", "", 60)
	end
	local ent2 = ents.Create("prop_dynamic_override")
	if ent2:IsValid() then
		ent2:SetModel("models/props_trainstation/train002.mdl")
		ent2:SetPos(pl:GetPos() + Vector(0,-24500,100))
		ent2:SetKeyValue("solid", "0")
		ent2:Spawn()
		ent2:SetParent(ent)
	end
	ent2 = ents.Create("prop_dynamic_override")
	if ent2:IsValid() then
		ent2:SetModel("models/props_trainstation/train003.mdl")
		ent2:SetPos(pl:GetPos() + Vector(0,-25000,100))
		ent2:SetKeyValue("solid", "0")
		ent2:Spawn()
		ent2:SetParent(ent)
	end
end

concommand.Add("suspend", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	if #arguments ~= 3 then sender:PrintMessage(HUD_PRINTTALK, "Syntax error. Wrong amount of arguments.") return end

	local steamid = arguments[1]
	local minutes = tonumber(arguments[2]) or 0
	local reason = table.concat(arguments, " ", 3)
	local banner = sender:Name()

	if sender.Incognito then banner = "Incognito" end

	if not steamid then sender:PrintMessage(HUD_PRINTTALK, "Syntax error. suspend <SteamID> <minutes> <reason> (error 001)\n") return end
	if not minutes then sender:PrintMessage(HUD_PRINTTALK, "Syntax error. suspend <SteamID> <minutes> <reason> (error 002)\n") return end
	if not reason then sender:PrintMessage(HUD_PRINTTALK, "Syntax error. suspend <SteamID> <minutes> <reason> (error 003)\n") return end

	if string.len(reason) <= 0 then sender:PrintMessage(HUD_PRINTTALK, "Syntax error. suspend <SteamID> <minutes> <reason> (error 004)\n") return end
	if 200 < string.len(reason) then reason = string.sub(reason, 1, 200) end

	if string.sub(steamid, 1, 6) ~= "STEAM_" or string.sub(steamid, 8, 8) ~= ":" or string.sub(steamid, 10, 10) ~= ":" then
		sender:PrintMessage(HUD_PRINTTALK, "Syntax error. SteamID Must be in STEAM_#:#:###... format (error 005)\n")
		return
	end

	NDB.BANS = NDB.BansToTable(file.Read("banlist.txt"))

	for i, ban in pairs(NDB.BANS) do
		if ban.SteamID == steamid then
			if ban.Unban ~= 0 and ban.Unban < os.time() then
				sender:PrintMessage(HUD_PRINTTALK, "That SteamID is already banned. Replacing")
				Msg(ban.Name.." ("..ban.SteamID..") being replaced.\n")
			end
			table.remove(NDB.BANS, i)
		end
	end

	local bantable = {}
	if 2880 < minutes then
		local net = ConvertNet(steamid)
		if net and file.Exists("noxaccounts/"..net..".txt") then
			if (tonumber(Deserialize(file.Read("noxaccounts/"..net..".txt")).MemberLevel) or 0) > 0 then
				minutes = 2880
			end
		end
		--[[for _, pl in pairs(player.GetAll()) do
			if pl:SteamID() == steamid then
				if MEMBER_GOLD <= (pl.MemberLevel or 0) then
					minutes = 2880
					break
				end
			end
		end]]
	end

	local playerbanned
	for _, pl in pairs(player.GetAll()) do
		if pl:SteamID() == steamid then
			playerbanned = pl
			bantable.Name = string.gsub(string.gsub(pl:Name(), "|", " "), "~", " ")
			pl.TimesBanned = (pl.TimesBanned or 0) + 1
			if 2 < pl.TimesBanned then
				if pl.Awards then
					local doesnthaveaward = true
					for _, award in pairs(pl.Awards) do
						if award == "Ban_Bait" then
							doesnthaveaward = false
							break
						end
					end
					if doesnthaveaward then
						NDB.GiveAward(pl, "Ban_Bait")
					end
				end
			end
			break
		end
	end
	bantable.Name = bantable.Name or "Unknown"
	bantable.SteamID = steamid
	if minutes == 0 then
		bantable.Unban = 0
	else
		bantable.Unban = os.time() + minutes * 60
	end
	bantable.Reason = reason
	bantable.Banner = banner
	table.insert(NDB.BANS, bantable)

	local displaytime = ""
	if minutes == 0 then
		displaytime = "forever"
	else
		displaytime = "for "..minutes.." minutes"
	end

	if playerbanned then
		if displaytime == "forever" then
			playerbanned.BanTrainComment = "Banned forever: "..reason
			BanTrain(playerbanned)
		else
			gmod.BroadcastLua([[surface.PlaySound("vo/npc/male01/gethellout.wav")]])
			playerbanned:Freeze(true)
			if 2 <= playerbanned:Health() then
				playerbanned:SetHealth(1)
			end
			timer.Simple(2, gatekeeper.Drop, playerbanned:UserID(), "Banned "..displaytime.." because: "..reason)
		end
	end

	local msg = "<defc=255,0,0>SteamID <white>"..steamid.."</white> being banned by <white>"..banner.."</white>, <white>"..displaytime.."</white>: <white>"..reason.."</white>"
	PrintMessage(HUD_PRINTTALK, msg)
	LOGCONTENTS = LOGCONTENTS..msg.."\n"

	file.Write("banlist.txt", NDB.BansToString())
end)

concommand.Add("unsuspend", function(sender, command, arguments)
	if not sender:IsAdmin() then return end
	if #arguments <= 0 then return end
	arguments = table.concat(arguments, "")
	NDB.BANS = NDB.BansToTable(file.Read("banlist.txt"))

	for i, ban in ipairs(NDB.BANS) do
		if ban.SteamID == arguments then
			sender:PrintMessage(HUD_PRINTTALK, "<limegreen>"..ban.SteamID.." Unbanned.</limegreen>")
			Msg(ban.Name.." ("..ban.SteamID..") unbanned by admin.\n")
			table.remove(NDB.BANS, i)
		end
	end

	file.Write("banlist.txt", NDB.BansToString())
end)

require("gatekeeper")

local function UserIDSort(a, b)
	return b:UserID() < a:UserID()
end

hook.Add("PlayerPasswordAuth", "GateKeeper", function(name, pass, steamid, ipaddress)
	for i, bantab in pairs(NDB.BANS) do
		if bantab.SteamID == steamid then
			if bantab.Unban == 0 then
				return {false, "Perma-banned: "..string.format("%s", bantab.Reason or "No given reason.")}
			elseif os.time() < bantab.Unban then
				local delta = math.max(1, bantab.Unban - os.time())
				local strTime = ""
				if delta < 60 then
					strTime = delta .." more seconds"
				elseif delta < 3600 then
					strTime = math.ceil(delta / 60) .." more minutes"
				elseif delta < 86400 then
					strTime = math.ceil(delta / 3600) .." more hours"
				else
					strTime = math.ceil(delta / 86400) .." more days"
				end

				return {false, "Banned for ".. strTime ..": "..string.format("%s", bantab.Reason or "No given reason.")}
			end
		end
	end

	if NDB.RESERVED_SLOTS <= 0 then return nil end

	local allplayers = player.GetAll()
	--local tplayers = #allplayers + 1
	local tplayers = gatekeeper.GetNumClients().total
	if GetConVarNumber("maxplayers") - NDB.RESERVED_SLOTS < tplayers then
		local net = ConvertNet(steamid) or "ending"
		local ReservedSlot
		if file.Exists("noxaccounts/"..net..".txt") then
			local red = Deserialize(file.Read("noxaccounts/"..net..".txt"))

			ReservedSlot = MEMBER_DIAMOND <= (red.MemberSlot or 0)
		end

		if ReservedSlot then
			table.sort(allplayers, UserIDSort)
			for i, kickee in ipairs(allplayers) do
				if kickee and kickee.MemberLevel == MEMBER_NONE and not kickee.ReservedSlot and not kickee:IsAdmin() then
					gatekeeper.Drop(kickee:UserID(), "Kicked to make room for a Diamond Member.")
					return
				end
			end
		else
			return {false, "Sorry, we're full! Last slot is for Diamond Members."}
		end
	end

	LOGCONTENTS = LOGCONTENTS..os.date().." <Player Connected> "..name.." | "..steamid.." | "..ipaddress.."\n"
end)

NDB.SyncBans()
timer.Create("SyncBans", 30, 0, NDB.SyncBans)

scripted_ents.Register({
Type = "anim",

Initialize = function(self)
	self.DieTime = CurTime() + math.Rand(20, 35)

	self:SetModel("models/props_trainstation/train001.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:Wake()
	end

	util.PrecacheSound("ambient/alarms/train_horn2.wav")
	util.PrecacheSound("ambient/alarms/train_horn_distant1.wav")
end,

AcceptInput = function(self, name, activator, caller, args)
	if name == "closehorn" then
		for _, pl in pairs(player.GetAll()) do
			pl:SendLua("surface.PlaySound(\"ambient/alarms/train_horn2.wav\")")
		end

		return true
	elseif name == "farhorn" then
		for _, pl in pairs(player.GetAll()) do
			pl:SendLua("surface.PlaySound(\"ambient/alarms/train_horn_distant1.wav\")")
		end

		return true
	elseif name == "doban" then
		local banee = self.Banee
		if banee:IsValid() and banee.BanTrainCommand then
			game.ConsoleCommand(banee.BanTrainCommand)
		end

		return true
	end
end,

Think = function(self)
	local banee = self.Banee
	if banee:IsValid() and banee:GetPos().y <= self:GetPos().y and not self.AlreadyHit then
		self.AlreadyHit = true
		banee:TakeDamage(1000, self, self)
		if banee:Alive() then
			banee:Kill()
		end
		PrintMessage(HUD_PRINTTALK, banee:Name().." was hit by the Ban Train.")
		gatekeeper.Drop(banee:UserID(), banee.BanTrainComment or "Hit by the ban train.")
		self:Fire("doban", "", 0.75)
		self:Fire("kill", "", 6)
	end

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetVelocityInstantaneous(Vector(0, 4000, 0))
	end
end,

UpdateTransmitState = function(self)
	return TRANSMIT_PVS
end}, "bantrain")
