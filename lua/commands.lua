local settings_path = vim.fn.stdpath('config') .. '/how_settings.json'
local actions = require("actions")

local function commands(how)
    local function extract_key_value(input)
        local key, value = input:match('"(.-)"%s+"(.-)"')
        return { key, value }
    end


    local function get_users_keys()
        local settings = actions.read_settings(settings_path)
        print(settings)
        local keys = {}
        for key, _ in pairs(settings) do
            table.insert(keys, key)
        end
        print(actions.tableToString(keys))
        return keys
    end

    ---------------------
    --  User Commands  --
    ---------------------
    vim.api.nvim_create_user_command("How",
        function(opts)
           -- if opts.count < 1 then
                local keys = get_users_keys()
              --  local result = actions.tableToString(keys)
              --  print(result)
            --else
             --   local arg1 = opts.fargs[1]
             --   local result = actions.tableToString(how.get_setting(arg1))
             --   print(result)
            --end
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
