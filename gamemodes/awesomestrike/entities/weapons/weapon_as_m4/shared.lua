if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "ar2"
end

if CLIENT then
	SWEP.PrintName = "M4 Carbine"
	SWEP.Author = "JetBoom"
	SWEP.Slot = 0
	SWEP.SlotPos = 2
end

SWEP.Base = "weapon_as_base"

SWEP.IsPrimary = true

SWEP.ViewModel = "models/weapons/v_rif_m4a1.mdl"
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.PrimarySound = Sound("Weapon_m4a1.Single")
SWEP.ReloadSound = Sound("Weapon_m4a1.Clipout")
SWEP.PrimaryRecoil = 1.4
SWEP.PrimaryDamage = 15
SWEP.PrimaryNumShots = 1
SWEP.PrimaryDelay = 0.13
SWEP.PrimaryBusyTime = 0.14

SWEP.Primary.ClipSize = 25
SWEP.Primary.DefaultClip = 99999
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"

SWEP.Cone = 1.3
SWEP.ConeMoving = 2.4
SWEP.ConeJumping = 4.5
SWEP.ConeCrouching = 0.6
SWEP.ConeCrouchMoving = 1

SWEP.WalkSpeed = 190
