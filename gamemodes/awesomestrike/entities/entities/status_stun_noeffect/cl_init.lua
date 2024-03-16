include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)

	self:GetOwner().Stunned = self
	self:GetOwner().SilentStunned = self
end

function ENT:OnRemove()
	self:GetOwner().Stunned = nil
	self:GetOwner().SilentStunned = nil
end

function ENT:DrawTranslucent()
end
