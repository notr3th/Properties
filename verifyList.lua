local Classes = {}
local foundClasses = {}

for _, Instance in ipairs(workspace["Spawned Items"]:GetDescendants()) do
    local className = Instance.ClassName
    foundClasses[className] = true

    if not Classes[className] then
        print("Not in list:", className)
    else
        instance:Destroy()
    end
end

for className, _ in pairs(Classes) do
    if not foundClasses[className] then
        print("Not in workspace:", className)
    end
end
