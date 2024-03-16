EFFECT.Time = math.Rand(5, 10)

function EFFECT:Init(data)
	local bTypePlayer = data:GetEntity()
	if not bTypePlayer:IsValid() then self.DeathTime = 0 return end

	self.NextEmit = 0

	local modelid = data:GetMagnitude()

	self.Emitter = ParticleEmitter(self:GetPos())

	self.Entity:SetModel(HumanGibs[modelid])

	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self.Entity:SetCollisionBounds(Vector(-128 -128, -128), Vector(128, 128, 128))

	local bType = data:GetRadius()
	self.bType = bType
	if bType == 0 and modelid > 4 then
		self.Entity:SetMaterial("models/flesh")
	elseif bType == 1 then
		self.Entity:SetColor(0, 255, 0, 255)
	elseif bType == 2 then
		self.Entity:SetColor(20, 60, 255, 255)
	elseif bType == 3 then
		self.Entity:SetColor(math.random(100, 255), math.random(100, 255), math.random(100, 255), 255)
	elseif bType == 4 then
		self.Entity:SetMaterial("models/shiny")
	elseif bType == 5 then
		self.Entity:SetColor(5, 5, 5, 255)
	end

	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetAngle(Angle(math.Rand(0,360), math.Rand(0,360), math.Rand(0,360)))
		phys:ApplyForceCenter(VectorRand() * math.Rand(4000, 9000) + Vector(0,0,3500))
	end
	self.DeathTime = RealTime() + 11

	self.Effects = data:GetScale()
end

function EFFECT:Think()
	if self.DeathTime < RealTime() then
		self.Emitter:Finish()
		return false
	end

	self.Emitter:SetPos(self.Entity:GetPos())

	return true
end

function EFFECT:Render()
	self.Entity:DrawModel()

	if CurTime() < self.NextEmit then return end
	self.NextEmit = CurTime() + 0.09

	local bType = self.bType

	local vel = self.Entity:GetVelocity():Length()

	if vel > 20 or self.Effects == DMGTYPE_FIRE then
		local emitter = self.Emitter

		if vel > 20 then
			local particle
			if bType == 4 then
				particle = emitter:Add("sprites/glow04_noz", self.Entity:GetPos())
			else
				particle = emitter:Add("noxctf/sprite_bloodspray"..math.random(1,8), self.Entity:GetPos())
			end
			particle:SetVelocity(VectorRand() * 16)
			particle:SetDieTime(0.6)
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(18)
			particle:SetEndSize(8)
			particle:SetRoll(180)
			if bType == 3 then
				particle:SetColor(math.random(100, 255), math.random(100, 255), math.random(100, 255))
			elseif bType == 2 then
				particle:SetColor(20, 60, 255)
			elseif bType == 1 then
				particle:SetColor(80, 255, 0)
				particle:SetLighting(true)
			elseif bType == 5 then
				particle:SetColor(5, 5, 5)
			elseif bType ~= 4 then
				particle:SetColor(255, 0, 0)
				particle:SetLighting(true)
			end
		end

		if self.Effects == DMGTYPE_FIRE then
			local particle = emitter:Add("effects/fire_embers"..math.random(1,3), self.Entity:GetPos())
			particle:SetDieTime(0.5)
			particle:SetVelocity(VectorRand():Normalize() * math.Rand(-8, 8) + Vector(0,0,8))
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(60)
			particle:SetStartSize(math.Rand(8, 16))
			particle:SetEndSize(8)
			particle:SetRoll(math.random(0, 360))
		end
	end
end
