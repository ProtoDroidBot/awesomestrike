include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-40, -40, -18), Vector(40, 40, 90))

	self.Emitter = ParticleEmitter(self:GetPos())
	self.Emitter:SetNearClip(40, 50)
	self.NextEmit = 0
end

function ENT:OnRemove()
	self.Emitter:Finish()
end

function ENT:Think()
	local owner = self:GetOwner()
	if owner:IsValid() then self:SetPos(owner:EyePos()) end
	self.Emitter:SetPos(self:GetPos())
end

function ENT:DrawTranslucent()
	if not DISPLAYHATS then return end
	local owner = self:GetOwner()
	if not owner:IsValid() or owner == MySelf and not (NOX_VIEW or GetViewEntity() ~= MySelf) and owner:Alive() then return end

	if owner:GetRagdollEntity() then
		owner = owner:GetRagdollEntity()
	elseif not owner:Alive() then return end

	local pos, ang

	local boneindex = owner:LookupBone("ValveBiped.Bip01_Head1")
	if boneindex then
		pos, ang = owner:GetBonePosition(boneindex)
		local r,g,b,a = owner:GetColor()
		self:SetColor(r,g,b,math.max(1,a))
		self:SetPos(pos + ang:Forward() * 4)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Right(), 180)
		ang:RotateAroundAxis(ang:Forward(), 90)
		self:SetAngles(ang)
		self:SetModelScale(Vector(2.2, 2.2, 2.2))
		self:DrawModel()
	else
		local attach = owner:GetAttachment(owner:LookupAttachment("eyes"))
		if not attach then attach = owner:GetAttachment(owner:LookupAttachment("head")) end
		if attach then
			local r,g,b,a = owner:GetColor()
			self:SetColor(r,g,b,a)
			self:SetAngles(attach.Ang)
			self:SetModelScale(Vector(2.2, 2.2, 2.2))
			pos = attach.Pos
			self:SetPos(pos)
			self:DrawModel()
		end
	end

	local r, g, b, a = owner:GetColor()
	if pos and 180 < a then
		local emitter = self.Emitter
		for i=1, 2 do
			local vec = VectorRand()
			vec.z = math.abs(vec.z)
			vec = vec:Normalize() * math.Rand(8, 32)

			local particle = emitter:Add("noxctf/sprite_flame", pos)
			particle:SetVelocity(vec)
			particle:SetDieTime(math.Rand(0.7, 1.25))
			particle:SetStartAlpha(230)
			particle:SetEndAlpha(0)
			particle:SetStartSize(math.Rand(5, 10))
			particle:SetEndSize(0)
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand(-5, 5))

			local particle2 = emitter:Add("noxctf/sprite_flame", pos)
			particle2:SetVelocity(vec)
			particle2:SetDieTime(math.Rand(0.85, 1.5))
			particle2:SetStartAlpha(0)
			particle2:SetEndAlpha(150)
			particle2:SetStartSize(math.Rand(5, 10))
			particle2:SetEndSize(0)
			particle2:SetRoll(math.Rand(0, 360))
			particle2:SetRollDelta(math.Rand(5, 5))
			particle2:SetColor(math.Rand(0, 50), math.Rand(0, 50), math.Rand(0, 50))
		end
	end
end
