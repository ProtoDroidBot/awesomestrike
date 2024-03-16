if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "pistol"
end

if CLIENT then
	SWEP.PrintName = "Desert Eagle"
	SWEP.Author = "JetBoom"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
end

SWEP.Base = "weapon_as_base"

SWEP.IsSecondary = true

SWEP.ViewModel = "models/weapons/v_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.PrimarySound = Sound("Weapon_Deagle.Single")
SWEP.ReloadSound = Sound("Weapon_Deagle.ClipOut")
SWEP.PrimaryRecoil = 4
SWEP.PrimaryDamage = 40
SWEP.PrimaryNumShots = 1
SWEP.PrimaryDelay = 0.42
SWEP.PrimaryBusyTime = 0.1

SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = 99999
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"

SWEP.Cone = 2
SWEP.ConeMoving = 2.6
SWEP.ConeJumping = 5.65
SWEP.ConeCrouching = 1
SWEP.ConeCrouchMoving = 1.45

SWEP.WalkSpeed = 200
