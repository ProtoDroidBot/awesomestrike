AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.NoRemoveOnDeath = true

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetModel("Models/Aviator/aviator.mdl")
end

function ENT:Think()
end
