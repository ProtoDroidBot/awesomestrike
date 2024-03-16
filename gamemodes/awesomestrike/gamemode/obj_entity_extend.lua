local meta = FindMetaTable("Entity")
if not meta then return end

if SERVER then
	function meta:SetModelScale(vec)
		if not self.vOriginalModelScaleMin then
			self.vOriginalModelScaleMin = self:OBBMins()
			self.vOriginalModelScaleMax = self:OBBMaxs()
		end

		local minv = self.vOriginalModelScaleMin * vec
		local maxv = self.vOriginalModelScaleMax * vec
		self:PhysicsInitBox(minv, maxv)
		--self:SetCollisionBounds(minv, maxv)

		self.vModelScale = vec
		self.BR = self:BoundingRadius()
	end

	function meta:GetModelScale()
		return self.vModelScale or Vector(1, 1, 1)
	end
end

local meta = FindMetaTable("Weapon")
if not meta then return end

function meta:GetNextPrimaryFire()
	return self.m_NextPrimaryFire or 0
end

function meta:GetNextSecondaryFire()
	return self.m_NextSecondaryFire or 0
end

meta.OldSetNextPrimaryFire = meta.SetNextPrimaryFire
function meta:SetNextPrimaryFire(fTime)
	self.m_NextPrimaryFire = fTime
	self:OldSetNextPrimaryFire(fTime)
end

meta.OldSetNextSecondaryFire = meta.SetNextSecondaryFire
function meta:SetNextSecondaryFire(fTime)
	self.m_NextSecondaryFire = fTime
	self:OldSetNextSecondaryFire(fTime)
end

function meta:SetNextReload(fTime)
	self.m_NextReload = fTime
end

function meta:GetNextReload()
	return self.m_NextReload or 0
end
