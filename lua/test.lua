local demo_path = "./demo.json"
local actions = require("lua.how.actions")
local demo_append = {}
demo_append["test"] = "test value"


local function tableToString(tbl, indent)
    indent = indent or 0
    local result = "{\n"
    local separator = ""
    local indentString = string.rep("  ", indent)

    for key, value in pairs(tbl) do
        result = result .. indentString .. separator .. tostring(key) .. " = "
        if type(value) == "table" then
            result = result .. tableToString(value, indent + 1)
        else
            result = result .. tostring(value)
        end
        separator = ",\n"
    end

    result = result .. "\n" .. string.rep("  ", indent - 1) .. "}"
    return result
end


local read_res = actions.read_settings(demo_path)
print(tableToString(read_res))
actions.append_definition(demo_path,"test", "test value")
read_res = actions.read_settings(demo_path)
print(tableToString(read_res))
actions.delete_definition(demo_path,"test")
read_res = actions.read_settings(demo_path)
print(tableToString(read_res))


