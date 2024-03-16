function EFFECT:Init(data)
	local pos = data:GetOrigin()

	util.Decal("Scorch", pos + Vector(0,0,1), pos + Vector(0,0,-1))

	self.BeginSmoke = CurTime() + 0.5

	local emitter = ParticleEmitter(pos)
	self.Emitter = emitter
	emitter:SetNearClip(40, 50)

	for i=1, 32 do
		local heading = VectorRand():Normalize()

		local particle = emitter:Add("effects/fire_cloud"..math.random(1, 2), pos + heading * 128)
		particle:SetVelocity(heading * math.Rand(500, 1200))
		particle:SetDieTime(math.Rand(2, 4))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(256)
		particle:SetEndSize(1024)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-1, 1))
		particle:SetColor(255, 255, 255)
		particle:SetAirResistance(math.Rand(50, 150))
	end
end

function EFFECT:Think()
	if self.BeginSmoke <= CurTime() then
		local emitter = self.Emitter
		for i=1, 16 do
			local particle = emitter:Add("particle/smokestack", self.Entity:GetPos() + VectorRand():Normalize() * math.Rand(128, 256))
			particle:SetVelocity(VectorRand() * 256)
			particle:SetDieTime(math.Rand(12, 14))
			particle:SetStartAlpha(64)
			particle:SetEndAlpha(0)
			particle:SetStartSize(0)
			particle:SetEndSize(768)
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand( -1, 1))
			particle:SetColor(128, 128, 128)
			particle:SetAirResistance(100)
		end

		emitter:Finish()
		return false
	end

	return true
end

function EFFECT:Render()
end
