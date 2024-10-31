local how = require("how")

describe("database", function()
    it("can find sqlite package", function()
        assert(how.db, "Checks for plugin.db being defined")
    end)

    it("can read sqlitepath", function()
        how.setup({ sqlitePath = "/Users/home/.luarocks/lib/lua/5.1/lsqlite3complete.so" })
        assert(how.config.sqlitePath == "/Users/home/.luarocks/lib/lua/5.1/lsqlite3complete.so", "the path took")
    end)

    it("can insert values", function()
        local res = how.actions.insertDefinition("test", "test", "test")
        assert(res == sqlite3.OK, res)
    end)

    it("can read sql", function()
        local expected = {}
        expected.term = "test"
        expected.keywords = "test"
        expected.frequency = 0
        expected.definition = "test"
        local res = how.actions.getDefinition("test")
        local compare = Fmt.deep_compare(res,expected)
        assert(compare == true, "Read returns expected db rows")
    end)

    it("can delete values", function()
    end)
end)
