include("shared.lua")

function ENT:Initialize()
	self.Emitter = ParticleEmitter(self:GetPos())
	self.Emitter:SetNearClip(24, 32)

	self:DrawShadow(false)
	self:SetModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
	self:SetRenderBounds(Vector(-128, -128, -128), Vector(128, 128, 128))

	self.StartCharge = CurTime() + 0.1
	self.EndCharge = self.StartCharge + 0.55

	self:GetOwner().BerserkerCharge = self

	self:EmitSound("weapons/physcannon/superphys_launch"..math.random(2, 4)..".wav", 68, 250)
end

function ENT:Think()
	self.Emitter:SetPos(self:GetPos())
end

function ENT:OnRemove()
	local owner = self:GetOwner()
	owner.BerserkerCharge = nil
	local emitter = self.Emitter
	if owner:IsValid() then
		local particle = emitter:Add("effects/select_ring", owner:LocalToWorld(owner:OBBCenter()) + owner:GetForward() * 16)
		particle:SetDieTime(0.5)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(4)
		particle:SetEndSize(200)
		particle:SetAngles(owner:GetAngles())
		particle:SetColor(owner:GetColor())
	end

	emitter:Finish()
end

function ENT:DrawTranslucent()
	local owner = self:GetOwner()
	if not owner:IsValid() then return end

	local pos = owner:LocalToWorld(owner:OBBCenter()) + owner:GetForward() * 16
	local fwd = owner:GetForward()

	local col = team.GetColor(owner:Team())
	local r,g,b = col.r, col.g, col.b
	local ct = CurTime()
	if self.StartCharge < ct then
		local vel = owner:GetVelocity() * -0.25 * fwd
		local fwdang = fwd:Angle()
		for i=1, 3 do
			local particle = self.Emitter:Add("effects/select_ring", pos)
			particle:SetVelocity(vel)
			particle:SetDieTime(0.4)
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(2)
			particle:SetEndSize(72)
			particle:SetAngles(fwdang)
			particle:SetColor(r, g, b)
		end
	end

	local delta = math.max(0, self.StartCharge - ct)
	self:SetModelScale(Vector(4, 4, 4))
	self:SetMaterial("models/shiny")
	self:SetColor(r, g, b, 90 - delta * 180)

	self:SetAngles(Angle(ct * 360, 0, 0))
	self:DrawModel()
end
