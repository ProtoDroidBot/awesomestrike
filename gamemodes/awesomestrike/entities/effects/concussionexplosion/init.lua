function EFFECT:Init(data)
	local normal = data:GetNormal() * -1
	local pos = data:GetOrigin()

	WorldSound("npc/roller/mine/rmine_explode_shock1.wav", pos, 78, math.Rand(78, 85))
	WorldSound("npc/roller/mine/rmine_explode_shock1.wav", pos, 78, math.Rand(78, 85))

	self.Emitter = ParticleEmitter(pos)
	self.Emitter:SetNearClip(26, 34)

	self.EndTime = CurTime() + 1
	self.Pos = pos
end

function EFFECT:Think()
	if self.EndTime <= CurTime() then
		self.Emitter:Finish()
		return false
	end

	return true
end

function EFFECT:Render()
	for i=1, 2 do
	local heading = VectorRand():Normalize()
	local particle = self.Emitter:Add("particle/snow", self.Pos + heading * 256)
	particle:SetVelocity(heading * -2500)
	particle:SetGravity(heading * 3000)
	particle:SetDieTime(math.Rand(0.6, 1))
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize(4)
	particle:SetEndSize(math.Rand(50, 100))
	particle:SetRoll(math.Rand(0, 360))
	particle:SetRollDelta(math.Rand(-210, 210))
	particle:SetAirResistance(30)
	particle:SetColor(255, 255, 60)
	end
end
