function EFFECT:Init(data)
	local ent = data:GetEntity()

	ent:EmitSound("npc/antlion/foot"..math.random(1,4)..".wav", 64, math.random(120, 135))

	local pos = ent:GetPos()
	local normal = util.TraceLine({start = pos + Vector(0,0,4), endpos = pos + Vector(0,0,-32), filter = ent, mask = MASK_SOLID}).HitNormal

	local ang = normal:Angle()
	ang:RotateAroundAxis(ang:Right(), 90)
	local upang = ang:Up()

	local emitter = ParticleEmitter(pos + Vector(0,0,4))
	for i=1, 45 do
		ang:RotateAroundAxis(upang, 8)

		local fwd = ang:Forward()

		local particle = emitter:Add("particle/smokestack", pos + fwd * 8)
		particle:SetVelocity(fwd * 128)
		particle:SetDieTime(0.4)
		particle:SetStartAlpha(140)
		particle:SetEndAlpha(0)
		particle:SetStartSize(2)
		particle:SetEndSize(25)
		particle:SetRoll(math.Rand(0, 20))
		particle:SetRollDelta(math.Rand(-5, 5))
		particle:SetColor(200, 200, 200)
	end

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
