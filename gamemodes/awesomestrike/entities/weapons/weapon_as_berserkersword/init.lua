AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

function SWEP:Initialize()
	self.ActivityTranslate = {}
	self.ActivityTranslate[ACT_HL2MP_IDLE] = ACT_HL2MP_IDLE_MELEE2
	self.ActivityTranslate[ACT_HL2MP_WALK] = ACT_HL2MP_WALK_MELEE2
	self.ActivityTranslate[ACT_HL2MP_RUN] = ACT_HL2MP_RUN_MELEE2
	self.ActivityTranslate[ACT_HL2MP_IDLE_CROUCH] = ACT_HL2MP_IDLE_CROUCH_MELEE2
	self.ActivityTranslate[ACT_HL2MP_WALK_CROUCH] = ACT_HL2MP_WALK_CROUCH_MELEE2
	self.ActivityTranslate[ACT_HL2MP_GESTURE_RANGE_ATTACK] = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2
	self.ActivityTranslate[ACT_HL2MP_GESTURE_RELOAD] = ACT_HL2MP_GESTURE_RELOAD_MELEE2
	self.ActivityTranslate[ACT_HL2MP_JUMP] = ACT_HL2MP_JUMP_MELEE2
	self.ActivityTranslate[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_MELEE2
	self.NextAttack = 0
	self.NextAttack2 = 0
end

function SWEP:Guarded(hitter, guarder, duration)
	guarder:RestartGesture(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE)
	hitter:SetLastAttacker(guarder)
	hitter:SetGroundEntity(NULL)
	hitter:SetVelocity((hitter:GetPos() - guarder:GetPos()):Normalize() * 220 + Vector(0,0,190))
	hitter:GiveStatus("knockdown", 10)
	local effectdata = EffectData()
		effectdata:SetOrigin(guarder:GetShootPos())
		effectdata:SetEntity(guarder)
	util.Effect("meleeguard", effectdata, true, true)
end

function SWEP:Deploy()
	local owner = self.Owner

	GAMEMODE:WeaponDeployed(owner, self)

	owner:DrawViewModel(false)
	self.DelayedViewModel = true
	owner:DrawWorldModel(false)
	owner:RemoveStatus("weapon_*", false, true)
	owner:GiveStatus("weapon_berserkersword")

	self:NextThink(CurTime())

	return true
end

function SWEP:Holster()
	local owner = self.Owner
	if owner.BJAStart or owner.BJAEnd or self.FinishSwing or self.Guarding or owner:KeyDown(IN_RELOAD) or owner.BerserkerCharge then
		return false
	end

	owner:RemoveStatus("weapon_berserkersword", false, true)
	return true
end

function SWEP:OnRemove()
	local owner = self.Owner
	if owner and owner:IsPlayer() then
		owner:RemoveStatus("weapon_berserkersword", false, true)
	end
end

function SWEP:Think()
	local ct = CurTime()
	local owner = self.Owner

	if self.IsShooting and self.IsShooting <= CurTime() then
		self.IsShooting = nil
	end

	if self.DelayedViewModel then
		self.DelayedViewModel = nil
		owner:DrawViewModel(false)
	end

	if self.ToRestore and self.ToRestore <= CurTime() then
		self.ToRestore = nil

		RestoreSpeed(owner, self.WalkSpeed)
	end

	if self.Guarding then
		if self.Guarding < ct and not owner:KeyDown(IN_RELOAD) or owner.Sprinting or owner.DashDodging then
			if owner.Sprinting then
				owner:RemoveStatus("sprint", false, true)
			end
			if owner.DashDodging then
				owner:RemoveStatus("dashdodge*", false, true)
			end
			self.WalkSpeed = self.WalkSpeed + 105
			RestoreSpeed(owner, self.WalkSpeed)
			self.Guarding = nil
			self.ActivityTranslate[ACT_HL2MP_IDLE] = ACT_HL2MP_IDLE_MELEE2
			self.ActivityTranslate[ACT_HL2MP_WALK] = ACT_HL2MP_WALK_MELEE2
			self.ActivityTranslate[ACT_HL2MP_RUN] = ACT_HL2MP_RUN_MELEE2
			self.ActivityTranslate[ACT_HL2MP_IDLE_CROUCH] = ACT_HL2MP_IDLE_CROUCH_MELEE2
			self.ActivityTranslate[ACT_HL2MP_WALK_CROUCH] = ACT_HL2MP_WALK_CROUCH_MELEE2
			self.ActivityTranslate[ACT_HL2MP_GESTURE_RANGE_ATTACK] = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2
			self.ActivityTranslate[ACT_HL2MP_GESTURE_RELOAD] = ACT_HL2MP_GESTURE_RELOAD_MELEE2
			self.ActivityTranslate[ACT_HL2MP_JUMP] = ACT_HL2MP_JUMP_MELEE2
			self.ActivityTranslate[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_MELEE2
		end

		self:NextThink(ct)
		return true
	end

	if self.FinishSwing and self.FinishSwing <= ct then
		self.FinishSwing = nil
		local eyepos = owner:EyePos()
		local ownerteam = owner:Team()

		for _, ent in pairs(ents.FindInSphere(eyepos + owner:GetAimVector() * 30, 40)) do
			if ent ~= owner then
				if ent:IsPlayer() then
					local nearest = ent:NearestPoint(eyepos)
					if ent:Alive() and TrueVisible(nearest, eyepos) then
						if IsGuardStun(owner, ent) then
							Guarded(owner, ent, 1)
							self.NextAttack = ct + 1
						else
							ent:EmitSound("nox/sword_hit.wav", 77, math.Rand(98, 102))
							ent:TakeDamage(30, owner, self)
						end
					end
				elseif 0 < ent:Health() and TrueVisible(ent:NearestPoint(eyepos), eyepos) then
					ent:EmitSound("nox/sword_hit.wav", 77, math.Rand(98, 102))
					ent:TakeDamage(30, owner, self)
				end
			end
		end

		if owner.WeaponStatus and owner.WeaponStatus:IsValid() then
			owner.WeaponStatus:SetSkin(0)
		end
	end

	self:NextThink(ct)
	return true
end

function SWEP:CanPrimaryAttack()
	local owner = self.Owner
	return not owner.Stunned and not self.Guarding and self.NextAttack <= CurTime() and not owner.BerserkFire and not owner.BJAStart and not owner.BJAEnd
end

function SWEP:CanSecondaryAttack()
	return not self.Owner.Stunned
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	local owner = self.Owner

	if owner.Sprinting then
		owner:RemoveStatus("sprint", false, true)
	end
	if owner.DashDodging then
		owner:RemoveStatus("dashdodge*", false, true)
	end

	if not owner:IsOnGround() and not util.TraceLine({start=owner:GetPos(), endpos = owner:GetPos() + Vector(0,0,-48), mask = MASK_SOLID, filter = {owner, self}}).Hit then
		self.NextAttack = CurTime() + 1
		owner:GiveStatus("berserkerjumpattack")
		self.IsShooting = self.NextAttack
		return
	end

	self.IsShooting = self.NextAttack + 0.1
	self.NextAttack = CurTime() + 0.65
	self.FinishSwing = CurTime() + 0.25

	owner:EmitSound("nox/sword_miss.wav", 80, math.Rand(80, 93))
	owner:SetAnimation(PLAYER_ATTACK1)

	local eyepos = owner:EyePos()
	local ownerteam = owner:Team()

	for _, ent in pairs(ents.FindInSphere(eyepos + owner:GetAimVector() * 40, 40)) do
		if ent.Inversion and ent.Team ~= ownerteam then
			ent:EmitSound("npc/manhack/bat_away.wav", 80, math.Rand(95, 105))
			Invert(ent, owner)
		elseif ent.Deflectable and ent.Team ~= ownerteam and ent:GetPhysicsObject():IsMoveable() then
			ent:EmitSound("npc/manhack/bat_away.wav", 80, math.Rand(95, 105))
			ent.Team = ownerteam
			ent:SetOwner(owner)
			ent:GetPhysicsObject():SetVelocityInstantaneous((ent:NearestPoint(eyepos) - eyepos):Normalize() * (ent:GetVelocity():Length() + 250))
		end
	end

	if owner.WeaponStatus and owner.WeaponStatus:IsValid() then
		owner.WeaponStatus:SetSkin(1)
	end
end

function SWEP:SecondaryAttack()
	if not self:CanSecondaryAttack() then return end

	local owner = self.Owner

	if self.Guarding or CurTime() < self.NextAttack or owner.BerserkFire or CurTime() < self.NextAttack2 or owner.ToRestore or owner.Stunned or not (owner:IsOnGround() or util.TraceLine({start = owner:GetPos(), endpos = owner:GetPos() + Vector(0,0,-16), filter = owner}).Hit) then return end

	if owner.Sprinting then
		owner:RemoveStatus("sprint", false, true)
	end
	if owner.DashDodging then
		owner:RemoveStatus("dashdodge*", false, true)
	end

	self.NextAttack = CurTime() + 0.96
	self.NextAttack2 = CurTime() + 2

	owner:GiveStatus("berserkercharge")
end

function SWEP:Reload()
	local owner = self.Owner
	if owner.Sprinting then
		owner:RemoveStatus("sprint", false, true)
	end
	if owner.DashDodging then
		owner:RemoveStatus("dashdodge*", false, true)
	end
	if self.Guarding then return end
	local ct = CurTime()
	if ct < self.NextAttack or owner.BerserkFire or self.ToRestore then return end

	--self.NextAttack = ct + 0.9
	self.Guarding = ct + 0.05

	self.WalkSpeed = self.WalkSpeed - 105
	RestoreSpeed(owner, self.WalkSpeed)

	owner:EmitSound("npc/metropolice/gear"..math.random(1,6)..".wav", 65, math.Rand(95, 105))

	self.ActivityTranslate[ACT_HL2MP_IDLE] = ACT_HL2MP_IDLE_FIST
	self.ActivityTranslate[ACT_HL2MP_WALK] = ACT_HL2MP_WALK_FIST
	self.ActivityTranslate[ACT_HL2MP_RUN] = ACT_HL2MP_RUN_FIST
	self.ActivityTranslate[ACT_HL2MP_IDLE_CROUCH] = ACT_HL2MP_IDLE_CROUCH_FIST
	self.ActivityTranslate[ACT_HL2MP_WALK_CROUCH] = ACT_HL2MP_WALK_CROUCH_FIST
	self.ActivityTranslate[ACT_HL2MP_GESTURE_RANGE_ATTACK] = ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST
	self.ActivityTranslate[ACT_HL2MP_GESTURE_RELOAD] = ACT_HL2MP_GESTURE_RELOAD_FIST
	self.ActivityTranslate[ACT_HL2MP_JUMP] = ACT_HL2MP_JUMP_FIST
	self.ActivityTranslate[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_FIST
end
