AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.DieTime = CurTime() + math.Rand(20, 35)

	self:SetModel("models/props_trainstation/train001.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:Wake()
	end

	util.PrecacheSound("ambient/alarms/train_horn2.wav")
	util.PrecacheSound("ambient/alarms/train_horn_distant1.wav")
end

function ENT:AcceptInput(name, activator, caller, args)
	if name == "closehorn" then
		for _, pl in pairs(player.GetAll()) do
			pl:SendLua("surface.PlaySound(\"ambient/alarms/train_horn2.wav\")")
		end

		return true
	elseif name == "farhorn" then
		for _, pl in pairs(player.GetAll()) do
			pl:SendLua("surface.PlaySound(\"ambient/alarms/train_horn_distant1.wav\")")
		end

		return true
	elseif name == "doban" then
		local banee = self.Banee
		if banee:IsValid() and banee.BanTrainCommand then
			game.ConsoleCommand(banee.BanTrainCommand)
		end

		return true
	end
end

function ENT:Think()
	local banee = self.Banee
	if banee:IsValid() and banee:GetPos().y <= self:GetPos().y and not self.AlreadyHit then
		self.AlreadyHit = true
		banee:TakeDamage(1000, self, self)
		if banee:Alive() then
			banee:Kill()
		end
		PrintMessage(HUD_PRINTTALK, banee:Name().." was hit by the Ban Train.")
		gatekeeper.Drop(banee:UserID(), banee.BanTrainComment or "Hit by the ban train.")
		self:Fire("doban", "", 0.75)
		self:Fire("kill", "", 6)
	end

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetVelocityInstantaneous(Vector(0, 4000, 0))
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_PVS
end
