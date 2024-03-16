AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.BJAStart = CurTime() + 0.25
	pPlayer.BJAEnd = pPlayer.BJAStart + 0.4
end

function ENT:OnRemove()
	local parent = self:GetParent()
	if parent:IsValid() then
		--local hasbjaend = parent.BJAEnd
		parent.BJAEnd = nil
		parent.BJAStart = nil
		parent:SetFOV(parent:GetInfo("fov_desired"), 0.2)

		if parent:Alive() then
			parent:Stun(0.5, true)
		end
	end
end

function ENT:Think()
	local ct = CurTime()
	local owner = self:GetOwner()

	if owner:IsOnGround() or owner.BJAEnd <= ct then
		owner:SetLocalVelocity(Vector(0,0,0))

		local explodepos = owner:GetPos() + owner:GetForward() * 15.9 + Vector(0,0,0.1)
		for _, ent in pairs(ents.FindInSphere(explodepos, 110)) do
			if ent:IsPlayer() and ent ~= owner and ent:Alive() and TrueVisible(ent:NearestPoint(explodepos), explodepos) then
				if IsGuardStun(owner, ent) then
					Guarded(owner, ent, 1)
					self:Remove()
					return
				end
			end
		end

		owner:RestartGesture(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE)

		owner:GodEnable()
		owner.DisableBlood = true
		util.BlastDamage(self, owner, explodepos, 100, 48)
		owner.DisableBlood = false
		owner:GodDisable()

		local effectdata = EffectData()
			effectdata:SetOrigin(explodepos)
			local tr = util.TraceLine({start = explodepos, endpos = explodepos + Vector(0,0,-48), mask = MASK_SOLID, filter = owner})
			local hitnormal = tr.HitNormal
			if hitnormal:Length() <= 0 then
				effectdata:SetNormal(Vector(0,0,1))
			else
				effectdata:SetNormal(hitnormal)
				--[[local ent = ents.Create("env_fire")
				if ent:IsValid() then
					ent:SetPos(tr.HitPos)
					ent:SetKeyValue("health", 5)
					ent:SetKeyValue("firesize", 50)
					ent:SetKeyValue("damagescale", -10)
					ent:SetKeyValue("spawnflags", "2")
					ent:Spawn()
					ent:Fire("Enable", "", 0)
					ent:Fire("StartFire", "", 0.01)
					ent:Fire("kill", "", 6)
				end]]
			end
		util.Effect("bjumpattack", effectdata)

		self:Remove()
		return
	elseif owner.BJAStart and owner.BJAStart <= ct then
		owner.BJAStart = nil
		owner:EmitSound("weapons/mortar/mortar_shell_incomming1.wav", 69, math.Rand(130, 135))
		owner:SetFOV(110, 0.2)
	end

	self:NextThink(ct)
	return true
end
