-- lua/tips.lua
local function how()
  print("how")
end

vim.api.nvim_buf_create_user_command(
  'How',
  how,
  {desc = "Echoes the word 'how' to the command bar"}
)

