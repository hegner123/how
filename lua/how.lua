local how = {}
local json = require("dkjson")
local settings_path = vim.fn.stdpath('config') .. '/how_settings.json'

-- Function to read settings from the JSON file
local function read_settings()
    local file = io.open(settings_path, 'r')
    if file then
        local content = file:read('*a')
        file:close()
        return json.decode(content)
    else
        return {}
    end
end

-- Function to write settings to the JSON file
local function write_settings(settings)
    local file = io.open(settings_path, 'w')
    if file then
        file:write(json.encode(settings, { indent = true }))
        file:close()
    else
        print('Error: Could not write to settings file')
    end
end

-- Function to update a specific setting
function how.update_setting(key, value)
    local settings = read_settings()
    settings[key] = value
    write_settings(settings)
end

-- Function to get a specific setting
function how.get_setting(key)
    local settings = read_settings()
    return settings[key]
end

-- Function to delete a specific setting
function how.delete_setting(key)
    local settings = read_settings()
    if settings[key] then
        settings[key] = nil
        write_settings(settings)
        print("Deleted setting: " .. key)
    else
        print("Setting not found: " .. key)
    end
end

function how.setup()
    vim.api.nvim_create_user_command("How",
        function(opts)
            local arg1 = opts.args

            if arg1 == "search" then
                print("%s@search@replace@g")
            else
                print(arg1)
            end
        end,
        {
            desc = "Echoes the word 'how' to the command bar",
            nargs = 1
        }
    )
    vim.api.nvim_create_user_command("HowAdd",
        function(opts)
            local arg1 = opts.args[1]
            local arg2 = opts.args[2]

            print(arg1, arg2)
        end,
        {
            desc = "Add setting to user setting",
            nargs = 2
        }
    )
    vim.api.nvim_create_user_command("HowDelete",
        function(opts)
            local arg1 = opts.args

            print(arg1)
        end,
        {
            desc = "Delete Settings"
        })
end

return how
