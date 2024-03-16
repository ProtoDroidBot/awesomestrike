if CLIENT then return end

NDB.ChatCommandHelp = {}
NDB.ChatCommandPerfect = {}
NDB.ChatCommandHidden = {}

function NDB.AddPublicChatCommand(in_say, out_func, help, perfect, hidden)
	NDB.PublicChatCommands[in_say] = out_func
	if help then
		NDB.ChatCommandHelp[in_say] = help
	end
	if perfect then
		NDB.ChatCommandPerfect[in_say] = true
	end
	if hidden then
		NDB.ChatCommandHidden[in_say] = true
	end
end

function NDB.AddPrivateChatCommand(in_say, out_func, help, perfect, hidden)
	NDB.PrivateChatCommands[in_say] = out_func
	if help then
		NDB.ChatCommandHelp[in_say] = help
	end
	if perfect then
		NDB.ChatCommandPerfect[in_say] = true
	end
	if hidden then
		NDB.ChatCommandHidden[in_say] = true
	end
end

NDB.AddPrivateChatCommand("/awards", function(sender)
	sender:SendLua("NDB.ViewAllAwards()")
end, "- Lists all awards.")

NDB.AddPrivateChatCommand("/claim", function(sender, text)
	local place = string.find(text, " ", 1, true)
	if not place then return end
	text = string.lower(string.sub(text, place+1))

	if text == "tribes" or text == "tribesrpg" then
		if not rawio then
			sender:PrintMessage(HUD_PRINTTALK, "This promotion has expired.")
		elseif sender:HasFlag("promo_tribesrpg") then
			sender:PrintMessage(HUD_PRINTTALK, "You've already claimed your prize for this promotion. \"Caster Hands\" should be available in the shop menu.")
		elseif util.tobool(rawio.readfile("C:/dynamix/tribes/temp/trash "..string.Explode(":", string.gsub(sender:IPAddress(), "%.", "_"))[1]..".txt")) then
			sender:AddFlag("promo_tribesrpg")
			sender:PrintMessage(HUD_PRINTTALK, "You have claimed your prize. The /buy menu item \"Caster Hands\" is now available, thanks for participating in the Tribes RPG promotion!")
		else
			sender:PrintMessage(HUD_PRINTTALK, "^900You don't qualify for this promotion. You must use the #claim command in the NoXiousNet Tribes RPG server while having 300 or more global skills. See forum thread at noxiousnet.com for details.")
		end
	elseif text == "dunmir" then
		if not rawio then
			sender:PrintMessage(HUD_PRINTTALK, "This promotion has expired.")
		elseif sender:HasFlag("promo_tribeswar") then
			sender:PrintMessage(HUD_PRINTTALK, "You've already claimed your prize for this promotion. You will be able to use \"Static Aura\" WHEN IT BECOMES AVAILABLE.")
		elseif util.tobool(rawio.readfile("C:/dynamix/tribes/temp/trash2 "..string.Explode(":", string.gsub(sender:IPAddress(), "%.", "_"))[1]..".txt")) then
			sender:AddFlag("promo_tribeswar")
			sender:PrintMessage(HUD_PRINTTALK, "You have claimed your prize. The /buy menu item \"Static Aura\" will be AVAILABLE SHORTLY!")
		else
			sender:PrintMessage(HUD_PRINTTALK, "^900You don't qualify for this promotion.")
		end
	else
		sender:PrintMessage(HUD_PRINTTALK, "^900Couldn't find that promo-code.")
	end
end, "- Claims promotional prizes. Use: /claim promocode")

NDB.AddPrivateChatCommand("nextmap", function(sender, text)
	if CurTime() < (sender.NextRequestNextMap or 0) then return end
	sender.NextRequestNextMap = CurTime() + 5

	if sender.Muted and string.lower(sender.Muted) ~= "none" then
		sender:PrintMessage(HUD_PRINTTALK, sender:NoParseName()..", the next map is "..tostring(NDB.NEXT_MAP))
	else
		PrintMessage(HUD_PRINTTALK, sender:NoParseName()..", the next map is "..tostring(NDB.NEXT_MAP))
	end
end, "- Displays the next map according to wich map has the most votes.")

NDB.AddPrivateChatCommand("/news", function(sender)
	sender:SendLua("MakepNews()")
end, "- Displays announcements box.")

NDB.AddPrivateChatCommand("thetime", function(sender, text)
	if CurTime() < (sender.NextRequestTime or 0) then return end
	sender.NextRequestTime = CurTime() + 5

	local thetime = os.date()
	if sender.Muted and string.lower(sender.Muted) ~= "none" then
		sender:PrintMessage(HUD_PRINTTALK, sender:NoParseName()..", the server's local time is now "..thetime.." GMT-5   (Log #"..tostring(LOGNUMBER)..")")
	else
		PrintMessage(HUD_PRINTTALK, sender:NoParseName()..", the server's local time is now "..thetime.." GMT-5   (Log #"..tostring(LOGNUMBER)..")")
	end
end, "- Displays the server's local time in 24 hour format.")

local function CC_Blah(sender, text)
	if sender:Alive() and gamemode.Call("CanPlayerSuicide", sender) then
		local effectdata = EffectData()
			effectdata:SetOrigin(sender:GetPos())
		util.Effect("Explosion", effectdata)

		local novel
		for _, ent in pairs(player.GetAll()) do
			if ent:GetGroundEntity() == sender then
				novel = true
				break
			end
		end

		if not novel then
			sender:SetGroundEntity(NULL)
			sender:SetLocalVelocity(Vector(0, 0, 2000))
		end

		sender:Kill()
	end
end
NDB.AddPublicChatCommand("blah", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("failcade", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("fail cade", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("wincade", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("win cade", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("lulz", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("xd", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("force of win", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("headcrab survival", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("you just lost the game", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("peashitter", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("battlefail", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("fagsassin", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("fagassin", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("!kill", CC_Blah, nil, nil, true)
NDB.AddPublicChatCommand("!zspawn", CC_Blah, nil, nil, true)

local function CC_GiveMoney(sender, text)
	if not sender.Money then return end
	if not sender:Alive() then return end
	if sender.DiamondMember then sender:PrintMessage(HUD_PRINTTALK, "You can't transfer Silver if you have an infinite amount of it.") return end
	local place = string.find(text, " ", 1, true)
	if not place then return end
	text = string.sub(text, place+1)
	text = tonumber(text)
	if not text then sender:PrintMessage(HUD_PRINTTALK, "Must be a number.") return end
	text = math.ceil(math.abs(text))

	if text < 25 then
		sender:PrintMessage(HUD_PRINTTALK, "You can't transfer such low amounts of money.")
		return
	end

	if 50000 < text then
		sender:PrintMessage(HUD_PRINTTALK, "For your security, only transfer 50,000 Silver at one time.")
		return
	end

	if sender.Money < text then
		sender:PrintMessage(HUD_PRINTTALK, "You don't even have that much money!")
		return
	end

	local vStart = sender:GetShootPos()
	local hit = util.TraceLine({start = vStart, endpos = vStart + sender:GetAimVector() * 48, filter = sender}).Entity
	if hit and hit:IsValid() and hit:IsPlayer() then
		if hit == sender then return end

		if hit.DiamondMember then sender:PrintMessage(HUD_PRINTTALK, "They have infinite Silver already.") return end

		local r,g,b,a = hit:GetColor()
		if a < 100 then sender:PrintMessage(HUD_PRINTTALK, "You must be pointing at a player in front of you.") return end
		hit:AddMoney(text)
		sender:AddMoney(-text)
		hit:EmitSound(Sound("ambient/levels/labs/coinslot1.wav"))
		sender:PrintMessage(HUD_PRINTTALK, "You gave them "..text.." Silver.")
		hit:PrintMessage(HUD_PRINTTALK, sender:NoParseName().." hands you "..text.." Silver.")
		sender:RestartGesture(ACT_ITEM_GIVE)
		NDB.SaveInfo(hit)
		NDB.SaveInfo(sender)

		LOGCONTENTS = LOGCONTENTS.."<"..sender:SteamID().."> "..sender:Name().." gave "..text.." Silver to <"..hit:SteamID().."> "..hit:Name()..".\n"
	else
		sender:PrintMessage(HUD_PRINTTALK, "You must be pointing at a player in front of you.")
	end
end
NDB.AddPrivateChatCommand("givemoney", CC_GiveMoney, "<amount> - Gives <amount> of your silver to whoever you are pointing at.")
NDB.AddPrivateChatCommand("/givemoney", CC_GiveMoney, "<amount> - Gives <amount> of your silver to whoever you are pointing at.")

NDB.AddPrivateChatCommand("/emotes", function(sender, text)
	sender:ConCommand("noxlistemotes")
end, "- List all emotes.")

NDB.AddPrivateChatCommand("/portal", function(sender, text)
	sender:PrintMessage(HUD_PRINTTALK, "Pick your destination...")
	sender:ConCommand("serverportal")
end, "- Travel to other NoXiousNet sanctioned servers.")

local function CC_Commands(sender, text)
	sender:PrintMessage(HUD_PRINTTALK, "A list of NoXiousNet's chat commands have been printed to your console.")

	for i in pairs(NDB.PrivateChatCommands) do
		if not NDB.ChatCommandHidden[i] then
			if NDB.ChatCommandHelp[i] then
				sender:PrintMessage(HUD_PRINTCONSOLE, i.." "..NDB.ChatCommandHelp[i].."\n")
			else
				sender:PrintMessage(HUD_PRINTCONSOLE, i.."\n")
			end
		end
	end

	for i in pairs(NDB.PublicChatCommands) do
		if not NDB.ChatCommandHidden[i] then
			if NDB.ChatCommandHelp[i] then
				sender:PrintMessage(HUD_PRINTCONSOLE, i.." "..NDB.ChatCommandHelp[i].."\n")
			else
				sender:PrintMessage(HUD_PRINTCONSOLE, i.."\n")
			end
		end
	end
end
NDB.AddPrivateChatCommand("/chatcommands", CC_Commands)
NDB.AddPrivateChatCommand("/commands", CC_Commands)
NDB.AddPrivateChatCommand("/help", CC_Commands)

NDB.AddPrivateChatCommand("/forceurl", function(sender, text)
	if not (sender:IsValid() and sender:IsConnected()) then return end
	if not sender:IsAdmin() then
		sender:PrintMessage(HUD_PRINTTALK, "This command is for admins.")
		return
	end

	local place = string.find(text, " ", 1, true)
	if not place then return end
	text = string.sub(text, place+1)
	local lowertext = string.lower(text)

	local expl = string.Explode(" ", text)
	local url = expl[#expl]

	local pl = NDB.FindPlayerByName(table.concat(text, " ", 1, #expl - 1))

	if pl then
		pl:SendLua("ForceURL('"..url.."')")
		sender:PrintMessage(HUD_PRINTTALK, "You have forced "..pl:NoParseName().." to go to "..url..".")
	else
		sender:PrintMessage(HUD_PRINTTALK, "No one with that name found.")
	end
end, "<playername> <url> - Force a player to open said website.")

NDB.AddPrivateChatCommand("/ignore", function (sender, text)
	sender:SendLua("IgnoreListAdd('"..text.."')")
end, "<playername> - Add <playername> to your ignore list.")

NDB.AddPrivateChatCommand("/unignore", function(sender, text)
	sender:SendLua("IgnoreListRemove('"..text.."')")
end, "<playername> - Remove <playername> from your ignore list.")

NDB.AddPrivateChatCommand("/votemap", function(sender, text)
	sender:SendLua("OpenVoteMenu()")
end, "- Open menu to vote for maps.")

NDB.AddPrivateChatCommand("/settitle", function (pl, text)
	if not (pl:IsPlayer() and pl:IsConnected()) then return end

	if pl:IsSuperAdmin() then
		local place = string.find(text, " ", 1, true)
		if not place then return end
		text = string.sub(text, place+1)

		local expl = string.Explode(" ", text)
		local id = tonumber(expl[1])
		if not id then return end

		local title = table.concat(expl, " ", 2) or ""

		local targ
		for _, ent in pairs(player.GetAll()) do
			if ent:UserID() == id then targ = ent break end
		end

		if not targ then return end

		targ.NewTitle = title

		if string.lower(title) == "none" then
			targ.NewTitle = targ:GetDefaultTitle()
			targ:PrintMessage(HUD_PRINTTALK, "<red>The admin has reset your player title.</red>")
			pl:PrintMessage(HUD_PRINTTALK, "<limegreen>You reset "..targ:NoParseName().."'s player title.</limegreen>")
			targ.TitleLock = nil
		elseif title == "" then
			targ.NewTitle = ""
			targ:PrintMessage(HUD_PRINTTALK, "<red>The admin has cleared your player title.</red>")
			pl:PrintMessage(HUD_PRINTTALK, "<limegreen>You clear "..targ:NoParseName().."'s player title.</limegreen>")
			targ.TitleLock = nil
		else
			targ:PrintMessage(HUD_PRINTTALK, "<red>The admin has set your player title to:</red> "..title)
			pl:PrintMessage(HUD_PRINTTALK, "<limegreen>"..targ:NoParseName().."'s player title has been set to:</limegreen> "..title)
			targ.TitleLock = true
		end

		umsg.Start("RecTitle")
			umsg.Entity(targ)
			umsg.String(targ.NewTitle)
		umsg.End()

		NDB.SaveInfo(targ)
	else
		pl:PrintMessage(HUD_PRINTTALK, "<red>Only super admins can use /settitle.</red>")
	end
end, "- Set a player's title. SuperAdmin only.")
