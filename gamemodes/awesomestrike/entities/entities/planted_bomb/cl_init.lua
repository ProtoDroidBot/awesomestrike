include("shared.lua")

util.PrecacheSound("weapons/c4/c4_click.wav")

local matGlow = Material("sprites/light_glow02_add")

function ENT:Initialize()
	self.Time = 0.7
	self.NextBeep = CurTime()

	self.Death = CurTime() + 45
	self.DefusePercent = 0

	GAMEMODE.BOMBENTITY = self
end

function ENT:Think()
	if self.NextBeep <= CurTime() then
		self:EmitSound("weapons/c4/c4_click.wav")

		self.Time = math.Clamp((self.Death - CurTime()) * 0.06, 0.15, 1.5)
		self.NextBeep = CurTime() + self.Time
	end
end

function ENT:Draw()
	self:DrawModel()

	local tim = (math.max(self.NextBeep - CurTime(), 0.4)) * 32
	render.SetMaterial(matGlow)
	render.DrawSprite(self:GetPos() + self:GetUp() * 8, tim, tim, COLOR_RED)
end
