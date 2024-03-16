include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_debris/metal_panel02a.mdl")
	self:SetRenderBounds(Vector(-130, -130, -130), Vector(130, 130, 130))
	self:SetMaterial("models/props_lab/Tank_Glass001")
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
				self:SetColor(r, g, b, math.min(170, math.max(1, a)))
				self:SetPos(pos + ang:Forward() * 22)
				self:SetAngles(ang)
				self:DrawModel()
			end
		end
	end

	self:DrawModel()
end
