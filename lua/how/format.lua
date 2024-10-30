
Fmt = {};

function Fmt.tableToString(tbl, indent)
    indent = indent or 0
    local result = "{\n"
    local separator = ""
    local indentString = string.rep("  ", indent)

    for key, value in pairs(tbl) do
        result = result .. indentString .. separator .. tostring(key) .. " = "
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
