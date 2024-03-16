AddCSLuaFile(NDB_ADDON_NAME)

CAT_HAT = 0
CAT_BODY = 1
CAT_BLOODDYE = 2
CAT_ACCESSORY = 3
CAT_TITLE = 4

NDB.ShopCategories = {[CAT_HAT] = "Hats", [CAT_BODY] = "Body Addons", [CAT_BLOODDYE] = "Blood Dyes", [CAT_ACCESSORY] = "Accessories", [CAT_TITLE] = "Titles"}

local order = 0
local function GetOrder()
	order = order + 1
	return order
end

local ShopItems = {}
NDB.ShopItems = ShopItems

function NDB.AddShopItem(name, bit, price, category, class, display, description, specialrequire, cantusemessage, canusecallback)
	if not name then return end

	local tab = {Money = price, Bit = bit, Category = category, Description = description, SpecialRequire = specialrequire, CantUseMessage = cantusemessage, CanUseCallback = canusecallback, Order = GetOrder()}
	if category and class then
		tab[category] = class
	end

	if display then
		if type(display) == "function" then
			tab.Paint = display
		else
			tab.Model = display
		end
	end

	ShopItems[name] = tab
end

NDB.AddShopItem("Aviator Glasses", 21, 500000, CAT_ACCESSORY, "acc_aviator", "Models/Aviator/aviator.mdl", "These glasses let others know that you're really stylish.")
--ShopItems["Aviator Glasses"] = {Money = 500000, Bit = 21, Category = CAT_ACCESSORY, [CAT_ACCESSORY] = "acc_aviator", Model = "Models/Aviator/aviator.mdl", Description = "These glasses let others know that you're really stylish.", Order = GetOrder()}
ShopItems["Afro"] = {Money = 250000, Bit = 22, Category = CAT_HAT, [CAT_HAT] = "hat_afro", Model = "models/Combine_Helicopter/helicopter_bomb01.mdl", Description = "People won't even be able to see past your hair.", Order = GetOrder()}
ShopItems["Headcrab Hat"] = {Money = 100000, Bit = 23, Category = CAT_HAT, [CAT_HAT] = "hat_headcrab", Model = "models/Nova/w_headcrab.mdl", Description = "Lamarr! There you are!", Awards = {"Marauder_of_Humans", "ZS_Zombie_Silver"}, Order = GetOrder()}
ShopItems["Plain Hat"] = {Money = 50000, Bit = 24, Category = CAT_HAT, [CAT_HAT] = "hat_plainhat", Model = "models/viroshat/viroshat.mdl", Description = "A very plain hat of the common business person.", Order = GetOrder()}
ShopItems["Mask"] = {Money = 100000, Bit = 19, Category = CAT_HAT, [CAT_HAT] = "hat_mask", Description = "Your face can remain a mystery with this.", Model = "models/BarneyHelmet_faceplate.mdl", Order = GetOrder()}
ShopItems["Lamp Shade"] = {Money = 50000, Bit = 20, Category = CAT_HAT, [CAT_HAT] = "hat_lampshade", Model = "models/props_c17/lampShade001a.mdl", Description = "Be a walking cliche!", Order = GetOrder()}
ShopItems["Cone Hat"] = {Money = 50000, Bit = 1, Category = CAT_HAT, [CAT_HAT] = "hat_cone", Description = "Direct traffic with your face!", Model = "models/props_junk/TrafficCone001a.mdl", Order = GetOrder()}
ShopItems["Watermelon Head"] = {Money = 50000, Bit = 2, Category = CAT_HAT, [CAT_HAT] = "hat_watermelon", Description = "No one will ever recognize you with a watermelon on your head!", Model = "models/props_junk/watermelon01.mdl", Order = GetOrder()}
ShopItems["Bucket Hat"] = {Money = 50000, Bit = 3, Category = CAT_HAT, [CAT_HAT] = "hat_bucket", Description = "How do you see out of this thing?", Model = "models/props_junk/MetalBucket01a.mdl", Order = GetOrder()}
ShopItems["Zombie Blood Dye"] = {Awards = {"ZS_Zombie_2nd"}, Bit = 4, Category = CAT_BLOODDYE, [CAT_BLOODDYE] = 1, Description = "Blood that comes out of your gibs will be a hideous green.", Model = "models/props_lab/jar01a.mdl", Order = GetOrder()}
ShopItems["Mana Blood Dye"] = {CTFKills = 2500, CTFCaptures = 25, Bit = 5, Category = CAT_BLOODDYE, [CAT_BLOODDYE] = 2, Description = "Blood that comes out of your gibs will be a bright blue.", Model = "models/props_lab/jar01a.mdl", Order = GetOrder()}
ShopItems["Rainbow Blood Dye"] = {Money = 100000, CTFKills = 2500, CTFCaptures = 25, Bit = 6, Category = CAT_BLOODDYE, [CAT_BLOODDYE] = 3, Description = "Blood that comes out of your gibs will be colors from the rainbow!", Model = "models/props_lab/jar01a.mdl", Order = GetOrder()}
ShopItems["Holy Blood Dye"] = {Money = 100000, Awards = {"ZS_Human_1st"}, Bit = 7, Category = CAT_BLOODDYE, [CAT_BLOODDYE] = 4, Description = "Blood that comes out of your gibs will be made of blinding light.", Model = "models/props_lab/jar01a.mdl", Order = GetOrder()}
ShopItems["Baseball Cap"] = {Money = 50000, Bit = 8, Category = CAT_HAT, [CAT_HAT] = "hat_baseballcap", Description = "A rather plain baseball cap.", Model = "models/props/cs_office/Snowman_hat.mdl", Order = GetOrder()}
ShopItems["Skull Head"] = {Money = 250000, Awards = {"Eradicator_Of_Humans"}, Bit = 9, Category = CAT_HAT, [CAT_HAT] = "hat_skull", Description = "Let others know how evil you are.", Model = "models/Gibs/HGIBS.mdl", Order = GetOrder()}
ShopItems["Snowman Face"] = {Money = 100000, Bit = 10, Category = CAT_HAT, [CAT_HAT] = "hat_snowman", Description = "Be like Frosty the Snowman with this hat.", Model = "models/props/cs_office/snowman_face.mdl", Order = GetOrder()}
ShopItems["Frosty Aura"] = {Money = 500000, Bit = 11, Category = CAT_BODY, [CAT_BODY] = "body_frostyaura", Description = "A snow elemental's body!", Model = "models/props/cs_office/snowman_face.mdl", Order = GetOrder()}
ShopItems["Frosty Aura 2"] = {Money = 500000, Bit = 12, Category = CAT_BODY, [CAT_BODY] = "body_frostyaura2", Description = "A more solid version of the Frosty Aura.", Model = "models/props/cs_office/snowman_face.mdl", Order = GetOrder()}
ShopItems["Barrel Head"] = {Money = 100000, Bit = 13, Category = CAT_HAT, [CAT_HAT] = "hat_barrel", Description = "Your head becomes a false explosive barrel!", Model = "models/props_c17/oildrum001_explosive.mdl", Order = GetOrder()}
ShopItems["Angelic Halo"] = {Money = 100000, Awards = {"2500HP_Cleric"}, Bit = 14, Category = CAT_HAT, [CAT_HAT] = "hat_angelichalo", Description = "This halo can only be worn by the greatest Templars.", Model = "models/props_c17/oildrum001_explosive.mdl", Order = GetOrder()}
ShopItems["Chef Hat"] = {Money = 50000, Bit = 15, Category = CAT_HAT, [CAT_HAT] = "hat_chefshat", Description = "A hat widely used by professional cooks.", Model = "models/chefHat.mdl", Order = GetOrder()}
ShopItems["Midnight Blood Dye"] = {Money = 100000, Awards = {"ZS_Zombie_1st"}, Bit = 16, Category = CAT_BLOODDYE, [CAT_BLOODDYE] = 5, Description = "Blood that comes out of your gibs will be pitch black!", Model = "models/props_lab/jar01a.mdl", Order = GetOrder()}
ShopItems["Annoying Radio"] = {SpecialRequire = "This special item isn't available through normal methods.", Bit = 17, Category = CAT_ACCESSORY, [CAT_ACCESSORY] = "acc_annoyingradio", Description = "Play dumb music to annoy people!", Model = "models/props_lab/citizenradio.mdl", Order = GetOrder()}
ShopItems["Pot Hat"] = {Money = 50000, Bit = 18, Category = CAT_HAT, [CAT_HAT] = "hat_pot", Description = "You can't play soldier without this.", Model = "models/props_interiors/pot02a.mdl", Order = GetOrder()}
ShopItems["Caster Hands"] = {Category = CAT_BODY, SpecialRequire = "Part of the Tribes RPG promotion. See the news section at www.noxiousnet.com for more information.", CantUseMessage = "You must claim this promotional item with /claiim tribesrpg.", [CAT_BODY] = "body_casterhands", Model = "models/props_c17/light_cagelight02_on.mdl", Description = "Your hands glow as if ready to unleash a magical spell.", Order = GetOrder(), CanUseCallback = function(pl) return pl:HasFlag("promo_tribesrpg") end}
ShopItems["Voice Changer"] = {Category = CAT_ACCESSORY, Bit = 25, SpecialRequire = "This item is currently not for sale!", CantUseMessage = "Not for sale!", [CAT_ACCESSORY] = "acc_voicechanger", Model = "models/props_lab/citizenradio.mdl", Description = "This little box allows you to change your voice!", Order = GetOrder()}
if SERVER then
	NDB.AddShopItem("Sh*t Eating Grin", 26, 250000, CAT_ACCESSORY, "acc_seg", nil, "Let everyone know how happy (or sadistic) you are.")	
end
if CLIENT then
	local texSmile = surface.GetTextureID("mario/boxsmile")
	NDB.AddShopItem("Sh*t Eating Grin", 26, 250000, CAT_ACCESSORY, "acc_seg", function(pan) surface.SetTexture(texSmile) surface.SetDrawColor(255, 255, 255, 255) surface.DrawOutlinedRect(0, 0, pan:GetWide(), pan:GetTall()) surface.DrawTexturedRect(pan:GetWide() * 0.5 - 16, pan:GetTall() * 0.5 - 16, 32, 32) end, "Let everyone know how happy (or sadistic) you are.")
end
--ShopItems["SE Grin"] = {Money = 250000, Category = CAT_ACCESSORY, Bit = 26, [CAT_ACCESSORY] = "acc_seg", Model = "models/props_lab/citizenradio.mdl", Description = "Let everyone know how happy (or sadistic) you are.", Order = GetOrder()}
ShopItems["(Grand Champion)"] = {Category = CAT_TITLE, SpecialRequire = "You must meet the requirements of every Champion title!",
CanUseCallback = function(pl)
	return NDB.PlayerHasShopItem(pl, "(Mario Boxes Champion)") and NDB.PlayerHasShopItem(pl, "(Zombie Survival Champion)") and NDB.PlayerHasShopItem(pl, "(Team Play Champion)") and NDB.PlayerHasShopItem(pl, "(Arena Champion)")
end, CantUseMessage = "You must meet the requirements of every Champion title!", Order = GetOrder()}
ShopItems["Title Reset"] = {Category = CAT_TITLE, SpecialRequire = "None",
CanUseCallback = function(pl)
	return true
end, Order = GetOrder()}
ShopItems["Title Clear"] = {Category = CAT_TITLE, SpecialRequire = "None",
CanUseCallback = function(pl)
	return true
end, Order = GetOrder()}
ShopItems["(Survivor)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a 0.1 survive / lose ratio and 30 games in Zombie Survival.",
CanUseCallback = function(pl)
	return pl.ZSGamesSurvived / math.max(pl.ZSGamesLost, 1) >= 0.1 and pl.ZSGamesSurvived + pl.ZSGamesLost >= 30
end, CantUseMessage = "You must have at least a 0.1 survive / lose ratio and have played at least 30 games in Zombie Survival.", Order = GetOrder()}
ShopItems["(Zombie Survival Champion)"] = {Category = CAT_TITLE, SpecialRequire = "You must have both the ZS Zombie 1st and ZS Human 1st awards.",
CanUseCallback = function(pl)
	return NDB.PlayerHasShopItem(pl, "(Survivor)") or pl:HasAward("ZS_Zombie_1st") and pl:HasAward("ZS_Human_1st")
end, CantUseMessage = "You must have both the ZS Zombie 1st and ZS Human 1st awards.", Order = GetOrder()}
ShopItems["(Slayer)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a Team Play K/D ratio of 2.0 or above as well as 100 kills.",
CanUseCallback = function(pl)
	return pl.CTFKills >= 100 and pl.CTFKills / math.max(1, pl.CTFDeaths) >= 2
end, CantUseMessage = "You must have at least 100 kills and at least a 2.0 K/D ratio.", Order = GetOrder()}
ShopItems["(Defender)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a Team Play Defense/Offense ratio of 5.0 or above as well as have at least 100 defense points.",
CanUseCallback = function(pl)
	return pl.AssaultDefense >= 100 and pl.AssaultDefense / math.max(1, pl.AssaultOffense) >= 5
end, CantUseMessage = "Requires a Team Play Defense/Offense ratio of 5.0 or above as well as have at least 100 defense points.", Order = GetOrder()}
ShopItems["(Destroyer)"] = {Category = CAT_TITLE, SpecialRequire = "You must have at least 100 Team Play offense points and at least a 5.0 Offense/Defense ratio.",
CanUseCallback = function(pl)
	return pl.AssaultOffense >= 100 and pl.AssaultOffense / math.max(1, pl.AssaultDefense) >= 5
end, CantUseMessage = "You must have at least 100 Team Play offense points and at least a 5.0 Offense/Defense ratio.", Order = GetOrder()}
ShopItems["(Team Play Apprentice)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a Team Play Win/Lose ratio of 1.25 or above and have at least 25 games played.",
CanUseCallback = function(pl)
	return pl.AssaultWins / math.max(pl.AssaultLosses, 1) >= 1.25 and pl.AssaultWins + pl.AssaultLosses >= 25
end, CantUseMessage = "Requires a Team Play Win/Lose ratio of 1.25 or above and have at least 25 games played.", Order = GetOrder()}

ShopItems["(Team Play Battle Apprentice)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a Team Play Kill/Death ratio of 1.0 or above and meet the requirements for Team Play Apprentice.",
CanUseCallback = function(pl)
	return pl.CTFKills / math.max(pl.CTFDeaths, 1) >= 1.0 and NDB.PlayerHasShopItem(pl, "(Team Play Apprentice)")
end, CantUseMessage = "Requires a Team Play Kill/Death ratio of 1.0 or above and meet the requirements for Team Play Apprentice.", Order = GetOrder()}
ShopItems["(Team Play Midfielder)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a Team Play Win/Lose ratio of 1.5 or above and have at least 50 games played.",
CanUseCallback = function(pl)
	return pl.AssaultWins / math.max(pl.AssaultLosses, 1) >= 1.5 and pl.AssaultWins + pl.AssaultLosses >= 50
end, CantUseMessage = "Requires a Team Play Win/Lose ratio of 1.5 or above and have at least 50 games played.", Order = GetOrder()}
ShopItems["(Team Play Battle Midfielder)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a Team Play Kill/Death ratio of 1.25 or above and meet the requirements for Team Play Midfielder.",
CanUseCallback = function(pl)
	return pl.CTFKills / math.max(pl.CTFDeaths, 1) >= 1.25 and NDB.PlayerHasShopItem(pl, "(Team Play Midfielder)")
end, CantUseMessage = "Requires a Team Play Kill/Death ratio of 1.25 or above and meet the requirements for Team Play Midfielder.", Order = GetOrder()}
ShopItems["(Team Play Master)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a Team Play Win/Lose ratio of 2.5 or above and have at least 100 games played.",
CanUseCallback = function(pl)
	return pl.AssaultWins / math.max(pl.AssaultLosses, 1) >= 2.5 and pl.AssaultWins + pl.AssaultLosses >= 100
end, CantUseMessage = "Requires a Team Play Win/Lose ratio of 2.5 or above and have at least 100 games played.", Order = GetOrder()}
ShopItems["(Team Play Battle Master)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a Team Play Kill/Death ratio of 1.5 or above and meet the requirements for Team Play Master.",
CanUseCallback = function(pl)
	return pl.CTFKills / math.max(pl.CTFDeaths, 1) >= 1.5 and NDB.PlayerHasShopItem(pl, "(Team Play Master)")
end, CantUseMessage = "Requires a Team Play Kill/Death ratio of 1.5 or above and meet the requirements for Team Play Master.", Order = GetOrder()}
ShopItems["(Team Play Champion)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a Team Play Kill/Death ratio of 2.0, a 2.0 Win/Lose ratio and, have at least 50 matches played.",
CanUseCallback = function(pl)
	return pl.CTFKills / math.max(pl.CTFDeaths, 1) >= 2.0 and pl.AssaultWins / math.max(pl.AssaultLosses, 1) >= 2.0 and pl.AssaultWins + pl.AssaultLosses >= 50
end, CantUseMessage = "Requires a Team Play Kill/Death ratio of 2.0, a 2.0 Win/Lose ratio and, have at least 50 matches played.", Order = GetOrder()}
ShopItems["(Mario Boxes Novice)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a Mario Boxes Win/Lose ratio of 1.0 or above and have at least 20 games played.",
CanUseCallback = function(pl)
	return pl.MarioBoxesWins / math.max(pl.MarioBoxesLosses, 1) >= 1 and pl.MarioBoxesWins + pl.MarioBoxesLosses >= 20
end, CantUseMessage = "Requires a Mario Boxes Win/Lose ratio of 1.0 or above and have at least 20 games played.", Order = GetOrder()}
ShopItems["(Mario Boxes Knight)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a Mario Boxes Win/Lose ratio of 1.5 or above and have at least 30 games played.",
CanUseCallback = function(pl)
	return pl.MarioBoxesWins / math.max(pl.MarioBoxesLosses, 1) >= 1.5 and pl.MarioBoxesWins + pl.MarioBoxesLosses >= 30
end, CantUseMessage = "Requires a Mario Boxes Win/Lose ratio of 1.5 or above and have at least 30 games played.", Order = GetOrder()}
ShopItems["(Mario Boxes Hero)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a Mario Boxes Win/Lose ratio of 1.5 or above and have at least 40 games played.",
CanUseCallback = function(pl)
	return pl.MarioBoxesWins / math.max(pl.MarioBoxesLosses, 1) >= 2 and pl.MarioBoxesWins + pl.MarioBoxesLosses >= 40
end, CantUseMessage = "Requires a Mario Boxes Win/Lose ratio of 2.0 or above and have at least 40 games played.", Order = GetOrder()}
ShopItems["(Box Killer)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a Mario Boxes Kill/Death ratio of 0.75 or above and have at least 50 kills.",
CanUseCallback = function(pl)
	return pl.MarioBoxesKills / math.max(pl.MarioBoxesDeaths, 1) >= 0.75 and pl.MarioBoxesKills >= 50
end, CantUseMessage = "Requires a Mario Boxes Kill/Death ratio of 0.75 or above and have at least 50 kills.", Order = GetOrder()}
ShopItems["(Box Destroyer)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a Mario Boxes Kill/Death ratio of 1.0 or above and have at least 100 kills.",
CanUseCallback = function(pl)
	return pl.MarioBoxesKills / math.max(pl.MarioBoxesDeaths, 1) >= 1 and pl.MarioBoxesKills >= 100
end, CantUseMessage = "Requires a Mario Boxes Kill/Death ratio of 1.0 or above and have at least 100 kills.", Order = GetOrder()}
ShopItems["(Mario Boxes Champion)"] = {Category = CAT_TITLE, SpecialRequire = "You must meet the requirements of both Box Destroyer and Mario Boxes Hero.",
CanUseCallback = function(pl)
	return NDB.PlayerHasShopItem(pl, "(Mario Boxes Hero)") and NDB.PlayerHasShopItem(pl, "(Box Destroyer)")
end, CantUseMessage = "You must meet the requirements of both Box Destroyer and Mario Boxes Hero.", Order = GetOrder()}
ShopItems["(Arena Fighter)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a NoX Arena Win/Lose ratio of 2.0 or above and have at least 25 matches played!",
CanUseCallback = function(pl)
	return pl.ArenaWins / math.max(pl.ArenaLosses, 1) >= 2 and pl.ArenaWins + pl.ArenaLosses >= 25
end, CantUseMessage = "Requires a NoX Arena Win/Lose ratio of 2.0 or above and have at least 25 matches played!", Order = GetOrder()}
ShopItems["(Arena Gladiator)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a NoX Arena Win/Lose ratio of 2.5 or above and have at least 40 matches played!",
CanUseCallback = function(pl)
	return pl.ArenaWins / math.max(pl.ArenaLosses, 1) >= 2.5 and pl.ArenaWins + pl.ArenaLosses >= 40
end, CantUseMessage = "Requires a NoX Arena Win/Lose ratio of 2.5 or above and have at least 40 matches played!", Order = GetOrder()}
ShopItems["(Arena Battlemaster)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a NoX Arena Win/Lose ratio of 3.0 or above and have at least 50 matches played!",
CanUseCallback = function(pl)
	return pl.ArenaWins / math.max(pl.ArenaLosses, 1) >= 3 and pl.ArenaWins + pl.ArenaLosses >= 50
end, CantUseMessage = "Requires a NoX Arena Win/Lose ratio of 3.0 or above and have at least 50 matches played!", Order = GetOrder()}
ShopItems["(Arena Champion)"] = {Category = CAT_TITLE, SpecialRequire = "Requires a NoX Arena Win/Lose ratio of 4.0 or above and have at least 75 matches played!",
CanUseCallback = function(pl)
	return pl.ArenaWins / math.max(pl.ArenaLosses, 1) >= 4 and pl.ArenaWins + pl.ArenaLosses >= 75
end, CantUseMessage = "Requires a NoX Arena Win/Lose ratio of 4.0 or above and have at least 75 matches played!", Order = GetOrder()}
ShopItems["<awardicon=verified_girl,xsmall>"] = {Category = CAT_TITLE, SpecialRequire = "If you have passed the vigorous \"are they female?\" test, you can freely use this title.",
CanUseCallback = function(pl)
	return pl:HasAward("Verified_Girl")
end, CantUseMessage = "You must have the Verified Girl award.", Order = GetOrder()}

GetOrder = nil
order = nil

for i, tab in pairs(ShopItems) do
	if tab.Category == CAT_TITLE and not tab[CAT_TITLE] then
		tab[CAT_TITLE] = i
	end
end

function NDB.GetShopItem(itemname)
	return ShopItems[itemname]
end

function NDB.OldPlayerHasShopItem(pl, item)
	if ShopItems[item] and ShopItems[item].Bit then
		local bit = 2 ^ ShopItems[item].Bit
		return bit & pl.ShopInventory == bit
	end

	return false
end

function NDB.PlayerHasShopItem(pl, item)
	if ShopItems[item] then
		if ShopItems[item].CanUseCallback then
			return ShopItems[item].CanUseCallback(pl)
		else
			local bit = ShopItems[item].Bit
			return table.HasValue(pl.Inventory, bit)
		end
	end

	return false
end
