if CLIENT then return end

function LogAction(sAction)
	LOGCONTENTS = LOGCONTENTS..os.date().." "..sAction.."\n"
	PrintMessage(HUD_PRINTTALK, sAction)
end

concommand.Add("a_slay", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumber(arguments[1])
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id and pl:Alive() then
			LogAction(sender:Name().." KILLED "..pl:Name().." <"..pl:SteamID()..">")

			pl:Kill()
			return
		end
	end
end)

concommand.Add("a_kick", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumber(arguments[1])
	if not id then return end
	--local reason = table.concat(arguments, 2) or "in the ass"
	local reason = arguments[2] or "in the ass"

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			LogAction(sender:Name().." KICKED "..pl:Name().." <"..pl:SteamID().."> because "..reason)

			if gatekeeper then
				gatekeeper.Drop(id, "Kicked: "..reason)
			else
				pl:Kick(reason)
			end
			return
		end
	end
end)

local SLAP_SOUNDS = {"physics/body/body_medium_impact_hard1.wav",
"physics/body/body_medium_impact_hard2.wav",
"physics/body/body_medium_impact_hard3.wav",
"physics/body/body_medium_impact_hard5.wav",
"physics/body/body_medium_impact_hard6.wav",
"physics/body/body_medium_impact_soft5.wav",
"physics/body/body_medium_impact_soft6.wav",
"physics/body/body_medium_impact_soft7.wav"}

concommand.Add("a_slap", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumber(arguments[1])
	if not id then return end
	local power = tonumber(arguments[2])
	if not power then return end
	local dmg = tonumber(arguments[3])
	if not dmg then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id and pl:Alive() then
			LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> SLAPPED "..pl:Name().." <"..pl:SteamID().."> with "..power.." power and "..dmg.." damage.")

			pl:EmitSound(SLAP_SOUNDS[math.random(1, #SLAP_SOUNDS)])
			pl:SetLocalVelocity(VectorRand() * power)
			if pl:Health() < dmg then
				pl:Kill()
			else
				pl:TakeDamage(dmg, NULL, NULL)
			end
			return
		end
	end
end)

concommand.Add("a_ignite", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumber(arguments[1])
	if not id then return end
	local tim = tonumber(arguments[2])
	if not tim then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> IGNITED "..pl:Name().." <"..pl:SteamID().."> for "..tim.." seconds.")

			pl:Ignite(tim, 1)
			return
		end
	end
end)

concommand.Add("a_forceurl", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumber(arguments[1])
	if not id then return end
	local url = table.concat(arguments, " ", 2)
	if not url then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id and not pl:IsSuperAdmin() then
			LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> FORCED "..pl:Name().." <"..pl:SteamID().."> to go to "..url..".")

			pl:SendLua("ForceURL(\""..url.."\")")
			return
		end
	end
end)

concommand.Add("a_god", function(sender, command, arguments)
	if not sender:IsSuperAdmin() then return end

	local id = tonumber(arguments[1])
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			if tonumber(arguments[2]) == 1 then
				LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> ENABLED GODMODE on "..pl:Name().." <"..pl:SteamID()..">.")

				pl:GodEnable()
			else
				LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> DISABLED GODMODE on "..pl:Name().." <"..pl:SteamID()..">.")

				pl:GodDisable()
			end
			return
		end
	end
end)

concommand.Add("a_freeze", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumber(arguments[1])
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			if tonumber(arguments[2]) == 1 then
				LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> FROZE "..pl:Name().." <"..pl:SteamID()..">.")

				pl:Freeze(true)
			else
				LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> UNFROZE "..pl:Name().." <"..pl:SteamID()..">.")

				pl:Freeze(false)
			end
			return
		end
	end
end)

concommand.Add("a_invisibility", function(sender, command, arguments)
	if not sender:IsSuperAdmin() then return end

	local id = tonumber(arguments[1])
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			local r,g,b,a = pl:GetColor()
			if tonumber(arguments[2]) == 1 then
				LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> ENABLED INVISIBILITY on "..pl:Name().." <"..pl:SteamID()..">.")

				pl:SetColor(r,g,b,0)
			else
				LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> DISABLED INVISIBILITY on "..pl:Name().." <"..pl:SteamID()..">.")

				pl:SetColor(r,g,b,255)
			end
			return
		end
	end
end)

concommand.Add("a_bringtome", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumber(arguments[1])
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> BROUGHT "..pl:Name().." <"..pl:SteamID().."> to them.")

			pl:SetPos(sender:GetPos() + Vector(0,0,73))
			return
		end
	end
end)

concommand.Add("a_teleporttothem", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumber(arguments[1])
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> TELEPORTED TO "..pl:Name().." <"..pl:SteamID()..">.")

			sender:SetPos(pl:GetPos() + Vector(0,0,73))
			return
		end
	end
end)

concommand.Add("a_teleporttotarget", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumber(arguments[1])
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			local pos = sender:GetEyeTrace().HitPos
			LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> TELEPORTED "..pl:Name().." <"..pl:SteamID().."> to their position ("..tostring(pos)..").")

			pl:SetPos(pos)
			return
		end
	end
end)

concommand.Add("a_restartmap", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> RESTARTED the map.")

	NDB.GlobalSave()

	game.ConsoleCommand("changelevel "..game.GetMap().."\n")
end)
