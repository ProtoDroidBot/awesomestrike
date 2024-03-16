include("shared.lua")

function ENT:Initialize()
	self.Emitter = ParticleEmitter(self:GetPos())
	self.Emitter:SetNearClip(24, 32)

	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-128, -128, -128), Vector(128, 128, 128))

	local owner = self:GetOwner()
	owner.BJAStart = CurTime() + 0.25
	owner.BJAEnd = owner.BJAStart + 0.6
end

function ENT:Think()
	self.Emitter:SetPos(self:GetPos())
end

function ENT:OnRemove()
	local owner = self:GetOwner()
	owner.BJAStart = nil
	owner.BJAEnd = nil
	self.Emitter:Finish()
end

function ENT:DrawTranslucent()
	--[[local owner = self:GetOwner()
	if not owner:IsValid() then return end]]
end
