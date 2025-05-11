local HttpService = game:GetService("HttpService")

local function GetClasses()
	local Version = HttpService:GetAsync("https://s3.amazonaws.com/setup.roblox.com/versionQTStudio")
	local Dump = HttpService:GetAsync("https://s3.amazonaws.com/setup.roblox.com/" .. Version .. "-API-Dump.json")
	local Data = HttpService:JSONDecode(Dump)

	local Classes = {}
	for _, Class in pairs(Data.Classes) do
		table.insert(Classes, Class.Name)
	end
	table.sort(Classes)
	return Classes
end

local List = GetClasses()
print("Total Classes:", #List)
print(table.concat(List, "\n"))
