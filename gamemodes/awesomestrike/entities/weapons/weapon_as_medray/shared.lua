if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "shotgun"
end

if CLIENT then
	SWEP.PrintName = "Med-Ray"
	SWEP.Author = "JetBoom"
	SWEP.Slot = 2
	SWEP.SlotPos = 6
	SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_as_base"

SWEP.IsTertiary = true

SWEP.ViewModel = "models/weapons/v_physcannon.mdl"
SWEP.WorldModel = "models/weapons/w_physics.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Primary.ClipSize = 50
SWEP.Primary.DefaultClip = 99999
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"

SWEP.WalkSpeed = 160

SWEP.Cone = 1
SWEP.ConeMoving = 1
SWEP.ConeJumping = 1
SWEP.ConeCrouching = 1
SWEP.ConeCrouchMoving = 1

function SWEP:Reload()
	if self:GetNextReload() <= CurTime() and self:Clip1() < self.Primary.ClipSize then
		self:SetNextReload(CurTime() + 3)
		self.Owner:GiveStatus("medrayreload", 3)
		self:SendWeaponAnim(ACT_VM_RELOAD)
		self.IsReloading = true
	end
end

if SERVER then
	function SWEP:Think()
		local owner = self.Owner
		if self.IsReloading then
			if owner.MedRay then
				owner:RemoveStatus("medray", false, true)
			end

			if not owner.MedRayReload then
				self.IsReloading = nil
			elseif owner.MedRayReload and owner.MedRayReload:IsValid() and owner.MedRayReload.DieTime <= CurTime() then
				owner:RemoveStatus("medrayreload", false, true)
				self:SetClip1(self.Primary.ClipSize)
				self:SendWeaponAnim(ACT_VM_IDLE)
			end
		else
			if owner.MedRay then
				if owner:KeyDown(IN_ATTACK) and 0 < self:Clip1() and not owner:IsFrozen() then
					self.IsShooting = CurTime() + 0.4
					if self:CanPrimaryAttack() then
						self:SetNextPrimaryFire(CurTime() + 0.1)
						self:TakePrimaryAmmo(1)
						local ent = owner:TraceLine(2048, MASK_SHOT).Entity
						if ent and ent:IsPlayer() and ent:Alive() and ent:Team() == owner:Team() then
							ent:SetHealth(math.min(100, ent:Health() + 1))
						end
					end
				elseif owner.MedRay:IsValid() then
					owner.MedRay:Remove()
				end
			end		
		end

		if self.IsShooting and self.IsShooting <= CurTime() then
			self.IsShooting = nil
			self.WalkSpeed = self.OriginalWalkSpeed
			RestoreSpeed(owner, self.OriginalWalkSpeed)
		end

		self:NextThink(CurTime())
		return true
	end

	function SWEP:PrimaryAttack()
		if self:CanPrimaryAttack() then
			local ct = CurTime()

			self:SetNextPrimaryFire(ct + self.PrimaryDelay)
			self:SetNextSecondaryFire(ct + self.PrimaryDelay)

			self:EmitSound("items/medshot4.wav")

			if self.Owner.DashDodging then
				self.Owner:RemoveStatus("dashdodge*")
			end

			self.IsShooting = ct + 0.5
			self.WalkSpeed = math.max(86, self.OriginalWalkSpeed - 40)
			RestoreSpeed(self.Owner, self.WalkSpeed)

			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			self.Owner:SetAnimation(PLAYER_ATTACK1)

			self.Owner:GiveStatus("medray")
		end
	end
end

function SWEP:CanPrimaryAttack()
	if self.Owner.Stunned or self.Owner.MedRayReload then return false end

	if self:Clip1() <= 0 then
		self:EmitSound("items/medshotno1.wav")
		self:SetNextPrimaryFire(CurTime() + 0.75)
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end

if CLIENT then
	function SWEP:PrimaryAttack()
		if self:CanPrimaryAttack() then
			local ct = CurTime()

			self:SetNextPrimaryFire(ct + self.PrimaryDelay)
			self:SetNextSecondaryFire(ct + self.PrimaryDelay)

			self:EmitSound("items/medshot4.wav")

			self.IsShooting = ct + 0.5
			self.WalkSpeed = math.max(86, self.OriginalWalkSpeed - 40)

			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			self.Owner:SetAnimation(PLAYER_ATTACK1)
		end
	end
	
	function SWEP:Think()
		local owner = self.Owner
		if owner.MedRay and owner:KeyDown(IN_ATTACK) and 0 < self:Clip1() and not owner.Stunned and not owner.KnockedDown then
			self.IsShooting = CurTime() + 0.4
			if self:CanPrimaryAttack() then
				self:SetNextPrimaryFire(CurTime() + 0.1)
				self:TakePrimaryAmmo(1)
			end
		end

		if self.IsShooting and self.IsShooting <= CurTime() then
			self.IsShooting = nil
			self.WalkSpeed = self.OriginalWalkSpeed
		end

		self:NextThink(CurTime())
		return true
	end

	SWEP.Help = {"Hold left click: Healing Beam"}
end

function SWEP:IsBusy()
	return self.IsReloading or self.IsShooting
end
