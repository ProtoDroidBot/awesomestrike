include("global/cl_noxiousdb.lua")

include("shared.lua")

include("cl_deathnotice.lua")
include("cl_targetid.lua")
include("cl_dermaskin.lua")
include("cl_scoreboard.lua")

include("vgui/pbuymenu.lua")
include("vgui/poptions.lua")
include("vgui/pteams.lua")
include("vgui/phelp.lua")

COLOR_LIMEGREEN = Color(50, 255, 50, 255)
COLOR_TEXTYELLOW = Color(255, 177, 0, 255)
COLOR_LINEYELLOW = Color(95, 56, 0, 255)
COLOR_RED = Color(255, 0, 0, 255)

dlightcounter = 5000

if not MySelf then
	MySelf = NULL
end
hook.Add("Think", "GetLocal", function()
	MySelf = LocalPlayer()
	if MySelf:IsValid() then
		if GAMEMODE.HookGetLocal then
			GAMEMODE:HookGetLocal(MySelf)
		end
		MySelf.Money = MySelf.Money or 0
		MySelf.MemberLevel = MySelf.MemberLevel or MEMBER_NONE or 0
		RunConsoleCommand("PostPlayerInitialSpawn")
		hook.Remove("Think", "GetLocal")
	end
end)

GM.SkinDescriptions = {}
GM.SkinDescriptions["Civil Protection"] = "THE CAN. IT WON'T PICK ITSELF UP."
GM.SkinDescriptions["Prison Guard"] = "<N/A>"
GM.SkinDescriptions["Soldier"] = "Boat. Crap."
GM.SkinDescriptions["Elite Crew"] = "He has one eye."
GM.SkinDescriptions["Weight Lifter"] = "WHY ELSE would the combine not wear their uniform?"
GM.SkinDescriptions["Barney"] = "Now... about that beer I owed ya'."

GM.SkinDescriptions["Gregori"] = "Father Gregori is tired of killing zombies and spouting bible passages. Now he's out for blood."
GM.SkinDescriptions["That Rocket Guy"] = "Ah, hello. I'll be right with you."
GM.SkinDescriptions["Frohman"] = "The most overrated comic character of all time."
GM.SkinDescriptions["Zombie"] = "What is more terrorist-y than a zombie?"
GM.SkinDescriptions["Alyx"] = "WHAT CAT?"
GM.SkinDescriptions["Some Guy"] = "hurrrr"

function GM:SpawnMenuEnabled()
	return false
end

function GM:SpawnMenuOpen()
	return false
end

function GM:ContextMenuOpen()
	return false
end

function PhysicalBullet(attacker, inflictor, start, heading, speed, damage)
	--[[local effectdata = EffectData()
		effectdata:SetEntity(attacker)
		effectdata:SetOrigin(util.TraceLine({start = start, endpos = start + heading * 60000, filter = {attacker, inflictor}, mask = MASK_SHOT}).HitPos)
		effectdata:SetStart(start)
		effectdata:SetNormal(heading)
		effectdata:SetMagnitude(speed)
		effectdata:SetScale(damage)
	util.Effect("physicalbullet", effectdata)]]
end

function GM:HUDWeaponPickedUp(wep)
end

function GM:HUDItemPickedUp(itemname)
end

function GM:HUDAmmoPickedUp(itemname, amount)
end

local lastforward = 0

function GM:PlayerBindPress(pl, bind, down)
	if bind == "+walk" and down then
		RunConsoleCommand("dropweapon")
		return true
	elseif string.find(bind, "jump") and string.sub(bind, 1, 1) == "+" and down then -- Some people use scripts to duck and jump at the same time.
		if not pl:KeyDown(IN_FORWARD) and not pl:KeyDown(IN_BACK) then
			if pl:KeyDown(IN_MOVELEFT) then
				RunConsoleCommand("dashleft")
				return true
			elseif pl:KeyDown(IN_MOVERIGHT) then
				RunConsoleCommand("dashright")
				return true
			end
		end
		if pl.KnockedDown then
			RunConsoleCommand("getup")
		end
	end
end

function GM:Initialize()
	self.BaseClass:Initialize()

	hook.Remove("GUIMousePressed", "SuperDOFMouseDown")
	hook.Remove("GUIMouseReleased", "SuperDOFMouseUp")

	surface.CreateFont("cstrike", 16, 400, true, false, "cstrike16")
	surface.CreateFont("cstrike", 24, 400, true, false, "cstrike24")
	surface.CreateFont("cstrike", 32, 400, true, false, "cstrike32")
	surface.CreateFont("cstrike", 48, 400, true, false, "cstrike48")
	surface.CreateFont("cstrike", 64, 400, true, false, "cstrike64")
	surface.CreateFont("cstrike", 72, 400, true, false, "cstrike72")
	surface.CreateFont("csd", ScreenScale(30), 500, true, true, "CSKillIcons")
	surface.CreateFont("csd", ScreenScale(60), 500, true, true, "CSSelectIcons")
end

function GM:InitPostEntity()
end

function GM:WeaponDeployed(pl, wep)
end

function GM:Think()
end

function GM:CreateMove(ucmd)
end

function GM:PlayerDeath(pl, attacker)
end

local texDie = surface.GetTextureID("HUD/killicons/default")
function GM:HUDPaintBackground()
	if MySelf:IsValid() then
		if MySelf:GetMoveType() == MOVETYPE_OBSERVER and not self.ShowScoreboard then
			surface.SetDrawColor(0, 0, 0, 235)
			surface.DrawRect(0, 0, w, h * 0.15)
			surface.DrawRect(0, h - h * 0.15, w, h * 0.15)
		end

		if self.DeathIconEnd and CurTime() < self.DeathIconEnd then
			local delta = math.max(0.15, self.DeathIconEnd - CurTime() - 2) * 0.5

			local realtime = RealTime()
			local RealSeed1 = math.sin(realtime * 18) * 100 + 155
			local RealSeed2 = math.cos(realtime * 24) * 100 + 155
			local RealSeed3 = math.sin(realtime * -20) * 100 + 155
			local RealSeed4 = math.cos(realtime * -25) * 100 + 155

			local ww = w * 0.5
			local hh = h * 0.5
			surface.SetTexture(texDie)
			surface.SetDrawColor(RealSeed1, RealSeed2, RealSeed3, 200)
			surface.DrawTexturedRect((ww - h * 0.15) + math.sin(realtime * 5) * hh * delta, (hh - h * 0.15) + math.cos(realtime * 5) * hh * delta, h * 0.3, h * 0.3)
			surface.SetDrawColor(RealSeed2, RealSeed3, RealSeed4, 200)
			surface.DrawTexturedRect((ww - h * 0.15) + math.sin((realtime + 1) * 5) * hh * delta, (hh - h * 0.15) + math.cos((realtime + 1) * 5) * hh * delta, h * 0.3, h * 0.3)
			surface.SetDrawColor(RealSeed4, RealSeed2, RealSeed1, 200)
			surface.DrawTexturedRect((ww - h * 0.15) + math.sin((realtime + 2) * 5) * hh * delta, (hh - h * 0.15) + math.cos((realtime + 2) * 5) * hh * delta, h * 0.3, h * 0.3)
			surface.SetDrawColor(RealSeed3, RealSeed4, RealSeed2, 200)
			surface.DrawTexturedRect((ww - h * 0.15) + math.sin((realtime + 3) * 5) * hh * delta, (hh - h * 0.15) + math.cos((realtime + 3) * 5) * hh * delta, h * 0.3, h * 0.3)
			surface.SetDrawColor(RealSeed1, RealSeed2, RealSeed4, 200)
			surface.DrawTexturedRect((ww - h * 0.15) + math.sin((realtime + 4) * 5) * hh * delta, (hh - h * 0.15) + math.cos((realtime + 4) * 5) * hh * delta, h * 0.3, h * 0.3)

			local alpha = math.max(1, 255 - delta * 100)
			surface.SetDrawColor(RealSeed1, RealSeed2, RealSeed3, alpha)
			surface.SetFont("cstrike48")
			local texw, texh = surface.GetTextSize("Hi")
			surface.DrawRect(0, h * 0.7 - 12, w, 10)
			surface.DrawRect(0, h * 0.7 + texh + 2, w, 10)
			surface.SetDrawColor(0, 0, 0, 200)
			surface.DrawRect(0, h * 0.7 - 2, w, texh + 4)
			draw.DrawText("You were "..self.DeathIconMessage.." by "..self.DeathIconName.."!", "cstrike48", w * 0.5 + math.sin(RealTime() * 3) * h * 0.1, h * 0.7, Color(RealSeed2, RealSeed1, RealSeed4, alpha), TEXT_ALIGN_CENTER)
		end
	end
end

function GM:UpdateAnimation(pl)
	if pl:Alive() then
		if pl:InVehicle() then
			local steer = pl:GetVehicle():GetPoseParameter("vehicle_steer")
			pl:SetPoseParameter("vehicle_steer", steer) 
		end

		pl:SetPoseParameter("breathing", 2 - pl:Health() * 0.01)
	end
end

local ranDeaths = {"killed",
"destroyed",
"dominated",
"knocked off",
"whacked",
"sent to the next world",
"annihilated",
"smashed",
"dispatched",
"wiped out",
"butchered",
"crushed",
"wrecked",
"erased",
"dismantled",
"slain",
"finished off"}

function GM:Died(attacker)
	if attacker and attacker:IsValid() then
		local attackername
		if attacker:IsPlayer() then
			attackername = attacker:Name()
		else
			attackername = "#"..attacker:GetClass()
		end

		self.DeathIconMessage = ranDeaths[math.random(1, #ranDeaths)]
		self.DeathIconEnd = CurTime() + 4.5
		self.DeathIconName = attackername
	end
end

function GM:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume)
	if pl:GetVelocity():Length() < 135 then return true end
end

function GM:PlayerStepSoundTime(pl, iType, bWalking)
	if iType == STEPSOUNDTIME_NORMAL or iType == STEPSOUNDTIME_WATER_FOOT then
		return 520 - pl:GetVelocity():Length()
	elseif iType == STEPSOUNDTIME_ON_LADDER then
		return 500
	elseif iType == STEPSOUNDTIME_WATER_KNEE then
		return 650
	end

	return 350
end

w, h = ScrW(), ScrH()
timer.Create("UpdateResolution", 4, 0, function()
	w, h = ScrW(), ScrH()
end)

local displaycontrols = CreateClientConVar("awesomestrike_displaycontrols", 1, true, false)
--local healthtexture = surface.GetTextureID("awesomestrike/healthbar")
--[[REC_ADDX = 16
REC_ADDY = 0
REC_HEI = 36]]
function GM:HUDPaint()
	self:DrawDeathNotice(0.85, 0.04)
	self:HUDDrawTargetID()

	if MySelf:IsValid() then
		--[[local health = math.max(0, MySelf:Health())

		surface.SetFont("cstrike64")
		local txtw, txth = surface.GetTextSize("100")
		draw.RoundedBox(16, 32, h - 32 - txth, txtw + 32, txth + 16, color_black_alpha90)
		draw.SimpleText(health, "cstrike64", 48 + txtw * 0.5, (h - 32 - txth) + txth * 0.5, COLOR_TEXTYELLOW, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		surface.SetDrawColor(200, 0, 0, 255)
		surface.DrawRect(72 + txtw + REC_ADDX, (h - 70) + REC_ADDY, 5.12 * health - REC_ADDX, REC_HEI)
		surface.SetTexture(healthtexture)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(72 + txtw, h - 70, 512, 64)]]

		if displaycontrols:GetBool() then
			local y = 0
			local x = w * 0.5
			draw.DrawTextShadow("Controls - More help in F1", "cstrike32", x, y, COLOR_LIMEGREEN, color_black, TEXT_ALIGN_CENTER)
			local txtw, txth = surface.GetTextSize("Controls")
			y = y + txth
			draw.DrawTextShadow("Forward + Forward: Sprint", "Default", x, y, color_white, color_black, TEXT_ALIGN_CENTER)
			txtw, txth = surface.GetTextSize("Forward + Forward: Sprint")
			y = y + txth
			draw.DrawTextShadow("Move left + Jump: Dash Dodge Left", "Default", x, y, color_white, color_black, TEXT_ALIGN_CENTER)
			txtw, txth = surface.GetTextSize("Move left + Jump: Dash Dodge Left")
			y = y + txth
			draw.DrawTextShadow("Move right + Jump: Dash Dodge Right", "Default", x, y, color_white, color_black, TEXT_ALIGN_CENTER)
			txtw, txth = surface.GetTextSize("Move right + Jump: Dash Dodge Right")
			y = y + txth
			draw.DrawTextShadow("Jump in the air, facing a wall: Wall Jump", "Default", x, y, color_white, color_black, TEXT_ALIGN_CENTER)
			txtw, txth = surface.GetTextSize("Jump in the air, facing a wall: Wall Jump")
			y = y + txth
			draw.DrawTextShadow("Jump in the air, facing a wall at an angle: Wall Reflect", "Default", x, y, color_white, color_black, TEXT_ALIGN_CENTER)
			txtw, txth = surface.GetTextSize("Jump in the air, facing a wall at an angle: Wall Reflect")
			y = y + txth
			draw.DrawTextShadow("Attack while dodging: Dash Cancel", "Default", x, y, color_white, color_black, TEXT_ALIGN_CENTER)
			txtw, txth = surface.GetTextSize("Attack while dodging: Dash Cancel")
			y = y + txth
			local wep = MySelf:GetActiveWeapon()
			if wep.Help then
				draw.DrawTextShadow(wep.PrintName.." Help", "cstrike24", x, y, COLOR_LIMEGREEN, color_black, TEXT_ALIGN_CENTER)
				txtw, txth = surface.GetTextSize(wep.PrintName.." Help")
				y = y + txth
				for i, line in ipairs(wep.Help) do
					draw.DrawTextShadow(line, "Default", x, y, color_white, color_black, TEXT_ALIGN_CENTER)
					txtw, txth = surface.GetTextSize(line)
					y = y + txth
				end
			end
		end

		surface.SetFont("cstrike32")
		local texw, texh = surface.GetTextSize("a")

		local x, y = w - 48, h * 0.5
		if CanBuy then
			draw.DrawText("F3: Buy", "cstrike32", x, y, COLOR_LIMEGREEN, TEXT_ALIGN_RIGHT)
		end

		y = y + texh + 8
		if MySelf:Team() == TEAM_T and MySelf:HasWeapon("weapon_as_bomb") then
			if CanPlantBomb then
				if math.sin(CurTime() * 20) < 0 then
					draw.DrawText("Bomb here!", "cstrike32", x, y, COLOR_RED, TEXT_ALIGN_RIGHT)
				else
					draw.DrawText("Bomb here!", "cstrike32", x, y, COLOR_LIMEGREEN, TEXT_ALIGN_RIGHT)
				end
			else
				draw.DrawText("You have the bomb", "cstrike32", x, y, COLOR_LIMEGREEN, TEXT_ALIGN_RIGHT)
			end
		elseif CanPlantBomb then
			draw.DrawText("Bomb Site", "cstrike32", x, y, COLOR_LIMEGREEN, TEXT_ALIGN_RIGHT)
		end

		y = y + texh + 8
		if CanRescueHostage then
			draw.DrawText("Hostage Zone", "cstrike32", x, y, COLOR_LIMEGREEN, TEXT_ALIGN_RIGHT)
		end

		local bomb = self.BOMBENTITY
		if bomb and bomb:IsValid() then
			if bomb:GetNetworkedEntity("defuser") == MySelf then
				bomb.DefusePercent = math.min(1, bomb.DefusePercent + FrameTime() * 0.13)

				surface.SetFont("cstrike48")
				local bombw, bombh = surface.GetTextSize("DEFUSING BOMB")

				draw.RoundedBox(16, w * 0.5 - bombw * 0.55, h * 0.6 - bombh * 0.55, bombw * 1.1, bombh * 1.1 + 20, color_black_alpha180)
				draw.SimpleText("DEFUSING BOMB", "cstrike48", w * 0.5, (h * 0.6 - bombh * 0.55) + 8, Color(255, 200, 0, 170 + math.sin(RealTime() * 6) * 135), TEXT_ALIGN_CENTER)

				local y = h * 0.6 + bombh * 1.1 - 16
				surface.SetDrawColor(0, 0, 0, 255)
				surface.DrawRect(w * 0.5 - bombw * 0.5, y, bombw, 7)
				surface.SetDrawColor(255, 190, 0, 255)
				surface.DrawOutlinedRect(w * 0.5 - bombw * 0.5, y, bombw, 7)
				surface.DrawRect(w * 0.5 - bombw * 0.5, y, bombw * bomb.DefusePercent, 7)
			else
				bomb.DefusePercent = 0
			end
		end

		surface.SetFont("cstrike32")
		local timleft = math.max(0, GetGlobalFloat("endroundtime", 0) - CurTime())
		if GetGlobalBool("roundend", true) then
			local txt = "ROUND OVER"
			local texw, texh = surface.GetTextSize(txt)
			draw.RoundedBox(8, w * 0.5 - texw * 0.6, h - texh - 32, texw * 1.2, texh + 16, color_black_alpha90)
			draw.SimpleText(txt, "cstrike32", w * 0.5, (h - texh - 32) + (texh * 0.5 + 8), COLOR_TEXTYELLOW, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif timleft <= 10 then
			local txt = string.ToMinutesSecondsMilliseconds(timleft)
			local texw, texh = surface.GetTextSize(txt)
			draw.RoundedBox(8, w * 0.5 - texw * 0.6, h - texh - 32, texw * 1.2, texh + 16, color_black_alpha90)
			local col = COLOR_TEXTYELLOW
			if math.sin(RealTime() * 30) < 0 then
				col = COLOR_RED
			end
			draw.SimpleText(txt, "cstrike32", w * 0.5, (h - texh - 32) + (texh * 0.5 + 8), col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			local txt = string.ToMinutesSeconds(timleft)
			local texw, texh = surface.GetTextSize(txt)
			draw.RoundedBox(8, w * 0.5 - texw * 0.6, h - texh - 32, texw * 1.2, texh + 16, color_black_alpha90)
			draw.SimpleText(txt, "cstrike32", w * 0.5, (h - texh - 32) + (texh * 0.5 + 8), COLOR_TEXTYELLOW, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

function GM:ShutDown()
end

function GM:RenderScreenspaceEffects()
end

function GM:GetTeamColor(ent)
	local teamid = TEAM_UNASSIGNED
	if ent.Team then teamid = ent:Team() end
	return team.GetColor(teamid)
end

function GM:AdjustMouseSensitivity(fDefault)
	return -1
end

usermessage.Hook("EndG", function(um)
	local winner = um:ReadShort()
	END_GAME = true
	NEXT_MAP = CurTime() + GetConVarNumber("as_votetime")

	RunConsoleCommand("+showscores")
end)

function GM:CalcView(pl, origin, angles, fov)
	local Vehicle = pl:GetVehicle()
	
	if Vehicle:IsValid() and gmod_vehicle_viewmode:GetInt() == 1 then
		return self:CalcVehicleThirdPersonView(Vehicle, pl, origin, angles, fov)
	end

	local wep = pl:GetActiveWeapon()
	local view = {origin = origin, angles = angles, fov = fov}

	local bullet = pl.AwesomeBullet
	if bullet and bullet:IsValid() and bullet:GetSkin() ~= 1 then
		view.angles = bullet:GetAngles()
		view.origin = bullet:GetPos() + bullet:GetAngles():Forward() * 4
		view.vm_origin = origin + angles:Up() * 200
	elseif pl:GetRagdollEntity() and pl:Alive() then
		local rpos, rang = self:GetRagdollEyes(pl)
		if rpos then
			view.origin = rpos
			view.angles = rang
		end
	elseif wep:IsValid() then
		if wep.GetViewModelPosition then
			view.vm_origin, view.vm_angles = wep:GetViewModelPosition(origin * 1, angles * 1)
		end

		if wep.CalcView then
			view.origin, view.angles, view.fov = wep:CalcView(pl, origin, angles, fov)
		end
	end

	return view
end

local dontdraw = {}
dontdraw["CHudSecondaryAmmo"] = true
--dontdraw["CHudHealth"] = true
function GM:HUDShouldDraw(name)
	return dontdraw[name] == nil
end

function CSButton(parent, text, doclick, dorightclick, thinkhook)
	local button = vgui.Create("DButton", parent)
	button:SetContentAlignment(4)
	button:SetText(text)
	button:SetFont("cstrike24")
	button:SetTextColor(COLOR_TEXTYELLOW)
	button:SetTextColorHovered(color_white)
	button:SetSize(300, 48)
	if doclick then
		button.DoClick = doclick
	end
	if dorightclick then
		button.DoRightClick = dorightclick
	end
	if thinkhook then
		button.Think = thinkhook
	end

	return button
end
