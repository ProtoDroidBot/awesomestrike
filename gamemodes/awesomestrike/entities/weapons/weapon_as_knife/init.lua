AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

function SWEP:Think()
end

function SWEP:Initialize()
	self.LastShootTime = 0

	self.ActivityTranslate = {}
	self.ActivityTranslate[ACT_HL2MP_IDLE] = ACT_HL2MP_IDLE_KNIFE
	self.ActivityTranslate[ACT_HL2MP_WALK] = ACT_HL2MP_WALK_KNIFE
	self.ActivityTranslate[ACT_HL2MP_RUN] = ACT_HL2MP_RUN_KNIFE
	self.ActivityTranslate[ACT_HL2MP_IDLE_CROUCH] = ACT_HL2MP_IDLE_CROUCH
	self.ActivityTranslate[ACT_HL2MP_WALK_CROUCH] = ACT_HL2MP_WALK_CROUCH_KNIFE
	self.ActivityTranslate[ACT_HL2MP_GESTURE_RANGE_ATTACK] = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
	self.ActivityTranslate[ACT_HL2MP_GESTURE_RELOAD] = ACT_HL2MP_GESTURE_RELOAD_KNIFE
	self.ActivityTranslate[ACT_HL2MP_JUMP] = ACT_HL2MP_JUMP_KNIFE
	self.ActivityTranslate[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_KNIFE
end
local lastinflictor = NULL
local function StabCallback(attacker, trace, dmginfo)
	local ent = nil

	if trace.HitNonWorld then
		ent = trace.Entity
	end

	if trace.Hit and trace.HitPos:Distance(trace.StartPos) <= 70 then
		if trace.MatType == MAT_FLESH or trace.MatType == MAT_BLOODYFLESH or trace.MatType == MAT_ANTLION or trace.MatType == MAT_ALIENFLESH then
			attacker:EmitSound("weapons/knife/knife_hit"..math.random(1,4)..".wav")
			util.Decal("Blood", trace.HitPos + trace.HitNormal * 8, trace.HitPos - trace.HitNormal * 8)
		else
			attacker:EmitSound("weapons/knife/knife_hitwall1.wav")
			util.Decal("ManhackCut", trace.HitPos + trace.HitNormal * 8, trace.HitPos - trace.HitNormal * 8)
		end
	else
		attacker:EmitSound("weapons/knife/knife_slash"..math.random(1,2)..".wav")
	end

	if ent and ent:IsValid() and trace.HitPos:Distance(trace.StartPos) <= 70 then
		if ent:IsPlayer() then
			if ent:GetForward():Distance(attacker:GetForward()) < 0.88 then
				ent:EmitSound("weapons/knife/knife_stab.wav")
				ent:TakeDamage(ent:Health(), attacker, lastinflictor)
				return {effects = false, damage = false}
			elseif IsGuardStun(attacker, ent) then
				Guarded(attacker, ent, 1)
				lastinflictor.NextAttack = CurTime() + 1
				return {effects = false, damage = false}
			end
		end
		return {effects = false, damage = true}
	end

	return {effects = false, damage = false}
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if CurTime() < self.LastShootTime + self.Primary.Delay then return end
	self.LastShootTime = CurTime()

	local owner = self.Owner

	if owner.Sprinting then
		owner:RemoveStatus("sprint", false, true)
	end
	if owner.DashDodging then
		owner:RemoveStatus("dashdodge*", false, true)
	end

	local bullet = {}
	bullet.Num = 1
	bullet.Src = owner:GetShootPos()
	bullet.Dir = owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force = 2
	bullet.Damage = self.Primary.Damage
	bullet.HullSize = 2
	bullet.Callback = StabCallback
	lastinflictor = self
	self.Owner:FireBullets(bullet)

	if self.Alternate then
		self:SendWeaponAnim(ACT_VM_MISSCENTER)
	else
		self:SendWeaponAnim(ACT_VM_HITCENTER)
	end

	self.Alternate = not self.Alternate

	owner:SetAnimation(PLAYER_ATTACK1)
end

function SWEP:SecondaryAttack()
end
