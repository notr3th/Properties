local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local IgnoreList = {
    "AdvancedDragger","Dragger","TestService",
    "VirtualInputManager","ProximityPromptService",
    "HeightmapImporterService","MemoryStoreService",
    "Clouds","DebuggerWatch","PluginAction",
    "GetTextBoundsParams"
}

local Ignore = {}
for _, Class in ipairs(IgnoreList) do
    Ignore[Class] = true
end

local function fetchJSON(Url)
    for i = 1,3 do
        local Success, Err = pcall(HttpService.GetAsync, HttpService, Url)
        if Success then
            return HttpService:JSONDecode(Err)
        end
        task.wait(1)
    end
    error("Failed to GET " .. Url)
end

local Version = HttpService:GetAsync("http://setup.roproxy.com/versionQTStudio")
local API = string.format("http://setup.roproxy.com/%s-API-Dump.json", Version)
local dumpData = fetchJSON(API)

local classList = {}
for _, Class in ipairs(dumpData.Classes or {}) do
    local notCreatable = Class.Tags and Class.Tags.NotCreatable or Class.NotCreatable
    if not notCreatable then
        table.insert(classList, Class.Name)
    end
end

local Container = Instance.new("Part")
Container.Name   = "Spawned Items"
Container.Parent = workspace

local Humanoid = Instance.new("Humanoid")
Humanoid.Parent = Container

local MeshPart = Instance.new("MeshPart")
MeshPart.Parent = Container

for _, Class in ipairs(classList) do
    if not Ignore[Class] then
        local Success, Instance = pcall(Instance.new, Class)
        if Success and Instance then
            local Success, Err = pcall(function()
                if Class == "Animator" then
                    Instance.Parent = Humanoid
                elseif Class == "SurfaceAppearance" or Class == "WrapLayer" or Class == "WrapTarget" then
                    Instance.Parent = MeshPart
                else
                    Instance.Parent = Container
                end
            end)
            if not Success then
                warn(Class .. ": " .. Err)
            end
        end
    end
end

print(("Spawned %d classes."):format(#classList))
