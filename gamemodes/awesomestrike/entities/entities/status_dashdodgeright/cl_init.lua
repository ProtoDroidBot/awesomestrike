include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-40, -40, -18), Vector(40, 40, 80))

	self.Emitter = ParticleEmitter(self:GetPos())
	self.Emitter:SetNearClip(14, 24)

	self:GetOwner().DashDodging = self
	self:GetOwner().DashDodgingRight = self

	self:EmitSound("npc/advisor/advisor_blast6.wav", 70, 210)

	self.DieTime = CurTime() + 0.5
end

function ENT:OnRemove()
	self:GetOwner().DashDodging = nil
	self:GetOwner().DashDodgingRight = nil

	self.Emitter:Finish()
end

function ENT:Think()
	self.Emitter:SetPos(self:GetPos())
end

function ENT:Draw()
	local owner = self:GetOwner()
	if not owner:IsValid() then return end

	local aa, bb = owner:WorldSpaceAABB()

	for i=1, 3 do
		local particle = self.Emitter:Add("effects/fire_cloud1", Vector(math.Rand(aa.x, bb.x), math.Rand(aa.y, bb.y), math.Rand(aa.z, bb.z)))
		particle:SetDieTime(math.Rand(0.3, 0.4))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(255)
		particle:SetStartSize(math.Rand(4, 8))
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-30, -15))
	end
end
