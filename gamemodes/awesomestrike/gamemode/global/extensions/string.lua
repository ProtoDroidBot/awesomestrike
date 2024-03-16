AddCSLuaFile("string.lua")

function string.RegularExplode(seperator, str)
	if seperator == "" then
		return string.ToTable(str)
	end

	local tble = {}
	local x = 1

	while true do
		local findmin, findmax = string.find(str, seperator, x)

		if findmin then
			table.insert(tble, string.sub(str, x, findmin))
			x = findmax + 1
		else
			table.insert(tble, string.sub(str, x))
			break
		end
	end

	return tble
end

function string.CommaSeparate(num)
	local k
	while true do
		num, k = string.gsub(num, "^(-?%d+)(%d%d%d)", '%1,%2')
		if k == 0 then break end
	end
	return num
end

function string.Replace(str, tofind, toreplace)
	if 0 < #tofind then
		local start = 1
		while true do
			local pos = string.find(str, tofind, start, true)

			if not pos then break end

			local left = string.sub(str, 1, pos - 1)
			local right = string.sub(str, pos + #tofind)

			str = left..toreplace..right
			start = pos + #toreplace
		end
	end

	return str
end
