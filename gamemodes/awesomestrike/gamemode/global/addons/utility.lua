if CLIENT then return end

function PrintMessageAll(int, str)
	for _, pl in pairs(player.GetAll()) do
		pl:PrintMessage(int, str)
	end
end

function ConvertNet(str)
	return string.sub(str, 11)
end
