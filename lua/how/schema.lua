local schema = {}

schema.term = ""
schema.keywords = ""
schema.frequency = 0
schema.definition = ""
local schemaTable = [=[
CREATE TABLE IF NOT EXISTS definitions (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    term TEXT NOT NULL UNIQUE,
    keywords TEXT NOT NULL,
    frequency INTEGER DEFAULT 0,
    definition TEXT NOT NULL
);

INSERT INTO definitions (term, keywords, frequency, definition) VALUES
('replace', 'find and replace', 0, ':s@search@replace@g5');
]=]

schema.table = schemaTable

return schema
