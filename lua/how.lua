local how = {}
local json = require("json")
local settings_path = vim.fn.stdpath('config') .. '/how_settings.json'

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
        file:write(json.encode(settings))
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

local function extract_key_value(input)
  local key, value = input:match('"(.-)"%s+"(.-)"')
  return {key, value}
end

local function get_users_keys()
    local settings = read_settings()
    local keys = {}
      for key, _ in pairs(settings) do
        table.insert(keys, key)
      end
  return keys
end

function how.setup()
    ensure_dependencies()
    vim.api.nvim_create_user_command("How",
        function(opts)
            local arg1 = opts.fargs[1]

            if arg1 == "search" then
                print("%s@search@replace@g")
            else
                print(arg1)
            end
        end,
         { nargs = 1,
             complete = function(ArgLead, CmdLine, CursorPos)
                local keys = get_users_keys()
                -- return completion candidates as a list-like table
                return keys
            end,
            desc = "Echos the command arg to command bar",
        }
    )
    vim.api.nvim_create_user_command("HowAdd",
        function(opts)
            local arg = opts.fargs[1]
            local parsed = extract_key_value(arg)

            print(parsed[1],parsed[2])
        end,
        {
            nargs = 1,
            desc = "Add setting to user setting",
        }
    )
    vim.api.nvim_create_user_command("HowDelete",
        function(opts)
            local arg1 = opts.args

            print(arg1)
        end,
        {
            nargs = 1,
            desc = "Delete Settings"
        })
end

return how
