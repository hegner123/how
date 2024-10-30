local sqlite3 = require("lsqlite3complete")
local actions = require("how.actions")
local schema = require("how.schema")

---@class Config
---@field sqlitePath string Location of lsqlite3complete.so file
local config = {
    sqlitePath = "",
}
---@class MyModule
local How = {}

---@type Config
How.config = config

How.db = sqlite3.open("how.db")

local res = How.db:exec(schema.table)
print(res)

How.actions = actions;


---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
How.setup = function(args)
    How.config = vim.tbl_deep_extend("force", How.config, args or {})
end


return How
