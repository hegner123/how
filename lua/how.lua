local how = {}

function how.setup()
    vim.api.nvim_create_user_command("How",
        function(opts)
            local arg1 = opts.args

            if arg1 == "search" then
                print("%s@search@replace@g")
            else
            end
        end,
        {
            desc = "Echoes the word 'how' to the command bar",
            nargs = 1
        }
    )
end

return how
