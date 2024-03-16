if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "rpg"
end

if CLIENT then
	SWEP.PrintName = "Melon Launcher"
	SWEP.Author = "JetBoom"
	SWEP.Slot = 0
	SWEP.SlotPos = 3
	SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_as_base"

SWEP.IsPrimary = true

SWEP.ViewModel = "models/weapons/v_rpg.mdl"
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.PrimarySound = Sound("Weapon_RPG.Single")
SWEP.ReloadSound = Sound("Weapon_RPG.Reload")
SWEP.PrimaryRecoil = 20
SWEP.PrimaryDelay = 1.5

SWEP.Primary.ClipSize = 3
SWEP.Primary.DefaultClip = 99999
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "buckshot"

SWEP.Cone = 0.8
SWEP.ConeMoving = 1.5
SWEP.ConeJumping = 3
SWEP.ConeCrouching = 0.5
SWEP.ConeCrouchMoving = 0.8

SWEP.WalkSpeed = 165

if SERVER then
	function SWEP:ShootBullet(fDamage, iNumber, fCone)
		local owner = self.Owner
		local altfire = self.AltFire
		local ang = owner:EyeAngles()
		ang:RotateAroundAxis(ang:Up(), math.Rand(-fCone, fCone))
		ang:RotateAroundAxis(ang:Right(), math.Rand(-fCone, fCone))
		local shootpos = owner:GetShootPos()
		local bullet = ents.Create("projectile_melon")
		if bullet:IsValid() then
			bullet:SetPos(shootpos)
			local fwd = ang:Forward()
			bullet.Heading = fwd
			bullet:SetAngles(ang)
			bullet:SetOwner(owner)
			bullet.Attacker = owner
			bullet.Inflictor = self
			bullet:Spawn()
			bullet:GetPhysicsObject():SetVelocityInstantaneous(fwd * 1100 + owner:GetVelocity())
		end
	end
end

if CLIENT then
	local SprintAng = 0
	local SprintDist = 0
	function SWEP:GetViewModelPosition(pos, ang)
		if SprintAng == 0 and SprintDist == 0 and not self.Owner.Sprinting then return pos, ang end

		if self.Owner.Sprinting then
			SprintAng = math.min(20, SprintAng + FrameTime() * 130)
			SprintDist = math.min(7, SprintDist + FrameTime() * 35)
		else
			SprintAng = math.max(0, SprintAng - FrameTime() * 200)
			SprintDist = math.max(0, SprintDist - FrameTime() * 60)
		end

		pos = pos + SprintDist * -1 * ang:Forward()

		ang = ang * 1
		ang:RotateAroundAxis(ang:Right(), SprintAng)

		return pos, ang
	end

	SWEP.Help = {"Melons will split right before hitting something"}
end
