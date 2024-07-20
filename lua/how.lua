local how = {}

function how.setup()
    vim.api.nvim_create_user_command("How",
        function(cmd)
            if cmd == "search" then
                print("%s@search@replace@g")
            else
            print(cmd)
            end
        end,
        { desc = "Echoes the word 'how' to the command bar" }
    )
end

return how
