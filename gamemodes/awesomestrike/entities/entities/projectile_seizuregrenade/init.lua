AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/weapons/w_eq_flashbang_thrown.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:SetMass(5)
	phys:Wake()

	self.DeathTime = self.DeathTime or CurTime() + 2
end

function ENT:Think()
	if self.DeathTime < CurTime() and not self.Exploded then
		self.Exploded = true

		local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetMagnitude(self.OwnerID or 0)
			effectdata:SetScale(self.TeamID or 0)
		util.Effect("seizureexplosion", effectdata)

		self:Remove()
	end
end

