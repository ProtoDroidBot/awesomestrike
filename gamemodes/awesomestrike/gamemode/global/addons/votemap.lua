if CLIENT then return end

NDB.EliminatedMaps = {}

hook.Add("InitPostEntity", "NDBInitPostEntity", function()
	hook.Remove("InitPostEntity", "NDBInitPostEntity")

	if not NDB.MapList[GAMEMODE_NAME] then return end

	local increment = NDB.EliminationIncrement[GAMEMODE_NAME]
	if not increment then return end

	if file.Exists(GAMEMODE_NAME.."_elim.txt") then
		NDB.EliminatedMaps = Deserialize(file.Read(GAMEMODE_NAME.."_elim.txt"))
	end
end)

hook.Add("PlayerReady", "SendElimination", function(pl)
	if NDB.EliminatedMaps and 0 < #NDB.EliminatedMaps then
		local str = Serialize(NDB.EliminatedMaps)
		if string.len(str) < 200 then
			umsg.Start("recelim", pl)
				umsg.String(str)
			umsg.End()
		else
			pl:SendLongString(2, str)
		end
	end
end)

NDB.VotedAlready = {}
NDB.VotedVotes = {}

NDB.VoteCallbacks = {}

NDB.VoteCallbacks["default"] = function(pl)
	local votes = math.max(1, pl:Frags())

	if pl.MemberLevel == MEMBER_DIAMOND then
		votes = votes * 1.75
	elseif pl.MemberLevel == MEMBER_GOLD then
		votes = votes * 1.5
	end

	return math.ceil(votes)
end

NDB.VoteCallbacks["darkrp"] = function(pl)
	if pl.MemberLevel == MEMBER_DIAMOND then
		return 3
	elseif pl.MemberLevel == MEMBER_GOLD then
		return 2
	end

	return 1
end

NDB.VoteCallbacks["zombiesurvival"] = function(pl)
	local votes = math.max(1, pl.ZombiesKilled + pl.BrainsEaten * 3 * 0.5)

	if pl.MemberLevel == MEMBER_DIAMOND then
		votes = votes * 1.75
	elseif pl.MemberLevel == MEMBER_GOLD then
		votes = votes * 1.5
	end

	return math.ceil(votes)
end

local TopVoted = 0
local VotedMaps = {}

local DisabledMaps = {}

concommand.Add("votemap", function(sender, command, arguments)
	if not sender:IsValid() or CurTime() < (sender.NextVoteMap or 0) then return end
	sender.NextVoteMap = CurTime() + 2.5

	if not NDB.MapList[GAMEMODE_NAME] then
		sender:PrintMessage(HUD_PRINTTALK, "This gamemode does not have voting enabled.")
		return
	end

	if VOTEMAPLOCKED or VOTEMAPSTART and CurTime() < VOTEMAPSTART then
		sender:PrintMessage(HUD_PRINTTALK, "Map voting has not started yet!")
		return
	end

	if VOTEMAPOVER and VOTEMAPOVER <= CurTime() then
		sender:PrintMessage(HUD_PRINTTALK, "Map voting time has ended!")
		return
	end

	local uid = sender:UniqueID()

	arguments = tonumber(arguments[1])
	if not arguments then return end

	local id = arguments
	local maptab = NDB.MapList[GAMEMODE_NAME][id]
	if not maptab then
		sender:PrintMessage(HUD_PRINTTALK, "Map doesn't exist.")
		return
	end

	local mapname = maptab[1]
	if not mapname then
		sender:PrintMessage(HUD_PRINTTALK, "Error, map not properly added to server. Tell an admin.")
		return
	end

	local lowermapname = string.lower(mapname)

	if string.lower(game.GetMap()) == lowermapname then
		sender:PrintMessage(HUD_PRINTTALK, "<red>You can't vote for the same map that's being played.</red>")
		return
	end

	if DisabledMaps[lowermapname] then
		sender:PrintMessage(HUD_PRINTTALK, "<red>That map has been marked for removal: "..tostring(DisabledMaps[lowermapname]).."</red>")
		return
	end

	if maptab[6] and #player.GetAll() < maptab[6] then
		sender:PrintMessage(HUD_PRINTTALK, "<red>That map requires at least "..maptab[6].." players in the game!</red>")
		return
	end

	local votes
	if NDB.VoteCallbacks[GAMEMODE_NAME] then
		votes = NDB.VoteCallbacks[GAMEMODE_NAME](sender)
	else
		votes = NDB.VoteCallbacks["default"](sender)
	end

	if NDB.EliminationIncrement[GAMEMODE_NAME] and NDB.EliminatedMaps and 0 < #NDB.EliminatedMaps then
		for i, mapid in ipairs(NDB.EliminatedMaps) do
			if mapid == id then
				local mul = i * NDB.EliminationIncrement[GAMEMODE_NAME]
				if 0.5 <= mul then
					votes = math.ceil(votes * mul)
				else
					sender:PrintMessage(HUD_PRINTTALK, "<red>That map has been played too recently to be played again.</red>")
					return
				end
				break
			end
		end
	end

	local votedalready = NDB.VotedAlready[uid]
	if votedalready == mapname then return end

	if votedalready then
		VotedMaps[votedalready] = VotedMaps[votedalready] - NDB.VotedVotes[uid]
		NDB.VotedAlready[uid] = nil
		NDB.VotedVotes[uid] = nil

		umsg.Start("recmapnumvotes")
			umsg.String(votedalready)
			umsg.Short(VotedMaps[votedalready])
		umsg.End()
	end

	NDB.VotedAlready[uid] = mapname
	NDB.VotedVotes[uid] = votes

	VotedMaps[mapname] = (VotedMaps[mapname] or 0) + votes

	local msg
	if votes == 1 then
		msg = sender:NoParseName().." placed <red>1</red> vote for <red>"..mapname.."</red>"
	else
		msg = sender:NoParseName().." placed <red>"..votes.."</red> votes for <red>"..mapname.."</red>"
		if sender.MemberLevel == MEMBER_DIAMOND then
			msg = msg.." (75% Diamond Member bonus)."
		elseif sender.MemberLevel == MEMBER_GOLD then
			msg = msg.." (50% Gold Member bonus)."
		else
			msg = msg.."."
		end
	end

	PrintMessage(HUD_PRINTTALK, msg)

	umsg.Start("recmapnumvotes")
		umsg.String(mapname)
		umsg.Short(VotedMaps[mapname])
	umsg.End()

	local most = 0
	for mapname, numvotes in pairs(VotedMaps) do
		if numvotes > most then
			most = numvotes
			NDB.NEXT_MAP = mapname
		end
	end

	if GAMEMODE.NDBMapVoted then
		GAMEMODE:NDBMapVoted(sender, maptab, mapname, id, votes, VotedMaps[mapname])
	end
end)

concommand.Add("requestmaptags", function(sender, command, arguments)
	if sender:IsPlayer() and not sender.SentRatings then
		sender.SentRatings = true
		sender:SendLongString(3, Serialize(NDB.MapTags))
	end
end)

hook.Add("InitPostEntity", "GetCurrentTags", function()
	hook.Remove("InitPostEntity", "GetCurrentTags")

	if file.Exists(GAMEMODE_NAME.."_maptags.txt") then
		NDB.MapTags = Deserialize(file.Read(GAMEMODE_NAME.."_maptags.txt"))
	else
		NDB.MapTags = {}
	end

	if NDB.GamemodeMapTags[GAMEMODE_NAME] then
		for i, tag in ipairs(NDB.GamemodeMapTags[GAMEMODE_NAME]) do
			NDB.GenericMapTags[#NDB.GenericMapTags + 1] = tag
		end
	end
end)

hook.Add("Initialize", "GameTypeVotingInitialize", function()
	hook.Remove("Initialize", "GameTypeVotingInitialize")

	if not GAMEMODE.GameTypes then return end

	GAMEMODE.GameTypeVoted = {}
	GAMEMODE.GameTypeVotedVotes = {}
	GAMEMODE.GameTypeVotes = {}
	for _, gt in pairs(GAMEMODE.GameTypes) do
		GAMEMODE.GameTypeVotes[gt] = 0
	end
	GAMEMODE.TopGameTypeVotes = 0
	concommand.Add("votegt", function(sender, command, arguments)
		if not sender:IsValid() or CurTime() < (sender.NextVoteGameType or 0) then return end
		sender.NextVoteGameType = CurTime() + 2.5

		if not ENDGAME then
			sender:PrintMessage(HUD_PRINTTALK, "Can only vote for a gametype after the current game has ended!")
			return
		end

		if not VOTEMAPOVER or CurTime() < VOTEMAPOVER then
			sender:PrintMessage(HUD_PRINTTALK, "Can only vote for a gametype after the map voting stage!")
			return
		end

		arguments = arguments[1]
		if not arguments then return end

		local gonethrough = false
		for _, gt in pairs(GAMEMODE.GameTypes) do
			if arguments == gt then
				gonethrough = true
				break
			end
		end

		if not gonethrough then
			sender:PrintMessage(HUD_PRINTTALK, "Error. Gametype doesn't exist?")
			return
		end

		if GAMEMODE.NoGameTypeTwiceInRow and 1 < #GAMEMODE.GameTypes and arguments == GAMEMODE.GameType then sender:PrintMessage(HUD_PRINTTALK, "The same game type can't be played twice in a row.") return end

		local votes
		if NDB.VoteCallbacks[GAMEMODE_NAME] then
			votes = NDB.VoteCallbacks[GAMEMODE_NAME](sender) or 1
		elseif sender.MemberLevel == MEMBER_DIAMOND then
			votes = 3
		elseif sender.MemberLevel == MEMBER_GOLD then
			votes = 2
		else
			votes = 1
		end

		local uid = sender:UniqueID()

		local votedalready = GAMEMODE.GameTypeVoted[uid]
		if votedalready == arguments then return end
		if votedalready then
			GAMEMODE.GameTypeVotes[votedalready] = GAMEMODE.GameTypeVotes[votedalready] - GAMEMODE.GameTypeVotedVotes[uid]
			GAMEMODE.GameTypeVotedVotes[uid] = nil
			GAMEMODE.GameTypeVoted[uid] = nil

			umsg.Start("recgtnumvotes")
				umsg.String(votedalready)
				umsg.Short(GAMEMODE.GameTypeVotes[votedalready])
			umsg.End()
		end

		GAMEMODE.GameTypeVoted[uid] = arguments
		GAMEMODE.GameTypeVotedVotes[uid] = votes
		GAMEMODE.GameTypeVotes[arguments] = GAMEMODE.GameTypeVotes[arguments] + votes

		local most = 0
		for _, gt in pairs(GAMEMODE.GameTypes) do
			if GAMEMODE.GameTypeVotes[gt] > most then
				most = GAMEMODE.GameTypeVotes[gt]
				file.Write(GAMEMODE_NAME.."_gametype.txt", gt)
			end
		end

		local msg = ""
		if votes == 1 then
			msg = sender:Name().." placed <red>1</red> vote for <red>"..arguments.."</red>"
		else
			msg = sender:Name().." placed <red>"..votes.."</red> votes for <red>"..arguments.."</red>"
			if sender.MemberLevel == MEMBER_DIAMOND then
				msg = msg.." (75% Diamond Member bonus)."
			elseif sender.MemberLevel == MEMBER_GOLD then
				msg = msg.." (50% Gold Member bonus)."
			else
				msg = msg.."."
			end
		end

		PrintMessage(HUD_PRINTTALK, msg)

		umsg.Start("recgtnumvotes")
			umsg.String(arguments)
			umsg.Short(GAMEMODE.GameTypeVotes[arguments])
		umsg.End()
	end)
end)

local AlreadyTagged = {}
concommand.Add("tagmap", function(sender, command, arguments)
	if not sender:IsValid() or not NDB.MapList[GAMEMODE_NAME] then return end
	if table.HasValue(AlreadyTagged, sender:SteamID()) then
		sender:PrintMessage(HUD_PRINTTALK, "<defc=255,0,0>You've already tagged this map. Please wait until the next time it is played.")
		return
	end
	local currentmap = string.lower(game.GetMap())

	local tagid = tonumber(arguments[1]) or 0
	if not NDB.GenericMapTags[tagid] then return end

	NDB.MapTags[currentmap] = NDB.MapTags[currentmap] or {}
	NDB.MapTags[currentmap][tagid] = (NDB.MapTags[currentmap][tagid] or 0) + 1

	umsg.Start("recmaptag")
		umsg.String(currentmap)
		umsg.Short(tagid)
		umsg.Long(NDB.MapTags[currentmap][tagid])
	umsg.End()

	AlreadyTagged[#AlreadyTagged + 1] = sender:SteamID()
	--sender:PrintMessage(HUD_PRINTTALK, "<defc=30,255,30>You have tagged this map \""..NDB.GenericMapTags[tagid].."\"!")
	PrintMessage(HUD_PRINTTALK, sender:Name().." <limegreen>has tagged this map \"</limegreen>"..NDB.GenericMapTags[tagid].."<limegreen>\"!</limegreen>")

	file.Write(GAMEMODE_NAME.."_maptags.txt", Serialize(NDB.MapTags))
end)
