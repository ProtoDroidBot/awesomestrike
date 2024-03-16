include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-32, -32, -8), Vector(32, 32, 72))
	self:SetModelScale(Vector(0.5, 0.5, 0.5))
end

function ENT:Draw()
	if not DISPLAYHATS then return end
	local owner = self:GetOwner()
	if not owner:IsValid() or owner == MySelf and not (NOX_VIEW or GetViewEntity() ~= MySelf) and owner:Alive() then return end

	if owner:GetRagdollEntity() then
		owner = owner:GetRagdollEntity()
	elseif not owner:Alive() then return end

	local attachid = owner:LookupAttachment("anim_attachment_head")
	if attachid == 0 then
		attachid = owner:LookupAttachment("head")
		if attachid == 0 then return end

		local attach = owner:GetAttachment(attachid)
		local ang = attach.Ang
		self:SetPos(attach.Pos + ang:Right() * 4 + ang:Forward() * -7)
		self:SetAngles(ang)
	else
		local attach = owner:GetAttachment(attachid)

		local ang = attach.Ang
		self:SetPos(attach.Pos + ang:Up() * 4 + ang:Right() * -5)
		self:SetAngles(ang)
	end

	local r,g,b,a = owner:GetColor()
	self:SetColor(0, 0, 0, math.max(1, a))
	self:SetMaterial("models/debug/debugwhite")
	self:DrawModel()
end
