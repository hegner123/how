
Fmt = {};

 function Fmt.deep_compare(t1, t2)
    -- If both are not tables, directly compare
    if type(t1) ~= "table" or type(t2) ~= "table" then
        return t1 == t2
    end

    -- Check if both tables have the same keys and values
    for k, v in pairs(t1) do
        if not Fmt.deep_compare(v, t2[k]) then
            return false
        end
    end

    -- Check if t2 has extra keys that t1 doesn't have
    for k in pairs(t2) do
        if t1[k] == nil then
            return false
        end
    end

    return true
end

function Fmt.logToFile(filename, message)
    local file = io.open(filename, "a")
    if not file then
        print("Error opening file:", filename)
        return
    end

    file:write(message .. "\n")
    file:close()
end

function Fmt.showrow(cols, name, values)
    for i = 0, cols do
        local statement = name[i] + " " + values[i]
        Fmt.logToFile("log.log", statement)
    end
    return 0
end

function Fmt.tableToString(tbl, indent)
    indent = indent or 0
    local result = "{\n"
    local separator = ""
    local indentString = string.rep("  ", indent)

    for key, value in pairs(tbl) do
        result = result .. indentString .. separator .. tostring(key) .. " : "
        if type(value) == "table" then
            result = result .. Fmt.tableToString(value, indent + 1)
        else
            result = result .. tostring(value)
        end
        separator = ",\n"
    end

    result = result .. "\n" .. string.rep("  ", indent - 1) .. "}"
    return result
end


return Fmt
