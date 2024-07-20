
local how = {}

function how.setup()

    vim.api.nvim_create_user_command("How",
         function(cmd)
            vim.echo("how")
            return {    desc = "Echoes the word 'how' to the command bar"}
        end
    )


end

return how
