AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Think()
	if self.DeathTime < CurTime() then
		self:Remove()
	elseif self.ExplodeInfo then
		self:Explode(self.ExplodeInfo.HitPos, self.ExplodeInfo.HitNormal)
	elseif 0 < self:WaterLevel() then
		self:Explode()
	end
end

function ENT:PhysicsCollide(data, physobj)
	if not (data.HitEntity:IsValid() and data.HitEntity:GetClass() == "projectile_melonchunk") then
		self.ExplodeInfo = data
		self:NextThink(CurTime())
	end
end

function ENT:Explode(hitpos, hitnormal)
	if self.Exploded then return end
	self.Exploded = true
	self.DeathTime = -10

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end

	hitpos = hitpos or self:GetPos()
	hitnormal = hitnormal or Vector(0,0,1)

	local effectdata = EffectData()
		effectdata:SetOrigin(hitpos)
		effectdata:SetNormal(hitnormal or Vector(0, 0, 1))
	util.Effect("melonexplosion", effectdata)

	util.BlastDamage(self, owner, hitpos, 80, 16)

	self:NextThink(CurTime())
end

local melonmdl = {"models/props_junk/watermelon01_chunk01a.mdl",
"models/props_junk/watermelon01_chunk01b.mdl",
"models/props_junk/watermelon01_chunk01c.mdl",
"models/props_junk/watermelon01_chunk02a.mdl",
"models/props_junk/watermelon01_chunk02b.mdl",
"models/props_junk/watermelon01_chunk02c.mdl"}

function ENT:Initialize()
	self:SetModel(melonmdl[math.random(1, 6)])
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:EnableDrag(false)
	phys:Wake()

	self.DeathTime = CurTime() + 20
end
