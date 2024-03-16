include("shared.lua")

function ENT:Initialize()
	self:SetRenderBounds(Vector(-60, -60, -60), Vector(60, 60, 60))
	self.Emitter = ParticleEmitter(self:GetPos())
end

function ENT:Think()
	self.Emitter:SetPos(self:GetPos())
end

function ENT:OnRemove()
	self.Emitter:Finish()
end

function ENT:Draw()
	self:DrawModel()

	local particle = self.Emitter:Add("effects/fire_cloud1", self:GetPos())
	particle:SetVelocity(VectorRand() * 16)
	particle:SetDieTime(0.65)
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(255)
	particle:SetStartSize(3)
	particle:SetEndSize(0)
	particle:SetRoll(math.Rand(0, 360))
	particle:SetRollDelta(math.Rand(-21.5, 21.5))
end
