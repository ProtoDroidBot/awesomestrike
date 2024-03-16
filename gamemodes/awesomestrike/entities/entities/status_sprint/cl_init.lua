include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-40, -40, -18), Vector(40, 40, 80))

	self.Emitter = ParticleEmitter(self:GetPos())
	self.Emitter:SetNearClip(14, 24)

	self:GetOwner().Sprinting = self

	self:EmitSound("sprin.wav", 60, math.random(110, 125))
end

function ENT:OnRemove()
	self:GetOwner().Sprinting = nil

	self.Emitter:Finish()
end

function ENT:Think()
	self.Emitter:SetPos(self:GetPos())
end

local matSprite = Material("sprites/glow04_noz")
function ENT:DrawTranslucent()
	local owner = self:GetOwner()
	if not owner:IsValid() then return end

	render.SetMaterial(matSprite)
	local ct = CurTime()

	local boneindex = owner:LookupBone("valvebiped.bip01_l_foot")
	if boneindex then
		local pos, ang = owner:GetBonePosition(boneindex)
		if pos then
			local sinm = math.sin(ct * 30) * 8 + 16
			render.DrawSprite(pos, sinm, sinm, color_white)
			local particle = self.Emitter:Add("effects/fire_cloud1", pos)
			particle:SetDieTime(math.Rand(0.4, 0.5))
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(255)
			particle:SetStartSize(math.Rand(4, 8))
			particle:SetEndSize(0)
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand(-5, 5))
		end
	end

	local boneindex2 = owner:LookupBone("valvebiped.bip01_r_foot")
	if boneindex2 then
		local pos, ang = owner:GetBonePosition(boneindex2)
		if pos then
			local cosm = math.cos(ct * 30) * 8 + 16
			render.DrawSprite(pos, cosm, cosm, color_white)
			local particle = self.Emitter:Add("effects/fire_cloud1", pos)
			particle:SetDieTime(math.Rand(0.4, 0.5))
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(255)
			particle:SetStartSize(math.Rand(4, 8))
			particle:SetEndSize(0)
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand(-5, 5))
		end
	end
end
