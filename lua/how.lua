----- Open the file in write mode
local file = io.open("log.log", "w")

-- Check if the file was successfully opened
if file then
    -- Write a string to the file
    file:write("This is a log message.\n")

    -- Close the file
    file:close()

    print("Log message written to log.log")
else
    print("Error opening file log.log")
end
---@class How
local How = {}

How.__index = How



local the_How = How

---@param self How
---@return How
function How.setup(self)
    if self ~= the_How then
        ---@diagnostic disable-next-line: cast-local-type
        self = the_How
    end

    vim.api.nvim_create_user_command("How",
         function(cmd)
            vim.echo("how")
            return {    desc = "Echoes the word 'how' to the command bar"}
        end
    )


    return self
end

return the_How
