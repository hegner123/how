-- Require the SQLite3 module
local sqlite3 = require("sqlite")

-- Open a connection to a SQLite3 database (creates the file if it doesn't exist)
local db = sqlite3.open("example.db")

-- Check if the database connection was successful
if not db then
    print("Failed to open the database.")
    return
else
    print("Database connection established.")
end

-- Example: Creating a table in the database
local create_table_sql = [[
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT
    );
]]

-- Execute the SQL command
local result = db:exec(create_table_sql)
if result ~= sqlite3.OK then
    print("Error creating table:", db:errmsg())
else
    print("Table created successfully.")
end

-- Close the database connection
db:close()
print("Database connection closed.")

