include("shared.lua")

SWEP.PrintName = "Force Shield"
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.ViewModelFOV = 1
SWEP.ViewModelFlip = false
SWEP.CSMuzzleFlashes = false

SWEP.Slot = 2
SWEP.SlotPos = 5

function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
	draw.SimpleText(self.PrintName, "DefaultBold", x + wide * 0.5, y + tall * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function SWEP:CanPrimaryAttack()
	return false
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:IsBusy()
	return self.Owner:KeyDown(IN_ATTACK)
end

SWEP.Help = {"Hold left click: Bullet Reflection and Melee Guard"}
