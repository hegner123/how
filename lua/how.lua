-- lua/tips.lua
--
---@class How
---@field config setupHow
local How = {}

How.__index = How



local the_How = How:new()

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
