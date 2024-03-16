util.PrecacheSound("physics/flesh/flesh_bloody_break.wav")

function EFFECT:Init(data)
	local player = data:GetEntity()
	local effects = data:GetScale()
	local radius = math.Round(data:GetRadius())
	--local dir = data:GetNormal() * -1

	if player and player:IsValid() then
		local pos = player:GetPos() + Vector(0, 0, 4)
		player:EmitSound("physics/flesh/flesh_bloody_break.wav")

		local effectdata = EffectData()
			effectdata:SetOrigin(pos + Vector(0,0,25))
			effectdata:SetMagnitude(math.random(30, 44))
			effectdata:SetRadius(radius)
			local vel = player:GetVelocity()
			effectdata:SetScale(math.max(vel:Length() * 1.5, 200))
			effectdata:SetNormal(vel:Normalize())
			effectdata:SetEntity(player)
		util.Effect("bloodstream", effectdata)

		for i=1, 2 do
			local effectdata = EffectData()
				effectdata:SetOrigin(pos + Vector(0,0,32) + VectorRand() * 12)
				effectdata:SetMagnitude(i)
				effectdata:SetScale(effects)
				effectdata:SetEntity(player)
				effectdata:SetRadius(radius)
			util.Effect("gib", effectdata)
		end

		for i=1, math.random(3, 4) do
			local effectdata = EffectData()
				effectdata:SetOrigin(pos + Vector(0,0,10) + VectorRand() * 12)
				effectdata:SetMagnitude(math.random(3, #HumanGibs))
				effectdata:SetScale(effects)
				effectdata:SetEntity(player)
				effectdata:SetRadius(radius)
			util.Effect("gib", effectdata)
		end
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
