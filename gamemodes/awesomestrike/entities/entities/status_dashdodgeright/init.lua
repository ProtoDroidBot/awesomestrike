AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.DashDodging = self
	pPlayer.DashDodgingRight = self

	self.DieTime = CurTime() + 0.5
end

function ENT:Think()
	if self.DieTime <= CurTime() then
		self:Remove()
	end
end

function ENT:OnRemove()
	local parent = self:GetOwner()
	if parent:IsValid() then
		parent.DashDodging = nil
		parent.DashDodgingRight = nil
	end
end
