local json = require("json")
local actions = {}

-- Functiion to read settings from the JSON file
function actions.read_settings(settings_path)
    local file = io.open(settings_path, 'r')
    if file then
        print(file:read("a"))
        local content = file:read('*a')
        file:close()
        return json.decode(content)
    else
        return {}
    end
end

-- Function to write settings to the JSON file
function actions.write_settings(settings_path, settings)
    local file = io.open(settings_path, 'w')
    if file then
        file:write(json.encode(settings))
        file:close()
    else
        print('Error: Could not write to settings file')
    end
end


function actions.append_definition(settings_path, key, value)
    local settings = actions.read_settings(settings_path)
    print(tostring(settings))
    local definitions = settings["definitions"]
    print(definitions)
    definitions[key] = value
    actions.write_settings(settings_path,settings)
end

function actions.delete_definition(path, key)
    local settings = actions.read_settings(path)
    local definitions = settings["definitions"]
    if definitions[key] then
        definitions[key] = nil;
        actions.write_settings(path, settings)
    else
        print("Definition not found")
    end
end
function actions.tableToString(tbl, indent)
    indent = indent or 0
    local result = "{\n"
    local separator = ""
    local indentString = string.rep("  ", indent)

    for key, value in pairs(tbl) do
        result = result .. indentString .. separator .. tostring(key) .. " = "
        if type(value) == "table" then
            result = result .. actions.tableToString(value, indent + 1)
        else
            result = result .. tostring(value)
        end
        separator = ",\n"
    end

    result = result .. "\n" .. string.rep("  ", indent - 1) .. "}"
    return result
end


return actions
