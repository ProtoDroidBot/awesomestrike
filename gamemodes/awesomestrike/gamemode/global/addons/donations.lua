if CLIENT then return end

function NDB.AddMoneyDB(net, int)
	if tonumber(net) == nil then return end
	if tonumber(int) == nil then return end

	int = math.floor(int)
	for _, pl in pairs(player.GetAll()) do
		if ConvertNet(pl:SteamID()) == net then
			Msg("Person is currently connected.\n")
			if int ~= 0 then
				pl:AddMoney(int, true)
				pl:PrintMessage(HUD_PRINTTALK, "<flash=255,255,255,6>An admin has given you "..int.." Silver.</flash> <silkicon=heart>")
				file.Write("logs/donationlogs.txt", file.Read("logs/donationlogs.txt").." "..int.." Silver added: "..ConvertNet(pl:SteamID()).."\n")
				NDB.SaveInfo(pl)
				Msg("Gave "..int.." Silver.\n")
			end
			return
		end
	end
	if file.Exists("noxaccounts/"..net..".txt") then
		local tab = Deserialize(file.Read("noxaccounts/"..net..".txt"))
		tab.Money = tab.Money + int
		file.Write("noxaccounts/"..net..".txt", Serialize(tab))
		Msg("Account awarded "..int.." Silver!\n")
		file.Write("logs/donationlogs.txt", file.Read("logs/donationlogs.txt").." "..int.." Silver added: "..net.."\n")
	else
		Msg("Account did not exist!\n")
	end
end

function NDB.AddGoldMember(pl)
	pl.MemberLevel = MEMBER_GOLD
	pl:PrintMessage(HUD_PRINTTALK, "<flash=255,255,0,6>Your account's member level has been changed to Gold Member!</flash> <silkicon=emoticon_smile>")
	pl:SendLua("MySelf.MemberLevel=MEMBER_GOLD CheckDiamondGold()")
	Msg(pl:Name().." added as Gold Member!\n")
	file.Write("logs/donationlogs.txt", file.Read("logs/donationlogs.txt").." Gold Member added: "..ConvertNet(pl:SteamID()).."\n")
	NDB.SaveInfo(pl)
end

function NDB.AddGoldMemberDB(net)
	for _, pl in pairs(player.GetAll()) do
		if ConvertNet(pl:SteamID()) == net then
			Msg("Person is currently connected.\n")
			NDB.AddGoldMember(pl)
			return
		end
	end
	if file.Exists("noxaccounts/"..net..".txt") then
		local tab = Deserialize(file.Read("noxaccounts/"..net..".txt"))
		tab.MemberLevel = MEMBER_GOLD
		file.Write("noxaccounts/"..net..".txt", Serialize(tab))
		Msg("Account edited to Gold Member!\n")
		file.Write("logs/donationlogs.txt", file.Read("logs/donationlogs.txt").." Gold Member added: "..net.."\n")
	else
		Msg("Account did not exist!\n")
	end
end

function NDB.AddDiamondMember(pl)
	pl.MemberLevel = MEMBER_DIAMOND
	pl:PrintMessage(HUD_PRINTTALK, "<flash=255,255,255,6>Your account's member level has been changed to Diamond Member!</flash> <silkicon=emoticon_smile>")
	pl:SendLua("MySelf.MemberLevel=MEMBER_DIAMOND CheckDiamondGold()")
	Msg(pl:Name().." added as Diamond Member!\n")
	file.Write("logs/donationlogs.txt", file.Read("logs/donationlogs.txt").." Diamond Member added: "..ConvertNet(pl:SteamID()).."\n")
	NDB.SaveInfo(pl)
end

function NDB.AddDiamondMemberDB(net)
	for _, pl in pairs(player.GetAll()) do
		if ConvertNet(pl:SteamID()) == net then
			Msg("Person is currently connected.\n")
			NDB.AddDiamondMember(pl)
			return
		end
	end

	if file.Exists("noxaccounts/"..net..".txt") then
		local tab = Deserialize(file.Read("noxaccounts/"..net..".txt"))
		tab.MemberLevel = MEMBER_DIAMOND
		file.Write("noxaccounts/"..net..".txt", Serialize(tab))
		Msg("Account edited to Diamond Member!\n")
		file.Write("logs/donationlogs.txt", file.Read("logs/donationlogs.txt").." Diamond Member added: "..net.."\n")
	else
		Msg("Account did not exist!\n")
	end
end
