AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.Sprinting = self
	pPlayer:SetFOV(110, 0.75)
	if not bExists then
		RestoreSpeed(pPlayer, pPlayer:GetActiveWeapon().WalkSpeed)
	end
	--pPlayer:EmitSound("nox/stunon.wav")
end

function ENT:Think()
	local owner = self:GetOwner()

	if not owner:KeyDown(IN_FORWARD) or owner:Crouching() or owner:IsFrozen() or owner:IsBusy() then
		self:Remove()
	end
end

function ENT:OnRemove()
	local parent = self:GetOwner()
	if parent:IsValid() then
		if not self.SilentRemove then
			--parent:EmitSound("nox/stunoff.wav")
		end
		parent:SetFOV(parent:GetInfo("fov_desired"), 0.25)
		parent.Sprinting = nil
		RestoreSpeed(parent, parent:GetActiveWeapon().WalkSpeed)
	end
end
