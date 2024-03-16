AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/weapons/w_c4_planted.mdl")
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetUseType(SIMPLE_USE)

	self.Death = CurTime() + 45
	self.Defuser = NULL
	self.DefusePercent = 0

	GAMEMODE.BOMBENTITY = self
end

util.PrecacheSound("weapons/c4/c4_disarm.wav")
function ENT:Use(pl)
	if pl:Team() == TEAM_CT and not (self.Defuser:IsPlayer() and self.Defuser:Alive()) and pl:TraceLine(64).Entity == self then
		self.Defuser = pl
		self.DefusePercent = 0.0001
		self:EmitSound("weapons/c4/c4_disarm.wav")
		self:SetNetworkedEntity("defuser", pl)
	end
end

function ENT:Think()
	local ct = CurTime()
	if self.Death <= ct then
		GAMEMODE:EndRound(TEAM_T)

		local Position = self:GetPos() + self:GetUp() * 32

		self:EmitSound("weapons/c4/c4_exp_deb2.wav")
		util.ScreenShake(Position, 64, 128, 3, 8192)
		util.BlastDamage(self, self, Position, 1200, 600)

		for _,ent in pairs(ents.FindInSphere(Position, 1200)) do
			if ent:IsPlayer() and ent:Alive() then
				ent.LastAttacker = NULL
				ent:TakeDamage(200, self)
			end
		end

		local effect = EffectData()
			effect:SetOrigin(Position)
		util.Effect("bomb_explode", effect)

		self:Remove()
	elseif 0 < self.DefusePercent then
		if not (self.Defuser:IsPlayer() and self.Defuser:Alive() and self.Defuser:TraceLine(64).Entity == self and self.Defuser:KeyDown(IN_USE)) then
			self.Defuser = NULL
			self.DefusePercent = 0
			self:SetNetworkedEntity("defuser", NULL)
		else
			self.DefusePercent = self.DefusePercent + FrameTime() * 13

			if 100 <= self.DefusePercent and not self.Defused then
				self.Defused = true
				for _, pl in pairs(player.GetAll()) do
					pl:PrintMessage(HUD_PRINTCENTER, self.Defuser:Name().." has defused the bomb!")
					pl:SendLua("surface.PlaySound(\"radio/bombdef.wav\")")
				end
				GAMEMODE:EndRound(TEAM_CT, true)
				self:Remove()
			else
				self:NextThink(ct)
				return true
			end
		end
	end
end

function ENT:KeyValue(key, value)
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end
