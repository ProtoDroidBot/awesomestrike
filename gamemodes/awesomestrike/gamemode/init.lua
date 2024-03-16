include("global/noxiousdb.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

AddCSLuaFile("obj_player_extend.lua")
AddCSLuaFile("obj_entity_extend.lua")
AddCSLuaFile("cl_deathnotice.lua")
AddCSLuaFile("cl_targetid.lua")
AddCSLuaFile("cl_dermaskin.lua")

AddCSLuaFile("vgui/pbuymenu.lua")
AddCSLuaFile("vgui/poptions.lua")
AddCSLuaFile("vgui/pteams.lua")
AddCSLuaFile("vgui/phelp.lua")

AddCSLuaFile("cl_scoreboard.lua")

include("shared.lua")

if file.Exists("../gamemodes/awesomestrike/gamemode/maps/"..game.GetMap()..".lua") then
	include("maps/"..game.GetMap()..".lua")
end

gmod.BroadcastLua = gmod.BroadcastLua or function(lua)
	for _, pl in pairs(player.GetAll()) do
		pl:SendLua(lua)
	end
end

function GM:Initialize()
	timer.Destroy("HostnameThink")

	RunConsoleCommand("mp_flashlight", 1)
	RunConsoleCommand("sv_gravity", 800)

	resource.AddFile("materials/killicon/env_explosion_killicon.vtf")
	resource.AddFile("materials/killicon/env_explosion_killicon.vmt")
	resource.AddFile("materials/killicon/env_fire_killicon.vtf")
	resource.AddFile("materials/killicon/env_fire_killicon.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray1.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray2.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray3.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray4.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray5.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray6.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray7.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray8.vmt")
	--[[resource.AddFile("materials/awesomestrike/healthbar.vmt")
	resource.AddFile("materials/awesomestrike/healthbar.vtf")]]
	resource.AddFile("sound/nox/stunon.wav")
	resource.AddFile("sound/nox/stunoff.wav")
	resource.AddFile("sound/sprin.wav")

	for _, filename in pairs(file.Find("../materials/mixerman3d/weapons/*.*")) do
		resource.AddFile("materials/mixerman3d/weapons/"..filename)
	end
	for _, filename in pairs(file.Find("../models/mixerman3d/weapons/*.*")) do
		resource.AddFile("models/mixerman3d/weapons/"..filename)
	end
	for _, filename in pairs(file.Find("../models/peanut/*.*")) do
		resource.AddFile("models/peanut/"..filename)
	end
	for _, filename in pairs(file.Find("../materials/peanut/*.*")) do
		resource.AddFile("materials/peanut/"..filename)
	end
end

function GM:PlayerDeathThink(pl)
	if pl.StartSpectating and pl.StartSpectating <= CurTime() then
		pl.StartSpectating = nil
		pl:SetHealth(100)
		pl:Spectate(OBS_MODE_ROAMING)
	elseif pl.NextRespawn and pl.NextRespawn <= CurTime() and pl:KeyDown(IN_ATTACK) then
		pl:Spawn()
	end
end

function GM:OnDamagedByExplosion(pl, dmginfo)
	--[[if 20 < dmginfo:GetDamage() then
		pl:GiveStatus("firedamage", dmg * 0.1).Attacker = dmginfo:GetAttacker()
	end]]
end

function GM:InitPostEntity()
	for _, ent in pairs(ents.FindByClass("func_breakable_surf")) do ent:Remove() end

	MapEditorEntities = {}
	file.CreateDir("asmaps")
	if file.Exists("asmaps/"..game.GetMap()..".txt") then
		for _, enttab in pairs(Deserialize(file.Read("asmaps/"..game.GetMap()..".txt"))) do
			local ent = ents.Create(string.lower(enttab.Class))
			if ent:IsValid() then
				ent:SetPos(enttab.Position)
				ent:SetAngles(enttab.Angles)
				if enttab.KeyValues then
					for key, value in pairs(enttab.KeyValues) do
						ent[key] = value
					end
				end
				ent:Spawn()
				table.insert(MapEditorEntities, ent)
			end
		end
	end

	self.Spawns = {}
	local ctspawns = {}
	ctspawns = ents.FindByClass("info_player_counterterrorist")
	ctspawns = table.Add(ctspawns, ents.FindByClass("info_player_combine"))
	if #ctspawns == 0 then
		ctspawns = table.Add(ctspawns, ents.FindByClass("info_player_start"))
	end
	self.Spawns[TEAM_CT] = ctspawns
	local tspawns = {}
	tspawns = ents.FindByClass("info_player_terrorist")
	tspawns = table.Add(tspawns, ents.FindByClass("info_player_rebel"))
	if #tspawns == 0 then
		tspawns = table.Add(tspawns, ents.FindByClass("info_player_start"))
	end
	self.Spawns[TEAM_T] = tspawns

	self.Spawns[TEAM_SPECTATOR] = table.Copy(tspawns)
	self.Spawns[TEAM_SPECTATOR] = table.Add(self.Spawns[TEAM_SPECTATOR], ctspawns)

	for _, ent in pairs(ents.FindByClass("hostage_entity")) do
		local host = ents.Create("npc_hostage")
		if host:IsValid() then
			host:SetPos(ent:GetPos())
			host:SetAngles(ent:GetAngles())
			host:Spawn()
		end
	end

	self.NumBombTargets = #ents.FindByClass("func_bomb_target")
	self.NumHostages = #ents.FindByClass("hostage_entity")

	--self.CanRespawn = self.NumBombTargets == 0 and self.NumHostages == 0
	--RunConsoleCommand("sv_alltalk", 0)
	--RunConsoleCommand("sv_voiceenable", 1)
end

concommand.Add("mapeditor_add", function(sender, command, arguments)
	if not sender:IsSuperAdmin() then return end

	if not arguments[1] then return end

	local tr = sender:TraceLine(3000)
	if tr.Hit then
		local ent = ents.Create(string.lower(arguments[1]))
		if ent:IsValid() then
			ent:SetPos(tr.HitPos)
			ent:Spawn()
			table.insert(MapEditorEntities, ent)
			SaveMapEditorFile()
		end
	end
end)

concommand.Add("mapeditor_addonme", function(sender, command, arguments)
	if not sender:IsSuperAdmin() then return end

	if not arguments[1] then return end

	local ent = ents.Create(string.lower(arguments[1]))
	if ent:IsValid() then
		ent:SetPos(sender:EyePos())
		ent:Spawn()
		table.insert(MapEditorEntities, ent)
		SaveMapEditorFile()
	end
end)

concommand.Add("mapeditor_remove", function(sender, command, arguments)
	if not sender:IsSuperAdmin() then return end

	local tr = sender:TraceLine(3000)
	if tr.Entity and tr.Entity:IsValid() then
		for i, ent in ipairs(MapEditorEntities) do
			if ent == tr.Entity then
				table.remove(MapEditorEntities, i)
				ent:Remove()
			end
		end
		SaveMapEditorFile()
	end
end)

local function ME_Pickup(pl, ent, uid)
	if pl:IsValid() and ent:IsValid() then
		ent:SetPos(util.TraceLine({start=pl:GetShootPos(),endpos=pl:GetShootPos() + pl:GetAimVector() * 3000, filter={pl, ent}}).HitPos)
		return
	end
	timer.Destroy(uid.."mapeditorpickup")
	SaveMapEditorFile()
end

concommand.Add("mapeditor_pickup", function(sender, command, arguments)
	if not sender:IsSuperAdmin() then return end

	local tr = sender:TraceLine(3000)
	if tr.Entity and tr.Entity:IsValid() then
		for i, ent in ipairs(MapEditorEntities) do
			if ent == tr.Entity then
				timer.Create(sender:UniqueID().."mapeditorpickup", 0.25, 0, ME_Pickup, sender, ent, sender:UniqueID())
			end
		end
	end
end)

concommand.Add("mapeditor_drop", function(sender, command, arguments)
	if not sender:IsSuperAdmin() then return end

	timer.Destroy(sender:UniqueID().."mapeditorpickup")
	SaveMapEditorFile()
end)

function SaveMapEditorFile()
	local sav = {}
	for _, ent in pairs(MapEditorEntities) do
		if ent:IsValid() then
			local enttab = {}
			enttab.Class = ent:GetClass()
			enttab.Position = ent:GetPos()
			enttab.Angles = ent:GetAngles()
			if ent.KeyValues then
				enttab.KeyValues = {}
				for _, key in pairs(ent.KeyValues) do
					enttab.KeyValues[key] = ent[key]
				end
			end
			table.insert(sav, enttab)
		end
	end
	file.Write("asmaps/"..game.GetMap()..".txt", Serialize(sav))
end

function GM:PlayerSwitchFlashlight(pl, onoff)
	return pl:Alive()
end

local PhysicalBullets = {}

function GetPhysicalBullets()
	return PhysicalBullets
end

function PhysicalBullet(attacker, inflictor, start, heading, speed, damage, callback, mask)
	local tab = {UnFinished = true, Attacker = attacker, Inflictor = inflictor, StartTime = CurTime(), StartPos = start, LastPosition = start, Heading = heading, Speed = speed, Damage = damage, Callback = callback, Filter = {attacker, inflictor}, Mask = mask or MASK_SHOT}
	table.insert(PhysicalBullets, tab)

	local effectdata = EffectData()
		effectdata:SetEntity(attacker)
		effectdata:SetOrigin(util.TraceLine({start = start, endpos = start + heading * 60000, filter = {attacker, inflictor}, mask = MASK_SHOT}).HitPos)
		effectdata:SetStart(start)
		effectdata:SetNormal(heading)
		effectdata:SetMagnitude(speed)
		effectdata:SetScale(damage)
	util.Effect("physicalbullet", effectdata, true, true)

	return tab
end

function CheckAllPhysicalBullets(ct)
	local finished = true
	for _, bultab in pairs(PhysicalBullets) do
		if bultab.UnFinished then
			local vStart = bultab.LastPosition
			local vEnd = bultab.StartPos + (ct - bultab.StartTime) * bultab.Speed * bultab.Heading
			local tr = util.TraceLine({start = vStart, endpos = vEnd, filter = bultab.Filter, mask = bultab.Mask})
			if tr.Hit then
				bultab.UnFinished = false

				if bultab.Inflictor:IsValid() then
					bultab.Inflictor:FireBullets({Num = 1, Src = vStart, Dir = bultab.Heading, Spread = Vector(0,0,0), Tracer = 0, Force = bultab.Damage * 0.1, Damage = bultab.Damage, Callback = bultab.Callback})
				elseif bultab.Attacker:IsValid() then
					bultab.Attacker:FireBullets({Num = 1, Src = vStart, Dir = bultab.Heading, Spread = Vector(0,0,0), Tracer = 0, Force = bultab.Damage * 0.1, Damage = bultab.Damage, Callback = bultab.Callback})
				end
			else
				bultab.LastPosition = vEnd
				finished = false
			end
		end
	end

	if finished and 0 < #PhysicalBullets then PhysicalBullets = {} end
end

function GM:SetupPlayerVisibility(pl)
	if pl.AwesomeBullet and pl.AwesomeBullet:IsValid() then
		AddOriginToPVS(pl.AwesomeBullet:GetPos())
	end
end

local nextcheck = 0
function GM:Think()
	local ct = CurTime()

	--CheckAllPhysicalBullets(ct)

	if nextcheck < ct then
		nextcheck = ct + 5

		self:CheckRoundStatus()
	end

	if self.roundend and self.roundstart <= ct then
		self.roundend = false
		self.HostageBeingRescuedWarning = nil
		SetGlobalBool("roundend", false)
		self.roundstart = CurTime() + GetConVarNumber("as_freezetime")
		SetGlobalFloat("roundstart", self.roundstart)

		for _, ent in pairs(ents.FindByClass("planted_bomb")) do ent:Remove() end
		for _, ent in pairs(ents.FindByClass("npc_hostage")) do ent:Remove() end
		for _, ent in pairs(ents.FindByClass("projectile_*")) do ent:Remove() end
		for _, ent in pairs(ents.FindByClass("weapon_as_remotedet")) do
			if ent.Planted or ent.Plant then
				ent.Planted = nil
				ent.Plant = nil
				ent:SetNetworkedBool("cantswap", false)
			end
		end
		for _, ent in pairs(ents.FindByClass("planted_remotedet")) do ent:Remove() end
		for _, ent in pairs(ents.FindByModel("models/props_c17/oildrum001_explosive.mdl")) do
			if ent.IsThrownBarrel then
				ent:Remove()
			end
		end

		for _, ent in pairs(ents.GetAll()) do
			if ent:IsValid() and ent:IsOnFire() then
				ent:Extinguish()
			end
		end

		for _, ent in pairs(ents.FindByClass("weapon_*")) do
			if not ent:GetOwner():IsValid() then
				ent:Remove()
			end
		end

		for _, ent in pairs(ents.FindByClass("hostage_entity")) do
			local host = ents.Create("npc_hostage")
			if host:IsValid() then
				host:SetPos(ent:GetPos())
				host:SetAngles(ent:GetAngles())
				host:Spawn()
			end
		end

		local ts = team.GetPlayers(TEAM_T)
		local tamount = #ts
		local cts = team.GetPlayers(TEAM_CT)
		local ctamount = #cts
		if tamount < ctamount - 1 then
			for i=1, ctamount - tamount - 1 do
				cts = team.GetPlayers(TEAM_CT)
				cts[math.random(1, #cts)]:SetTeam(TEAM_T)
			end
			PrintMessage(HUD_PRINTTALK, "Teams have been auto-balanced.")
		elseif ctamount < tamount - 1 then
			for i=1, tamount - ctamount - 1 do
				ts = team.GetPlayers(TEAM_T)
				ts[math.random(1, #ts)]:SetTeam(TEAM_CT)
			end
			PrintMessage(HUD_PRINTTALK, "Teams have been auto-balanced.")
		end

		for _, pl in pairs(player.GetAll()) do
			pl.StartSpectating = nil
			if pl:Team() == TEAM_T or pl:Team() == TEAM_CT then
				local wasalive = pl:Alive()
				pl:Spawn()
				if not wasalive then
					pl:Give("weapon_as_dinkygun")
					pl:Give("weapon_as_knife")
				end
				pl:Freeze(true)
			end
		end

		for _, ent in pairs(ents.FindByClass("weapon_*")) do
			if ent.SetClip1 and ent.Primary then
				ent:SetClip1(ent.Primary.ClipSize)
			end
			if ent.SetClip2 and ent.Secondary then
				ent:SetClip2(ent.Secondary.ClipSize)
			end
		end

		if 0 < #ents.FindByClass("func_bomb_target") then
			local ran = team.GetPlayers(TEAM_T)
			if 0 < #ran then
				local randomguy = ran[math.random(1, #ran)]
				randomguy:Give("weapon_as_bomb")
				randomguy:PrintMessage(HUD_PRINTCENTER, "You have the bomb. Plant it at a bomb site!")
			end
		end
	elseif not self.roundend and self.roundstart <= ct then
		self.endroundtime = CurTime() + GetConVarNumber("as_roundtime")
		SetGlobalFloat("endroundtime", self.endroundtime)
		self.roundstart = CurTime() + 9999999

		local ran = math.random(1, 3)
		for _, pl in pairs(player.GetAll()) do
			if pl:Alive() and (pl:Team() == TEAM_T or pl:Team() == TEAM_CT) then
				pl:Freeze(false)
				if ran == 1 then
					pl:SendLua("surface.PlaySound(\"radio/letsgo.wav\")")
				elseif ran == 2 then
					pl:SendLua("surface.PlaySound(\"radio/locknload.wav\")")
				else
					pl:SendLua("surface.PlaySound(\"radio/moveout.wav\")")
				end
			end
		end
	elseif self.endroundtime <= ct then
		self.NumBombTargets = #ents.FindByClass("func_bomb_target")
		if 0 < self.NumBombTargets then
			self:EndRound(TEAM_CT, false, 1)
		elseif 0 < self.NumHostages then
			if 0 < #ents.FindByClass("npc_hostage") then
				self:EndRound(TEAM_T, false, 1)
			end
		else -- FY map
			local numts = team.NumPlayers(TEAM_T)
			local numcts = team.NumPlayers(TEAM_CT)
			if numts == numcts then
				self:EndRound(0, false, 2)
			elseif numts < numcts then
				self:EndRound(TEAM_CT, false, 2)
			else
				self:EndRound(TEAM_T, false, 2)
			end
		end
	end
end

function GM:ShutDown()
end

function GM:CanPlayerSuicide(pl)
	return pl:Alive()
end

function GM:WeaponDeployed(pl, wep)
	RestoreSpeed(pl, wep.WalkSpeed)
end

function GM:PlayerInitialSpawn(pl)
	pl.LastAttacker = NULL
	pl.LastAttacked = 0
	pl.LastOnGround = true
	pl.NextDashDodge = 0
	pl.NextWallJump = 0
	pl.LastForward = 0

	pl:SetTeam(TEAM_SPECTATOR)
	pl:Spectate(OBS_MODE_ROAMING)
	pl:SetCanZoom(false)
	pl:SetJumpPower(320)
	pl:SetCrouchedWalkSpeed(0.44)
	pl.JoinTime = CurTime()

	--[[local onred = 0
	local ongreen = 0
	for _, pl in pairs(player.GetAll()) do
		local plteam = pl:Team()
		if plteam == TEAM_RED then
			onred = onred + 1
		elseif plteam == TEAM_GREEN then
			ongreen = ongreen + 1
		end
	end

	if onred == ongreen then
		math.randomseed(SysTime())
		pl:SetTeam(math.random(TEAM_RED, TEAM_GREEN))
	elseif onred < ongreen then
		pl:SetTeam(TEAM_RED)
	else
		pl:SetTeam(TEAM_GREEN)
	end]]
end

concommand.Add("changeteam", function(sender, command, arguments)
	if sender:IsValid() then
		if CurTime() < (sender.NextTeamChange or 0) then return end

		local teamid = tonumber(arguments[1]) or 0
		local mdl = arguments[2] or ""

		if GAMEMODE.CanRespawn and sender:Team() ~= TEAM_SPECTATOR then
			sender:PrintMessage(HUD_PRINTCENTER, "Changing teams is not allowed in FightYard.")
			return
		end

		if sender:Team() ~= teamid then
			if teamid == TEAM_SPECTATOR then
				sender.NextTeamChange = CurTime() + 5
				if sender:Alive() then
					sender:Kill()
				end
				sender:SetTeam(teamid)
				GAMEMODE:CheckRoundStatus()
			elseif teamid == TEAM_T then
				local numts = team.NumPlayers(TEAM_T)
				local numcts = team.NumPlayers(TEAM_CT)
				if (numcts == 0 or numts < numcts + GetConVarNumber("as_autobalancethresh")) and not (numcts == 0 and 0 < numts) then
					sender.NextTeamChange = CurTime() + 5
					sender:StripWeapons()
					if sender:Alive() then
						sender:Kill()
					end
					sender:SetTeam(TEAM_T)
					for m in pairs(GAMEMODE.Skins[TEAM_T]) do
						if m == mdl then
							sender.PreferedTSkin = mdl
							break
						end
					end
					GAMEMODE:CheckRoundStatus()
				else
					sender:PrintMessage(HUD_PRINTTALK, "That would make the teams unfair!")
					GAMEMODE:ShowTeam(sender)
					sender.NextTeamChange = CurTime() + 0.2
				end
			elseif teamid == TEAM_CT then
				local numts = team.NumPlayers(TEAM_T)
				local numcts = team.NumPlayers(TEAM_CT)
				if (numts == 0 or numcts < numts + GetConVarNumber("as_autobalancethresh")) and not (numts == 0 and 0 < numcts) then
					sender.NextTeamChange = CurTime() + 5
					sender:StripWeapons()
					if sender:Alive() then
						sender:Kill()
					end
					sender:SetTeam(TEAM_CT)
					for m in pairs(GAMEMODE.Skins[TEAM_CT]) do
						if m == mdl then
							sender.PreferedCTSkin = mdl
							break
						end
					end
					GAMEMODE:CheckRoundStatus()
				else
					sender:PrintMessage(HUD_PRINTTALK, "That would make the teams unfair!")
					GAMEMODE:ShowTeam(sender)
					sender.NextTeamChange = CurTime() + 0.2
				end
			end
		end
	end
end)

function GM:PlayerLoadout()
end

function GM:PlayerSpawn(pl)
	local plteam = pl:Team()
	if plteam == TEAM_SPECTATOR then
		pl:Spectate(OBS_MODE_ROAMING)
		return
	end

	pl:UnSpectate()

	pl.LastAttacker = NULL
	pl.LastAttacked = 0

	pl.NumBuysThisRound = 0

	if pl.PreDeathWeapons then
		if 0 < #pl.PreDeathWeapons then
			for _, wepname in pairs(pl.PreDeathWeapons) do
				pl:Give(wepname)
			end
			if pl.PreDeathWeapon then
				pl:SelectWeapon(pl.PreDeathWeapon)
			end
		else
			pl:Give("weapon_as_knife")
			pl:Give("weapon_as_dinkygun")
		end
	else
		pl:Give("weapon_as_knife")
		pl:Give("weapon_as_dinkygun")
	end

	self:SetPlayerSpeed(pl, 200, 100)
	pl:ShouldDropWeapon(not self.CanRespawn)

	if pl:Team() == TEAM_CT then
		if pl.PreferedCTSkin then
			pl:SetModel(pl.PreferedCTSkin)
		else
			pl:SetModel(DEFAULT_CT_SKIN)
		end
	elseif pl.PreferedTSkin then
		pl:SetModel(pl.PreferedTSkin)
	else
		pl:SetModel(DEFAULT_T_SKIN)
	end
end

function GM:PlayerReady(pl)
	if pl:IsValid() then
		self:ShowTeam(pl)
	end
end

function GM:KeyPress(pl, key)
	if key == IN_FORWARD and pl:Alive() and not pl:IsFrozen() and not pl.Sprinting and not pl:IsBusy() and not pl:Crouching() and not pl.DashDodging and not pl.BJAStart and not pl.BJAEnd and not pl.BerserkerCharge and not pl.WallJumping then
		local clok = os.clock()
		if clok < pl.LastForward + 0.3 then
			pl.LastForward = 0
			pl:RemoveStatus("dashdodge*", false, true)
			pl:GiveStatus("sprint")
		else
			pl.LastForward = clok
		end
	elseif key == IN_JUMP and pl:Alive() and not pl.BJAStart and not pl.BJAEnd and not pl.BerserkerCharge then
		if pl.Sprinting then
			pl:RemoveStatus("sprint", false, true)
		end

		if not pl:IsFrozen() and not pl:IsOnGround() and pl.NextWallJump <= CurTime() and not pl.WallJumping and util.TraceLine({start = pl:GetPos(), endpos = pl:GetPos() + pl:GetForward() * 36, mask = MASK_PLAYERSOLID, filter = pl}).Hit then
			pl.NextWallJump = CurTime() + 0.2
			pl:RemoveStatus("dashdodge*", false, true)
			pl:RemoveStatus("sprint", false, true)
			local getpos = pl:GetPos()
			local forward = pl:GetForward()
			local tr = util.TraceLine({start = getpos, endpos = getpos + forward * 36, mask = MASK_SOLID, filter = pl})
			local status = pl:GiveStatus("walljump", 0.1)
			status.HitNormal = (2 * tr.HitNormal * tr.HitNormal:Dot(forward * -1) + forward):Normalize()
			status.Forward = forward
		end
	end
end

concommand.Add("getup", function(pl, command, arguments)
	if pl:IsValid() and pl:Alive() and pl.KnockedDown and not pl.Stunned then
		local ct = CurTime()
		local knockedent = pl.KnockedDown
		if knockedent:IsValid() and ct < knockedent.DieTime - 0.5 then
			knockedent.DieTime = ct + 0.5
			knockedent:SetNetworkedFloat("endtime", knockedent.DieTime)
			pl:EmitSound("physics/nearmiss/whoosh_huge2.wav", 75, math.Rand(235, 255))
		end
	end
end)

function GM:KeyRelease(pl, key)
	if key == IN_FORWARD and pl.Sprinting then
		pl:RemoveStatus("sprint", false, true)
	end
end

function GM:ShowTeam(pl)
	pl:SendLua("MakepTeams()")
end

function GM:ShowHelp(pl)
	pl:SendLua("MakepHelp()")
end

function GM:ShowSpare1(pl)
	if pl:Alive() then
		if pl.CanBuy then
			if GetConVarNumber("as_buytime") == 0 or CurTime() < self.roundstart + GetConVarNumber("as_buytime") then
				pl:SendLua("MakepBuyMenu()")
			else
				pl:PrintMessage(HUD_PRINTCENTER, "You must buy your weapons within "..GetConVarNumber("as_buytime").." seconds of the round starting.")
			end
		else
			pl:PrintMessage(HUD_PRINTCENTER, "You must be in a buy zone to purchase weapons!")
		end
	end
end

function GM:ShowSpare2(pl)
	pl:SendLua("MakepOptions()")
end

function gmod.BroadcastLua(lu)
	for _, pl in pairs(player.GetAll()) do
		pl:SendLua(lu)
	end
end

GM.round = 0
function GM:EndRound(winner, nosoundormessage, reason)
	if self.roundend then return end

	for _, ent in pairs(ents.FindByClass("weapon_as_bomb")) do
		ent:Remove()
	end

	self.roundend = true
	SetGlobalBool("roundend", true)
	if not nosoundormessage then
		if winner == TEAM_T then
			if reason == 1 then
				PrintMessage(HUD_PRINTCENTER, "Counter-terrorists failed to rescue the hostages! Terrorists win!")
			elseif reason == 2 then
				PrintMessage(HUD_PRINTCENTER, "The round ended with more T's than CT's alive! Terrorists win!")
			else
				PrintMessage(HUD_PRINTCENTER, "Terrorists win!")
			end
			gmod.BroadcastLua("surface.PlaySound(\"radio/terwin.wav\")")
		elseif winner == TEAM_CT then
			if reason == 1 then
				PrintMessage(HUD_PRINTCENTER, "Terrorists failed to bomb a target! Counter-terrorists win!")
			elseif reason == 2 then
				PrintMessage(HUD_PRINTCENTER, "The round ended with more CT's than T's alive! Counter-terrorists win!")
			elseif reason == 3 then
				PrintMessage(HUD_PRINTCENTER, "All hostages have been rescued! Counter-terrorists win!")
			else
				PrintMessage(HUD_PRINTCENTER, "Counter-terrorists win!")
			end
			gmod.BroadcastLua("surface.PlaySound(\"radio/ctwin.wav\")")
		else
			if self.CanRespawn then
				local tscore = team.GetScore(TEAM_T)
				local ctscore = team.GetScore(TEAM_CT)
				if tscore < ctscore then
					PrintMessage(HUD_PRINTCENTER, "Counter-terrorists win!")
					gmod.BroadcastLua("surface.PlaySound(\"radio/ctwin.wav\")")
					winner = TEAM_CT
				elseif ctscore < tscore then
					PrintMessage(HUD_PRINTCENTER, "Terrorists win!")
					gmod.BroadcastLua("surface.PlaySound(\"radio/twin.wav\")")
					winner = TEAM_T
				else
					PrintMessage(HUD_PRINTCENTER, "Round draw!")
					gmod.BroadcastLua("surface.PlaySound(\"radio/rounddraw.wav\")")
				end

				team.SetScore(TEAM_T, 0)
				team.SetScore(TEAM_CT, 0)
			elseif reason == 2 then
				PrintMessage(HUD_PRINTCENTER, "YOU FAILED TO KILL EACHOTHER!")
				gmod.BroadcastLua("surface.PlaySound(\"radio/rounddraw.wav\")")
			else
				PrintMessage(HUD_PRINTCENTER, "Round draw!")
				gmod.BroadcastLua("surface.PlaySound(\"radio/rounddraw.wav\")")
			end
		end
	end

	local numts = team.NumPlayers(TEAM_T)
	local numcts = team.NumPlayers(TEAM_CT)

	for _, pl in pairs(player.GetAll()) do
		if pl:Team() == winner then
			if winner == TEAM_T and 0 < numcts then
				pl:AddMoney(150)
			elseif winner == TEAM_CT and 0 < numts then
				pl:AddMoney(150)
			end
		elseif winner ~= 0 and 1 < numcts and 1 < numts then
			pl:AddMoney(25)
		end
	end

	self.round = self.round + 1
	SetGlobalInt("round", self.round)

	if GetConVarNumber("as_numrounds") <= self.round then
		self:EndGame(0)
	else
		self.roundstart = CurTime() + GetConVarNumber("as_intermissiontime")
		SetGlobalFloat("roundstart", self.roundstart)

		self.endroundtime = self.roundstart + GetConVarNumber("as_freezetime") + GetConVarNumber("as_roundtime")
		SetGlobalFloat("endroundtime", self.endroundtime)
	end
end

function GM:EndGame(winner)
	if ENDGAME then return end

	NEXTMAP = CurTime() + 30
	ENDGAME = true

	hook.Add("Think", "NextMapChecker", function()
		if NEXTMAP <= CurTime() then
			game.LoadNextMap()
			hook.Remove("Think", "NextMapChecker")
		end
	end)

	timer.Simple(5, gmod.BroadcastLua, "OpenVoteMenu()")

	for _, pl in pairs(player.GetAll()) do
		pl:Freeze(true)
		pl:GodEnable()
	end

	umsg.Start("EndG")
		umsg.Short(winner)
	umsg.End()

	NDB.GlobalSave()

	hook.Add("PlayerSpawn", "FREEZENEW", function(p)
		p:Freeze(true)
		p:GodEnable()
	end)

	GAMEWINNER = winner
	hook.Add("PlayerReady", "FREEZENEW2", function(p)
		umsg.Start("EndG", p)
			umsg.Short(GAMEWINNER)
		umsg.End()
	end)
end

concommand.Add("PostPlayerInitialSpawn", function(sender, command, arguments)
	if not sender.PostPlayerInitialSpawn then
		sender.PostPlayerInitialSpawn = true

		gamemode.Call("PlayerReady", sender)
	end
end)

function GM:PlayerSelectSpawn(pl)
	local tab = self.Spawns[pl:Team()]
	local Count = #tab
	if Count == 0 then return pl end
	local ChosenSpawnPoint = tab[1]
	for i=0, 20 do
		ChosenSpawnPoint = tab[math.random(1, Count)]
		if ChosenSpawnPoint and ChosenSpawnPoint:IsValid() and ChosenSpawnPoint:IsInWorld() then
			local blocked = false
			for _, ent in pairs(ents.FindInBox(ChosenSpawnPoint:GetPos() + Vector(-16, -16, 0), ChosenSpawnPoint:GetPos() + Vector(16, 16, 72))) do
				if ent:IsPlayer() then
					blocked = true
				end
			end
			if not blocked then
				return ChosenSpawnPoint
			end
		end
	end

	return ChosenSpawnPoint
end

function GM:PlayerDeathSound(pl)
	return true
end

function GM:PlayerDeath(Victim, Inflictor, Attacker)
end

function GM:CheckRoundStatus()
	if self.CanRespawn then
		if self.round == 0 and 0 < team.NumPlayers(TEAM_T) and 0 < team.NumPlayers(TEAM_CT) then self:EndRound(0) end
		return
	end

	local tcount = 0
	local ctcount = 0
	--local speccount = 0

	local allplayers = player.GetAll()
	for _, pl in pairs(allplayers) do
		if pl:Team() == TEAM_T then
			tcount = tcount + 1
		elseif pl:Team() == TEAM_CT then
			ctcount = ctcount + 1
		--else
			--speccount = speccount + 1
		end
	end

	local newtcount = 0
	local newctcount = 0
	for _, pl in pairs(allplayers) do
		if pl:Alive() then
			if pl:Team() == TEAM_T then
				newtcount = newtcount + 1
			else
				newctcount = newctcount + 1
			end
			if 0 < newtcount and 0 < newctcount then return end
		end
	end

	if 0 < #ents.FindByClass("planted_bomb") then newtcount = newtcount + 1 end

	if newtcount == 0 and 0 < newctcount and 0 < tcount then
		self:EndRound(TEAM_CT)
	elseif newctcount == 0 and 0 < newtcount and 0 < ctcount then
		self:EndRound(TEAM_T)
	elseif newctcount == 0 and newtcount == 0 and 0 < ctcount and 0 < tcount then
		self:EndRound(0)
	end
end

function GM:PlayerDeath2(Victim, Inflictor, Attacker, washeadshot)
	if Inflictor.Inflictor and Inflictor.Inflictor:IsValid() then
		Inflictor = Inflictor.Inflictor
	elseif Inflictor == Attacker and Inflictor:IsPlayer() and Inflictor.Weapon then
		Inflictor = Inflictor.Weapon
	end

	if Attacker == Victim then
		umsg.Start("PlayerKilledSelf")
			umsg.Entity(Victim)
			umsg.String(Inflictor:GetClass())
		umsg.End()
	elseif Attacker:IsPlayer() then
		umsg.Start("PlayerKilledByPlayer")
			umsg.Entity(Victim)
			umsg.String(Inflictor:GetClass())
			umsg.Entity(Attacker)
			umsg.Bool(washeadshot)
		umsg.End()
	else
		umsg.Start("PlayerKilled")
			umsg.Entity(Victim)
			umsg.String(Inflictor:GetClass())
			umsg.String(Attacker:GetClass())
		umsg.End()
	end
end

function GM:DoPlayerDeath(pl, attacker, dmginfo)
	if pl:FlashlightIsOn() then
		pl:Flashlight(false)
	end

	if self.CanRespawn then
		local weapons = pl:GetWeapons()
		pl.PreDeathWeapons = {}
		for _, wep in pairs(pl:GetWeapons()) do
			table.insert(pl.PreDeathWeapons, wep:GetClass())
		end
		local wep = pl:GetActiveWeapon()
		if wep and wep:IsValid() then
			pl.PreDeathWeapon = wep:GetClass()
		end
		pl.NextRespawn = CurTime() + 7
	else
		pl.StartSpectating = CurTime() + 4
	end

	timer.Create("checkroundstatus", 0, 1, self.CheckRoundStatus, self)

	if pl:HasWeapon("weapon_as_bomb") then
		if not (pl:GetActiveWeapon():IsValid() and pl:GetActiveWeapon():GetClass() == "weapon_as_bomb") then
			local ent = ents.Create("weapon_as_bomb")
			ent:SetPos(pl:GetPos())
			ent:Spawn()
		end
		PrintMessage(HUD_PRINTCENTER, pl:Name().." dropped the bomb!")
	end

	if attacker.Attacker then
		attacker = attacker.Attacker
	else
		local owner = attacker:GetOwner()
		if owner:IsValid() then attacker = owner end
	end

	pl:Freeze(false)
	pl:AddDeaths(1)

	--[[if pl:Health() < -60 or dmginfo:IsExplosionDamage() then
		pl:Gib(dmginfo)
	else
		pl:SetLocalVelocity(pl:GetVelocity() * 2)
		pl:CreateRagdoll()
		pl:GetRagdollEntity():EmitSound("nox/player_death.wav", 84, math.random(90, 110))
	end]]

	--pl:SetLocalVelocity(pl:GetVelocity() * 2)
	if not pl.KnockedDown then
		pl:CreateRagdoll()
	end
	pl:RemoveAllStatus(true, true)
	pl:EmitSound("nox/player_death.wav", 85, math.random(90, 110))
	if dmginfo:IsExplosionDamage() then
		local effectdata = EffectData()
			effectdata:SetOrigin(pl:EyePos())
			effectdata:SetEntity(pl)
		util.Effect("fire_death", effectdata)
	end

	local inflictor = dmginfo:GetInflictor()
	local inflictorisself = inflictor == attacker or not inflictor:IsValid()
	if inflictorisself and pl.LastAttacker:IsValid() and CurTime() < pl.LastAttacked + 7.5 then
		attacker = pl.LastAttacker
		inflictorisself = false
	end

	if attacker:IsPlayer() then
		if attacker == pl then
			attacker:AddFrags(-1)
		else
			attacker:AddFrags(1)
			attacker:AddMoney(25)
			if self.CanRespawn then
				team.AddScore(attacker:Team(), 1)
			end
		end
	end

	local washeadshot = dmginfo:IsBulletDamage() and dmginfo:GetDamagePosition():Distance(pl:GetAttachment(pl:LookupAttachment("eyes")).Pos) <= 10
	--[[local washeadshot = false
	if dmginfo:IsBulletDamage() then
		local attach = pl:GetAttachment(1)
		washeadshot = attach and dmginfo:GetDamagePosition():Distance(attach.Pos) < 13
	end]]

	if inflictorisself then
		self:PlayerDeath2(pl, pl, pl, false)
	else
		self:PlayerDeath2(pl, inflictor, attacker, washeadshot)
	end
end

--[[concommand.Add("nox_view", function(sender, command, arguments)
	if not sender:Alive() or sender:InVehicle() or sender:Team() == TEAM_SPECTATE then return end

	local noxview = util.tobool(arguments[1])

	if noxview then
		sender:CreateCamera()
	else
		sender:DestroyCamera()
	end
end)]]

function GM:PlayerDisconnect(pl)
	pl:DestroyCamera()

	timer.Create("checkroundstatus", 0.1, 1, self.CheckRoundStatus, self)

	if pl:IsValid() and pl:HasWeapon("weapon_as_bomb") then
		local ent = ents.Create("weapon_as_bomb")
		ent:SetPos(pl:GetPos())
		ent:Spawn()
		PrintMessage(HUD_PRINTCENTER, pl:Name().." dropped the bomb!")
	end

	pl:RemoveAllStatus(true, true)
end

function GM:PlayerHurt(pl, attacker, healthremaining, damage)
end

local usesounds = file.Find("../sound/hostage/huse/*.wav")
local unusesounds = file.Find("../sound/hostage/hunuse/*.wav")

function GM:PlayerUse(pl, ent)
	if not pl:Alive() then return false end

	if ent:GetClass() == "npc_hostage" and ent.NextPlayerUse <= CurTime() then
		if pl:Team() == TEAM_T and ent.Escort and ent.Escort:IsValid() then
			ent.Escort = nil
			ent:DoStartScheduleIdle()
			ent.NextPlayerUse = CurTime() + 0.75
		elseif pl:Team() == TEAM_CT then
			if ent.Escort == pl then
				ent.Escort = nil
				ent:EmitSound("hostage/hunuse/"..unusesounds[math.random(1, #unusesounds)])
				ent:DoStartScheduleIdle()
				ent.NextPlayerUse = CurTime() + 0.75
			else
				ent.Escort = pl
				ent:EmitSound("hostage/huse/"..usesounds[math.random(1, #usesounds)])
				ent:DoStartScheduleEscort()
				ent.NextPlayerUse = CurTime() + 0.75
				if not self.HostageBeingRescuedWarning then
					self.HostageBeingRescuedWarning = true

					for _, playa in pairs(player.GetAll()) do
						if playa:Team() == TEAM_T then
							playa:SendLua("surface.PlaySound(\"radio/hostagecompromised.wav\")")
							playa:PrintMessage(HUD_PRINTCENTER, "Warning! Hostages are being rescued!")
						end
					end
				end
			end
		end
	end

	return true
end

function GM:GetFallDamage(pl, fallspeed)
	return 0
end

function GM:EntityTakeDamage(ent, inflictor, attacker, amount, dmginfo)
	if ent.SendLua then
		if dmginfo:IsBulletDamage() then
			if 10 < dmginfo:GetDamagePosition():Distance(ent:GetAttachment(ent:LookupAttachment("eyes")).Pos) then
				dmginfo:ScaleDamage(0.5)
			end
		end

		if attacker.SendLua and attacker:Team() ~= ent:Team() then
			ent.LastAttacker = attacker
			ent.LastAttacked = CurTime()
			local nearest = ent:NearestPoint(inflictor:EyePos())
			amount = math.min(100, amount)
			ent:BloodSpray(nearest, amount * 0.5, (nearest - inflictor:EyePos()):Normalize(), amount * 5)
		else
			local nearest = ent:NearestPoint(inflictor:EyePos())
			amount = math.min(100, amount)
			ent:BloodSpray(nearest, amount * 0.5, (nearest - attacker:EyePos()):Normalize(), amount * 5)
		end
	end
end

function GM:CreateEntityRagdoll(ent, ragdoll)
end

function GM:PlayerCanPickupWeapon(pl, entity)
	if entity.IsPrimary then
		for _, wep in pairs(pl:GetWeapons()) do
			if wep.IsPrimary then return false end
		end
	elseif entity.IsSecondary then
		for _, wep in pairs(pl:GetWeapons()) do
			if wep.IsSecondary then return false end
		end
	elseif entity.IsTertiary then
		for _, wep in pairs(pl:GetWeapons()) do
			if wep.IsTertiary then return false end
		end
	end
	return not (entity.TOnly and pl:Team() == TEAM_CT) and not (entity.CTOnly and pl:Team() == TEAM_T)
end

function RestoreSpeed(pl, speed)
	if not pl:IsValid() then return end

	if pl.Stunned then
		GAMEMODE:SetPlayerSpeed(pl, 1, 1)
	else
		speed = speed or 200
		if pl.Sprinting then
			GAMEMODE:SetPlayerSpeed(pl, speed + 100, speed + 100)
		else
			GAMEMODE:SetPlayerSpeed(pl, speed, math.min(speed, 100))
		end
	end
end

function IsGuardStun(owner, ent)
	return ent:IsPlayer() and (owner:IsPlayer() and owner:Team() ~= ent:Team() or not owner:IsPlayer()) and ent:GetActiveWeapon().Guarding and 1.4 < owner:GetForward():Distance(ent:GetForward())
end

function Guarded(hitter, guarder, duration)
	local wep = guarder:GetActiveWeapon()
	if wep:IsValid() and wep.Guarded then
		wep:Guarded(hitter, guarder, duration)
	end
end

concommand.Add("dropweapon", function(sender, command, arguments)
	local wep = sender:GetActiveWeapon()
	if wep:IsValid() and not wep:IsBusy() and wep:Holster() ~= false then
		sender:DropWeapon(wep)
	end
end)

concommand.Add("dashleft", function(sender, command, arguments)
	if sender:IsPlayer() and sender:Alive() and not sender:IsFrozen() and sender.NextDashDodge <= CurTime() and not sender.DashDodging and not sender.BJAStart and not sender.BJAEnd and not sender.BerserkerCharge and not sender.WallJumping and not sender.IsReloading and not sender.SilentStunned then
		if sender.Stunned then
			sender:RemoveStatus("stun", false, true)
		end
		if sender.Sprinting then
			sender:RemoveStatus("sprint", false, true)
		end
		if sender.DashingDodging then
			sender:RemoveStatus("dashdodge*", false, true)
		end

		sender.NextDashDodge = CurTime() + 0.65
		sender:GiveStatus("dashdodgeleft")
	end
end)

concommand.Add("dashright", function(sender, command, arguments)
	if sender:IsPlayer() and sender:Alive() and not sender:IsFrozen() and sender.NextDashDodge <= CurTime() and not sender.DashDodging and not sender.BJAStart and not sender.BJAEnd and not sender.BerserkerCharge and not sender.WallJumping and not sender.IsReloading and not sender.SilentStunned then
		if sender.Stunned then
			sender:RemoveStatus("stun", false, true)
		end
		if sender.Sprinting then
			sender:RemoveStatus("sprint", false, true)
		end
		if sender.DashingDodging then
			sender:RemoveStatus("dashdodge*", false, true)
		end

		sender.NextDashDodge = CurTime() + 0.65
		sender:GiveStatus("dashdodgeright")
	end
end)

concommand.Add("buyweapon", function(sender, command, arguments)
	if sender:IsPlayer() and sender:Alive() then
		if sender.CanBuy then
			if 8 <= sender.NumBuysThisRound then
				sender:PrintMessage(HUD_PRINTCENTER, "You've bought enough shit this round.")
			elseif GetConVarNumber("as_buytime") == 0 or CurTime() < GAMEMODE.roundstart + GetConVarNumber("as_buytime") then
				local wepslot = tonumber(arguments[1]) or 1
				for _, weptab in pairs(GAMEMODE.Buyables) do
					if weptab.Slot == wepslot then
						local price = math.ceil(sender:GetDiscount() * weptab.Cost)
						if sender:HasWeapon(weptab.SWEP) then
							sender:PrintMessage(HUD_PRINTCENTER, "You already have this weapon.")
						elseif sender.Money < price then
							sender:PrintMessage(HUD_PRINTCENTER, "You don't have the money to buy that!")
						elseif weptab.Team and sender:Team() ~= weptab.Team then
							sender:PrintMessage(HUD_PRINTCENTER, "You can't buy that weapon.")
						else
							for _, curwep in pairs(sender:GetWeapons()) do -- Drop current wep.
								if weptab.Type == 0 and curwep.IsPrimary or weptab.Type == 1 and curwep.IsSecondary or weptab.Type == 2 and curwep.IsTertiary then
									sender:DropWeapon(curwep)
									break
								end
							end
							sender:AddMoney(-price, true)
							sender:Give(weptab.SWEP)
							sender:SelectWeapon(weptab.SWEP)
							sender.NumBuysThisRound = sender.NumBuysThisRound + 1
						end
						break
					end
				end
			else
				sender:PrintMessage(HUD_PRINTCENTER, "You must buy your weapons within "..GetConVarNumber("as_buytime").." seconds of the round starting.")
			end
		else
			sender:PrintMessage(HUD_PRINTCENTER, "You must be in a buy zone to purchase weapons!")
		end
	end
end)

local SprintTranslate = {}
SprintTranslate[ACT_HL2MP_IDLE] = ACT_HL2MP_IDLE_GRENADE
SprintTranslate[ACT_HL2MP_WALK] = ACT_HL2MP_IDLE_GRENADE+1
SprintTranslate[ACT_HL2MP_RUN] = ACT_HL2MP_IDLE_GRENADE+2
SprintTranslate[ACT_HL2MP_IDLE_CROUCH] = ACT_HL2MP_IDLE_GRENADE+3
SprintTranslate[ACT_HL2MP_WALK_CROUCH] = ACT_HL2MP_IDLE_GRENADE+4
SprintTranslate[ACT_HL2MP_GESTURE_RANGE_ATTACK] = ACT_HL2MP_IDLE_GRENADE+5
SprintTranslate[ACT_HL2MP_GESTURE_RELOAD] = ACT_HL2MP_IDLE_GRENADE+6
SprintTranslate[ACT_HL2MP_JUMP] = ACT_HL2MP_IDLE_GRENADE+7
SprintTranslate[ACT_RANGE_ATTACK1] = ACT_HL2MP_IDLE_GRENADE+8

local AnimTranslateTable = {}
AnimTranslateTable[PLAYER_RELOAD] = ACT_HL2MP_GESTURE_RELOAD
AnimTranslateTable[PLAYER_ATTACK1] = ACT_HL2MP_GESTURE_RANGE_ATTACK

local RestartGestureTable = {}
RestartGestureTable[ACT_HL2MP_GESTURE_RANGE_ATTACK] = true
RestartGestureTable[ACT_HL2MP_GESTURE_RELOAD] = true

function GM:SetPlayerAnimation(pl, anim)
	if pl:InVehicle() then
		local seq = pl:LookupSequence("drive_jeep")
		if pl:GetSequence() ~= seq then
			pl:ResetSequence(seq)
		end
	else
		local act = ACT_HL2MP_IDLE

		if AnimTranslateTable[anim] then
			act = AnimTranslateTable[anim]
		elseif pl:IsOnGround() then
			local Speed = pl:GetVelocity():Length()
			if pl:Crouching() or pl.DashDodging then
				if 0 < Speed then
					act = ACT_HL2MP_WALK_CROUCH
				else
					act = ACT_HL2MP_IDLE_CROUCH
				end
			elseif 115 < Speed then
				act = ACT_HL2MP_RUN
			elseif 0 < Speed then
				act = ACT_HL2MP_WALK
			end
		else
			act = ACT_HL2MP_JUMP
		end

		if RestartGestureTable[act] then
			pl:RestartGesture(pl:Weapon_TranslateActivity(act))
			if act == ACT_HL2MP_GESTURE_RANGE_ATTACK then
				pl:Weapon_SetActivity(pl:Weapon_TranslateActivity(ACT_RANGE_ATTACK1), 0)
			end
		else
			
			local seq
			if pl.Sprinting then
				seq = pl:SelectWeightedSequence(SprintTranslate[act])
			else
				seq = pl:SelectWeightedSequence(pl:Weapon_TranslateActivity(act))
			end

			if seq == -1 then seq = pl:SelectWeightedSequence(ACT_HL2MP_JUMP_SLAM) end

			if pl:GetSequence() ~= seq then
				pl:ResetSequence(seq)
			end
		end
	end
end

require("guardian")
function ShouldEntitiesCollide(ent1, ent2)
	local enta = Entity(ent1)
	local entb = Entity(ent2)
	return enta:IsPlayer() and entb:IsValid() and entb:GetClass() == "status_weapon_forceshield" or entb:IsPlayer() and entb:IsValid() and enta:GetClass() == "status_weapon_forceshield"
end
