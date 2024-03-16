include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-32, -32, -8), Vector(32, 32, 72))
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
		self:SetPos(attach.Pos + ang:Up() * -3 + ang:Right() * 3 + ang:Forward() * -1)
		ang:RotateAroundAxis(ang:Up(), -90)
		ang:RotateAroundAxis(ang:Forward(), 90)
		self:SetAngles(ang)
	else
		local attach = owner:GetAttachment(attachid)

		self:SetPos(attach.Pos)
		self:SetAngles(attach.Ang)
	end

	local r,g,b,a = owner:GetColor()
	self:SetColor(r, g, b, math.max(1, a))
	self:DrawModel()
end
