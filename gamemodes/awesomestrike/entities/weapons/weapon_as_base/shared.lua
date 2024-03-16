if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.Weight = 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
end

if CLIENT then
	SWEP.DrawAmmo = true
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = true
	SWEP.CSMuzzleFlashes = true
end

SWEP.PrimarySound = Sound("Weapon_AK47.Single")
SWEP.PrimaryRecoil = 1.5
SWEP.PrimaryDamage = 40
SWEP.PrimaryNumShots = 1
SWEP.PrimaryDelay = 0.15
SWEP.PrimaryBusyTime = 0.1

SWEP.Cone = 3.6
SWEP.ConeMoving = 5.25
SWEP.ConeJumping = 9
SWEP.ConeCrouching = 2.25
SWEP.ConeCrouchMoving = 3

SWEP.NextSecondaryAttack = 0

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "CombineCannon"
SWEP.Secondary.BusyTime = 0.1

SWEP.BulletSpeed = 3000 -- Bullets travel about 1000 MPH but it's reduced about 5x for gameplay.

SWEP.WalkSpeed = 200

SWEP.HoldType = "pistol"

function SWEP:Deploy()
	self:SetNextReload(0)

	local owner = self.Owner

	owner:DrawViewModel(true)
	owner:DrawWorldModel(true)
	GAMEMODE:WeaponDeployed(owner, self)

	local col = team.GetColor(owner:Team())
	self.colBulletR = col.r
	self.colBulletG = col.g
	self.colBulletB = col.b

	if self.PreHolsterClip1 then
		self:SetClip1(self.PreHolsterClip1)
		self.PreHolsterClip1 = nil
	end
	if self.PreHolsterClip2 then
		self:SetClip2(self.PreHolsterClip2)
		self.PreHolsterClip2 = nil
	end

	return true
end

function SWEP:Holster()
	--return not self:GetNetworkedBool("cantswap")
	self.IsShooting = nil
	self.IsReloading = nil
	if self.Primary.Ammo ~= "none" then
		self.PreHolsterClip1 = self:Clip1()
	end
	if self.Secondary.Ammo ~= "none" then
		self.PreHolsterClip2 = self:Clip2()
	end
	return true
end

function SWEP:IsBusy()
	return self.IsShooting or self.IsReloading
end

function SWEP:Think()
	if self.IsShooting and self.IsShooting <= CurTime() then
		self.IsShooting = nil
	end

	if self.IsReloading and self.IsReloading <= CurTime() then
		self:SetClip1(self.Primary.ClipSize)
		self:SetClip2(self.Secondary.ClipSize)

		self.IsReloading = nil
	end
end

if SERVER then
	function SWEP:PrimaryAttack()
		if self:CanPrimaryAttack() then
			local ct = CurTime()

			self:SetNextPrimaryFire(ct + self.PrimaryDelay)
			self:SetNextSecondaryFire(ct + self.PrimaryDelay)

			self:EmitSound(self.PrimarySound)

			if self.Owner.DashDodging then
				self.Owner:RemoveStatus("dashdodge*")
			end

			self:TakePrimaryAmmo(1)

			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			self.Owner:SetAnimation(PLAYER_ATTACK1)
			--self.IsShooting = ct + self.PrimaryDelay + 0.01
			self.IsShooting = ct + self.PrimaryBusyTime

			if self.Owner:IsOnGround() then
				local moving = 25 < self.Owner:GetVelocity():Length()
				if moving then
					if self.Owner:Crouching() then
						self:ShootBullet(self.PrimaryDamage, self.PrimaryNumShots, self.ConeCrouchMoving)
					else
						self:ShootBullet(self.PrimaryDamage, self.PrimaryNumShots, self.ConeMoving)
					end
				else
					if self.Owner:Crouching() then
						self:ShootBullet(self.PrimaryDamage, self.PrimaryNumShots, self.ConeCrouching)
					else
						self:ShootBullet(self.PrimaryDamage, self.PrimaryNumShots, self.Cone)
					end
				end
			else
				self:ShootBullet(self.PrimaryDamage, self.PrimaryNumShots, self.ConeJumping)
			end
		end
	end

	function SWEP:Initialize()
		self:SetWeaponHoldType(self.HoldType)
		self:SetDeploySpeed(3)
		self.OriginalWalkSpeed = self.WalkSpeed
	end

	function SWEP:ShootBullet(fDamage, iNumber, fCone)
		local owner = self.Owner
		if iNumber == 1 then
			local bullet = ents.Create("projectile_asbullet")
			if bullet:IsValid() then
				bullet:SetPos(owner:GetShootPos())
				local ang = owner:EyeAngles()
				ang:RotateAroundAxis(ang:Up(), math.Rand(-fCone, fCone))
				ang:RotateAroundAxis(ang:Right(), math.Rand(-fCone, fCone))
				local fwd = ang:Forward()
				bullet.Heading = fwd
				bullet:SetAngles(ang)
				bullet:SetOwner(owner)
				bullet:SetColor(self.colBulletR, self.colBulletG, self.colBulletB, 255)
				bullet.Attacker = owner
				bullet.Inflictor = self
				bullet.BulletSpeed = self.BulletSpeed
				bullet:Spawn()
				bullet.Damage = fDamage
				bullet:GetPhysicsObject():SetVelocityInstantaneous(fwd * self.BulletSpeed)
			end
		else
			for i=1, iNumber do
				local bullet = ents.Create("projectile_asbullet")
				if bullet:IsValid() then
					bullet:SetPos(owner:GetShootPos())
					local ang = owner:EyeAngles()
					ang:RotateAroundAxis(ang:Up(), math.Rand(-fCone, fCone))
					ang:RotateAroundAxis(ang:Right(), math.Rand(-fCone, fCone))
					local fwd = ang:Forward()
					bullet.Heading = fwd
					bullet:SetAngles(ang)
					bullet:SetOwner(owner)
					bullet:SetColor(self.ColBulletR, self.ColBulletG, self.ColBulletB, 255)
					bullet.Attacker = owner
					bullet.Inflictor = self
					bullet.BulletSpeed = self.BulletSpeed
					bullet:Spawn()
					bullet.Damage = fDamage
					bullet:GetPhysicsObject():SetVelocityInstantaneous(fwd * self.BulletSpeed)
				end
			end
		end
	end

	local ActIndex = {}
	ActIndex["pistol"] = ACT_HL2MP_IDLE_PISTOL
	ActIndex["smg"] = ACT_HL2MP_IDLE_SMG1
	ActIndex["grenade"] = ACT_HL2MP_IDLE_GRENADE
	ActIndex["ar2"] = ACT_HL2MP_IDLE_AR2
	ActIndex["shotgun"] = ACT_HL2MP_IDLE_SHOTGUN
	ActIndex["rpg"] = ACT_HL2MP_IDLE_RPG
	ActIndex["physgun"] = ACT_HL2MP_IDLE_PHYSGUN
	ActIndex["crossbow"] = ACT_HL2MP_IDLE_CROSSBOW
	ActIndex["melee"] = ACT_HL2MP_IDLE_MELEE
	ActIndex["melee2"] = ACT_HL2MP_IDLE_MELEE2
	ActIndex["slam"] = ACT_HL2MP_IDLE_SLAM
	ActIndex["fist"] = ACT_HL2MP_IDLE_FIST
	ActIndex["passive"] = ACT_HL2MP_IDLE_PASSIVE
	ActIndex["knife"] = ACT_HL2MP_IDLE_KNIFE
	ActIndex["normal"] = ACT_HL2MP_IDLE

	function SWEP:SetWeaponHoldType(t, i)
		t = t or "normal"
		local index = ActIndex[t]
		if index then
			self.ActivityTranslate = {}
			self.ActivityTranslate[ACT_HL2MP_IDLE] = index
			self.ActivityTranslate[ACT_HL2MP_WALK] = index+1
			self.ActivityTranslate[ACT_HL2MP_RUN] = index+2
			self.ActivityTranslate[ACT_HL2MP_IDLE_CROUCH] = index+3
			self.ActivityTranslate[ACT_HL2MP_WALK_CROUCH] = index+4
			self.ActivityTranslate[ACT_HL2MP_GESTURE_RANGE_ATTACK] = index+5
			self.ActivityTranslate[ACT_HL2MP_GESTURE_RELOAD] = index+6
			self.ActivityTranslate[ACT_HL2MP_JUMP] = index+7
			self.ActivityTranslate[ACT_RANGE_ATTACK1] = index+8
		else
			Msg("SWEP:SetWeaponHoldType - ActIndex[ \""..t.."\" ] isn't set!\n")
		end
	end
end

function SWEP:TranslateActivity(act)
	return self.ActivityTranslate[act] or -1
end

function SWEP:Reload()
	if self:GetNextReload() <= CurTime() and not self:IsBusy() and self:Clip1() < self.Primary.ClipSize then
		self:SendWeaponAnim(ACT_VM_RELOAD)
		self.Owner:SetAnimation(PLAYER_RELOAD)
		local endtime = CurTime() + self:SequenceDuration()
		self.IsReloading = endtime
		self:SetNextReload(endtime)
		if self.ReloadSound then
			self:EmitSound(self.ReloadSound)
		end
	end
end

--[[function SWEP:ShootBullet(fDamage, iNumber, fCone)
	local owner = self.Owner
	if iNumber == 1 then
		local ang = owner:EyeAngles()
		ang:RotateAroundAxis(ang:Up(), math.Rand(-fCone, fCone))
		ang:RotateAroundAxis(ang:Right(), math.Rand(-fCone, fCone))
		PhysicalBullet(self.Owner, self, owner:GetShootPos(), ang:Forward(), self.BulletSpeed, fDamage)
	else
		for i=1, iNumber do
			local ang = owner:EyeAngles()
			ang:RotateAroundAxis(ang:Up(), math.Rand(-fCone, fCone))
			ang:RotateAroundAxis(ang:Right(), math.Rand(-fCone, fCone))
			PhysicalBullet(self.Owner, self, owner:GetShootPos(), ang:Forward(), self.BulletSpeed, fDamage)
		end
	end
end]]

if CLIENT then
	local SprintAng = 0
	local SprintDist = 0
	function SWEP:GetViewModelPosition(pos, ang)
		if SprintAng == 0 and SprintDist == 0 and not self.Owner.Sprinting then return pos, ang end

		if self.Owner.Sprinting then
			SprintAng = math.min(20, SprintAng + FrameTime() * 130)
			SprintDist = math.min(5.5, SprintDist + FrameTime() * 30)
		else
			SprintAng = math.max(0, SprintAng - FrameTime() * 200)
			SprintDist = math.max(0, SprintDist - FrameTime() * 50)
		end

		pos = pos + SprintDist * -1 * ang:Forward()

		ang = ang * 1
		ang:RotateAroundAxis(ang:Right(), SprintAng)

		return pos, ang
	end

	function SWEP:ShootBullet(fDamage, iNumber, fCone)
	end

	function SWEP:Initialize()
		self:SetDeploySpeed(1.75)
		self.OriginalWalkSpeed = self.WalkSpeed
	end

	function SWEP:PrimaryAttack()
		if self:CanPrimaryAttack() then
			local ct = CurTime()
			self:SetNextPrimaryFire(ct + self.PrimaryDelay)
			self:EmitSound(self.PrimarySound)

			self.IsShooting = CurTime() + self.PrimaryDelay + 0.01
			self.WalkSpeed = math.max(86, self.OriginalWalkSpeed - 60)

			self:TakePrimaryAmmo(1)
			local owner = self.Owner
			--local recoil = self.PrimaryRecoil
			--owner:ViewPunch(Angle(math.Rand(-0.2, -0.1) * recoil, math.Rand(-0.1, 0.1) * recoil, 0))

			self:SetNetworkedFloat("LastShootTime", ct)

			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			owner:SetAnimation(PLAYER_ATTACK1)

			--self.IsShooting = ct + 0.15

			--[[local eyeang = owner:EyeAngles()
			eyeang:RotateAroundAxis(eyeang:Right(), math.Rand(0.8, 1.2) * recoil)
			eyeang:RotateAroundAxis(eyeang:Up(), math.Rand(-0.2, 0.2) * recoil)
			eyeang.roll = 0
			self.Owner:SetEyeAngles(eyeang)]]

			if owner:IsOnGround() then
				local moving = 25 < self.Owner:GetVelocity():Length()
				if moving then
					if self.Owner:Crouching() then
						self:ShootBullet(self.PrimaryDamage, self.PrimaryNumShots, self.ConeCrouchMoving)
					else
						self:ShootBullet(self.PrimaryDamage, self.PrimaryNumShots, self.ConeMoving)
					end
				else
					if self.Owner:Crouching() then
						self:ShootBullet(self.PrimaryDamage, self.PrimaryNumShots, self.ConeCrouching)
					else
						self:ShootBullet(self.PrimaryDamage, self.PrimaryNumShots, self.Cone)
					end
				end
			else
				self:ShootBullet(self.PrimaryDamage, self.PrimaryNumShots, self.ConeJumping)
			end
		end
	end

	function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
		draw.SimpleText(self.PrintName, "DefaultBold", x + wide * 0.5, y + tall * 0.5, COLOR_RED, TEXT_ALIGN_CENTER)
	end

	SWEP.CrossHairScale = 1
	function SWEP:DrawHUD()
		local x = w * 0.5
		local y = h * 0.5

		local scalebyheight = (h / 768) * 0.2

		local scale

		if self.Owner:IsOnGround() then
			local moving = 25 < self.Owner:GetVelocity():Length()
			if moving then
				if self.Owner:Crouching() then
					scale = scalebyheight * self.ConeCrouchMoving
				else
					scale = scalebyheight * self.ConeMoving
				end
			else
				if self.Owner:Crouching() then
					scale = scalebyheight * self.ConeCrouching
				else
					scale = scalebyheight * self.Cone
				end
			end
		else
			scale = scalebyheight * self.ConeJumping
		end

		surface.SetDrawColor(0, 230, 0, 230)

		self.CrossHairScale = math.Approach(self.CrossHairScale, scale, FrameTime() * 5 + math.abs(self.CrossHairScale - scale) * 0.012)

		local dispscale = self.CrossHairScale
		local gap = 40 * dispscale
		local length = gap + 10 * dispscale
		surface.DrawLine(x - length, y, x - gap, y)
		surface.DrawLine(x + length, y, x + gap, y)
		surface.DrawLine(x, y - length, x, y - gap)
		surface.DrawLine(x, y + length, x, y + gap)
	end
end

function SWEP:CanPrimaryAttack()
	if self.Owner.Stunned or self.IsReloading then return false end

	if self:Clip1() <= 0 then
		self:EmitSound("Weapon_Pistol.Empty")
		self:SetNextPrimaryFire(CurTime() + self.PrimaryDelay)
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP:SecondaryAttack()
	if CurTime() < self.NextSecondaryAttack or self.Owner.Stunned then return end
	self.NextSecondaryAttack = CurTime() + 0.5
end

function SWEP:OnRestore()
	self.NextSecondaryAttack = 0
end
