include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-40, -40, -16), Vector(40, 40, 48))

	self:SetModelScale(Vector(1, 1.3, 1))

	local owner = self:GetOwner()
	if owner:IsValid() then
		local attach = owner:LookupAttachment("eyes")
		if not attach then attach = owner:LookupAttachment("head") end

		self.Attach = attach
	end
end

function ENT:Draw()
	if not DISPLAYHATS then return end
	local owner = self:GetOwner()
	if not owner:IsValid() or owner == MySelf and not (NOX_VIEW or GetViewEntity() ~= MySelf) and owner:Alive() then return end

	if owner:GetRagdollEntity() then
		owner = owner:GetRagdollEntity()
	elseif not owner:Alive() then return end

	--self:SetModelScale(Vector(1, 1.3, 1))

	--[[local boneindex = owner:LookupBone("ValveBiped.Bip01_Head1")
	if boneindex then
		local pos, ang = owner:GetBonePosition(boneindex)
		if pos and pos ~= owner:GetPos() then
			local r,g,b,a = owner:GetColor()
			self:SetColor(r,g,b,math.max(1,a))
			self:SetPos(pos + ang:Forward() * 3)
			ang:RotateAroundAxis(ang:Right(), -90)
			ang:RotateAroundAxis(ang:Up(), -90)
			self:SetAngles(ang)
			self:DrawModel()
			return
		end
	end]]

	local attach = owner:GetAttachment(self.Attach)
	if attach then
		self:SetPos(attach.Pos + attach.Ang:Forward() * -4 + attach.Ang:Up() * -1)
		self:SetAngles(attach.Ang)
		local r,g,b,a = owner:GetColor()
		self:SetColor(r,g,b,math.max(1,a))
		self:DrawModel()
	end
end
