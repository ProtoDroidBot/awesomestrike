AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:EnableDrag(false)
	phys:Wake()

	self.DeathTime = CurTime() + 20
end

function ENT:Think()
	if self.DeathTime < CurTime() then
		self:Remove()
	elseif self.ExplodeInfo then
		self:Explode(self.ExplodeInfo.HitPos, self.ExplodeInfo.HitNormal)
	elseif 0 < self:WaterLevel() then
		self:Explode()
	else
		local vel = self:GetVelocity()
		if 16 < vel:Length() then
			local tr = util.TraceLine({start = self:GetPos(), endpos = self:GetPos() + vel * 0.55, mask = MASK_SOLID, filter = self})
			if tr.Hit then
				self:Explode(self:GetPos(), vel:Normalize() * -1)
			end
		end
	end
end

function ENT:PhysicsCollide(data, physobj)
	self.ExplodeInfo = data
	self:NextThink(CurTime())
end

function ENT:Explode(hitpos, hitnormal)
	if self.Exploded then return end
	self.Exploded = true
	self.DeathTime = -10

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end

	hitpos = hitpos or self:GetPos()
	hitnormal = hitnormal or Vector(0,0,1)

	hitnormal = hitnormal * -1

	local effectdata = EffectData()
		effectdata:SetOrigin(hitpos)
		effectdata:SetNormal(hitnormal or Vector(0, 0, 1))
	util.Effect("melonsplit", effectdata)

	local velLength = self:GetVelocity():Length()

	for i=1, 5 do
		local ent = ents.Create("projectile_melonchunk")
		if ent:IsValid() then
			ent:SetPos(hitpos)
			ent:SetAngles(VectorRand():Angle())
			ent:SetOwner(owner)
			ent:Spawn()
			ent:GetPhysicsObject():SetVelocityInstantaneous(velLength * math.Rand(0.8, 1.2) * (hitnormal + VectorRand():Normalize() * math.Rand(-0.4, 0.4)):Normalize())
		end
	end

	util.BlastDamage(self, owner, hitpos, 32, 15)

	self:NextThink(CurTime())
end
