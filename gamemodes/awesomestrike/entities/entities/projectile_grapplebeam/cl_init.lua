include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-60, -60, -60), Vector(60, 60, 60))
	self.Col = Color(self:GetColor())

	self:GetOwner().GrappleBeam = self
end

function ENT:Think()
	local owner = self:GetOwner()
	if owner:IsValid() then
		self:SetRenderBoundsWS(self:GetPos(), owner:GetShootPos(), Vector(32, 32, 32))
	end
end

function ENT:OnRemove()
	self:GetOwner().GrappleBeam = nil
end

local matBeam = Material("effects/laser1")
function ENT:Draw()
	local vel = self:GetVelocity()
	if 10 < vel:Length() then
		self:SetAngles(vel:Angle())
	end
	self:DrawModel()

	local owner = self:GetOwner()
	if not owner:IsValid() then return end

	local startpos
	--if MySelf == owner then
		local wep = owner:GetActiveWeapon()
		if wep:IsValid() then
			local attach
			if MySelf == owner and not NOX_VIEW then
				attach = owner:GetViewModel():GetAttachment(1)
			else
				attach = wep:GetAttachment(1)
			end
			if attach then
				startpos = attach.Pos
			end
		end
	--end	

	startpos = startpos or owner:GetShootPos()

	render.SetMaterial(matBeam)
	local pos = self:GetPos()
	render.DrawBeam(pos, startpos, 5, 1, 0, color_white)
	render.DrawBeam(pos, startpos, 2.5, 1, 0, color_white)
end
