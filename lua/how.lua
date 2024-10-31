---@module 'lua.lsp.sqlite3_lsp'
---@type sqlite3
local sqlite3 = require("lsqlite3complete")
local actions = require("how.actions")

---@class Config
---@field sqlitePath string Location of lsqlite3complete.so file
local config = {
    sqlitePath = "",
}
---@class How
---@field db sqlite3_db
How = {}
How.__index = How

---@type Config
How.config = config
How.db = sqlite3.open("~/.local/share/nvim/how.db")


How.actions = actions;


---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
How.setup = function(args)
    How.config = vim.tbl_deep_extend("force", How.config, args or {})
end

How.db:close()

return How
