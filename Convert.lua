local Classes = {}

local trueList = {}
for Class, _ in pairs(Classes) do
    trueList[Class] = true
end

local function dumpList(tbl)
    local Lines = {"local Classes = {"}
    for Class, _ in pairs(tbl) do
        table.insert(Lines, string.format("    %s = true,", Class))
    end
    table.insert(Lines, "}")
    return table.concat(Lines, "\n")
end

print(dumpList(trueList))
