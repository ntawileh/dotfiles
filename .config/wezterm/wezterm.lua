--
-- ██╗    ██╗███████╗███████╗████████╗███████╗██████╗ ███╗   ███╗
-- ██║    ██║██╔════╝╚══███╔╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
-- ██║ █╗ ██║█████╗    ███╔╝    ██║   █████╗  ██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝   ███╔╝     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗███████╗   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
-- A GPU-accelerated cross-platform terminal emulator
-- https://wezfurlong.org/wezterm/

local b = require("utils/background")
local cs = require("utils/color_scheme")
local f = require("utils/font")
local h = require("utils/helpers")
local k = require("utils/keys")
local w = require("utils/wallpaper")

local wezterm = require("wezterm")
local act = wezterm.action
local wallpapers_glob = os.getenv("HOME") .. "/Pictures/wallpapers/**"

local config = {
    background = {
        w.get_wallpaper(wallpapers_glob),
        b.get_background(0.8, 0.8),
    },
    max_fps = 120,

    default_prog = { "/usr/local/bin/fish", "-l" },

    font_size = 20,

    line_height = 1.1,
    font = f.get_font({
        -- "CommitMono",
        -- "JetBrains Mono",
        -- "Monaspace Argon",
        -- "Monaspace Krypton",
        "Monaspace Neon",
        -- "Monaspace Radon",
        -- "Monaspace Xenon",
    }),
    harfbuzz_features = { "calt", "dlig", "clig=1", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },

    color_scheme = cs.get_color_scheme(),

    window_padding = {
        left = 30,
        right = 30,
        top = 20,
        bottom = 10,
    },

    set_environment_variables = {
        -- THEME_FLAVOUR = "latte",
        BAT_THEME = h.is_dark() and "Catppuccin-mocha" or "Catppuccin-latte",
        TERM = "xterm-256color",
        LC_ALL = "en_US.UTF-8",
    },

    -- general options
    adjust_window_size_when_changing_font_size = false,
    debug_key_events = false,
    enable_tab_bar = false,
    native_macos_fullscreen_mode = false,
    window_close_confirmation = "NeverPrompt",
    window_decorations = "RESIZE",

    -- keys
    keys = {
        k.cmd_to_tmux_prefix("[", "j"),
        k.cmd_to_tmux_prefix("]", "k"),
        k.cmd_to_tmux_prefix("1", "1"),
        k.cmd_to_tmux_prefix("2", "2"),
        k.cmd_to_tmux_prefix("3", "3"),
        k.cmd_to_tmux_prefix("4", "4"),
        k.cmd_to_tmux_prefix("5", "5"),
        k.cmd_to_tmux_prefix("6", "6"),
        k.cmd_to_tmux_prefix("7", "7"),
        k.cmd_to_tmux_prefix("8", "8"),
        k.cmd_to_tmux_prefix("9", "9"),
        k.cmd_to_tmux_prefix("`", "n"),
        k.cmd_to_tmux_prefix("b", "B"),
        k.cmd_to_tmux_prefix("C", "C"),
        k.cmd_to_tmux_prefix("d", "D"),
        k.cmd_to_tmux_prefix("G", "G"),
        k.cmd_to_tmux_prefix("g", "g"),
        k.cmd_to_tmux_prefix("K", "T"),
        k.cmd_to_tmux_prefix("k", "s"),
        k.cmd_to_tmux_prefix("l", "L"),
        k.cmd_to_tmux_prefix("j", "T"),
        k.cmd_to_tmux_prefix("p", "P"),
        k.cmd_to_tmux_prefix("n", "-"),
        k.cmd_to_tmux_prefix("N", "|"),
        k.cmd_to_tmux_prefix("u", "u"),
        k.cmd_to_tmux_prefix("t", "c"),
        k.cmd_to_tmux_prefix("w", "x"),
        k.cmd_to_tmux_prefix(",", ","),
        k.cmd_to_tmux_prefix(";", ":"),

        k.cmd_key(
            "s",
            act.Multiple({
                act.SendKey({ key = "\x1b" }), -- escape
                k.multiple_actions(":w"),
            })
        ),

        k.cmd_key(
            ".",
            act.Multiple({
                act.SendKey({ key = "\x1b" }), -- escape
                act.SendKey({ key = "\x20" }), -- escape
                k.multiple_actions("ca"),
            })
        ),
    },
}

wezterm.on("user-var-changed", function(window, pane, name, value)
    -- local appearance = window:get_appearance()
    -- local is_dark = appearance:find("Dark")
    local overrides = window:get_config_overrides() or {}
    wezterm.log_info("name", name)
    wezterm.log_info("value", value)

    if name == "T_SESSION" then
        local session = value
        wezterm.log_info("is session", session)
        overrides.background = {
            w.set_tmux_session_wallpaper(value),
            b.get_background(0.8, 0.8),
        }
    end

    if name == "WALLPAPER_FOLDER" then
        local folder = value
        wezterm.log_info("wallpaper folder ", folder)
        if folder == "" then
            overrides.background = nil
        else
            overrides.background = {
                w.set_wallpaper(value),
                b.get_background(0.8, 0.8),
            }
        end
    end

    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while number_value > 0 do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
        else
            overrides.font_size = number_value
        end
    end
    if name == "DIFF_VIEW" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while number_value > 0 do
                window:perform_action(wezterm.action.DecreaseFontSize, pane)
                number_value = number_value - 1
            end
        -- overrides.background = {
        -- 	w.set_nvim_wallpaper("Diffview.jpeg"),
        --
        -- 	{
        -- 		source = {
        -- 			Gradient = {
        -- 				colors = { "#000000" },
        -- 			},
        -- 		},
        -- 		width = "100%",
        -- 		height = "100%",
        -- 		opacity = 0.95,
        -- 	},
        -- }
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.background = nil
            overrides.font_size = nil
        else
            overrides.font_size = number_value
        end
    end
    window:set_config_overrides(overrides)
end)

return config
