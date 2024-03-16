if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "pistol"
end

if CLIENT then
	SWEP.PrintName = "Dinky Gun"
	SWEP.Author = "JetBoom"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
end

SWEP.Base = "weapon_as_base"

SWEP.IsSecondary = true

SWEP.ViewModel = "models/weapons/v_pist_p228.mdl"
SWEP.WorldModel = "models/weapons/w_pist_p228.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.PrimarySound = Sound("Weapon_P228.Single")
SWEP.ReloadSound = Sound("Weapon_P228.ClipOut")
SWEP.PrimaryRecoil = 1
SWEP.PrimaryDamage = 20
SWEP.PrimaryNumShots = 1
SWEP.PrimaryDelay = 0.28
SWEP.PrimaryBusyTime = 0.1

SWEP.Primary.ClipSize = 12
SWEP.Primary.DefaultClip = 99999
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"

SWEP.Cone = 1.4
SWEP.ConeMoving = 2.4
SWEP.ConeJumping = 4.125
SWEP.ConeCrouching = 0.8
SWEP.ConeCrouchMoving = 1.2

SWEP.WalkSpeed = 200
