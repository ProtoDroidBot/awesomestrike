include("obj_player_extend.lua")
include("obj_entity_extend.lua")

GM.Name = "Awesome Strike: Source"
GM.Author = "JetBoom"
GM.Email = "jetboom@yahoo.com"
GM.Website = "http://www.noxiousnet.com"

CreateConVar("as_roundtime", "240", true, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("as_intermissiontime", "5", true, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("as_votetime", "30", true, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("as_freezetime", "4", true, FCVAR_ARCHIVE)
CreateConVar("as_numrounds", "15", true, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("as_buytime", "30", true, {FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("as_autobalancethresh", "2", FCVAR_ARCHIVE)

HumanGibs = {"models/gibs/HGIBS.mdl",
"models/gibs/HGIBS_spine.mdl",
"models/gibs/HGIBS_rib.mdl",
"models/gibs/HGIBS_scapula.mdl",
"models/gibs/antlion_gib_medium_2.mdl",
"models/gibs/Antlion_gib_Large_1.mdl",
"models/gibs/Strider_Gib4.mdl"
}

GM.roundstart = GetConVarNumber("as_intermissiontime")
GM.endroundtime = GetConVarNumber("as_roundtime") + GetConVarNumber("as_freezetime")
SetGlobalFloat("endroundtime", GM.endroundtime)

TEAM_CT = 2
TEAM_T = 3

team.SetUp(TEAM_CT, "Counter-terrorists", Color(50, 90, 255, 255))
team.SetUp(TEAM_T, "Terrorists", Color(255, 30, 30, 255))
team.SetUp(TEAM_SPECTATOR, "Spectators", Color(160, 160, 160, 255))

GM.Skins = {}
GM.Skins[TEAM_CT] = {}
GM.Skins[TEAM_CT][Model("models/player/police.mdl")] = "Civil Protection"
GM.Skins[TEAM_CT][Model("models/player/combine_soldier_prisonguard.mdl")] = "Prison Guard"
GM.Skins[TEAM_CT][Model("models/player/combine_soldier.mdl")] = "Soldier"
GM.Skins[TEAM_CT][Model("models/player/combine_super_soldier.mdl")] = "Elite Crew"
GM.Skins[TEAM_CT][Model("models/player/soldier_stripped.mdl")] = "Weight Lifter"
GM.Skins[TEAM_CT][Model("models/player/barney.mdl")] = "Barney"

GM.Skins[TEAM_T] = {}
GM.Skins[TEAM_T][Model("models/player/monk.mdl")] = "Gregori"
GM.Skins[TEAM_T][Model("models/player/odessa.mdl")] = "That Rocket Guy"
GM.Skins[TEAM_T][Model("models/player/Group01/male_07.mdl")] = "Frohman"
GM.Skins[TEAM_T][Model("models/player/classic.mdl")] = "Zombie"
GM.Skins[TEAM_T][Model("models/player/alyx.mdl")] = "Alyx"
GM.Skins[TEAM_T][Model("models/player/Group01/Male_01.mdl")] = "Some Guy"

GM.Buyables = {
{Name = "Crossfire", Type = 0, Cost = 75, SWEP = "weapon_as_crossfire", Description = "Shotgun that fires in an alternating cross pattern.", Slot = 3},
{Name = "M4 Carbine", Type = 0, Cost = 75, SWEP = "weapon_as_m4", Description = "It shoots bullets accurately.", Slot = 8, Team = TEAM_CT},
{Name = "AK-47", Type = 0, Cost = 75, SWEP = "weapon_as_ak47", Description = "Alah akbar.", Slot = 9, Team = TEAM_T},
{Name = "Uzi", Type = 0, Cost = 75, SWEP = "weapon_as_uzi", Description = "It's capacity and rate of fire are high.", Slot = 15},
{Name = "Minigun", Type = 0, Cost = 75, SWEP = "weapon_as_minigun", Description = "It's capacity and rate of fire are very high.", Slot = 16},
{Name = "Melon Launcher", Type = 0, Cost = 75, SWEP = "weapon_as_melonlauncher", Description = "Melon Launcher. What else do you need to know?", Slot = 12},
{Name = "Awesome Rifle", Type = 0, Cost = 75, SWEP = "weapon_as_awesomerifle", Description = "Take over your bullet's path with your mind!", Slot = 19},
{Name = "Submachine Gun", Type = 0, Cost = 75, SWEP = "weapon_as_smg", Description = "Sacrifices speed for accuracy.", Slot = 20},

{Name = "Dinky Gun", Cost = 5, Type = 1, SWEP = "weapon_as_dinkygun", Description = "Not so dinky.", Slot = 1},
{Name = "Desert Eagle", Cost = 50, Type = 1, SWEP = "weapon_as_deagle", Description = "Blows people's heads apart.", Slot = 5},
{Name = "Grapple Beam", Type = 1, Cost = 30, SWEP = "weapon_as_grapplebeam", Description = "Allows you to grapple on to anything solid and reel yourself in.", Slot = 18},

{Name = "Knife", Cost = 5, Type = 2, SWEP = "weapon_as_knife", Description = "Capable of instantly killing people in the back.", Slot = 2},
{Name = "Berserker Sword", Cost = 50, Type = 2, SWEP = "weapon_as_berserkersword", Description = "Thrust, parry, counter.", Slot = 6},
{Name = "Barrel", Type = 2, Cost = 20, SWEP = "weapon_as_barrel", Description = "An explosive barrel.", Slot = 10},
{Name = "Seizure Grenade", Type = 2, Cost = 20, SWEP = "weapon_as_seizuregrenade", Description = "Send the people you love a seizure today!", Slot = 11},
{Name = "Concussion Grenade", Type = 2, Cost = 20, SWEP = "weapon_as_concussiongrenade", Description = "Anyone in the blast gets blown to next Tuesday.", Slot = 13},
{Name = "Force Shield", Type = 2, Cost = 25, SWEP = "weapon_as_forceshield", Description = "Deflect bullets and melee!", Slot = 14},
{Name = "Med-Ray", Type = 2, Cost = 30, SWEP = "weapon_as_medray", Description = "Allows you to heal teammates, even at a range!", Slot = 17},
{Name = "Remote Detonation Pack", Type = 2, Cost = 75, SWEP = "weapon_as_remotedet", Description = "Plant a remote detonation pack and detonate it when you want to!", Slot = 21}
}

DEFAULT_CT_SKIN = "models/player/police.mdl"
DEFAULT_T_SKIN = "models/player/monk.mdl"

function GM:PlayerShouldTakeDamage(pl, attacker)
	local owner = attacker:GetOwner()
	if owner:IsValid() then attacker = owner end

	return pl:GetMoveType() ~= MOVETYPE_OBSERVER and (pl == attacker or not attacker:IsPlayer() or attacker:Team() ~= pl:Team())
end

function GM:Move(pl, move)
	local ct = CurTime()

	if pl:Alive() then
		if pl.GrappleBeam and pl.GrappleBeam:IsValid() then
			if SERVER then
				pl:SetGroundEntity(NULL)
			end
			if pl.GrappleBeam:GetSkin() == 1 then
				--move:SetVelocity(move:GetVelocity() + FrameTime() * 1800 * (pl.GrappleBeam:GetPos() - pl:GetShootPos()):Normalize())
				move:SetVelocity(800 * (pl.GrappleBeam:GetPos() - pl:GetPos()):Normalize())
			else
				move:SetVelocity(Vector(0,0,0))
			end
		end

		if pl.DashDodgingLeft and pl.DashDodgingLeft.DieTime then
			local delta = pl.DashDodgingLeft.DieTime - CurTime()
			if 0 < delta then
				if delta < 0.06 then
					local vel = -2500 * delta * pl:GetRight()
					vel.z = math.max(move:GetVelocity().z, -800)
					move:SetVelocity(vel)
				else
					local vel = -500 * pl:GetRight()
					--if delta < 0.45 then
						vel.z = math.max(move:GetVelocity().z, -800)
					--end
					move:SetVelocity(vel)
				end
			end
		elseif pl.DashDodgingRight and pl.DashDodgingRight.DieTime then
			local delta = pl.DashDodgingRight.DieTime - CurTime()
			if 0 < delta then
				if delta < 0.06 then
					local vel = 2500 * delta * pl:GetRight()
					vel.z = math.max(move:GetVelocity().z, -800)
					move:SetVelocity(vel)
				else
					local vel = 500 * pl:GetRight()
					--if delta < 0.45 then
						vel.z = math.max(move:GetVelocity().z, -800)
					--end
					move:SetVelocity(vel)
				end
			end
		elseif pl.BJAStart or pl.WallJumping then
			move:SetVelocity(Vector(0,0,0))
			return true
		elseif pl.BJAEnd then
			move:SetVelocity(pl:GetForward() * 800 + Vector(0,0,-600))
		elseif pl.BerserkerCharge and pl.BerserkerCharge.StartCharge <= ct then
			local forward = pl:GetForward()
			local delta = pl.BerserkerCharge.EndCharge - ct
			if 0 < delta then
				if delta <= 0.15 then
					move:SetSideSpeed(0)
					move:SetForwardSpeed(delta * 8500)
					local vBVel = delta * 8500 * forward
					vBVel.z = move:GetVelocity().z
					move:SetVelocity(vBVel)
				else
					local vBVel = forward * 850
					vBVel.z = move:GetVelocity().z
					move:SetVelocity(vBVel)
					move:SetSideSpeed(0)
					move:SetForwardSpeed(850)
				end
			end
		elseif pl.Sprinting then
			move:SetSideSpeed(0)
			move:SetForwardSpeed(pl:GetMaxSpeed())
		else
			local wep = pl:GetActiveWeapon()
			--if wep:IsValid() and wep.IsBusy and wep:IsBusy() then
			if wep:IsValid() and wep.IsReloading then
				move:SetSideSpeed(move:GetSideSpeed() * 0.7)
				move:SetForwardSpeed(move:GetForwardSpeed() * 0.7)
			end
		end
	end
end

function GM:OnPlayerHitGround(pl, inwater, hitfloater, fallspeed)
	if CurTime() ~= pl.LastHitGround then
		pl.LastHitGround = CurTime()

		local effectdata = EffectData()
			effectdata:SetEntity(pl)
			effectdata:SetOrigin(pl:EyePos())
		util.Effect("jumpland", effectdata)
	end
end

function GM:SetPlayerSpeed(pl, walk)
	pl:SetWalkSpeed(walk)
	pl:SetRunSpeed(walk)
	pl:SetMaxSpeed(walk)
end

function GM:GetRagdollEyes(pl)
	local Ragdoll = pl:GetRagdollEntity()
	if not Ragdoll then return end

	local att = Ragdoll:GetAttachment(Ragdoll:LookupAttachment("eyes"))
	if att then
		att.Pos = att.Pos + att.Ang:Forward() * -1
		att.Ang = att.Ang

		return att.Pos, att.Ang
	end
end

function GM:ScalePlayerDamage(pl, hitgroup, dmginfo)
end

function TrueVisible(posa, posb)
	local filt = ents.FindByClass("projectile_*")
	filt = table.Add(filt, ents.FindByClass("item_*"))
	filt = table.Add(filt, ents.FindByClass("status_*"))
	filt = table.Add(filt, ents.FindByClass("prop_physics*"))
	filt = table.Add(filt, player.GetAll())

	return not util.TraceLine({start = posa, endpos = posb, filter = filt}).Hit
end

function ToMinutesSeconds(TimeInSeconds)
	local iMinutes = math.floor(TimeInSeconds / 60.0)
	return string.format("%0d:%02d", iMinutes, math.floor(TimeInSeconds - iMinutes*60))
end
