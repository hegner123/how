local how = require("lua.how")
local sqlite3 = require("lsqlite3complete")
local Fmt = require("how.format")

describe("database", function()
    it("can find sqlite package", function()
        assert(how.db ~= nil, "Checks for plugin.db being defined")
    end)

    it("can read sqlitepath", function()
        how.setup({ sqlitePath = "/Users/home/.luarocks/lib/lua/5.1/lsqlite3complete.so" })
        assert(how.config.sqlitePath == "/Users/home/.luarocks/lib/lua/5.1/lsqlite3complete.so", "the path took")
    end)

    it("can insert values", function()
        local test_term = "test_unique_" .. os.time()
        local res = how.actions.insertDefinition(test_term, "test_keywords", "test_definition")
        assert(res == sqlite3.OK, res)
    end)

    it("can read sql", function()
        local test_term = "test_read_" .. os.time()
        -- Insert test data first
        how.actions.insertDefinition(test_term, "test_keywords", "test_definition")
        
        local res = how.actions.getDefinition(test_term)
        assert(#res > 0, "Should return at least one row")
        assert(res[1].term == test_term, "Term should match")
        assert(res[1].keywords == "test_keywords", "Keywords should match")
        assert(res[1].definition == "test_definition", "Definition should match")
    end)

    it("can delete values", function()
    end)
end)
