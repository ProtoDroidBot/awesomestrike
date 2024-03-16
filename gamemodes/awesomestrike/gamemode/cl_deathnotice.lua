local Color_Icon = Color(255, 50, 0, 255) 

killicon.AddFont("prop_physics", "HL2MPTypeDeath", "9", Color_Icon)
killicon.AddFont("weapon_smg1", "HL2MPTypeDeath", "/", Color_Icon)
killicon.AddFont("weapon_357", "HL2MPTypeDeath", ".", Color_Icon)
killicon.AddFont("weapon_ar2", "HL2MPTypeDeath", "2", Color_Icon)
killicon.AddFont("crossbow_bolt", "HL2MPTypeDeath", "1", Color_Icon)
killicon.AddFont("weapon_shotgun", "HL2MPTypeDeath", "0", Color_Icon)
killicon.AddFont("rpg_missile", "HL2MPTypeDeath", "3", Color_Icon)
killicon.AddFont("npc_grenade_frag", "HL2MPTypeDeath", "4", Color_Icon)
killicon.AddFont("weapon_pistol", "HL2MPTypeDeath", "-", Color_Icon)
killicon.AddFont("prop_combine_ball", "HL2MPTypeDeath", "8", Color_Icon)
killicon.AddFont("grenade_ar2", "HL2MPTypeDeath", "7", Color_Icon)
killicon.AddFont("weapon_stunstick", "HL2MPTypeDeath", "!", Color_Icon)
killicon.AddFont("weapon_slam", "HL2MPTypeDeath", "*", Color_Icon)
killicon.AddFont("weapon_crowbar", "HL2MPTypeDeath", "6", Color_Icon)

killicon.AddFont("headshot", "CSKillIcons", "D", Color_Icon)

killicon.AddFont("weapon_as_deagle", "CSKillIcons", "f", Color_Icon)
killicon.AddFont("weapon_as_dinkygun", "CSKillIcons", "a", Color_Icon)
killicon.AddFont("weapon_as_knife", "CSKillIcons", "j", Color_Icon)
killicon.AddFont("weapon_as_crossfire", "HL2MPTypeDeath", ".", Color_Icon)
killicon.AddFont("weapon_as_uzi", "CSKillIcons", "l", Color_Icon)
killicon.AddFont("weapon_zs_m4", "CSKillIcons", "w", Color_Icon)
killicon.AddFont("weapon_zs_ak47", "CSKillIcons", "b", Color_Icon)
killicon.AddFont("weapon_zs_awesomerifle", "CSKillIcons", "r", Color_Icon)
killicon.AddFont("weapon_zs_minigun", "CSKillIcons", "z", Color_Icon)

usermessage.Hook("PlayerKilledByPlayer", function(message)
	local victim = message:ReadEntity()
	local inflictor = message:ReadString()
	local attacker = message:ReadEntity()
	local headshot = message:ReadBool()

	if victim:IsValid() then 
		if attacker:IsValid() then
			if victim == MySelf then
				GAMEMODE:Died(attacker)
			end
			GAMEMODE:AddDeathNotice(attacker:Name(), attacker:Team(), inflictor, victim:Name(), victim:Team(), headshot)
			print(attacker:Name().." killed "..victim:Name().." with "..inflictor)
		elseif victim == MySelf then
			GAMEMODE:Died()
		end
	end
end)

usermessage.Hook("PlayerKilledSelf", function(message)
	local victim = message:ReadEntity()
	local inflictor = message:ReadString()

	if victim:IsValid() then
		if victim == MySelf then
			GAMEMODE:Died()
		end
		GAMEMODE:AddDeathNotice(nil, 0, "suicide", victim:Name(), victim:Team(), inflictor)
		print(victim:Name().." killed themselves with "..inflictor)
	end
end)

usermessage.Hook("PlayerKilled", function(message)
	local victim = message:ReadEntity()
	local inflictor = message:ReadString()
	local attacker = "#" .. message:ReadString()

	if victim:IsValid() then
		if victim == MySelf then
			GAMEMODE:Died()
		end
		GAMEMODE:AddDeathNotice(attacker, -1, inflictor, victim:Name(), victim:Team())
		print(victim:Name().." was killed by "..inflictor)
	end
end)

usermessage.Hook("PlayerKilledNPC", function(message)
	local victim = "#"..message:ReadString()
	local inflictor = message:ReadString()
	local attacker = message:ReadEntity()

	if attacker:IsValid() then
		GAMEMODE:AddDeathNotice(attacker:Name(), attacker:Team(), inflictor, victim, -1)
	end
end)

usermessage.Hook("NPCKilledNPC", function(message)
	local victim = "#"..message:ReadString()
	local inflictor = message:ReadString()
	local attacker = "#"..message:ReadString()

	GAMEMODE:AddDeathNotice(attacker, -1, inflictor, victim, -1)
end)

local Deaths = {}

function GM:AddDeathNotice(Attacker, team1, Inflictor, Victim, team2, headshot)
	local Death = {}
	Death.victim = Victim
	Death.attacker = Attacker
	Death.time = CurTime()

	Death.left = Attacker
	Death.right = Victim
	Death.icon = Inflictor

	if team1 == -1 then Death.color1 = table.Copy(NPC_Color)
	else Death.color1 = table.Copy(team.GetColor(team1)) end

	if team2 == -1 then Death.color2 = table.Copy(NPC_Color)
	else Death.color2 = table.Copy(team.GetColor(team2)) end

	if Death.left == Death.right then
		Death.left = nil
		Death.icon = "suicide"
	end

	Death.headshot = headshot

	table.insert(Deaths, Death)
end

local function DrawDeath(x, y, death, hud_deathnotice_time)
	local tw, th = killicon.GetSize(death.icon)
	local texw, texh = surface.GetTextSize(death.right)

	x = w - texw - tw - 16

	local fadeout = death.time + hud_deathnotice_time - CurTime()

	local alpha = math.Clamp(fadeout * 255, 0, 255)
	death.color1.a = alpha
	death.color2.a = alpha

	if death.headshot then
		killicon.Draw(x + tw * 0.5, y, death.icon, alpha)
		killicon.Draw(x - tw * 0.5, y, "headshot", alpha)
	else
		killicon.Draw(x, y, death.icon, alpha)
	end

	if death.left then
		draw.DrawText(death.left, "cstrike24", x - tw * 0.6 - 16, y, death.color1, TEXT_ALIGN_RIGHT)
	end

	draw.DrawText(death.right, "cstrike24", x + tw * 0.6 + 16, y, death.color2, TEXT_ALIGN_LEFT)

	return y + th * 0.70
end

local __hud_deathnotice_time = CreateConVar("hud_deathnotice_time", "6", FCVAR_REPLICATED)
function GM:DrawDeathNotice(x, y)
	local hud_deathnotice_time = __hud_deathnotice_time:GetFloat()

	x = x * w
	y = y * h

	surface.SetFont("cstrike24")

	local done = true
	for k, Death in pairs(Deaths) do
		if Death.time + hud_deathnotice_time > CurTime() then
			done = false

			if Death.lerp then
				x = x * 0.3 + Death.lerp.x * 0.7
				y = y * 0.3 + Death.lerp.y * 0.7
			end

			Death.lerp = Death.lerp or {}
			Death.lerp.x = x
			Death.lerp.y = y

			y = DrawDeath(x, y, Death, hud_deathnotice_time)
		end
	end

	if done then
		Deaths = {}
	end
end
