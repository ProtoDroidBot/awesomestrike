if SERVER then
	AddCSLuaFile(NDB_ADDON_NAME)
	return
end

AWARDS_CAT_SPECIAL = 1
AWARDS_CAT_ZS = 2
AWARDS_CAT_OLDTP = 4
AWARDS_CAT_TP = 8
AWARDS_CAT_MARIO = 16
AWARDS_CAT_ARENA = 32
AWARDS_CAT_BR = 64

local AwardCategories = {
[AWARDS_CAT_SPECIAL] = "Special",
[AWARDS_CAT_ZS] = "Zombie Survival",
[AWARDS_CAT_OLDTP] = "NoX Retro TeamPlay",
[AWARDS_CAT_TP] = "NoXious - Team Play",
[AWARDS_CAT_MARIO] = "Mario Boxes 2D",
[AWARDS_CAT_ARENA] = "NoXious Arena",
[AWARDS_CAT_BR] = "Buggy Racer"
}

local Awards = {
["100_ctf_kills"] = {"Kill 100 people in TeamPlay.", AWARDS_CAT_OLDTP},
["250_ctf_kills"] = {"Kill 250 people in TeamPlay.", AWARDS_CAT_OLDTP},
["500_ctf_kills"] = {"Kill 500 people in TeamPlay.", AWARDS_CAT_OLDTP},
["1000_ctf_kills"] = {"Kill 1,000 people in TeamPlay.", AWARDS_CAT_OLDTP},
["2500_ctf_kills"] = {"Kill 2,500 people in TeamPlay.", AWARDS_CAT_OLDTP},
["5000_ctf_kills"] = {"Kill 5,000 people in TeamPlay.", AWARDS_CAT_OLDTP},
["7500_ctf_kills"] = {"Kill 7,500 people in TeamPlay.", AWARDS_CAT_OLDTP},
["10000_ctf_kills"] = {"Kill 10,000 people in TeamPlay.", AWARDS_CAT_OLDTP},
["12500_ctf_kills"] = {"Kill 12,500 people in TeamPlay.", AWARDS_CAT_OLDTP},
["15000_ctf_kills"] = {"Kill 15,000 people in TeamPlay.", AWARDS_CAT_OLDTP},
["17500_ctf_kills"] = {"Kill 17,500 people in TeamPlay.", AWARDS_CAT_OLDTP},
["20000_ctf_kills"] = {"Kill 20,000 people in TeamPlay.", AWARDS_CAT_OLDTP},
["10_core_final_blows"] = {"Score the last hit on an Assault core a total of 10 times.", AWARDS_CAT_OLDTP},
["25_core_final_blows"] = {"Score the last hit on an Assault core a total of 25 times.", AWARDS_CAT_OLDTP},
["50_core_final_blows"] = {"Score the last hit on an Assault core a total of 50 times.", AWARDS_CAT_OLDTP},
["50_caps"] = {"Capture the flag a total of 50 times.", AWARDS_CAT_OLDTP},
["250_caps"] = {"Capture the flag a total of 250 times.", AWARDS_CAT_OLDTP},
["125_caps"] = {"Capture the flag a total of 125 times.", AWARDS_CAT_OLDTP},
["500_ctf_captures"] = {"Capture the flag a total of 500 times.", AWARDS_CAT_OLDTP},
["750_ctf_captures"] = {"Capture the flag a total of 750 times.", AWARDS_CAT_OLDTP},
["1000_ctf_captures"] = {"Capture the flag a total of 1000 times.", AWARDS_CAT_OLDTP},
["250hp_cleric"] = {"Heal 250 HP for your teamates in one game.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["500hp_cleric"] = {"Heal 500 HP for your teamates in one game.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["750hp_cleric"] = {"Heal 750 HP for your teamates in one game.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["1000hp_cleric"] = {"Heal 1,000 HP for your teamates in one game.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["1500hp_cleric"] = {"Heal 1,500 HP for your teamates in one game.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["2500hp_cleric"] = {"Heal 2,500 HP for your teamates in one game.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["5000hp_cleric"] = {"Heal 5,000 HP for your teamates in one game.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["novice_miner"] = {"Blow up 2 people with Fire Mines in one game.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["adept_miner"] = {"Blow up 4 people with Fire Mines in one game.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["master_miner"] = {"Blow up 8 people with Fire Mines in one game.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["awesome_miner"] = {"Blow up 16 people with Fire Mines in one game.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["crazy_miner"] = {"Blow up 24 people with Fire Mines in one game.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["lunatic_miner"] = {"Blow up 32 people with Fire Mines in one game.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["miner_fourty-niner"] = {"Blow up 49 people with Fire Mines in one game.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["warrior_award"] = {"Kill 7 people in one life while a Warrior. They must all be alive for more than 10 seconds.", AWARDS_CAT_OLDTP},
["no_flying_zone"] = {"Run over a person with the Raven when they are in the air.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["multi-skewer"] = {"Kill 2 people with the same crossbow bolt.", AWARDS_CAT_OLDTP},
["shish_kabob"] = {"Kill 3 people with the same crossbow bolt.", AWARDS_CAT_OLDTP},
["harpwned"] = {"Kill a person with Harpoon.", AWARDS_CAT_OLDTP},
["whaling_man"] = {"Kill 2 people with Harpoon in one life.", AWARDS_CAT_OLDTP},
["ar_she_blows"] = {"Kill 4 people with Harpoon in one life.", AWARDS_CAT_OLDTP},
["bomberman"] = {"Kill 5 people with the Vulture Heavy Bomber in one life.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["fatboy"] = {"Kill 20 people with the Vulture Heavy Bomber in one life.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["beeee_17_boamber"] = {"Kill 50 people with the Vulture Heavy Bomber in one life.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["hot_foot"] = {"Kill 3 people with the Burn spell in one life.", AWARDS_CAT_OLDTP},
["my_hair_is_on_fire"] = {"Kill 10 people with the Burn spell in one life.", AWARDS_CAT_OLDTP},
["anti_semetic"] = {"Kill 15 people with the Burn spell in one life.", AWARDS_CAT_OLDTP},
["you_cant_pull_me_over"] = {"Kill 3 people by running them over with the Assault Rover in one life.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["vroom_im_a_car"] = {"Kill 8 people by running them over with the Assault Rover in one life.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["get_out_of_the_way"] = {"Kill 15 people by running them over with the Assault Rover in one life.", AWARDS_CAT_OLDTP | AWARDS_CAT_TP},
["copper_defense"] = {"Acquire 10 defense points in one game.", AWARDS_CAT_OLDTP},
["iron_defense"] = {"Acquire 20 defense points in one game.", AWARDS_CAT_OLDTP},
["steel_defense"] = {"Acquire 35 defense points in one game.", AWARDS_CAT_OLDTP},
["titanium_defense"] = {"Acquire 50 defense points in one game.", AWARDS_CAT_OLDTP},
["diamond_defense"] = {"Acquire 75 defense points in one game.", AWARDS_CAT_OLDTP},
["ultimate_defense"] = {"Acquire 100 defense points in one game.", AWARDS_CAT_OLDTP},
["copper_offense"] = {"Acquire 30 offense points in one game.", AWARDS_CAT_OLDTP},
["iron_offense"] = {"Acquire 60 offense points in one game.", AWARDS_CAT_OLDTP},
["steel_offense"] = {"Acquire 100 offense points in one game.", AWARDS_CAT_OLDTP},
["titanium_offense"] = {"Acquire 150 offense points in one game.", AWARDS_CAT_OLDTP},
["diamond_offense"] = {"Acquire 175 offense points in one game.", AWARDS_CAT_OLDTP},
["ultimate_offense"] = {"Acquire 250 offense points in one game.", AWARDS_CAT_OLDTP},
["zs_human_bronze"] = {"Kill 30 zombies in one game or win a game while being the Last Human.", AWARDS_CAT_ZS},
["zs_human_silver"] = {"Kill 50 zombies in one game.", AWARDS_CAT_ZS},
["zs_human_3rd"] = {"Kill 75 zombies in one game.", AWARDS_CAT_ZS},
["zs_human_2nd"] = {"Kill 90 zombies in one game.", AWARDS_CAT_ZS},
["zs_human_1st"] = {"Kill 100 zombies in one game.", AWARDS_CAT_ZS},
["zs_zombie_bronze"] = {"Kill 5 humans in one game.", AWARDS_CAT_ZS},
["zs_zombie_silver"] = {"Kill 7 humans in one game.", AWARDS_CAT_ZS},
["zs_zombie_3rd"] = {"Kill 9 humans in one game.", AWARDS_CAT_ZS},
["zs_zombie_2nd"] = {"Kill 11 humans in one game.", AWARDS_CAT_ZS},
["zs_zombie_1st"] = {"Kill 13 humans in one game.", AWARDS_CAT_ZS},
["pest_of_humans"] = {"Eat a total of 25 human brains.", AWARDS_CAT_ZS},
["killer_of_humans"] = {"Eat a total of 50 human brains.", AWARDS_CAT_ZS},
["marauder_of_humans"] = {"Eat a total of 100 human brains.", AWARDS_CAT_ZS},
["butcher_of_humans"] = {"Eat a total of 250 human brains.", AWARDS_CAT_ZS},
["exterminator_of_humans"] = {"Eat a total of 500 human brains.", AWARDS_CAT_ZS},
["destroyer_of_humans"] = {"Eat a total of 1,000 human brains.", AWARDS_CAT_ZS},
["annihilator_of_humans"] = {"Eat a total of 2,500 human brains.", AWARDS_CAT_ZS},
["eradicator_of_humans"] = {"Eat a total of 5,000 human brains.", AWARDS_CAT_ZS},
["bane_of_humanity"] = {"Eat a total of 10,000 human brains.", AWARDS_CAT_ZS},
["zombie_assassin_-_novice"] = {"Kill 2 zombies with a knife in one game.", AWARDS_CAT_ZS},
["zombie_assassin_-_adept"] = {"Kill 4 zombies with a knife in one game.", AWARDS_CAT_ZS},
["zombie_assassin_-_master"] = {"Kill 6 zombies with a knife in one game.", AWARDS_CAT_ZS},
["survivalist"] = {"Survive for 5 minutes straight while being the Last Human.", AWARDS_CAT_ZS},
["official_zs_king"] = {"Be the king of Zombie Survival.", AWARDS_CAT_SPECIAL},
["verified_girl"] = {"Prove that you're a girl.", AWARDS_CAT_SPECIAL},
["won_contest"] = {"Win a minor event or contest.", AWARDS_CAT_SPECIAL},
["gold_star"] = {"Do something worth mentioning.", AWARDS_CAT_SPECIAL},
["robot_war_champion"] = {"Win a Robot Wars tournament.", AWARDS_CAT_SPECIAL},
["worms_winner"] = {"Win the Worms event.", AWARDS_CAT_SPECIAL},
["trap_runner"] = {"Win a Trap Runner event.", AWARDS_CAT_SPECIAL},
["airship_captain"] = {"Win an Airship Captain event.", AWARDS_CAT_SPECIAL},
["baseball_winner"] = {"Win a baseball event.", AWARDS_CAT_SPECIAL},
["antguard_soccer_winner"] = {"Win an Antlion Guard Soccer event.", AWARDS_CAT_SPECIAL},
["zombie_herder_2007"] = {"Be on the winning team of the 2007 Zombie Herder event.", AWARDS_CAT_SPECIAL},
["nsl_champions"] = {"Win a NoX Soccer League tournament.", AWARDS_CAT_SPECIAL},
["old_player"] = {"Be here for Advanced Fortwars on gmod9.", AWARDS_CAT_SPECIAL},
["atomic"] = {"Be radioactive.", AWARDS_CAT_SPECIAL},
["ban_bait"] = {"Get banned a lot.", AWARDS_CAT_SPECIAL},
["complete_failure"] = {"Fail at everything.", AWARDS_CAT_SPECIAL},
["gigantic_faggot"] = {"Be a gigantic faggot.", AWARDS_CAT_SPECIAL},
["mingebag"] = {"Be a MingeBag.", AWARDS_CAT_SPECIAL},
["ugly_girl_friend"] = {"Have an ugly girlfriend.", AWARDS_CAT_SPECIAL},
["stealing_first"] = {"Score a goal in Blitz or Capture the Flag within 30 seconds of the game starting.", AWARDS_CAT_TP},
["greedy"] = {"Be the one to score every goal in a game of Blitz or Capture the Flag.", AWARDS_CAT_TP},
["sharpshooter"] = {"Get 6 consecutive head shots with the Slug Rifle.", AWARDS_CAT_ZS},
["hellsing"] = {"Kill 6 different zombies with one crossbow bolt.", AWARDS_CAT_ZS},
["volley_bomb_winner"] = {"Win a Volley Bomb event.", AWARDS_CAT_SPECIAL}
}

local colbox = Color(40, 40, 40, 255)
local function emptypaint(self)
	draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), colbox)
	return true
end

function NDB.CreateAwardsPanel(category, wid, hei, parent, awards)
	category = category or "All"

	wid = wid or 540
	hei = hei or 470

	local panel = vgui.Create("DPanel", parent)
	panel:SetSize(wid, hei)
	panel:SetVisible(true)
	panel.Category = category
	panel.Children = {}
	panel.Awards = awards

	local dropdown = vgui.Create("DMultiChoice", panel)
	dropdown:SetWide(120)
	dropdown:SetPos(8, 8)
	dropdown:SetEditable(false)
	dropdown:SetText(category)
	function dropdown:OnSelect(index, value, data)
		if value == "All" or table.HasValue(AwardCategories, value) then
			local parent = self:GetParent()
			parent.Category = value
			parent:RefreshList()
			if parent.PList.VBar and parent.PList.VBar:Valid() then
				parent.PList.VBar:SetScroll(0)
			end

			surface.PlaySound("buttons/button15.wav")
		end
	end
	dropdown:AddChoice("All")
	for id, category in pairs(AwardCategories) do
		dropdown:AddChoice(category)
	end
	panel.DropDown = dropdown

	function panel:RefreshList()
		for _, child in pairs(self.Children) do
			child:Remove()
		end
		self.Children = {}

		local plist
		local panw
		if self.PList then
			for _, item in pairs(self.PList:GetItems()) do
				self.PList:RemoveItem(item)
			end
			plist = self.PList
			panw = plist:GetWide() - 16
		else
			plist = vgui.Create("DPanelList", self)
			panw = wid - 16
			plist:SetSize(panw, hei - 40)
			plist:SetPos(8, 32)
			plist:EnableVerticalScrollbar()
			plist:EnableHorizontal(false)
			plist:SetSpacing(2)
			self.PList = plist
		end

		local catid
		local using = {}
		local mycategory = self.Category or "All"
		if mycategory == "All" then
			catid = -1

			for awardname, awardtab in pairs(Awards) do
				if awardtab[2] ~= AWARDS_CAT_SPECIAL then
					using[#using + 1] = awardname
				end
			end
		else
			for id, catname in pairs(AwardCategories) do
				if catname == mycategory then
					catid = id
					break
				end
			end

			catid = catid or -1

			for awardname, awardtab in pairs(Awards) do
				if awardtab[2] & catid == catid then
					using[#using + 1] = awardname
				end
			end
		end

		table.sort(using)

		local totalawards = #using
		local achieved = 0

		for _, awardname in ipairs(using) do
			local ourcount = 0
			if self.Awards then
				for _, awd in pairs(self.Awards) do
					if string.lower(awd) == awardname then
						ourcount = ourcount + 1
					end
				end
			else
				ourcount = ourcount + 1
			end

			local cleanname = string.Replace(string.upper(awardname), "_", " ")
			local awardtab = Awards[awardname]
			local awarddesc = awardtab[1]

			local Panel = vgui.Create("Panel", plist)
			Panel:SetSize(panw, 72)
			Panel.Paint = emptypaint

			local img = vgui.Create("DImage", Panel)
			img:SetPos(4, 4)
			img:SetSize(64, 64)
			img:SetImage("noxawards/"..awardname)
			img:SetMouseInputEnabled(false)
			img:SetKeyboardInputEnabled(false)

			local lab
			local clab
			if ourcount == 0 then
				lab = EasyLabel(Panel, cleanname, "awardsname")
			else
				achieved = achieved + 1

				lab = EasyLabel(Panel, cleanname, "awardsname", COLOR_LIMEGREEN)
				if 1 < ourcount then
					clab = EasyLabel(Panel, " (x"..ourcount..")", "awardsname", COLOR_YELLOW)
				end
			end
			local y = Panel:GetTall() * 0.5 - lab:GetTall() - 2
			lab:SetPos(72, y)
			if clab then
				clab:SetPos(72 + lab:GetWide(), y)
			end
			y = y + lab:GetTall() + 2

			if awarddesc then
				local lab2 = EasyLabel(Panel, awarddesc)
				lab2:SetPos(72, y)
			end

			if self.Awards and 0 < ourcount then
				local wb = WordBox(Panel, "Achieved!", "DefaultBold", COLOR_YELLOW)
				wb:SetPos(panw - 24 - wb:GetWide(), 8)
			end

			plist:AddItem(Panel)
		end

		local wb
		if self.Awards and 0 < totalawards then
			wb = WordBox(self, achieved.." of "..totalawards.." awards achieved. (".. math.floor((achieved / totalawards) * 100) .."%)", nil, COLOR_YELLOW)
		else
			wb = WordBox(self, totalawards.." total awards.", nil, COLOR_YELLOW)
		end
		wb:SetPos(self:GetWide() - 8 - wb:GetWide(), 8)
		table.insert(self.Children, wb)
	end
	panel:RefreshList()

	return panel
end

function NDB.ViewAllAwards()
	local wid, hei = 540, 470

	local frmAll = vgui.Create("DFrame")
	frmAll:SetSize(wid, hei)
	frmAll:Center()
	frmAll:SetTitle("Complete awards listing")
	frmAll:SetDeleteOnClose(true)
	frmAll:SetVisible(true)
	frmAll:SetKeyboardInputEnabled(false)
	frmAll:MakePopup()

	NDB.CreateAwardsPanel(nil, wid - 8, hei - 28, frmAll):SetPos(4, 24)
end

local function CreateRealProfile(player, contents)
	local frame = vgui.Create("DFrame")
	local wid, hei = 540, 600
	frame:SetSize(wid, hei)
	frame:Center()
	frame:SetTitle("Account - "..player.RealSteamID)
	frame:SetDeleteOnClose(true)
	frame:SetVisible(true)
	frame:MakePopup()

	local playername = player:Name()

	local label = vgui.Create("DLabel", frame)
	label:SetFont("awardsname")
	label:SetText(playername)
	label:SetTextColor(COLOR_LIMEGREEN)
	surface.SetFont("awardsname")
	local txw, txh = surface.GetTextSize(playername)
	label:SetPos(54, 32)
	label:SetSize(txw, txh)
	label:SetMouseInputEnabled(false)
	label:SetKeyboardInputEnabled(false)

	local avatar = vgui.Create("AvatarImage", frame)
	avatar:SetPos(8, 32)
	avatar:SetSize(32, 32)
	avatar:SetPlayer(player)
	avatar:SetMouseInputEnabled(false)
	avatar:SetKeyboardInputEnabled(false)

	surface.SetFont("DefaultBold")
	local txw2, txh2 = surface.GetTextSize(playername)

	if contents.MemberLevel == MEMBER_DIAMOND then
		local label = vgui.Create("DLabel", frame)
		label:SetFont("DefaultBold")
		label:SetText("Diamond Member")
		label:SetTextColor(color_white)
		txw2, txh2 = surface.GetTextSize("Diamond Member")
		label:SetPos(54, 32 + txh)
		label:SetSize(txw2, txh2)
		label:SetMouseInputEnabled(false)
		label:SetKeyboardInputEnabled(false)
	elseif contents.MemberLevel == MEMBER_GOLD then
		local label = vgui.Create("DLabel", frame)
		label:SetFont("DefaultBold")
		label:SetText("Gold Member")
		label:SetTextColor(COLOR_YELLOW)
		txw2, txh2 = surface.GetTextSize("Gold Member")
		label:SetPos(54, 32 + txh)
		label:SetSize(txw, txh)
		label:SetMouseInputEnabled(false)
		label:SetKeyboardInputEnabled(false)
	end

	local label = EasyLabel(frame, string.CommaSeparate(contents.Money).." Silver", nil, color_white)
	label:SetPos(54, 32 + txh + txh2)

	local list = vgui.Create("DListView", frame)
	list:SetSize(wid - 8, hei - 392)
	list:SetPos(4, 88)
	list:AddColumn(""):SetMinWidth(list:GetWide() * 0.5)
	list:AddColumn(""):SetMinWidth(list:GetWide() * 0.25)
	list:AddLine("NoX TeamPlay - Wins", contents.AssaultWins)
	list:AddLine("NoX TeamPlay - Losses", contents.AssaultLosses)
	list:AddLine("NoX TeamPlay - W/L Ratio", string.format("%.4f", contents.AssaultWins / math.max(1, contents.AssaultLosses)))
	list:AddLine("NoX TeamPlay - Kills", contents.CTFKills)
	list:AddLine("NoX TeamPlay - Deaths", contents.CTFDeaths)
	list:AddLine("NoX TeamPlay - K/D Ratio", string.format("%.4f", contents.CTFKills / math.max(1, contents.CTFDeaths)))
	list:AddLine("NoX TeamPlay - Assists", contents.TeamPlayAssists)
	list:AddLine("NoX TeamPlay - Flag Captures", contents.CTFCaptures)
	list:AddLine("NoX TeamPlay - Offense", contents.AssaultOffense)
	list:AddLine("NoX TeamPlay - Defense", contents.AssaultDefense)
	list:AddLine("NoX TeamPlay - D/O Ratio", string.format("%.4f", contents.AssaultOffense / math.max(1, contents.AssaultDefense)))
	list:AddLine("NoX TeamPlay - O/D Ratio", string.format("%.4f", contents.AssaultDefense / math.max(1, contents.AssaultOffense)))
	list:AddLine("NoX TeamPlay - Cores Destroyed", contents.AssaultCoresDestroyed)
	list:AddLine("NoX Arena - Wins", contents.ArenaWins)
	list:AddLine("NoX Arena - Losses", contents.ArenaLosses)
	list:AddLine("NoX Arena - W/L Ratio", string.format("%.4f", contents.ArenaWins / math.max(1, contents.ArenaLosses)))
	list:AddLine("Zombie Survival - Games Survived", contents.ZSGamesSurvived)
	list:AddLine("Zombie Survival - Games Lost", contents.ZSGamesLost)
	list:AddLine("Zombie Survival - S/L Ratio", string.format("%.4f", contents.ZSGamesSurvived / math.max(1, contents.ZSGamesLost)))
	list:AddLine("Zombie Survival - Zombies Killed", contents.ZSZombiesKilled)
	list:AddLine("Zombie Survival - Brains Eaten", contents.ZSBrainsEaten)
	list:AddLine("Mario Boxes 2D - Wins", contents.MarioBoxesWins)
	list:AddLine("Mario Boxes 2D - Losses", contents.MarioBoxesLosses)
	list:AddLine("Mario Boxes 2D - W/L Ratio", string.format("%.4f", contents.MarioBoxesWins / math.max(1, contents.MarioBoxesLosses)))
	list:AddLine("Mario Boxes 2D - Kills", contents.MarioBoxesKills)
	list:AddLine("Mario Boxes 2D - Deaths", contents.MarioBoxesDeaths)
	list:AddLine("Mario Boxes 2D - K/D Ratio", string.format("%.4f", contents.MarioBoxesKills / math.max(1, contents.MarioBoxesDeaths)))

	NDB.CreateAwardsPanel(nil, wid - 8, 296, frame, contents.Awards or {}):SetPos(4, hei - 300)
end

function NDB.CreateProfile(player)
	if player:IsPlayer() and player.RealSteamID then
		player.AccountContents = nil

		local frame = vgui.Create("DFrame")
		frame:SetTitle("Loading")
		frame:SetDeleteOnClose(true)
		frame.EndAttempt = CurTime() + 3
		frame.Player = player
		frame.Think = function(f)
			if f.EndAttempt <= CurTime() then
				f.EndAttempt = CurTime() + 999999
				f.Think = function(a) a:Remove() end
				Derma_Message("Couldn't load account information...")
			elseif f.Player:IsValid() and f.Player.AccountContents then
				f.EndAttempt = CurTime() + 999999
				f.Think = function(a) a:Remove() end
				CreateRealProfile(f.Player, f.Player.AccountContents)
			end
		end

		local wb = WordBox(frame, "Requesting account information...", "DefaultBold", color_white)
		wb:SetPos(8, 32)

		frame:SetSize(wb:GetWide() + 16, wb:GetTall() + 40)
		frame:Center()
		frame:SetVisible(true)
		frame:MakePopup()

		RunConsoleCommand("requestaccount", player:EntIndex())
	end
end

local matStar = Material("gui/silkicons/star")
effects.Register({Init = function(self, data)
	local pl = data:GetEntity()

	if pl and pl:IsValid() then
		self.Entity:SetRenderBounds(Vector(-256, -256, -256), Vector(256, 256, 256))

		self.DieTime = CurTime() + 3
		self.Player = pl

		local vPos = pl:GetPos()
		vPos.z = vPos.z + pl:OBBMaxs().z + 16

		local emitter = ParticleEmitter(vPos)
		emitter:SetNearClip(24, 32)

		local r, g, b, a = pl:GetColor()

		pl:EmitSound("weapons/physcannon/energy_disintegrate"..math.random(4, 5)..".wav", 100, a * 0.392)

		local vecGrav = Vector(0, 0, -800)
		for i=1, 64 do
			local vHeading = Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-0.1, 0.1)):Normalize()

			local particle = emitter:Add("gui/silkicons/star", vPos + vHeading * 8)
			particle:SetVelocity(vHeading * math.Rand(128, 256))
			particle:SetAirResistance(10)
			particle:SetDieTime(math.Rand(1.5, 2))
			particle:SetStartAlpha(a)
			particle:SetEndAlpha(0)
			particle:SetStartSize(5)
			particle:SetEndSize(5)
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand(-20, 20))
			particle:SetCollide(true)
			particle:SetBounce(0.9)
			particle:SetGravity(vecGrav)
		end

		emitter:Finish()
	else
		self.DieTime = 0
	end
end,

Think = function(self)
	return CurTime() < self.DieTime
end,

Render = function(self)
	local pl = self.Player
	if pl and pl:IsValid() then
		local pos = pl:GetPos()
		pos.z = pos.z + pl:OBBMaxs().z + 16

		local r,g,b,a = pl:GetColor()
		a = a * math.min(1, math.max(0, (self.DieTime - CurTime()) * 0.5))

		local siz = math.abs(math.sin(RealTime() * 8)) * (255 - a) * 0.2

		render.SetMaterial(matStar)
		render.DrawSprite(pos, 32 + siz, 32 + siz, Color(255, 255, 255, a * 0.5))
		render.DrawSprite(pos, 32, 32, Color(255, 255, 255, a))
	end
end}, "noxgetaward")
