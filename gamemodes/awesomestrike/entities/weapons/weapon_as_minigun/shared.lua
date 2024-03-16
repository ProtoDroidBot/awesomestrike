if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "shotgun"
end

if CLIENT then
	SWEP.PrintName = "Minigun"
	SWEP.Author = "JetBoom"
	SWEP.Slot = 0
	SWEP.SlotPos = 5
	SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_as_base"

SWEP.IsPrimary = true

SWEP.ViewModel = "models/weapons/v_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.PrimarySound = Sound("Weapon_m249.Single")
SWEP.ReloadSound = Sound("Weapon_m249.Boxout")
SWEP.PrimaryRecoil = 3
SWEP.PrimaryDamage = 13
SWEP.PrimaryNumShots = 1
SWEP.PrimaryDelay = 0.085
SWEP.PrimaryBusyTime = 0.125

SWEP.Primary.ClipSize = 75
SWEP.Primary.DefaultClip = 99999
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"

SWEP.Cone = 4.25
SWEP.ConeMoving = 4.25
SWEP.ConeJumping = 4.25
SWEP.ConeCrouching = 4.25
SWEP.ConeCrouchMoving = 4.25

SWEP.WalkSpeed = 160
