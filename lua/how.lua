
local module = require("how.module")
local sqlite3 = require("lsqlite3complete")

---@class Config
---@field opt string Your config option
local config = {
  opt = "Hello!",
    sqlitePath = "",
}
---@class MyModule
local How = {}

---@type Config
How.config = config

print(config.sqlitePath)

sqlite3.open("test.db")


---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
How.setup = function(args)
  How.config = vim.tbl_deep_extend("force", How.config, args or {})
end

How.hello = function()
  return module.greet(How.config.opt)
end

return How
