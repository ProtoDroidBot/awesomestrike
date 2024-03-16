include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/oildrum001_explosive.mdl")
	self:SetRenderBounds(Vector(-80, -80, -32), Vector(80, 80, 120))
end

function ENT:Draw()
	local owner = self:GetOwner()
	if owner:IsValid() then
		local rag = owner:GetRagdollEntity()
		if rag then
			owner = rag
		elseif not owner:Alive() then return end

		local boneindex = owner:LookupBone("valvebiped.bip01_r_hand")
		if boneindex then
			local pos, ang = owner:GetBonePosition(boneindex)
			if pos then
				local r,g,b,a = owner:GetColor()
				self:SetColor(255, 255, 255, math.max(1, a))
				self:SetPos(pos + ang:Forward() * 2)
				ang:RotateAroundAxis(ang:Right(), -90)
				self:SetAngles(ang)
				self:DrawModel()
			end
		end
	end
end
