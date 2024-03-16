if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "crossbow"
end

if CLIENT then
	SWEP.PrintName = "Grapple Beam"
	SWEP.Author = "JetBoom"
	SWEP.Slot = 1
	SWEP.SlotPos = 2
	SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_as_base"

SWEP.IsSecondary = true

SWEP.ViewModel = "models/weapons/v_crossbow.mdl"
SWEP.WorldModel = "models/weapons/w_crossbow.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.PrimarySound = Sound("Weapon_Crossbow.Single")
SWEP.ReloadSound = Sound("Weapon_Crossbow.Reload")
SWEP.PrimaryDelay = 1
SWEP.PrimaryBusyTime = 0.25

SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 99999
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"

SWEP.Cone = 1
SWEP.ConeMoving = 1
SWEP.ConeJumping = 1
SWEP.ConeCrouching = 1
SWEP.ConeCrouchMoving = 1

SWEP.WalkSpeed = 190

function SWEP:CanPrimaryAttack()
	local owner = self.Owner
	if owner.Stunned or owner.GrappleBeam and owner.GrappleBeam:IsValid() then return false end

	if self:Clip1() <= 0 then
		self:EmitSound("Weapon_AR2.Empty")
		self:SetNextPrimaryFire(CurTime() + self.PrimaryDelay)
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end

if SERVER then
	function SWEP:ShootBullet(fDamage, iNumber, fCone)
		local owner = self.Owner
		local shootpos = owner:GetShootPos()
		local ang = owner:EyeAngles()
		local bullet = ents.Create("projectile_grapplebeam")
		if bullet:IsValid() then
			bullet:SetPos(shootpos)
			local fwd = ang:Forward()
			bullet.Heading = fwd
			bullet:SetAngles(ang)
			bullet:SetOwner(owner)
			bullet:SetColor(self.ColBulletR, self.ColBulletG, self.ColBulletB, 255)
			bullet.Attacker = owner
			bullet.Inflictor = self
			bullet.Team = owner:Team()
			bullet:Spawn()
			owner.GrappleBeam = bullet
			local phys = bullet:GetPhysicsObject()
			if phys:IsValid() then
				phys:SetVelocityInstantaneous(fwd * 1200)
			end
		end
	end
end

function SWEP:IsBusy()
	local grapplebeam = self.Owner.GrappleBeam
	return self.IsShooting or self.IsReloading or grapplebeam and grapplebeam:IsValid()
end

if CLIENT then
	SWEP.Help = {"Hold left click: Reel In"}
end
