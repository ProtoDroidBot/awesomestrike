AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/crossbow_bolt.mdl")
	self:DrawShadow(false)
	self:PhysicsInitSphere(0.001)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE_DEBRIS)
	local phys = self:GetPhysicsObject()
	phys:EnableDrag(false)
	phys:EnableGravity(false)
	phys:SetBuoyancyRatio(0.00001)
	phys:Wake()

	self:GetOwner().GrappleBeam = self
end

function ENT:OnRemove()
	self:EmitSound("npc/barnacle/barnacle_crunch2.wav")
	self:GetOwner().GrappleBeam = nil
end

function ENT:Think()
	local owner = self:GetOwner()
	if owner:IsValid() and owner:Alive() and owner:KeyDown(IN_ATTACK) then
		local ownershootpos = owner:GetShootPos()
		local ownerpos = owner:GetPos()
		local nearest = self:NearestPoint(ownerpos)
		local selfpos = self:GetPos()
		local dist = nearest:Distance(ownerpos)
		if not (TrueVisible(ownershootpos, selfpos + (ownershootpos - selfpos):Normalize() * 16) and 32 < dist and dist < 1280) then
			self:Remove()
			return
		end

		self:NextThink(CurTime())
		return true
	end

	self:Remove()
end

function ENT:OnTakeDamage(dmginfo)
	if 0 < dmginfo:GetDamage() and not (dmginfo:GetAttacker():IsPlayer() and dmginfo:GetAttacker():Team() == self.Team) then
		self:Remove()
	end
end

function ENT:PhysicsCollide(data, phys)
	if not self.Hit then
		local ent = data.HitEntity
		if not ent:IsValid() or not data.HitObject:IsValid() or not data.HitObject:IsMoveable() then
			self.Hit = true
			self:SetSkin(1)
			self:EmitSound("physics/metal/sawblade_stick"..math.random(1,3)..".wav")
			phys:EnableMotion(false)
		end
	end
end
