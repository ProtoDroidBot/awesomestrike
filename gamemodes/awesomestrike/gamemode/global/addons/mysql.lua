if CLIENT then return end

function mysql_threaded_query(query, callback, ...)
	if tmysql then
		if callback then
			local args = arg
			tmysql.query(query, function(tab, stat, err)
				if stat then
					callback(tab, args)
				end
			end)
		else
			tmysql.query(query)
		end
	end
end

require("tmysql")

hook.Add("InitPostEntity", "mysqlcheck", function()
	if not tmysql then return end

	tmysql.initialize("127.0.0.1", "root", "QWioSqFJywBeQwVn0N21309MQweqphoenxXp", "nox", 3306, 3, 2)
end)

local function QUERY_Dupes(result, arguments)
	local steamids = {}
	local dupes = {}

	print(result)
	for i=1, #result do
		local id = result[i][1]
		if steamids[id] then dupes[id] = true end
		steamids[id] = true
	end

	for i in pairs(dupes) do
		mysql_threaded_query("DELETE FROM noxplayers WHERE SteamID = '"..i.."'")
	end
end

function DropDuplicates()
	mysql_threaded_query("SELECT SteamID FROM noxplayers", QUERY_Dupes)
end
