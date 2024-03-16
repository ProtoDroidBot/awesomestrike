if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "crossbow"
end

if CLIENT then
	SWEP.PrintName = "AK-47"
	SWEP.Author = "JetBoom"
	SWEP.Slot = 0
	SWEP.SlotPos = 3
end

SWEP.Base = "weapon_as_base"

SWEP.IsPrimary = true

SWEP.ViewModel = "models/weapons/v_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.PrimarySound = Sound("Weapon_ak47.Single")
SWEP.ReloadSound = Sound("Weapon_AK47.ClipOut")
SWEP.PrimaryRecoil = 1.5
SWEP.PrimaryDamage = 16
SWEP.PrimaryNumShots = 1
SWEP.PrimaryDelay = 0.135
SWEP.PrimaryBusyTime = 0.145

SWEP.Primary.ClipSize = 25
SWEP.Primary.DefaultClip = 99999
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"

SWEP.Cone = 1.4
SWEP.ConeMoving = 2.52
SWEP.ConeJumping = 4.6
SWEP.ConeCrouching = 0.7
SWEP.ConeCrouchMoving = 1.1

SWEP.WalkSpeed = 190
