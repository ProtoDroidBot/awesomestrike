local meta = FindMetaTable("Player")
if not meta then return end

function meta:GetTeamName()
	return team.GetName(self:Team()) or "None"
end

function meta:ConvertNet()
	return ConvertNet(self:SteamID())
end

function meta:TraceLine(distance, _mask)
	local vStart = self:GetShootPos()
	local filt = ents.FindByClass("projectile_*")
	table.insert(filt, self)
	return util.TraceLine({start = vStart, endpos = vStart + self:GetAimVector() * distance, filter = filt, mask = _mask})
end

function meta:Stun(tim, noeffect)
	if noeffect then
		self:GiveStatus("stun_noeffect", tim):SetColor(tim, 255, 255, 255)
	else
		self:GiveStatus("stun", tim):SetColor(tim, 255, 255, 255)
	end
end

function meta:SetLastAttacker(ent)
	self.LastAttacker = ent
	self.LastAttacked = CurTime()
end

function meta:IsBusy()
	local wep = self:GetActiveWeapon()
	if wep:IsValid() and wep:IsBusy() then return true end

	return false
end

if SERVER then
	function meta:DestroyCamera()
		if self.Camera and self.Camera:IsValid() then
			self.Camera:Remove()
			self.Camera = nil
		end

		self:SetViewEntity(self)
		self.NOX_VIEW = nil
		self:SendLua("NOX_VIEW=nil")
	end

	function meta:CreateCamera()
		if self.Camera and self.Camera:IsValid() then
			self.Camera:Remove()
		end

		local ent = ents.Create("isometric_camera")
		if ent:IsValid() then
			ent:SetPos(self:EyePos())
			ent:SetAngles(self:EyeAngles())
			ent:SetOwner(self)
			ent:Spawn()
			ent:SetParent(self)
			self.Camera = self
			self:SetViewEntity(ent)
			self.NOX_VIEW = true
			self:SendLua("NOX_VIEW=true")
		else
			print("Camera creation failed for "..tostring(self).."!!")
		end
	end

	meta.OldDrawViewModel = meta.DrawViewModel
	meta.OldDrawWorldModel = meta.DrawWorldModel

	function meta:DrawViewModel(bDraw)
		self.m_DrawViewModel = bDraw
		self:OldDrawViewModel(bDraw)
	end

	function meta:DrawWorldModel(bDraw)
		self.m_DrawWorldModel = bDraw
		self:OldDrawWorldModel(bDraw)
	end

	function meta:IsFrozen()
		return self.m_IsFrozen
	end

	meta.OldFreeze = meta.Freeze
	function meta:Freeze(bFreeze)
		self.m_IsFrozen = bFreeze
		self:OldFreeze(bFreeze)
	end

	function meta:BloodSpray(pos, num, dir, force)
		if self.DisableBlood then return end

		local effectdata = EffectData()
			effectdata:SetOrigin(pos)
			effectdata:SetMagnitude(num)
			effectdata:SetRadius(self.BloodDye or 0)
			effectdata:SetNormal(dir)
			effectdata:SetScale(force)
			effectdata:SetEntity(self)
		util.Effect("bloodstream", effectdata, true, true)
	end

	function meta:Gib(dmginfo)
		self.Gibbed = true
		local effectdata = EffectData()
			effectdata:SetEntity(self)
			effectdata:SetOrigin(self:EyePos())
			effectdata:SetScale(self.GibEffects)
			effectdata:SetRadius(self.BloodDye or 0)
		util.Effect("gib_player", effectdata, true, true)
	end

	function meta:RemoveAllStatus(bSilent, bInstant)
		if bInstant then
			for _, ent in pairs(ents.FindByClass("status_*")) do
				if not ent.NoRemoveOnDeath and ent:GetOwner() == self then
					ent:Remove()
				end
			end
		else
			for _, ent in pairs(ents.FindByClass("status_*")) do
				if not ent.NoRemoveOnDeath and ent:GetOwner() == self then
					ent.SilentRemove = bSilent
					ent:SetDie()
				end
			end
		end
	end

	function meta:RemoveStatus(sType, bSilent, bInstant)
		local removed
		for _, ent in pairs(ents.FindByClass("status_"..sType)) do
			if ent:GetOwner() == self then
				if bInstant then
					ent:Remove()
				else
					ent.SilentRemove = bSilent
					ent:SetDie()
				end
				removed = true
			end
		end
		return removed
	end

	function meta:GetStatus(sType)
		local ent = self["status_"..sType]
		if ent and ent.Owner == self then return ent end
	end

	function meta:GiveStatus(sType, fDie)
		local cur = self:GetStatus(sType)
		if cur then
			if fDie then
				cur:SetDie(fDie)
			end
			cur:SetPlayer(self, true)
			return cur
		else
			local ent = ents.Create("status_"..sType)
			if ent:IsValid() then
				ent:Spawn()
				if fDie then
					ent:SetDie(fDie)
				end
				ent:SetPlayer(self)
				return ent
			end
		end
	end

	function meta:ForceRespawn()
		self:StripWeapons()
		self.LastDeath = CurTime()
		self:RemoveAllStatus(true, true)
		self:Spawn()
		self.SpawnTime = CurTime()
	end
end

if CLIENT then
	function meta:DrawViewModel(bDraw)
		self.m_DrawViewModel = bDraw
	end

	function meta:DrawWorldModel(bDraw)
		self.m_DrawWorldModel = bDraw
	end

	function meta:GetStatus(sType)
		for _, ent in pairs(ents.FindByClass("status_"..sType)) do
			if ent:GetOwner() == self then return ent end
		end
	end

	function meta:RemoveAllStatus(bSilent, bInstant)
	end

	function meta:RemoveStatus(sType, bSilent, bInstant)
	end

	function meta:GiveStatus(sType, fDie)
	end

	function meta:GetWeapon(wepclass)
		for _, wep in pairs(self:GetWeapons()) do
			if wep:GetClass() == wepclass then
				return wep
			end
		end
	end

	function meta:HasWeapon(wepclass)
		return self:GetWeapon(wepclass) ~= nil
	end
end

local oldalive = meta.Alive
function meta:Alive()
	if self:GetMoveType() == MOVETYPE_OBSERVER or self:Team() == TEAM_SPECTATOR then return false end

	return oldalive(self)
end
