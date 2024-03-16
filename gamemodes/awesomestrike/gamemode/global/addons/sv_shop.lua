local ShopItems = NDB.ShopItems

local function DoReset(pl)
	if pl:IsValid() then
		local setpos = pl:GetPos() + Vector(0,0,16)
		for _, ent in pairs(ents.FindByClass("status_*")) do
			if ent:GetOwner() == pl then
				ent:SetPos(setpos)
			end
		end
	end
end

hook.Add("PlayerSpawn", "ResetAccessories", function(pl)
	timer.Simple(0.1, DoReset, pl)
end)

hook.Add("PlayerReady", "HatPlayerReady", function(pl)
	if pl.Hat and not GAMEMODE.HatsDisabled then
		pl:GiveStatus(pl.Hat)
	end

	if pl.BloodDye and not GAMEMODE.BloodDyesDisabled then
		pl:GiveStatus("blooddye"):SetSkin(pl.BloodDye)
	end

	if pl.Body and not GAMEMODE.BodysDisabled then
		pl:GiveStatus(pl.Body)
	end

	if pl.Acc and not GAMEMODE.AccsDisabled then
		pl:GiveStatus(pl.Acc)
	end

	local curtitle = pl.NewTitle or "None"
	for i, tab in pairs(ShopItems) do
		if tab[CAT_TITLE] and string.find(curtitle, tab[CAT_TITLE], 1, true) and tab.CanUseCallBack and not tab.CanUseCallBack(pl) then
			pl:PrintMessage(HUD_PRINTTALK, "You no longer qualify for the \""..curtitle.."\" title and it has been removed.")
			pl.NewTitle = pl:GetDefaultTitle()

			umsg.Start("RecTitle")
				umsg.Entity(pl)
				umsg.String(pl.NewTitle)
			umsg.End()

			break
		end
	end
end)

for _, tab in pairs(ShopItems) do
	tab.Description = nil
	tab.Model = nil
end

local function GiveHat(pl, typ)
	if GAMEMODE.HatsDisabled or not typ or CurTime() < (pl.NextHat or 0) then return end
	pl.NextHat = CurTime() + 2

	if pl.Hat and pl.Hat == typ then
		pl:RemoveStatus(pl.Hat, false, true)
		pl.Hat = nil
		pl:PrintMessage(HUD_PRINTTALK, "You remove your current hat.")
		return
	end

	if pl.Hat then
		pl:RemoveStatus(pl.Hat, false, true)
		pl.Hat = nil
	end

	pl.Hat = typ
	pl:GiveStatus(typ)
	pl:PrintMessage(HUD_PRINTTALK, typ.." is now being worn in your hat slot.")
end

local function GiveBody(pl, typ)
	if GAMEMODE.BodyDisabled or not typ or CurTime() < (pl.NextBody or 0) then return end
	pl.NextBody = CurTime() + 2

	if pl.Body and pl.Body == typ then
		pl:RemoveStatus(pl.Body, false, true)
		pl.Body = nil
		pl:PrintMessage(HUD_PRINTTALK, "You remove your current body addon.")
		return
	end

	if pl.Body then
		pl:RemoveStatus(pl.Body, false, true)
		pl.Body = nil
	end

	pl.Body = typ
	pl:GiveStatus(typ)
	pl:PrintMessage(HUD_PRINTTALK, typ.." is now being worn in your body slot.")
end

local function GiveAcc(pl, typ)
	if GAMEMODE.AccsDisabled or not typ or CurTime() < (pl.NextAcc or 0) then return end
	pl.NextAcc = CurTime() + 2

	if pl.Acc and pl.Acc == typ then
		pl:RemoveStatus(pl.Acc, false, true)
		pl.Acc = nil
		pl:PrintMessage(HUD_PRINTTALK, "You remove your current accessory.")
		return
	end

	if pl.Acc then
		pl:RemoveStatus(pl.Acc, false, true)
		pl.Acc = nil
	end

	pl.Acc = typ
	pl:GiveStatus(typ)
	pl:PrintMessage(HUD_PRINTTALK, typ.." is now being worn in your accessory slot.")
end

local function GiveBloodDye(pl, skin)
	if GAMEMODE.BloodDyesDisabled or not skin or CurTime() < (pl.NextBloodDye or 0) then return end
	pl.NextBloodDye = CurTime() + 2

	if pl.BloodDye and pl.BloodDye == skin then
		pl:RemoveStatus("blooddye", false, true)
		pl.BloodDye = nil
		pl:PrintMessage(HUD_PRINTTALK, "You restore your blood to it's original composition.")
	else
		local stat = pl:GetStatus("blooddye")
		if stat then
			stat:SetSkin(skin)
		else
			pl:GiveStatus("blooddye"):SetSkin(skin)
		end
		pl.BloodDye = skin
		pl:PrintMessage(HUD_PRINTTALK, "Blood Dye #"..skin.." set.")
	end
end

local function GiveTitle(pl, title)
	if not title then return end

	if pl.TitleLocked and not pl:IsAdmin() then
		pl:PrintMessage(HUD_PRINTTALK, "Your title has been locked by an admin.")
		return
	end

	if title == "None" then
		title = pl:GetDefaultTitle()
	elseif MEMBER_GOLD <= pl.MemberLevel then
		title = "<avatar> "..title
	end

	pl.NewTitle = title

	pl:PrintMessage(HUD_PRINTTALK, "Your title has been set to \""..title.."\"")

	umsg.Start("RecTitle")
		umsg.Entity(pl)
		umsg.String(pl.NewTitle)
	umsg.End()
end

ShopItems["Title Reset"].Use = function(pl)
	GiveTitle(pl, "None")
end
ShopItems["Title Clear"].Use = function(pl)
	GiveTitle(pl, "")
end

concommand.Add("buyshopitem", function(pl, command, arguments)
	local item = table.concat(arguments, " ")

	if not ShopItems[item] then return pl:PrintMessage(HUD_PRINTTALK, "That item doesn't exist.") end

	if NDB.PlayerHasShopItem(pl, item) then
		pl:UpdateShopInventory()
		return pl:PrintMessage(HUD_PRINTTALK, "You already have this item.")
	end

	local itemname = item
	item = ShopItems[item]

	if item.SpecialRequire then
		return pl:PrintMessage(HUD_PRINTTALK, "This item is not for sale!")
	end

	if item.GoldMember and pl.MemberLevel ~= MEMBER_GOLD then
		return pl:PrintMessage(HUD_PRINTTALK, "This item is only for Gold Members.")
	end

	if item.DiamondMember and pl.MemberLevel ~= MEMBER_DIAMOND then
		return pl:PrintMessage(HUD_PRINTTALK, "This item is only for Diamond Members.")
	end

	if item.NormalOnly and pl.MemberLevel ~= MEMBER_NONE then
		return pl:PrintMessage(HUD_PRINTTALK, "This item is only for non-Gold and non-Diamond Members.")
	end

	if item.Money and pl.Money < math.ceil(pl:GetDiscount() * item.Money) then
		return pl:PrintMessage(HUD_PRINTTALK, "You don't have enough Silver for this item.")
	end

	if item.Jetanium and pl.UsableJetanium < item.Jetanium then
		return pl:PrintMessage(HUD_PRINTTALK, "You don't have enough Jetanium for this item.")
	end

	if item.Awards then
		local hasawards = true

		for _, award in pairs(item.Awards) do
			if not pl:HasAward(award) then
				return pl:PrintMessage(HUD_PRINTTALK, "This item requires these awards: "..table.concat(item.Awards, ", ")..".")
			end
		end
	end

	if item.CTFKills and pl.CTFKills < item.CTFKills then
		return pl:PrintMessage(HUD_PRINTTALK, "You don't have enough TeamPlay kills for this item.")
	end

	if item.CTFCaptures and pl.CTFCaptures < item.CTFCaptures then
		return pl:PrintMessage(HUD_PRINTTALK, "You don't have enough TeamPlay flag captures for this item.")
	end

	if item.TeamPlayWins and pl.AssaultWins < item.TeamPlayWins then
		return pl:PrintMessage(HUD_PRINTTALK, "You don't have enough TeamPlay game victories for this item.")
	end

	if item.TeamPlayLosses and pl.AssaultLosses < item.TeamPlayLosses then
		return pl:PrintMessage(HUD_PRINTTALK, "You don't have enough TeamPlay game losses for this item.")
	end

	if item.TeamPlayWinLossRatio and pl.AssaultWins / math.max(1, pl.AssaultLosses) < item.TeamPlayWinLossRatio then
		return pl:PrintMessage(HUD_PRINTTALK, "Your TeamPlay win / loss ratio is too low for this item.")
	end

	if item.TeamPlayOffenseDefenseRatio and pl.AssaultOffense / math.max(1, pl.AssaultDefense) < item.TeamPlayOffenseDefenseRatio then
		return pl:PrintMessage(HUD_PRINTTALK, "Your TeamPlay offense-over-defense ratio is too low for this item.")
	end

	if item.TeamPlayDefenseOffenseRatio and pl.AssaultDefense / math.max(1, pl.AssaultOffense) < item.TeamPlayDefenseOffenseRatio then
		return pl:PrintMessage(HUD_PRINTTALK, "Your TeamPlay defense-over-offense ratio is too low for this item.")
	end

	if item.TeamPlayOffense and pl.AssaultOffense < item.TeamPlayOffense then
		return pl:PrintMessage(HUD_PRINTTALK, "You don't have enough TeamPlay offense for this item.")
	end

	if item.TeamPlayDefense and pl.AssaultDefense < item.TeamPlayOffense then
		return pl:PrintMessage(HUD_PRINTTALK, "You don't have enough TeamPlay defense for this item.")
	end

	if item.ArenaWins and pl.ArenaWins < item.ArenaWins then
		return pl:PrintMessage(HUD_PRINTTALK, "You don't have enough Arena victories for this item.")
	end

	if item.ArenaLosses and pl.ArenaLosses < item.ArenaLosses then
		return pl:PrintMessage(HUD_PRINTTALK, "You don't have enough Arena losses for this item.")
	end

	if item.ArenaWinLossRatio and pl.ArenaWins / math.max(1, pl.ArenaLosses) < item.ArenaWinLossRatio then
		return pl:PrintMessage(HUD_PRINTTALK, "Your Arena victory / loss ratio is too low for this item.")
	end

	if item.ZSBrainsEaten and pl.ZSBrainsEaten < item.ZSBrainsEaten then
		return pl:PrintMessage(HUD_PRINTTALK, "You don't have enough brains eaten in Zombie Survival for this item.")
	end

	if item.ZSZombiesKilled and pl.ZSZombiesKilled < item.ZSZombiesKilled then
		return pl:PrintMessage(HUD_PRINTTALK, "You don't have enough zombies killed in Zombie Survival for this item.")
	end

	if item.ZSZombiesKilledZSBrainsEatenRatio and pl.ZSZombiesKilled / math.max(1, pl.ZSBrainsEaten) < item.ZSZombiesKilledZSBrainsEatenRatio then
		return pl:PrintMessage(HUD_PRINTTALK, "Your zombies killed over brains eaten ratio in Zombie Survival is too low for this item.")
	end

	if item.ZSBrainsEatenZSZombiesKilledRatio and pl.ZSBrainsEaten / math.max(1, pl.ZSZombiesKilled) < item.ZSBrainsEatenZSZombiesKilledRatio then
		return pl:PrintMessage(HUD_PRINTTALK, "Your brains eaten over zombies killed ratio in Zombie Survival is too low for this item.")
	end

	if item.Money then
		pl:SetMoney(pl:GetMoney() - math.ceil(pl:GetDiscount() * item.Money))
	end

	if item.Jetanium then
		pl:SetJetanium(pl:GetJetanium() - item.Jetanium, true)
	end

	pl.Inventory[#pl.Inventory+1] = item.Bit

	pl:UpdateShopInventory()

	pl:PrintMessage(HUD_PRINTTALK, "You have obtained an item: "..itemname.."! You can use the chat command /useitem "..itemname.." or console command useitem "..itemname.." as a shortcut to use your item!")

	NDB.SaveInfo(pl)
end)

concommand.Add("useitem", function(sender, command, arguments)
	local itemname = table.concat(arguments, " ")
	local item = ShopItems[itemname]

	if not item then
		sender:PrintMessage(HUD_PRINTTALK, "That item doesn't exist.")
	elseif item.NoUse then
		sender:PrintMessage(HUD_PRINTTALK, "You can't use this item through the shop menu.")
	elseif not NDB.PlayerHasShopItem(sender, itemname) then
		sender:PrintMessage(HUD_PRINTTALK, item.CantUseMessage or "You don't have that item!")
	elseif item.Use then
		item.Use(sender)
	elseif item[CAT_HAT] then
		GiveHat(sender, item[CAT_HAT], item[CAT_HAT_MSG])
	elseif item[CAT_BODY] then
		GiveBody(sender, item[CAT_BODY], item[CAT_BODY_MSG])
	elseif item[CAT_BLOODDYE] then
		GiveBloodDye(sender, item[CAT_BLOODDYE], item[CAT_BLOODDYE_MSG])
	elseif item[CAT_ACCESSORY] then
		GiveAcc(sender, item[CAT_ACCESSORY], item[CAT_ACCESSORY_MSG])
	elseif item[CAT_TITLE] then
		GiveTitle(sender, item[CAT_TITLE])
	else
		sender:PrintMessage(HUD_PRINTTALK, "That item can't be activated with useitem or the shop menu.")
	end
end)

local function CC_OpenBuyMenu(pl)
	pl:ConCommand("shopmenu")
end
NDB.AddPrivateChatCommand("/store", CC_OpenBuyMenu, "- Open the global NoXiousNet store.", true)
NDB.AddPrivateChatCommand("/shop", CC_OpenBuyMenu, "- Open the global NoXiousNet store.", true)
NDB.AddPrivateChatCommand("/buy", CC_OpenBuyMenu, "- Open the global NoXiousNet store.", true)
