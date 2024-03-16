AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_debris/metal_panel02a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:SetMass(2)
	phys:EnableGravity(false)
	phys:Wake()

	self:SetMaterial("models/props_lab/Tank_Glass001")
end

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.WeaponStatus = self
	self:SetParent(NULL)
end

function ENT:Think()
	local owner = self:GetOwner()
	local wep = owner:GetActiveWeapon()
	if not wep:IsValid() or wep:GetClass() ~= "weapon_as_forceshield" then
		self:Remove()
	elseif owner:GetRagdollEntity() then
		if not self.RagdollSet then
			self.RagdollSet = true
			self:SetSolid(SOLID_NONE)
		end
	else
		if self.RagdollSet then
			self.RagdollSet = nil
			self:SetSolid(SOLID_VPHYSICS)
		end

		local boneindex = owner:LookupBone("valvebiped.bip01_r_hand")
		if boneindex then
			local pos, ang = owner:GetBonePosition(boneindex)
			if pos then
				--self:SetPos(pos + ang:Forward() * 22)
				--self:SetAngles(ang)
				local phys = self:GetPhysicsObject()
				phys:Wake()
				phys:ComputeShadowControl({secondstoarrive = 0.001, pos = pos + ang:Forward() * 22, angle = ang, maxangular = 2000, maxangulardamp = 10000, maxspeed = 100000, maxspeeddamp = 1000, dampfactor = 0.8, teleportdistance = 8, deltatime = FrameTime()})
			end
		end
	end

	self:NextThink(CurTime())
	return true
end
