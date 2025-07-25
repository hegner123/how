local sqlite3 = require("lsqlite3complete")

local actions = {}

---Query sqlite3_db for exact match in term column, or get all definitions
---@param db sqlite3_db
---@param term string|nil
---@return table|nil, string|nil
function actions.getDefinition(db, term)
    if not db then
        return nil, "Invalid database"
    end

    local sql, stmt
    if not term or term == "" then
        -- Get all definitions
        stmt = db:prepare("SELECT * FROM definitions ORDER BY term")
    else
        -- Get specific term
        stmt = db:prepare("SELECT * FROM definitions WHERE term = ?")
    end

    if not stmt then
        return nil, "Failed to prepare statement: " .. db:errmsg()
    end

    if term and term ~= "" then
        stmt:bind(1, term)
    end

    local rows = {}
    while stmt:step() == sqlite3.ROW do
        local row = {}
        for i = 0, stmt:columns() - 1 do
            row[stmt:get_name(i)] = stmt:get_value(i)
        end
        table.insert(rows, row)
    end

    stmt:finalize()
    return rows, nil
end

---Insert definition into sqlite3_db 
---@param db sqlite3_db
---@param term string
---@param keywords string
---@param definition string
---@return boolean, string|nil
function actions.insertDefinition(db, term, keywords, definition)
    if not db or not term or term == "" or not definition or definition == "" then
        return false, "Invalid parameters"
    end

    local stmt = db:prepare("INSERT INTO definitions (term, keywords, definition) VALUES (?, ?, ?)")
    if not stmt then
        return false, "Failed to prepare statement: " .. db:errmsg()
    end

    stmt:bind(1, term)
    stmt:bind(2, keywords or "")
    stmt:bind(3, definition)

    local result = stmt:step()
    stmt:finalize()

    if result == sqlite3.DONE then
        return true, nil
    else
        return false, "Failed to insert: " .. db:errmsg()
    end
end

---Delete definition from sqlite3_db
---@param db sqlite3_db
---@param term string delete filter term
---@return boolean, string|nil
function actions.deleteDefinition(db, term)
    if not db or not term or term == "" then
        return false, "Invalid parameters"
    end

    local stmt = db:prepare("DELETE FROM definitions WHERE term = ?")
    if not stmt then
        return false, "Failed to prepare statement: " .. db:errmsg()
    end

    stmt:bind(1, term)
    local result = stmt:step()
    stmt:finalize()

    if result == sqlite3.DONE then
        return true, nil
    else
        return false, "Failed to delete: " .. db:errmsg()
    end
end

return actions
