AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Characters/Hostage_0"..math.random(1,4)..".mdl")

	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()

	self:SetSolid(SOLID_BBOX)
	self:SetMoveType(MOVETYPE_STEP)

	self:CapabilitiesAdd(CAP_MOVE_GROUND | CAP_MOVE_JUMP | CAP_MOVE_CLIMB | CAP_MOVE_SHOOT | CAP_USE | CAP_AUTO_DOORS | CAP_OPEN_DOORS | CAP_TURN_HEAD | CAP_ANIMATEDFACE | CAP_USE_SHOT_REGULATOR | CAP_FRIENDLY_DMG_IMMUNE | CAP_DUCK | CAP_AIM_GUN)

	self:SetMaxYawSpeed(5000)

	self:SetHealth(150)
	self:SetUseType(SIMPLE_USE)
	self.NextPlayerUse = 0
end

local schdEscort = ai_schedule.New()
schdEscort:AddTask("CheckEscortDead")
schdEscort:EngTask("TASK_GET_PATH_TO_TARGET", 0)
schdEscort:EngTask("TASK_RUN_PATH_TIMED", 0.1)
--schdEscort:EngTask("TASK_WAIT", 0.1)
schdEscort:AddTask("CheckEscortDead")

local schdIdle = ai_schedule.New()
schdIdle:EngTask("TASK_WAIT", 1)

function ENT:DoStartScheduleEscort()
	self:StartSchedule(schdEscort)
end

function ENT:DoStartScheduleIdle()
	self:StartSchedule(schdIdle)
end

function ENT:TaskStart_PlaySequence(data)
	local SequenceID = data.ID

	if data.Name then SequenceID = self:LookupSequence(data.Name) end

	self:ResetSequence(SequenceID)
	self:SetNPCState(NPC_STATE_SCRIPT)

	local Duration

	if data.Duration then
		Duration = data.Duration
	elseif data.Speed and 0 < data.Speed then
		SequenceID = self:SetPlaybackRate(data.Speed)
		Duration = self:SequenceDuration() / data.Speed
	else
		Duration = self:SequenceDuration()
	end

	if data.StartSounds then self:EmitSound(data.StartSounds[math.random(1, #data.StartSounds)]) end

	self.TaskSequenceEnd = CurTime() + Duration
end

function ENT:Task_PlaySequence(data)
	if CurTime() < self.TaskSequenceEnd then return end

	self:TaskComplete()
	self:SetNPCState(NPC_STATE_NONE)

	if data.EndSounds then self:EmitSound(data.EndSounds[math.random(1, #data.EndSounds)]) end

	self.TaskSequenceEnd = nil
end

function ENT:TaskStart_CheckEscortDead()
	self:TaskComplete()

	local escort = self.Escort

	if escort then
		if not escort:IsValid() then
			self:StartSchedule(schdIdle)
			self.Escort = nil
		elseif not escort:Alive() then
			self:StartSchedule(schdIdle)
			self.Escort = nil
		else
			local trueeye = self:TrueEyePos()
			local dist = escort:NearestPoint(trueeye):Distance(trueeye)
			if 1024 < dist then
				self:StartSchedule(schdIdle)
				self.Escort = nil
			else
				self:SetTarget(escort)
			end
		end
	end
end

function ENT:Task_CheckEscortDead()
end

function ENT:OnTakeDamage(dmg)
	if self.DEAD then return end

	local attacker = dmg:GetAttacker()

	local owner = attacker:GetOwner()
	if owner and owner:IsValid() then
		attacker = owner
	end

	self:SetHealth(self:Health() - dmg:GetDamage())

	self:EmitSound("hostage/hpain/hpain"..math.random(1,6)..".wav")

	if self:Health() <= 0 then
		self.DEAD = true
		local ragdoll = ents.Create("prop_ragdoll")
		if ragdoll:IsValid() then
			ragdoll:SetPos(self:GetPos())
			ragdoll:SetAngles(self:GetAngles())
			ragdoll:SetModel(self:GetModel())
			ragdoll:Spawn()
			ragdoll:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			if dmg and dmg.GetDamageForce then
				local force = dmg:GetDamageForce()
				if force:Length() == 0 then
					force = VectorRand() * 64
				end
				ragdoll:GetPhysicsObject():SetVelocityInstantaneous(force * 500)
			end
			ragdoll:Fire("kill", "", 15)
		end

		self:Remove()
		return
	end
end 

function ENT:SelectSchedule()
	local escort = self.Escort

	if escort and escort:IsValid() then
		self:StartSchedule(schdEscort)
	else
		self:StartSchedule(schdIdle)
	end
end

function ENT:GetAttackSpread(weapon, target)
	return 0
end
