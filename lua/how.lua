---@module 'how'
---@module 'vim'
---@module 'lua.lsp.sqlite3_lsp'

---@type sqlite3
local sqlite3 = require("lsqlite3complete")
local actions = require("how.actions")
local schema = require("how.schema")

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

-- Expand home directory path
local home = os.getenv("HOME") or ""
local db_path = home .. "/.local/share/nvim/how.db"

-- Ensure the directory exists
vim.fn.mkdir(vim.fn.fnamemodify(db_path, ":h"), "p")

How.db = sqlite3.open(db_path)

-- Initialize database schema
if How.db then
    How.db:exec(schema.table)
end

-- Wrapper functions that pass db to actions
How.getDefinition = function(term)
    return actions.getDefinition(How.db, term)
end

How.insertDefinition = function(term, keywords, definition)
    return actions.insertDefinition(How.db, term, keywords, definition)
end

How.deleteDefinition = function(term)
    return actions.deleteDefinition(How.db, term)
end

-- Export actions module for testing
How.actions = actions

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
How.setup = function(args)
    How.config = vim.tbl_deep_extend("force", How.config, args or {})
end

return How
