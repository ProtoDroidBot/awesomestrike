include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-16, -16, -36), Vector(16, 16, 36))
end

local matSmile = Material("mario/boxsmile")
local colSmile = Color(255, 255, 255, 255)
function ENT:DrawTranslucent()
	if not DISPLAYHATS then return end
	local owner = self:GetOwner()
	if not owner:IsValid() or owner == MySelf and not (NOX_VIEW or GetViewEntity() ~= MySelf) and owner:Alive() then return end

	if owner:GetRagdollEntity() then
		owner = owner:GetRagdollEntity()
	elseif not owner:Alive() then return end

	local attachid = owner:LookupAttachment("mouth")
	if attachid == 0 then return end
	local attach = owner:GetAttachment(attachid)
	local fwd = attach.Ang:Forward()
	local pos = attach.Pos + fwd * 0.18 + attach.Ang:Up() * 0.65
	local r,g,b,a = owner:GetColor()
	colSmile.a = math.max(1, a)
	render.SetMaterial(matSmile)
	render.DrawQuadEasy(pos, fwd, 4, 4, colSmile, 180)
	render.DrawQuadEasy(pos, fwd * -1, 4, 4, colSmile, 180)
end
