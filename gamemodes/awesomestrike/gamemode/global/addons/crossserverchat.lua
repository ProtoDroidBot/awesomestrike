if CLIENT then return end

require("socket")
if not socket or not socket.udp then return end

local ThisServerIP = GetConVarString("ip")
local ThisServerPort = GetConVarString("hostport")

local Servers = {
{"65.60.53.26", "27015", 28900},
{"65.60.53.26", "27016", 28901},
{"65.60.53.26", "27017", 28902},
{"65.60.53.26", "27018", 28903},
{"65.60.53.26", "27019", 28904},
{"65.60.53.27", "27015", 28905},
{"65.60.53.27", "27016", 28906},
{"65.60.53.27", "27017", 28907},
{"65.60.53.27", "27018", 28908},
{"65.60.53.27", "27019", 28909}
}

NDB.AddPrivateChatCommand("/csc", function(sender, text)
	if sender.Muted and string.lower(sender.Muted) ~= "none" then
		sender:PrintMessage(HUD_PRINTTALK, "<red>You are muted and can't use CSC.</red>")
		return
	end

	local findmin, findmax, message = string.find(text, "/csc (.+)")
	if not message then return end
	message = string.Trim(message)
	if message == "" or message == " " then return end

	local msg = "<lightblue>[CSC]</lightblue> "..sender:NoParseName()..": "..message
	PrintMessage(HUD_PRINTTALK, msg)
	print(msg)
	LOGCONTENTS = LOGCONTENTS.."<"..sender:SteamID().."> sent a CSC message: "..message

	msg = "C$*3eSssJZsC#3§"..msg
	local sock = socket.udp()
	for _, tab in pairs(Servers) do
		if not (tab[1] == ThisServerIP and tab[2] == ThisServerPort) then
			sock:sendto(msg, tab[1], tab[3])
		end
	end
	sock:close()
end, "/csc <message> - Sends a message to every NoXiousNet server.")

hook.Add("Initialize", "CreateCSCSockets", function()
	hook.Remove("Initialize", "CreateCSCSockets")

	local Receiver
	for _, tab in pairs(Servers) do
		if tab[1] == ThisServerIP and tab[2] == ThisServerPort then
			local sock = socket.udp()
			sock:setsockname(ThisServerIP, tab[3])
			sock:settimeout(0)

			Receiver = sock
		end
	end

	hook.Add("Think", "ReceiveCSC", function()
		if Receiver then
			local datagram = Receiver:receive()
			if datagram then
				local _, __, message = string.find(datagram, "C%$%*3eSssJZsC%#3§(.+)")
				if message then
					PrintMessage(HUD_PRINTTALK, message)
					print(message)
				end
			end
		end
	end)

	hook.Add("ShutDown", "CloseSockets", function()
		hook.Remove("Think", "ReceiveCSC")
		if Receiver then
			Receiver:close()
		end
	end)
end)
