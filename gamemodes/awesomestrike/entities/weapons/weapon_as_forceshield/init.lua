AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

function SWEP:Initialize()
	self.ActivityTranslate = {}
	self.ActivityTranslate[ACT_HL2MP_IDLE] = ACT_HL2MP_IDLE_MELEE
	self.ActivityTranslate[ACT_HL2MP_WALK] = ACT_HL2MP_WALK_MELEE
	self.ActivityTranslate[ACT_HL2MP_RUN] = ACT_HL2MP_RUN_MELEE
	self.ActivityTranslate[ACT_HL2MP_IDLE_CROUCH] = ACT_HL2MP_IDLE_CROUCH_MELEE
	self.ActivityTranslate[ACT_HL2MP_WALK_CROUCH] = ACT_HL2MP_WALK_CROUCH_MELEE
	self.ActivityTranslate[ACT_HL2MP_GESTURE_RANGE_ATTACK] = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
	self.ActivityTranslate[ACT_HL2MP_GESTURE_RELOAD] = ACT_HL2MP_GESTURE_RELOAD_MELEE
	self.ActivityTranslate[ACT_HL2MP_JUMP] = ACT_HL2MP_JUMP_MELEE
	self.ActivityTranslate[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_MELEE
end

function SWEP:Guarded(hitter, guarder, duration)
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
	owner:GiveStatus("weapon_forceshield")

	self:NextThink(CurTime())

	return true
end

function SWEP:Holster()
	local owner = self.Owner
	if self.Guarding then
		return false
	end

	owner:RemoveStatus("weapon_forceshield", false, true)
	return true
end

function SWEP:OnRemove()
	local owner = self.Owner
	if owner and owner:IsPlayer() then
		owner:RemoveStatus("weapon_forceshield", false, true)
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

	--[[if self.ToRestore and self.ToRestore <= CurTime() then
		self.ToRestore = nil

		RestoreSpeed(owner, self.WalkSpeed)
	end]]

	if self.Guarding then
		if self.Guarding < ct and not owner:KeyDown(IN_ATTACK) or owner.Sprinting or owner.DashDodging then
			if owner.Sprinting then
				owner:RemoveStatus("sprint", false, true)
			end
			if owner.DashDodging then
				owner:RemoveStatus("dashdodge*", false, true)
			end
			--self.WalkSpeed = self.WalkSpeed + 105
			--RestoreSpeed(owner, self.WalkSpeed)
			self.Guarding = nil
			self.ActivityTranslate[ACT_HL2MP_IDLE] = ACT_HL2MP_IDLE_MELEE
			self.ActivityTranslate[ACT_HL2MP_WALK] = ACT_HL2MP_WALK_MELEE
			self.ActivityTranslate[ACT_HL2MP_RUN] = ACT_HL2MP_RUN_MELEE
			self.ActivityTranslate[ACT_HL2MP_IDLE_CROUCH] = ACT_HL2MP_IDLE_CROUCH_MELEE
			self.ActivityTranslate[ACT_HL2MP_WALK_CROUCH] = ACT_HL2MP_WALK_CROUCH_MELEE
			self.ActivityTranslate[ACT_HL2MP_GESTURE_RANGE_ATTACK] = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
			self.ActivityTranslate[ACT_HL2MP_GESTURE_RELOAD] = ACT_HL2MP_GESTURE_RELOAD_MELEE
			self.ActivityTranslate[ACT_HL2MP_JUMP] = ACT_HL2MP_JUMP_MELEE
			self.ActivityTranslate[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_MELEE
		end

		self:NextThink(ct)
		return true
	end

	self:NextThink(ct)
	return true
end

function SWEP:CanPrimaryAttack()
	local owner = self.Owner
	return not owner.Stunned
end

function SWEP:CanSecondaryAttack()
	return not self.Owner.Stunned
end

function SWEP:PrimaryAttack()
	local owner = self.Owner
	if owner.Sprinting then
		owner:RemoveStatus("sprint", false, true)
	end
	if owner.DashDodging then
		owner:RemoveStatus("dashdodge*", false, true)
	end
	if self.Guarding then return end
	local ct = CurTime()
	if self.ToRestore then return end

	self.Guarding = ct + 0.05

	owner:EmitSound("npc/metropolice/gear"..math.random(1,6)..".wav", 65, math.Rand(95, 105))

	self.ActivityTranslate[ACT_HL2MP_IDLE] = ACT_HL2MP_IDLE_FIST
	self.ActivityTranslate[ACT_HL2MP_WALK] = ACT_HL2MP_WALK_FIST
	self.ActivityTranslate[ACT_HL2MP_RUN] = ACT_HL2MP_RUN_FIST
	self.ActivityTranslate[ACT_HL2MP_IDLE_CROUCH] = ACT_HL2MP_IDLE_CROUCH_MELEE2
	self.ActivityTranslate[ACT_HL2MP_WALK_CROUCH] = ACT_HL2MP_WALK_CROUCH_FIST
	self.ActivityTranslate[ACT_HL2MP_GESTURE_RANGE_ATTACK] = ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST
	self.ActivityTranslate[ACT_HL2MP_GESTURE_RELOAD] = ACT_HL2MP_GESTURE_RELOAD_FIST
	self.ActivityTranslate[ACT_HL2MP_JUMP] = ACT_HL2MP_JUMP_FIST
	self.ActivityTranslate[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_FIST

	if not owner:IsOnGround() then
		owner:SetAnimation(PLAYER_WALK)
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end

function SWEP:Reload()
	self:PrimaryAttack()
end

function SWEP:IsBusy()
	return self.Guarding
end
