AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.NoRemoveOnDeath = true

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetModel("models/Nova/w_headcrab.mdl")
end

function ENT:Think()
end
