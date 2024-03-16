include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:OnRemove()
	self.AmbientSound:Stop()
end

function ENT:Think()
	self.AmbientSound:PlayEx(0.38, math.sin(CurTime()) + 80)
end

function ENT:Initialize()
	self.AmbientSound = CreateSound(self, "npc/turret_wall/turret_loop1.wav")
end
