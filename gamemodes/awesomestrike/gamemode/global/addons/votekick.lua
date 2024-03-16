if CLIENT then return end

NDB.KickVotesFor = {}
NDB.BanVotesFor = {}
NDB.KickVotedAlready = {}
NDB.BanVotedAlready = {}

NDB.AddPrivateChatCommand("/votekick", function(sender, text)
	local curtime = CurTime()
	if sender.NextVoteKickBan and sender.NextVoteKickBan > curtime then
		sender:PrintMessage(HUD_PRINTTALK, "Please wait ".. math.ceil(sender.NextVoteKickBan - curtime) .." more seconds before voting to kick or ban someone again.")
		return
	end

	local allplayers = player.GetAll()
	if #allplayers <= 5 then
		sender:PrintMessage(HUD_PRINTTALK, "Votekick is disabled while there are 5 or less people in the server.")
		return
	end

	for _, pl in pairs(allplayers) do
		if pl:IsAdmin() and not pl.Incognito then
			sender:PrintMessage(HUD_PRINTTALK, "Votekick is disabled while there are admins in the server.")
			return
		end
	end

	text = string.sub(text, 11)

	if text == "" then
		sender:SendLua("OpenVoteKick()")
	else
		text = string.lower(text)
		for _, pl in pairs(allplayers) do
			if string.lower(pl:Name()) == text then
				sender:ConCommand("votekick "..pl:Name())
				return
			end
		end
	end
end, " <name> - Vote to kick a player.")

NDB.AddPrivateChatCommand("/voteban", function(sender, text)
	local curtime = CurTime()
	if sender.NextVoteKickBan and sender.NextVoteKickBan > curtime then
		sender:PrintMessage(HUD_PRINTTALK, "Please wait ".. math.ceil(sender.NextVoteKickBan - curtime) .." more seconds before voting to kick or ban someone again.")
		return
	end

	local allplayers = player.GetAll()
	if #allplayers <= 5 then
		sender:PrintMessage(HUD_PRINTTALK, "Voteban is disabled while there are 5 or less people in the server.")
		return
	end

	for _, pl in pairs(allplayers) do
		if pl:IsAdmin() and not pl.Incognito then
			sender:PrintMessage(HUD_PRINTTALK, "Voteban is disabled while there are admins in the server.")
			return
		end
	end

	text = string.sub(text, 10)

	if text == "" then
		sender:SendLua("OpenVoteKick(true)")
	else
		text = string.lower(text)
		for _, pl in pairs(allplayers) do
			if string.lower(pl:Name()) == text then
				sender:ConCommand("voteban "..pl:Name())
				return
			end
		end
	end
end, " <name> - Vote to ban a player.")

concommand.Add("votekick", function(sender, command, arguments)
	local curtime = CurTime()
	if sender.NextVoteKickBan and sender.NextVoteKickBan > curtime then
		sender:PrintMessage(HUD_PRINTTALK, "Please wait ".. math.ceil(sender.NextVoteKickBan - curtime) .." more seconds before voting to kick or ban someone again.")
		return
	end

	local allplayers = player.GetAll()
	local numplayers = #allplayers
	if numplayers <= 5 then
		sender:PrintMessage(HUD_PRINTTALK, "<red>Votekick is disabled while there are 5 or less people in the server.</red>")
		return
	end

	for _, pl in pairs(allplayers) do
		if pl:IsAdmin() and not pl.Incognito then
			sender:PrintMessage(HUD_PRINTTALK, "<red>Votekick is disabled while there are admins in the server.</red>")
			return
		end
	end

	arguments = table.concat(arguments, " ")

	local sendersteam = sender:SteamID()

	local target

	if tonumber(arguments) then
		for _, pl in pairs(allplayers) do
			if not pl:IsAdmin() and ConvertNet(pl:SteamID()) == arguments then
				target = pl
				break
			end
		end
	else
		for _, pl in pairs(allplayers) do
			if not pl:IsAdmin() and pl:Name() == arguments then
				target = pl
				break
			end
		end
	end

	if target then
		local targetsteam = target:SteamID()
		local votealreadystr = sendersteam.."votekicked"..targetsteam
		if NDB.KickVotedAlready[votealreadystr] then
			sender:PrintMessage(HUD_PRINTTALK, "<yellow>You already voted to kick "..target:NoParseName()..".</yellow>")
		else
			sender.NextVoteKickBan = curtime + 30
			NDB.KickVotedAlready[votealreadystr] = true
			NDB.KickVotesFor[targetsteam] = NDB.KickVotesFor[targetsteam] or 0
			NDB.KickVotesFor[targetsteam] = NDB.KickVotesFor[targetsteam] + 1
			local total = NDB.KickVotesFor[targetsteam]
			LOGCONTENTS = LOGCONTENTS.."<"..sendersteam.."> "..sender:Name().." voted to kick <"..targetsteam.."> "..target:Name()..".\n"
			if total >= 11 or total >= numplayers * 0.55 then
				PrintMessageAll(HUD_PRINTTALK, sender:NoParseName().." <red>voted to kick</red> "..target:NoParseName()..". <flash=30,255,30,6>VOTE PASSES</flash>.")
				LOGCONTENTS = LOGCONTENTS.."<"..targetsteam.."> "..target:Name().." VOTEKICKED by "..total.." people.\n"

				if gatekeeper then
					gatekeeper.Drop(target:UserID(), "Votekicked by "..total.." people.")
				else
					local concom = "kickid "..targetsteam.." Votekicked by "..total.." people.\n"
					game.ConsoleCommand(concom)
					game.ConsoleCommand(concom)
					game.ConsoleCommand(concom)
				end
				
				NDB.KickVotesFor[targetsteam] = nil
				local entry = "votekicked"..targetsteam
				for k, v in pairs(NDB.KickVotedAlready) do
					if string.find(k, entry, 1, true) then
						NDB.KickVotedAlready[k] = nil
					end
				end
			else
				PrintMessageAll(HUD_PRINTTALK, sender:NoParseName().." <red>voted to kick</red> "..target:NoParseName()..". Say /votekick to participate. "..math.ceil(math.min(11, numplayers * 0.55) - total).." more votes are needed.")
			end
		end
	else
		sender:PrintMessage(HUD_PRINTTALK, "<red>Player not found.</red>")
	end
end)

concommand.Add("voteban", function(sender, command, arguments)
	local curtime = CurTime()
	if sender.NextVoteKickBan and sender.NextVoteKickBan > curtime then
		sender:PrintMessage(HUD_PRINTTALK, "Please wait ".. math.ceil(sender.NextVoteKickBan - curtime) .." more seconds before voting to kick or ban someone again.")
		return
	end

	local allplayers = player.GetAll()
	local numplayers = #allplayers
	if numplayers <= 5 then
		sender:PrintMessage(HUD_PRINTTALK, "<red>Voteban is disabled while there are 5 or less people in the server.</red>")
		return
	end

	for _, pl in pairs(allplayers) do
		if pl:IsAdmin() and not pl.Incognito then
			sender:PrintMessage(HUD_PRINTTALK, "<red>Voteban is disabled while there are admins in the server.</red>")
			return
		end
	end

	arguments = table.concat(arguments, " ")

	local sendersteam = sender:SteamID()

	local target

	if tonumber(arguments) then
		for _, pl in pairs(allplayers) do
			if not pl:IsAdmin() and ConvertNet(pl:SteamID()) == arguments then
				target = pl
				break
			end
		end
	else
		for _, pl in pairs(allplayers) do
			if not pl:IsAdmin() and pl:Name() == arguments then
				target = pl
				break
			end
		end
	end

	if target then
		local targetsteam = target:SteamID()
		local votealreadystr = sendersteam.."votebanned"..targetsteam
		if NDB.BanVotedAlready[votealreadystr] then
			sender:PrintMessage(HUD_PRINTTALK, "<yellow>You already voted to ban "..target:NoParseName()..".</yellow>")
		else
			sender.NextVoteKickBan = curtime + 30
			NDB.BanVotedAlready[votealreadystr] = true
			NDB.BanVotesFor[targetsteam] = NDB.BanVotesFor[targetsteam] or 0
			NDB.BanVotesFor[targetsteam] = NDB.BanVotesFor[targetsteam] + 1
			local total = NDB.BanVotesFor[targetsteam]
			LOGCONTENTS = LOGCONTENTS.."<"..sendersteam.."> "..sender:Name().." voted to ban <"..targetsteam.."> "..target:Name()..".\n"
			if 14 <= total or numplayers * 0.65 <= total then
				PrintMessageAll(HUD_PRINTTALK, sender:NoParseName().." <red>voted to ban</red> "..target:NoParseName().." for an hour. <flash=30,255,30,6>VOTE PASSES</flash>.")
				LOGCONTENTS = LOGCONTENTS.."<"..targetsteam.."> "..target:Name().." VOTEBANNED by "..total.." people for 60 minutes.\n"
				NDB.InstantBan(target, "VOTEBANNED by "..total.." people", 3600, "Democracy")

				NDB.BanVotesFor[targetsteam] = nil
				local entry = "votebanned"..targetsteam
				for k, v in pairs(NDB.BanVotedAlready) do
					if string.find(k, entry, 1, true) then
						NDB.BanVotedAlready[k] = nil
					end
				end
			else
				PrintMessageAll(HUD_PRINTTALK, sender:Name().." <red>voted to ban</red> "..target:NoParseName().." for an hour. Say /voteban to participate. "..math.ceil(math.min(14, numplayers * 0.65) - total).." more votes are needed.")
			end
		end
	else
		sender:PrintMessage(HUD_PRINTTALK, "<red>Player not found.</red>")
	end
end)
