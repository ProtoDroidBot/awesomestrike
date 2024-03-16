SWEP.ViewModel = "models/weapons/v_knife_t.mdl"
SWEP.WorldModel = "models/peanut/conansword.mdl"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.HoldType = "melee"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 0.1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.WalkSpeed = 210

SWEP.IsTertiary = true

function SWEP:Deploy()
	local owner = self.Owner

	GAMEMODE:WeaponDeployed(owner, self)

	owner:RemoveStatus("weapon_*", false, true)
	owner:GiveStatus("weapon_berserkersword")
	owner:DrawViewModel(false)
	owner:DrawViewModel(false)
	owner:DrawWorldModel(false)
end

function SWEP:Reload()
	return false
end

function SWEP:Precache()
	for i=1, 5 do
		util.PrecacheSound("physics/flesh/flesh_impact_bullet"..i..".wav")
	end
	util.PrecacheSound("npc/zombie/claw_miss1.wav")
end

function SWEP:IsBusy()
	return self.IsShooting
end
