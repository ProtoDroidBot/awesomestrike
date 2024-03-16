function EFFECT:Init(data)
	local normal = data:GetNormal() * -1
	local pos = data:GetOrigin()
	self.DieTime = CurTime() + 0.75
	util.Decal("FadingScorch", pos + normal, pos - normal)
	pos = pos + normal * 2
	self.Pos = pos
	self.Norm = normal
	self.Entity:SetRenderBoundsWS(pos + Vector(-400, -400, -400), pos + Vector(400, 400, 400))

	WorldSound("ambient/explosions/explode_"..math.random(1,5)..".wav", pos, 72, math.Rand(125, 160))

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(80, 100)
	for i=1, 10 do
		local dir = (VectorRand() + normal):Normalize()
		local particle = emitter:Add("particle/smokestack", pos + dir * 8)
		particle:SetVelocity(dir * math.Rand(40, 90))
		particle:SetDieTime(math.Rand(3.5, 4))
		particle:SetStartAlpha(240)
		particle:SetEndAlpha(0)
		particle:SetStartSize(math.Rand(5, 7))
		particle:SetEndSize(math.Rand(20, 35))
		particle:SetColor(40, 100, 40)
		particle:SetRoll(math.Rand(0, 359))
		particle:SetRollDelta(math.Rand(-1, 1))
		particle:SetAirResistance(math.Rand(25, 30))

		local particle = emitter:Add("effects/fire_cloud1", pos + dir * 8)
		particle:SetVelocity(dir * math.Rand(35, 45))
		particle:SetDieTime(math.Rand(1, 1.8))
		particle:SetStartAlpha(240)
		particle:SetEndAlpha(0)
		particle:SetStartSize(2)
		particle:SetEndSize(math.Rand(15, 25))
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-0.5, 0.5))
		particle:SetAirResistance(50)
	end
	emitter:Finish()
end

function EFFECT:Think()
	return CurTime() < self.DieTime
end

local matRing = Material("effects/select_ring")
function EFFECT:Render()
	local ct = CurTime()
	if ct < self.DieTime then
		render.SetMaterial(matRing)
		local size = (0.75 - (self.DieTime - ct)) * 92
		local col = Color(30, 255, 5, math.min(255, (self.DieTime - ct) * 560))
		render.DrawQuadEasy(self.Pos, self.Norm, size, size, col, 0)
		render.DrawQuadEasy(self.Pos, self.Norm * -1, size, size, col, 0)
	end
end
