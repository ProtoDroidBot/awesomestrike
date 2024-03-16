function EFFECT:Think()
	local ct = CurTime()
	if self.DieTime <= ct then
		local mypos = self.Entity:GetPos()

		WorldSound("ambient/machines/floodgate_stop1.wav", mypos, 72, math.random(230, 240))

		local emitter = ParticleEmitter(mypos)
		emitter:SetNearClip(10, 20)
		for _, pos in pairs(self.PartPos) do
			local dlight = DynamicLight(dlightcounter)
			if dlight then
				dlight.Pos = pos
				dlight.r = math.Rand(150, 255)
				dlight.g = math.Rand(150, 255)
				dlight.b = math.Rand(150, 255)
				dlight.Brightness = math.Rand(5, 6)
				dlight.Decay = 700
				dlight.Size = 200
				dlight.DieTime = ct + 0.3
			end
			dlightcounter = dlightcounter + 1

			for i=1, math.Rand(30, 45) do
				local particle = emitter:Add("sprites/glow04_noz", pos)
				particle:SetVelocity(VectorRand():Normalize() * math.Rand(128, 450))
				particle:SetCollide(true)
				particle:SetBounce(0.75)
				particle:SetGravity(Vector(0,0,-600))
				particle:SetDieTime(math.Rand(2, 2.5))
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(16)
				particle:SetEndSize(16)
				particle:SetRoll(math.Rand(0, 360))
				particle:SetRollDelta(math.Rand(-60, 60))
				local ran = math.random(1, 4)
				if ran == 1 then
					particle:SetColor(30, 255, 30)
				elseif ran == 2 then
					particle:SetColor(20, 40, 255)
				elseif ran == 3 then
					particle:SetColor(255, 20, 20)
				else
					particle:SetColor(math.random(160, 255), math.random(160, 255), math.random(160, 255))
				end
			end
		end
		return false
	end
	return true
end

function EFFECT:Render()
end

local endseizure = 0
local function SeizureTime()
	local ct = CurTime()
	if endseizure <= ct then
		MySelf:SetDSP(0, false)
		hook.Remove("HUDPaint", "seizuregrenade")
	else
		local mul = RealTime() * 10
		surface.SetDrawColor(math.sin(mul) * 100 + 150, math.cos(mul) * 100 + 150, math.sin(math.cos(mul)) * 100 + 150, math.min(255, (endseizure - ct) * 255))
		surface.DrawRect(0, 0, w, h)
		local ang = VectorRand():Angle()
		ang.roll = 0
		MySelf:SetEyeAngles(ang)
	end
end

function EFFECT:Init(data)
	self.PartPos = {}
	self.DieTime = CurTime() + 0.5

	local pos = data:GetOrigin()
	local ownerid = math.Round(data:GetMagnitude())
	local teamid = math.Round(data:GetScale())

	WorldSound("ambient/explosions/explode_8.wav", pos, 70, math.random(230, 250))

	if MySelf and MySelf:IsValid() and MySelf:Alive() and (MySelf:Team() ~= teamid or ownerid == MySelf:EntIndex()) then
		local eyepos = MySelf:EyePos()
		local dist = pos:Distance(eyepos)
		if dist <= 275 and TrueVisible(pos, eyepos) then
			MySelf:SetDSP(6, false)
			endseizure = CurTime() + math.max(1.25, (275 - dist) * 0.03)
			hook.Add("HUDPaint", "seizuregrenade", SeizureTime)
		end
	end

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(10, 20)
	for i=1, 5 do
		local particle = emitter:Add("sprites/glow04_noz", pos)
		local heading = VectorRand():Normalize()
		particle:SetVelocity(heading * 1024)
		table.insert(self.PartPos, pos + heading * 256)
		particle:SetDieTime(0.25)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(64)
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-60, 60))
		local ran = math.random(1, 4)
		if ran == 1 then
			particle:SetColor(30, 255, 30)
		elseif ran == 2 then
			particle:SetColor(20, 40, 255)
		elseif ran == 3 then
			particle:SetColor(255, 20, 20)
		else
			particle:SetColor(math.random(160, 255), math.random(160, 255), math.random(160, 255))
		end
	end

	local particle = emitter:Add("effects/select_ring", pos)
	particle:SetDieTime(0.5)
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize(2)
	particle:SetEndSize(300)
	particle:SetRoll(math.Rand(0, 360))
	particle:SetRollDelta(180)
	particle:SetAngles(Angle(0,0,0))

	local particle = emitter:Add("effects/select_ring", pos)
	particle:SetDieTime(0.5)
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize(2)
	particle:SetEndSize(300)
	particle:SetRoll(math.Rand(0, 360))
	particle:SetRollDelta(180)
	particle:SetAngles(Angle(90,0,0))

	local particle = emitter:Add("effects/select_ring", pos)
	particle:SetDieTime(0.5)
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize(2)
	particle:SetEndSize(300)
	particle:SetRoll(math.Rand(0, 360))
	particle:SetRollDelta(180)
	particle:SetAngles(Angle(90,90,0))

	emitter:Finish()
end
