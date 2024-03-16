function EFFECT:Init(data)
	self.Owner = data:GetEntity()
	self.Death = RealTime() + 10
	self:SetRenderBounds(Vector(-128,-128,-128), Vector(128, 128, 128))

	self.Threshold = 0
end

function EFFECT:Render()
	if self.DoDraw and self.Ent:IsValid() then
		self.DoDraw = false
		local ent = self.Ent

		local emitter = ParticleEmitter(ent:GetPos())
		emitter:SetNearClip(50, 60)

		for i=1, ent:GetPhysicsObjectCount() do
			if math.random(0, 2) == 0 then
				local phys = ent:GetPhysicsObjectNum(i)
				if phys and phys:IsValid() then
					if math.random(1, 5) > 1 then
						local particle = emitter:Add("effects/fire_embers"..math.random(1, 3), phys:GetPos())
						particle:SetDieTime(math.Rand(0.4, 0.6))
						particle:SetVelocity(VectorRand():Normalize() * math.Rand(-12, 12) + Vector(0, 0, 12))
						particle:SetStartAlpha(200)
						particle:SetEndAlpha(60)
						particle:SetStartSize(math.Rand(8, 16))
						particle:SetEndSize(2)
						particle:SetRoll(math.Rand(0, 359))
						particle:SetRollDelta(math.Rand(-2, 2))
					else
						local particle = emitter:Add("particles/smokey", phys:GetPos())
						particle:SetDieTime(math.Rand(0.6, 1.0))
						particle:SetVelocity(VectorRand():Normalize() * math.Rand(-12, 12))
						particle:SetGravity(Vector(0, 0, math.Rand(24, 32)))
						particle:SetColor(20, 20, 20)
						particle:SetStartAlpha(130)
						particle:SetEndAlpha(1)
						particle:SetStartSize(2)
						particle:SetEndSize(math.Rand(12, 17))
						particle:SetRoll(math.Rand(0, 359))
						particle:SetRollDelta(math.Rand(-2, 2))
					end
				end
			end
		end

		emitter:Finish()
	end
end

local function ragdoll_BuildBonePositions(ragdoll, NumBones, NumPhysBones)
	local burnscale = math.max(1, ragdoll.BurnEnd - CurTime()) * 0.5
	local vecScale = Vector(burnscale, burnscale, burnscale)
	for i=0, NumBones do
		local matrix = ragdoll:GetBoneMatrix(i)
		if matrix then
			matrix:Scale(vecScale)
			ragdoll:SetBoneMatrix(i, matrix)
		end
	end
end 

function EFFECT:Think()
	local ent = self.Owner

	if not (RealTime() < self.Death and ent and ent:IsValid() and not ent:Alive()) then
		self.Threshold = self.Threshold + FrameTime()
		return self.Threshold < 1
	end

	if ent:IsValid() then
		ent = ent:GetRagdollEntity()
	else
		self.Threshold = self.Threshold + FrameTime()
		return self.Threshold < 1
	end

	if ent then
		ent.Burnt = true
		self.Entity:SetPos(ent:GetPos())
		self.DoDraw = true
		self.Ent = ent
		local r, g, b, a = ent:GetColor()
		r = math.max(20, r - FrameTime() * 200)
		ent:SetColor(r, r, r, a)
		if not ent.BurnEnd then
			ent.BurnEnd = CurTime() + 2
			ent.BuildBonePositions = ragdoll_BuildBonePositions
		end
	else
		self.Threshold = self.Threshold + FrameTime()
		return self.Threshold < 1
	end

	return true
end
