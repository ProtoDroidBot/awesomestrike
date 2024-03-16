AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.TOnly = true

function SWEP:Initialize()
	self:SetWeaponHoldType("slam")
end

util.PrecacheSound("weapons/c4/c4_plant.wav")
function SWEP:Think()
	if self.Plant and self.Plant <= CurTime() and not self.Planted then
		if not self.Owner.CanPlantBomb then
			self.Planted = nil
			self.Plant = nil
			self:SetNetworkedBool("cantswap", false)
			self.Owner:Freeze(false)
		else
			local ent = ents.Create("planted_bomb")
			if ent:IsValid() then
				self.Planted = true
				self.Owner:Freeze(false)
				ent:SetPos(self.Owner:GetPos())
				--ent:SetAngles(self.Owner:GetAngles())
				ent:Spawn()
				ent:EmitSound("weapons/c4/c4_plant.wav")

				for _, pl in pairs(player.GetAll()) do
					pl:PrintMessage(HUD_PRINTCENTER, "Bomb has been planted!")
					pl:SendLua("surface.PlaySound(\"radio/bombpl.wav\")")
				end

				self:Remove()
			end
		end
	end
end

function SWEP:CanPrimaryAttack()
	return true
end

util.PrecacheSound("weapons/c4/c4_click.wav")
function SWEP:PrimaryAttack()
	if self.Plant then return end

	local owner = self.Owner

	if owner.CanPlantBomb and owner:IsOnGround() then
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
	else
		owner:PrintMessage(HUD_PRINTCENTER, "The bomb must be planted at a bomb site!")
	end
end
