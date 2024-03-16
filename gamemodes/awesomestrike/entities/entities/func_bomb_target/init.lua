ENT.Type = "brush"

function ENT:Initialize()
	if self.On == nil then
		self.On = true
	end

	self.bombexplodes = self.bombexplodes or {}
end

function ENT:Think()
end

function ENT:KeyValue(key, value)
	if string.lower(key) == "bombexplode" then
		local tab = string.Explode(",", value)
		self.bombexplodes = self.bombexplodes or {}
		table.insert(self.bombexplodes, {entityname=tab[1], input=tab[2], args=tab[3], delay=tab[4], reps=tab[5]})
	end
end

function ENT:AcceptInput(name, activator, caller, arg)
	name = string.lower(name)
	if name == "enable" then
		self.On = true

		return true
	elseif name == "disable" then
		self.On = false
		for _, pl in pairs(player.GetAll()) do
			if pl.CanPlantBomb == self then
				pl.CanPlantBomb = nil
				pl:SendLua("CanPlantBomb=nil")
			end
		end

		return true
	elseif name == "toggle" then
		if self.On then
			self:AcceptInput("disable", activator, caller, arg)
		else
			self:AcceptInput("enable", activator, caller, arg)
		end

		return true
	elseif name == "bombexplode" then
		for _, ent in pairs(ents.FindByClass("planted_bomb")) do
			ent:Explode()
		end

		return true
	end
end

function ENT:FireOff(intab, activator, caller)
	for key, tab in pairs(intab) do
		for __, subent in pairs(ents.FindByName(tab.entityname)) do
			if tab.delay == 0 then
				subent:Input(tab.input, activator, caller, tab.args)
			else
				timer.Simple(tab.delay, function() if subent:IsValid() then subent:Input(tab.input, activator, caller, tab.args) end end)
			end
		end
	end
end

function ENT:StartTouch(ent)
	if ent:IsPlayer() then
		ent.CanPlantBomb = self
		ent:SendLua("CanPlantBomb="..self:EntIndex())
	end
end

function ENT:EndTouch(ent)
	if ent.CanPlantBomb == self then
		ent.CanPlantBomb = nil
		ent:SendLua("CanPlantBomb=nil")
	end
end

function ENT:Touch(ent)
end
