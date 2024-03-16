include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-60, -60, -60), Vector(60, 60, 60))

	self:GetOwner().AwesomeBullet = self
end

function ENT:OnRemove()
	local owner = self:GetOwner()
	if owner.AwesomeBullet == self then
		owner.AwesomeBullet = nil
	end
end

function ENT:Draw()
	local vel = self:GetVelocity()
	if 10 < vel:Length() then
		self:SetAngles(vel:Angle())
	end
	self:DrawModel()
end
