AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

function SWEP:Initialize()
	self:SetWeaponHoldType("slam")
end

util.PrecacheSound("weapons/slam/mine_mode.wav")
function SWEP:Think()
	if self.Plant and self.Plant <= CurTime() and not self.Planted then
		local ent = ents.Create("planted_remotedet")
		if ent:IsValid() then
			self.Planted = true
			self.Owner:Freeze(false)
			self:SetNetworkedBool("cantswap", false)
			ent:SetPos(self.Owner:GetPos())
			--ent:SetAngles(self.Owner:GetAngles())
			ent.Owner = self.Owner
			ent.TeamID = self.Owner:Team()
			ent:SetOwner(self.Owner)
			local col = team.GetColor(ent.TeamID)
			ent:SetColor(col.r, col.g, col.b, 255)
			ent:Spawn()
			ent:EmitSound("weapons/slam/mine_mode.wav")
			self:SendWeaponAnim(ACT_VM_IDLE)
		end
	end
end

function SWEP:CanPrimaryAttack()
	return true
end

util.PrecacheSound("weapons/c4/c4_click.wav")
util.PrecacheSound("buttons/button24.wav")
function SWEP:PrimaryAttack()
	if self.Deted then return end

	if self.Planted then
		self.Deted = true

		for _, ent in pairs(ents.FindByClass("planted_remotedet")) do
			if ent.Owner == self.Owner then
				ent:Detonate()
			end
		end

		self.Owner:EmitSound("buttons/button24.wav")

		self:Remove()
		return
	end

	if self.Plant then return end

	local owner = self.Owner

	self:SetNetworkedBool("cantswap", true)
	self.Plant = CurTime() + 2.8
	owner:Freeze(true)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	owner:EmitSound("weapons/c4/c4_click.wav")

	if owner.Sprinting then
		owner:RemoveStatus("sprint", false, true)
	end
	if owner.DashDodging then
		owner:RemoveStatus("dashdodge*", false, true)
	end
end
