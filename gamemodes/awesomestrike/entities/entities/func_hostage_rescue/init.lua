ENT.Type = "brush"

function ENT:Initialize()
end

function ENT:Think()
end

function ENT:StartTouch(ent)
	if ent:IsPlayer() then
		ent.CanRescueHostage = self
		ent:SendLua("CanRescueHostage="..self:EntIndex())
	elseif ent:GetClass() == "npc_hostage" then
		local numhostages = #ents.FindByClass("npc_hostage")
		if numhostages <= 1 then
			GAMEMODE:EndRound(TEAM_CT, false, 3)
		else
			for _, pl in pairs(player.GetAll()) do
				pl:PrintMessage(HUD_PRINTCENTER, "A hostage has been rescued!")
				pl:SendLua("surface.PlaySound(\"radio/rescued.wav\")")
			end

			local escort = ent.Escort
			if escort and escort:IsPlayer() and escort:Team() == TEAM_CT then
				escort:AddMoney(200)
			end
		end

		ent:Remove()
	end
end

function ENT:EndTouch(ent)
	if ent.CanRescueHostage == self then
		ent.CanRescueHostage = nil
		ent:SendLua("CanRescueHostage=nil")
	end
end

function ENT:Touch(ent)
end
