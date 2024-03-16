AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

function SWEP:Initialize()
	self.ActivityTranslate = {}
	self.ActivityTranslate[ACT_HL2MP_IDLE] = ACT_HL2MP_IDLE_GRENADE
	self.ActivityTranslate[ACT_HL2MP_WALK] = ACT_HL2MP_WALK_GRENADE
	self.ActivityTranslate[ACT_HL2MP_RUN] = ACT_HL2MP_RUN_GRENADE
	self.ActivityTranslate[ACT_HL2MP_IDLE_CROUCH] = ACT_HL2MP_IDLE_CROUCH_GRENADE
	self.ActivityTranslate[ACT_HL2MP_WALK_CROUCH] = ACT_HL2MP_WALK_CROUCH_GRENADE
	self.ActivityTranslate[ACT_HL2MP_GESTURE_RANGE_ATTACK] = ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE
	self.ActivityTranslate[ACT_HL2MP_GESTURE_RELOAD] = ACT_HL2MP_GESTURE_RELOAD_GRENADE
	self.ActivityTranslate[ACT_HL2MP_JUMP] = ACT_HL2MP_JUMP_GRENADE
	self.ActivityTranslate[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_GRENADE
	self.NextAttack = 0
end

function SWEP:Holster()
	return true
end

function SWEP:OnRemove()
end

function SWEP:Think()
	if self.IsShooting and self.IsShooting <= CurTime() then
		self.IsShooting = nil
	end
end

function SWEP:CanPrimaryAttack()
	local owner = self.Owner
	return not owner.Stunned and self.NextAttack <= CurTime()
end

function SWEP:CanSecondaryAttack()
	return not self.Owner.Stunned
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	local owner = self.Owner

	if owner.Sprinting then owner:RemoveStatus("sprint", false, true) end

	self.NextAttack = CurTime() + 3
	self.IsShooting = CurTime() + 1

	if owner.Sprinting then
		owner:RemoveStatus("sprint", false, true)
	end
	if owner.DashDodging then
		owner:RemoveStatus("dashdodge*", false, true)
	end

	owner:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 72, math.Rand(85, 95))
	owner:SetAnimation(PLAYER_ATTACK1)

	local eyepos = owner:EyePos()
	local ownerteam = owner:Team()

	local ent = ents.Create("projectile_seizuregrenade")
	if ent:IsValid() then
		ent:SetPos(eyepos)
		ent:SetAngles(VectorRand():Angle())
		ent:SetOwner(owner)
		ent.TeamID = owner:Team()
		ent.OwnerID = owner:EntIndex()
		ent:Spawn()
		ent:GetPhysicsObject():SetVelocityInstantaneous(owner:GetAimVector() * 1000 + owner:GetVelocity())
		ent:SetPhysicsAttacker(owner)
	end

	owner:StripWeapon("weapon_as_seizuregrenade")
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end
