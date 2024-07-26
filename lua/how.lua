local how = {}
local commands = require("commands")

local function ensure_dependencies()
    local handle = io.popen("luarocks list dkjson")
    local result;
    if handle == nil then
        return
    else
        result = handle:read("*a")
        handle:close()
    end

    if not result:find("dkjson") then
        print("dkjson not found. Installing...")
        os.execute("luarocks install dkjson")
    end
end

function how.setup()
    
    ensure_dependencies()
    commands()
end

return how
