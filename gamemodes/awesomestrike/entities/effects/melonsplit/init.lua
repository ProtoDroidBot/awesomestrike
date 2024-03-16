function EFFECT:Init(data)
	local pos = data:GetOrigin()
	WorldSound("weapons/stinger_fire1.wav", pos, 70, 130)

	local normal = data:GetNormal()

	local ang = normal:Angle()
	ang:RotateAroundAxis(ang:Right(), 90)
	local upang = ang:Up()

	local emitter = ParticleEmitter(pos + Vector(0,0,4))
	for i=1, 45 do
		ang:RotateAroundAxis(upang, 8)

		local fwd = ang:Forward()

		local particle = emitter:Add("sprites/glow04_noz", pos + fwd * 8)
		particle:SetVelocity(fwd * 300)
		particle:SetDieTime(0.4)
		particle:SetStartAlpha(200)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(48)
		particle:SetRoll(math.Rand(0, 20))
		particle:SetRollDelta(math.Rand(-5, 5))
		particle:SetColor(30, 255, 5)
	end

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
