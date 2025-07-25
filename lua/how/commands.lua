local format = require("how.format")


local function commands()
    local function extract_key_value(input)
        local key, value = input:match('"(.-)"%s+"(.-)"')
        return { key, value }
    end

    local function get_users_keys()
    end

    ---------------------
    --  User Commands  --
    ---------------------
    vim.api.nvim_create_user_command("How",
        function(opts)
            local How = require("how")
            if #opts.fargs == 0 then
                -- Show all definitions
                local result, err = How.getDefinition("")
                if err then
                    print("Error: " .. err)
                else
                    print(format.tableToString(result or {}))
                end
            else
                local term = opts.fargs[1]
                local result, err = How.getDefinition(term)
                if err then
                    print("Error: " .. err)
                else
                    print(format.tableToString(result or {}))
                end
            end
        end,
        {
            nargs = "?",
            complete = function()
                --local keys = get_users_keys()
                --print(ArgLead)
                --print(CmdLine)
                --print(CursorPos)
                -- return completion candidates as a list-like table
                -- return keys
            end,
            desc = "Echos the command arg to command bar",
        }
    )

    vim.api.nvim_create_user_command("HowAdd",
        function(opts)
            local How = require("how")
            if #opts.fargs < 2 then
                print("Usage: HowAdd <term> <definition>")
                return
            end
            
            local term = opts.fargs[1]
            local definition = table.concat(opts.fargs, " ", 2)
            local keywords = "" -- Could be extracted from definition or set separately
            
            local success, err = How.insertDefinition(term, keywords, definition)
            if success then
                print("Added definition for: " .. term)
            else
                print("Error adding definition: " .. (err or "unknown error"))
            end
        end,
        {
            nargs = "+",
            desc = "Add command definition",
        }
    )


    vim.api.nvim_create_user_command("HowDelete",
        function(opts)
            local How = require("how")
            if #opts.fargs == 0 then
                print("Usage: HowDelete <term>")
                return
            end
            
            local term = opts.fargs[1]
            local success, err = How.deleteDefinition(term)
            if success then
                print("Deleted definition for: " .. term)
            else
                print("Error deleting definition: " .. (err or "unknown error"))
            end
        end,
        {
            nargs = 1,
            desc = "Delete command definition"
        })
end

return commands
