local Classes = {}
local trueList = {}

local function dumpList(tbl)
    local Lines = {"local Classes = {"}
    for Class, _ in pairs(tbl) do
        table.insert(Lines, string.format("    %s = true,", Class))
    end
    table.insert(Lines, "}")
    return table.concat(Lines, "\n")
end

for Class, _ in pairs(Classes) do
    trueList[Class] = true
end

print(dumpList(trueList))
