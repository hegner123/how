local how = {}

function how.setup()
    vim.api.nvim_create_user_command("How",
        function(cmd)
            print("how")
        end,
        { desc = "Echoes the word 'how' to the command bar" }
    )
end

return how
