if SERVER then
	AddCSLuaFile(NDB_ADDON_NAME)
	return
end

hook.Add("Think", "GetGamemodeName", function()
	GAMEMODE_NAME = GetConVarString("sv_gamemode")

	if GAMEMODE_NAME ~= "base" then
		hook.Remove("Think", "GetGamemodeName")
	end
end)
