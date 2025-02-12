local M = {}
local suggestion = require("supermaven-nvim.completion_preview")

function M.register_ai_keymaps()
    Snacks.toggle({
        name = "AI inline completion",
        get = function()
            return not suggestion.disable_inline_completion
        end,
        set = function(state)
            if state then
                suggestion.disable_inline_completion = false
            else
                suggestion.disable_inline_completion = true
            end
        end,
    }):map("<leader>ai")
end
return M
