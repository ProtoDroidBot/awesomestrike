if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "pistol"
end

if CLIENT then
	SWEP.PrintName = "Uzi"
	SWEP.Author = "JetBoom"
	SWEP.Slot = 0
	SWEP.SlotPos = 4
end

SWEP.Base = "weapon_as_base"

SWEP.IsPrimary = true

SWEP.ViewModel = "models/weapons/v_smg_mac10.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mac10.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.PrimarySound = Sound("Weapon_MAC10.Single")
SWEP.ReloadSound = Sound("Weapon_MAC10.ClipOut")
SWEP.PrimaryRecoil = 2
SWEP.PrimaryDamage = 12
SWEP.PrimaryNumShots = 1
SWEP.PrimaryDelay = 0.09
SWEP.PrimaryBusyTime = 0.13

SWEP.Primary.ClipSize = 35
SWEP.Primary.DefaultClip = 99999
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"

SWEP.Cone = 3.5
SWEP.ConeMoving = 3.6
SWEP.ConeJumping = 3.8
SWEP.ConeCrouching = 3.5
SWEP.ConeCrouchMoving = 3.5

SWEP.WalkSpeed = 190
