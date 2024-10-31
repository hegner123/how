--- @meta sqlite3_lsp

--- SQLite3 Library
--- @class sqlite3
sqlite3 = {}

--- Sqlite3 DB class
--- @class sqlite3_db
sqlite3.db = {}

--- Statement Class
--- @class sqlite3_stmt
sqlite3.stmt = {}

--- Online Backup Class
--- @class sqlite3_backup
sqlite3.backup = {}

--- Error Codes
sqlite3.OK = 0
sqlite3.ERROR = 1
sqlite3.INTERNAL = 2
sqlite3.PERM = 3
sqlite3.ABORT = 4
sqlite3.BUSY = 5
sqlite3.LOCKED = 6
sqlite3.NOMEM = 7
sqlite3.READONLY = 8
sqlite3.INTERRUPT = 9
sqlite3.IOERR = 10
sqlite3.CORRUPT = 11
sqlite3.NOTFOUND = 12
sqlite3.FULL = 13
sqlite3.CANTOPEN = 14
sqlite3.PROTOCOL = 15
sqlite3.EMPTY = 16
sqlite3.SCHEMA = 17
sqlite3.TOOBIG = 18
sqlite3.CONSTRAINT = 19
sqlite3.MISMATCH = 20
sqlite3.MISUSE = 21
sqlite3.NOLFS = 22
sqlite3.FORMAT = 24
sqlite3.RANGE = 25
sqlite3.NOTADB = 26
sqlite3.ROW = 100
sqlite3.DONE = 101

--- Authorizer Action Codes
sqlite3.CREATE_INDEX = 1
sqlite3.CREATE_TABLE = 2
sqlite3.CREATE_TEMP_INDEX = 3
sqlite3.CREATE_TEMP_TABLE = 4
sqlite3.CREATE_TEMP_TRIGGER = 5
sqlite3.CREATE_TEMP_VIEW = 6
sqlite3.CREATE_TRIGGER = 7
sqlite3.CREATE_VIEW = 8
sqlite3.DELETE = 9
sqlite3.DROP_INDEX = 10
sqlite3.DROP_TABLE = 11
sqlite3.DROP_TEMP_INDEX = 12
sqlite3.DROP_TEMP_TABLE = 13
sqlite3.DROP_TEMP_TRIGGER = 14
sqlite3.DROP_TEMP_VIEW = 15
sqlite3.DROP_TRIGGER = 16
sqlite3.DROP_VIEW = 17
sqlite3.INSERT = 18
sqlite3.PRAGMA = 19
sqlite3.READ = 20
sqlite3.SELECT = 21
sqlite3.TRANSACTION = 22
sqlite3.UPDATE = 23
sqlite3.ATTACH = 24
sqlite3.DETACH = 25
sqlite3.ALTER_TABLE = 26
sqlite3.REINDEX = 27
sqlite3.ANALYZE = 28
sqlite3.CREATE_VTABLE = 29
sqlite3.DROP_VTABLE = 30
sqlite3.FUNCTION = 31
sqlite3.SAVEPOINT = 32

--- Open Flags
sqlite3.OPEN_READONLY = 0x00000001
sqlite3.OPEN_READWRITE = 0x00000002
sqlite3.OPEN_CREATE = 0x00000004
sqlite3.OPEN_URI = 0x00000040
sqlite3.OPEN_MEMORY = 0x00000080
sqlite3.OPEN_NOMUTEX = 0x00008000
sqlite3.OPEN_FULLMUTEX = 0x00010000
sqlite3.OPEN_SHAREDCACHE = 0x00020000
sqlite3.OPEN_PRIVATECACHE = 0x00040000


--- Checks if an SQL statement is complete.
--- @param statement string The SQL statement to check.
--- @return boolean complete Returns true if the statement is complete.
function sqlite3.complete(statement) end

--- Returns the Lua-SQLite3 library version as a string.
--- @return string version The version of the Lua-SQLite3 library.
function sqlite3.lversion() end

--- Opens a connection to an SQLite database.
--- @param filename string The filename of the SQLite database.
--- @return sqlite3_db|nil db The database connection object or nil on failure.
--- @return string|nil errmsg Error message if opening the database failed.
function sqlite3.open(filename) end

--- Opens an in-memory SQLite database.
--- @return sqlite3_db|nil db The in-memory database connection object or nil on failure.
--- @return string|nil errmsg Error message if opening the database failed.
function sqlite3.open_memory() end

--- Opens an SQLite database with an external pointer.
--- @param ptr userdata A pointer to an external SQLite database.
--- @return sqlite3_db|nil db The database connection object or nil on failure.
function sqlite3.open_ptr(ptr) end

--- Initializes a backup from one database to another.
--- @param destDB sqlite3_db The destination database connection.
--- @param destName string The name of the destination database.
--- @param srcDB sqlite3_db The source database connection.
--- @param srcName string The name of the source database.
--- @return sqlite3_backup|nil backup The backup object or nil on failure.
function sqlite3.backup_init(destDB, destName, srcDB, srcName) end

--- Sets or gets the temporary directory for SQLite operations.
--- @param path string|nil The path to set as the temporary directory (optional).
--- @return string|nil currentPath The current temporary directory path if no argument is provided.
function sqlite3.temp_directory(path) end

--- Returns the SQLite version as a string.
--- @return string version The version of SQLite being used.
function sqlite3.version() end


--- Sets a busy handler function that will be invoked when the database is busy.
--- @param callback function The function to call when the database is busy.
function sqlite3.db:busy_handler(callback) end

--- Sets a busy timeout for the database in milliseconds.
--- @param ms number The timeout duration in milliseconds.
function sqlite3.db:busy_timeout(ms) end

--- Returns the number of rows changed by the last executed statement.
--- @return number 'The number of rows changed.'
function sqlite3.db:changes() end

--- Closes the database connection.
--- @return boolean success Returns true if closed successfully.
function sqlite3.db:close() end

--- Closes the virtual machine used for executing statements.
--- @return boolean success Returns true if closed successfully.
function sqlite3.db:close_vm() end

--- Gets the raw pointer to the SQLite database.
--- @return userdata db A pointer to the database.
function sqlite3.db:get_ptr() end

--- Sets a commit hook that will be invoked whenever a transaction is committed.
--- @param callback function The function to call on commit.
function sqlite3.db:commit_hook(callback) end

--- Creates an aggregate function in the database.
--- @param name string The name of the aggregate function.
--- @param nargs number The number of arguments the function takes.
--- @param step function The function called for each row in the aggregate.
--- @param finalize function The function called to compute the final result.
function sqlite3.db:create_aggregate(name, nargs, step, finalize) end

--- Creates a collation function to define custom sorting.
--- @param name string The name of the collation.
--- @param callback function The function used to compare values.
function sqlite3.db:create_collation(name, callback) end

--- Creates a custom SQL function.
--- @param name string The name of the function.
--- @param nargs number The number of arguments the function takes.
--- @param callback function The function to call when the SQL function is executed.
function sqlite3.db:create_function(name, nargs, callback) end

--- Returns the last error code.
--- @return number 'The error code.'
function sqlite3.db:errcode() end

--- Returns the last error message.
--- @return string 'The error message.'
function sqlite3.db:errmsg() end

--- Executes a SQL statement.
--- @param sql string The SQL statement to execute.
--- @param callback function|nil Optional callback for processing rows.
--- @param args string|nil arguments to pass to callback
--- @return number 'The result code (e.g., sqlite3.OK, sqlite3.error).'
function sqlite3.db:exec(sql, callback, args) end

--- Interrupts the current database operation.
function sqlite3.db:interrupt() end

--- Returns the file name of the opened database.
--- @param db_name string The database name.
--- @return string The file name of the database.
function sqlite3.db:db_filename(db_name) end

--- Checks if the database connection is open.
--- @return boolean isOpen True if the database is open, false otherwise.
function sqlite3.db:isopen() end

--- Returns the row ID of the last inserted row.
--- @return number 'The row ID.'
function sqlite3.db:last_insert_rowid() end

--- Loads an SQLite extension.
--- @param path string The path to the extension.
--- @return number 'The result code.'
function sqlite3.db:load_extension(path) end

--- Returns the number of rows in the result of the last query.
--- @param sql string The SQL query.
--- @return number 'The number of rows.'
function sqlite3.db:nrows(sql) end

--- Prepares an SQL statement for execution.
--- @param sql string The SQL statement.
--- @return sqlite3_stmt 'A prepared statement object.'
function sqlite3.db:prepare(sql) end

--- Sets a progress handler that is called periodically during long-running queries.
--- @param n number The number of operations between calls.
--- @param callback function The function to call periodically.
function sqlite3.db:progress_handler(n, callback) end

--- Sets a rollback hook that will be invoked whenever a transaction is rolled back.
--- @param callback function The function to call on rollback.
function sqlite3.db:rollback_hook(callback) end

--- Executes an SQL statement and returns the rows as an iterator.
--- @param sql string The SQL statement.
--- @return function 'An iterator over the result rows.'
function sqlite3.db:rows(sql) end

--- Returns the total number of changes since the database was opened.
--- @return number 'The total number of changes.'
function sqlite3.db:total_changes() end

--- Sets a trace callback to monitor SQL statements.
--- @param callback function The function to call for each SQL statement executed.
function sqlite3.db:trace(callback) end

--- Sets an update hook that will be invoked whenever a row is updated, inserted, or deleted.
--- @param callback function The function to call on update.
function sqlite3.db:update_hook(callback) end

--- Executes an SQL statement and returns the rows as a Lua table.
--- @param sql string The SQL statement.
--- @return table 'A table of rows from the result set.'
function sqlite3.db:urows(sql) end



--- Binds a value to a parameter in the SQL statement.
--- @param index number The 1-based index of the parameter.
--- @param value any The value to bind.
--- @return boolean success True if binding was successful.
function sqlite3.stmt:bind(index, value) end

--- Binds binary data (blob) to a parameter in the SQL statement.
--- @param index number The 1-based index of the parameter.
--- @param blob string The blob data to bind.
--- @return boolean success True if binding was successful.
function sqlite3.stmt:bind_blob(index, blob) end

--- Binds multiple values by name.
--- @param values table<string, any> A table of key-value pairs, where keys are parameter names.
--- @return boolean success True if binding was successful.
function sqlite3.stmt:bind_names(values) end

--- Returns the number of parameters in the SQL statement.
--- @return number count The count of bindable parameters.
function sqlite3.stmt:bind_parameter_count() end

--- Returns the name of a parameter in the SQL statement by index.
--- @param index number The 1-based index of the parameter.
--- @return string|nil name The name of the parameter or nil if not found.
function sqlite3.stmt:bind_parameter_name(index) end

--- Binds multiple values in the order of parameters.
--- @param values table<number, any> A table of values indexed by position.
--- @return boolean success True if binding was successful.
function sqlite3.stmt:bind_values(values) end

--- Returns the number of columns in the result set.
--- @return number columns The number of columns.
function sqlite3.stmt:columns() end

--- Finalizes the SQL statement, releasing its resources.
--- @return boolean success True if finalization was successful.
function sqlite3.stmt:finalize() end

--- Gets the name of a column by index.
--- @param index number The 1-based index of the column.
--- @return string name The name of the column.
function sqlite3.stmt:get_name(index) end

--- Returns a table of named types for the columns.
--- @return table<number, string> types A table of column names mapped to their data types.
function sqlite3.stmt:get_named_types() end

--- Returns a table of named values for the current row.
--- @return table<string, any> values A table of column names mapped to their values.
function sqlite3.stmt:get_named_values() end

--- Returns a table of column names in the result set.
--- @return table<number, string> names A table of column names indexed by position.
function sqlite3.stmt:get_names() end

--- Gets the type of a column by index.
--- @param index number The 1-based index of the column.
--- @return string type The type of the column.
function sqlite3.stmt:get_type(index) end

--- Returns a table of types for all columns.
--- @return table<number, string> types A table of data types indexed by position.
function sqlite3.stmt:get_types() end

--- Returns a table of unique column names.
--- @return table<number, string> unames A table of unique column names.
function sqlite3.stmt:get_unames() end

--- Returns a table of unique column types.
--- @return table<number, string> utypes A table of unique data types.
function sqlite3.stmt:get_utypes() end

--- Returns a table of unique column values for the current row.
--- @return table<string, any> uvalues A table of unique column values.
function sqlite3.stmt:get_uvalues() end

--- Gets the value of a column by index for the current row.
--- @param index number The 1-based index of the column.
--- @return any value The value of the column.
function sqlite3.stmt:get_value(index) end

--- Returns a table of all column values for the current row.
--- @return table<number, any> values A table of values indexed by position.
function sqlite3.stmt:get_values() end

--- Checks if the statement is currently open.
--- @return boolean isOpen True if the statement is open, false otherwise.
function sqlite3.stmt:isopen() end

--- Returns the row ID of the last inserted row by the statement.
--- @return number rowid The row ID.
function sqlite3.stmt:last_insert_rowid() end

--- Returns the number of rows in the result set.
--- @return number rows The number of rows in the result set.
function sqlite3.stmt:nrows() end

--- Resets the statement to its initial state, allowing re-execution.
--- @return boolean success True if reset was successful.
function sqlite3.stmt:reset() end

--- Returns an iterator for the result rows of the statement.
--- @return function iterator An iterator over the rows.
function sqlite3.stmt:rows() end

--- Advances the statement to the next row in the result set.
--- @return number result The result code (e.g., sqlite3.ROW, sqlite3.DONE).
function sqlite3.stmt:step() end

--- Returns the rows in the result set as a table.
--- @return table rows The rows as a table.
function sqlite3.stmt:urows() end

--- Callback Context Class
--- @class Context
sqlite3.context = {}

--- Gets the current count of rows processed in the aggregate function.
--- @return number count The number of rows processed.
function sqlite3.context:aggregate_count() end

--- Retrieves the aggregate data stored for this context.
--- @return any data The aggregate data associated with the context.
function sqlite3.context:get_aggregate_data() end

--- Sets the aggregate data for this context.
--- @param data any The data to associate with the aggregate context.
function sqlite3.context:set_aggregate_data(data) end

--- Sets the result for the SQL function to the provided value.
--- @param result any The result to return.
function sqlite3.context:result(result) end

--- Sets the result for the SQL function to NULL.
function sqlite3.context:result_null() end

--- Sets the result for the SQL function to a number.
--- @param num number The numeric result to return.
function sqlite3.context:result_number(num) end

--- Sets the result for the SQL function to an integer.
--- @param int number The integer result to return.
function sqlite3.context:result_int(int) end

--- Sets the result for the SQL function to a text string.
--- @param text string The text result to return.
function sqlite3.context:result_text(text) end

--- Sets the result for the SQL function to a blob.
--- @param blob string The blob data to return.
function sqlite3.context:result_blob(blob) end

--- Sets an error message as the result for the SQL function.
--- @param errmsg string The error message to return.
function sqlite3.context:result_error(errmsg) end

--- Retrieves the user data associated with the function.
--- @return any user_data The user data passed when the function was created.
function sqlite3.context:user_data() end


--- Steps the backup process, moving a specified number of pages from source to destination.
--- @param num_pages number The number of pages to transfer in this step.
--- @return number result The result code (e.g., sqlite3.DONE, sqlite3.OK).
function sqlite3.backup:step(num_pages) end

--- Returns the number of pages remaining in the backup source database.
--- @return number remaining The number of remaining pages to copy.
function sqlite3.backup:remaining() end

--- Returns the total number of pages in the backup source database.
--- @return number pagecount The total number of pages.
function sqlite3.backup:pagecount() end

--- Finalizes the backup process and releases resources.
--- @return number result The result code (e.g., sqlite3.OK, sqlite3.error).
function sqlite3.backup:finish() end


return sqlite3
