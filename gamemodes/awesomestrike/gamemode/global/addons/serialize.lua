if SERVER then
	AddCSLuaFile(NDB_ADDON_NAME)
end

function Deserialize(sIn)
	SRL = nil

	RunString(sIn)

	return SRL
end

local function MakeTable(tab, done)
	local str = ""
	local done = done or {}

	local sequential = table.IsSequential(tab)

	for key, value in pairs(tab) do
		local keytype = type(key)
		local valuetype = type(value)

		if sequential then
			key = ""
		else
			if keytype == "number" or keytype == "boolean" then 
				key ="["..tostring(key).."]="
			elseif keytype ~= "Entity" and keytype ~= "Player" then
				key = "["..string.format("%q", tostring(key)).."]="
			end
		end

		if valuetype == "table" and not done[value] then
			done[value] = true
			str = str..key.."{"..MakeTable(value, done).."},"
		else
			if valuetype == "string" then 
				value = string.format("%q", value)
			elseif valuetype == "Vector" then
				value = "Vector("..value.x..","..value.y..","..value.z..")"
			elseif valuetype == "Angle" then
				value = "Angle("..value.pitch..","..value.yaw..","..value.roll..")"
			elseif valuetype ~= "Entity" and valuetype ~= "Player" then
				value = tostring(value)
			end

			str = str .. key .. value .. ","
		end
	end

	if string.sub(str, -1) == "," then
		return string.sub(str, 1, string.len(str) - 1)
	else
		return str
	end
end

function Serialize(tIn)
	return "SRL={"..MakeTable(tIn).."}"
end
