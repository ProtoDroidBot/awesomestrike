if CLIENT then return end

function NDB.GiveAward(pl, str)
	if not (pl:IsPlayer() and pl:IsConnected()) then return end

	table.insert(pl.Awards, str)
	PrintMessageAll(HUD_PRINTTALK, "<red>"..pl:Name().."</red> has been given the <red>"..string.upper(string.Replace(str, "_", " ")).."</red> award!! <awardicon="..str..",small>")

	LOGCONTENTS = LOGCONTENTS.."<"..pl:SteamID().."> "..pl:Name().." has been given the <"..str.."> award.\n"

	local effectdata = EffectData()
		effectdata:SetEntity(pl)
		effectdata:SetOrigin(pl:EyePos())
	util.Effect("noxgetaward", effectdata, true, true)

	NDB.SaveInfo(pl)
end

function createawardvmts()
	file.CreateDir("awards")
	for _, filename in pairs(file.Find("../materials/noxawards/*.vtf")) do
		local subf = string.sub(filename, 1, -5)
		file.Write("awards/"..subf..".txt", [["UnlitGeneric"
{
"$basetexture" "noxawards/]]..subf..[["
"$vertexcolor" 1
"$ignorez" 1
"$nolod" 1
"$nomip" 1
"$nocompress" 1
"$translucent" 1
}]])
	end
end

local awds = {}

concommand.Add("_getaward", function(sender, command, arguments)
	local id = arguments[1]
	if awds[id] and awds[id](sender, command, arguments) then
		NDB.GiveAward(sender, id)
	end
end)
