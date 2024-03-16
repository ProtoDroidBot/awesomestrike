AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.Damage = 10

function ENT:Initialize()
	self:SetModel("models/crossbow_bolt.mdl")
	self:DrawShadow(false)
	self:PhysicsInitSphere(0.001)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	--self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	local phys = self:GetPhysicsObject()
	phys:EnableDrag(false)
	phys:EnableGravity(false)
	phys:SetBuoyancyRatio(0.00001)
	phys:Wake()

	self:StartMotionController()

	self.DeathTime = CurTime() + 30

	self:GetOwner().AwesomeBullet = self
end

function ENT:OnRemove()
	local owner = self:GetOwner()
	if owner.AwesomeBullet == self then
		owner.AwesomeBullet = nil
	end
end

function ENT:PhysicsSimulate(phys, frametime)
	phys:Wake()

	local owner = self:GetOwner()
	if self:GetSkin() ~= 1 and owner:IsValid() and owner:Alive() then
		local curvel = self:GetVelocity()
		local newangles = self:GetAngles()
		local diffangles = self:WorldToLocalAngles(owner:EyeAngles())

		newangles:RotateAroundAxis(newangles:Right(), diffangles.pitch * frametime * -1)
		newangles:RotateAroundAxis(newangles:Up(), diffangles.yaw * frametime)
		newangles:RotateAroundAxis(newangles:Forward(), diffangles.roll * frametime)

		self:SetAngles(newangles)
		phys:SetVelocityInstantaneous(newangles:Forward() * self.BulletSpeed)
	end

	return SIM_NOTHING
end

function ENT:Think()
	if self.DelaySetOwner and self.DelaySetOwner:IsValid() then
		self:SetOwner(self.DelaySetOwner)
		self.DelaySetOwner = nil
	end

	local owner = self:GetOwner()
	if self.PhysicsData then
		local data = self.PhysicsData
		self.PhysicsData = nil

		local start = self:GetPos()
		if data.HitEntity:IsPlayer() then
			local dir = (data.HitPos - start):Normalize()
			start = start + dir * -8
			self:FireBullets({Num = 1, Src = start, Dir = dir, Spread = Vector(0,0,0), HullSize = 8, Tracer = 0, Force = self.Damage, Damage = self.Damage})
		else
			local dir = self.Heading
			start = start + dir * -8
			self:FireBullets({Num = 1, Src = start, Dir = dir, Spread = Vector(0,0,0), Tracer = 0, Force = self.Damage, Damage = self.Damage})
		end

		self:Remove()
	elseif self.DeathTime <= CurTime() then
		self:Remove()
	end
end

function ENT:PhysicsCollide(data, phys)
	if 0 < self.DeathTime then
		local hitent = data.HitEntity
		if hitent and hitent:IsValid() and hitent:GetClass() == "status_weapon_forceshield" then
			local owner = hitent:GetOwner()
			if owner:IsValid() then
				local hitnormal = owner:GetAimVector()
				local normal = data.OurOldVelocity:Normalize()
				local newheading = 2 * hitnormal * hitnormal:Dot(normal * -1) + normal
				self:SetAngles(newheading:Angle())
				phys:SetVelocityInstantaneous(newheading * self.BulletSpeed)
				self:GetOwner().AwesomeBullet = nil
				self.DelaySetOwner = owner
				self.Attacker = owner
				self.Inflictor = hitent
				self:SetSkin(1)
				self:NextThink(CurTime())
				return
			end
		end
		self.DeathTime = 0
		self.PhysicsData = data
		self:NextThink(CurTime())
	end
end
