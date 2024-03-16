AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.Stunned = self
	pPlayer.SilentStunned = self
	if not bExists then
		RestoreSpeed(pPlayer)
	end
end

function ENT:OnRemove()
	local parent = self:GetParent()
	if parent:IsValid() then
		parent.Stunned = nil
		parent.SilentStunned = nil
		RestoreSpeed(parent, parent:GetActiveWeapon().WalkSpeed)
	end
end
