SWEP.ViewModel = "models/weapons/v_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.Damage = 25
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 0.5

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Delay = 10
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.IsTertiary = true

SWEP.WalkSpeed = 210

function SWEP:CanPrimaryAttack()
	return not self.Owner.Stunned
end

function SWEP:CanSecondaryAttack()
	return not self.Owner.Stunned
end

function SWEP:Deploy()
	local owner = self.Owner

	owner:DrawViewModel(true)
	owner:DrawWorldModel(true)
	GAMEMODE:WeaponDeployed(owner, self)
end

function SWEP:Reload()
	return false
end

function SWEP:Precache()
	util.PrecacheSound("weapons/knife/knife_hit1.wav")
	util.PrecacheSound("weapons/knife/knife_hit2.wav")
	util.PrecacheSound("weapons/knife/knife_hit3.wav")
	util.PrecacheSound("weapons/knife/knife_hit4.wav")
	util.PrecacheSound("weapons/knife/knife_slash1.wav")
	util.PrecacheSound("weapons/knife/knife_slash2.wav")
	util.PrecacheSound("weapons/knife/knife_hitwall1.wav")
	util.PrecacheSound("weapons/knife/knife_stab.wav")
end

function SWEP:IsBusy()
	return false
end
