if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "pistol"
end

if CLIENT then
	SWEP.PrintName = "Crossfire"
	SWEP.Author = "JetBoom"
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_as_base"

SWEP.IsPrimary = true

SWEP.ViewModel = "models/weapons/v_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.PrimarySound = Sound("Weapon_M3.Single")
SWEP.ReloadSound = Sound("Weapon_357.OpenLoader")
SWEP.PrimaryRecoil = 10
SWEP.PrimaryDamage = 10
--SWEP.PrimaryNumShots = 6
SWEP.PrimaryDelay = 0.85
SWEP.PrimaryBusyTime = 0.25

SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 99999
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "buckshot"

SWEP.Cone = 1
SWEP.ConeMoving = 1
SWEP.ConeJumping = 1.25
SWEP.ConeCrouching = 1
SWEP.ConeCrouchMoving = 1

SWEP.WalkSpeed = 190

if SERVER then
	function SWEP:ShootBullet(fDamage, iNumber, fCone)
		--[[local owner = self.Owner
		local altfire = self.AltFire
		local ang = owner:EyeAngles()
		if altfire then
			ang:RotateAroundAxis(ang:Up(), fCone * -3)
		else
			ang:RotateAroundAxis(ang:Right(), fCone * -3)
		end
		local shootpos = owner:GetShootPos()
		for i = 1, 5 do
			if altfire then
				ang:RotateAroundAxis(ang:Up(), fCone)
			else
				ang:RotateAroundAxis(ang:Right(), fCone)
			end
			PhysicalBullet(owner, self, shootpos, ang:Forward(), self.BulletSpeed, fDamage)
		end
		self.AltFire = not altfire
		CheckAllPhysicalBullets(CurTime())]]
		local owner = self.Owner
		local altfire = self.AltFire
		local ang = owner:EyeAngles()
		if altfire then
			ang:RotateAroundAxis(ang:Up(), fCone * -3)
		else
			ang:RotateAroundAxis(ang:Right(), fCone * -3)
		end
		local shootpos = owner:GetShootPos()
		for i = 1, 5 do
			local bullet = ents.Create("projectile_asbullet")
			if bullet:IsValid() then
				bullet:SetPos(shootpos)
				if altfire then
					ang:RotateAroundAxis(ang:Up(), fCone)
				else
					ang:RotateAroundAxis(ang:Right(), fCone)
				end
				local fwd = ang:Forward()
				bullet.Heading = fwd
				bullet:SetAngles(ang)
				bullet:SetOwner(owner)
				bullet:SetColor(self.ColBulletR, self.ColBulletG, self.ColBulletB, 255)
				bullet.Attacker = owner
				bullet.Inflictor = self
				bullet.BulletSpeed = self.BulletSpeed
				bullet:Spawn()
				bullet.Damage = fDamage
				bullet:GetPhysicsObject():SetVelocityInstantaneous(fwd * self.BulletSpeed)
			end
		end
		self.AltFire = not altfire
	end
end

if CLIENT then
	SWEP.Help = {"Left click: Fire bullets in an alternating cross."}
end
