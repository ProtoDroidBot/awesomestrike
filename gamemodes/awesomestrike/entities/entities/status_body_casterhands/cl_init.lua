include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-40, -40, -18), Vector(40, 40, 84))
end

local matGlow = Material("sprites/glow04_noz")
local matGlow2 = Material("effects/yellowflare")
function ENT:DrawTranslucent()
	if not DISPLAYHATS then return end
	local owner = self:GetOwner()
	if not owner:IsValid() or owner == MySelf and not (NOX_VIEW or GetViewEntity() ~= MySelf) and owner:Alive() then return end

	if owner:GetRagdollEntity() then
		owner = owner:GetRagdollEntity()
	elseif not owner:Alive() then return end

	local r,g,b,a = owner:GetColor()
	if a < 200 then return end

	render.SetMaterial(matGlow)
	local iRHBone = owner:LookupBone("ValveBiped.Bip01_R_Hand")
	local iLHBone = owner:LookupBone("ValveBiped.Bip01_L_Hand")
	local RBonePos, RBoneAng = owner:GetBonePosition(iRHBone)
	local LBonePos, LBoneAng = owner:GetBonePosition(iLHBone)
	render.DrawSprite(RBonePos, 24 + math.Rand(8, 14), 24 + math.Rand(8, 14), COLOR_RED)
	render.DrawSprite(LBonePos, 24 + math.Rand(8, 14), 24 + math.Rand(8, 14), COLOR_LIMEGREEN)

	render.SetMaterial(matGlow2)
	RBoneAng:RotateAroundAxis(RBoneAng:Right(), RealTime() * 360)
	render.DrawSprite(RBonePos + RBoneAng:Forward() * 8, 8, 8, color_white)
	LBoneAng:RotateAroundAxis(LBoneAng:Right(), RealTime() * 360)
	render.DrawSprite(LBonePos + LBoneAng:Forward() * 8, 8, 8, color_white)
end
