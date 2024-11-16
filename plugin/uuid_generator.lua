-- ~/.config/nvim/lua/uuid_generator.lua
local M = {}

-- Function to generate a UUID
function M.generate_uuid()
    local random = math.random
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    local uuid = string.gsub(template, "[xy]", function(c)
        local v = (c == "x") and random(0, 15) or random(8, 11)
        return string.format("%x", v)
    end)

    -- Copy UUID to the clipboard
    vim.fn.setreg("+", uuid)
    vim.fn.setreg('"', uuid) -- Set default register for pasting

    -- Notify the user
    print("UUID copied to clipboard: " .. uuid)
end

-- Define the :Uuid command
vim.api.nvim_create_user_command(
    "uuid",
    function() M.generate_uuid() end,
    { desc = "Generate a UUID and copy it to the clipboard" }
)

return M
