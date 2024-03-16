include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-60, -60, -60), Vector(60, 60, 60))
	self.Col = Color(self:GetColor())
end

--[[function ENT:Think()
	if not self.PlayedWizz then
		local eyepos = EyePos()
		local selfpos = self:GetPos()
		local eyeangles = EyeAngles():Right()
		if (eyepos + eyeangles * 8):Distance(selfpos) < 16 or (eyepos + eyeangles * -8):Distance(selfpos) < 16 then
			self.PlayedWizz = true
			self:EmitSound("npc/env_headcrabcanister/incoming.wav", 60, math.random(165, 190))
		end
	end
end]]

function ENT:OnRemove()
end

local matBeam = Material("effects/spark")
function ENT:Draw()
	local vel = self:GetVelocity()
	if 10 < vel:Length() then
		self:SetAngles(vel:Angle())
	end
	self:DrawModel()
	render.SetMaterial(matBeam)
	local pos = self:GetPos()
	local start = pos
	local endpos = pos - vel:Normalize() * 100
	render.DrawBeam(start, endpos, 4, 1, 0, col)
	render.DrawBeam(start, endpos, 2, 1, 0, col)
end
