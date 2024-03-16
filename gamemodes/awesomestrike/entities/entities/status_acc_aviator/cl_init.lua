include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-16, -16, -36), Vector(16, 16, 36))
end

function ENT:DrawTranslucent()
	if not DISPLAYHATS then return end
	local owner = self:GetOwner()
	if not owner:IsValid() or owner == MySelf and not (NOX_VIEW or GetViewEntity() ~= MySelf) and owner:Alive() then return end

	if owner:GetRagdollEntity() then
		owner = owner:GetRagdollEntity()
	elseif not owner:Alive() then return end

	local attachid = owner:LookupAttachment("eyes")
	if attachid == 0 then return end
	local attach = owner:GetAttachment(attachid)
	local ang = attach.Ang
	self:SetPos(attach.Pos + ang:Forward() * -1.75 + ang:Up() * -2)
	self:SetAngles(ang)
	local r,g,b,a = owner:GetColor()
	self:SetColor(255, 255, 255, math.max(1, a))
	self:DrawModel()
end
