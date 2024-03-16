include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-40, -40, -18), Vector(40, 40, 80))

	self:EmitSound("npc/ministrider/ministrider_fire1.wav", 70, 130)

	self.Forward = Vector(0,0,1)

	local owner = self:GetOwner()
	if not owner:IsValid() then return end

	local vForward = owner:GetForward()
	vForward.z = 0
	self.Forward = vForward:Normalize()

	local emitter = ParticleEmitter(self:GetPos())
	emitter:SetNearClip(14, 24)

	owner.WallJumping = self
	self.Emitter = emitter
end

function ENT:OnRemove()
	local owner = self:GetOwner()
	if owner:IsValid() then
		owner.WallJumping = nil

		if owner:Alive() then
			local wallhitnormal = self.Forward * -1

			local emitter = self.Emitter

			local boneindex = owner:LookupBone("valvebiped.bip01_l_foot")
			if boneindex then
				local pos, _ = owner:GetBonePosition(boneindex)
				if pos then
					--local tr = util.TraceLine({start = pos, endpos = self.Forward * 32, filter = owner, mask = MASK_SOLID})
					--pos = tr.HitPos + tr.HitNormal

					local ang = wallhitnormal:Angle()
					ang:RotateAroundAxis(ang:Right(), 90)
					local upang = ang:Up()
					for i=1, 45 do
						ang:RotateAroundAxis(upang, 8)
						local heading = ang:Forward()

						local particle = emitter:Add("effects/yellowflare", pos + heading)
						particle:SetVelocity(heading * 128)
						particle:SetAirResistance(150)
						particle:SetDieTime(math.Rand(1, 1.5))
						particle:SetStartAlpha(255)
						particle:SetEndAlpha(0)
						particle:SetStartSize(6)
						particle:SetEndSize(0)
						particle:SetRoll(math.Rand(0, 360))
						particle:SetRollDelta(math.Rand(-100, -50))
					end
				end
			end

			local boneindex2 = owner:LookupBone("valvebiped.bip01_r_foot")
			if boneindex2 then
				local pos, _ = owner:GetBonePosition(boneindex2)
				if pos then
					--local tr = util.TraceLine({start = pos, endpos = self.Forward * 32, filter = owner, mask = MASK_SOLID})
					--pos = tr.HitPos + tr.HitNormal

					local ang = wallhitnormal:Angle()
					ang:RotateAroundAxis(ang:Right(), 90)
					local upang = ang:Up()
					for i=1, 45 do
						ang:RotateAroundAxis(upang, 8)
						local heading = ang:Forward()

						local particle = emitter:Add("effects/yellowflare", pos + heading)
						particle:SetVelocity(heading * 128)
						particle:SetAirResistance(150)
						particle:SetDieTime(math.Rand(1, 1.5))
						particle:SetStartAlpha(255)
						particle:SetEndAlpha(0)
						particle:SetStartSize(6)
						particle:SetEndSize(0)
						particle:SetRoll(math.Rand(0, 360))
						particle:SetRollDelta(math.Rand(50, 100))
					end
				end
			end
		end
	end

	if self.Emitter then
		self.Emitter:Finish()
	end
end

function ENT:Think()
end

function ENT:DrawTranslucent()
	local owner = self:GetOwner()
	if owner:IsValid() then
		local boneindex = owner:LookupBone("valvebiped.bip01_l_foot")
		if boneindex then
			local pos, ang = owner:GetBonePosition(boneindex)
			if pos then
				local particle = self.Emitter:Add("sprites/glow04_noz", pos)
				particle:SetVelocity(VectorRand():Normalize() * math.Rand(64, 128))
				particle:SetDieTime(math.Rand(0.3, 0.5))
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(8)
				particle:SetEndSize(0)
				particle:SetRoll(math.Rand(0, 360))
				particle:SetRollDelta(math.Rand(-150, 150))
				particle:SetCollide(true)
				particle:SetBounce(0.85)
			end
		end

		local boneindex2 = owner:LookupBone("valvebiped.bip01_r_foot")
		if boneindex2 then
			local pos, ang = owner:GetBonePosition(boneindex2)
			if pos then
				local particle = self.Emitter:Add("sprites/glow04_noz", pos)
				particle:SetVelocity(VectorRand():Normalize() * math.Rand(64, 128))
				particle:SetDieTime(math.Rand(0.3, 0.5))
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(8)
				particle:SetEndSize(0)
				particle:SetRoll(math.Rand(0, 360))
				particle:SetRollDelta(math.Rand(-150, 150))
				particle:SetCollide(true)
				particle:SetBounce(0.85)
			end
		end
	end
end
