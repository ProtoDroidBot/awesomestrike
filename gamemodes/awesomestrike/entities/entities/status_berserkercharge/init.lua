AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:PlayerSet(pPlayer, bExists)
	self.StartCharge = CurTime() + 0.1
	self.EndCharge = self.StartCharge + 0.55
	self:SetModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
	pPlayer.BerserkerCharge = self
	pPlayer.BerserkFire = self
end

function ENT:OnRemove()
	local parent = self:GetParent()
	if parent:IsValid() then
		parent.BerserkerCharge = nil
		parent.BerserkFire = nil
		if parent:Alive() then
			parent:Stun(0.4, true)
		end
	end
end

function ENT:Think()
	local ct = CurTime()

	if self.EndCharge <= ct then
		self:Remove()
		return
	end

	local owner = self:GetOwner()

	if not self.PlayedSound and self.StartCharge <= ct then
		self.PlayedSound = true

		owner:EmitSound("weapons/mortar/mortar_shell_incomming1.wav", 69, math.Rand(130, 135))
	end

	if not self.StopHitting then
		local midpos = owner:LocalToWorld(owner:OBBCenter())
		local tr = util.TraceEntityHull({start=midpos, endpos=midpos + owner:GetForward() * 16, filter=owner}, owner)
		local hitent = tr.Entity
		if hitent:IsValid() and hitent:IsPlayer() and hitent:Team() ~= owner:Team() then
			if IsGuardStun(owner, hitent) then
				Guarded(owner, hitent, 1)
			else
				hitent:TakeDamage(10, owner, self)
				hitent:EmitSound("physics/concrete/boulder_impact_hard"..math.random(1,4)..".wav", 70, math.Rand(83, 87))
				if hitent:IsPlayer() and hitent:Alive() then
					hitent:SetGroundEntity(NULL)
					hitent:SetVelocity((hitent:GetPos() - owner:GetPos()):Normalize() * 480 + Vector(0,0,300))
					hitent:GiveStatus("knockdown", 6)
				end
			end
			self.StopHitting = true
			self.EndCharge = math.min(self.EndCharge, ct + 0.1)
		end
	end

	self:NextThink(ct)
	return true
end
