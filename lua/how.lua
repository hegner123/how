
local how = {}

function how.setup()

    vim.api.nvim_create_user_command("How",
         function(cmd)
            vim.echo("how")
        end,
        {    desc = "Echoes the word 'how' to the command bar"}
    )


end

return how
