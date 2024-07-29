local json = require("json")
local schema = require("schema")
local actions = require("actions")
local commands = require("commands")
local settings_path = vim.fn.stdpath('data') .. '/how_settings.json'
local how = {}

local function ensure_dependencies()
    local handle = io.popen("luarocks list dkjson")
    local result;
    if handle == nil then
        return
    else
        result = handle:read("*a")
        handle:close()
    end

    if not result:find("dkjson") then
        print("dkjson not found. Installing...")
        os.execute("luarocks install dkjson")
    end
end

local function file_exists(filename)
    local file = io.open(filename, "r")
    if file then
        file:close()
        return true
    else
        return false
    end
end

local function create_file(filename)
    local file = io.open(filename, "w")
    if file then
        file:close()
        print("File created: " .. filename)
    else
        print("Error creating file: " .. filename)
    end
end

local function check_and_create_file(filename)
    if not file_exists(filename) then
        create_file(filename)
        actions.write_settings(filename,schema)
    else
        print("File already exists: " .. filename)
    end
end



function how.setup()
    print(settings_path)
    check_and_create_file(settings_path)
    ensure_dependencies()
    commands(how)
end

return how
