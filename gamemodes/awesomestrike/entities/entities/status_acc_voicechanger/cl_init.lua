include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:GetOwner().VoicePitch = 150
end

function ENT:OnRemove()
	self:GetOwner().VoicePitch = nil
end

function ENT:Think()
	local owner = self:GetOwner()
	if owner:IsValid() then self:SetPos(owner:EyePos()) end
end

function ENT:Draw()
end
