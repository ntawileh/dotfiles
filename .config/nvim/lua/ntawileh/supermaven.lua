local M = {}
local suggestion = require("supermaven-nvim.completion_preview")

-- function M.toggle_supermaven_inline()
--     if suggestion.disable_inline_completion then
--         suggestion.disable_inline_completion = false
--         print("Supermaven inline completion ENABLED")
--     else
--         suggestion.disable_inline_completion = true
--         print("Supermaven inline completion DISABLED")
--     end
-- end
--
-- function M.register_ai_keymaps()
--     local wk = require("which-key")
--     wk.add({
--         { "<leader>a", group = "AI", icon = "󰚩" },
--         {
--             "<leader>ai",
--             "<cmd>lua require('ntawileh.supermaven').toggle_supermaven_inline()<cr>",
--             desc = "Enable AI inline completion",
--             icon = "",
--             cond = function()
--                 if suggestion.disable_inline_completion then
--                     return true
--                 else
--                     return false
--                 end
--             end,
--         },
--         {
--             "<leader>ai",
--             "<cmd>lua require('ntawileh.supermaven').toggle_supermaven_inline()<cr>",
--             desc = "Disable AI inline completion",
--             icon = "",
--             cond = function()
--                 if suggestion.disable_inline_completion then
--                     return false
--                 else
--                     return true
--                 end
--             end,
--         },
--     })
-- end
--
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
