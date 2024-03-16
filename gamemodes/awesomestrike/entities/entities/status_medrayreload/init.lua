AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.MedRayReload = self
end

function ENT:OnRemove()
	local parent = self:GetParent()
	if parent:IsValid() then
		parent.MedRayReload = nil
	end
end

function ENT:Think()
	local owner = self:GetOwner()
	if owner:IsValid() and not owner:GetActiveWeapon():IsValid() or owner:GetActiveWeapon():GetClass() ~= "weapon_as_medray" then self:Remove() end
end
