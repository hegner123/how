local how = require("lua.how")
local sqlite3 = require("lsqlite3complete")
local Fmt = require("how.format")
local actions = require("how.actions")
local schema = require("how.schema")
local commands = require("how.commands")

-- Initialize commands for testing
commands()

-- Test helpers
local function generate_unique_term()
    return "test_" .. os.time() .. "_" .. math.random(1000, 9999)
end

local function cleanup_test_data(term)
    how.deleteDefinition(term)
end

describe("How Plugin", function()
    describe("main module setup", function()
        it("can be required without errors", function()
            assert(how ~= nil, "How module should be loadable")
        end)

        it("has database connection", function()
            assert(how.db ~= nil, "Database connection should be established")
        end)

        it("can setup configuration", function()
            local original_config = vim.deepcopy(how.config)
            how.setup({ sqlitePath = "/test/path/to/sqlite.so" })
            assert(how.config.sqlitePath == "/test/path/to/sqlite.so", "Config should update")
            -- Restore original config
            how.config = original_config
        end)

        it("exports actions module", function()
            assert(how.actions ~= nil, "Actions module should be exported")
            assert(type(how.actions.getDefinition) == "function", "getDefinition should be function")
            assert(type(how.actions.insertDefinition) == "function", "insertDefinition should be function")
            assert(type(how.actions.deleteDefinition) == "function", "deleteDefinition should be function")
        end)
    end)

    describe("database operations", function()
        local test_term

        before_each(function()
            test_term = generate_unique_term()
        end)

        after_each(function()
            if test_term then
                cleanup_test_data(test_term)
            end
        end)

        it("can insert definition", function()
            local success, err = how.insertDefinition(test_term, "test_keywords", "test_definition")
            assert(success == true, err or "Failed to insert")
        end)

        it("can read specific definition", function()
            how.insertDefinition(test_term, "test_keywords", "test_definition")
            local res = how.getDefinition(test_term)
            assert(#res > 0, "Should return at least one row")
            assert(res[1].term == test_term, "Term should match")
            assert(res[1].keywords == "test_keywords", "Keywords should match")
            assert(res[1].definition == "test_definition", "Definition should match")
        end)

        it("can read all definitions", function()
            how.insertDefinition(test_term, "test_keywords", "test_definition")
            local res = how.getDefinition("")
            assert(#res > 0, "Should return at least one row when getting all")
            local found = false
            for _, row in ipairs(res) do
                if row.term == test_term then
                    found = true
                    break
                end
            end
            assert(found, "Should find our test term in all results")
        end)

        it("can delete definition", function()
            how.insertDefinition(test_term, "test_keywords", "test_definition")
            local success, err = how.deleteDefinition(test_term)
            assert(success == true, err or "Failed to delete")
            
            local res = how.getDefinition(test_term)
            assert(#res == 0, "Should return no rows after deletion")
        end)

        it("handles invalid parameters gracefully", function()
            local success, err = how.insertDefinition("", "", "")
            assert(success == false, "Should fail with empty term")
            assert(err ~= nil, "Should return error message")

            success, err = how.deleteDefinition("")
            assert(success == false, "Should fail with empty term")
            assert(err ~= nil, "Should return error message")
        end)

        it("handles non-existent term queries", function()
            local res = how.getDefinition("non_existent_term_12345")
            assert(#res == 0, "Should return empty result for non-existent term")
        end)

        it("handles duplicate term insertion", function()
            how.insertDefinition(test_term, "keywords1", "definition1")
            local success, err = how.insertDefinition(test_term, "keywords2", "definition2")
            assert(success == false, "Should fail when inserting duplicate term")
            assert(err ~= nil, "Should return error for duplicate")
        end)
    end)

    describe("direct actions module", function()
        local test_term

        before_each(function()
            test_term = generate_unique_term()
        end)

        after_each(function()
            if test_term then
                cleanup_test_data(test_term)
            end
        end)

        it("getDefinition works with valid database", function()
            actions.insertDefinition(how.db, test_term, "keywords", "definition")
            local res, err = actions.getDefinition(how.db, test_term)
            assert(err == nil, "Should not return error")
            assert(#res > 0, "Should return results")
            assert(res[1].term == test_term, "Should return correct term")
        end)

        it("getDefinition handles nil database", function()
            local res, err = actions.getDefinition(nil, test_term)
            assert(res == nil, "Should return nil for invalid db")
            assert(err ~= nil, "Should return error message")
        end)

        it("insertDefinition validates parameters", function()
            local success, err = actions.insertDefinition(how.db, "", "", "")
            assert(success == false, "Should fail with empty term")
            
            success, err = actions.insertDefinition(how.db, "term", "", "")
            assert(success == false, "Should fail with empty definition")
            
            success, err = actions.insertDefinition(nil, "term", "keywords", "definition")
            assert(success == false, "Should fail with nil database")
        end)

        it("deleteDefinition validates parameters", function()
            local success, err = actions.deleteDefinition(how.db, "")
            assert(success == false, "Should fail with empty term")
            
            success, err = actions.deleteDefinition(nil, "term")
            assert(success == false, "Should fail with nil database")
        end)
    end)

    describe("schema module", function()
        it("contains table creation SQL", function()
            assert(schema.table ~= nil, "Schema should have table property")
            assert(type(schema.table) == "string", "Table schema should be string")
            assert(schema.table:find("CREATE TABLE"), "Should contain CREATE TABLE statement")
            assert(schema.table:find("definitions"), "Should reference definitions table")
        end)

        it("has default schema fields", function()
            assert(schema.term ~= nil, "Should have term field")
            assert(schema.keywords ~= nil, "Should have keywords field")
            assert(schema.frequency ~= nil, "Should have frequency field")
            assert(schema.definition ~= nil, "Should have definition field")
        end)
    end)

    describe("format utilities", function()
        it("can compare tables deeply", function()
            local t1 = { a = 1, b = { c = 2 } }
            local t2 = { a = 1, b = { c = 2 } }
            local t3 = { a = 1, b = { c = 3 } }
            
            assert(Fmt.deep_compare(t1, t2) == true, "Identical tables should be equal")
            assert(Fmt.deep_compare(t1, t3) == false, "Different tables should not be equal")
        end)

        it("can compare non-table values", function()
            assert(Fmt.deep_compare(1, 1) == true, "Same numbers should be equal")
            assert(Fmt.deep_compare("a", "a") == true, "Same strings should be equal")
            assert(Fmt.deep_compare(1, 2) == false, "Different numbers should not be equal")
            assert(Fmt.deep_compare("a", "b") == false, "Different strings should not be equal")
        end)

        it("can convert table to string", function()
            local test_table = { term = "test", definition = "test def" }
            local result = Fmt.tableToString(test_table)
            assert(type(result) == "string", "Should return string")
            assert(result:find("term"), "Should contain term key")
            assert(result:find("test"), "Should contain term value")
        end)

        it("handles empty table conversion", function()
            local result = Fmt.tableToString({})
            assert(type(result) == "string", "Should return string for empty table")
        end)

        it("handles nested table conversion", function()
            local nested_table = { 
                outer = { 
                    inner = "value" 
                } 
            }
            local result = Fmt.tableToString(nested_table)
            assert(type(result) == "string", "Should return string for nested table")
            assert(result:find("outer"), "Should contain outer key")
            assert(result:find("inner"), "Should contain inner key")
        end)
    end)

    describe("user commands integration", function()
        local test_term

        before_each(function()
            test_term = generate_unique_term()
        end)

        after_each(function()
            if test_term then
                cleanup_test_data(test_term)
            end
        end)

        it("How command exists", function()
            local commands = vim.api.nvim_get_commands({})
            assert(commands["How"] ~= nil, "How command should be registered")
        end)

        it("HowAdd command exists", function()
            local commands = vim.api.nvim_get_commands({})
            assert(commands["HowAdd"] ~= nil, "HowAdd command should be registered")
        end)

        it("HowDelete command exists", function()
            local commands = vim.api.nvim_get_commands({})
            assert(commands["HowDelete"] ~= nil, "HowDelete command should be registered")
        end)

        it("commands have proper configuration", function()
            local commands = vim.api.nvim_get_commands({})
            
            local how_cmd = commands["How"]
            assert(how_cmd.nargs == "?", "How command should accept optional args")
            
            local add_cmd = commands["HowAdd"]
            assert(add_cmd.nargs == "+", "HowAdd command should require args")
            
            local delete_cmd = commands["HowDelete"]
            assert(delete_cmd.nargs == "1", "HowDelete command should require one arg")
        end)
    end)

    describe("database persistence", function()
        it("maintains data across operations", function()
            local term1 = generate_unique_term()
            local term2 = generate_unique_term()
            
            -- Insert multiple definitions
            how.insertDefinition(term1, "keywords1", "definition1")
            how.insertDefinition(term2, "keywords2", "definition2")
            
            -- Verify both exist
            local res1 = how.getDefinition(term1)
            local res2 = how.getDefinition(term2)
            assert(#res1 > 0, "First definition should exist")
            assert(#res2 > 0, "Second definition should exist")
            
            -- Delete one, verify the other remains
            how.deleteDefinition(term1)
            res1 = how.getDefinition(term1)
            res2 = how.getDefinition(term2)
            assert(#res1 == 0, "First definition should be deleted")
            assert(#res2 > 0, "Second definition should still exist")
            
            -- Cleanup
            cleanup_test_data(term2)
        end)

        it("handles concurrent operations", function()
            local terms = {}
            for i = 1, 5 do
                terms[i] = generate_unique_term()
                how.insertDefinition(terms[i], "keywords" .. i, "definition" .. i)
            end
            
            -- Verify all were inserted
            for i = 1, 5 do
                local res = how.getDefinition(terms[i])
                assert(#res > 0, "Definition " .. i .. " should exist")
            end
            
            -- Cleanup
            for i = 1, 5 do
                cleanup_test_data(terms[i])
            end
        end)
    end)

    describe("error handling", function()
        it("handles database connection issues gracefully", function()
            -- Test with a mock broken database
            local broken_db = nil
            local res, err = actions.getDefinition(broken_db, "test")
            assert(res == nil, "Should return nil for broken db")
            assert(err ~= nil, "Should return error message")
        end)

        it("handles malformed SQL gracefully", function()
            -- This tests the robustness of our parameter binding
            local test_term = "test'; DROP TABLE definitions; --"
            local success, err = how.insertDefinition(test_term, "safe keywords", "safe definition")
            -- Should either succeed (properly escaped) or fail gracefully
            assert(type(success) == "boolean", "Should return boolean success status")
            if success then
                cleanup_test_data(test_term)
            end
        end)
    end)
end)
