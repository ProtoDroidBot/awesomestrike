AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/peanut/conansword.mdl")
end

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.WeaponStatus = self
end

function ENT:Think()
	local owner = self:GetOwner()
	local wep = owner:GetActiveWeapon()
	if not wep:IsValid() or wep:GetClass() ~= "weapon_as_berserkersword" then
		self:Remove()
	end
end
