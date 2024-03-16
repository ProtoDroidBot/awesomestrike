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

function SWEP:Deploy()
	local owner = self.Owner

	GAMEMODE:WeaponDeployed(owner, self)

	owner:DrawViewModel(false)
	self.DelayedViewModel = true
	owner:DrawWorldModel(false)
	owner:RemoveStatus("weapon_*", false, true)
	owner:GiveStatus("weapon_barrel")

	self:NextThink(CurTime())

	return true
end

function SWEP:Holster()
	self.Owner:RemoveStatus("weapon_barrel", false, true)
	return true
end

function SWEP:OnRemove()
	local owner = self.Owner
	if owner and owner:IsPlayer() then
		owner:RemoveStatus("weapon_barrel", false, true)
	end
end

function SWEP:Think()
	local ct = CurTime()
	local owner = self.Owner

	if self.IsShooting and self.IsShooting <= ct then
		self.IsShooting = nil
	end

	if self.DelayedViewModel then
		self.DelayedViewModel = nil
		owner:DrawViewModel(false)
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

	owner:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 77, math.Rand(60, 73))
	owner:SetAnimation(PLAYER_ATTACK1)

	local eyepos = owner:EyePos()
	local ownerteam = owner:Team()

	local ent = ents.Create("prop_physics")
	if ent:IsValid() then
		ent:SetModel("models/props_c17/oildrum001_explosive.mdl")
		ent:SetPos(eyepos)
		ent:SetAngles(VectorRand():Angle())
		ent:SetOwner(owner)
		ent:Spawn()
		ent.IsThrownBarrel = true
		ent:GetPhysicsObject():SetVelocityInstantaneous(owner:GetAimVector() * 500 + owner:GetVelocity() * 0.75)
		ent:SetPhysicsAttacker(owner)
		ent:Fire("ignite", "", 0)
	end

	owner:ConCommand("-attack")

	owner:StripWeapon("weapon_as_barrel")
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end
