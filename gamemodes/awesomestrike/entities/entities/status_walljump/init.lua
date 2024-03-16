AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.WallJumping = self
	--pPlayer:EmitSound("nox/stunon.wav")
end

function ENT:OnRemove()
	local parent = self:GetOwner()
	if parent:IsValid() then
		parent.WallJumping = nil
		if parent:Alive() then
			if util.TraceLine({start = parent:GetPos(), endpos = parent:GetPos() + self.Forward * 36, mask = MASK_SOLID, filter = parent}).Hit then
				parent:SetAnimation(PLAYER_JUMP)
				parent:SetLocalVelocity(self.HitNormal * 450 + Vector(0,0,450))
			end
		end
	end
end

function ENT:Think()
	local ct = CurTime()
	if self.DieTime < ct then
		self:Remove()
	else
		self:NextThink(ct)
		return true
	end
end
