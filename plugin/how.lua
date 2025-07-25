-- Plugin initialization file for How
-- This file is automatically sourced by Neovim when the plugin is loaded

-- Ensure the plugin is only loaded once
if vim.g.loaded_how then
    return
end
vim.g.loaded_how = 1

-- Initialize the How module to set up database
require("how")

-- Register user commands
local commands = require("how.commands")
commands()