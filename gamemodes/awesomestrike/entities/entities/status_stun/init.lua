AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.Stunned = self
	if not bExists then
		RestoreSpeed(pPlayer)
	end
	pPlayer:EmitSound("nox/stunon.wav")
end

function ENT:OnRemove()
	local parent = self:GetParent()
	if parent:IsValid() then
		if not self.SilentRemove then
			parent:EmitSound("nox/stunoff.wav")
		end
		parent.Stunned = nil
		RestoreSpeed(parent, parent:GetActiveWeapon().WalkSpeed)
	end
end
