if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "pistol"
end

if CLIENT then
	SWEP.PrintName = "Submachine Gun"
	SWEP.Author = "JetBoom"
	SWEP.Slot = 0
	SWEP.SlotPos = 7
end

SWEP.Base = "weapon_as_base"

SWEP.IsPrimary = true

SWEP.ViewModel = "models/weapons/v_smg_mp5.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mp5.mdl"

SWEP.PrimarySound = Sound("Weapon_MP5Navy.Single")
SWEP.ReloadSound = Sound("Weapon_MP5Navy.ClipOut")
SWEP.PrimaryRecoil = 2
SWEP.PrimaryDamage = 12
SWEP.PrimaryNumShots = 1
SWEP.PrimaryDelay = 0.1
SWEP.PrimaryBusyTime = 0.14

SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 99999
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"

SWEP.Cone = 1.6
SWEP.ConeMoving = 2.8
SWEP.ConeJumping = 5
SWEP.ConeCrouching = 1.5
SWEP.ConeCrouchMoving = 1.55

SWEP.WalkSpeed = 190
