-- lua/tips.lua

local function setupHow()
vim.api.nvim_create_user_command("How",
  function(cmd)
return {    desc = "Echoes the word 'how' to the command bar"}
end
    )
end

return setupHow
