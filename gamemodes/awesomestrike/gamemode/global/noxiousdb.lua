AddCSLuaFile("cl_noxiousdb.lua")
AddCSLuaFile("maplist.lua")

NDB = {}

include("core.lua")
include("maplist.lua")

--timer.Create("ForceHeartbeat", 15, 0, RunConsoleCommand, "heartbeat")

NDB.LoadedAddons = {}
NDB.LoadedExtensions = {}

for _, name in pairs(file.Find("../gamemodes/"..GetConVarString("sv_defaultgamemode").."/gamemode/global/extensions/*.lua")) do
	NDB_EXTENSION_NAME = name
	include("extensions/"..name)
	table.insert(NDB.LoadedExtensions, name)
end

for _, name in pairs(file.Find("../gamemodes/"..GetConVarString("sv_defaultgamemode").."/gamemode/global/addons/*.lua")) do
	NDB_ADDON_NAME = name
	include("addons/"..name)
	table.insert(NDB.LoadedAddons, name)
end

NDB_ADDON_NAME = nil
NDB_EXTENSION_NAME = nil

local tags = string.Explode(",",(GetConVarString("sv_tags") or ""))
for i,tag in ipairs(tags) do
	if tag:find("noxiousnet") then table.remove(tags,i) end
end
table.insert(tags, "noxiousnet")
table.sort(tags)
RunConsoleCommand("sv_tags", table.concat(tags, ","))
tags = nil

require("gamedescription")
