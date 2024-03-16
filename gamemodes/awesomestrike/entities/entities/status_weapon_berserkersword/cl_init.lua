include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/peanut/conansword.mdl")
	self:SetRenderBounds(Vector(-80, -80, -32), Vector(80, 80, 120))

	--self.Ghosts = {}
	--self.NextGhost = 0
end

--[[function ENT:Think()
	if self.NextGhost <= RealTime() then
		self.NextGhost = RealTime() + 0.05

		if 28 < #self.Ghosts then
			table.remove(self.Ghosts, #self.Ghosts)
		end

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
					ang:RotateAroundAxis(ang:Up(), 90)
					table.insert(self.Ghosts, 1, {Pos=pos + ang:Forward() * 3 + ang:Right() * 3, Ang=ang})
				end
			end
		end
	end
end]]

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
				a = math.max(1, a)
				self:SetColor(255, 255, 255, a)
				self:SetPos(pos + ang:Forward() * 3 + ang:Right() * 3)
				ang:RotateAroundAxis(ang:Up(), 90)
				self:SetAngles(ang)
				self:SetModelScale(Vector(1, 1, 1.25))
				self:DrawModel()

				--[[local iTot = #self.Ghosts
				if 0 < iTot then
					self:DrawShadow(false)
					self:SetMaterial("models/shiny")
					for i, tab in ipairs(self.Ghosts) do
						self:SetPos(tab.Pos)
						self:SetAngles(tab.Ang)
						self:SetColor(255, 255, 255, (255 / iTot) * i)
						self:DrawModel()
					end
					self:SetMaterial("")
					self:DrawShadow(true)
				end]]
			end
		end
	end
end
