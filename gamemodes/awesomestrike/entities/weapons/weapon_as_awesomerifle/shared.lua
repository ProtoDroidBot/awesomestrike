if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "ar2"
end

if CLIENT then
	SWEP.PrintName = "Awesome Rifle"
	SWEP.Author = "JetBoom"
	SWEP.Slot = 0
	SWEP.SlotPos = 6
end

SWEP.Base = "weapon_as_base"

SWEP.IsPrimary = true

SWEP.ViewModel = "models/weapons/v_snip_awp.mdl"
SWEP.WorldModel = "models/weapons/w_snip_awp.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.PrimarySound = Sound("Weapon_AWP.Single")
SWEP.ReloadSound = Sound("Weapon_AWP.ClipOut")
SWEP.PrimaryDamage = 50
SWEP.PrimaryNumShots = 1
SWEP.PrimaryDelay = 1.5
SWEP.PrimaryBusyTime = 0.35

SWEP.Primary.ClipSize = 2
SWEP.Primary.DefaultClip = 99999
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"

SWEP.Cone = 1
SWEP.ConeMoving = 1
SWEP.ConeJumping = 1
SWEP.ConeCrouching = 1
SWEP.ConeCrouchMoving = 1

SWEP.WalkSpeed = 170

SWEP.BulletSpeed = 2000

function SWEP:CanPrimaryAttack()
	local owner = self.Owner
	if owner.Stunned or owner.AwesomeBullet and owner.AwesomeBullet:IsValid() and owner.AwesomeBullet:GetSkin() ~= 1 then return false end

	if self:Clip1() <= 0 then
		self:EmitSound("Weapon_Shotgun.Empty")
		self:SetNextPrimaryFire(CurTime() + self.PrimaryDelay)
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP:IsBusy()
	local bullet = self.Owner.AwesomeBullet
	return self.IsShooting or self.IsReloading or bullet and bullet:IsValid() and bullet:GetSkin() ~= 1
end

if SERVER then
	function SWEP:ShootBullet(fDamage, iNumber, fCone)
		local owner = self.Owner
		local shootpos = owner:GetShootPos()
		local ang = owner:EyeAngles()
		local bullet = ents.Create("projectile_arbullet")
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
			bullet.BulletSpeed = self.BulletSpeed
			bullet:Spawn()
			bullet.Damage = fDamage
			bullet:GetPhysicsObject():SetVelocityInstantaneous(fwd * self.BulletSpeed)
			util.SpriteTrail(bullet, 0, team.GetColor(bullet.Team), false, 8, 1, 1, 0.02, "trails/smoke.vmt")
		end
	end
end

if CLIENT then
	SWEP.Help = {"Mouse movement after shooting: Guide Bullet"}
end
