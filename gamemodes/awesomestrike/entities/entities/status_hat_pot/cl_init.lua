include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetModel("models/props_interiors/pot02a.mdl")
	self:SetRenderBounds(Vector(-40, -40, -18), Vector(40, 40, 84))
end

function ENT:Draw()
	if not DISPLAYHATS then return end
	local owner = self:GetOwner()
	if not owner:IsValid() or owner == MySelf and not (NOX_VIEW or GetViewEntity() ~= MySelf) and owner:Alive() then return end

	if owner:GetRagdollEntity() then
		owner = owner:GetRagdollEntity()
	elseif not owner:Alive() then return end

	self:SetModelScale(Vector(1.25, 1.25, 1.25))

	local boneindex = owner:LookupBone("ValveBiped.Bip01_Head1")
	if boneindex then
		local pos, ang = owner:GetBonePosition(boneindex)
		if pos and pos ~= owner:GetPos() then
			local r,g,b,a = owner:GetColor()
			self:SetColor(r,g,b,math.max(1,a))
			self:SetPos(pos + ang:Forward() * 5.5 + ang:Up() * 6.5)
			ang:RotateAroundAxis(ang:Right(), 90)
			ang:RotateAroundAxis(ang:Up(), 90)
			self:SetAngles(ang)
			self:DrawModel()
			return
		end
	end

	local attach = owner:GetAttachment(owner:LookupAttachment("eyes"))
	if not attach then attach = owner:GetAttachment(owner:LookupAttachment("head")) end
	if attach then
		local ang = attach.Ang
		self:SetPos(attach.Pos + ang:Forward() * -3 + ang:Right() * 7 + ang:Up() * 3)
		ang:RotateAroundAxis(ang:Forward(), 180)
		ang:RotateAroundAxis(ang:Up(), 180)
		self:SetAngles(ang)
		local r,g,b,a = owner:GetColor()
		self:SetColor(r,g,b,math.max(1,a))
		self:DrawModel()
	end
end
