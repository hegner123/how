local plugin = require("how")

describe("database", function()
    it("can find sqlite package", function()
        assert(plugin.db, "Checks for plugin.db being defined")
    end)

    it("can read sqlitepath", function()
        plugin.setup({ sqlitePath = "/Users/home/.luarocks/lib/lua/5.1/lsqlite3complete.so" })
        assert(plugin.config.sqlitePath == "/Users/home/.luarocks/lib/lua/5.1/lsqlite3complete.so", "the path took")
    end)
end)


describe("add definition", function()
    --local read_res = actions.read_settings(demo_path)
    --print(tableToString(read_res))
    --actions.append_definition(demo_path,"test", "test value")
    --read_res = actions.read_settings(demo_path)
    --print(tableToString(read_res))
    --actions.delete_definition(demo_path,"test")
    --read_res = actions.read_settings(demo_path)
    --print(tableToString(read_res))
end)
