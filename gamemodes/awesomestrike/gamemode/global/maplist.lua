NDB.GenericMapTags = {"Fun", "Boring", "Amazing", "Lousy", "Fast", "Slow", "Pretty", "Ugly", "Unique", "Unoriginal", "Hard", "Easy", "Big", "Small", "Complex", "Simple", "Interactive", "Colorful", "Favorite!"}
NDB.GamemodeMapTags = {}
NDB.MapList = {}
NDB.EliminationIncrement = {}

if SERVER then
	function NDB.AddMap(name, gamemodename, cleanname, garbage, garbage2, minplayers)
		if not NDB.MapList[gamemodename] then
			NDB.AddMapType(gamemodename)
		end

		local tab = NDB.MapList[gamemodename]
		tab[#tab+1] = {name, gamemodename, cleanname, nil, nil, minplayers}
	end
end

if CLIENT then
	NDB.MapTagIcons = {}
	NDB.MapTagIcons["Favorite!"] = "gui/silkicons/heart"
	NDB.MapTagIcons["Explosives"] = "gui/silkicons/bomb"
	NDB.MapTagIcons["Fun"] = "gui/silkicons/emoticon_smile"
	NDB.MapTagIcons["Colorful"] = "gui/silkicons/palette"
	NDB.MapTagIcons["Amazing"] = "gui/silkicons/star"
	NDB.MapTagIcons["Big"] = "gui/silkicons/world"
	NDB.MapTagIcons["Vehicles"] = "gui/silkicons/car"
	NDB.MapTagIcons["House Map"] = "gui/silkicons/house"
	NDB.MapTagIcons["Boring"] = "gui/silkicons/text_bold"
	NDB.MapTagIcons["Complex"] = "gui/silkicons/arrow_switch"
	NDB.MapTagIcons["Fast"] = "gui/silkicons/clock_red"
	NDB.MapTagIcons["Slow"] = "gui/silkicons/clock"
	NDB.MapTagIcons["Frantic"] = "gui/silkicons/lightning"
	NDB.MapTagIcons["Simple"] = "gui/silkicons/arrow_right"
	NDB.MapTagIcons["Interactive"] = "gui/silkicons/cog"
	NDB.MapTagIcons["Pretty"] = "gui/silkicons/eye"
	NDB.MapTagIcons["Lousy"] = "gui/silkicons/bin_closed"
	NDB.MapTagIcons["Frantic"] = "gui/silkicons/lightning"
	NDB.MapTagIcons["Unoriginal"] = "noxemoticons/dry"
	NDB.MapTagIcons["Ugly"] = "noxemoticons/ugly"
	NDB.MapTagIcons["Hard"] = "noxemoticons/cry"
	NDB.MapTagIcons["Guns"] = "noxemoticons/gun"
	NDB.MapTagIcons["Swords"] = "noxemoticons/swords"
	NDB.MapTagIcons["Building"] = "noxemoticons/phys"
	NDB.MapTagIcons["Scary"] = "noxemoticons/scream"
	NDB.MapTagIcons["Dark"] = "noxemoticons/dark"
	NDB.MapTagIcons["Strategic"] = "noxemoticons/chess"
	NDB.MapTagIcons["Unique"] = "noxemoticons/unique"
	NDB.MapTagIcons["Super Weapons"] = "noxemoticons/atomic"
	NDB.MapTagIcons["Camping"] = "noxemoticons/tent"
	NDB.MapTagIcons["Progressive"] = "noxemoticons/stairs"
	NDB.MapTagIcons["Overworld"] = "noxemoticons/overworld"
	NDB.MapTagIcons["Traps"] = "noxemoticons/beartrap"
	NDB.MapTagIcons["Barricading"] = "noxemoticons/barricade"
	NDB.MapTagIcons["Open"] = "noxemoticons/openbox"
	NDB.MapTagIcons["Dungeon"] = "noxemoticons/dungeonmaster"
	NDB.MapTagIcons["Grappling"] = "noxemoticons/grapple"
	NDB.MapTagIcons["Aerial"] = "noxemoticons/flyingblock"
	NDB.MapTagIcons["Enclosed"] = "noxemoticons/mario_squashed"
	NDB.MapTagIcons["Easy"] = "noxemoticons/wheelchair2"
	NDB.MapTagIcons["Small"] = "gui/silkicons/magnifier"

	function NDB.AddMap(name, gamemodename, cleanname, description, author, minplayers)
		if not NDB.MapList[gamemodename] then
			NDB.AddMapType(gamemodename)
		end

		local tab = NDB.MapList[gamemodename]
		tab[#tab+1] = {name, gamemodename, cleanname, description, author, minplayers}
	end
end

function NDB.AddMapType(gamemodename, tags, increment)
	NDB.MapList[gamemodename] = NDB.MapList[gamemodename] or {}
	NDB.GamemodeMapTags[gamemodename] = NDB.GamemodeMapTags[gamemodename] or tags or {}
	NDB.EliminationIncrement[gamemodename] = increment
end

function NDB.GetMapTable(name, gamemodename)
	if not NDB.GamemodeMapList[gamemodename] then return end

	for i, tab in pairs(NDB.GamemodeMapList[gamemodename]) do
		if tab[1] == name then return tab end
	end
end

NDB.AddMapType("default")
NDB.AddMap("gm_flatgrass", "default", "Flat Grass")
NDB.AddMap("gm_construct", "default", "Construct")

NDB.AddMapType("noxious", {"Vehicles", "Strategic", "Building"}, 0.1)
NDB.AddMap("gm_build_noxctf_bigdesert2", "noxious", "Big Desert", "A large, four team map in a desert. A mountain in the middle creates a natural border between bases.", "JetBoom - jetboom@yahoo.com", 16)
--NDB.AddMap("gm_build_noxctf_battlefield", "noxious", "Battlefield", "Two teams face off in a rather large battleground. Offense is an uphill battle.", "Chrispin", 8)
NDB.AddMap("gm_build_noxctf_mountain", "noxious", "Mountain", nil, nil, 8)
NDB.AddMap("gm_build_noxctf_oldremix", "noxious", "Old Remix")
NDB.AddMap("gm_build_noxctf_mountash", "noxious", "Mount. Ash", nil, nil, 8)
NDB.AddMap("noxctfnb_fortsofmadness", "noxious", "Forts of Madness", "Three teams with forts face off in a flat arena.", "JetBoom - jetboom@yahoo.com", 12)
--NDB.AddMap("gm_build_noxctf_longrun", "noxious", "Longrun", nil, nil, 12)
NDB.AddMap("gm_build_noxctf_river2", "noxious", "River")
--NDB.AddMap("gm_build_noxctf_longbridge2", "noxious", "Long Bridge", nil, nil, 8)
NDB.AddMap("noxctf_oldie", "noxious", "Oldie")
NDB.AddMap("gm_build_fortwars_ctf_4towers3", "noxious", "4 Towers High")
NDB.AddMap("noxctf_4towers", "noxious", "4 Towers", "A very simple and open map with four towers.\nTwo towers can be climbed to offer an advantage over anyone below.", "JetBoom - jetboom@yahoo.com")
NDB.AddMap("gm_build_noxctf_sanddunes2", "noxious", "Sand Dunes", nil, nil, 12)
NDB.AddMap("noxctfnb_broadside_v2", "noxious", "Broadside")
NDB.AddMap("gm_nobuild_noxctf_temple_v2", "noxious", "Temple")
NDB.AddMap("gm_build_noxctfnb_swamp", "noxious", "Swamp")
NDB.AddMap("noxctfnb_blizzard", "noxious", "Blizzard", nil, nil, 6)
NDB.AddMap("noxctf_deadlypass", "noxious", "Deadly Pass", nil, nil, 8)
NDB.AddMap("noxctfnb_bigdesert", "noxious", "Big Desert 2")
NDB.AddMap("noxctfnb_chamber", "noxious", "Chamber")
NDB.AddMap("noxtp_fortis", "noxious", "Fortis", "A small, straight-forward map made for intense, close-range fighting. Based off of a Zap DM map.", "Benjy - Benjy67k@gmail.com")
NDB.AddMap("noxctf_afterlife", "noxious", "Afterlife", nil, nil, 8)
NDB.AddMap("noxctfnb_parkv3", "noxious", "Park", "", "Monte Cristo - akselabt@mail.com")
NDB.AddMap("noxnb_bloodgulch", "noxious", "Bloodgulch")
NDB.AddMap("noxctf_toy_fort_elite", "noxious", "Toy Fort Elite")
NDB.AddMap("noxtp_battlefield2", "noxious", "Battlefield 2", "Two large military-like fortifications sit face-to-face while being heavily defended by bunkers, massive walls, and imposing Tesla towers in this strategy-focused map.", "Chrispin", 8)
NDB.AddMap("noxctf_valleycorners_v3", "noxious", "Valley Corners", "", "Testament Doom", 12)
NDB.AddMap("nox_urban2c", "noxious", "Urban")
NDB.AddMap("nox_lavawars_b1", "noxious", "Lava Wars", nil, nil, 12)
NDB.AddMap("noxnb_intersection_v2", "noxious", "Intersection", "This is a small map with hallways, teleporters, and a middle area. Based off of a Zap DM map.", "Benjy - Benjy67k@gmail.com")
NDB.AddMap("noxnb_streamline", "noxious", "Streamline")
NDB.AddMap("gm_bigcity", "noxious", "Big City", nil, nil, 8)
NDB.AddMap("df_frozenplanes_b4", "noxious", "Frozen Planes", nil, nil, 8)
NDB.AddMap("nox_photonic_v3", "noxious", "Photonic", nil, nil, 8)
NDB.AddMap("ctf_portalstorm", "noxious", "Portal Storm")
NDB.AddMap("ctf_2morforever", "noxious", "2Mor Forever")
NDB.AddMap("FY_SkyStep", "noxious", "Sky Step", "Fight to stay on the platforms or be sent to oblivion.", "Primus8")
NDB.AddMap("gm_noxarena_colosseum_v2", "noxious", "Colosseum", "A huge colosseum with plenty of pillars to be slammed in to.", "PainKiller")
NDB.AddMap("gm_aftermath_rc1a", "noxious", "Aftermath", "This post-apacolyptic land has suffered from the traumatic effects of World War 3.", "Skyhawk (Nanospork)", nil, nil, 6)
NDB.AddMap("gm_build_noxctf_canyon", "noxious", "Canyon", "This arena has a middle ground surrounded by a deadly pit.", "Kenny")
NDB.AddMap("noxctf_roundabout_v2", "noxious", "Roundabout", "The goals in this map are close but seperated by a huge wall.", "Testament Doom")
NDB.AddMap("noxctf_rampchaos_v5", "noxious", "Ramp Chaos", "The paths to the bases are windey and high up in this map.", "Unknown")
NDB.AddMap("noxtp_stadium", "noxious", "Stadium", "A big stadium in the middle of space with a low-G zone and plenty of room to fight.", "Benjy - Benjy67k@gmail.com")
NDB.AddMap("noxtp_techchambers_v2", "noxious", "Tech Chambers", "A big indoor arena with a strategic center control point.", "ReXeN")

NDB.AddMapType("noxctf", {"Vehicles", "Strategic", "Building"}, 0.1)
NDB.AddMap("gm_build_noxctf_bigdesert2", "noxctf", "Big Desert", "A large, four team map in a desert. A mountain in the middle creates a natural border between bases.", "JetBoom - jetboom@yahoo.com", 16)
NDB.AddMap("gm_build_noxctf_battlefield", "noxctf", "Battlefield", "Two teams face off in a rather large battleground. Offense is an uphill battle.", "Chrispin", 8)
NDB.AddMap("gm_build_noxctf_mountain", "noxctf", "Mountain", nil, nil, 8)
NDB.AddMap("gm_build_noxctf_oldremix", "noxctf", "Old Remix")
NDB.AddMap("gm_build_noxctf_mountash", "noxctf", "Mount. Ash", nil, nil, 8)
NDB.AddMap("noxctfnb_fortsofmadness", "noxctf", "Forts of Madness", "Three teams with forts face off in a flat arena.", "JetBoom - jetboom@yahoo.com", 12)
--NDB.AddMap("gm_build_noxctf_longrun", "noxctf", "Longrun", nil, nil, 12)
NDB.AddMap("gm_build_noxctf_river2", "noxctf", "River")
NDB.AddMap("gm_build_noxctf_longbridge2", "noxctf", "Long Bridge", nil, nil, 8)
NDB.AddMap("noxctf_oldie", "noxctf", "Oldie")
NDB.AddMap("gm_build_fortwars_ctf_4towers3", "noxctf", "4 Towers High")
NDB.AddMap("noxctf_4towers", "noxctf", "4 Towers", "A very simple and open map with four towers.\nTwo towers can be climbed to offer an advantage over anyone below.", "JetBoom - jetboom@yahoo.com")
NDB.AddMap("gm_build_noxctf_sanddunes2", "noxctf", "Sand Dunes", nil, nil, 12)
NDB.AddMap("noxctfnb_broadside_v2", "noxctf", "Broadside")
NDB.AddMap("gm_nobuild_noxctf_temple_v2", "noxctf", "Temple")
NDB.AddMap("gm_build_noxctfnb_swamp", "noxctf", "Swamp")
NDB.AddMap("noxctfnb_blizzard", "noxctf", "Blizzard", nil, nil, 6)
NDB.AddMap("noxctf_deadlypass", "noxctf", "Deadly Pass", nil, nil, 8)
NDB.AddMap("noxctfnb_bigdesert", "noxctf", "Big Desert 2")
NDB.AddMap("noxctfnb_chamber", "noxctf", "Chamber")
NDB.AddMap("noxtp_fortis", "noxctf", "Fortis")
NDB.AddMap("noxctf_afterlife", "noxctf", "Afterlife", nil, nil, 8)
NDB.AddMap("noxctfnb_parkv3", "noxctf", "Park", "", "Monte Cristo - akselabt@mail.com")
NDB.AddMap("noxnb_bloodgulch", "noxctf", "Bloodgulch")
NDB.AddMap("noxctf_toy_fort_elite", "noxctf", "Toy Fort Elite")
NDB.AddMap("noxtp_battlefield2", "noxctf", "Battlefield 2", "Two large military-like fortifications sit face-to-face while being heavily defended by bunkers, massive walls, and imposing Tesla towers in this strategy-focused map.", "Chrispin", 8)
NDB.AddMap("noxctf_valleycorners_v3", "noxctf", "Valley Corners", "", "Testament Doom", 12)
NDB.AddMap("nox_urban2c", "noxctf", "Urban")
NDB.AddMap("nox_lavawars_b1", "noxctf", "Lava Wars", nil, nil, 12)
NDB.AddMap("noxnb_intersection", "noxctf", "Intersection")
NDB.AddMap("noxnb_streamline", "noxctf", "Streamline")
NDB.AddMap("gm_bigcity", "noxctf", "Big City", nil, nil, 8)
NDB.AddMap("df_frozenplanes_b4", "noxctf", "Frozen Planes", nil, nil, 8)
NDB.AddMap("gm_aftermath_rc1a", "noxctf", "Aftermath", "A post-apacolyptic land that has suffered from the traumatic effects of World War 3.", "Skyhawk (Nanospork)")
NDB.AddMap("nox_photonic_v3", "noxctf", "Photonic", nil, nil, 8)
NDB.AddMap("noxtp_stadium", "noxctf", "Stadium", "A big stadium in the middle of space with plenty of room to fight.", "Benjy - Benjy67k@gmail.com")
NDB.AddMap("noxtp_techchambers_v2", "noxctf", "Tech Chambers", "A big indoor arena with a strategic center control point.", "ReXeN")

NDB.AddMapType("zombiesurvival", {"Camping", "Progressive", "Barricading", "Scary", "Dark", "House Map"}, 0.04)
NDB.AddMap("zs_noir", "zombiesurvival", "Noir")
NDB.AddMap("zm_fury_v2", "zombiesurvival", "Fury")
NDB.AddMap("cs_crackhousenightbeta4", "zombiesurvival", "Crackhouse")
NDB.AddMap("zs_forestofthedamned_final", "zombiesurvival", "Forest of the Damned")
NDB.AddMap("zm_opt_cityholdout_v1", "zombiesurvival", "City Holdout")
NDB.AddMap("zs_woodhouse_rain", "zombiesurvival", "Wooden House in the Rain")
NDB.AddMap("zm_darkhouse_ocxv3", "zombiesurvival", "Dark House")
NDB.AddMap("zs_raunchierhouse_v2", "zombiesurvival", "Raunchier House")
NDB.AddMap("zs_nastiesthouse_v2", "zombiesurvival", "Nastiest House")
NDB.AddMap("zs_nastierhouse", "zombiesurvival", "Nastier House")
NDB.AddMap("zs_VillageHouse", "zombiesurvival", "Village House")
NDB.AddMap("fy_houses_final", "zombiesurvival", "Houses")
NDB.AddMap("zs_imashouse_final", "zombiesurvival", "Imas House")
NDB.AddMap("zs_urbandecay2", "zombiesurvival", "Urban Decay")
NDB.AddMap("de_alivemetal", "zombiesurvival", "Alive Metal")
NDB.AddMap("zs_cabin_v2", "zombiesurvival", "Cabin")
NDB.AddMap("cs_twilight", "zombiesurvival", "Twilight")
NDB.AddMap("de_junitown_v3", "zombiesurvival", "Junitown")
NDB.AddMap("zs_buntshot", "zombiesurvival", "Buntshot")
NDB.AddMap("zs_village_v2", "zombiesurvival", "Village", "Humans hold out in a small village.", "Unknown\nEdited by Zinco - funkyringtone@hotmail.com")
NDB.AddMap("zs_dracula", "zombiesurvival", "Dracula", "Survivors take refuge in a large house only to find out that it was owned by Count Dracula.", "Unknown\nEdited by Zinco - funkyringtone@hotmail.com")
NDB.AddMap("zs_house_outbreak_b2", "zombiesurvival", "House Outbreak")
NDB.AddMap("cs_urban", "zombiesurvival", "Urban")
NDB.AddMap("zs_the_pub_final", "zombiesurvival", "The Pub", "Humans hold out in a road-side pub and gas station.", "Unknown\nEdited by Zinco - funkyringtone@hotmail.com")
NDB.AddMap("zs_ravenholm_v4", "zombiesurvival", "Ravenholm")
NDB.AddMap("zs_shithole_v3", "zombiesurvival", "Shithole", "The humans have found a worn down house surrounded by rubble and decide it's a good place to take shelter.\nLittle do they know that the zombie horde is already closing in.", "SuperHebbe - superhebbe@online.no\nConverted by Benjy - Benjy67k@gmail.com\nEdited by Zinco - ")
NDB.AddMap("zs_fortress", "zombiesurvival", "Fortress", "Some survivors have taken shelter in an abandoned lookout spot somewhere in a large desert\nThe zombie horde is slowly approaching behind the dunes.", "SuperHebbe - superhebbe@online.no\nConverted by Benjy - Benjy67k@gmail.com")
NDB.AddMap("zs_plague_v2", "zombiesurvival", "Plague")
NDB.AddMap("zs_port_v4", "zombiesurvival", "Port")
--NDB.AddMap("zs_fen", "zombiesurvival", "Fen")
--NDB.AddMap("zs_lou_sadday", "zombiesurvival", "Lou Sadday")
--NDB.AddMap("de_castle_b4", "zombiesurvival", "Castle")
NDB.AddMap("cs_market_fix", "zombiesurvival", "Market")
NDB.AddMap("zs_Alexg_Motel_v2", "zombiesurvival", "AlexG Motel", "", "Alexg - webplay@libero.it")
NDB.AddMap("zs_stormier_v1", "zombiesurvival", "Stormier", "", "Charles G - charles.green.cs@gmail.com")
NDB.AddMap("zs_storm_v1", "zombiesurvival", "Storm", "", "Charles G - charles.green.cs@gmail.com")
-- NDB.AddMap("de_residentevil", "zombiesurvival", "Resident Evil")
NDB.AddMap("Abandonned_Building", "zombiesurvival", "Abandoned Building")
NDB.AddMap("zs_Farmhouse", "zombiesurvival", "Farm House", "", "Alexg - webplay@libero.it")
NDB.AddMap("zs_forgotten_city_enclosed", "zombiesurvival", "Forgotten City", "", "Moonshine - jkhaykin@yahoo.com")
NDB.AddMap("zs_jail_v1", "zombiesurvival", "Jail", "", "Edward Fox - roterfuchss@hotmail.com")
NDB.AddMap("zs_vulture_final_d", "zombiesurvival", "Vulture", "The humans have found an abandoned scientist settlement and decide to take shelter thinking that the height will protect them, little do they know that the zombie horde are already here.", "SuperHebbe - superhebbe@online.no\nConverted by Benjy - Benjy67k@gmail.com")
NDB.AddMap("cs_abandonedoffice_v3", "zombiesurvival", "Abandoned Office")
NDB.AddMap("zs_cold_final", "zombiesurvival", "Cold")
NDB.AddMap("zs_winterforest", "zombiesurvival", "Winter Forest")
NDB.AddMap("zs_mall_final_opt", "zombiesurvival", "Mall")
NDB.AddMap("zs_raunchiesthouse_v3", "zombiesurvival", "Raunchiest House")
NDB.AddMap("zs_termites_final", "zombiesurvival", "Termites")
NDB.AddMap("zs_deadhouse_b4", "zombiesurvival", "Dead House")
NDB.AddMap("zs_fireforest_final", "zombiesurvival", "Fire Forest", "If the zombies don't get you, the fire will.", "Eisiger")
NDB.AddMap("zs_overran_city_final", "zombiesurvival", "Overran City")
NDB.AddMap("cs_gasstation_d", "zombiesurvival", "Gas Station")
NDB.AddMap("zs_street_kuopio_v2_ce", "zombiesurvival", "Street Kupio", 10)
NDB.AddMap("zs_sector4f", "zombiesurvival", "Sector 4", "", "Extreme56 - rknisley@charter.net")
--NDB.AddMap("zs_tunnels_fixed_v2", "zombiesurvival", "Tunnels")
--NDB.AddMap("zs_town_b1_7", "zombiesurvival", "Town")
NDB.AddMap("zs_sewers_final", "zombiesurvival", "Sewers")
NDB.AddMap("zs_overandunderground_v2", "zombiesurvival", "Over and Underground")
NDB.AddMap("zs_uglyfort_v2", "zombiesurvival", "Ugly Fort")
--NDB.AddMap("zs_xeno_b2", "zombiesurvival", "Xeno")
NDB.AddMap("zs_zombienowhere_v3", "zombiesurvival", "No Where")
NDB.AddMap("zs_warehousefacility_v3", "zombiesurvival", "Warehouse Facility")
NDB.AddMap("cs_1_home_v2", "zombiesurvival", "1 Home")
--NDB.AddMap("zs_skyscraper_v2", "zombiesurvival", "Skyscraper")
NDB.AddMap("zs_reactor15_b3", "zombiesurvival", "Reactor 15", "You are a part of HazMat team sent to find out what happened to Reactor 15.\nOnce inside you find the chamber is flooded with radiation, and the crew have turned into zombies.\nLeft behind by the rest of your team, you must try and survive long enough get to the exit on the top floor, but will you be able to get out?", "Kris2456 - cwalkris@hotmail.com")
NDB.AddMap("zs_blastdoors_fixed", "zombiesurvival", "Blast Doors", "Humans hold out in a small section of a water treatment complex.", "Unknown\nEdited by Zinco - funkyringtone@hotmail.com")
--NDB.AddMap("zs_modest_neighborhood", "zombiesurvival", "Modest Neighborhood")
NDB.AddMap("zs_hamlet_ce", "zombiesurvival", "Hamlet CE", "Try to survive in a hamlet. Has a few houses, a treehouse, a Winchester Pub, and of course a grave yard!", "DaMaN - Da_HL_MaN@yahoo.ca\nConverted by JetBoom - jetboom@yahoo.com\nEdited by Zinco - funkyringtone@hotmail.com", 8)
--NDB.AddMap("zs_mystery", "zombiesurvival", "Mystery")
-- NDB.AddMap("de_school", "zombiesurvival", "School")
NDB.AddMap("zs_darkvilla", "zombiesurvival", "Dark Villa")
--NDB.AddMap("zs_viruslabs_remake_b1_2", "zombiesurvival", "Virus Labs")
NDB.AddMap("zs_apartmentruins_fixed", "zombiesurvival", "Apartment Ruins", "The ruins of a long-abandoned apartment building host the location of your next stand.", "M-Zoner\nEdited by Zinco - funkyringtone@hotmail.com")
--NDB.AddMap("zm_zerbes_corruption", "zombiesurvival", "Zerbes Corruption")
NDB.AddMap("zm_distant", "zombiesurvival", "Distant")
--NDB.AddMap("zm_siberia_v2", "zombiesurvival", "Siberia")
--NDB.AddMap("zm_city19_intel", "zombiesurvival", "City 19")
--NDB.AddMap("zs_the_river_final", "zombiesurvival", "The River")
NDB.AddMap("zs_nastyhouse_opt2", "zombiesurvival", "Nasty House")
NDB.AddMap("zs_outpost_gold", "zombiesurvival", "Outpost")
NDB.AddMap("zs_darkvilla_v2", "zombiesurvival", "Dark Villa 2")
NDB.AddMap("zs_fortis_final", "zombiesurvival", "Fortis")
NDB.AddMap("zs_fearhouse_v3", "zombiesurvival", "Fear House")
NDB.AddMap("zs_subversive_v2_fix", "zombiesurvival", "Subversive 2", "The remaining survivors have been pushed further in to the tunnels by the zombie horde.", "Stelk - develope@abv.bg")
NDB.AddMap("zs_infected_city_b1", "zombiesurvival", "Infected City", 8)
--NDB.AddMap("zs_the_citadel", "zombiesurvival", "The Citadel", "Survivors have held up in a Combine Citadel only to find out that it has been long-since overrun with the undead.", "Unknown")
NDB.AddMap("zs_placid_final", "zombiesurvival", "Placid", 8)
NDB.AddMap("zs_subversive_v1", "zombiesurvival", "Subversive", "A large breakout of the undead has pushed you and a group of survivors in to an urban sewer and tunnel system.", "Stelk - develope@abv.bg")
NDB.AddMap("zs_subversive_part3_fix", "zombiesurvival", "Subversive 3", "The survivors go further in to the tunnels.", "Stelk - develope@abv.bg")
--NDB.AddMap("zs_ascent_v7", "zombiesurvival", "Ascent", "God this is a terrible map, stop voting for it.", "Zinco - funkyringtone@hotmail.com")
NDB.AddMap("zs_Lost_Coast_House", "zombiesurvival", "Lost Coast House", "A group of survivors take shelter in a house by the coast and prepare for the upcoming onslaught.", "Alexg - webplay@libero.it")
--NDB.AddMap("zs_apple_seed_v3", "zombiesurvival", "Apple Seed", "It's a snowy day and humans are trapped in a large house complex while zombies come from the walls.", "Kirumi\nConverted by Zinco - funkyringtone@hotmail.com")
NDB.AddMap("zs_abandoned_motel_opt3", "zombiesurvival", "Abandoned Motel", "Escaping from the undead, a group of survivors have made it through a tunnel and discovered a ransacked motel.\nDeciding to seal the tunnel and look for supplies, they discover too late that zombies are rushing in from another tunnel.\nUnable to escape, they take refuge inside the damaged motel.", "Unknown\nEdited by Zinco - funkyringtone@hotmail.com")
--NDB.AddMap("zs_defection_v4", "zombiesurvival", "Defection")
NDB.AddMap("zs_houseruins", "zombiesurvival", "House Ruins", "Humans take on the undead in the ruins of a house.", "Unknown\nConverted by Zinco - funkyringtone@hotmail.com")
--NDB.AddMap("zs_lost_isle_v3", "zombiesurvival", "Lost Isle", "The humans try to prepare a barricade using the crane in this abandoned harbour.\nFeatures a real working crane.", "Unknown\nConverted by Zinco - funkyringtone@hotmail.com")
NDB.AddMap("zs_nasty_headquarters", "zombiesurvival", "Nasty Headquarters", "The remaining workers of Nasty Headquarters try to fight off their own mistake.", "Zinco - funkyringtone@hotmail.com")
NDB.AddMap("zs_junkyard", "zombiesurvival", "Junk Yard", "Survivors have met up in a junk yard and the undead are closing in fast.", "Stelk - develope@abv.bg")
NDB.AddMap("zs_hellarch", "zombiesurvival", "Hellarch", "Another day, another house to hold up in.", "Unknown\nEdited by Zinco - funkyringtone@hotmail.com")
NDB.AddMap("zs_barren", "zombiesurvival", "Barren", "The survivors try to hold out in an abandoned town.", "Stelk - develope@abv.bg")
--NDB.AddMap("zs_assassins_hideout_v1_fix", "zombiesurvival", "Assassin's Hideout", "An ex-hideout for an assassin. It has underground tunnels and rooms where he was hiding in his lifetime. When the zombies were rushing the whole city, the humans found the hideout and tried to survive there.", "O_o - jokespeaker@hotmail.de")
NDB.AddMap("zs_subversive_part4", "zombiesurvival", "Subversive 4", "Survive in an underground complex.", "Stelk - develope@abv.bg")
--NDB.AddMap("zs_aeolus_v3", "zombiesurvival", "Aeolus Complex", "Welcome to Port Aeolus. Please stay seated until the tram arrives in the station.", "Little Nemo - austin_odyssey@yahoo.com", 20)
NDB.AddMap("zm_westwood_final", "zombiesurvival", "Westwood", "An ol' fashioned zombie outbreak.", "Unknown")
NDB.AddMap("zm_tag_sealed", "zombiesurvival", "Tag Sealed", "An outbreak occurs in an industrial section of a town.", "Unknown")
NDB.AddMap("zm_poon_institute_b1", "zombiesurvival", "Poon Institute", "Some office workers try to hold off a zombie invasion.", "Unknown")
--NDB.AddMap("zm_hellz_silent_hill", "zombiesurvival", "Hellz Silent Hill", "Silent Hill!", "Unknown")
NDB.AddMap("zm_onadega_v2a", "zombiesurvival", "Onadega", "Some survivors have taken shelter in a lone ranch house.", "Unknown")
NDB.AddMap("zm_ghs_abdandon_mall", "zombiesurvival", "Abdandon Mall", "Survivors have held up in the Abdandon Mall and zombies are right outside.", "Unknown", 18)
NDB.AddMap("zm_hauntedmanor_v1", "zombiesurvival", "Haunted Manor", "The zombies in the attic are the least of your worries in this house from hell.", "Unknown", 22)
NDB.AddMap("zs_splinter_v4", "zombiesurvival", "Splinter", "A very simple map with four buildings and multiple hold up areas.", "Unknown")
NDB.AddMap("zs_chaste_part1", "zombiesurvival", "Chaste", "An experiment gone wrong has escaped its holding cell and went on a rampage. A few months later a clean up team is called to the area to investigate.", "warbasher")
NDB.AddMap("zs_asylum_v6", "zombiesurvival", "Asylum", "This insane asylum has been shut down for years. After the outbreak a group of survivors decided it would be a good idea to hold up in the complex.", "Unknown original author\nLatest version by Swedishtiger")
NDB.AddMap("zs_plaza", "zombiesurvival", "Plaza", "This mall has an automated security system and it's on the fritz. It's opening stores after they're closed! One of the construction workers probably damaged it, so it's best to steer clear.", "Isonoe - bryan.bonnici@gmail.com")
NDB.AddMap("rd_zombocity_f", "zombiesurvival", "Zombo City", "A huge city has come under siege by zombies!", "Unknown")
NDB.AddMap("gm_highstreet", "zombiesurvival", "High Street", "Hold out against zombies in a night club.", "Unknown")

NDB.AddMapType("noxdm", {}, 0.25)
NDB.AddMap("dm_killbox_final", "noxdm", "Kill Box")
NDB.AddMap("dm_peachs_castle", "noxdm", "Peach's Castle")
NDB.AddMap("dm_epigram_nofx", "noxdm", "Epigram")
NDB.AddMap("dm_snowblind", "noxdm", "Snowblind")
NDB.AddMap("usa_warehouse", "noxdm", "USA Warehouse")
NDB.AddMap("dm_lostvillage", "noxdm", "Lost Village")
NDB.AddMap("boot_camp", "noxdm", "Boot Camp")
NDB.AddMap("dm_lostrock", "noxdm", "Lost Rock")
NDB.AddMap("dm_fragyard", "noxdm", "Fragyard")

NDB.AddMapType("noxarena", {"Symetric", "Flat"}, 0.25)
NDB.AddMap("gm_noxarena_colosseum_v2", "noxarena", "Colosseum", "A huge colosseum with plenty of pillars to be slammed in to.", "PainKiller")
NDB.AddMap("gm_noxarena_hell_b2", "noxarena", "Hell")
NDB.AddMap("gm_noxarena_cage", "noxarena", "Cage")
NDB.AddMap("gm_noxarena_castle", "noxarena", "Castle")
NDB.AddMap("gm_noxarena_darkarena", "noxarena", "Dark Arena")
NDB.AddMap("gm_noxarena_stonearena_mac2", "noxarena", "Stone Arena")
NDB.AddMap("gm_noxarena_titans_b3", "noxarena", "Titans")
NDB.AddMap("gm_noxarena_temple", "noxarena", "Temple", "An indoor map centered around a temple.", "Benjy - Benjy67k@gmail.com")

NDB.AddMapType("buggyracer", {}, 0.25)
NDB.AddMap("br2_crisscrosscrash", "buggyracer", "Criss-Cross-Crash")
NDB.AddMap("br2_pipedream", "buggyracer", "Pipe Dream")
NDB.AddMap("br2_lake", "buggyracer", "Lake")
NDB.AddMap("br2_bulldog_v3", "buggyracer", "Bulldog")
NDB.AddMap("br2_citadelsv3", "buggyracer", "Citadels")

NDB.AddMapType("marioboxes", {"Aerial", "Grappling", "Dungeon", "Overworld", "Open", "Enclosed", "Frantic", "Traps", "Guns", "Swords", "Explosives", "Super Weapons"}, 0.1)
NDB.AddMap("nox2d_toonland", "marioboxes", "Toon Land", "", "Testament Doom")
NDB.AddMap("nox2d_newcastle2newcastleV2", "marioboxes", "Castle 2 Castle")
NDB.AddMap("nox2d_smb1", "marioboxes", "SMB1")
NDB.AddMap("nox2d_palace_v2", "marioboxes", "Palace")
NDB.AddMap("nox2d_marioworld_v2", "marioboxes", "Mario World")
--NDB.AddMap("nox2d_grappleworld", "marioboxes", "Grapple World")
NDB.AddMap("nox2d_night_blocks_v2", "marioboxes", "Night Blocks")
NDB.AddMap("nox2d_marionight_v4", "marioboxes", "Mario Night")
NDB.AddMap("nox2d_castlev2", "marioboxes", "Castle")
NDB.AddMap("nox2d_boo_mansion_v4", "marioboxes", "Boo Mansion")
NDB.AddMap("nox2d_smb3_world1_v3", "marioboxes", "SMB3 World 1")
NDB.AddMap("nox2d_mariocastle_v2", "marioboxes", "Mario Castle")
NDB.AddMap("nox2d_smb2_world1_v2", "marioboxes", "SMB2 World 1")
NDB.AddMap("nox2d_smw_yoshisisland_v4", "marioboxes", "Yoshi's Island", "Fight in the background and foreground of this intense water map.", "Eisiger\nEdited by Charles G - charles.green.cs@gmail.com")
NDB.AddMap("nox2d_smb1_world1", "marioboxes", "SMB1 World 1")
NDB.AddMap("nox2d_smb3_world2_v2", "marioboxes", "SMB3 World 2")
NDB.AddMap("nox2d_n_lvl1", "marioboxes", "N+")
NDB.AddMap("nox2d_smb1_underground_v2-2", "marioboxes", "SMB1 Underground")
NDB.AddMap("nox2d_smb1_world2_v2", "marioboxes", "SMB1 World 2", "", "Charles G - charles.green.cs@gmail.com")
NDB.AddMap("nox2d_smbw_ww1_v2", "marioboxes", "SMB Water World", "Almost the entire level is underwater. Use the fan in the middle to quickly win the match!", "Modestyiswimpy - Hugh@eriegel.com")
NDB.AddMap("nox2d_dreamland_v7", "marioboxes", "Dream Land", "This level is full of things just waiting to destroy you. Use the turrets and door switch to make sure no one can get your flag!", "JaSeN - jasen666@hotmail.com")
NDB.AddMap("nox2d_smw_yoshishouse_v3", "marioboxes", "Yoshi's House", "Another incredible map from Charles G. Fight for both the flag and the Yoshi in the middle!", "Charles G - charles.green.cs@gmail.com")
NDB.AddMap("nox2d_castlevania3", "marioboxes", "Castlevania", "Capturing is very tricky on this map. Use the stairs for a technical advantage.", "Testament Doom")
NDB.AddMap("nox2d_kid_icarus_fixed", "marioboxes", "Kid Icarus", "Grappling hooks are always available. Find the Jet Pack for a distinct advantage!", "Testament Doom")
NDB.AddMap("nox2d_smw_chocolateisland_v2", "marioboxes", "Chocolate Island", "Two castles battle in this massive and amazingly well-made map. Destroy the enemy front door for a strategic advantage!", "Charles G - charles.green.cs@gmail.com")
NDB.AddMap("nox2d_castle2castle", "marioboxes", "Castle 2 Castle Classic", "The very first Mario Boxes map from GMod9. Basic weapons are readily available but the more powerful ones can only be found in the middle of the map!", "JetBoom - jetboom@yahoo.com\nRemade by Charles G - charles.green.cs@gmail.com")
NDB.AddMap("smb3_grassland", "marioboxes", "Grass Land", "A medium-sized level under a blazing sun - which you can control!", "Charles G - charles.green.cs@gmail.com")

NDB.AddMapType("awesomestrike", {}, 0.2)
NDB.AddMap("de_tides", "awesomestrike", "Tides (DE)")
NDB.AddMap("de_train", "awesomestrike", "Train (DE)")
NDB.AddMap("de_dust", "awesomestrike", "Dust (DE)")
NDB.AddMap("de_dust2", "awesomestrike", "Dust2 (DE)")
NDB.AddMap("cs_office", "awesomestrike", "Office (DE)")
NDB.AddMap("de_alivemetal", "awesomestrike", "Alive Metal (DE)")
NDB.AddMap("cs_assault", "awesomestrike", "Assault (CS)")
NDB.AddMap("cs_compound", "awesomestrike", "Compound (CS)")
NDB.AddMap("cs_italy", "awesomestrike", "Italy (CS)")
NDB.AddMap("cs_havana", "awesomestrike", "Havana (CS)")
NDB.AddMap("de_inferno", "awesomestrike", "Inferno (DE)")
NDB.AddMap("de_nuke", "awesomestrike", "Nuke (DE)")
NDB.AddMap("de_prodigy", "awesomestrike", "Prodigy (DE)")
NDB.AddMap("de_port", "awesomestrike", "Port (DE)")
NDB.AddMap("de_piranesi", "awesomestrike", "Piranesi (DE)")
NDB.AddMap("de_chateau", "awesomestrike", "Chateau (DE)")
NDB.AddMap("de_cbble", "awesomestrike", "Cbble (DE)")
NDB.AddMap("de_aztec", "awesomestrike", "Aztec (DE)")
NDB.AddMap("fy_houses_final", "awesomestrike", "Houses (FY)")
NDB.AddMap("FY_SkyStep", "awesomestrike", "Sky Step (FY)")

NDB.AddMapType("darkrp")
NDB.AddMap("rp_silenthill", "darkrp", "Silent Hill", "A large map set in Silent Hill. Tons of housing and stores. Great for gang wars and stuff.", "Sgt.Sickness")
NDB.AddMap("RP_OMGCity_Final", "darkrp", "OMG City", "Small town map. Contains a decent number of things to see and do.", "Slambob - the_guy_with_pie@hotmail.com")
NDB.AddMap("RP_OMGCity_Night", "darkrp", "OMG City at Night", "Night version of OMG City", "Slambob - the_guy_with_pie@hotmail.com")
NDB.AddMap("rp_tb_city45_v02n", "darkrp", "City 45", "A very big map with places for everyone.", "TNB")

function GetNonExistantMaps()
	for gamename, gametab in pairs(NDB.MapList) do
		for i, maptab in pairs(gametab) do
			if not file.Exists("../maps/"..maptab[1]..".bsp") then
				print(maptab[1])
			end
		end
	end
end

local notdm = {"TDM"}
NDB.DisabledGameTypes = {}
NDB.DisabledGameTypes["topgun_aircraftcarrier"] = {"HTF", "TDM"}
NDB.DisabledGameTypes["noxctfnb_fortis"] = {"KOTH"}
NDB.DisabledGameTypes["nox_battlefield2"] = notdm
NDB.DisabledGameTypes["gm_build_noxctf_bigdesert2"] = notdm
NDB.DisabledGameTypes["gm_build_noxctf_battlefield"] = notdm
NDB.DisabledGameTypes["gm_build_noxctf_mountain"] = notdm
NDB.DisabledGameTypes["gm_build_noxctf_mountash"] = notdm
NDB.DisabledGameTypes["gm_build_noxctf_longrun"] = notdm
NDB.DisabledGameTypes["gm_build_noxctf_longbridge2"] = notdm
NDB.DisabledGameTypes["gm_build_noxctf_sanddunes2"] = notdm
NDB.DisabledGameTypes["gm_nobuild_noxctf_temple_v2"] = NDB.DisabledGameTypes["noxctfnb_fortis"]
NDB.DisabledGameTypes["gm_nobuild_noxctf_raindance"] = notdm
NDB.DisabledGameTypes["noxctfnb_blizzard"] = notdm
NDB.DisabledGameTypes["noxctf_deadlypass"] = notdm
NDB.DisabledGameTypes["noxctf_chaoscanyon3a"] = notdm
NDB.DisabledGameTypes["noxctfnb_bigdesert"] = notdm
NDB.DisabledGameTypes["gm_blockfort_2007_pr"] = NDB.DisabledGameTypes["noxctfnb_fortis"]
NDB.DisabledGameTypes["noxctf_rampchaos_v5"] = notdm
NDB.DisabledGameTypes["noxctfnb_rollercoaster"] = notdm
NDB.DisabledGameTypes["noxctf_afterlife"] = notdm
NDB.DisabledGameTypes["noxctfnb_parkv3"] = NDB.DisabledGameTypes["noxctfnb_fortis"]
NDB.DisabledGameTypes["noxnb_intersection"] = NDB.DisabledGameTypes["noxctfnb_fortis"]
notdm = nil

collectgarbage("collect")
