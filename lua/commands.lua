local json = require("json")
local settings_path = vim.fn.stdpath('config') .. '/how_settings.json'
local actions = require("actions")

local function commands(how)
    local function get_length(var)
        local var_type = type(var)
        if var_type == "string" then
            return #var
        elseif var_type == "table" then
            local count = 0
            for _ in pairs(var) do
                count = count + 1
            end
            return count
        else
            return nil -- Length is not defined for other types
        end
    end

    -- Functiion to read settings from the JSON file

    local function extract_key_value(input)
        local key, value = input:match('"(.-)"%s+"(.-)"')
        return { key, value }
    end

    local function get_users_keys()
        local settings = actions.read_settings()
        local keys = {}
        for key, _ in pairs(settings) do
            table.insert(keys, key)
        end
        return keys
    end

    ---------------------
    --  User Commands  --
    ---------------------
    vim.api.nvim_create_user_command("How",
        function(opts)
            if get_length(opts) < 1 then
                local result = actions.tableToString(get_users_keys())
                print(result)
            else
                local arg1 = opts.fargs[1]
                local result = actions.tableToString(how.get_setting(arg1))
                print(result)
            end
        end,
        {
            nargs = "?",
            complete = function(ArgLead, CmdLine, CursorPos)
                local keys = get_users_keys()
                print(ArgLead)
                print(CmdLine)
                print(CursorPos)
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

            print(parsed[1], parsed[2])
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

return commands
