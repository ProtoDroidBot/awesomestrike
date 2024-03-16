AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/weapons/w_c4_planted.mdl")
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	--self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetUseType(SIMPLE_USE)
end

function ENT:Use(pl)
	if pl == self.Owner and not self.Disarmed and pl:GetEyeTrace().Entity == self then
		self.Disarmed = true
		self:EmitSound("weapons/c4/c4_disarm.wav")
		self:Remove()

		local wep = pl:GetWeapon("weapon_as_remotedet")
		if wep and wep:IsValid() then
			wep.Plant = nil
			wep.Planted = nil
			wep:SetNetworkedBool("cantswap", false)
		end
	end
end

function ENT:OnRemove()
	local owner = self.Owner
	if owner:IsValid() then
		owner:StripWeapon("weapon_as_remotedet")
	end
end

function ENT:Detonate()
	if self.Detonated then return end
	self.Detonated = true

	local pos = self:GetPos()

	local effectdata = EffectData()
		effectdata:SetOrigin(pos)
	util.Effect("Explosion", effectdata, true, true)

	util.BlastDamage(self, self.Owner, pos, 180, 150)

	self:Remove()
end

function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	local owner = attacker:GetOwner()
	if owner:IsValid() then attacker = owner end
	if 1 <= dmginfo:GetDamage() and (attacker == self.Owner or not (attacker:IsPlayer() and attacker:Team() == self.TeamID)) then
		self.FutureDetonate = true
		self:NextThink(CurTime())
	end
end

function ENT:Think()
	if self.FutureDetonate then
		self:Detonate()
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_PVS
end
