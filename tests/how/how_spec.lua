local plugin = require("how")
function LogToFile(filename, message)
    local file = io.open(filename, "a")
    if not file then
        print("Error opening file:", filename)
        return
    end

    file:write(message .. "\n")
    file:close()
end

function Showrow(cols, name, values)
    for i = 0, cols do
        local statement = name[i] + " " + values[i]
        LogToFile("log.log", statement)
    end
    return 0
end

function TableToString(tbl, indent)
    indent = indent or 0
    local result = "{\n"
    local separator = ""
    local indentString = string.rep("  ", indent)

    for key, value in pairs(tbl) do
        result = result .. indentString .. separator .. tostring(key) .. " : "
        if type(value) == "table" then
            result = result .. TableToString(value, indent + 1)
        else
            result = result .. tostring(value)
        end
        separator = ",\n"
    end

    result = result .. "\n" .. string.rep("  ", indent - 1) .. "}"
    return result
end

describe("database", function()
    it("can find sqlite package", function()
        assert(plugin.db, "Checks for plugin.db being defined")
    end)

    it("can read sqlitepath", function()
        plugin.setup({ sqlitePath = "/Users/home/.luarocks/lib/lua/5.1/lsqlite3complete.so" })
        assert(plugin.config.sqlitePath == "/Users/home/.luarocks/lib/lua/5.1/lsqlite3complete.so", "the path took")
    end)

    it("can insert values", function()
        local sql = "INSERT INTO definitions (term, keywords, frequency, definition) VALUES ('test', 'test', 0, 'test');"
        local readSQL = "SELECT * FROM definitions WHERE term='test'"

        plugin.db:exec(sql)
        local read = plugin.db:exec(readSQL, Showrow)
        assert(read == 4, read)
    end)

    it("can read sql", function()
        local rows = {}
        local sql = "SELECT * FROM definitions"
        function Showrow(udata, cols, values, names)
            local row = {}
            assert(udata == 'test_udata', "Unexpected userdata")

            for i = 1, cols do
                row[names[i]] = string.lower(values[i])
            end

            table.insert(rows, row)
            return 0
        end

        plugin.db:exec(sql, Showrow, 'test_udata')
        local res = TableToString(rows,1)
        LogToFile("table.log", res)
        assert(0 == 0)
    end)

    it("can delete values", function()
        local sql = "DELETE FROM definitions WHERE term='test';"
        local res = plugin.db:exec(sql)
        assert(res == 0, "Delete sql value")
    end)
end)
