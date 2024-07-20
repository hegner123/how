-- lua/tips.lua
local function how()
  print("how")
end

vim.api.nvim_create_user_command(
  'how', 
  how, 
  {desc = "Echoes the word 'how' to the command bar"}
)

