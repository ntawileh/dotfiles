return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            modes = {
                search = {
                    enabled = false,
                },
                char = {
                    jump_labels = true,
                },
            },
        },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
    },
    {
        "nvim-mini/mini.hipatterns",
        event = "BufReadPre",
        opts = {
            highlighters = {
                hsl_color = {
                    pattern = "hsl%(%d+,?%s*%d+%%?,?%s*%d+%%?%)",
                    group = function(_, match)
                        local utils = require("ntawileh.hsl")
                        --- @type string, string, string
                        local nh, ns, nl = match:match("hsl%((%d+),?%s*(%d+)%%?,?%s*(%d+)%%?%)")
                        --- @type number?, number?, number?
                        local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
                        --- @type string
                        local hex_color = utils.HSL_to_Hex(h, s, l)
                        return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
                    end,
                },
            },
        },
    },
}
