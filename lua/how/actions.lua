local schema = require("how.schema")

local actions = {}

---Query sqlite3_db for exact match in term column, then run search on keyword
---@param term string
---@return table
function actions.getDefinition(term)
    local rows = {}
    function Showrow(udata, cols, values, names)
        local row = {}
        assert(udata == 'test_udata', "Unexpected userdata")

        for i = 1, cols do
            row[names[i]] = string.lower(values[i])
        end

        table.insert(rows, row)
        return 0
    end

    local sql = "SELECT * FROM definitions WHERE term=" .. term .. ";"

    local result = How.db:exec(sql, Showrow, 'test_udata')
    if result ~= sqlite3.OK then
        print("SQL Error", How.db:errmsg())
    else
        print("SQL statements executed successfully")
    end
    return rows
end


---Insert definition into sqlite3_db 
---@param term string
---@param keywords string
---@param definition string
---@return number return code
function actions.insertDefinition(term,keywords,definition)
local sep = "','"
    local sql = "INSERT INTO definitions (term,keywords,definition) VALUES ('"..term..sep..keywords..sep..definition"');"

    local result = How.db:exec(sql, Showrow, 'test_udata')
    if result ~= sqlite3.OK then
        print("SQL Error", How.db:errmsg())
        return sqlite3.OK
    else
        print("SQL statements executed successfully")
        return sqlite3.ERROR
    end

end


---Delete definition from sqlite3_db
---@param term string delete filter term
---@return string result or errmsg
function actions.deleteDefinition(term)
local sep = "','"
    local sql = "DELETE FROM definitions WHERE term="..term..";"
    local res = How.db.exec(sql)
end

return actions
