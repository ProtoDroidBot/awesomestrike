AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/weapons/w_eq_fraggrenade_thrown.mdl")
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

		local teamid = self.TeamID or 0

		local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
		util.Effect("concussionexplosion", effectdata)

		local explodepos = self:GetPos()
		local owner = self:GetOwner()
		for _, ent in pairs(ents.FindInSphere(explodepos, 256)) do
			if ent:IsPlayer() and ent:Alive() and (ent:Team() ~= teamid or ent == owner) then
				local nearest = ent:NearestPoint(explodepos)
				if TrueVisible(nearest, explodepos) then
					ent:SetGroundEntity(NULL)
					ent:SetVelocity(ent:GetVelocity() + 900 * (ent:GetPos() - explodepos):Normalize() + Vector(0,0,300))
					ent:GiveStatus("knockdown", 4)
					ent:Stun(4)
					if owner:IsPlayer() then
						ent:SetLastAttacker(owner)
					end
				end
			end
		end

		self:Remove()
	end
end

